Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BBD6719CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjARK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjARKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:53:07 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031B8875F;
        Wed, 18 Jan 2023 02:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674035966; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PD4JUF0Ic4zCMKwyQWHQy7gAP8Ew6sCp2yIgnHi5zkrDbfJU7YzTLQyV44eW7Jl+Np
    o2WZgd3TcJPoe3H+UewoH5Pn+VdgMwfsbrR7LfvftqViWqQNU6ZbmKQDIXiJXJJ0NNKz
    6e2ORQ+SsBDWLRQRVxnHuG79N+e3mDlP8qnbmlQTFJ+V+ZmzicRaO7pHnl+P4CHIECwR
    nt2xz0HukwCMtJZ+ZTgs+9qBwsbGpjLQ7DVCMB61EFZP0lFWXQtZrQiFMHrjwu3EGtgH
    Fm69e+S64d8U2ohQm3LZBrmMnBuyICCvcR0RSruFXY6fsMjqaqCBAEgI99uvyQhQ/vdV
    DSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674035966;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=XloDhccUPEB9DABnwjfDY3kw39mWtjS7W0i5G+mAxDs=;
    b=pEvGrdFJw8qSRvoFjSUU7zhBK3HVXXG+4cEhKKe2TUvpV/g7ZmlQ9KTN2yPyAM7Dxd
    OV0ea3NhQLu2L/9MOHTmyhtXmrmYNLgCZj3418bTCNpEXdFoNDqPpy9AsdMHBRYrt/Xd
    g0Z0zhk4psdu3LOA5cx5Uxm/zHeoAfGQw2i/L3VrVgcSFaKepPCFHDzaoap+sCJ7K9dz
    i9gWpNzogJITWgLxkZq68//WgQwSenBQZaZ5zvlsZFZRQTZSHbtsL/iIs6olXAap5x1w
    18iakDu+nDGRSdJcKkZrBLUy6/FCIUneIRV0wJk8M4IqwhEux/CsiWZ/+gxpFCEuUzu7
    ONTQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674035966;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=XloDhccUPEB9DABnwjfDY3kw39mWtjS7W0i5G+mAxDs=;
    b=HAG6wdjdUu/Bp4BeyeXCwVER+yRK7HFxk0I7SIxF2T67GTap3z0icYL7/iBZd27kbK
    8b3rdu2eRkx1IfRCMvBjsvVvbEQOpZC29171VsEyP2KCbTjX93Q6QTzBXu/SXIG48B+c
    754Mb+VpJGx9MWd7x+108Gpv1AIPrPmyJ+ruke02V1tVCPsDrHojyqBtpzK3ft6RsuRw
    wC3SstDMm0ELxNozapLJe+keWWIDyarCwZwJ5DZCXKeGZZfdeVAZ15xwnHYQu3oTJWYg
    WVbrgz8QTvxgmOqZHsdUm15oSx2v8r/EHwyOmkrwflcqjwGGPsTWoc2lD31MeLQo/0L2
    Bo4Q==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWx/bI"
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.6.2 DYNA|AUTH)
    with ESMTPSA id yacdeez0I9xPM2a
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 18 Jan 2023 10:59:25 +0100 (CET)
Date:   Wed, 18 Jan 2023 10:59:24 +0100
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
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Message-ID: <Y8fC/GCHfENQmBNC@gerhold.net>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:48:43AM +0000, Bryan O'Donoghue wrote:
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
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2393 +++++++++++++++++++++++++
>  1 file changed, 2393 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> new file mode 100644
> index 0000000000000..8cd358a9fe623
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -0,0 +1,2393 @@
> [...]
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@100 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x100>;
> +			next-level-cache = <&L2_1>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";

Why are you adding a dummy power domain here? IMO this would be better
added together with CPR. Especially because I would expect two power
domains here later ("mx", "cpr"). For cpufreq you also need to make
votes for the "MSM8939_VDDMX" power domain.

