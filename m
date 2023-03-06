Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC886AC89D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjCFQrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCFQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:46:48 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97603E09E;
        Mon,  6 Mar 2023 08:45:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678119250; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r0oJisPmVmiGhfBOquIsvykEt6GuagiLlQN3/aghpdIAGN6xOQzmJJS77ZXM68sjkY
    I8wZnax46XbT9eUc+4dfK/xGTaaRA3GQJtWIIITRmKeFKY307FaFst3ZqiNsdmJ3zgzs
    oKXiI4sRa7ndWY6qIsTTXT8agFnhT2ThvN590G1irEy0/zh8mlHXlwoj4xfvM2v3+J5B
    mlOZHmCGiwmmtJZ9GjKtNYgfGZH+LYsye3l4dbqkScNDujxbPHkea2B7XJleJ+lhRlHF
    qDEWhmWVJG+rashB/PMmNwvkqTx9fA/pjJQTelfWz2NGSJOzqzb5CEIUIvMKRsh0a3Ib
    XXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678119250;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=E5MgXFLGzXqV3kZmdi0um2+BJZgLBqfV9CY4BZsWLcI=;
    b=oJKShJQQjwd41p6Hkl3y02zdklHVMxlsNG2nS3axF1McBpSRf+5kQLNyEJ1wC1rW2c
    Sue1UdycnksjwLZJ4+34rQn7BHYB9gCkBpXHtr3nAZ71lsaDwohImCnq7s+nWdjYGJxX
    +pj8SPm8g7byQ+V95NEE9eQUBGT/R6Pzw/JOaNWLBSyVUYfaJmi2u0fiuhSeVWzWrqxh
    BH5fABJ8aTN6D2Z61gJ5HM401Y+Azdh2R5b/GQx6fXsg+GzBY7kgQcPb95pJ6htKAZyq
    xWwUv3MurZZwcOpmErASNJYuf4ITZ7fLljVVvLrktI4qDWTBKCBVU5FMhj1npV5Lo2Ct
    cdMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678119250;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=E5MgXFLGzXqV3kZmdi0um2+BJZgLBqfV9CY4BZsWLcI=;
    b=YGr2At5ociglkixjIGpZr9H4tKF7PQcOrsKysdzF+u/wz1H/1QQdImdpI/nwF8IQyT
    9X2m4U8BHBwnk32YdA3JkmI3bh3/j19WQi2Y57lFWupj0lrFnMdDR8u4AsabVWr3Ia4Q
    Ie6GkaXJ4yfzpId/2FbxeY1S28SWKI/DPuQxlxclOapv9oDISyTmEO9Ax4/QBvgQbIgJ
    1eN65wualCMaDkLWDd3ZT2wA9zfK77e7H1l5HIl089k9vbv4n69knWXQSUpicJ2JMnhO
    z1dZsZpbpPIPDLVAvWjsTMldwIfZ+mnCS6RB/LDLea6t9Y4YNZGnd76Nllk90OTRSSbi
    Qq6A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjXrKw8/qY="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id jba5bez26GE9Jsp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 6 Mar 2023 17:14:09 +0100 (CET)
Date:   Mon, 6 Mar 2023 17:14:08 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v7 5/5] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Message-ID: <ZAYRUIg0SwKOnBGx@gerhold.net>
References: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
 <20230223153655.262783-6-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223153655.262783-6-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 03:36:55PM +0000, Bryan O'Donoghue wrote:
> Add a basic booting DTS for the Sony Xperia M4 Aqua aka "tulip".
> 
> Tulip is paired with:
> 
> - wcn3660
> - smb1360 battery charger
> - 720p Truly NT35521 Panel
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../qcom/msm8939-sony-xperia-kanuti-tulip.dts | 457 ++++++++++++++++++
>  2 files changed, 458 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2983e83a19061..81a38d46deba5 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> new file mode 100644
> index 0000000000000..c646fada11a5a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> @@ -0,0 +1,457 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2023, Bryan O'Donoghue.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8939.dtsi"
> +#include "msm8939-pm8916.dtsi"
> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +/ {
> +	model = "Sony Xperia M4 Aqua";
> +	compatible = "sony,kanuti-tulip", "qcom,msm8939";
> +
> +	qcom,board-id = <8 0>;

Could use QCOM_BOARD_ID_MTP instead of 8 for more clarity here.

> [...]
> +&dsi0 {
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "sony,tulip-truly-nt35521";
> +		reg = <0>;
> +		positive5-supply = <&vreg_positive5_reg>;
> +		negative5-supply = <&vreg_negative5_reg>;
> +		reset-gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
> +		enable-gpios = <&tlmm 10 GPIO_ACTIVE_LOW>;

Have you tested this? While this matches the (likely incorrect)
bindings, as far as I can tell the Linux tulip-truly-nt35521 driver
wants "backlight-gpios" instead of "enable-gpios". And it's not an
optional GPIO so I don't quite understand how the existing driver could
probe successfully with what you have here.

> +
> +		ports {
> +			port {
> +				panel_in: endpoint {
> +					remote-endpoint = <&dsi0_out>;
> +				};
> +			};
> +		};
> +
> +	};
> +};
> +
> [...]
> +&tlmm {
> +	ak8963_default: ak8963-default-state {
> +		pins = "gpio69";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <6>;
> +	};
> +
> +	ak8963_sleep: ak8963-sleep-state {
> +		pins = "gpio69";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +
> +	/* Ambient light and proximity sensor apds9930 and apds9900 */
> +	apds99xx_default: apds99xx-default-state {
> +		pins = "gpio113";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <6>;
> +	};
> +
> +	apds99xx_sleep: apds99xx-sleep-state {
> +		pins = "gpio113";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +
> +	cam_sensor_flash_default: cam-sensor-flash-default-state {
> +		pins = "gpio98", "gpio97";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +
> +	cci1_default: cci1-default-state {
> +		pins = "gpio31", "gpio32";
> +		function = "cci_i2c";
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +
> +	cdc_ext_spk_pa_active: cdc-ext-spk-pa-on-state {
> +		pins = "gpio0";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		output-low;
> +	};
> +
> +	cdc_ext_spk_pa_sus: cdc-ext-spk-pa-off-state {
> +		pins = "gpio0";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +
> +	cdc_slim_lines_act: lines-on-state {
> +		pins = "gpio63";
> +		function = "cdc_pdm0";
> +		drive-strength = <8>;
> +		output-high;
> +	};
> +
> +	cdc_slim_lines_sus: lines-off-state {
> +		pins = "gpio63";
> +		function = "cdc_pdm0";
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +
> +	cross_conn_det_act: lines-on-state {
> +		pins = "gpio120";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <8>;
> +		output-low;
> +	};
> +
> +	cross_conn_det_sus: lines-off-state {
> +		pins = "gpio120";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +
> +	ext_buck_vsel: vsel0-state {
> +		pins = "gpio111";
> +		function = "gpio";
> +		drive-strength = <2>;
> +	};
> +
> +	ext_cdc_tlmm_lines_act: tlmm-lines-on-state {
> +		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <8>;
> +	};
> +
> +	ext_cdc_tlmm_lines_sus: tlmm-lines-off-state {
> +		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +
> +	gpio_key_suspend: gpio-key-suspend-state {
> +		pins = "gpio107", "gpio108", "gpio109";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <2>;
> +	};
> +
> +	negative5_reg_default: negative5-reg-default-state {
> +		pins = "gpio17";
> +		function = "gpio";
> +		output-low;
> +	};
> +
> +	positive5_reg_default: positive5-reg-default-state {
> +		pins = "gpio114";
> +		function = "gpio";
> +		output-low;
> +	};
> +
> +	/* Gyroscope and accelerometer sensor combo */
> +	mpu6050_default: mpu6050-default-state {
> +		pins = "gpio115";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <6>;
> +	};
> +
> +	mpu6050_sleep: mpu6050-sleep-state {
> +		pins = "gpio115";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +
> +	nfc_disable_active: nfc-disable-active-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <6>;
> +	};
> +
> +	nfc_disable_suspend: nfc-disable-suspend-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <6>;
> +	};
> +
> +	nfc_int_active: nfc-int-active-state {
> +		pins = "gpio21";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <6>;
> +	};
> +
> +	nfc_int_suspend: nfc-int-suspend-state {
> +		pins = "gpio21";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <6>;
> +	};
> +
> +	nt35521_te_default: nt35521-te-default-state {
> +		pins = "gpio24";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <6>;
> +	};
> +
> +	nt35521_backlight: nt35521-backlight-default-state {
> +		pins = "gpio10";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <6>;
> +	};
> +
> +	smb_int: smb-int-default-state {
> +		pins = "gpio62";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <2>;
> +	};
> +
> +	ts_int_active: ts-int-active-state {
> +		pins = "gpio13";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <16>;
> +	};
> +
> +	ts_int_suspend: ts-int-suspend-state {
> +		pins = "gpio13";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +
> +	ts_reset_active: ts-reset-active-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <16>;
> +	};
> +
> +	ts_reset_suspend: ts-reset-suspend-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +
> +	ts_release: ts-release-default-state {
> +		pins = "gpio13", "gpio12";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +

There are *a lot* of unused pinctrl entries here. If you don't reference
them anywhere (by referencing them via label) they just waste space in
the device tree. The GPIOs will still remain unconfigured.

Please save them locally for later usage and only keep the used entries.
This will ease review of upcoming patches since these are better
understandable together with the actual device node making use of them.

Thanks,
Stephan
