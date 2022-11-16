Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE162BFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiKPNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiKPNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:38:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C828064EA;
        Wed, 16 Nov 2022 05:38:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6748561DF7;
        Wed, 16 Nov 2022 13:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0649C433D6;
        Wed, 16 Nov 2022 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668605885;
        bh=o/L5hTRc+UROCPzDc8twMJIeoNJhL9dYAFN5gGbF/ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrtvOzGSvYBUFutZQ+KypZZeCpGv/fPgPfPcvp/TkSik12NueTES6wZAI4hc90+J7
         rImtebSIpqDL79fuJMoZ5WhFXFaVgWjSjCpMcy+HYwOuxfFM0yUffCFy6+0CL0cKOD
         PGI8L+CVmQYSvFSzSgCeeOL3tcNDEb9UbqU5Jxbon/rAPfi/E69VIvKiKS3ijr/zkm
         xtA5a8m91OJ1yLTX96YW6Wo6M4+qWDkgOgRpnB04Q9+RpjaQaIKRNBppzieCY6rOri
         tQ4y8oFfkt5MqfZmE2X9jLfn+M5XNXtn8LYyLKle7TmKkPPxUack3AC+dXToHuoYMO
         FZSZfg3ML8m2g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovIbg-0002eD-9g; Wed, 16 Nov 2022 14:37:36 +0100
Date:   Wed, 16 Nov 2022 14:37:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add PCIe PHYs and
 controllers nodes
Message-ID: <Y3TnoIqXSSimqySN@hovoldconsulting.com>
References: <20221116130430.2812173-1-abel.vesa@linaro.org>
 <20221116130430.2812173-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116130430.2812173-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:04:29PM +0200, Abel Vesa wrote:
> Add PCIe controllers and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 245 +++++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 07ba709ca35f..5c274d0372ad 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
 				 <&ufs_phy_rx_symbol_1_clk>,
> @@ -1372,6 +1376,247 @@ mmss_noc: interconnect@1780000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-sm8550-pcie0";
> +			reg = <0 0x01c00000 0 0x3000>,
> +			      <0 0x60000000 0 0xf1d>,
> +			      <0 0x60000f20 0 0xa8>,
> +			      <0 0x60001000 0 0x1000>,
> +			      <0 0x60100000 0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> +
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			interconnect-names = "icc_path";
> +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
> +				 <&pcie0_lane>,
> +				 <&rpmhcc RPMH_CXO_CLK>,

As I mentioned in my comment to the binding, the above three clocks
should not be here but rather be handled by the clock driver.

> +				 <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
> +			clock-names = "pipe",
> +					"pipe_mux",
> +					"phy_pipe",
> +					"ref",
> +					"aux",
> +					"cfg",
> +					"bus_master",
> +					"bus_slave",
> +					"slave_q2a",
> +					"ddrss_sf_tbu",
> +					"aggre0";
> +
> +			iommus = <&apps_smmu 0x1400 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_0_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +			power-domain-names = "gdsc";
> +
> +			phys = <&pcie0_lane>;
> +			phy-names = "pciephy";
> +
> +			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie0_default_state>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy";

Where's the corresponding binding update?

> +			reg = <0 0x01c06000 0 0x200>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_0_PHY_GDSC>;
> +			power-domain-names = "gdsc";
> +
> +			status = "disabled";
> +
> +			pcie0_lane: phy@1c06200 {
> +				reg = <0 0x1c06e00 0 0x200>, /* tx0 */
> +				      <0 0x1c07000 0 0x200>, /* rx0 */
> +				      <0 0x1c06200 0 0x200>, /* pcs */
> +				      <0 0x1c07600 0 0x200>, /* tx1 */
> +				      <0 0x1c07800 0 0x200>, /* rx1 */
> +				      <0 0x1c06600 0 0x200>; /* pcs_pcie */
> +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> +				clock-names = "pipe0";
> +
> +				#clock-cells = <0>;
> +				#phy-cells = <0>;
> +				clock-output-names = "pcie_0_pipe_clk";
> +			};

These PHY nodes should also be updated to the new binding scheme which
drops the child node and individual register descriptions (cf.
sc8280xp).

Johan
