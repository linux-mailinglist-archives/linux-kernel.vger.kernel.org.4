Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F94D5E670F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIVP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiIVP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:28:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46972F1D47
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:28:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D665139F;
        Thu, 22 Sep 2022 08:28:43 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05B013F73D;
        Thu, 22 Sep 2022 08:28:35 -0700 (PDT)
Date:   Thu, 22 Sep 2022 16:28:25 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, quic_rgottimu@quicinc.com,
        quic_avajid@quicinc.com
Subject: Re: Query regarding "firmware: arm_scmi: Free mailbox channels if
 probe fails"
Message-ID: <Yyx/DKcc7XupQmnx@e120937-lin>
References: <cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com>
 <Yyx3IAcMX309QEjB@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyx3IAcMX309QEjB@e120937-lin>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:54:31PM +0100, Cristian Marussi wrote:
> On Thu, Sep 22, 2022 at 10:31:47AM +0530, Shivnandan Kumar wrote:
> > Hi Christian,
> > 
> 

Hi Shivnandan,
 
[snip]

> Looking at the transport layer that you use, mailbox, I see that while
> setup/free helpers are synchronized on an internal chan->lock, the RX
> path inside the mailbox core is not, so I tried this:
> 
> 
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 4229b9b5da98..bb6173c0ad54 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -157,9 +157,13 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
>   */
>  void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&chan->lock, flags);
>         /* No buffering the received data */
>         if (chan->cl->rx_callback)
>                 chan->cl->rx_callback(chan->cl, mssg);
> +       spin_unlock_irqrestore(&chan->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(mbox_chan_received_data);
>  

...sorry... a small change on the tentative above fix...

----8<------

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98..6fbe183acdae 100644
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
-       if (chan->cl->rx_callback)
+       if (chan->cl && chan->cl->rx_callback)
                chan->cl->rx_callback(chan->cl, mssg);
+       spin_unlock_irqrestore(&chan->lock, flags);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_received_data);

------8<-----

Thanks,
Cristian

