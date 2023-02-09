Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0E690ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBINrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBINrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:47:43 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDBC19F2F;
        Thu,  9 Feb 2023 05:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675950457; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dcaDta66ZUyr4xZTMKopwnnbdTVVbGV1apxTvGrXpQKc5CIo6RMlrIrL2GzJffnlRq
    CQHtlLVr877kBoXyH7Lyr635+Z62OcPiebukMKfZwEkkn/03h3R+ecweSt0lUkzp/2qS
    wULXIHeKSZ/qf43nkUuiIbZ8N7B9qXVPDziOJsj+WHBMRWowZrg5x30G1zwKEIgcFjKM
    rh85dcoabvDS8sFY3GNgON6Y76A1mvv8g69eHIaYB7JC8Dtju6Or9pBz7lNwL3XFMNQi
    k3kqWcXa5DtH4JDgxB00dW9mnQ+81Jx5l+7vjMoeAN32E5aWvFZm0d8WMuZZ4v4HiNPe
    d4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675950457;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IY2gJ2JdUD9X1qj48Ay5XBdVhmse5lzzITzrG+rllWU=;
    b=MsuatPmmBrx1YjoToipwFFOD84ldbeBiJ4mUECj/tml8RxaUH4oLrz0UduI+DOiq4A
    kaqaFD2qBezC9XdGvGgWwtA48xpCYDrnkLZwVagvbC3TvHHXMsaCp4wiD3n2hI7F+UCl
    56WLuFWNHcjcwFnRB4Em8m2nQceOtiEyHgCj20WDUWTyGzXqXYfy90QOaaIZuWYGTtsQ
    7ik2lwOuuL6wMpsbvxbTFpLRG/t8s6VKDtjL04Deqq0bpAwx/Z8i/NAxJDqqpBlXsVSe
    jThQbj0qDptUeG/yU7W6Ltq05q2sroaq8Lxxdl3Oltdo369zW/IeCfZm0KOUM5NrPZT/
    2Lbw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675950457;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IY2gJ2JdUD9X1qj48Ay5XBdVhmse5lzzITzrG+rllWU=;
    b=Gb1rPPdlOTsIOJVciDIA8+2tAm9U9tVKgcsgQeLx8ay4Au34l47Wc+xj1jrDiHYCqq
    O5GqN+Yxd18mMwE6RDbnGKkZ6CnfpXhFXdU08pZ5YuxA93MgitBs22n7fBE46FIWYJSZ
    3fjrZNwTMW+CdIV9cxk8/YlYfJGXncdpunZ2vxviLhQ4cxOWJwnhWZyrxEbQtgPuBNPK
    pIEnc6IG9E0bJUsgtF9tObAt3TW5f7O0ZRTZ0pHLbI49hN/qbiiWSHxPLhYZ3oGZPHza
    P7O+SvYOEDwq8o1tJSzDP8RZ2sJwjx3CB8zj3L8MHvoPdOQNE3EQE0AHj8r3Xjsx42f+
    TgFg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267EpF+OQRc4obTF5+Uw3E="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id K7ac91z19DlbAQz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 9 Feb 2023 14:47:37 +0100 (CET)
Date:   Thu, 9 Feb 2023 14:47:28 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: Re: [PATCH v5 2/5] arm64: dts: qcom: Add msm8939 SoC
Message-ID: <Y+T5cF4d667RhrJp@gerhold.net>
References: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
 <20230206012336.2130341-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206012336.2130341-3-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 01:23:33AM +0000, Bryan O'Donoghue wrote:
> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
> differences to msm8916.
> 
> - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
> - DRAM 1x800 LPDDR3
> - Camera 4+4 lane CSI
> - Venus @ 1080p60 HEVC
> - DSI x 2
> - Adreno A405
> - WiFi wcn3660/wcn3680b 802.11ac
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> Co-developed-by: James Willcox <jwillcox@squareup.com>
> Signed-off-by: James Willcox <jwillcox@squareup.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Co-developed-by: Joseph Gates <jgates@squareup.com>
> Signed-off-by: Joseph Gates <jgates@squareup.com>
> Co-developed-by: Max Chen <mchen@squareup.com>
> Signed-off-by: Max Chen <mchen@squareup.com>
> Co-developed-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Zac Crosby <zac@squareup.com>
> Co-developed-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2344 +++++++++++++++++++++++++
>  1 file changed, 2344 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> new file mode 100644
> index 0000000000000..17327513a5698
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -0,0 +1,2344 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8939.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/interconnect/qcom,msm8939.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/reset/qcom,gcc-msm8939.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	/*
> +	 * Stock LK wants address-cells/size-cells = 2
> +	 * A number of our drivers want address/size cells = 1
> +	 * hence the disparity between top-level and /soc below.
> +	 */
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@100 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x100>;
> +			next-level-cache = <&L2_1>;
> +			power-domains = <&vreg_cpr_stub>;
> +			power-domain-names = "cpr";

