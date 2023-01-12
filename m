Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B4D667963
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjALPf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbjALPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:34:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22C3625E8;
        Thu, 12 Jan 2023 07:25:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B7F4B81E85;
        Thu, 12 Jan 2023 15:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042BDC433F0;
        Thu, 12 Jan 2023 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673537103;
        bh=GQl+TWZ0lnrDJO8A5lwHu11g+ftYrH3VhsAL3ZgMFWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlzFMbN/JXIzWEoNTyGumTKR4PUw5Vc7B1E/cMDEoZje0fAkYNiTVUPTjedti/jFj
         r9i8ScD0tlLJwVa4KxzNZj4fyG38McIKeALAC6D4zHRXYc9mCsZTKZ8t/48Sfn+uBT
         ZSgfPfEJUaMNQ9tu2yGA7ZQdP1ZY4wePfeCkafomtEKjfPRDf/yAgNaWDec66b46MA
         rVemYgJkFZTvOIiin6NWDKsJPUAvgkl0WhrOVqOe8Y1dXFHneqJ8aCCPBg1IQv0m4E
         /mbHUx5O/8YQaVEeDBWM09YI+w3Bar2QkzV0GisihpLDV8I3ExtVaGXISJGQvDnokH
         eotab+39gC3tg==
Date:   Thu, 12 Jan 2023 09:25:01 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8550: Add UFS host controller
 and phy nodes
Message-ID: <20230112152501.lwamtdsuufobof3c@builder.lan>
References: <20230112135926.1572191-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112135926.1572191-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 03:59:25PM +0200, Abel Vesa wrote:
> Add UFS host controller and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v1:
>  * dropped ufs_mem_phy_lanes child node, like Johan suggested
>  * addressed Konrad comments.
> 
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 78 ++++++++++++++++++++++++++--
>  1 file changed, 75 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 59756ec11564..d20b5fbcb2c3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -649,9 +649,9 @@ gcc: clock-controller@100000 {
>  				 <0>,
>  				 <0>,
>  				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&ufs_mem_phy 0>,
> +				 <&ufs_mem_phy 1>,
> +				 <&ufs_mem_phy 2>,
>  				 <0>;
>  		};
>  
> @@ -1571,6 +1571,78 @@ crypto: crypto@1de0000 {
>  			interconnect-names = "memory";
>  		};
>  
> +		ufs_mem_phy: phy@1d80000 {
> +			compatible = "qcom,sm8550-qmp-ufs-phy";
> +			reg = <0x0 0x01d80000 0x0 0x2000>;
> +			clock-names = "ref", "qref";
> +			clocks = <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&tcsr TCSR_UFS_CLKREF_EN>;
> +
> +			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +
> +			#phy-cells = <0>;
> +
> +			#clock-cells = <1>;
> +
> +			ranges;

Isn't this a leftover from the older binding?

> +
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_hc: ufshc@1d84000 {

ufs@ I believe.

> +			compatible = "qcom,sm8550-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg = <0x0 0x01d84000 0x0 0x3000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			iommus = <&apps_smmu 0x60 0x0>;
> +
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
> +
> +			interconnect-names = "ufs-ddr", "cpu-ufs";
> +			clock-names = "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk",
> +				      "rx_lane1_sync_clk";
> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				 <&rpmhcc RPMH_LN_BB_CLK3>,

ref_clk here represents the refclk to the memory device, which I believe
is what is the thing you have as <&tcsrcc TCSR_UFS_PAD_CLKREF_EN>.

> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +			freq-table-hz =
> +				<75000000 300000000>,

GCC_UFS_PHY_AXI_CLK requires SM8550_CX (UFS_PHY_GDSC) to be voted to
nominal, so please ensure that this is done. (e.g. using required-opps)

Thanks,
Bjorn

> +				<0 0>,
> +				<0 0>,
> +				<75000000 300000000>,
> +				<100000000 403000000>,
> +				<0 0>,
> +				<0 0>,
> +				<0 0>;
> +			status = "disabled";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0 0x01f40000 0 0x20000>;
> -- 
> 2.34.1
> 
