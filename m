Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B0063FA93
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiLAWaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiLAWaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:30:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F4BE698;
        Thu,  1 Dec 2022 14:30:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 067AB62155;
        Thu,  1 Dec 2022 22:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A50C433D6;
        Thu,  1 Dec 2022 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669933815;
        bh=C9zPt6ff2ci339LcJjA+A5VnNTOlj2rygaMYGmHG9Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3LQUI+ImSEa4/wJUkQRej3SnDSVRtGUoRzMqcyJYmlFR4e37G98HM/AJJpeqMq5W
         Ngh+yG5Y0JqE7XCOJaVYr2tayfLQIC+Fkhi8R9OQELvupx2nGnRtqY/4oM7WQgNOCq
         kUVVO50DZB2oSiMaDeP6hCUdIJc8h2xnPiU0PX8T5xSYeQ+ClbShFDofrr8cfaZE2s
         1j3afsRRbbfxBCfzZD1/HjX2KipNAex6wcT8kOdLOh/hsjL86WwZDZX6YTAbdGa8qv
         9VnRK9YxcG1kdMEzFkrVuGb8PFKtsDE1zyGqiUbFvg67s8MJRYCsClhAH03z6JsVfd
         buyq/x3hKNv3w==
Date:   Thu, 1 Dec 2022 16:30:12 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_shazhuss@quicinc.com,
        psodagud@quicinc.com, ahalaney@redhat.com, echanude@redhat.com
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: enable PCIe support
Message-ID: <20221201223012.r6mvz4updf3qoilj@builder.lan>
References: <20221201171931.1919961-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201171931.1919961-1-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 12:19:31PM -0500, Brian Masney wrote:
> Add the vreg_l11a, pcie3a, pcie3a_phy, and tlmm nodes that are necessary
> in order to get PCIe working on the QDrive3.
> 
> This patch also increases the width of the ranges property for the PCIe
> switch that's found on this platform. Note that this change requires
> the latest trustzone (TZ) firmware that's available from Qualcomm as
> of November 2022. If this is used against a board with the older
> firmware, then the board will go into ramdump mode when PCIe is probed
> on startup.
> 
> The ranges property is overridden in this sa8540p-ride.dts file since
> this is what's used to describe the QDrive3 variant with dual SoCs.
> There's another variant of this board that only has a single SoC where
> this change is not applicable, and hence why this specific change was
> not done in sa8540p.dtsi.
> 
> These changes were derived from various patches that Qualcomm
> delivered to Red Hat in a downstream kernel.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
> Changes since v1:
> - Add -state and -pins suffixes to tlmm (Krzysztof)
> 
> This patch depends on the following series that hasn't made it's way
> into linux-next yet:
> 
> [PATCH v10 0/2] arm64: dts: qcom: add dts for sa8540p-ride board
> https://lore.kernel.org/lkml/20221118025158.16902-1-quic_ppareek@quicinc.com/
> 
> I can't find the specific TZ firmware version that we have so that's why
> I included the date instead.
> 
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 54 +++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index a5f87a8629d6..e953165f3b73 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -51,6 +51,14 @@ vreg_l7a: ldo7 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l11a: ldo11 {
> +			regulator-name = "vreg_l11a";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;

In order to specify regulator-allow-set-load you also need
regulator-allowed-modes.

But if I read the implementation correction, we don't actually alter the
load, so perhaps best to just omit this for now?

Regards,
Bjorn

> +		};
> +
>  		vreg_l13a: ldo13 {
>  			regulator-name = "vreg_l13a";
>  			regulator-min-microvolt = <3072000>;
> @@ -139,6 +147,27 @@ vreg_l8g: ldo8 {
>  	};
>  };
>  
> +&pcie3a {
> +	ranges = <0x01000000 0x0 0x32200000 0x0 0x32200000 0x0 0x100000>,
> +	         <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x20000000>,
> +	         <0x03000000 0x6 0x00000000 0x6 0x00000000 0x2 0x00000000>;
> +
> +	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 56 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie3a_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3a_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
>  &qup2 {
>  	status = "okay";
>  };
> @@ -158,6 +187,31 @@ &remoteproc_nsp1 {
>  	status = "okay";
>  };
>  
> +&tlmm {
> +	pcie3a_default: pcie3a-default-state {
> +		perst-pins {
> +			pins = "gpio151";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		clkreq-pins {
> +			pins = "gpio150";
> +			function = "pcie3a_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio56";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
>  &ufs_mem_hc {
>  	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
>  
> -- 
> 2.38.1
> 