> +			qcom,acc = <&acc0>;
> +			qcom,saw = <&saw0>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs1_mbox>;
> +			#cooling-cells = <2>;
> +			L2_1: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +			};
> +		};
> [...]
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +
> +		rng@22000 {
> +			compatible = "qcom,prng";
> +			reg = <0x00022000 0x200>;
> +			clocks = <&gcc GCC_PRNG_AHB_CLK>;
> +			clock-names = "core";
> +		};
> +
> +		qfprom: qfprom@5c000 {
> +			compatible = "qcom,msm8916-qfprom", "qcom,qfprom";
> +			reg = <0x0005c000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			tsens_caldata: caldata@a0 {
> +				reg = <0xa0 0x5c>;
> +			};
> +			cpr_efuse_init_voltage1: ivoltage1@dc {
> +				reg = <0xdc 0x4>;
> +				bits = <4 6>;
> +			};
> +			cpr_efuse_init_voltage2: ivoltage2@da {
> +				reg = <0xda 0x4>;
> +				bits = <2 6>;
> +			};
> +			cpr_efuse_init_voltage3: ivoltage3@d8 {
> +				reg = <0xd8 0x4>;
> +				bits = <0 6>;
> +			};
> +			cpr_efuse_quot1: quot1@dd {
> +				reg = <0xdd 0x8>;
> +				bits = <2 12>;
> +			};
> +			cpr_efuse_quot2: quot2@db {
> +				reg = <0xdb 0x8>;
> +				bits = <0x0 12>;
> +			};
> +			cpr_efuse_ring1: ring1@de {
> +				reg = <0xde 0x4>;
> +				bits = <6 3>;
> +			};
> +			cpr_efuse_revision: revision@5 {
> +				reg = <0x5 0x1>;
> +				bits = <5 1>;
> +			};
> +			cpr_efuse_revision_high: revision-high@7 {
> +				reg = <0x7 0x1>;
> +				bits = <0 1>;
> +			};
> +			cpr_efuse_pvs_version: pvs@3 {
> +				reg = <0x3 0x1>;
> +				bits = <5 1>;
> +			};
> +			cpr_efuse_pvs_version_high: pvs-high@6 {
> +				reg = <0x6 0x1>;
> +				bits = <2 2>;
> +			};
> +			cpr_efuse_speedbin: speedbin@c {
> +				reg = <0xc 0x1>;
> +				bits = <2 3>;
> +			};

Please add the CPR items later together with CPR. This will make the
review a bit easier because we don't need to check that these are right
for the initial submission.

> +		};
> [...]
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
> +
> +			mdp: display-controller@1a01000 {
> +				compatible = "qcom,mdp5";
> +				reg = <0x01a01000 0x89000>;
> +				reg-names = "mdp_phys";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;
> +
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_VSYNC_CLK>,
> +					 <&gcc GCC_MDP_TBU_CLK>,
> +					 <&gcc GCC_MDP_RT_TBU_CLK>;
> +				clock-names = "iface",
> +					      "bus",
> +					      "core",
> +					      "vsync",
> +					      "tbu",
> +					      "tbu_rt";
> +
> +				iommus = <&apps_iommu 4>;
> +
> +				interconnects = <&snoc_mm MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>,
> +						<&snoc_mm MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>,
> +						<&pcnoc MASTER_SPDM &snoc SLAVE_IMEM>;
> +				interconnect-names = "mdp0-mem", "mdp1-mem", "register-mem";

As I mentioned a already in a direct email at some point, AFAIU adding
interconnects should be an [almost-] all or nothing step. If you only
add interconnects for MDP then everything else that needs bandwidth will
either break or only continue working as a mere side effect of MDP
voting for permanent high bandwidth.

This could break easily if someone has a board without display, or if
the MDP5 driver is optimized to request the minimum necessary bandwidth
only.

I think strictly speaking "interconnects" properties are needed for
everything that uses DMA, i.e. CPUs, SDHCI, USB, UART, I2C, SPI and also
audio (in DSP bypass mode only). If you look at newer platforms they do
have "interconnects" for most of these.

(Semi-related side note: "register-mem" is neither documented nor used
 anywhere in the code?)

> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdp5_intf1_out: endpoint {
> +							remote-endpoint = <&dsi0_in>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdp5_intf2_out: endpoint {
> +							remote-endpoint = <&dsi1_in>;
> +						};
> +					};
> +				};
> +			};
> +
> +			dsi0: dsi@1a98000 {
> +				compatible = "qcom,msm8916-dsi-ctrl",
> +					     "qcom,mdss-dsi-ctrl";
> +				reg = <0x01a98000 0x25c>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <4>;
> +
> +				power-domains = <&gcc MDSS_GDSC>;

Why is MDSS_GDSC defined again here? The parent-child relationship of
MDSS->MDP should ensure that the MDSS_GDSC from the parent mdss node
is on when dsi is.

> +
> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
> +					 <&gcc GCC_MDSS_ESC0_CLK>;
> +				clock-names = "mdp_core",
> +					      "iface",
> +					      "bus",
> +					      "byte",
> +					      "pixel",
> +					      "core";
> +				assigned-clocks = <&gcc BYTE0_CLK_SRC>,
> +						  <&gcc PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&dsi_phy0 0>,
> +							 <&dsi_phy0 1>;
> +
> +				phys = <&dsi_phy0>;
> +				status = "disabled";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dsi0_in: endpoint {
> +							remote-endpoint = <&mdp5_intf1_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dsi0_out: endpoint {
> +						};
> +					};
> +				};
> +			};
> +
> +			dsi_phy0: phy@1a98300 {
> +				compatible = "qcom,dsi-phy-28nm-lp";
> +				reg = <0x01a98300 0xd4>,
> +				      <0x01a98500 0x280>,
> +				      <0x01a98780 0x30>;
> +				reg-names = "dsi_pll",
> +					    "dsi_phy",
> +					    "dsi_phy_regulator";
> +
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +				clock-names = "iface", "ref";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			dsi1: dsi@1aa0000 {
> +				compatible = "qcom,msm8916-dsi-ctrl",
> +					     "qcom,mdss-dsi-ctrl";
> +				reg = <0x01aa0000 0x25c>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <5>;
> +
> +				power-domains = <&gcc MDSS_GDSC>;
> +
> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_BYTE1_CLK>,
> +					 <&gcc GCC_MDSS_PCLK1_CLK>,
> +					 <&gcc GCC_MDSS_ESC1_CLK>;
> +				clock-names = "mdp_core",
> +					      "iface",
> +					      "bus",
> +					      "byte",
> +					      "pixel",
> +					      "core";
> +				assigned-clocks = <&gcc BYTE1_CLK_SRC>,
> +						  <&gcc PCLK1_CLK_SRC>;
> +				assigned-clock-parents = <&dsi_phy1 0>,
> +							 <&dsi_phy1 1>;

Does this work? Confusingly, BYTE1/PCLK1_CLK_SRC can only have dsi0pll
as parent in gcc-msm8939 and not the dsi1pll. <&dsi_phy1 0/1> is not a
valid parent for those clocks.

Actually I cannot find any mention of mdss_dsi1_pll at all in
downstream. It seems a bit like the PLL functionality in dsi_phy1 is
unused and the PLL in dsi_phy0 is used for both DSI interfaces instead.
No idea why. If this is the case then assigned-clock-parents should
refer to dsi_phy0 here.

> +				phys = <&dsi_phy1>;
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dsi1_in: endpoint {
> +							remote-endpoint = <&mdp5_intf2_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dsi1_out: endpoint {
> +						};
> +					};
> +				};
> +			};
> +
> +			dsi_phy1: phy@1aa0300 {
> +				compatible = "qcom,dsi-phy-28nm-lp";
> +				reg = <0x01aa0300 0xd4>,
> +				      <0x01aa0500 0x280>,
> +				      <0x01aa0780 0x30>;
> +				reg-names = "dsi_pll",
> +					    "dsi_phy",
> +					    "dsi_phy_regulator";
> +
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +				clock-names = "iface", "ref";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> [...]
> +		blsp_dma: dma-controller@7884000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x07884000 0x23000>;
> +			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			status = "disabled";

Please enable this by default, see
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=0154d3594af3c198532ac7b4ab70f50fb5207a15

> +		};
> [...]
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

