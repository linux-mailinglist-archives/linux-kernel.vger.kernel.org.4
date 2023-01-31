Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EDE6824CA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjAaGrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjAaGrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:47:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F43DBC8;
        Mon, 30 Jan 2023 22:46:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A038B819A4;
        Tue, 31 Jan 2023 06:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3D1C4339C;
        Tue, 31 Jan 2023 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675147261;
        bh=1Ktw8fRx3L9lsDLoEZlYAA2XenxlZJqftC4YCLC29nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2nxZzCgnPYPKqIKINTpUSpK3N6jKEGvefto19ofjDD9/2LNFxCM1WA054yWoJSD0A
         q7FdaX96ku87QoH5UjCRaqdTc9zSzEQjB12sBIC1Og7XmNx3y1YBbObRZ/LjPei54L
         d5/37ZFsPMWF7rq0gdKpRnpHyHSytpEf5Bp2N/gc=
Date:   Tue, 31 Jan 2023 07:40:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Wayne Chang <waynec@nvidia.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] ucsi_ccg: Refine the UCSI Interrupt handling
Message-ID: <Y9i3+sMs+wI6AhqG@kroah.com>
References: <20230118061523.1537992-1-haotienh@nvidia.com>
 <Y8k3XB53iHeE0XZF@kroah.com>
 <b590cb4e-1814-4253-9f87-2f945b99452d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b590cb4e-1814-4253-9f87-2f945b99452d@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 06:29:59AM +0000, Haotien Hsu wrote:
> On 1/19/23 20:28, Greg Kroah-Hartman wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jan 18, 2023 at 02:15:23PM +0800, Haotien Hsu wrote:
> >> From: Sing-Han Chen <singhanc@nvidia.com>
> >>
> >> For the CCGx, when the OPM field in the INTR_REG is cleared, then the
> >> CCI data in the PPM is reset.
> >>
> >> To align with the CCGx UCSI interface guide, this patch updates the
> >> driver to copy CCI and MESSAGE_IN before clearing UCSI interrupt.
> >> When a new command is sent, the driver will clear the old CCI and
> >> MESSAGE_IN copy.
> >>
> >> Finally, clear UCSI_READ_INT before calling complete() to ensure that
> >> the ucsi_ccg_sync_write() would wait for the interrupt handling to
> >> complete.
> >> It prevents the driver from resetting CCI prematurely.
> >>
> >> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> >> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> >> ---
> >> V1->V2
> >> - Fix uninitialized symbol 'cci'
> >> v2->v3
> >> - Remove misusing Reported-by tags
> >> v3->v4
> >> - Add comments for op_lock
> >> ---
> >>   drivers/usb/typec/ucsi/ucsi_ccg.c | 90 ++++++++++++++++++++++++++++---
> >>   1 file changed, 83 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> index eab3012e1b01..532813a32cc1 100644
> >> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> >> @@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
> >>        bool checked;
> >>   } __packed;
> >>
> >> +#define CCGX_MESSAGE_IN_MAX 4
> >> +struct op_region {
> >> +     u32 cci;
> > 
> > This is coming from hardware so you have to specify the endian-ness of
> > it, right?
> 
> 
> Yes.
> According to CCGX's guide, CCI and MESSAGE_IN are accessed as registers.

So please specify the endianness of the registers.

> >> +static void ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
> >> +{
> >> +     u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
> >> +     struct op_region *data = &uc->op_data;
> >> +     u32 message_in[CCGX_MESSAGE_IN_MAX];
> > 
> > Are you sure you can put this big of a buffer on the stack?
> > 
> 
> 
> I assume 16 bytes are okay to put on the stack.
> Please let me know if you think this size is not practical to put on the 
> stack.

Why do you want it on the stack?  Is it going to be used as DMA memory?
If so, it can NOT be on the stack.

> >> +
> >> +     if (UCSI_CCI_LENGTH(cci))
> >> +             if (ccg_read(uc, reg, (void *)&message_in,
> >> +                                     sizeof(message_in))) {
> > 
> > Are you allowed to copy in into stack memory?  This ends up being an i2c
> > message, right?  Can that be transferred into non-dma-able memory?
> > 
> 
> 
> Yes, it works.

How was this tested?  On a system that requires i2c messages to be in
DMA?

> >> +                     return;
> >> +             }
> >> +
> >> +     spin_lock(&uc->op_lock);
> >> +     memcpy(&data->cci, &cci, sizeof(cci));
> > 
> > Perhaps just:
> >          data->cci = cci;
> > as this is only a 32bit value.
> >
> 
> 
> True.
> >> +     if (UCSI_CCI_LENGTH(cci))
> >> +             memcpy(&data->message_in, &message_in, sizeof(message_in));
> >> +     spin_unlock(&uc->op_lock);
> >> +}
> >> +
> >> +static void ccg_op_region_clean(struct ucsi_ccg *uc)
> >> +{
> >> +     struct op_region *data = &uc->op_data;
> >> +
> >> +     spin_lock(&uc->op_lock);
> >> +     memset(&data->cci, 0, sizeof(data->cci));
> > 
> >          data->cci = 0;
> > 
> >> +     memset(&data->message_in, 0, sizeof(data->message_in));
> > 
> > Or better yet, do it all at once:
> >          memset(&data, 0, sizeof(*data));
> 
> 
> That looks better, thanks.
> 
> > 
> >> +     spin_unlock(&uc->op_lock);
> > 
> > But why do you need to do this at all?  Why "clean" the whole buffer
> > out, why not just set cci to 0 and be done with it?
> > 
> > Or why even clean this out at all, what happens if you do not?
> > 
> 
> 
> It only be called in ucsi_ccg_async_write(), and I will move it there as 
> inline.
> The reason to clean the whole op_data is that UCSI may read MESSAGE_IN 
> after writing UCSI_CONTROL, so clear it to avoid callers getting wrong data.

How could a caller get the wrong data?  It's what they asked for.  I'm
confused.

greg k-h
