Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4276AD314
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCFX6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCFX6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:58:23 -0500
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720113C08
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:58:20 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id c4170a49-bc7a-11ed-a9de-005056bdf889;
        Tue, 07 Mar 2023 01:58:18 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 7 Mar 2023 01:58:17 +0200
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
Subject: Re: [PATCH V8 4/7] pinctrl: qcom: Add IPQ9574 pinctrl driver
Message-ID: <ZAZ+GeGu8mW1XqpG@surfacebook>
References: <20230214163116.9924-1-quic_devipriy@quicinc.com>
 <20230214163116.9924-5-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214163116.9924-5-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Feb 14, 2023 at 10:01:13PM +0530, Devi Priya kirjoitti:
> Add pinctrl definitions for the TLMM of IPQ9574

...

> +	depends on OF

No compile test on non-OF configurations?

> +	depends on ARM64 || COMPILE_TEST

...

> +#define FUNCTION(fname)			                \

PINCTRL_PINFUNCTION() ?

> +	[msm_mux_##fname] = {		                \
> +		.name = #fname,				\
> +		.groups = fname##_groups,               \
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}

...

> +#define REG_SIZE 0x1000
> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
> +	{					        \
> +		.name = "gpio" #id,			\
> +		.pins = gpio##id##_pins,		\
> +		.npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),	\

Can you embed struct pingroup?

> +		.funcs = (int[]){			\
> +			msm_mux_gpio, /* gpio mode */	\
> +			msm_mux_##f1,			\
> +			msm_mux_##f2,			\
> +			msm_mux_##f3,			\
> +			msm_mux_##f4,			\
> +			msm_mux_##f5,			\
> +			msm_mux_##f6,			\
> +			msm_mux_##f7,			\
> +			msm_mux_##f8,			\
> +			msm_mux_##f9			\
> +		},				        \
> +		.nfuncs = 10,				\
> +		.ctl_reg = REG_SIZE * id,			\
> +		.io_reg = 0x4 + REG_SIZE * id,		\
> +		.intr_cfg_reg = 0x8 + REG_SIZE * id,		\
> +		.intr_status_reg = 0xc + REG_SIZE * id,	\
> +		.intr_target_reg = 0x8 + REG_SIZE * id,	\
> +		.mux_bit = 2,			\
> +		.pull_bit = 0,			\
> +		.drv_bit = 6,			\
> +		.oe_bit = 9,			\
> +		.in_bit = 0,			\
> +		.out_bit = 1,			\
> +		.intr_enable_bit = 0,		\
> +		.intr_status_bit = 0,		\
> +		.intr_target_bit = 5,		\
> +		.intr_target_kpss_val = 3,	\
> +		.intr_raw_status_bit = 4,	\
> +		.intr_polarity_bit = 1,		\
> +		.intr_detection_bit = 2,	\
> +		.intr_detection_width = 2,	\
> +	}

...

> +	PINGROUP(62, blsp1_spi, audio_sec, audio_pdm1, audio_sec, pta, prng_rosc2, gcc_plltest,
> +		 _, _),

Can be one line.

...

> +static const struct of_device_id ipq9574_pinctrl_of_match[] = {
> +	{ .compatible = "qcom,ipq9574-tlmm", },

> +	{ },

No comma for terminator line.

> +};

No MODULE_DEVICE_TABLE()?

-- 
With Best Regards,
Andy Shevchenko


