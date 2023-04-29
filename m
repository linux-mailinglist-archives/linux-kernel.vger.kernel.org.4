Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786D06F21C6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347178AbjD2A6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjD2A6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CAE3ABC;
        Fri, 28 Apr 2023 17:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EFF760FBA;
        Sat, 29 Apr 2023 00:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92963C433D2;
        Sat, 29 Apr 2023 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682729929;
        bh=sxiftscupycNTg2zTKUCUESPu2fccUODMoS5OmsMnbg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l8wB1JTvFsgQ/fsfvVQ7+KNogogLsWQNXQcpKQ3n7LgQFHlQqxsR5M0pVddYaq5Ue
         CEo5OVQ5QfmoMVgYLDEh36juBMbYRXSQzhk9sSnovPVWVOHIoo51OBWIeXLtM/Qu8j
         CCl8CpEj5WF2fWzARgzbsbLyCINoaWmtKRBda+H5kjUAxOl4i7x9/IycvvxVKE60CD
         2ARi0twAP3J9qX4L32zoUmsV7RfvWJkXVg1azadtYe38isfMgjwV/kmuNGI1Z0d8OU
         hPBPIRmeFtdj8ttMleh05dq1fX5IxUrhn/zWa+rv1KDECV8mkA/fkV/KlHzCqfCzaF
         r2JVBjMfLp6XQ==
Message-ID: <d15b580f84ac89274cde3785168b0e26.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230424123522.18302-13-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me> <20230424123522.18302-13-nikita.shubin@maquefel.me>
Subject: Re: [PATCH 12/43] clk: ep93xx: add DT support for Cirrus EP93xx
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Date:   Fri, 28 Apr 2023 17:58:47 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Shubin (2023-04-24 05:34:28)
> This is a rewrite of EP93xx timer driver in
> arch/arm/mach-ep93xx/clock.c trying to do everything
> the device tree way:
>=20
> - convert to syscon driver
> - provide clock acces via of

But clkdev is still around?

>=20
> Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>=20
> Notes:
>     rfc->v0
>     Linus Walleij:
>     - renamed all __underscore
>    =20
>     Alexander Sverdlin:
>     - "Logick" -> "Logic"
>    =20
>     Changes by Alexander Sverdlin:
>     - remove pr_info
>     - DIV_ROUND_UP_ULL -> DIV_ROUND_CLOSEST
>     - fix zeroing bitfield in ep93xx_div_set_rate
>     - add sanity check for EP93XX_SYSCON_CHIPID_ID
>     - use bit index for DMA clock's
>     - ep93xx_clk_register_gate() takes bit index, not mask
>     - remove redundant define
>     - use DIV_ROUND_CLOSEST() everywhere to achieve frequencies closer to=
 those
>       requested
>     - Add the forgotten configuration from the deleted
>       arch/arm/mach-ep93xx/core.c
>=20
>  drivers/clk/Kconfig      |   8 +
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-ep93xx.c | 880 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 889 insertions(+)
>  create mode 100644 drivers/clk/clk-ep93xx.c
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 1eef05bb1f99..d3ad975b688e 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -436,6 +436,14 @@ config COMMON_CLK_K210
>         help
>           Support for the Canaan Kendryte K210 RISC-V SoC clocks.
> =20
> +config COMMON_CLK_EP93XX

Keep this sorted based on Kconfig symbol.