These timer interrupts are still wrong. GIC_SPI 8/7 belong to the timer
frame of the other cluster, 0x0b121000 instead of 0x0b021000.

You need to change the reg addresses like in
https://github.com/msm8916-mainline/linux/commit/0905a152ccb6fe6b94e8c16767993f05c608089c

OR, alternatively: Fix all the interrupt numbers. From the LK source
code we know that this timer frame specifically has GIC_SPI 257 as one
of its interrupts, because LK is making use of it:

https://git.codelinaro.org/clo/la/kernel/lk/-/blob/caf_migration/LA.BR.1.2.9.1_rb1.5/platform/msm8916/include/platform/irqs.h#L47-48

The other timer frames are likely also connected to some other interrupt
number that you might find in documentation or using experiments.

But the easier solution would be keeping the interrupts and just
changing the "reg"s.

> +				frame-number = <0>;
> +			};
> +
> +			frame@b023000 {
> +				reg = <0x0b023000 0x1000>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <1>;
> +				status = "disabled";
> +			};
> +
> +			frame@b024000 {
> +				reg = <0x0b024000 0x1000>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <2>;
> +				status = "disabled";
> +			};
> +
> +			frame@b025000 {
> +				reg = <0x0b025000 0x1000>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <3>;
> +				status = "disabled";
> +			};
> +
> +			frame@b026000 {
> +				reg = <0x0b026000 0x1000>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <4>;
> +				status = "disabled";
> +			};
> +
> +			frame@b027000 {
> +				reg = <0x0b027000 0x1000>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <5>;
> +				status = "disabled";
> +			};
> +
> +			frame@b028000 {
> +				reg = <0x0b028000 0x1000>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <6>;
> +				status = "disabled";
> +			};
> +		};
> [...]

Thanks!
Stephan
