Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB55169E560
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjBURBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjBURA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:00:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9B422B;
        Tue, 21 Feb 2023 09:00:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2B73DCE1B17;
        Tue, 21 Feb 2023 16:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C72C4339B;
        Tue, 21 Feb 2023 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676998788;
        bh=qnPzBu5Kq1bG0VJWxrFm9hT2MssTj7tUkyGFHcTRlks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04O5oeWJu8E2T4t6WAWZ6yClkJcQGDSp/jeKJphrAhMACn8zCQgmNpkC71CPSrJP8
         wMj34MKshTod9h5u5IYw1T3zGxzVDMGm0fcST78n7qNTr/EXOHLFXvw46k/k9U3JeU
         Gh/LyBCbHv3FuFwdZ/KLVN7Tj7kZK5MT/SS0HQ6Y=
Date:   Tue, 21 Feb 2023 17:59:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Haotien Hsu <haotienh@nvidia.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Wayne Chang <waynec@nvidia.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ucsi_ccg: Refine the UCSI Interrupt handling
Message-ID: <Y/T4gew0bBaCSZjz@kroah.com>
References: <20230118061523.1537992-1-haotienh@nvidia.com>
 <Y8k3XB53iHeE0XZF@kroah.com>
 <40a2a0f3-a396-2a13-b7ce-514015ae3bab@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a2a0f3-a396-2a13-b7ce-514015ae3bab@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 04:40:24PM +0000, Jon Hunter wrote:
> Hi Greg,
> 
> On 19/01/2023 12:28, Greg Kroah-Hartman wrote:
> > On Wed, Jan 18, 2023 at 02:15:23PM +0800, Haotien Hsu wrote:
> > > From: Sing-Han Chen <singhanc@nvidia.com>
> > > 
> > > For the CCGx, when the OPM field in the INTR_REG is cleared, then the
> > > CCI data in the PPM is reset.
> > > 
> > > To align with the CCGx UCSI interface guide, this patch updates the
> > > driver to copy CCI and MESSAGE_IN before clearing UCSI interrupt.
> > > When a new command is sent, the driver will clear the old CCI and
> > > MESSAGE_IN copy.
> > > 
> > > Finally, clear UCSI_READ_INT before calling complete() to ensure that
> > > the ucsi_ccg_sync_write() would wait for the interrupt handling to
> > > complete.
> > > It prevents the driver from resetting CCI prematurely.
> > > 
> > > Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> > > Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> > > ---
> > > V1->V2
> > > - Fix uninitialized symbol 'cci'
> > > v2->v3
> > > - Remove misusing Reported-by tags
> > > v3->v4
> > > - Add comments for op_lock
> > > ---
> > >   drivers/usb/typec/ucsi/ucsi_ccg.c | 90 ++++++++++++++++++++++++++++---
> > >   1 file changed, 83 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> > > index eab3012e1b01..532813a32cc1 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> > > @@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
> > >   	bool checked;
> > >   } __packed;
> > > +#define CCGX_MESSAGE_IN_MAX 4
> > > +struct op_region {
> > > +	u32 cci;
> > 
> > This is coming from hardware so you have to specify the endian-ness of
> > it, right?
> 
> The current driver reads the 'cci' state in the ccg_irq_handler and here we
> just pass a variable of type u32 for storing the state. We are just adding
> variable of the same type to save the state. This value is returned to the
> ucsi layer which does not specify the endian-ness either. I guess this
> driver like many assume little endian. What is the guidance here? Should we
> be adding __le32 here even if the upper layers don't?

Yes, set what you are reading from the hardware, and then do the proper
transformation to the cpu native types for the upper layers where
needed.

> > Or why even clean this out at all, what happens if you do not?
> 
> 
> I have been taking a look at this. If we don't clean the variable and
> buffer, then the previous state could be incorrectly read again after the
> next command has been sent.
> 
> Without this fix we occasionally see timeout errors such as ...
> 
>    ucsi_ccg 2-0008: error -ETIMEDOUT: PPM init failed (-110)
> 
> 
> I tried not doing this at all, but then we see these timeout issues are
> still seen.

Then that means someone is not properly handling errors, and assuming
that whatever data is in the buffer is correct?  Try fixing that bug :)

See my other comments about not handling errors, perhaps that is where
the problem is.

thanks,

greg k-h
