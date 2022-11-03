Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666B6617880
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKCIQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:15:59 -0400
X-Greylist: delayed 617 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 01:15:55 PDT
Received: from smtp-out-01.comm2000.it (smtp-out-01.comm2000.it [212.97.32.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA45E14;
        Thu,  3 Nov 2022 01:15:55 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-01.comm2000.it (Postfix) with ESMTPSA id 70F61842C87;
        Thu,  3 Nov 2022 09:04:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1667462730;
        bh=yOfY9eB7qu7TqUunKx7AkuCRtrNlolkJbCg5vWbHkSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=1OFovVjhXynjTKz/QW5UZoWQeetj8oiaI3Qc1kqnpKvDr25wLL5QwyrCi35/fbQKD
         4+aJPG2bT56xfXOD/9Dof7Xb6ydNoQ4nkAY/HnnHbu/HRd5vdubBSX58iLor9IONTC
         aLc+/qmXD9PqlEqT6J7q56QpiG/uO4e3EWV3a0U4KTCKPyGnKCRUdCPjImeZmH6pJZ
         HSOGCq+5m6O7khYqTk5kXPWaO6tCJj1LMiuewHdzeFF6WleviNas6qdpte9GOBpH6+
         WOEk/0AKfpqVAmDDkLAv6FiqITLmeo8pbALt6YZYotqt/URIL/Xkcph4e/ZPupaga+
         zCsJaUxK7xn0A==
Date:   Thu, 3 Nov 2022 09:04:53 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH] ARM: dts: colibri-imx6ull: Enable dual-role switching
Message-ID: <Y2N2JYGvmzLjpGUq@francesco-nb.int.toradex.com>
References: <20221102155226.51587-1-dev@pschenker.ch>
 <4964263.31r3eYUQgx@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4964263.31r3eYUQgx@steina-w>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:46:58AM +0100, Alexander Stein wrote:
> Hi Philippe,
> 
> Am Mittwoch, 2. November 2022, 16:52:26 CET schrieb Philippe Schenker:
> > From: Philippe Schenker <philippe.schenker@toradex.com>
> > 
> > The Colibri standard provides a GPIO called USBC_DET to switch from
> > USB Host to USB Device and back. The Colibri iMX6ULL does have the SoC
> > ball USB_OTG1_VBUS connected in series with a capacitor to ground.
> > 
> > This means that we need to provide to the extcon framework VBUS and ID
> > events using the single GPIO we have. The Extcon USB GPIO driver does
> > use id-gpio also for VBUS event, as in our case where vbus-gpio is
> > absent.
> > 
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > 
> > ---
> > 
> >  arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > b/arch/arm/boot/dts/imx6ull-colibri.dtsi index 577a424b0e1d..feb1fcd9a684
> > 100644
> > --- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > +++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> > @@ -24,6 +24,13 @@ backlight: backlight {
> >  		status = "okay";
> >  	};
> > 
> > +	extcon_usbc_det: usbc-det {
> > +		compatible = "linux,extcon-usb-gpio";
> > +		id-gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>; /* SODIMM 137 / 
> USBC_DET */
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_snvs_usbc_det>;
> > +	};
> > +
> >  	gpio-keys {
> >  		compatible = "gpio-keys";
> >  		pinctrl-names = "default";
> > @@ -275,6 +282,7 @@ &uart5 {
> >  /* Colibri USBC */
> >  &usbotg1 {
> >  	dr_mode = "otg";
> > +	extcon = <&extcon_usbc_det>, <&extcon_usbc_det>;
> 
> How came you up with this double entries? Is there some documentation you need 
> two phandles?

extcon-usb-gpio provides both vbus/otg_id with a single handle, however
the integration in chipidea is somehow weird, the first entry is supposed to be
used to read the vbus, the second one to read the otg_id.

So if you need to read both you really need to have the handle twice ...

Francesco

