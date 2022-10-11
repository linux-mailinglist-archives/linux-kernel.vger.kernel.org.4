Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23A5FB093
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJKKk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJKKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:40:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FEB07D7B1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:40:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13F761042;
        Tue, 11 Oct 2022 03:40:57 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8F33F766;
        Tue, 11 Oct 2022 03:40:49 -0700 (PDT)
Date:   Tue, 11 Oct 2022 11:40:47 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, quic_rgottimu@quicinc.com
Subject: Re: Query regarding "firmware: arm_scmi: Free mailbox channels if
 probe fails"
Message-ID: <Y0VILyEaNOQiTpO5@e120937-lin>
References: <cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com>
 <Yyx3IAcMX309QEjB@e120937-lin>
 <Yyx/DKcc7XupQmnx@e120937-lin>
 <c81540cc-e485-0c45-9e4e-248d3279e1ea@quicinc.com>
 <YzriGCLf+MFNGO2n@e120937-lin>
 <b1de7e87-9590-3aad-d62b-167a7685746a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1de7e87-9590-3aad-d62b-167a7685746a@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:34:45PM +0530, Shivnandan Kumar wrote:
> 
> Hi Cristian,
> 

Hi Shivnandan,

> >>Ok, just out of curiosity, once done, can you point me at your downstream
> public sources so I can see the issue and the fix that you are applying to
> your trees ?
> 
> https://source.codeaurora.org/quic/la/kernel/msm-5.10/tree/drivers/soc/qcom/qcom_rimps.c?h=KERNEL.PLATFORM.1.0.r1-07800-kernel.0
> 
> I have added lock while accessing con_priv inside irq handler and shutdown
> function.
> 

Thanks !

> 
> I have one input regarding timeout from firmware, can we enable BUG on
> response  time out in function do_xfer based on some debug config flag,this
> will help to debug firmware timeout issue faster.
> 
> We will only enable that config flag during internal testing.
> 

I understand a sort of 'Panic-on-timeout' would be useful to just freeze
the system as it is and debug, but it seems to me pretty much invasive
(and generally frowned upon) to BUG_ON timeouts, given on some SCMI
platforms/transports a few timeouts can happen really not so infrequently
due to transient conditions during moments of peak SCMI traffic.

Even though you mention to make it conditional to Kconfig, I'm not sure
this could fly, especially if you want to enable only for internal
testing...I'll ping Sudeep about this to see what he thinks.

As an alternative, what if I try to improve SCMI tracing/debug, let's say
dumping more info in dmesg about the offending (timed-out) message instead
of hanging the system as a whole ?

I'd have also some still-brewing-and-not-published patches to add some
SCMI stats somewhere in sysfs to be able to read current SCMI errors/timeouts
and transport anomalies, would that be of interest ?

...maybe, we could combine some of these stats and some sort of
BUG_ON/WARN_ON (if it will fly eventually..) into some kind SCMI_DEBUG mode
...any input on your needs about which kind of SCMI info you'll like to see
exposed by the stack would be welcome.

Last but not least, since we are talking about SCMI Server/FW testing,
have you (or your team) seen this work-in-progress of mine:

https://lore.kernel.org/linux-arm-kernel/20220903183042.3913053-1-cristian.marussi@arm.com/

about a new unified userspace interface to inject/snoop SCMI messages to
test/fuzz/stress the SCMI server wherever it is placed ?

Any feedback on the API proprosed in the cover-letter would be highly welcome;
I'll post a new V4 next week possibly, and the changes to the existing ARM SCMI
Compliance suite (mentioned in the cover) to support this new SCMI Raw
mode are in their final stage too.

Thanks,
Cristian
