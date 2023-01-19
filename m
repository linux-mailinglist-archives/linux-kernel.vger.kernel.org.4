Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052EC6737C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjASMB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjASMAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:00:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEED5C0DC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:00:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i4so987942wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=vGhIkmV1Mg5mNM04dUi+JtodrePHaCkSPqrX88wSfSg=;
        b=p5o4ZpD1aUW3PcV63Vrgja65ZwshpeLx1kn/CB4pG7R7haBNsptV/2h9SjVp/Y1ohK
         gFPLhpCUMbtLP4F+EuqWLAjWfHdOJ1TbPnTmicJ2vBd9Oa5Y9PTnvh/IufMB5ZEjFs18
         nAjG2ZxmuCKNvQyPdurcvMMMD24FeZXH5rMcJSf4xrk6IM5aseQMPPUfVWjJ0ZPf1PrT
         KHn3WM7Ns5yy/MG7IYvfEh8o/KBN2e0niu7VvAPfb+nsGrVTijCBj2k0RQYMrcwO4APC
         5wnWhjP+pKN2eFBVqw/BxWugdYfwN71BmLoOtaiSxdVOEZgeZ5I6T0KCv29h8rW2eJlv
         LK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGhIkmV1Mg5mNM04dUi+JtodrePHaCkSPqrX88wSfSg=;
        b=c6rwAWKOFj8Dr4EnifaoOeFnlaMw/EQkJhZafbszUJIgPaWCDpFJalYeUzsRE1Q+2z
         j/1OtjqkuXNE2dq/FjkSfUGZ48kedtjJTVvSqrO6SDzgCu/jsh1oNMs1gOH6GkhYzDUl
         ddivu4K7RQKox3EHoGsd1Ik6N3aq7WlBgGTG3S3eD7F3X5sLEK1Ucpb4I2fGLI5wEAmT
         kdBIxeeXZQf4NFaGw13Kis0hetb4lGDIWznTi/P4yLJSyKDcp1OjbTj+I3tXz40HKXjv
         xx19mbClv/GfkHQnZjfOTj3El+QFwzoizprAlz1POAqBkoSW7G9hYUbJvJ9D9t4+ew7Y
         7LHQ==
X-Gm-Message-State: AFqh2koNRfyxRanLK4GJxq73vVHv+5kt4kFz4k1H743vqgd9KFr6DHdk
        LdONyhSLSlkKB1bbr6e0CXnzzQ==
X-Google-Smtp-Source: AMrXdXvE6zeWlw2COOPr4i3Zcc8CGy1UYJgXpOyXeL5P/Vz7p5Rm9U/wVBzw89FTf13sxsjk/VqjdA==
X-Received: by 2002:a5d:674a:0:b0:2bb:e864:7a30 with SMTP id l10-20020a5d674a000000b002bbe8647a30mr9658049wrw.32.1674129643006;
        Thu, 19 Jan 2023 04:00:43 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b16-20020adff910000000b002bdf8dd6a8bsm11591895wrr.80.2023.01.19.04.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 04:00:41 -0800 (PST)
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-4-yu.tu@amlogic.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
Subject: Re: [PATCH V6 3/3] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Date:   Thu, 19 Jan 2023 12:37:20 +0100
In-reply-to: <20230116074214.2326-4-yu.tu@amlogic.com>
Message-ID: <1ja62eybrv.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:

> Add the peripherals clock controller driver in the s4 SoC family.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>

[...]

> +
> +/* Video Clocks */
> +static struct clk_regmap s4_vid_pll_div = {
> +	.data = &(struct meson_vid_pll_div_data){
> +		.val = {
> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
> +			.shift   = 0,
> +			.width   = 15,
> +		},
> +		.sel = {
> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
> +			.shift   = 16,
> +			.width   = 2,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vid_pll_div",
> +		/*
> +		 * The frequency division from the hdmi_pll clock to the vid_pll_div
> +		 * clock is the default value of this register. When designing the
> +		 * video module of the chip, a default value that can meet the
> +		 * requirements of the video module will be solidified according
> +		 * to the usage requirements of the chip, so as to facilitate chip
> +		 * simulation. So this is ro_ops.
> +		 * It is important to note that this clock is not used on this
> +		 * chip and is described only for the integrity of the clock tree.
> +		 */

If it is reset value and will be applicable to all the design, regarless
of the use-case, then yes RO ops is OK

From what I understand here, the value will depend on the use-case requirements.
This is a typical case where the DT prop "assigned-rate" should be used, not RO ops.

> +		.ops = &meson_vid_pll_div_ro_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "hdmi_pll", }
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +

> +
> +/* VDEC clocks */
> +static const struct clk_parent_data s4_dec_parent_data[] = {
> +	{ .fw_name = "fclk_div2p5", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "gp0_pll", },
> +	{ .fw_name = "xtal", }
> +};
> +
> +static struct clk_regmap s4_vdec_p0_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdec_p0_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_dec_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
> +		/*
> +		 * When the driver uses this clock, needs to specify the patent clock
> +		 * he wants in the dts.

s/patent/parent ?
s/he wants/it requires ?

> +		 */
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
> +	},
> +};
> +

