Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2D665C58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjAKNVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjAKNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:21:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FFE2617;
        Wed, 11 Jan 2023 05:21:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9371B81BFC;
        Wed, 11 Jan 2023 13:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE2DC433F0;
        Wed, 11 Jan 2023 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443270;
        bh=ISFWJ7IK4NOUI4+Z5Sm60UhFRmtLQIdAfB5VDLBw6M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwQLJgZZSL54B+vK7fc14GlCICDEfSzWk6YEfjgEjd6SrTKJSE9SMED1M8AeCC6SU
         geKx34z6dgxb9MHRHKpIOYWRYSjd1RAGPl72XVdUkcpWKkn0mOGAEbmUYFdulOv2Cs
         8CzeAy+QvtbL79LyutFWb9GxeWxhFYkR1+MnSeMgmIaB8BJLohMlOIUc0Rip79DiPq
         t4DungWYrRAnC0K9CNVQFaBo1HYEj6KNWON6/ihzwKtrToRaHe0SxPiIky+petf6F7
         9l6lkHXHqasrjCysoxzMtvmuEkqpjd+v3ZRNXshcz3fUIht5+1XiA7bPwkF1MqQl1+
         zeNWdMhUjOoew==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFb2P-00085n-Ok; Wed, 11 Jan 2023 14:21:06 +0100
Date:   Wed, 11 Jan 2023 14:21:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/4] arm64: dts: qcom: sc8280xp: Define some of the
 display blocks
Message-ID: <Y763wVbqHAEaBWBd@hovoldconsulting.com>
References: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
 <20230111035906.2975494-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111035906.2975494-2-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:59:03PM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Define the display clock controllers, the MDSS instances, the DP phys
> and connect these together.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v6:
> - Dropped assigned-clock-rate on MDP_CLK
> - Rearranged the properties in all nodes
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 811 +++++++++++++++++++++++++
>  1 file changed, 811 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 0ea2f19d471b..2ed17baf50d3 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi

> +			mdss0_mdp: display-controller@ae01000 {
> +				compatible = "qcom,sc8280xp-dpu";
> +				reg = <0 0x0ae01000 0 0x8f000>,
> +				      <0 0x0aeb0000 0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&gcc GCC_DISP_SF_AXI_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_MDP_LUT_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <0>;
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;

Nit: Shouldn't these come after the clock-names property as they did in
v5 so that the clock properties are grouped?

> +				operating-points-v2 = <&mdss0_mdp_opp_table>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@5 {
> +						reg = <5>;
> +						mdss0_intf5_out: endpoint {
> +							remote-endpoint = <&mdss0_dp3_in>;
> +						};
> +					};
> +
> +					port@6 {
> +						reg = <6>;
> +						mdss0_intf6_out: endpoint {
> +							remote-endpoint = <&mdss0_dp2_in>;
> +						};
> +					};
> +				};

> +			mdss0_dp2: displayport-controller@ae9a000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0xae9a000 0 0x200>,
> +				      <0 0xae9a200 0 0x200>,
> +				      <0 0xae9a400 0 0x600>,
> +				      <0 0xae9b000 0 0x400>;
> +
> +				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <14>;
> +				phys = <&mdss0_dp2_phy>;
> +				phy-names = "dp";
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
> +						  <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss0_dp2_phy 0>, <&mdss0_dp2_phy 1>;

Same here.

> +				operating-points-v2 = <&mdss0_dp2_opp_table>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";

> +			mdss0_dp3: displayport-controller@aea0000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0xaea0000 0 0x200>,
> +				      <0 0xaea0200 0 0x200>,
> +				      <0 0xaea0400 0 0x600>,
> +				      <0 0xaea1000 0 0x400>;
> +
> +				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_INTF_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <15>;
> +				phys = <&mdss0_dp3_phy>;
> +				phy-names = "dp";
> +				power-domains = <&dispcc0 MDSS_GDSC>;
> +
> +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
> +						  <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss0_dp3_phy 0>, <&mdss0_dp3_phy 1>;

And here.

> +				operating-points-v2 = <&mdss0_dp3_opp_table>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";

> +		mdss1: display-subsystem@22000000 {
> +			compatible = "qcom,sc8280xp-mdss";
> +			reg = <0 0x22000000 0 0x1000>;
> +			reg-names = "mdss";
> +
> +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> +				 <&dispcc1 DISP_CC_MDSS_MDP_CLK>;
> +			clock-names = "iface",
> +				      "ahb",
> +				      "core";
> +			interconnects = <&mmss_noc MASTER_MDP_CORE1_0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&mmss_noc MASTER_MDP_CORE1_1 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "mdp0-mem", "mdp1-mem";
> +			interrupts = <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;

This is a provider property so perhaps it should go before
'#interrupt-cells' as it did above?

> +
> +			iommus = <&apps_smmu 0x1800 0x402>;
> +			power-domains = <&dispcc1 MDSS_GDSC>;
> +			resets = <&dispcc1 DISP_CC_MDSS_CORE_BCR>;
> +
> +			#interrupt-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdss1_mdp: display-controller@22001000 {
> +				compatible = "qcom,sc8280xp-dpu";
> +				reg = <0 0x22001000 0 0x8f000>,
> +				      <0 0x220b0000 0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&gcc GCC_DISP_SF_AXI_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_MDP_LUT_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +				interrupt-parent = <&mdss1>;
> +				interrupts = <0>;
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;

Move after 'clock-names'?

There are a few more instances like this below.

Johan
