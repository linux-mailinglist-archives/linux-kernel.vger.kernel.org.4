Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBB5B7F13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiINCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:39:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239D6AA26;
        Tue, 13 Sep 2022 19:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9422DB81018;
        Wed, 14 Sep 2022 02:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CB8C433D6;
        Wed, 14 Sep 2022 02:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663123143;
        bh=CwjA5cCb7upzhqgNOUxSAJq8hrwVIu6949lkXh/Lwok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpNvdY5Pt5oMauEP0a5o4ILOSRhvFqLe8AlBXIj0jFZR1DSxsjy2aTQJodjoJw6Fw
         o6HLaQRVy6z3o5ZTKLjkNKVexY9fwhjSN6VdnmQi1X6UWvnYcirP81Q7ekSjo+0SC4
         KBJFwjb5oAR/oLQq3vaUnkHgT5/RSGLEjV6zgEVc01w/RneZK4q4qASGG7iY1HtQZv
         uAGTxfHDH8rSYEVngy9VzOkv+Xw+YWdWYYr8uMAp+klXnXa4sHwoV6NMW+m5/wamei
         6B5WiTxUZ1EOssZfvZSMv5boCiC4w3TUfbD6IvcMnXv8gs7bx2eqRt1/0+1WqTMA9f
         vZxqTIrbsFPuA==
Date:   Tue, 13 Sep 2022 21:39:00 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] pinctrl: qcom: add sdm670 pinctrl
Message-ID: <20220914023900.z64wugbq7p2gfb32@builder.lan>
References: <20220914014404.199505-1-mailingradian@gmail.com>
 <20220914014404.199505-3-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914014404.199505-3-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 09:44:04PM -0400, Richard Acayan wrote:
> The Snapdragon 670 has a Top-Level Mode Multiplexer (TLMM) for various
> features. Add a driver to support it.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/pinctrl/qcom/Kconfig          |    9 +
>  drivers/pinctrl/qcom/Makefile         |    1 +
>  drivers/pinctrl/qcom/pinctrl-sdm670.c | 1368 +++++++++++++++++++++++++
>  3 files changed, 1378 insertions(+)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 2961b5eb8e10..7aba4188110c 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -283,6 +283,15 @@ config PINCTRL_SDM660
>  	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
>  	 Technologies Inc SDM660 platform.
>  
> +config PINCTRL_SDM670
> +	tristate "Qualcomm Technologies Inc SDM670 pin controller driver"
> +	depends on (OF || ACPI)

I believe you can drop ACPI from this?

