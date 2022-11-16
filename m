Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192E62BFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiKPNnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiKPNmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:42:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C745EC0;
        Wed, 16 Nov 2022 05:42:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E31E3B81D89;
        Wed, 16 Nov 2022 13:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FBBC433C1;
        Wed, 16 Nov 2022 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606159;
        bh=oPVFkf6C4Y0jh6Ft7Ba+5hG505e129cn+0wTVBkqdl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKabFNlBhNstb/056A7/S3937WcMVkAclP46psvHOQ4mxpz0ptjqU+ReL/oYaiWDF
         ETaaIOb1ROG/IcADdQRyhdTH67Wp5oCYOs+x7m09JamCMu6WsrVUZk21Dvf4Fi5MT+
         pXLKupB9it33liQz2fI9cC2uD9dyl57g4hE/RJbwjLV0Vf0ZExpeu50G8ko3SPSM6D
         3LIY6Bc3RMx94vWh2akuXyCuDKG1eIrujcmp6i7eHE17HwlTbdc2wiSE4VkYNBV39C
         sqLkvSGTUfI23RLQFdzzVFlV+XwHwBDHTwx48dnEEYnF85JqbIJk82Eimv7E6blPKf
         llZOFgxL4y7zQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovIg5-0002h3-O4; Wed, 16 Nov 2022 14:42:09 +0100
Date:   Wed, 16 Nov 2022 14:42:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add USB PHYs and
 controller nodes
Message-ID: <Y3TosXNl/91acN94@hovoldconsulting.com>
References: <20221116132212.2842655-1-abel.vesa@linaro.org>
 <20221116132212.2842655-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116132212.2842655-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:22:11PM +0200, Abel Vesa wrote:
> Add USB host controller and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 99 ++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 07ba709ca35f..1b62395fe101 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1460,6 +1460,105 @@ opp-202000000 {
>  			};
>  		};
>  
> +		usb_1_hsphy: phy@88e3000 {
> +			compatible = "qcom,sm8550-snps-eusb2-phy";
> +			reg = <0x0 0x088e3000 0x0 0x154>;
> +			status = "disabled";
> +			#phy-cells = <0>;
> +
> +			clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		};
> +
> +		usb_1_qmpphy: phy-wrapper@88e9000 {
> +			compatible = "qcom,sm8550-qmp-usb3-phy";

Where's the corresponding binding update?

> +			reg = <0x0 0x088e9000 0x0 0x200>,
> +			      <0x0 0x088e8000 0x0 0x20>;
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_PAD_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "ref_clk_src", "com_aux";

Don't you have a dedicated ref clk? In any case, ref_clk_src should not
be here (either rename it 'ref' or replace it).

> +
> +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> +				<&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			reset-names = "phy", "common";
> +			power-domains = <&gcc USB3_PHY_GDSC>;
> +
> +			usb_1_ssphy: phy@88e9200 {
> +				reg = <0x0 0x088e9200 0x0 0x200>,
> +				      <0x0 0x088e9400 0x0 0x200>,
> +				      <0x0 0x088e9c00 0x0 0x400>,
> +				      <0x0 0x088e9600 0x0 0x200>,
> +				      <0x0 0x088e9800 0x0 0x200>,
> +				      <0x0 0x088e9a00 0x0 0x100>;
> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};

As for UFS and PCIe these PHY nodes should be updated to use the new
binding scheme which drops the child node and individual register
descriptions (cf. sc8280xp).

> +		};

Johan