> +       bool "Clock driver for Cirrus Logic ep93xx SoC"
> +       depends on ARCH_EP93XX || COMPILE_TEST
> +       select MFD_SYSCON
> +       select REGMAP
> +       help
> +        This driver supports the SoC clocks on the Cirrus Logic ep93xx.
> +
>  source "drivers/clk/actions/Kconfig"
>  source "drivers/clk/analogbits/Kconfig"
>  source "drivers/clk/baikal-t1/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e3ca0d058a25..deec25ffd004 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE706)      +=3D clk-cdce706.o
>  obj-$(CONFIG_COMMON_CLK_CDCE925)       +=3D clk-cdce925.o
>  obj-$(CONFIG_ARCH_CLPS711X)            +=3D clk-clps711x.o
>  obj-$(CONFIG_COMMON_CLK_CS2000_CP)     +=3D clk-cs2000-cp.o
> +obj-$(CONFIG_COMMON_CLK_EP93XX)                +=3D clk-ep93xx.o
>  obj-$(CONFIG_ARCH_SPARX5)              +=3D clk-sparx5.o
>  obj-$(CONFIG_COMMON_CLK_EN7523)                +=3D clk-en7523.o
>  obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)    +=3D clk-fixed-mmio.o
> diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> new file mode 100644
> index 000000000000..e5913fc4c39b
> --- /dev/null
> +++ b/drivers/clk/clk-ep93xx.c
> @@ -0,0 +1,880 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Clock control for Cirrus EP93xx chips.
> + * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/clock.c:
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + */
> +#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/soc/cirrus/ep93xx.h>
> +#include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +
> +#include <asm/div64.h>
> +
> +#define EP93XX_EXT_CLK_RATE            14745600
> +#define EP93XX_EXT_RTC_RATE            32768
> +
> +#define EP93XX_SYSCON_POWER_STATE      0x00
> +#define EP93XX_SYSCON_PWRCNT           0x04
> +#define EP93XX_SYSCON_PWRCNT_UARTBAUD  BIT(29)
> +#define EP93XX_SYSCON_PWRCNT_USH_EN    28
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2M1  27
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2M0  26
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P8  25
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P9  24
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P6  23
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P7  22
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P4  21
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P5  20
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P2  19
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P3  18
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P0  17
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P1  16
> +#define EP93XX_SYSCON_CLKSET1          0x20
> +#define EP93XX_SYSCON_CLKSET1_NBYP1    BIT(23)
> +#define EP93XX_SYSCON_CLKSET2          0x24
> +#define EP93XX_SYSCON_CLKSET2_NBYP2    BIT(19)
> +#define EP93XX_SYSCON_CLKSET2_PLL2_EN  BIT(18)
> +#define EP93XX_SYSCON_DEVCFG           0x80
> +#define EP93XX_SYSCON_DEVCFG_U3EN      24
> +#define EP93XX_SYSCON_DEVCFG_U2EN      20
> +#define EP93XX_SYSCON_DEVCFG_U1EN      18
> +#define EP93XX_SYSCON_VIDCLKDIV                0x84
> +#define EP93XX_SYSCON_CLKDIV_ENABLE    15
> +#define EP93XX_SYSCON_CLKDIV_ESEL      BIT(14)
> +#define EP93XX_SYSCON_CLKDIV_PSEL      BIT(13)
> +#define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT        8
> +#define EP93XX_SYSCON_I2SCLKDIV                0x8c
> +#define EP93XX_SYSCON_I2SCLKDIV_SENA   31
> +#define EP93XX_SYSCON_I2SCLKDIV_ORIDE  BIT(29)
> +#define EP93XX_SYSCON_I2SCLKDIV_SPOL   BIT(19)
> +#define EP93XX_I2SCLKDIV_SDIV          (1 << 16)
> +#define EP93XX_I2SCLKDIV_LRDIV32       (0 << 17)
> +#define EP93XX_I2SCLKDIV_LRDIV64       (1 << 17)
> +#define EP93XX_I2SCLKDIV_LRDIV128      (2 << 17)
> +#define EP93XX_I2SCLKDIV_LRDIV_MASK    (3 << 17)
> +#define EP93XX_SYSCON_KEYTCHCLKDIV     0x90
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN        31
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV        16
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN 15
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV        0
> +#define EP93XX_SYSCON_CHIPID           0x94
> +#define EP93XX_SYSCON_CHIPID_ID                0x9213
> +
> +static DEFINE_SPINLOCK(clk_lock);

This name is not unique. Please make it unique by prefixing with ep93xx.

> +static struct regmap *ep93xx_map;

Do these need to be static globals? Doing a runtime allocation reduces
the size overhead for kernel images that don't have this hardware but
compile in this driver, i.e. distros.

> +#define ep93xx_regmap_read(reg, val) regmap_read(ep93xx_map, reg, val)
> +
> +/* Keeps track of all clocks */
> +static struct clk_hw_onecell_data *ep93xx_clk_data;

Same static global question.

> +
> +static char fclk_divisors[] =3D { 1, 2, 4, 8, 16, 1, 1, 1 };
> +static char hclk_divisors[] =3D { 1, 2, 4, 5, 6, 8, 16, 32 };
> +static char pclk_divisors[] =3D { 1, 2, 4, 8 };
> +
> +static char adc_divisors[] =3D { 16, 4 };
> +static char sclk_divisors[] =3D { 2, 4 };
> +static char lrclk_divisors[] =3D { 32, 64, 128 };

const?

> +
> +static const char * const mux_parents[] =3D {
> +       "xtali",
> +       "pll1",
> +       "pll2"
> +};
> +
> +/*
> + * PLL rate =3D 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / =
2^PS
> + */
> +static unsigned long calc_pll_rate(unsigned long long rate, u32 config_w=
ord)

u64 rate

