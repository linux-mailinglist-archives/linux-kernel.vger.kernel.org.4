Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD0764823D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLIMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLIMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:14:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744F51743C;
        Fri,  9 Dec 2022 04:14:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F272962245;
        Fri,  9 Dec 2022 12:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF02C433EF;
        Fri,  9 Dec 2022 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670588040;
        bh=qzpMtoWZNpsZQI9YGO/jGLlQ5OXpCbZNeUK0GWywa5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2pob/fUs86fazeBu6/pQnGCZkTQHedRqlm4MFJqhrvLuKUQHRxBlxjZaXJ0z7fIBm
         2z9ZPQDYzSoU+qKyKgXWPdvtKhELbnCjNuZM9d3ynI72MV/980V4y68c7OHbs6J4LV
         yX6P+XfBVFv76qXblKMCMYeD5JzaC2fsJIH1eU3I=
Date:   Fri, 9 Dec 2022 13:13:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        Minas Harutyunyan <hminas@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 3/3] usb: dwc2: prevent core phy initialisation
Message-ID: <Y5MmhEMMx2sy91LS@kroah.com>
References: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
 <20221206-dwc2-gadget-dual-role-v1-3-36515e1092cd@theobroma-systems.com>
 <Y5IIaeip81DIvEZ6@kroah.com>
 <69c0f9c0-5c89-e99e-c807-9963ca377093@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c0f9c0-5c89-e99e-c807-9963ca377093@theobroma-systems.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 12:15:34PM +0100, Quentin Schulz wrote:
> Hi Greg,
> 
> On 12/8/22 16:53, Greg Kroah-Hartman wrote:
> > On Wed, Dec 07, 2022 at 02:19:18PM +0100, Quentin Schulz wrote:
> > > From: Bin Yang <yangbin@rock-chips.com>
> > > 
> > > The usb phys need to be controlled dynamically on some Rockchip SoCs.
> > > So set the new HCD flag which prevents USB core from trying to manage
> > > our phys.
> > > 
> > > Signed-off-by: Bin Yang <yangbin@rock-chips.com>
> > > Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> > > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > ---
> > >   drivers/usb/dwc2/hcd.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> > > index 657f1f659ffaf..757a66fa32fa8 100644
> > > --- a/drivers/usb/dwc2/hcd.c
> > > +++ b/drivers/usb/dwc2/hcd.c
> > > @@ -5315,6 +5315,13 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
> > >   	if (!IS_ERR_OR_NULL(hsotg->uphy))
> > >   		otg_set_host(hsotg->uphy->otg, &hcd->self);
> > > +	/*
> > > +	 * do not manage the PHY state in the HCD core, instead let the driver
> > > +	 * handle this (for example if the PHY can only be turned on after a
> > > +	 * specific event)
> > > +	 */
> > > +	hcd->skip_phy_initialization = 1;
> > 
> > Wait, doesn't this mess with the phy logic for all other chips that use
> > this IP block?  Have you tested this on other systems?
> > 
> 
> I have not. I asked this in the cover-letter but I guess I should have made
> the patch series an RFC for this reason?

Ah, should I drop the first 2 in this series that I already applied?

> > I'd like some verification first before taking this change as it seems
> > very specific-platform.
> > 
> 
> There's already some platform-specific callbacks for the driver (see
> dwc2_set_rk_params in drivers/usb/dwc2/params.c) but this gets called too
> early, before hcd structure is actually allocated. So we either need to use
> some "proxy"/shadow variable in dwc2_core_params and then update it right
> after hcd gets allocated or have another platform-specific callback only for
> hcd (post-)initialization.
> 
> Nothing too fancy so shouldn't take too long to implement. Any preference?
> Something else?

Which ever you think would be simplest.

thanks,

greg k-h
