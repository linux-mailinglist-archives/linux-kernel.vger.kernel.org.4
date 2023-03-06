Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972276AC5DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCFPsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCFPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:47:59 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003B1CF52;
        Mon,  6 Mar 2023 07:47:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678117661; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OpO31gyeAiyfGj7Qq0n9i+LLyix+4Fz8YP+IIprBlVCVH535SVSp58mNFLYTzDnGsx
    dzpLfYv09VS/E+OMpg5hOcRlp6rIxGgkO6h7mDVkYWmhRcbI5c7AwFanoeNBAibdejan
    1GBYqkyUU21mW6F1tApVmLZ/5nhwP9KMdlE2a/JQSnfdB3yTP593hvGo1wpmHtS+Bwt7
    xq+hBuvZ9MSmGNbkVM4ywN1ToSqWXcT//tq4lXdeEVmt68Hx6rPdTsCkGMVzrXICB01l
    kI/cZfXfGyu973rP8M36ta9R/9yD1UReZadRhcFAd9XQbh2JpyT82cao0QNUeuBNO+WA
    J3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678117661;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KmIA5wadD9AJClhPdtpitOvaCeW1sQ+zwa4MQNlW01E=;
    b=dlV0ArgL82FH0c8qaZ+Mn/DPje+7T1ZRC02tU2D1L4gZupuHjT5OPXaPIVtdAf4KXu
    q2atHQolU4BcNo4uPylfpMvJiAXiEetKvxYL5WX4fCGMAAw3pb2rW1FUFXVHlxvB6aDj
    +i9DUFmZV4uOXBnUfKdWsnrs6gaVqyGn3n6j+V5BggeCPk0A8wb/THj5te/W0ZKxZLmQ
    gu0tMe2AhfFd2S7nAU3k5JWtlXQv2TNNBYoXQlA4eYBk7bOYDuMrioUsPDrVw+ofckgG
    Rg/i5CEm+mVuli9OPML5PjEIFdQnOUFdYbX9MQbP1ZwjoawGsYpQa23wQ95YLMOLQZhG
    LK8A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678117660;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KmIA5wadD9AJClhPdtpitOvaCeW1sQ+zwa4MQNlW01E=;
    b=XAeZ5UtgcmAvDnW/RhUyFSm1QUBZFPE1cGODH42NTTZrh0HY8BK8kiUehgmz6TetjV
    UDNDphTOYFM7x41wyZEl16JlR9xu+pASMYGQ8RjuzNArfiMkh1KL/86CphLE94+1Utjm
    gYJYxoRYrV/TVNqs8ljY0cAZVHolcoYfhbXDkqqPdd7mkokchuZcYphxajvZpUSRXqc/
    eBi4t3+L7JNps/fA2luQMPhCyIcpd5QMgatFaLTGBvPLiJM5wATzzIF2gHk9/ITLPIir
    Ov9jEEzjtaZq+538ctKhI0MCrCSSJCch0krgLxQyp5w5LYfmvY95thaNaCSsRvNr730V
    Z6rg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjXrKw8/qY="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id jba5bez26FleJnt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 6 Mar 2023 16:47:40 +0100 (CET)
Date:   Mon, 6 Mar 2023 16:47:39 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
Subject: Re: [PATCH v7 4/5] arm64: dts: qcom: Add Square apq8039-t2 board
Message-ID: <ZAYLG7JkcIHQeVcz@gerhold.net>
References: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
 <20230223153655.262783-5-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223153655.262783-5-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 03:36:54PM +0000, Bryan O'Donoghue wrote:
> The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
> chipset.
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> Co-developed-by: James Willcox <jwillcox@squareup.com>
> Signed-off-by: James Willcox <jwillcox@squareup.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Co-developed-by: Joseph Gates <jgates@squareup.com>
> Signed-off-by: Joseph Gates <jgates@squareup.com>
> Co-developed-by: Max Chen <mchen@squareup.com>
> Signed-off-by: Max Chen <mchen@squareup.com>
> Co-developed-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Zac Crosby <zac@squareup.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/apq8039-t2.dts | 550 ++++++++++++++++++++++++
>  2 files changed, 551 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 31aa54f0428c3..2983e83a19061 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> new file mode 100644
> index 0000000000000..6ff044bfe2ebc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> @@ -0,0 +1,550 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2023, Linaro Ltd.
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
> +#include <dt-bindings/sound/apq8016-lpass.h>
> +
> +/ {
> +	model = "Square, Inc. T2 Devkit";
> +	compatible = "square,apq8039-t2", "qcom,msm8939";
> +
> +	qcom,board-id = <0x53 0x54>;
> +	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>, <QCOM_ID_APQ8039 0x30000>;

Does the board have variants with MSM8939 v2, MSM8939 v3.0 and APQ8039
v3.0? If not it should be enough to list only a single item (the actual
SoC in use).

> [...]
> +&blsp1_uart1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&blsp1_uart1_default>;
> +	pinctrl-1 = <&blsp1_uart1_sleep>;
> +	status = "okay";
> +};
> +
> +&blsp1_uart2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&blsp1_uart2_default>;
> +	pinctrl-1 = <&blsp1_uart2_sleep>;

This is in msm8939.dtsi already.

> [...]
> +&pronto {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wcnss_pin_a>;

This is also in msm8939.dtsi already.

> +	status = "okay";
> +
> +	iris {
> +		compatible = "qcom,wcn3680";
> +	};
> +};
> +
> [...]
> +	blsp1_uart1_default: blsp1-uart1-default-state {
> +		pins = "gpio0", "gpio1";
> +		function = "blsp_uart1";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
> +		pins = "gpio0", "gpio1";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};

Personally I'd override just the pins of the definition in msm8939.dtsi
since everything else is exactly the same. Not a strict change request
though, I guess this is subjective:

&blsp1_uart1_default {
	pins = "gpio0", "gpio1";
};

&blsp1_uart1_sleep {
	pins = "gpio0", "gpio1";
};

> +
> +	ext_buck_vsel_reg: ext-buck-vsel-reg-state {
> +		function = "gpio";
> +		pins = "gpio111";
> +		drive-strength = <2>;
> +	};

This seems unused.

> [...]
> +	sq_spe_enable: sq-spe-enable-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		output-low;
> +	};

This seems unused as well.

> +
> +	tlmm_crq_reg: tlmm-crq-reg-state {
> +		function = "gpio";
> +		pins = "gpio12";
> +		output-high;
> +	};
> +
> +	tlmm_spe_reg: tlmm-spe-reg-state {
> +		pins = "gpio108";
> +		function = "gpio";
> +		output-high;
> +	};
> +

Does output-high really make sense here? These are assigned to a
regulator-fixed. The driver for fixed regulators initializes the
GPIO state based on the "regulator-boot-on" property. If the property
exists it does gpiod_get(... GPIOD_OUT_HIGH), otherwise GPIOD_OUT_LOW.

You don't have regulator-boot-on. So I would expect the GPIO/regulator
state to toggle unnecessarily during initialization:

  - First pinctrl is applied so the GPIO is set to output-high.
    The regulator gets turned on for a few ms/ns.
  - Then the driver probes which initializes it to GPIOD_OUT_LOW.
    The regulator turns back off.

I'd just drop the output-high here and leave it up to the regulator
driver to initialize the GPIO state. If you want the regulator on during
boot, use regulator-boot-on.

Thanks,
Stephan