IMHO there are still no compelling arguments for adding this dummy stub
here, aside from fixing a non-critical DT schema warning that is
obviously wrong and is being fixed in [1]. But I guess I have made my
point and you have made yours so I'll leave it up to Bjorn to decide.

[1]: https://lore.kernel.org/linux-arm-msm/20230208153913.24436-2-ansuelsmth@gmail.com/

Otherwise I just have some more nitpicks and one critical issue:
The timer interrupt numbers are still wrong.

> + [...]
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,msm8939-tsens", "qcom,tsens-v0_1";
> +			reg = <0x004a9000 0x1000>, /* TM */
> +			      <0x004a8000 0x1000>; /* SROT */
> +			nvmem-cells = <&tsens_caldata>;
> +			nvmem-cell-names = "calib";
> +			#qcom,sensors = <10>;
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow";
> +			#thermal-sensor-cells = <1>;
> +		};

"thermal/drivers/tsens: Drop single-cell code for msm8939" [2] is in
linux-next now so you need to convert this to use multiple nvmem-cells.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=dfadb4599ab0206935d5f14975b5e8112492b29c

> + [...]
> +		mdss: display-subsystem@1a00000 {
> +			compatible = "qcom,mdss";
> +			reg = <0x01a00000 0x1000>,
> +			      <0x01ac8000 0x3000>;
> +			reg-names = "mdss_phys", "vbif_phys";
> +
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_MDSS_AXI_CLK>,
> +				 <&gcc GCC_MDSS_VSYNC_CLK>;
> +			clock-names = "iface",
> +				      "bus",
> +				      "vsync";
> +
> +			power-domains = <&gcc MDSS_GDSC>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#interrupt-cells = <1>;
> +			ranges;

Please disable this by default similar to 5f36d633c214 ("arm64: dts:
qcom: Disable MDSS by default for 8916/8016 devices") for consistency
with MSM8916.

> + [...]
> +		apps_iommu: iommu@1ef0000 {
> +			compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
> +			reg = <0x01ef0000 0x3000>;
> +			ranges = <0 0x1e20000 0x40000>;

0x01e20000 (pad to 8 digits)

> + [...]
> +		usb: usb@78d9000 {
> +			compatible = "qcom,ci-hdrc";
> +			reg = <0x078d9000 0x200>,
> +			      <0x078d9200 0x200>;
> +			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			clock-names = "iface", "core";
> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			assigned-clock-rates = <80000000>;
> +			resets = <&gcc GCC_USB_HS_BCR>;
> +			reset-names = "core";
> +			#reset-cells = <1>;
> +			phy_type = "ulpi";
> +			dr_mode = "otg";
> +			ahb-burst-config = <0>;
> +			phy-names = "usb-phy";
> +			phys = <&usb_hs_phy>;
> +			status = "disabled";
> +
> +			ulpi {
> +				usb_hs_phy: phy {
> +					compatible = "qcom,usb-hs-phy-msm8916",
> +						     "qcom,usb-hs-phy";
> +					clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
> +					clock-names = "ref", "sleep";
> +					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
> +					reset-names = "phy", "por";
> +					#phy-cells = <0>;
> +					qcom,init-seq = /bits/ 8 <0x0 0x44
> +						0x1 0x6b 0x2 0x24 0x3 0x13>;

Should be formatted in pairs, see commit 640e71aac554c ("arm64: dts:
qcom: msm8916: improve usb hs node formating").

> + [...]
> +		timer@b020000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0b020000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			frame@b021000 {
> +				reg = <0x0b021000 0x1000>,
> +				      <0x0b022000 0x1000>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <0>;
> +			};

These timer interrupts are still wrong like mentioned in v3:
https://lore.kernel.org/linux-arm-msm/Y8fC%2FGCHfENQmBNC@gerhold.net/

> + [...]
> +		pronto: remoteproc@a204000 {
> +			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
> +			reg = <0x0a204000 0x2000>,
> +			      <0x0a202000 0x1000>,
> +			      <0x0a21b000 0x3000>;
> +			reg-names = "ccu", "dxe", "pmu";
> +
> +			interrupts-extended = <&intc 0 149 IRQ_TYPE_EDGE_RISING>,

&intc GIC_SPI 149

Thanks,
Stephan
