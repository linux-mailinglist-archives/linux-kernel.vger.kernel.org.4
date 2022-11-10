Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD39F623AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiKJDw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKJDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:52:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42CF20BE4;
        Wed,  9 Nov 2022 19:52:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5454DB8208A;
        Thu, 10 Nov 2022 03:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AB8C433C1;
        Thu, 10 Nov 2022 03:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668052342;
        bh=lFcBZSotaNJJMeV7gZx5otDWIzaZmFElYU6GelPw+R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YG1JQQSlFj1ALTWAd/W1wBPEPZKk3YznzwB66Dpfe+S7ntBwly3kuG0Dlu8ZC4wO2
         MrZl2dcmdecLIweeV1i4NqHUHlm+vwU3vAKw6UgCbXvAlIGd3fFPa3ZuzxuCzT157N
         c2li8g27beZpdedYQQ7DVjnORyKLwuxy1rtCE40l5lDET9sEhpUqvPctVrqi7XidaR
         +QlTgVLMvn477qZSDeWY2r4yZtkLhuoifn+/Mo+ImfUdWiw9lrO6DTfzGt9y6nhSvt
         uu3ncsHMtPtG0wkDOd3I4fK7joRn83hfx3kWsPbHz/559Nwct/tyw74lh2P9xeBhc8
         qw4nI5IBCTPqw==
Date:   Wed, 9 Nov 2022 21:52:19 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, patches@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add a device tree for PMK8350 on
 SID6
Message-ID: <20221110035219.3ohl2637fou6427t@builder.lan>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
 <20221109111236.46003-4-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109111236.46003-4-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:12:28PM +0100, Konrad Dybcio wrote:
> PMK8350 is shipped on SID6 with some SoCs, for example with SM6375.
> Add a DT with the SID changed to allow it to work.
> 
> Unfortunately, the entire DT needs to be copied even if the diff is
> very little, as the node names are not unique. Including pm6125 and
> pmk8350 together for example, would make pmk8350 overwrite the pm6125
> node, as both are defined as 'pmic@0'.
> 

This seems to work in this case, but we have the same situation in other
places where the labels just don't add up with the schematics.

That's why I ended up just defining all the pmics in sc8280xp-pmics.dtsi
and then the separate set in sa8295p-adp.dts.

Regards,
Bjorn

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi b/arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi
> new file mode 100644
> index 000000000000..00390f8b9c97
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pmk8350: pmic@6 {
> +		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
> +		reg = <0x6 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmk8350_pon: pon@1300 {
> +			compatible = "qcom,pm8998-pon";
> +			reg = <0x1300>;
> +
> +			pon_pwrkey: pwrkey {
> +				compatible = "qcom,pmk8350-pwrkey";
> +				interrupts = <0x6 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_POWER>;
> +				status = "disabled";
> +			};
> +
> +			pon_resin: resin {
> +				compatible = "qcom,pmk8350-resin";
> +				interrupts = <0x6 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		pmk8350_vadc: adc@3100 {
> +			compatible = "qcom,spmi-adc7";
> +			reg = <0x3100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <0x6 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#io-channel-cells = <1>;
> +		};
> +
> +		pmk8350_adc_tm: adc-tm@3400 {
> +			compatible = "qcom,adc-tm7";
> +			reg = <0x3400>;
> +			interrupts = <0x6 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#thermal-sensor-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		pmk8350_rtc: rtc@6100 {
> +			compatible = "qcom,pmk8350-rtc";
> +			reg = <0x6100>, <0x6200>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x6 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		pmk8350_gpios: gpio@b000 {
> +			compatible = "qcom,pmk8350-gpio", "qcom,spmi-gpio";
> +			reg = <0xb000>;
> +			gpio-controller;
> +			gpio-ranges = <&pmk8350_gpios 0 0 4>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
> -- 
> 2.38.1
> 
