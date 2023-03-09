Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13C86B26AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCIOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCIOV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:21:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22485B53E1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:21:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g3so2039557wri.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678371714;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=AEHlRMi5Q2I80CZialyymAKTB782rTM8WKCpwZlq1o8=;
        b=hcpQN/n+icfLdi79023NpowiwPnkzd6YL1WrFNyLc8oYHIQsBuUDpGUAahbYaLviym
         ln31tKbSw7bs2TH8gTWfF1gchQ4Xd6Jk6XX4AkPt5Qtldrzu5ngCjwdnz1HI9/nhUFrF
         67kNkh2+wKxd0c/WVsYRqYZWXjDbGgGOlfm1EIDEXrFEf75Z+4Nlq6OzXfWBe29nHii4
         5wwvA/f7IdBAF5QrXAHxRd/RfXxHfoJ4YG5574mF/x5zFNF/FUVwDrm/kRksBTqTQN2G
         GSMYCeKWDn5o0fQDC3uZZ0qej9VhA58dHOmWsnc79kGWxYZtoyyWXI++jbR/gv6zO2Ln
         PWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678371714;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEHlRMi5Q2I80CZialyymAKTB782rTM8WKCpwZlq1o8=;
        b=vx047J2kJMb5PpWOAcf0wfXML+7F0bda2C0B6Yt/0T6UiG+DEFCkIj2wzwFZj03hoM
         JdpZVp10TdwdE1H20PLOGMOSKStuId2MRerBjZqHs9Vc5STUKJ4s6lHgVDXlXs31qkkm
         aTBoSkHQ98r+GzATRRka6gE7/DDvE2nEyqCkQMym2iC5TOICTJUu1QnXq+LiboAbnB7H
         B3oyIvTB4wDSBS4ab//xgJ8MOXbPanPEopaV4K7aaFx1uS9UdTiO2MFgpLs8y/TKSUYE
         xOuHQAQUqqIm4HKQBX3P//V22eMWa+DT8TofA/GH8dlSeIXNSZH/m0bTgvbYYWEAH/FP
         fvKw==
X-Gm-Message-State: AO0yUKXI5xI0wSufyKyPEtfIUUHlv9cpa1zR96bC5rCyRA2z2ojwDyC1
        vyL5NDqaLOOEf8eVYGghveeBFEvqUFyQTjql+B8=
X-Google-Smtp-Source: AK7set+d7SR228BMsoIxKvezFbp4g82LTL4J61pq06eA7vMpP8G1ojBrn/NaLY8jkXnQlPBxLF+OoQ==
X-Received: by 2002:adf:dd49:0:b0:2c7:1aaa:750 with SMTP id u9-20020adfdd49000000b002c71aaa0750mr14090260wrm.66.1678371714560;
        Thu, 09 Mar 2023 06:21:54 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d508d000000b002c54536c662sm18204361wrt.34.2023.03.09.06.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:21:53 -0800 (PST)
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-3-ddrokosov@sberdevices.ru>
 <1jr0u2azfi.fsf@starbuckisacylon.baylibre.com>
 <20230306200549.7iuedbl27ejfhf6b@CAB-WSD-L081021>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/5] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
