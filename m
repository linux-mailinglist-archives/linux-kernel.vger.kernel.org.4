Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8DB6952E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBMVQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:16:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2D1CAED;
        Mon, 13 Feb 2023 13:16:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A383A612E8;
        Mon, 13 Feb 2023 21:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7648CC433EF;
        Mon, 13 Feb 2023 21:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676323003;
        bh=M7AJTt0MhjRcZTQBX2tHEhiva1s7SEpMeL0qiMtS4+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFQra2ftbWL9EAYRbwdGHyIGaRMGPYyQJrKn+j9ETXrOK0QQyNKHx4t8qRRN79O4w
         yByOaAxlOK2Ae39BXSXGZpRzVSC3S66r9W67ng7LTzta2Y22kLoTFEgfQSnWniG5yY
         6Bo1oKTxquM5M7i9wt9iVOW7YkzLRSnqxKE+cdM3NvRJ9gYmsIu+Wp9k0n0HDgtify
         u9U7rGdQTNl8ZKGXglalKjtzulb4fE95XT143DQxomTYNnN7TDy/xCCuRW8CTB6gSg
         0c0S2gzJXCMaBfjy/2P2QXJmOIZ+Vb9vNB298Wd+3K0ZctnTdzqqEbpO0zx37Lkj/V
         fhE5ehnv9PUkw==
Date:   Mon, 13 Feb 2023 13:18:48 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Wildt <patrick@blueri.se>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: Specify interrupt
 parent explicitly
Message-ID: <20230213211848.ktj3koac3nbnhz3k@ripper>
References: <20230213090118.11527-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213090118.11527-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 02:31:18PM +0530, Manivannan Sadhasivam wrote:
> Nodes like pwrkey, resin, iadc, adc-tm, temp-alarm which are the grand
> children of spmi_bus node represent the interrupt generating devices but
> don't have "interrupt-parent" property.
> 
> As per the devicetree spec v0.3, section 2.4:
> 
> "The physical wiring of an interrupt source to an interrupt controller is
> represented in the devicetree with the interrupt-parent property. Nodes
> that represent interrupt-generating devices contain an interrupt-parent
> property which has a phandle value that points to the device to which the
> device’s interrupts are routed, typically an interrupt controller. If an
> interrupt-generating device does not have an interrupt-parent property,
> its interrupt parent is assumed to be its devicetree parent."
> 
> This clearly says that if the "interrupt-parent" property is absent, then
> the immediate devicetree parent will be assumed as the interrupt parent.
> But the immediate parents of these nodes are not interrupt controllers
> themselves.
> 
> This may lead to failure while wiring the interrupt for these nodes by an
> operating system. But a few operating systems like Linux, workaround this
> issue by walking up the parent nodes until it finds the "interrupt-cells"
> property. Then the node that has the "interrupt-cells" property will be
> used as the interrupt parent.
> 
> But this workaround is not as per the DT spec and is not being implemented
> by other operating systems such as OpenBSD.
> 
> Hence, fix this issue by adding the "interrupts-extended" property that
> explicitly specifies the spmi_bus node as the interrupt parent. Note that
> the "interrupts-extended" property is chosen over "interrupt-parent" as it
> allows specifying both interrupt parent phandle and interrupt specifiers in
> a single property.
> 
> Reported-by: Patrick Wildt <patrick@blueri.se>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks Mani, I had forgotten about this issue again.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> 
> I just fixed one dtsi since wanted to make sure that everyone agrees to
> this implementation, otherwise I'll end up wasting too much time fixing
> every other DTs making use of these nodes.
> 
> Next step would be to fix the bindings of these nodes to include interrupt-
> parent or interrupts-extended properties and affected DTs.
> 
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index f2c0b71b5d8e..df7d28f7ae60 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -64,14 +64,14 @@ pmk8280_pon: pon@1300 {
>  
>  			pmk8280_pon_pwrkey: pwrkey {
>  				compatible = "qcom,pmk8350-pwrkey";
> -				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				interrupts-extended = <&spmi_bus 0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
>  				linux,code = <KEY_POWER>;
>  				status = "disabled";
>  			};
>  
>  			pmk8280_pon_resin: resin {
>  				compatible = "qcom,pmk8350-resin";
> -				interrupts = <0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				interrupts-extended = <&spmi_bus 0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
>  				status = "disabled";
>  			};
>  		};
> @@ -79,7 +79,7 @@ pmk8280_pon_resin: resin {
>  		pmk8280_vadc: adc@3100 {
>  			compatible = "qcom,spmi-adc7";
>  			reg = <0x3100>;
> -			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			interrupts-extended = <&spmi_bus 0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			#io-channel-cells = <1>;
> @@ -89,7 +89,7 @@ pmk8280_vadc: adc@3100 {
>  		pmk8280_adc_tm: adc-tm@3400 {
>  			compatible = "qcom,spmi-adc-tm5-gen2";
>  			reg = <0x3400>;
> -			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> +			interrupts-extended = <&spmi_bus 0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			#thermal-sensor-cells = <1>;
> @@ -106,7 +106,7 @@ pmc8280_1: pmic@1 {
>  		pm8280_1_temp_alarm: temp-alarm@a00 {
>  			compatible = "qcom,spmi-temp-alarm";
>  			reg = <0xa00>;
> -			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts-extended = <&spmi_bus 0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>  			#thermal-sensor-cells = <0>;
>  		};
>  
> @@ -158,7 +158,7 @@ pmc8280_2: pmic@3 {
>  		pm8280_2_temp_alarm: temp-alarm@a00 {
>  			compatible = "qcom,spmi-temp-alarm";
>  			reg = <0xa00>;
> -			interrupts = <0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
>  			#thermal-sensor-cells = <0>;
>  		};
>  
> -- 
> 2.25.1
> 
