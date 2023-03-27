Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4936C9D96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjC0IWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjC0IWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:22:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB65255
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:22:18 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pgi7H-0000x3-5U; Mon, 27 Mar 2023 10:22:11 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pgi7G-0005fk-GH; Mon, 27 Mar 2023 10:22:10 +0200
Date:   Mon, 27 Mar 2023 10:22:10 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jun Li <jun.li@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
Message-ID: <20230327082210.2s2kelyxxua375dk@pengutronix.de>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
 <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-03-24, Jun Li wrote:
> 
> 
> > -----Original Message-----
> > From: Marco Felsch <m.felsch@pengutronix.de>
> > Sent: Thursday, March 23, 2023 6:58 PM
> > To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; dl-linux-imx <linux-imx@nxp.com>; festevam@gmail.com
> > Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de
> > Subject: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
> > 
> > The i.MX8MP-EVK has a dual-role usb-type-c port marked as PORT1. By this
> > commit the dual-role support is added which allows the user-space to assign
> > usb-gadget functions to it via the configFS.
> 
> So just ignore the orientation switch will make this port cannot work
> at super speed, this is actually why this port is not enabled at upstream.

I saw comments on the i.MX8MP-EVK schematic but no erratum listed. Can
you explain this a bit more in detail? Since the USBx_ID pin is
unconnected, the role is described via DTs as otg and the tcpc can be
configured via user-space. I tested this at least for the device mode.

> I see the orientation switch via GPIO for SBU is already merged:
> drivers/usb/typec/mux/gpio-sbu-mux.c
> Do you have interest to expand this driver to support super speed
> switch for this case? 

My intention was to enable this port to be able to have it as device
which is useful for bootloaders. The speed doesn't matter to me, at
least not now.

Regards,
  Marco


> 
> Thanks
> Li Jun
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 59 ++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > index f2d93437084be..982fe35f09a7e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -5,7 +5,9 @@
> > 
> >  /dts-v1/;
> > 
> > +#include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/phy/phy-imx8-pcie.h>
> > +#include <dt-bindings/usb/pd.h>
> >  #include "imx8mp.dtsi"
> > 
> >  / {
> > @@ -336,6 +338,34 @@ &i2c2 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_i2c2>;
> >  	status = "okay";
> > +
> > +	tcpc@50 {
> > +		compatible = "nxp,ptn5110";
> > +		reg = <0x50>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_tcpc>;
> > +		interrupt-parent = <&gpio4>;
> > +		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +		connector {
> > +			compatible = "usb-c-connector";
> > +			label = "USB-C";
> > +			power-role = "dual";
> > +			data-role = "dual";
> > +			try-power-role = "sink";
> > +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> > +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> > +				     PDO_VAR(5000, 20000, 3000)>;
> > +			op-sink-microwatt = <15000000>;
> > +			self-powered;
> > +		};
> > +
> > +		port {
> > +			usb_con_ss: endpoint {
> > +				remote-endpoint = <&usb_dwc3_0_drd>;
> > +			};
> > +		};
> > +	};
> >  };
> > 
> >  &i2c3 {
> > @@ -449,14 +479,37 @@ &uart2 {
> >  	status = "okay";
> >  };
> > 
> > +&usb3_phy0 {
> > +	status = "okay";
> > +};
> > +
> >  &usb3_phy1 {
> >  	status = "okay";
> >  };
> > 
> > +&usb3_0 {
> > +	status = "okay";
> > +};
> > +
> >  &usb3_1 {
> >  	status = "okay";
> >  };
> > 
> > +&usb_dwc3_0 {
> > +	dr_mode = "otg";
> > +	hnp-disable;
> > +	srp-disable;
> > +	adp-disable;
> > +	usb-role-switch;
> > +	status = "okay";
> > +
> > +	port {
> > +		usb_dwc3_0_drd: endpoint {
> > +			remote-endpoint = <&usb_con_ss>;
> > +		};
> > +	};
> > +};
> > +
> >  &usb_dwc3_1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_usb1_vbus>;
> > @@ -666,6 +719,12 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
> >  		>;
> >  	};
> > 
> > +	pinctrl_tcpc: tcpcgrp {
> > +		fsl,pins = <
> > +			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x159
> > +		>;
> > +	};
> > +
> >  	pinctrl_uart1: uart1grp {
> >  		fsl,pins = <
> >  			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
> > --
> > 2.30.2
> 
> 
