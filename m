Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C055D6C9EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjC0I7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjC0I7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:59:14 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 01:57:10 PDT
Received: from pi.fatal.se (andreasfatal-1-pt.tunnel.tserv3.fmt2.ipv6.he.net [IPv6:2001:470:1f04:f16::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83AED55AF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:57:10 -0700 (PDT)
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 3A18E2A127; Mon, 27 Mar 2023 10:49:47 +0200 (CEST)
Date:   Mon, 27 Mar 2023 10:49:47 +0200
From:   Andreas Henriksson <andreas@fatal.se>
To:     Jun Li <jun.li@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
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
Message-ID: <20230327084947.dcguxgyo2lfen2ms@fatal.se>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
 <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:18:17AM +0000, Jun Li wrote:
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
> I see the orientation switch via GPIO for SBU is already merged:
> drivers/usb/typec/mux/gpio-sbu-mux.c
> Do you have interest to expand this driver to support super speed
> switch for this case? 
[...]

FWIW This is what I ended up with (after backporting the gpio-sbu-mux patches)
a little while ago trying to get the usb-c ports going on imx8mp-evk. I've not
yet had the time to fully test this (only done host/device, not tested: SS,
orientation, etc), so beware that it might be completely wrong.

#include "dt-bindings/usb/pd.h"

&usb3_phy0 {
    vbus-power-supply = <&ptn5110>;
    status = "okay";
};

&usb3_0 {
    status = "okay";
};

&usb_dwc3_0 {
    dr_mode = "otg";
    hnp-disable;
    srp-disable;
    adp-disable;
    usb-role-switch;
    role-switch-default-mode = "peripheral";
    snps,dis-u1-entry-quirk;
    snps,dis-u2-entry-quirk;
    status = "okay";

    port {
        usb3_drd_sw: endpoint {
            remote-endpoint = <&typec_dr_sw>;
        };
    };
};

&i2c2 {
    clock-frequency = <100000>;
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_i2c2>;
    status = "okay";

    ptn5110: tcpc@50 {
        compatible = "nxp,ptn5110";
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_typec>;
        reg = <0x50>;

        interrupt-parent = <&gpio4>;
        interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
        status = "okay";

        port {
            typec_dr_sw: endpoint {
                remote-endpoint = <&usb3_drd_sw>;
            };
        };

        usb_con: connector {
            compatible = "usb-c-connector";
            label = "USB-C";
            power-role = "dual";
            data-role = "dual";
            try-power-role = "sink";
            source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
            sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
                     PDO_VAR(5000, 20000, 3000)>;
            op-sink-microwatt = <15000000>;
            self-powered;

            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@1 {
                    reg = <1>;
                    typec_con_ss: endpoint {
                        remote-endpoint = <&usb3_data_ss>;
                    };
                };
            };
        };
    };

};

&iomuxc {
    pinctrl_typec: typec1grp {
        fsl,pins = <
            MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19    0x1c4
        >;
    };

    pinctrl_typec_mux: typec1muxgrp {
        fsl,pins = <
            MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20    0x16
            MX8MP_IOMUXC_SD2_WP__GPIO2_IO20        0x16
        >;
    };


    pinctrl_i2c2: i2c2grp {
        fsl,pins = <
            MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL        0x400001c2
            MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA        0x400001c2
        >;
    };
};

/ {
    gpio-sbu-mux {
        compatible = "gpio-sbu-mux";

        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_typec_mux>;
        select-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>; // (PAD_)SAI1_MCLK -> USB1_SS_SEL
        enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>; // (PAD_)SD2_WP -> USB1_TYPEC_EN_B -> TYPEC_EN_B

        //mode-switch;
        orientation-switch;

        port {
            usb3_data_ss: endpoint {
                remote-endpoint = <&typec_con_ss>;
            };
        };
    };
};

Hope it might help.

Regards,
Andreas Henriksson
