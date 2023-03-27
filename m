Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD16C9AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjC0Eux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0Euv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:50:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0E646AE;
        Sun, 26 Mar 2023 21:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7E93FCE0B26;
        Mon, 27 Mar 2023 04:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0459C433EF;
        Mon, 27 Mar 2023 04:50:40 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     peng.fan@oss.nxp.com
Cc:     Markus.Niebel@ew.tq-group.com, abailon@baylibre.com,
        abelvesa@kernel.org, aford173@gmail.com,
        devicetree@vger.kernel.org, djakov@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        marex@denx.de, paul.elder@ideasonboard.com, peng.fan@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        gerg@kernel.org
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk ctrl
Date:   Mon, 27 Mar 2023 14:50:37 +1000
Message-Id: <20230327045037.593326-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 17:13, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add interconnect property for hsio blk ctrl
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
 > arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 > 1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 08bd57742294..9cceeeeb26be 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1109,6 +1109,11 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
>  						<&pgc_hsiomix>, <&pgc_pcie_phy>;
>  				power-domain-names = "bus", "usb", "usb-phy1",
>  						     "usb-phy2", "pcie", "pcie-phy";
> +				interconnects = <&noc IMX8MP_ICM_NOC_PCIE &noc IMX8MP_ICN_HSIO>,
> +						<&noc IMX8MP_ICM_USB1 &noc IMX8MP_ICN_HSIO>,
> +						<&noc IMX8MP_ICM_USB2 &noc IMX8MP_ICN_HSIO>,
> +						<&noc IMX8MP_ICM_PCIE &noc IMX8MP_ICN_HSIO>;
> +				interconnect-names = "noc-pcie", "usb1", "usb2", "pcie";
>  				#power-domain-cells = <1>;
>  			};
>  		};

This change completely breaks USB for me on a new iMX8mp platform I am
working with. Before this change normal USB probe looks good:

    xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
    xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
    xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe6d hci version 0x110 quirks 0x0000000000010010
    xhci-hcd xhci-hcd.0.auto: irq 206, io mem 0x38100000
    xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
    xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
    xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
    usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.03
    usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    usb usb1: Product: xHCI Host Controller
    usb usb1: Manufacturer: Linux 6.3.0-rc4-dirty xhci-hcd
    ....

But after this commit is applied, no USB probe messages at all.

USB worked fine in 6.0 for me, but when I switched up to 6.1 USB was broken,
I bisected to this as being the offending commit. This is still broken for me
in todays 6.3-rc4. If I revert this change (and only this change) USB works
again.

Any thoughts on why this breaks USB?

Regards
greg


