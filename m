Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13C46B2CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCIS3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCIS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:29:04 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DECE9CEB;
        Thu,  9 Mar 2023 10:29:01 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D09415FD16;
        Thu,  9 Mar 2023 21:28:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678386538;
        bh=CIRQg7hC6CEd/e41iLtiXwUhJirx9xJ3FGxic7KJOuI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=OX97kEXlp0GYFIRkei7PlgtCLDhBwyCVlnu71ydo/9UiG6hr4ZV4VrB2EE8nHBOoz
         4ntpOMH8pIH1WXwvNd1rhQAyI3o6u3j9YPnKPXHN9mjavEFdmgdNKHJcHfwRSskRha
         0sTqau4cjSHEm83bL/EaSXv6cgjP0QgiiI6+NFqX2IAVZ8t/sp3uCsVRQdY4220crt
         9zKka4KfdYWo2AjXe08FWiS+bfI5igJVLFWZlF2XCO1iWtwi2lcEwwTPNCyJKM3zDR
         rAoS5pI+v1bVkBoXSFnOd2/a676aKlHt6ClQCar/5ywF+5qjy7i/tqIkDrVq2lpdgC
         wtysz3BymV8mA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  9 Mar 2023 21:28:58 +0300 (MSK)
Date:   Thu, 9 Mar 2023 21:28:57 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 2/5] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
Message-ID: <20230309182857.a2fzotcejueio23w@CAB-WSD-L081021>
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-3-ddrokosov@sberdevices.ru>
 <1jr0u2azfi.fsf@starbuckisacylon.baylibre.com>
 <20230306200549.7iuedbl27ejfhf6b@CAB-WSD-L081021>
 <1jlek60zun.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jlek60zun.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/09 14:25:00 #20928723
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:20:23PM +0100, Jerome Brunet wrote:
> 
> On Mon 06 Mar 2023 at 23:05, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > On Mon, Mar 06, 2023 at 12:17:23PM +0100, Jerome Brunet wrote:
> >> 
> >> On Wed 01 Mar 2023 at 21:37, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >> 
> >> > Introduce PLL clock controller for Amlogic A1 SoC family.
> >> >
> >> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> >> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

[...]

> >> > +	},
> >> > +};
> >> > +
> >> > +static const struct pll_mult_range hifi_pll_mult_range = {
> >> > +	.min = 32,
> >> > +	.max = 64,
> >> > +};
> >> > +
> >> > +static const struct reg_sequence hifi_init_regs[] = {
> >> > +	{ .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x01800000 },
> >> > +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001100 },
> >> > +	{ .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x100a1100 },
> >> > +	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x00302000 },
> >> > +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x01f18440 },
> >> 
> >> This last poke should not bits otherwise handled by parms.
> >> This is a rate init in disguise.
> >> 
> >
> > I believe, you are talking about hifi_pll clk_regmap conflicts with
> > hifi_init_regs. The above init sequence shouldn't affect pll regmap setup,
> > it doesn't touch them (we assume that default bit values are all zero):
> >
> >     .en = {
> >         .reg_off = ANACTRL_HIFIPLL_CTRL0,
> >         .shift   = 28,
> >         .width   = 1,
> >     },
> >     // init_value = 0x01f18440
> >     // en_mask    = 0x10000000
> >
> >     .m = {
> >         .reg_off = ANACTRL_HIFIPLL_CTRL0,
> >         .shift   = 0,
> >         .width   = 8,
> >     },
> >     // init_value = 0x01f18440
> >     // m_mask     = 0x0000000f
> 
> mask is 0xff with width 8
> 

Ah, you're right. Anyway, I think this is just init value and it's okay
to set it during initialization and rewrite after in parameter
propagation stage.

> >
> >     .n = {
> >         .reg_off = ANACTRL_HIFIPLL_CTRL0,
> >         .shift   = 10,
> >         .width   = 5,
> >     },
> >     // init_value = 0x01f18440
> >     // n_mask     = 0x00007c00
> >                            ^
> >                     oops, one overlap
> >                     but why we can't set init value for pre_sel?
> >
> >     .frac = {
> >         .reg_off = ANACTRL_HIFIPLL_CTRL1,
> >         .shift   = 0,
> >         .width   = 19,
> >     },
> >     // init_value = 0x01800000
> >     // frac_mask  = 0x0007ffff
> >
> >     .current_en = {
> >         .reg_off = ANACTRL_HIFIPLL_CTRL0,
> >         .shift   = 26,
> >         .width   = 1,
> >     },
> >     // init_value      = 0x01f18440
> >     // current_en_mask = 0x04000000
> >
> >     .l_detect = {
> >         .reg_off = ANACTRL_HIFIPLL_CTRL2,
> >         .shift   = 6,
> >         .width   = 1,
> >     },
> >     // init_value    = 0x00001100
> >     // l_detect_mask = 0x00000040
> >
> >> > +};
> >> > +
> >> > +static struct clk_regmap hifi_pll = {
> >> > +	.data = &(struct meson_clk_pll_data){
> >> > +		.en = {
> >> > +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> >> > +			.shift   = 28,
> >> > +			.width   = 1,
> >> > +		},
> >> > +		.m = {
> >> > +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> >> > +			.shift   = 0,
> >> > +			.width   = 8,
> >> > +		},
> >> > +		.n = {
> >> > +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> >> > +			.shift   = 10,
> >> > +			.width   = 5,
> >> > +		},
> >> > +		.frac = {
> >> > +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
> >> > +			.shift   = 0,
> >> > +			.width   = 19,
> >> > +		},
> >> > +		.l = {
> >> > +			.reg_off = ANACTRL_HIFIPLL_STS,
> >> > +			.shift   = 31,
> >> > +			.width   = 1,
> >> > +		},
> >> > +		.current_en = {
> >> > +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> >> > +			.shift   = 26,
> >> > +			.width   = 1,
> >> > +		},
> >> > +		.l_detect = {
> >> 
> >> What is this ?
> >> 
> >
> > Lock detection module.
> >
> > This is IP module included to new PLL power-on sequence. From clk-pll.c
> > patchset:
> >
> > /*
> >  * Compared with the previous SoCs, self-adaption current module
> >  * is newly added for A1, keep the new power-on sequence to enable the
> >  * PLL. The sequence is:
> >  * 1. enable the pll, delay for 10us
> >  * 2. enable the pll self-adaption current module, delay for 40us
> >  * 3. enable the lock detect module
> >  */
> 
> Ok. I missed this is the PLL driver
> 

No problem.

[...]

-- 
Thank you,
Dmitry