Date:   Thu, 09 Mar 2023 15:20:23 +0100
In-reply-to: <20230306200549.7iuedbl27ejfhf6b@CAB-WSD-L081021>
Message-ID: <1jlek60zun.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Mar 2023 at 23:05, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> On Mon, Mar 06, 2023 at 12:17:23PM +0100, Jerome Brunet wrote:
>> 
>> On Wed 01 Mar 2023 at 21:37, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
>> 
>> > Introduce PLL clock controller for Amlogic A1 SoC family.
>> >
>> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> > ---
>> >  drivers/clk/meson/Kconfig  |  10 +
>> >  drivers/clk/meson/Makefile |   1 +
>> >  drivers/clk/meson/a1-pll.c | 365 +++++++++++++++++++++++++++++++++++++
>> >  drivers/clk/meson/a1-pll.h |  47 +++++
>> >  4 files changed, 423 insertions(+)
>> >  create mode 100644 drivers/clk/meson/a1-pll.c
>> >  create mode 100644 drivers/clk/meson/a1-pll.h
>> >
>
> [...]
>
>> > diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
>> > new file mode 100644
>> > index 000000000000..c565f9b2a8dd
>> > --- /dev/null
>> > +++ b/drivers/clk/meson/a1-pll.c
>> > @@ -0,0 +1,365 @@
>> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> > +/*
>> > + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> > + * Author: Jian Hu <jian.hu@amlogic.com>
>> > + *
>> > + * Copyright (c) 2023, SberDevices. All Rights Reserved.
>> > + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> > + */
>> > +
>> > +#include <linux/clk-provider.h>
>> > +#include <linux/of_device.h>
>> > +#include <linux/platform_device.h>
>> > +#include "meson-a1-clkc.h"
>> 
>> As pointed out by the kernel robot, there is a problem here
>> 
>
> My fault. Really sorry for that.
>
> [...]
>
>> > +static struct clk_regmap fixed_pll = {
>> > +	.data = &(struct clk_regmap_gate_data){
>> > +		.offset = ANACTRL_FIXPLL_CTRL0,
>> > +		.bit_idx = 20,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data) {
>> > +		.name = "fixed_pll",
>> > +		.ops = &clk_regmap_gate_ops,
>> > +		.parent_hws = (const struct clk_hw *[]) {
>> > +			&fixed_pll_dco.hw
>> > +		},
>> > +		.num_parents = 1,
>> > +		/*
>> > +		 * It is enough that the fdiv leaf has critical flag,
>> > +		 * No critical or unused flag here.
>> > +		 */
>> 
>> The comment is not useful
>> 
>
> OK
>
>> > +	},
>> > +};
>> > +
>> > +static const struct pll_mult_range hifi_pll_mult_range = {
>> > +	.min = 32,
>> > +	.max = 64,
>> > +};
>> > +
>> > +static const struct reg_sequence hifi_init_regs[] = {
>> > +	{ .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x01800000 },
>> > +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001100 },
>> > +	{ .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x100a1100 },
>> > +	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x00302000 },
>> > +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x01f18440 },
>> 
>> This last poke should not bits otherwise handled by parms.
>> This is a rate init in disguise.
>> 
>
> I believe, you are talking about hifi_pll clk_regmap conflicts with
> hifi_init_regs. The above init sequence shouldn't affect pll regmap setup,
> it doesn't touch them (we assume that default bit values are all zero):
>
>     .en = {
>         .reg_off = ANACTRL_HIFIPLL_CTRL0,
>         .shift   = 28,
>         .width   = 1,
>     },
>     // init_value = 0x01f18440
>     // en_mask    = 0x10000000
>
>     .m = {
>         .reg_off = ANACTRL_HIFIPLL_CTRL0,
>         .shift   = 0,
>         .width   = 8,
>     },
>     // init_value = 0x01f18440
>     // m_mask     = 0x0000000f

mask is 0xff with width 8

