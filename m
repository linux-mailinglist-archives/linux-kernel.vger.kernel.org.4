Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7B6C9AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjC0FHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjC0FHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:07:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983755AC;
        Sun, 26 Mar 2023 22:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B291EB80D1A;
        Mon, 27 Mar 2023 05:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9749C433EF;
        Mon, 27 Mar 2023 05:06:44 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     peng.fan@oss.nxp.com
Cc:     Markus.Niebel@ew.tq-group.com, aford173@gmail.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, marex@denx.de,
        paul.elder@ideasonboard.com, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, gerg@kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: add vpu pgc nodes
Date:   Mon, 27 Mar 2023 15:06:42 +1000
Message-Id: <20230327050642.593778-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713063653.2584488-6-peng.fan@oss.nxp.com>
References: <20220713063653.2584488-6-peng.fan@oss.nxp.com>
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

On 22/8/22 14:45, Peng Fan wrote:
> Add i.MX8MP PGC nodes for vpu, which are used to supply power for VPU.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 27 +++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 0b165f98a82c..34af983b0210 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -598,6 +598,33 @@ pgc_ispdwp: power-domain@18 {
>                                                 reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
>                                                 clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
>                                         };
> +
> +                                       pgc_vpumix: power-domain@19 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
> +                                               clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
> +                                       };
> +
> +                                       pgc_vpu_g1: power-domain@20 {
> +                                               #power-domain-cells = <0>;
> +                                               power-domains = <&pgc_vpumix>;
> +                                               reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
> +                                               clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
> +                                       };
> +
> +                                       pgc_vpu_g2: power-domain@21 {
> +                                               #power-domain-cells = <0>;
> +                                               power-domains = <&pgc_vpumix>;
> +                                               reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
> +                                               clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
> +                                       };
> +
> +                                       pgc_vpu_vc8000e: power-domain@22 {
> +                                               #power-domain-cells = <0>;
> +                                               power-domains = <&pgc_vpumix>;
> +                                               reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
> +                                               clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
> +                                       };
>                                 };
>                         };
>                 };

This change causes new error messages to come out during boot, for example:

    ...
    imx-pgc imx-pgc-domain.8: failed to command PGC
    imx-pgc imx-pgc-domain.8: failed to command PGC
    imx-pgc imx-pgc-domain.8: failed to command PGC
    30890000.serial: ttymxc1 at MMIO 0x30890000 (irq = 197, base_baud = 1500000) is a IMX
    ...
    hwmon hwmon1: temp1_input not attached to any thermal zone
    imx-pgc imx-pgc-domain.8: failed to command PGC
    imx-pgc imx-pgc-domain.8: failed to command PGC
    imx-pgc imx-pgc-domain.8: failed to command PGC
    ...

They don't seem to cause any problems on the hardware I am using, well,
at least not that I have found so far.

This first appeared for me in linux-6.1. But it is the same in todays
linux 6.3-rc4. Reverting this change (not completely trivial due to a
couple of commits after it that rely on it) fixes it - no more errors.

Regards
Greg


