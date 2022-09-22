Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F65E6639
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiIVOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIVOye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:54:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 766CFFC0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:54:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8DB91042;
        Thu, 22 Sep 2022 07:54:37 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 565713F73D;
        Thu, 22 Sep 2022 07:54:30 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:54:24 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, quic_rgottimu@quicinc.com,
        quic_avajid@quicinc.com
Subject: Re: Query regarding "firmware: arm_scmi: Free mailbox channels if
 probe fails"
Message-ID: <Yyx3IAcMX309QEjB@e120937-lin>
References: <cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:31:47AM +0530, Shivnandan Kumar wrote:
> Hi Christian,
> 

Hi Shivnandan,

> 
> Do you have any update or suggestion regarding thread https://lore.kernel.org/lkml/20211105094310.GI6526@e120937-lin/T/#m07993053f6f238864acad4e9bad9f08d85aeb019.
> 
> We are still getting this issue and wanted to check if  there is any fix
> that I can try.
> 

Sorry this issue fell to the bottom of my list in these past months...
... but it stil on TODO :D

So today I tried to get my head around this issue again (i.e. mainly
re-reading the above thread to remind me what was the status and wth I
had written... :P)

In summary the racy thing seemed to be caused by the a delayed late
SCMI Base reply happily served on one core by scmi_rx_callback operating
on some well-defined SCMI channel, while on another core we are effectively
shutting down the system and destroying such channels: now this should
be clearly NOT be possible and it is what we have to synchronize.

Looking at the transport layer that you use, mailbox, I see that while
setup/free helpers are synchronized on an internal chan->lock, the RX
path inside the mailbox core is not, so I tried this:


diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98..bb6173c0ad54 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -157,9 +157,13 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
  */
 void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
 {
+       unsigned long flags;
+
+       spin_lock_irqsave(&chan->lock, flags);
        /* No buffering the received data */
        if (chan->cl->rx_callback)
                chan->cl->rx_callback(chan->cl, mssg);
+       spin_unlock_irqrestore(&chan->lock, flags);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_received_data);
 

... can you try on your setup ? I dont have a way to easily reproduce
your race as of now...

NOTE THAT, I am not still convinced that the above fix, if it works, will
constitute the final solution to this issue, I could maybe move this same
kind of sync up into the SCMI transport layer to avoid to impact all other
users of the above mailbox interface (since, as of today, nobody has
reported any issue like ours due to the missing spinlock..)..but it
could be helpful to test the above to verify that this is really where
the root issue is.

Thanks,
Cristian
