Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B6D61996B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKDOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiKDOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:20:35 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD22FFF5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:20:02 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 855E13F336;
        Fri,  4 Nov 2022 15:20:00 +0100 (CET)
Message-ID: <2afd6323-09e3-b8af-e98e-859983bde1ba@somainline.org>
Date:   Fri, 4 Nov 2022 15:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: msm8916-alcatel-idol347: add
 GPIO torch LED
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
 <20221104132400.1763218-3-vincent.knecht@mailoo.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104132400.1763218-3-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 14:23, Vincent Knecht wrote:
> Add support for torch LED on GPIO 32.
>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> index 668f8ff53229..eadeb1a445fd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> @@ -5,6 +5,7 @@
>   #include "msm8916-pm8916.dtsi"
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>   
>   / {
>   	model = "Alcatel OneTouch Idol 3 (4.7)";
> @@ -34,6 +35,19 @@ button-volume-up {
>   		};
>   	};
>   
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_leds_default>;
> +
> +		led-0 {
> +			gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "torch";
> +			function = LED_FUNCTION_TORCH;
> +		};
> +	};
> +
>   	usb_id: usb-id {
>   		compatible = "linux,extcon-usb-gpio";
>   		id-gpio = <&msmgpio 69 GPIO_ACTIVE_HIGH>;
> @@ -276,6 +290,14 @@ gpio_keys_default: gpio-keys-default-state {
>   		bias-pull-up;
>   	};
>   
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio32";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
>   	gyro_int_default: gyro-int-default-state {
>   		pins = "gpio97", "gpio98";
>   		function = "gpio";