> +{
> +       int i;
> +
> +       rate *=3D ((config_word >> 11) & 0x1f) + 1;               /* X1FB=
D */
> +       rate *=3D ((config_word >> 5) & 0x3f) + 1;                /* X2FB=
D */
> +       do_div(rate, (config_word & 0x1f) + 1);                 /* X2IPD =
*/
> +       for (i =3D 0; i < ((config_word >> 16) & 3); i++)         /* PS */
> +               rate >>=3D 1;
> +
> +       return (unsigned long)rate;

Drop useless cast.

> +}
> +
> +struct clk_psc {
> +       struct clk_hw hw;
> +       unsigned int reg;
> +       u8 bit_idx;
> +       u32 mask;
> +       u8 shift;
> +       u8 width;
> +       char *div;
> +       u8 num_div;
> +       spinlock_t *lock;
> +};
> +
> +#define to_clk_psc(_hw) container_of(_hw, struct clk_psc, hw)
> +
> +static int ep93xx_clk_is_enabled(struct clk_hw *hw)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       u32 val;
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +
> +       return (val & BIT(psc->bit_idx)) ? 1 : 0;
> +}
> +
> +static int ep93xx_clk_enable(struct clk_hw *hw)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       unsigned long flags =3D 0;
> +       u32 val;
> +
> +       if (psc->lock)
> +               spin_lock_irqsave(psc->lock, flags);
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +       val |=3D BIT(psc->bit_idx);
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +       if (psc->lock)
> +               spin_unlock_irqrestore(psc->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void ep93xx_clk_disable(struct clk_hw *hw)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       unsigned long flags =3D 0;
> +       u32 val;
> +
> +       if (psc->lock)
> +               spin_lock_irqsave(psc->lock, flags);
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +       val &=3D ~BIT(psc->bit_idx);
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +       if (psc->lock)
> +               spin_unlock_irqrestore(psc->lock, flags);
> +}
> +
> +static const struct clk_ops clk_ep93xx_gate_ops =3D {
> +       .enable =3D ep93xx_clk_enable,
> +       .disable =3D ep93xx_clk_disable,
> +       .is_enabled =3D ep93xx_clk_is_enabled,
> +};
> +
> +static struct clk_hw *ep93xx_clk_register_gate(const char *name,
> +                                   const char *parent_name,
> +                                   unsigned int reg,
> +                                   u8 bit_idx)
> +{
> +       struct clk_init_data init;
> +       struct clk_psc *psc;
> +       struct clk *clk;
> +
> +       psc =3D kzalloc(sizeof(*psc), GFP_KERNEL);
> +       if (!psc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &clk_ep93xx_gate_ops;
> +       init.flags =3D CLK_SET_RATE_PARENT;
> +       init.parent_names =3D (parent_name ? &parent_name : NULL);
> +       init.num_parents =3D (parent_name ? 1 : 0);

Please use parent_data or parent_hw instead.

> +
> +       psc->reg =3D reg;
> +       psc->bit_idx =3D bit_idx;
> +       psc->hw.init =3D &init;
> +       psc->lock =3D &clk_lock;
> +
> +       clk =3D clk_register(NULL, &psc->hw);
> +       if (IS_ERR(clk)) {
> +               kfree(psc);
> +               return ERR_CAST(clk);
> +       }
> +
> +       return &psc->hw;
> +}
> +
> +static u8 ep93xx_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       u32 val;
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +       if (!(val & EP93XX_SYSCON_CLKDIV_ESEL))
> +               return 0;
> +
> +       if (!(val & EP93XX_SYSCON_CLKDIV_PSEL))
> +               return 1;
> +
> +       return 2;
> +}
> +
> +static int ep93xx_mux_set_parent_lock(struct clk_hw *hw, u8 index)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       unsigned long flags =3D 0;
> +       u32 val;
> +
> +       if (index >=3D ARRAY_SIZE(mux_parents))
> +               return -EINVAL;
> +
> +       if (psc->lock)

Can you simply lock all the time?