> +	depends on PINCTRL_MSM
> +	help
> +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	 Technologies Inc SDM670 platform.
> +
>  config PINCTRL_SDM845
>  	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
>  	depends on (OF || ACPI)
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 8269a1db8794..a5c40f552e5c 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_PINCTRL_SC7280_LPASS_LPI) += pinctrl-sc7280-lpass-lpi.o
>  obj-$(CONFIG_PINCTRL_SC8180X)	+= pinctrl-sc8180x.o
>  obj-$(CONFIG_PINCTRL_SC8280XP)	+= pinctrl-sc8280xp.o
>  obj-$(CONFIG_PINCTRL_SDM660)   += pinctrl-sdm660.o
> +obj-$(CONFIG_PINCTRL_SDM670) += pinctrl-sdm670.o
>  obj-$(CONFIG_PINCTRL_SDM845) += pinctrl-sdm845.o
>  obj-$(CONFIG_PINCTRL_SDX55) += pinctrl-sdx55.o
>  obj-$(CONFIG_PINCTRL_SM6115) += pinctrl-sm6115.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm670.c b/drivers/pinctrl/qcom/pinctrl-sdm670.c
> new file mode 100644
> index 000000000000..2cc6da89b342
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm670.c
> @@ -0,0 +1,1368 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Richard Acayan. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-msm.h"
> +
> +#define FUNCTION(fname)					\
> +	[msm_mux_##fname] = {				\
> +		.name = #fname,				\
> +		.groups = fname##_groups,		\
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +#define NORTH	0x00500000
> +#define SOUTH	0x00900000
> +#define WEST	0x00100000
> +
> +#define REG_SIZE 0x1000
> +#define PINGROUP(id, base, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
> +	{						\
> +		.name = "gpio" #id,			\
> +		.pins = gpio##id##_pins,		\
> +		.npins = ARRAY_SIZE(gpio##id##_pins),	\
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
> +		},					\
> +		.nfuncs = 10,				\
> +		.ctl_reg = base + REG_SIZE * id,		\
> +		.io_reg = base + 0x4 + REG_SIZE * id,		\
> +		.intr_cfg_reg = base + 0x8 + REG_SIZE * id,	\
> +		.intr_status_reg = base + 0xc + REG_SIZE * id,	\
> +		.intr_target_reg = base + 0x8 + REG_SIZE * id,	\
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
> +
> +/*
> + * A dummy pingroup is a pin group that cannot be assigned a function and has
> + * no registers to control or monitor it.
> + */
> +#define PINGROUP_DUMMY(id)				\

This isn't overly pretty, but I don't have a better suggestion for
describing holes in the gpio range.

> +	{						\
> +		.name = "gpio" #id,			\
> +		.pins = gpio##id##_pins,		\
> +		.npins = ARRAY_SIZE(gpio##id##_pins),	\
> +		.ctl_reg = 0,				\
> +		.io_reg = 0,				\
> +		.intr_cfg_reg = 0,			\
> +		.intr_status_reg = 0,			\
> +		.intr_target_reg = 0,			\
> +		.mux_bit = -1,				\
> +		.pull_bit = -1,				\
> +		.drv_bit = -1,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = -1,				\
> +		.intr_enable_bit = -1,			\
> +		.intr_status_bit = -1,			\
> +		.intr_target_bit = -1,			\
> +		.intr_raw_status_bit = -1,		\
> +		.intr_polarity_bit = -1,		\
> +		.intr_detection_bit = -1,		\
> +		.intr_detection_width = -1,		\
> +	}
[..]
> +/* Every pin is maintained as a single group, and missing or non-existing pin
> + * would be maintained as dummy group to synchronize pin group index with
> + * pin descriptor registered with pinctrl core.
> + * Clients would not be able to request these dummy pin groups.

The client wouldn't be able to define pinmux/pinconf, but I'm not able
to spot anything that would prevent a client from referencing the gpio?

Perhaps I'm missing something?

Otherwise, I think you should be able to specify reserved_gpios in
sdm670_pinctrl and list the dummy items. This would ensure that the gpio
code as well treat them as absent.

> + */
> +static const struct msm_pingroup sdm670_groups[] = {
> +	PINGROUP(0, SOUTH, qup0, _, _, _, _, _, _, _, _),
> +	PINGROUP(1, SOUTH, qup0, _, _, _, _, _, _, _, _),
> +	PINGROUP(2, SOUTH, qup0, _, _, _, _, _, _, _, _),
> +	PINGROUP(3, SOUTH, qup0, _, _, _, _, _, _, _, _),
> +	PINGROUP(4, NORTH, qup9, qdss_cti, _, _, _, _, _, _, _),
> +	PINGROUP(5, NORTH, qup9, qdss_cti, _, _, _, _, _, _, _),
> +	PINGROUP(6, NORTH, qup9, _, ddr_pxi0, _, _, _, _, _, _),
> +	PINGROUP(7, NORTH, qup9, ddr_bist, _, atest_tsens2, vsense_trigger,
> +		 atest_usb1, ddr_pxi0, _, _),

Please unwrap all these lines, it's easier to read that way.

> +	PINGROUP(8, WEST, qup_l4, gp_pdm1, ddr_bist, _, _, _, _, _, _),
> +	PINGROUP(9, WEST, qup_l5, ddr_bist, _, _, _, _, _, _, _),
> +	PINGROUP(10, NORTH, mdp_vsync, qup_l6, ddr_bist, wlan2_adc1,
> +		 atest_usb11, ddr_pxi2, _, _, _),
> +	PINGROUP(11, NORTH, mdp_vsync, edp_lcd, dbg_out, wlan2_adc0,
> +		 atest_usb10, ddr_pxi2, _, _, _),
> +	PINGROUP(12, SOUTH, mdp_vsync, m_voc, tsif1_sync, ddr_pxi3, _, _, _, _,
> +		 _),
> +	PINGROUP(13, WEST, cam_mclk, pll_bypassnl, qdss, ddr_pxi3, _, _, _, _,
> +		 _),
> +	PINGROUP(14, WEST, cam_mclk, pll_reset, qdss, _, _, _, _, _, _),
> +	PINGROUP(15, WEST, cam_mclk, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(16, WEST, cam_mclk, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(17, WEST, cci_i2c, qup1, qdss, _, _, _, _, _, _),
> +	PINGROUP(18, WEST, cci_i2c, qup1, _, qdss, _, _, _, _, _),
> +	PINGROUP(19, WEST, cci_i2c, qup1, _, qdss, _, _, _, _, _),
> +	PINGROUP(20, WEST, cci_i2c, qup1, _, qdss, _, _, _, _, _),
> +	PINGROUP(21, WEST, cci_timer0, gcc_gp2, qdss, _, _, _, _, _, _),
> +	PINGROUP(22, WEST, cci_timer1, gcc_gp3, qdss, _, _, _, _, _, _),
> +	PINGROUP(23, WEST, cci_timer2, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(24, WEST, cci_timer3, cci_async, qdss, _, _, _, _, _, _),
> +	PINGROUP(25, WEST, cci_timer4, cci_async, qdss, _, _, _, _, _, _),
> +	PINGROUP(26, WEST, cci_async, qdss, jitter_bist, _, _, _, _, _, _),
> +	PINGROUP(27, WEST, qup2, qdss, pll_bist, _, _, _, _, _, _),
> +	PINGROUP(28, WEST, qup2, qdss, agera_pll, _, _, _, _, _, _),
> +	PINGROUP(29, WEST, qup2, _, phase_flag, qdss, atest_tsens, _, _, _, _),
> +	PINGROUP(30, WEST, qup2, phase_flag, qdss, _, _, _, _, _, _),
> +	PINGROUP(31, WEST, qup11, qup14, _, _, _, _, _, _, _),
> +	PINGROUP(32, WEST, qup11, qup14, _, _, _, _, _, _, _),
> +	PINGROUP(33, WEST, qup11, qup14, _, _, _, _, _, _, _),
> +	PINGROUP(34, WEST, qup11, qup14, _, _, _, _, _, _, _),
> +	PINGROUP(35, NORTH, pci_e0, qup_l4, jitter_bist, _, _, _, _, _, _),
> +	PINGROUP(36, NORTH, pci_e0, qup_l5, pll_bist, _, _, _, _, _, _),
> +	PINGROUP(37, NORTH, qup_l6, agera_pll, _, _, _, _, _, _, _),
> +	PINGROUP(38, NORTH, usb_phy, _, _, _, _, _, _, _, _),
> +	PINGROUP(39, NORTH, lpass_slimbus, _, _, _, _, _, _, _, _),
> +	PINGROUP(40, NORTH, sd_write, tsif1_error, _, _, _, _, _, _, _),
> +	PINGROUP(41, SOUTH, qup3, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(42, SOUTH, qup3, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(43, SOUTH, qup3, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(44, SOUTH, qup3, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(45, SOUTH, qup6, _, _, _, _, _, _, _, _),
> +	PINGROUP(46, SOUTH, qup6, _, _, _, _, _, _, _, _),
> +	PINGROUP(47, SOUTH, qup6, _, _, _, _, _, _, _, _),
> +	PINGROUP(48, SOUTH, qup6, _, _, _, _, _, _, _, _),
> +	PINGROUP(49, NORTH, qup12, _, _, _, _, _, _, _, _),
> +	PINGROUP(50, NORTH, qup12, _, _, _, _, _, _, _, _),
> +	PINGROUP(51, NORTH, qup12, qdss_cti, _, _, _, _, _, _, _),
> +	PINGROUP(52, NORTH, qup12, phase_flag, qdss_cti, _, _, _, _, _, _),
> +	PINGROUP(53, NORTH, qup10, phase_flag, _, _, _, _, _, _, _),
> +	PINGROUP(54, NORTH, qup10, gp_pdm0, phase_flag, _, wlan1_adc1,
> +		 atest_usb13, ddr_pxi1, _, _),
> +	PINGROUP(55, NORTH, qup10, phase_flag, _, wlan1_adc0, atest_usb12,
> +		 ddr_pxi1, _, _, _),
> +	PINGROUP(56, NORTH, qup10, phase_flag, _, _, _, _, _, _, _),
> +	PINGROUP(57, NORTH, qua_mi2s, gcc_gp1, phase_flag, _, _, _, _, _, _),
> +	PINGROUP_DUMMY(58),
> +	PINGROUP_DUMMY(59),
> +	PINGROUP_DUMMY(60),
> +	PINGROUP_DUMMY(61),
> +	PINGROUP_DUMMY(62),
> +	PINGROUP_DUMMY(63),
> +	PINGROUP_DUMMY(64),
> +	PINGROUP(65, NORTH, pri_mi2s, qup8, wsa_clk, _, _, _, _, _, _),
> +	PINGROUP(66, NORTH, pri_mi2s_ws, qup8, wsa_data, gp_pdm1, _, _, _, _,
> +		 _),
> +	PINGROUP(67, NORTH, pri_mi2s, qup8, _, atest_usb2, _, _, _, _, _),
> +	PINGROUP(68, NORTH, pri_mi2s, qup8, _, atest_usb23, _, _, _, _, _),
> +	PINGROUP_DUMMY(69),
> +	PINGROUP_DUMMY(70),
> +	PINGROUP_DUMMY(71),
> +	PINGROUP_DUMMY(72),
> +	PINGROUP_DUMMY(73),
> +	PINGROUP_DUMMY(74),
> +	PINGROUP(75, NORTH, ter_mi2s, phase_flag, qdss, atest_usb22, qup_l4, _,
> +		 _, _, _),
> +	PINGROUP(76, NORTH, ter_mi2s, phase_flag, qdss, atest_usb21, qup_l5, _,
> +		 _, _, _),
> +	PINGROUP(77, NORTH, ter_mi2s, phase_flag, qdss, atest_usb20, qup_l6, _,
> +		 _, _, _),
> +	PINGROUP(78, NORTH, ter_mi2s, gcc_gp1, _, _, _, _, _, _, _),
> +	PINGROUP(79, NORTH, sec_mi2s, gp_pdm2, _, qdss, _, _, _, _, _),
> +	PINGROUP(80, NORTH, sec_mi2s, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(81, NORTH, sec_mi2s, qup15, _, _, _, _, _, _, _),
> +	PINGROUP(82, NORTH, sec_mi2s, qup15, _, _, _, _, _, _, _),
> +	PINGROUP(83, NORTH, sec_mi2s, qup15, _, _, _, _, _, _, _),
> +	PINGROUP(84, NORTH, qup15, _, _, _, _, _, _, _, _),
> +	PINGROUP(85, SOUTH, qup5, _, _, _, _, _, _, _, _),
> +	PINGROUP(86, SOUTH, qup5, copy_gp, _, _, _, _, _, _, _),
> +	PINGROUP(87, SOUTH, qup5, _, _, _, _, _, _, _, _),
> +	PINGROUP(88, SOUTH, qup5, _, _, _, _, _, _, _, _),
> +	PINGROUP(89, SOUTH, tsif1_clk, qup4, tgu_ch3, phase_flag, _, _, _, _,
> +		 _),
> +	PINGROUP(90, SOUTH, tsif1_en, mdp_vsync0, qup4, mdp_vsync1, mdp_vsync2,
> +		 mdp_vsync3, tgu_ch0, phase_flag, qdss_cti),
> +	PINGROUP(91, SOUTH, tsif1_data, sdc4_cmd, qup4, tgu_ch1, _, qdss_cti,
> +		 _, _, _),
> +	PINGROUP(92, SOUTH, tsif2_error, sdc4_data, qup4, vfr_1, tgu_ch2, _, _, _,
> +		 _),
> +	PINGROUP(93, SOUTH, tsif2_clk, sdc4_clk, qup7, _, qdss, _, _, _, _),
> +	PINGROUP(94, SOUTH, tsif2_en, sdc4_data, qup7, _, _, _, _, _, _),
> +	PINGROUP(95, SOUTH, tsif2_data, sdc4_data, qup7, gp_pdm0, _, _, _, _, _),
> +	PINGROUP(96, SOUTH, tsif2_sync, sdc4_data, qup7, phase_flag, _, _, _, _,
> +		 _),
> +	PINGROUP(97, WEST, _, _, mdp_vsync, ldo_en, _, _, _, _, _),
> +	PINGROUP(98, WEST, _, mdp_vsync, ldo_update, _, _, _, _, _, _),
> +	PINGROUP(99, NORTH, phase_flag, prng_rosc, _, _, _, _, _, _, _),
> +	PINGROUP(100, WEST, phase_flag, _, _, _, _, _, _, _, _),
> +	PINGROUP(101, WEST, _, phase_flag, _, _, _, _, _, _, _),
> +	PINGROUP(102, WEST, pci_e1, prng_rosc, _, _, _, _, _, _, _),
> +	PINGROUP(103, WEST, pci_e1, copy_phase, _, _, _, _, _, _, _),
> +	PINGROUP_DUMMY(104),
> +	PINGROUP(105, NORTH, uim2_data, qup13, qup_l4, _, _, _, _, _, _),
> +	PINGROUP(106, NORTH, uim2_clk, qup13, qup_l5, _, _, _, _, _, _),
> +	PINGROUP(107, NORTH, uim2_reset, qup13, qup_l6, _, _, _, _, _, _),
> +	PINGROUP(108, NORTH, uim2_present, qup13, _, _, _, _, _, _, _),
> +	PINGROUP(109, NORTH, uim1_data, _, _, _, _, _, _, _, _),
> +	PINGROUP(110, NORTH, uim1_clk, _, _, _, _, _, _, _, _),
> +	PINGROUP(111, NORTH, uim1_reset, _, _, _, _, _, _, _, _),
> +	PINGROUP(112, NORTH, uim1_present, _, _, _, _, _, _, _, _),
> +	PINGROUP(113, NORTH, uim_batt, edp_hot, _, _, _, _, _, _, _),
> +	PINGROUP(114, WEST, _, nav_pps, nav_pps, gps_tx, _, _, _, _, _),
> +	PINGROUP(115, WEST, _, nav_pps, nav_pps, gps_tx, _, _, _, _, _),
> +	PINGROUP(116, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(117, NORTH, _, qdss, atest_char, _, _, _, _, _, _),
> +	PINGROUP(118, NORTH, adsp_ext, _, qdss, atest_char, _, _, _, _, _),
> +	PINGROUP(119, NORTH, _, qdss, atest_char, _, _, _, _, _, _),
> +	PINGROUP(120, NORTH, _, qdss, atest_char, _, _, _, _, _, _),
> +	PINGROUP(121, NORTH, _, qdss, atest_char, _, _, _, _, _, _),
> +	PINGROUP(122, NORTH, _, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(123, NORTH, qup_l4, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(124, NORTH, qup_l5, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(125, NORTH, qup_l6, _, _, _, _, _, _, _, _),
> +	PINGROUP(126, NORTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(127, WEST, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(128, WEST, nav_pps, nav_pps, gps_tx, _, _, _, _, _, _),
> +	PINGROUP(129, WEST, nav_pps, nav_pps, gps_tx, _, _, _, _, _, _),
> +	PINGROUP(130, WEST, qlink_request, _, _, _, _, _, _, _, _),
> +	PINGROUP(131, WEST, qlink_enable, _, _, _, _, _, _, _, _),
> +	PINGROUP(132, WEST, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(133, NORTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(134, NORTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(135, WEST, _, pa_indicator, _, _, _, _, _, _, _),
> +	PINGROUP(136, WEST, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(137, WEST, _, _, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(138, WEST, _, _, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(139, WEST, _, phase_flag, _, _, _, _, _, _, _),
> +	PINGROUP(140, WEST, _, _, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(141, WEST, _, phase_flag, _, _, _, _, _, _, _),
> +	PINGROUP(142, WEST, _, phase_flag, _, _, _, _, _, _, _),
> +	PINGROUP(143, WEST, _, nav_pps, nav_pps, gps_tx, phase_flag, _, _, _,
> +		 _),
> +	PINGROUP(144, SOUTH, mss_lte, _, _, _, _, _, _, _, _),
> +	PINGROUP(145, SOUTH, mss_lte, gps_tx, _, _, _, _, _, _, _),
> +	PINGROUP(146, WEST, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(147, WEST, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(148, WEST, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(149, WEST, _, _, _, _, _, _, _, _, _),
> +	UFS_RESET(ufs_reset, 0x99d000),
> +	SDC_QDSD_PINGROUP(sdc1_rclk, 0x99000, 15, 0),
> +	SDC_QDSD_PINGROUP(sdc1_clk, 0x99000, 13, 6),
> +	SDC_QDSD_PINGROUP(sdc1_cmd, 0x99000, 11, 3),
> +	SDC_QDSD_PINGROUP(sdc1_data, 0x99000, 9, 0),
> +	SDC_QDSD_PINGROUP(sdc2_clk, 0x9a000, 14, 6),
> +	SDC_QDSD_PINGROUP(sdc2_cmd, 0x9a000, 11, 3),
> +	SDC_QDSD_PINGROUP(sdc2_data, 0x9a000, 9, 0),
> +};
> +
> +static const struct msm_pinctrl_soc_data sdm670_pinctrl = {
> +	.pins = sdm670_pins,
> +	.npins = ARRAY_SIZE(sdm670_pins),
> +	.functions = sdm670_functions,
> +	.nfunctions = ARRAY_SIZE(sdm670_functions),
> +	.groups = sdm670_groups,
> +	.ngroups = ARRAY_SIZE(sdm670_groups),
> +	.ngpios = 151,
> +};
> +
> +static int sdm670_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return msm_pinctrl_probe(pdev, &sdm670_pinctrl);
> +}
> +
> +static const struct of_device_id sdm670_pinctrl_of_match[] = {
> +	{ .compatible = "qcom,sdm670-pinctrl", },

Forgot to mention this on the binding, but please make this
qcom,sdm670-tlmm.

> +	{ },
> +};
> +
> +static struct platform_driver sdm670_pinctrl_driver = {
> +	.driver = {
> +		.name = "sdm670-pinctrl",
> +		.of_match_table = sdm670_pinctrl_of_match,
> +	},
> +	.probe = sdm670_pinctrl_probe,
> +	.remove = msm_pinctrl_remove,
> +};
> +
> +static int __init sdm670_pinctrl_init(void)
> +{
> +	return platform_driver_register(&sdm670_pinctrl_driver);
> +}
> +arch_initcall(sdm670_pinctrl_init);
> +
> +static void __exit sdm670_pinctrl_exit(void)
> +{
> +	platform_driver_unregister(&sdm670_pinctrl_driver);
> +}
> +module_exit(sdm670_pinctrl_exit);
> +
> +MODULE_AUTHOR("Richard Acayan <mailingradian@gmail.com>");
> +MODULE_DESCRIPTION("QTI sdm670 pinctrl driver");

Perhaps spell out "Qualcomm SDM670 TLMM pinctrl driver".

> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, sdm670_pinctrl_of_match);

It's nice to have the MODULE_DEVICE_TABLE next to the of_device_id
table.

Regards,
Bjorn
