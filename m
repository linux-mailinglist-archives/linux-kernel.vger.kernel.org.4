Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F56610A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ1GGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ1GGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:06:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD91905FA;
        Thu, 27 Oct 2022 23:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC57FB827D5;
        Fri, 28 Oct 2022 06:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC548C433C1;
        Fri, 28 Oct 2022 06:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666937170;
        bh=P/skQmDFlxUGT/JrFGFyc1uOd/GDc3c8F0PKdj3yR14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KORVJYlSUzHCjf21S5JCPuZ/G/LLquDopKjG5pMXz8EQUsVmkIQMpUFeG9z/Gr/v7
         rJNPDzYK0ro0QohQZYwYC7+R+DjVdGTAeDzukQSTGDXyg3gvesuPtYHVm7xkbljR9/
         /j8tuqdbOosyadr7AVXVNTM8Ic5SJLbu1xxQgXC8=
Date:   Fri, 28 Oct 2022 08:07:03 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Petlozu Pravareshwar <petlozup@nvidia.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jui Chang Kuo <jckuo@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] xhci: tegra: USB2 pad power controls
Message-ID: <Y1txh6keM4AQJDB3@kroah.com>
References: <20221027133127.27592-1-jilin@nvidia.com>
 <20221027133127.27592-4-jilin@nvidia.com>
 <Y1qO8cN4+kJVk2f5@kroah.com>
 <2e26a4a16122ca9129f02e03600b088f3effae47.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e26a4a16122ca9129f02e03600b088f3effae47.camel@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 03:11:31AM +0000, Jim Lin wrote:
> On Thu, 2022-10-27 at 16:00 +0200, Greg KH wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Oct 27, 2022 at 09:31:27PM +0800, Jim Lin wrote:
> > > Program USB2 pad PD controls during port connect/disconnect, port
> > > suspend/resume, and test mode, to reduce power consumption on
> > > disconnect or suspend.
> > > 
> > > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > > Signed-off-by: JC Kuo <jckuo@nvidia.com>
> > > Signed-off-by: Jim Lin <jilin@nvidia.com>
> > 
> > Who is the author here?  These do not seem to be in the correct order
> > if
> > you are the author, right?
> > > This is an old patch. Each time went with some small modification.
> 
> 
> Petlozu is author for local Kernel 3.18
> 
> Then JC for local Kernel 4.4
> Now my turn for Kernel 5.xx

Then you all need to figure out how to proper document this (hint, read
the documentation for how to do that...)

> > > ---
> > > v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
> > > v3: No change on copyright
> > > v4: Remove hcd_to_tegra_xusb() function which is used only once.
> > > v5: Update .hub_control in tegra_xhci_overrides (xhci-tegra.c)
> > >     Invoke xhci_hub_control() directly (xhci-tegra.c)
> > > 
> > >  drivers/usb/host/xhci-tegra.c | 131
> > > +++++++++++++++++++++++++++++++++-
> > >  1 file changed, 130 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-
> > > tegra.c
> > > index c8af2cd2216d..f685bb7459ba 100644
> > > --- a/drivers/usb/host/xhci-tegra.c
> > > +++ b/drivers/usb/host/xhci-tegra.c
> > > @@ -189,6 +189,13 @@ struct tegra_xusb_context_soc {
> > >       } fpci;
> > >  };
> > > 
> > > +enum tegra_xhci_phy_type {
> > > +     USB3_PHY,
> > > +     USB2_PHY,
> > > +     HSIC_PHY,
> > > +     MAX_PHY_TYPES,
> > > +};
> > > +
> > >  struct tegra_xusb_soc {
> > >       const char *firmware;
> > >       const char * const *supply_names;
> > > @@ -274,6 +281,7 @@ struct tegra_xusb {
> > > 
> > >       bool suspended;
> > >       struct tegra_xusb_context context;
> > > +     u32 enable_utmi_pad_after_lp0_exit;
> > 
> > This is a bitfield, how do we know it will fit in a u32?  What is the
> > range you are putting in here?
> > 
> > thanks,
> > 
> > greg k-h
> static void tegra_xhci_program_utmi_power_lp0_exit(struct tegra_xusb
> *tegra)
> {
> 	unsigned int i;
> 
> 	for (i = 0; i < tegra->soc->phy_types[USB2_PHY].num; i++) {
> 		if (!is_host_mode_phy(tegra, USB2_PHY, i))
> 			continue;
> 		/* USB2 */
> 		if (tegra->enable_utmi_pad_after_lp0_exit & BIT(i))
> :
> How many bits to be used is based on tegra->soc-
> >phy_types[USB2_PHY].num which is defined like
> 
> static const struct tegra_xusb_phy_type tegra210_phy_types[] = {
> :
> 	{ .name = "usb2", .num = 4, },
> :
> };
> 
> static const struct tegra_xusb_phy_type tegra194_phy_types[] = {
> :
> 	{ .name = "usb2", .num = 4, },
> };
> , so far at most 4.
> 
> Therefore u8 for enable_utmi_pad_after_lp0_exit is long enough.

I am sorry, I do not understand.  If you are needing to treat this as a
bitfield, then properly define it that way so it is obvious what is
happening.

As it is, this is very confusing and I do not understand what is going
on at all.  What is the relationship to "num" and the bit being set?
Why set a bit at all?

thanks,

greg k-h
