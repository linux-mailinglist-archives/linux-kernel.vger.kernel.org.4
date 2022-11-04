Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D2619992
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiKDOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiKDOW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:22:29 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900E2ED47
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:21:21 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 841903F70C;
        Fri,  4 Nov 2022 15:21:19 +0100 (CET)
Message-ID: <89994dc6-52f8-752e-04ae-42c8df3e9615@somainline.org>
Date:   Fri, 4 Nov 2022 15:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8916-alcatel-idol347: add LED
 indicator
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
 <20221104132400.1763218-4-vincent.knecht@mailoo.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104132400.1763218-4-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 14:24, Vincent Knecht wrote:
> Add si-en,sn3190 LED controller to enable white LED indicator.
>
> This requires adding the additional "enable" gpio that the OEM
> choose to use, despite it not being mentioned in si-en,sn3190
> datasheet nor supported by the driver.
>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>   .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 44 +++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> index eadeb1a445fd..701a5585d77e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> @@ -130,6 +130,27 @@ gyroscope@68 {
>   	};
>   };
>   
> +&blsp_i2c6 {
> +	status = "okay";
> +
> +	led-controller@68 {
> +		compatible = "si-en,sn3190";
> +		reg = <0x68>;
> +		shutdown-gpios = <&msmgpio 89 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_enable_default &led_shutdown_default>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@1 {
> +			reg = <1>;
> +			led-max-microamp = <5000>;
> +			function = LED_FUNCTION_INDICATOR;
> +			color = <LED_COLOR_ID_WHITE>;
> +		};
> +	};
> +};
> +
>   &pm8916_resin {
>   	status = "okay";
>   	linux,code = <KEY_VOLUMEDOWN>;
> @@ -306,6 +327,29 @@ gyro_int_default: gyro-int-default-state {
>   		bias-disable;
>   	};
>   
> +	/*
> +	 * The OEM wired an additional GPIO to be asserted so that
> +	 * the si-en,sn3190 LED IC works. Since this GPIO is not
> +	 * part of the IC datasheet nor supported by the driver,
> +	 * force it asserted here.
> +	 */

Looks like the least problematic way to handle this.


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

> +	led_enable_default: led-enable-default-state {
> +		pins = "gpio102";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-high;
> +	};
> +
> +	led_shutdown_default: led-shutdown-default-state {
> +		pins = "gpio89";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
>   	mag_reset_default: mag-reset-default-state {
>   		pins = "gpio8";
>   		function = "gpio";
