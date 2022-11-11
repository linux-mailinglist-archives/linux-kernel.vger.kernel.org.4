Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0916625307
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 06:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiKKFRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 00:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiKKFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:17:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26E6B383;
        Thu, 10 Nov 2022 21:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0CDDB81E60;
        Fri, 11 Nov 2022 05:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC44C433C1;
        Fri, 11 Nov 2022 05:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668143849;
        bh=n+aNotBQFKuFcOYsREI/VGTiSdZhVRAVtpMX5N+QlU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xf3V/jkVqHQegrpSr0Xg4J7SVOGlmG0XblfaVvPyDP45FLlyTZlCRO4vCl4QWZzcc
         KKkXVtDO8r9wBZIAoHXZiN9YxB9mJu5l6bQyAZcirrnsx6zfZ+j3CvlqW06ByoC/kJ
         meBkKTi41p+cihQnTdk+LqnIXY74RpXEQLORj15YvivVG9y89svujZS8WVbZcK1BmM
         2HC1GJTgRINZEq11uLJHAfPUfTSA2/t9Keyy4LXBr22uSnfqwCsC62kzhUyAtMQUat
         WnkumBt55C1euGOi9hGaXrmzF0h2Uw3Hd8AQSA+Y9X9v9njwJeZYWGUQCOHNu2RKMB
         EM7JFrWdlq3Qw==
Date:   Fri, 11 Nov 2022 13:17:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH] ARM: dts: colibri-imx6ull: Enable dual-role switching
Message-ID: <20221111051721.GD2649582@dragon>
References: <20221102155226.51587-1-dev@pschenker.ch>
 <4964263.31r3eYUQgx@steina-w>
 <Y2N2JYGvmzLjpGUq@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2N2JYGvmzLjpGUq@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 09:04:53AM +0100, Francesco Dolcini wrote:
> On Thu, Nov 03, 2022 at 08:46:58AM +0100, Alexander Stein wrote:
> > Hi Philippe,
> > 
> > Am Mittwoch, 2. November 2022, 16:52:26 CET schrieb Philippe Schenker:
> > > From: Philippe Schenker <philippe.schenker@toradex.com>
> > > 
> > > The Colibri standard provides a GPIO called USBC_DET to switch from
> > > USB Host to USB Device and back. The Colibri iMX6ULL does have the SoC
> > > ball USB_OTG1_VBUS connected in series with a capacitor to ground.
> > > 
> > > This means that we need to provide to the extcon framework VBUS and ID
> > > events using the single GPIO we have. The Extcon USB GPIO driver does
> > > use id-gpio also for VBUS event, as in our case where vbus-gpio is
> > > absent.
> > > 
> > > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > > 
> > > ---
> > > 
> > >  arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > > b/arch/arm/boot/dts/imx6ull-colibri.dtsi index 577a424b0e1d..feb1fcd9a684
> > > 100644
> > > --- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > > +++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > > @@ -24,6 +24,13 @@ backlight: backlight {
> > >  		status = "okay";
> > >  	};
> > > 
> > > +	extcon_usbc_det: usbc-det {
> > > +		compatible = "linux,extcon-usb-gpio";
> > > +		id-gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>; /* SODIMM 137 / 
> > USBC_DET */
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_snvs_usbc_det>;
> > > +	};
> > > +
> > >  	gpio-keys {
> > >  		compatible = "gpio-keys";
> > >  		pinctrl-names = "default";
> > > @@ -275,6 +282,7 @@ &uart5 {
> > >  /* Colibri USBC */
> > >  &usbotg1 {
> > >  	dr_mode = "otg";
> > > +	extcon = <&extcon_usbc_det>, <&extcon_usbc_det>;
> > 
> > How came you up with this double entries? Is there some documentation you need 
> > two phandles?
> 
> extcon-usb-gpio provides both vbus/otg_id with a single handle, however
> the integration in chipidea is somehow weird, the first entry is supposed to be
> used to read the vbus, the second one to read the otg_id.
> 
> So if you need to read both you really need to have the handle twice ...

Thanks for the input, Francesco!

Philippe,

Do you consider to use usb-role-switch as suggested by Alexander,
considering the weirdness of how chipidea driver supports extcon-usb-gpio?

Shawn
