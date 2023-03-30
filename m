Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059AA6D086F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjC3Oi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjC3Oi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:38:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F6DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:38:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1phtPr-0002m4-U6; Thu, 30 Mar 2023 16:38:15 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1phtPp-0001ax-BT; Thu, 30 Mar 2023 16:38:13 +0200
Date:   Thu, 30 Mar 2023 16:38:13 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     Jun Li <jun.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Message-ID: <20230330143813.teid36w24a4esjsx@pengutronix.de>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
 <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230327084947.dcguxgyo2lfen2ms@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327084947.dcguxgyo2lfen2ms@fatal.se>
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

On 23-03-27, Andreas Henriksson wrote:
> On Fri, Mar 24, 2023 at 10:18:17AM +0000, Jun Li wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > Sent: Thursday, March 23, 2023 6:58 PM
> > > To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > shawnguo@kernel.org; dl-linux-imx <linux-imx@nxp.com>; festevam@gmail.com
> > > Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > kernel@pengutronix.de
> > > Subject: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
> > > 
> > > The i.MX8MP-EVK has a dual-role usb-type-c port marked as PORT1. By this
> > > commit the dual-role support is added which allows the user-space to assign
> > > usb-gadget functions to it via the configFS.
> > 
> > So just ignore the orientation switch will make this port cannot work
> > at super speed, this is actually why this port is not enabled at upstream.
> > I see the orientation switch via GPIO for SBU is already merged:
> > drivers/usb/typec/mux/gpio-sbu-mux.c
> > Do you have interest to expand this driver to support super speed
> > switch for this case? 
> [...]
> 
> FWIW This is what I ended up with (after backporting the gpio-sbu-mux patches)
> a little while ago trying to get the usb-c ports going on imx8mp-evk. I've not
> yet had the time to fully test this (only done host/device, not tested: SS,
> orientation, etc), so beware that it might be completely wrong.
> 
> #include "dt-bindings/usb/pd.h"
> 
> &usb3_phy0 {
>     vbus-power-supply = <&ptn5110>;
>     status = "okay";
> };
> 
> &usb3_0 {
>     status = "okay";
> };
> 
> &usb_dwc3_0 {
>     dr_mode = "otg";
>     hnp-disable;
>     srp-disable;
>     adp-disable;
>     usb-role-switch;
>     role-switch-default-mode = "peripheral";
>     snps,dis-u1-entry-quirk;
>     snps,dis-u2-entry-quirk;
>     status = "okay";
> 
>     port {
>         usb3_drd_sw: endpoint {
>             remote-endpoint = <&typec_dr_sw>;
>         };
>     };
> };
> 
> &i2c2 {
>     clock-frequency = <100000>;
>     pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_i2c2>;
>     status = "okay";
> 
>     ptn5110: tcpc@50 {
>         compatible = "nxp,ptn5110";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_typec>;
>         reg = <0x50>;
> 
>         interrupt-parent = <&gpio4>;
>         interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
>         status = "okay";
> 
>         port {
>             typec_dr_sw: endpoint {
>                 remote-endpoint = <&usb3_drd_sw>;
>             };
>         };
> 
>         usb_con: connector {
>             compatible = "usb-c-connector";
>             label = "USB-C";
>             power-role = "dual";
>             data-role = "dual";
>             try-power-role = "sink";
>             source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
>             sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
>                      PDO_VAR(5000, 20000, 3000)>;
>             op-sink-microwatt = <15000000>;
>             self-powered;
> 
>             ports {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 port@1 {
>                     reg = <1>;
>                     typec_con_ss: endpoint {
>                         remote-endpoint = <&usb3_data_ss>;
>                     };
>                 };
>             };
>         };
>     };
> 
> };
> 
> &iomuxc {
>     pinctrl_typec: typec1grp {
>         fsl,pins = <
>             MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19    0x1c4
>         >;
>     };
> 
>     pinctrl_typec_mux: typec1muxgrp {
>         fsl,pins = <
>             MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20    0x16
>             MX8MP_IOMUXC_SD2_WP__GPIO2_IO20        0x16
>         >;
>     };
> 
> 
>     pinctrl_i2c2: i2c2grp {
>         fsl,pins = <
>             MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL        0x400001c2
>             MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA        0x400001c2
>         >;
>     };
> };
> 
> / {
>     gpio-sbu-mux {
>         compatible = "gpio-sbu-mux";
> 
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_typec_mux>;
>         select-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>; // (PAD_)SAI1_MCLK -> USB1_SS_SEL
>         enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>; // (PAD_)SD2_WP -> USB1_TYPEC_EN_B -> TYPEC_EN_B
> 
>         //mode-switch;
>         orientation-switch;
> 
>         port {
>             usb3_data_ss: endpoint {
>                 remote-endpoint = <&typec_con_ss>;
>             };
>         };
>     };
> };
> 
> Hope it might help.

I didn't tested it but at the moment I don't see the problem with my
patch. Sure the ID pin is not connected but if I understood it correctly
(please correct me) the tcpc will handle the orientation. I can set the
mode to device from user-space which worked. I didn't verified the
SuperSpeed mode nor the host mode since I don't have a USB-C flash
drive.

Without the patch the port is just unused albeit the port is really
useful for bootloaders like barebox to provide a usbgadget/fastboot
device to flash the system.

Regards,
  Marco