> +               spin_lock_irqsave(psc->lock, flags);
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +       val &=3D ~(EP93XX_SYSCON_CLKDIV_ESEL | EP93XX_SYSCON_CLKDIV_PSEL);
> +
> +       if (index !=3D 0) {
> +               val |=3D EP93XX_SYSCON_CLKDIV_ESEL;
> +               val |=3D (index - 1) ? EP93XX_SYSCON_CLKDIV_PSEL : 0;
> +       }
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +       if (psc->lock)
> +               spin_unlock_irqrestore(psc->lock, flags);
> +
> +       return 0;
> +}
> +
> +static bool is_best(unsigned long rate, unsigned long now,
> +                    unsigned long best)
> +{
> +       return abs(rate - now) < abs(rate - best);
> +}
> +
> +static int ep93xx_mux_determine_rate(struct clk_hw *hw,
> +                               struct clk_rate_request *req)
> +{
> +       unsigned long rate =3D req->rate;
> +       struct clk *parent_best =3D NULL;
> +       unsigned long parent_rate;
> +       unsigned long best_rate =3D 0, actual_rate, mclk_rate;
> +       unsigned long parent_rate_best;
> +       int div, pdiv;
> +       int i;
> +
> +       /*
> +        * Try the two pll's and the external clock
> +        * Because the valid predividers are 2, 2.5 and 3, we multiply
> +        * all the clocks by 2 to avoid floating point math.
> +        *
> +        * This is based on the algorithm in the ep93xx raster guide:
> +        * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
> +        *
> +        */
> +       for (i =3D 0; i < ARRAY_SIZE(mux_parents); i++) {
> +               struct clk *parent =3D clk_get_sys(mux_parents[i], NULL);

The possible parents can be had with clk_hw_get_parent_by_index(). Use
that so you can stop leaking .

> +
> +               parent_rate =3D clk_get_rate(parent);
> +               mclk_rate =3D parent_rate * 2;

The parent_rate is available via clk_hw_get_rate() or by looking at the
clk_rate_request structure 'req' if the parent is the current parent, or
by calling clk_hw_round_rate() or the poorly named
__clk_determine_rate(). In this case it looks like the parents aren't
expected to change rate, so clk_hw_get_rate() will work.

> +
> +               /* Try each predivider value */
> +               for (pdiv =3D 4; pdiv <=3D 6; pdiv++) {
> +                       div =3D DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);
> +                       if (div < 1 || div > 127)
> +                               continue;
> +
> +                       actual_rate =3D DIV_ROUND_CLOSEST(mclk_rate, pdiv=
 * div);
> +
> +                       if (is_best(rate, actual_rate, best_rate)) {
> +                               best_rate =3D actual_rate;
> +                               parent_rate_best =3D parent_rate;
> +                               parent_best =3D parent;
> +                       }
> +               }
> +       }
> +
> +       if (!parent_best)
> +               return -EINVAL;
> +
> +       req->best_parent_rate =3D parent_rate_best;
> +       req->best_parent_hw =3D __clk_get_hw(parent_best);
> +       req->rate =3D best_rate;
> +
> +       return 0;
> +}
> +
> +static unsigned long ep93xx_ddiv_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       unsigned long rate =3D 0;
> +       u32 val;
> +       int pdiv, div;
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +       pdiv =3D ((val >> EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) & 0x03);
> +       div =3D val & 0x7f;
> +       if (div > 0)
> +               rate =3D DIV_ROUND_CLOSEST(parent_rate * 2, (pdiv + 3) * =
div);
> +
> +       return rate;
> +}
> +
> +static int ep93xx_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
> +                               unsigned long parent_rate)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       int pdiv, div, npdiv, ndiv;
> +       unsigned long actual_rate, mclk_rate, rate_err =3D -1;
> +       int found =3D 0;
> +       u32 val;
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +       mclk_rate =3D parent_rate * 2;
> +
> +       for (pdiv =3D 4; pdiv <=3D 6; pdiv++) {
> +               div =3D DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);
> +               if (div < 1 || div > 127)
> +                       continue;
> +
> +               actual_rate =3D DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
> +
> +               if (!found || abs(actual_rate - rate) < rate_err) {
> +                       npdiv =3D pdiv - 3;
> +                       ndiv =3D div;
> +                       rate_err =3D abs(actual_rate - rate);
> +                       found =3D 1;
> +               }
> +       }
> +
> +       if (!found)
> +               return -EINVAL;
> +
> +       /* Clear old dividers */
> +       val &=3D ~0x37f;
> +
> +       /* Set the new pdiv and div bits for the new clock rate */
> +       val |=3D (npdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | ndiv;
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops clk_ddiv_ops =3D {
> +       .enable =3D ep93xx_clk_enable,
> +       .disable =3D ep93xx_clk_disable,
> +       .is_enabled =3D ep93xx_clk_is_enabled,
> +       .get_parent =3D ep93xx_mux_get_parent,
> +       .set_parent =3D ep93xx_mux_set_parent_lock,
> +       .determine_rate =3D ep93xx_mux_determine_rate,
> +       .recalc_rate =3D ep93xx_ddiv_recalc_rate,
> +       .set_rate =3D ep93xx_ddiv_set_rate,
> +};
> +
> +static struct clk_hw *clk_hw_register_ddiv(const char *name,
> +                                         unsigned int reg,
> +                                         u8 bit_idx)
> +{
> +       struct clk_init_data init;
> +       struct clk_psc *psc;
> +       struct clk *clk;
> +
> +       psc =3D kzalloc(sizeof(*psc), GFP_KERNEL);
> +       if (!psc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &clk_ddiv_ops;
> +       init.flags =3D 0;
> +       init.parent_names =3D mux_parents;
> +       init.num_parents =3D ARRAY_SIZE(mux_parents);
> +
> +       psc->reg =3D reg;
> +       psc->bit_idx =3D bit_idx;
> +       psc->lock =3D &clk_lock;
> +       psc->hw.init =3D &init;
> +
> +       clk =3D clk_register(NULL, &psc->hw);
> +       if (IS_ERR(clk)) {
> +               kfree(psc);
> +               return ERR_CAST(clk);
> +       }
> +
> +       return &psc->hw;
> +}
> +
> +static unsigned long ep93xx_div_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       u32 val;
> +       u8 index;
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +       index =3D (val & psc->mask) >> psc->shift;
> +       if (index > psc->num_div)
> +               return 0;
> +
> +       return DIV_ROUND_CLOSEST(parent_rate, psc->div[index]);
> +}
> +
> +static long ep93xx_div_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                  unsigned long *parent_rate)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       unsigned long best =3D 0, now;
> +       bool assigned =3D false;
> +       int i;
> +
> +       for (i =3D 0; i < psc->num_div; i++) {
> +               if ((rate * psc->div[i]) =3D=3D *parent_rate)
> +                       return rate;
> +
> +               now =3D DIV_ROUND_CLOSEST(*parent_rate, psc->div[i]);
> +
> +               if (!assigned || is_best(rate, now, best))
> +                       best =3D now;
> +               assigned =3D true;
> +       }
> +
> +       return best;
> +}
> +
> +static int ep93xx_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long parent_rate)
> +{
> +       struct clk_psc *psc =3D to_clk_psc(hw);
> +       u32 val;
> +       int i;
> +
> +       ep93xx_regmap_read(psc->reg, &val);
> +       val &=3D ~psc->mask;
> +       for (i =3D 0; i < psc->num_div; i++)
> +               if (rate =3D=3D DIV_ROUND_CLOSEST(parent_rate, psc->div[i=
])) {
> +                       val |=3D i << psc->shift;
> +                       break;
> +               }
> +
> +       if (i =3D=3D psc->num_div)
> +               return -EINVAL;
> +
> +       ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops ep93xx_div_ops =3D {
> +       .enable =3D ep93xx_clk_enable,
> +       .disable =3D ep93xx_clk_disable,
> +       .is_enabled =3D ep93xx_clk_is_enabled,
> +       .recalc_rate =3D ep93xx_div_recalc_rate,
> +       .round_rate =3D ep93xx_div_round_rate,
> +       .set_rate =3D ep93xx_div_set_rate,
> +};
> +
> +static struct clk_hw *clk_hw_register_div(const char *name,
> +                                         const char *parent_name,
> +                                         unsigned int reg,
> +                                         u8 enable_bit,
> +                                         u8 shift,
> +                                         u8 width,
> +                                         char *clk_divisors,
> +                                         u8 num_div)
> +{
> +       struct clk_init_data init;
> +       struct clk_psc *psc;
> +       struct clk *clk;
> +
> +       psc =3D kzalloc(sizeof(*psc), GFP_KERNEL);
> +       if (!psc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &ep93xx_div_ops;
> +       init.flags =3D 0;
> +       init.parent_names =3D (parent_name ? &parent_name : NULL);
> +       init.num_parents =3D 1;
> +
> +       psc->reg =3D reg;
> +       psc->bit_idx =3D enable_bit;
> +       psc->mask =3D GENMASK(shift + width - 1, shift);
> +       psc->shift =3D shift;
> +       psc->div =3D clk_divisors;
> +       psc->num_div =3D num_div;
> +       psc->lock =3D &clk_lock;
> +       psc->hw.init =3D &init;
> +
> +       clk =3D clk_register(NULL, &psc->hw);

Use clk_hw_register()

> +       if (IS_ERR(clk)) {
> +               kfree(psc);
> +               return ERR_CAST(clk);
> +       }
> +
> +       return &psc->hw;
> +}
> +
> +struct ep93xx_gate {
> +       unsigned int idx;
> +       unsigned int bit;
> +       const char *dev_id;
> +       const char *con_id;
> +};
> +
> +static struct ep93xx_gate ep93xx_uarts[] =3D {
> +       {EP93XX_CLK_UART1, EP93XX_SYSCON_DEVCFG_U1EN, "apb:uart1", NULL},
> +       {EP93XX_CLK_UART2, EP93XX_SYSCON_DEVCFG_U2EN, "apb:uart2", NULL},
> +       {EP93XX_CLK_UART3, EP93XX_SYSCON_DEVCFG_U3EN, "apb:uart3", NULL},
> +};
> +
> +static void ep93xx_uart_clock_init(void)
> +{
> +       unsigned int i;
> +       struct clk_hw *hw;
> +       u32 val;
> +       unsigned int clk_uart_div;
> +
> +       ep93xx_regmap_read(EP93XX_SYSCON_PWRCNT, &val);
> +       if (val & EP93XX_SYSCON_PWRCNT_UARTBAUD)
> +               clk_uart_div =3D 1;
> +       else
> +               clk_uart_div =3D 2;
> +
> +       hw =3D clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1, =
clk_uart_div);
> +       ep93xx_clk_data->hws[EP93XX_CLK_UART] =3D hw;
> +
> +       /* parenting uart gate clocks to uart clock */
> +       for (i =3D 0; i < ARRAY_SIZE(ep93xx_uarts); i++) {
> +               hw =3D ep93xx_clk_register_gate(ep93xx_uarts[i].dev_id,
> +                                       "uart",
> +                                       EP93XX_SYSCON_DEVCFG,
> +                                       ep93xx_uarts[i].bit);
> +
> +               ep93xx_clk_data->hws[ep93xx_uarts[i].idx] =3D hw;
> +       }
> +}
> +
> +static struct ep93xx_gate ep93xx_dmas[] =3D {

const?

> +       {EP93XX_CLK_M2P0, EP93XX_SYSCON_PWRCNT_DMA_M2P0, NULL, "m2p0"},

Put space after { and before }

> +       {EP93XX_CLK_M2P1, EP93XX_SYSCON_PWRCNT_DMA_M2P1, NULL, "m2p1"},
> +       {EP93XX_CLK_M2P2, EP93XX_SYSCON_PWRCNT_DMA_M2P2, NULL, "m2p2"},
> +       {EP93XX_CLK_M2P3, EP93XX_SYSCON_PWRCNT_DMA_M2P3, NULL, "m2p3"},
> +       {EP93XX_CLK_M2P4, EP93XX_SYSCON_PWRCNT_DMA_M2P4, NULL, "m2p4"},
> +       {EP93XX_CLK_M2P5, EP93XX_SYSCON_PWRCNT_DMA_M2P5, NULL, "m2p5"},
> +       {EP93XX_CLK_M2P6, EP93XX_SYSCON_PWRCNT_DMA_M2P6, NULL, "m2p6"},
> +       {EP93XX_CLK_M2P7, EP93XX_SYSCON_PWRCNT_DMA_M2P7, NULL, "m2p7"},
> +       {EP93XX_CLK_M2P8, EP93XX_SYSCON_PWRCNT_DMA_M2P8, NULL, "m2p8"},
> +       {EP93XX_CLK_M2P9, EP93XX_SYSCON_PWRCNT_DMA_M2P9, NULL, "m2p9"},
> +       {EP93XX_CLK_M2M0, EP93XX_SYSCON_PWRCNT_DMA_M2M0, NULL, "m2m0"},
> +       {EP93XX_CLK_M2M1, EP93XX_SYSCON_PWRCNT_DMA_M2M1, NULL, "m2m1"},
> +};
> +
> +static void ep93xx_dma_clock_init(void __iomem *base)
> +{
> +       int i;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(ep93xx_dmas); i++) {
> +               hw =3D clk_hw_register_gate(NULL, ep93xx_dmas[i].con_id,
> +                                       "hclk", 0,
> +                                       base + EP93XX_SYSCON_PWRCNT,
> +                                       ep93xx_dmas[i].bit,
> +                                       0,
> +                                       &clk_lock);
> +
> +               ret =3D clk_hw_register_clkdev(hw, ep93xx_dmas[i].con_id,=
 NULL);
> +               if (ret) {
> +                       pr_err("%s: failed to register lookup %s\n",
> +                              __func__, ep93xx_dmas[i].con_id);
> +                       continue;
> +               }
> +
> +               ep93xx_clk_data->hws[ep93xx_dmas[i].idx] =3D hw;
> +       }
> +}
> +
> +static int ep93xx_clk_probe(struct platform_device *pdev)
> +{
> +       void __iomem *base;
> +       unsigned int clk_usb_div;
> +       unsigned long clk_spi_div;
> +       struct clk_hw *hw;
> +       struct device *dev =3D &pdev->dev;
> +       u32 value;
> +       struct resource *res;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       ep93xx_regmap_read(EP93XX_SYSCON_CLKSET2, &value);
> +       clk_usb_div =3D (((value >> 28) & 0xf) + 1);
> +       hw =3D clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1=
, clk_usb_div);
> +       hw =3D clk_hw_register_gate(NULL, "ohci-platform",
> +                               "usb_clk", 0,
> +                               base + EP93XX_SYSCON_PWRCNT,
> +                               EP93XX_SYSCON_PWRCNT_USH_EN,
> +                               0,
> +                               &clk_lock);
> +       clk_hw_register_clkdev(hw, NULL, "ohci-platform");
> +       ep93xx_clk_data->hws[EP93XX_CLK_USB] =3D hw;
> +
> +       /*
> +        * EP93xx SSP clock rate was doubled in version E2. For more info=
rmation
> +        * see:
> +        *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
> +        */
> +       clk_spi_div =3D 1;
> +       if (ep93xx_chip_revision() < EP93XX_CHIP_REV_E2)
> +               clk_spi_div =3D 2;
> +       hw =3D clk_hw_register_fixed_factor(NULL, "ep93xx-spi.0", "xtali"=
, 0, 1, clk_spi_div);
> +       clk_hw_register_clkdev(hw, NULL, "ep93xx-spi.0");
> +       ep93xx_clk_data->hws[EP93XX_CLK_SPI] =3D hw;
> +
> +       /* pwm clock */
> +       hw =3D clk_hw_register_fixed_factor(NULL, "pwm_clk", "xtali", 0, =
1, 1);
> +       clk_hw_register_clkdev(hw, "pwm_clk", NULL);
> +       ep93xx_clk_data->hws[EP93XX_CLK_PWM] =3D hw;
> +
> +       ep93xx_uart_clock_init();
> +
> +       /* touchscreen/adc clock */
> +       hw =3D clk_hw_register_div("ep93xx-adc",
> +                               "xtali",
> +                               EP93XX_SYSCON_KEYTCHCLKDIV,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_ADIV,
> +                               1,
> +                               adc_divisors,
> +                               ARRAY_SIZE(adc_divisors));
> +
> +       clk_hw_register_clkdev(hw, NULL, "ep93xx-adc");
> +       ep93xx_clk_data->hws[EP93XX_CLK_ADC] =3D hw;
> +
> +       /* keypad clock */
> +       hw =3D clk_hw_register_div("ep93xx-keypad",
> +                               "xtali",
> +                               EP93XX_SYSCON_KEYTCHCLKDIV,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_KDIV,
> +                               1,
> +                               adc_divisors,
> +                               ARRAY_SIZE(adc_divisors));
> +
> +       clk_hw_register_clkdev(hw, NULL, "ep93xx-keypad");
> +       ep93xx_clk_data->hws[EP93XX_CLK_KEYPAD] =3D hw;
> +
> +       /* On reset PDIV and VDIV is set to zero, while PDIV zero

The /* is on a line by itself.

> +        * means clock disable, VDIV shouldn't be zero.
> +        * So i set both dividers to minimum.
> +        */
> +       /* ENA - Enable CLK divider. */
> +       /* PDIV - 00 - Disable clock */
> +       /* VDIV - at least 2 */
> +       /* Check and enable video clk registers */
> +       ep93xx_regmap_read(EP93XX_SYSCON_VIDCLKDIV, &value);
> +       value |=3D (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
> +       ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_VIDCLKDIV);
> +
> +       /* check and enable i2s clk registers */
> +       ep93xx_regmap_read(EP93XX_SYSCON_I2SCLKDIV, &value);
> +       value |=3D (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
> +       /*
> +        * Override the SAI_MSTR_CLK_CFG from the I2S block and use the
> +        * I2SClkDiv Register settings. LRCLK transitions on the falling =
SCLK
> +        * edge.
> +        */
> +       value |=3D EP93XX_SYSCON_I2SCLKDIV_ORIDE | EP93XX_SYSCON_I2SCLKDI=
V_SPOL;
> +       ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_I2SCLKDIV);
> +
> +       /* video clk */
> +       hw =3D clk_hw_register_ddiv("ep93xx-fb",
> +                               EP93XX_SYSCON_VIDCLKDIV,
> +                               EP93XX_SYSCON_CLKDIV_ENABLE);
> +
> +       clk_hw_register_clkdev(hw, NULL, "ep93xx-fb");
> +       ep93xx_clk_data->hws[EP93XX_CLK_VIDEO] =3D hw;
> +
> +       /* i2s clk */
> +       hw =3D clk_hw_register_ddiv("mclk",
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_CLKDIV_ENABLE);
> +
> +       clk_hw_register_clkdev(hw, "mclk", "ep93xx-i2s");
> +       ep93xx_clk_data->hws[EP93XX_CLK_I2S_MCLK] =3D hw;
> +
> +       /* i2s sclk */
> +#define EP93XX_I2SCLKDIV_SDIV_SHIFT    16
> +#define EP93XX_I2SCLKDIV_SDIV_WIDTH    1
> +       hw =3D clk_hw_register_div("sclk",
> +                               "mclk",
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_I2SCLKDIV_SENA,
> +                               EP93XX_I2SCLKDIV_SDIV_SHIFT,
> +                               EP93XX_I2SCLKDIV_SDIV_WIDTH,
> +                               sclk_divisors,
> +                               ARRAY_SIZE(sclk_divisors));
> +
> +       clk_hw_register_clkdev(hw, "sclk", "ep93xx-i2s");
> +       ep93xx_clk_data->hws[EP93XX_CLK_I2S_SCLK] =3D hw;
> +
> +       /* i2s lrclk */
> +#define EP93XX_I2SCLKDIV_LRDIV32_SHIFT 17
> +#define EP93XX_I2SCLKDIV_LRDIV32_WIDTH 2