[...]

> +static const struct clk_parent_data s4_vpu_clkc_parent_data[] = {
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +	{ .fw_name = "mpll1", },
> +	{ .hw = &s4_vid_pll.hw },
> +	{ .fw_name = "mpll2", },
> +	{ .fw_name = "gp0_pll", },
> +};
> +
> +static struct clk_regmap s4_vpu_clkc_p0_mux  = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_clkc_p0_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_vpu_clkc_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
> +		/*
> +		 * When the driver uses this clock, needs to specify the patent clock
> +		 * he wants in the dts.
> +		 */

That's quite a lot of occurences of the same comment.
At the same time, other clocks with the same flag have no comment.

Please make general comment, before the Video/VPU section, explaining
which clocks needs on a use-case basis (through DT) and possibly how it
should be set, what should drive the choices.

> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
> +	},
> +};
> +

> +
> +/* EMMC/NAND clock */
> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .fw_name = "fclk_div2", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "hifi_pll", },
> +	{ .fw_name = "fclk_div2p5", },
> +	{ .fw_name = "mpll2", },
> +	{ .fw_name = "mpll3", },
> +	{ .fw_name = "gp0_pll", },
> +};
> +
> +static struct clk_regmap s4_sd_emmc_c_clk0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_NAND_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_clk0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_sd_emmc_clk0_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
> +		/*
> +		 * When the driver uses this clock, needs to specify the patent clock
> +		 * he wants in the dts.
> +		 */

I'm getting a bit suspicious about the use (and abuse ...) of this flag.
I don't quite get how selecting the base PLL for MMC should be done on
use-case basis and should be up the board DT ...

Other SoC have all used fdiv2 so far. Do you expect this setting to be
part of the dtsi SoC file ?

> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
> +	},
> +};
> +

> +
> +/* SPICC Clock */
> +static const struct clk_parent_data s4_spicc_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .hw = &s4_sys_clk.hw },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +	{ .fw_name = "fclk_div2", },
> +	{ .fw_name = "fclk_div5", },
> +	{ .fw_name = "fclk_div7", },
> +};
> +
> +static struct clk_regmap s4_spicc0_mux = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc0_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_spicc_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_spicc_parent_data),
> +		/*
> +		 * When the driver uses this clock, needs to specify the patent clock
> +		 * he wants in the dts.
> +		 */

This is getting too far. All the parent clocks are fixed.
Let CCF do the job of picking the most adequate clock for the job
instead of manually settings things

> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
> +	},
> +};
> +


> +
> +/* PWM Clock */
> +static const struct clk_parent_data s4_pwm_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .hw = &s4_vid_pll.hw },
> +	{ .fw_name = "fclk_div4", },
> +	{ .fw_name = "fclk_div3", },
> +};
> +
> +static struct clk_regmap s4_pwm_a_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pwm_a_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = s4_pwm_parent_data,
> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
> +		/*
> +		 * When the driver uses this clock, needs to specify the patent clock
> +		 * he wants in the dts.
> +		 */

Same here ... this is really going to far.

> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
> +	},
> +};
> +

> +
> +static struct clk_regmap s4_saradc_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_SAR_CLK_CTRL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "saradc_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", },
> +			{ .hw = &s4_sys_clk.hw },
> +		},
> +		.num_parents = 2,
> +		/*
> +		 * When the driver uses this clock, needs to specify the patent clock
> +		 * he wants in the dts.
> +		 */

For each clock type, if this flag is going to be used, I'd like a clear
explanation about why it is use-case dependent and why you need manual
control over this. Same applies to all the occurence.

> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
> +	},
> +};
