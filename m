Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9046F62BF88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiKPNcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiKPNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:32:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C35FC5;
        Wed, 16 Nov 2022 05:32:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC27C61DDC;
        Wed, 16 Nov 2022 13:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C362C433D6;
        Wed, 16 Nov 2022 13:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668605522;
        bh=vGBFo/ah9WmfIpSFtYYdvhOmHS/nYqo+0ewfTvT7Oik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BI3p5B8jwWp/4299D7+kyP7MSm0UzjWtXeSjYcbKF9+igw8tscxZLoFZh5OBUWI28
         QDnK7SlnPSb49vQ2k+D+RM0bUaT2DGPRJlQ/LvgWKvgRKJVRJCP3zs8pQAMaeGK418
         yNz90/5GfZOfTJjqHnfErlNhB3/OirvToJiyoJomJC+4/qSwGHf/tz2CBCYrv2dNnC
         qo00XZDbudKELiBllkaXNAKNQZrROiiYsqUONaE6QbV0ahDNjFcODonKhFhJOXMZX4
         dx6jtETsEH503p6HiH6Yn3pjhh2Tfyw97Q02uc/Ag1A0eAT2kG2wq5FLh+yPLYBldD
         m/4ZpRWgzfmNg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovIVn-0002a4-FU; Wed, 16 Nov 2022 14:31:32 +0100
Date:   Wed, 16 Nov 2022 14:31:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add UFS host controller
 and phy nodes
Message-ID: <Y3TmM+D7gn7wQM+5@hovoldconsulting.com>
References: <20221116125112.2788318-1-abel.vesa@linaro.org>
 <20221116125112.2788318-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116125112.2788318-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:51:11PM +0200, Abel Vesa wrote:
> Add UFS host controller and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 76 ++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 07ba709ca35f..27ce382cb594 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1372,6 +1372,82 @@ mmss_noc: interconnect@1780000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		ufs_mem_phy: phy@1d80000 {
> +			compatible = "qcom,sm8550-qmp-ufs-phy";

Where's the corresponding binding update?

> +			reg = <0x0 0x01d80000 0x0 0x200>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clock-names = "ref", "qref";
> +			clocks = <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&tcsr TCSR_UFS_CLKREF_EN>;
> +
> +			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +			status = "disabled";
> +
> +			ufs_mem_phy_lanes: phy@1d80400 {
> +				reg = <0x0 0x01d81000 0x0 0x134>,
> +				      <0x0 0x01d81200 0x0 0x3d8>,
> +				      <0x0 0x01d80400 0x0 0x258>,
> +				      <0x0 0x01d81800 0x0 0x134>,
> +				      <0x0 0x01d81a00 0x0 0x3d8>;
> +				#phy-cells = <0>;
> +			};

This should be converted to use the new binding scheme which drops the
child node and individual register descriptions (cf. sc8280xp).

> +		};

Johan