Please just inline these defines as they're only used on place.

> +       hw =3D clk_hw_register_div("lrclk",
> +                               "sclk",
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_I2SCLKDIV_SENA,
> +                               EP93XX_I2SCLKDIV_LRDIV32_SHIFT,
> +                               EP93XX_I2SCLKDIV_LRDIV32_WIDTH,
> +                               lrclk_divisors,
> +                               ARRAY_SIZE(lrclk_divisors));
> +
> +       clk_hw_register_clkdev(hw, "lrclk", "ep93xx-i2s");
> +       ep93xx_clk_data->hws[EP93XX_CLK_I2S_LRCLK] =3D hw;
> +
> +       /* IrDa clk uses same pattern but no init code presents in origin=
al clock driver */
> +       return 0;
> +}
> +
> +static const struct of_device_id ep93xx_clk_dt_ids[] =3D {
> +       { .compatible =3D "cirrus,ep9301-syscon", },
> +       { /* sentinel */ },
> +};
> +
> +static struct platform_driver ep93xx_clk_driver =3D {
> +       .probe  =3D ep93xx_clk_probe,
> +       .driver =3D {
> +               .name =3D "ep93xx-clk",
> +               .of_match_table =3D ep93xx_clk_dt_ids,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +builtin_platform_driver(ep93xx_clk_driver);
> +
> +static void __init ep93xx_clock_init(struct device_node *np)
> +{
> +       void __iomem *base;
> +       int i;
> +       int ret;
> +       u32 value;
> +       struct clk_hw *hw;
> +       unsigned long clk_pll1_rate;
> +       unsigned long clk_f_rate;
> +       unsigned long clk_h_rate;
> +       unsigned long clk_p_rate;
> +       unsigned long clk_pll2_rate;
> +       unsigned int clk_f_div;
> +       unsigned int clk_h_div;
> +       unsigned int clk_p_div;
> +
> +       ep93xx_clk_data =3D kzalloc(struct_size(ep93xx_clk_data, hws,
> +                               EP93XX_NUM_CLKS),
> +                               GFP_KERNEL);
> +
> +       if (!ep93xx_clk_data)
> +               return;
> +
> +       /*
> +        * This way all clock fetched before the platform device probes,
> +        * except those we assign here for early use, will be deferred.
> +        */
> +       for (i =3D 0; i < EP93XX_NUM_CLKS; i++)
> +               ep93xx_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> +
> +       base =3D of_iomap(np, 0);
> +       /* Remap the system controller for the exclusive register */
> +       if (IS_ERR(base)) {
> +               pr_err("failed to map base\n");
> +               return;
> +       }
> +
> +       ep93xx_map =3D syscon_node_to_regmap(np);
> +       if (IS_ERR(ep93xx_map)) {
> +               pr_err("no syscon regmap\n");
> +               return;
> +       }
> +
> +       /*
> +        * We check that the regmap works on this very first access,
> +        * but as this is an MMIO-backed regmap, subsequent regmap
> +        * access is not going to fail and we skip error checks from
> +        * this point.
> +        */
> +       ret =3D ep93xx_regmap_read(EP93XX_SYSCON_CHIPID, &value);
> +       if (ret || (value & 0xffff) !=3D EP93XX_SYSCON_CHIPID_ID) {
> +               pr_err("failed to read global status register\n");
> +               return;
> +       }
> +
> +       hw =3D clk_hw_register_fixed_rate(NULL, "xtali", NULL, 0, EP93XX_=
EXT_CLK_RATE);

Maybe this can be registered from DT itself.

> +       clk_hw_register_clkdev(hw, NULL, "xtali");
> +
> +       /* Determine the bootloader configured pll1 rate */
> +       ep93xx_regmap_read(EP93XX_SYSCON_CLKSET1, &value);
> +       if (!(value & EP93XX_SYSCON_CLKSET1_NBYP1))
> +               clk_pll1_rate =3D EP93XX_EXT_CLK_RATE;
> +       else
> +               clk_pll1_rate =3D calc_pll_rate(EP93XX_EXT_CLK_RATE, valu=
e);
> +
> +       hw =3D clk_hw_register_fixed_rate(NULL, "pll1", "xtali", 0, clk_p=
ll1_rate);

And maybe this can be registered from wherever the regmap is created?

> +       clk_hw_register_clkdev(hw, NULL, "pll1");

Do you need to use clkdev?

> +       ep93xx_clk_data->hws[EP93XX_CLK_PLL1] =3D hw;
> +
> +       /* Initialize the pll1 derived clocks */
> +       clk_f_div =3D fclk_divisors[(value >> 25) & 0x7];
> +       clk_h_div =3D hclk_divisors[(value >> 20) & 0x7];
> +       clk_p_div =3D pclk_divisors[(value >> 18) & 0x3];
> +
> +       hw =3D clk_hw_register_fixed_factor(NULL, "fclk", "pll1", 0, 1, c=
lk_f_div);
> +       clk_f_rate =3D clk_get_rate(hw->clk);
> +       ep93xx_clk_data->hws[EP93XX_CLK_FCLK] =3D hw;
> +       hw =3D clk_hw_register_fixed_factor(NULL, "hclk", "pll1", 0, 1, c=
lk_h_div);
> +       clk_h_rate =3D clk_get_rate(hw->clk);
> +       ep93xx_clk_data->hws[EP93XX_CLK_HCLK] =3D hw;
> +       hw =3D clk_hw_register_fixed_factor(NULL, "pclk", "hclk", 0, 1, c=
lk_p_div);
> +       clk_p_rate =3D clk_get_rate(hw->clk);
> +       ep93xx_clk_data->hws[EP93XX_CLK_PCLK] =3D hw;

Try to not use clk consumer APIs from a clk provider. In this case, it
looks like some debug message, so just drop these clk_get_rate() calls
and the associated printks.

> +
> +       clk_hw_register_clkdev(hw, "apb_pclk", NULL);
> +
> +       ep93xx_dma_clock_init(base);

Does some interrupt or timer driver use dma? Why are these registered
early?

> +
> +       /* Determine the bootloader configured pll2 rate */
> +       ep93xx_regmap_read(EP93XX_SYSCON_CLKSET2, &value);
> +       if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
> +               clk_pll2_rate =3D EP93XX_EXT_CLK_RATE;
> +       else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
> +               clk_pll2_rate =3D calc_pll_rate(EP93XX_EXT_CLK_RATE, valu=
e);
> +       else
> +               clk_pll2_rate =3D 0;
> +
> +       hw =3D clk_hw_register_fixed_rate(NULL, "pll2", "xtali", 0, clk_p=
ll2_rate);

Instead of registering a fixed rate clk here you can implemented
recalc_rate and look at the regmap value.

> +       ep93xx_clk_data->hws[EP93XX_CLK_PLL2] =3D hw;
> +       clk_hw_register_clkdev(hw, NULL, "pll2");
> +
> +       ep93xx_clk_data->num =3D EP93XX_NUM_CLKS;
> +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, ep93xx_clk_data=
);
> +
> +       pr_info("PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
> +               clk_pll1_rate / 1000000, clk_pll2_rate / 1000000);
> +       pr_info("FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
> +               clk_f_rate / 1000000, clk_h_rate / 1000000,
> +               clk_p_rate / 1000000);
> +}
> +CLK_OF_DECLARE_DRIVER(ep93xx_cc, "cirrus,ep9301-syscon", ep93xx_clock_in=
it);