>
>     .n = {
>         .reg_off = ANACTRL_HIFIPLL_CTRL0,
>         .shift   = 10,
>         .width   = 5,
>     },
>     // init_value = 0x01f18440
>     // n_mask     = 0x00007c00
>                            ^
>                     oops, one overlap
>                     but why we can't set init value for pre_sel?
>
>     .frac = {
>         .reg_off = ANACTRL_HIFIPLL_CTRL1,
>         .shift   = 0,
>         .width   = 19,
>     },
>     // init_value = 0x01800000
>     // frac_mask  = 0x0007ffff
>
>     .current_en = {
>         .reg_off = ANACTRL_HIFIPLL_CTRL0,
>         .shift   = 26,
>         .width   = 1,
>     },
>     // init_value      = 0x01f18440
>     // current_en_mask = 0x04000000
>
>     .l_detect = {
>         .reg_off = ANACTRL_HIFIPLL_CTRL2,
>         .shift   = 6,
>         .width   = 1,
>     },
>     // init_value    = 0x00001100
>     // l_detect_mask = 0x00000040
>
>> > +};
>> > +
>> > +static struct clk_regmap hifi_pll = {
>> > +	.data = &(struct meson_clk_pll_data){
>> > +		.en = {
>> > +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
>> > +			.shift   = 28,
>> > +			.width   = 1,
>> > +		},
>> > +		.m = {
>> > +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
>> > +			.shift   = 0,
>> > +			.width   = 8,
>> > +		},
>> > +		.n = {
>> > +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
>> > +			.shift   = 10,
>> > +			.width   = 5,
>> > +		},
>> > +		.frac = {
>> > +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
>> > +			.shift   = 0,
>> > +			.width   = 19,
>> > +		},
>> > +		.l = {
>> > +			.reg_off = ANACTRL_HIFIPLL_STS,
>> > +			.shift   = 31,
>> > +			.width   = 1,
>> > +		},
>> > +		.current_en = {
>> > +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
>> > +			.shift   = 26,
>> > +			.width   = 1,
>> > +		},
>> > +		.l_detect = {
>> 
>> What is this ?
>> 
>
> Lock detection module.
>
> This is IP module included to new PLL power-on sequence. From clk-pll.c
> patchset:
>
> /*
>  * Compared with the previous SoCs, self-adaption current module
>  * is newly added for A1, keep the new power-on sequence to enable the
>  * PLL. The sequence is:
>  * 1. enable the pll, delay for 10us
>  * 2. enable the pll self-adaption current module, delay for 40us
>  * 3. enable the lock detect module
>  */

Ok. I missed this is the PLL driver

>
> [...]
>
>> > +static struct clk_regmap fclk_div3 = {
>> > +	.data = &(struct clk_regmap_gate_data){
>> > +		.offset = ANACTRL_FIXPLL_CTRL0,
>> > +		.bit_idx = 22,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data){
>> > +		.name = "fclk_div3",
>> > +		.ops = &clk_regmap_gate_ops,
>> > +		.parent_hws = (const struct clk_hw *[]) {
>> > +			&fclk_div3_div.hw
>> > +		},
>> > +		.num_parents = 1,
>> > +		/*
>> > +		 * This clock is used by APB bus which is set in boot ROM code
>> > +		 * and is required by the platform to operate correctly.
>> > +		 * About critical, refer to fclk_div2.
>> 
>> This last line is not useful. Same for other occurences
>> 
>
> Good point. Copy-paste detected :-)
>
> [...]
>
>> > +static int meson_a1_pll_probe(struct platform_device *pdev)
>> > +{
>> > +	struct device *dev = &pdev->dev;
>> > +	struct clk_hw *hw;
>> > +	void __iomem *base;
>> > +	struct regmap *map;
>> > +	int clkid, i, err;
>> > +
>> > +	base = devm_platform_ioremap_resource(pdev, 0);
>> > +	if (IS_ERR(base))
>> > +		return dev_err_probe(dev, PTR_ERR(base),
>> > +				     "can't ioremap resource\n");
>> > +
>> > +	map = devm_regmap_init_mmio(dev, base, &a1_pll_regmap_cfg);
>> > +	if (IS_ERR(map))
>> > +		return dev_err_probe(dev, PTR_ERR(map),
>> > +				     "can't init regmap mmio region\n");
>> > +
>> > +	/* Populate regmap for the regmap backed clocks */
>> > +	for (i = 0; i < ARRAY_SIZE(a1_pll_regmaps); i++)
>> > +		a1_pll_regmaps[i]->map = map;
>> > +
>> > +	for (clkid = 0; clkid < a1_pll_hw_onecell_data.num; clkid++) {
>> > +		hw = a1_pll_hw_onecell_data.hws[clkid];
>> > +		err = devm_clk_hw_register(dev, hw);
>> > +		if (err)
>> > +			return dev_err_probe(dev, err,
>> > +					     "clock registration failed\n");
>> > +	}
>> > +
>> > +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> > +					   &a1_pll_hw_onecell_data);
>> > +}
>> > +
>> > +#ifdef CONFIG_OF
>> 
>> This config is selected by ARM64 which this driver depends on
>> 
>
> Make sense, thanks a lot!
>
> [...]

