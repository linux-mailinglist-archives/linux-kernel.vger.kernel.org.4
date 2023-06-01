Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0271924D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjFAFhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjFAFh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:37:27 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FFEE4C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:37:00 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:c83:0:640:84f9:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 1344D60035;
        Thu,  1 Jun 2023 08:36:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OaGNfZvWv8c0-1Ei1IgtB;
        Thu, 01 Jun 2023 08:36:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685597817;
        bh=QQ3F5MayytDWeiENHmf+SnmETDC1ZfItgSNEnRIRE1U=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=CAs37a6domuEeR1/cdZc5lqxJC2YeiG2e374NZjPy2DH2UbsKlpOubiT3gdywgJ46
         +ZJ3RpM+FHo50Xj9PVBkySqae2KxxpDuqmRwpuRf7rc89wSLqhUBYaaW5zWhkkVz7f
         FlUpU2QlqlvRSEY6tHnT2qagInS1MieunNhRmc5I=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v1 05/43] clk: ep93xx: add DT support for Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:33:56 +0300
Message-Id: <20230601053546.9574-6-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rewrite of EP93xx timer driver in
arch/arm/mach-ep93xx/clock.c trying to do everything
the device tree way:

- convert to syscon driver
- provide clock acces via of

Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    Stephen Boyd:
    - dropped clkdev
    - Kconfig sorted
    - make lock name uniq
    - make divisors const
    - u64 rate and drop cast for calc_pll_rate
    - use parent_data
    - locking all the time
    - reworked parents in muxes
    - using clk_hw_register everywhere
    - inlined defines
    
    rfc -> v0:
    
    Linus Walleij:
    - renamed all __underscore
    
    Alexander Sverdlin:
    - "Logick" -> "Logic"
    
    Changes by Alexander Sverdlin:
    - remove pr_info
    - DIV_ROUND_UP_ULL -> DIV_ROUND_CLOSEST
    - fix zeroing bitfield in ep93xx_div_set_rate
    - add sanity check for EP93XX_SYSCON_CHIPID_ID
    - use bit index for DMA clock's
    - ep93xx_clk_register_gate() takes bit index, not mask
    - remove redundant define
    - use DIV_ROUND_CLOSEST() everywhere to achieve frequencies closer to those
      requested
    - Add the forgotten configuration from the deleted
      arch/arm/mach-ep93xx/core.c

 drivers/clk/Kconfig      |   8 +
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-ep93xx.c | 850 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 859 insertions(+)
 create mode 100644 drivers/clk/clk-ep93xx.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 1eef05bb1f99..acd28167b46c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -218,6 +218,14 @@ config COMMON_CLK_EN7523
 	  This driver provides the fixed clocks and gates present on Airoha
 	  ARM silicon.
 
+config COMMON_CLK_EP93XX
+	bool "Clock driver for Cirrus Logic ep93xx SoC"
+	depends on ARCH_EP93XX || COMPILE_TEST
+	select MFD_SYSCON
+	select REGMAP
+	help
+	  This driver supports the SoC clocks on the Cirrus Logic ep93xx.
+
 config COMMON_CLK_FSL_FLEXSPI
 	tristate "Clock driver for FlexSPI on Layerscape SoCs"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..deec25ffd004 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
+obj-$(CONFIG_COMMON_CLK_EP93XX)		+= clk-ep93xx.o
 obj-$(CONFIG_ARCH_SPARX5)		+= clk-sparx5.o
 obj-$(CONFIG_COMMON_CLK_EN7523)		+= clk-en7523.o
 obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
new file mode 100644
index 000000000000..e83571f83b5a
--- /dev/null
+++ b/drivers/clk/clk-ep93xx.c
@@ -0,0 +1,850 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Clock control for Cirrus EP93xx chips.
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Based on a rewrite of arch/arm/mach-ep93xx/clock.c:
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ */
+#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/soc/cirrus/ep93xx.h>
+#include <dt-bindings/clock/cirrus,ep93xx-clock.h>
+
+#include <asm/div64.h>
+
+#define EP93XX_EXT_CLK_RATE		14745600
+#define EP93XX_EXT_RTC_RATE		32768
+
+#define EP93XX_SYSCON_POWER_STATE	0x00
+#define EP93XX_SYSCON_PWRCNT		0x04
+#define EP93XX_SYSCON_PWRCNT_UARTBAUD	BIT(29)
+#define EP93XX_SYSCON_PWRCNT_USH_EN	28
+#define EP93XX_SYSCON_PWRCNT_DMA_M2M1	27
+#define EP93XX_SYSCON_PWRCNT_DMA_M2M0	26
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P8	25
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P9	24
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P6	23
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P7	22
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P4	21
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P5	20
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P2	19
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P3	18
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P0	17
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P1	16
+#define EP93XX_SYSCON_CLKSET1		0x20
+#define EP93XX_SYSCON_CLKSET1_NBYP1	BIT(23)
+#define EP93XX_SYSCON_CLKSET2		0x24
+#define EP93XX_SYSCON_CLKSET2_NBYP2	BIT(19)
+#define EP93XX_SYSCON_CLKSET2_PLL2_EN	BIT(18)
+#define EP93XX_SYSCON_DEVCFG		0x80
+#define EP93XX_SYSCON_DEVCFG_U3EN	24
+#define EP93XX_SYSCON_DEVCFG_U2EN	20
+#define EP93XX_SYSCON_DEVCFG_U1EN	18
+#define EP93XX_SYSCON_VIDCLKDIV		0x84
+#define EP93XX_SYSCON_CLKDIV_ENABLE	15
+#define EP93XX_SYSCON_CLKDIV_ESEL	BIT(14)
+#define EP93XX_SYSCON_CLKDIV_PSEL	BIT(13)
+#define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT	8
+#define EP93XX_SYSCON_I2SCLKDIV		0x8c
+#define EP93XX_SYSCON_I2SCLKDIV_SENA	31
+#define EP93XX_SYSCON_I2SCLKDIV_ORIDE	BIT(29)
+#define EP93XX_SYSCON_I2SCLKDIV_SPOL	BIT(19)
+#define EP93XX_I2SCLKDIV_SDIV		(1 << 16)
+#define EP93XX_I2SCLKDIV_LRDIV32	(0 << 17)
+#define EP93XX_I2SCLKDIV_LRDIV64	(1 << 17)
+#define EP93XX_I2SCLKDIV_LRDIV128	(2 << 17)
+#define EP93XX_I2SCLKDIV_LRDIV_MASK	(3 << 17)
+#define EP93XX_SYSCON_KEYTCHCLKDIV	0x90
+#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	31
+#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	16
+#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	15
+#define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	0
+#define EP93XX_SYSCON_CHIPID		0x94
+#define EP93XX_SYSCON_CHIPID_ID		0x9213
+
+static DEFINE_SPINLOCK(ep93xx_clk_lock);
+static struct regmap *ep93xx_map;
+#define ep93xx_regmap_read(reg, val) regmap_read(ep93xx_map, reg, val)
+#define ep93xx_regmap_write(reg, val) regmap_write(ep93xx_map, reg, val)
+
+/* Keeps track of all clocks */
+static struct clk_hw_onecell_data *ep93xx_clk_data;
+
+static const char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
+static const char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
+static const char pclk_divisors[] = { 1, 2, 4, 8 };
+
+static const char adc_divisors[] = { 16, 4 };
+static const char sclk_divisors[] = { 2, 4 };
+static const char lrclk_divisors[] = { 32, 64, 128 };
+
+#define EP_PARENT(NAME) { .name = NAME, .fw_name = NAME }
+
+static const struct clk_parent_data ep93xx_clk_parents[] = {
+	EP_PARENT("xtali"),
+	EP_PARENT("pll1"),
+	EP_PARENT("pll2")
+};
+
+/*
+ * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
+ */
+static unsigned long calc_pll_rate(u64 rate, u32 config_word)
+{
+	int i;
+
+	rate *= ((config_word >> 11) & 0x1f) + 1;		/* X1FBD */
+	rate *= ((config_word >> 5) & 0x3f) + 1;		/* X2FBD */
+	do_div(rate, (config_word & 0x1f) + 1);			/* X2IPD */
+	for (i = 0; i < ((config_word >> 16) & 3); i++)		/* PS */
+		rate >>= 1;
+
+	return rate;
+}
+
+struct clk_psc {
+	struct clk_hw hw;
+	unsigned int reg;
+	u8 bit_idx;
+	u32 mask;
+	u8 shift;
+	u8 width;
+	const char *div;
+	u8 num_div;
+	spinlock_t *lock;
+	bool nolock;
+};
+
+#define to_clk_psc(_hw) container_of(_hw, struct clk_psc, hw)
+
+static int ep93xx_clk_is_enabled(struct clk_hw *hw)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	u32 val;
+
+	ep93xx_regmap_read(psc->reg, &val);
+
+	return (val & BIT(psc->bit_idx)) ? 1 : 0;
+}
+
+static int ep93xx_clk_enable(struct clk_hw *hw)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long flags = 0;
+	u32 val;
+
+	spin_lock_irqsave(psc->lock, flags);
+
+	ep93xx_regmap_read(psc->reg, &val);
+	val |= BIT(psc->bit_idx);
+
+	if (psc->nolock)
+		ep93xx_regmap_write(psc->reg, val);
+	else
+		ep93xx_syscon_swlocked_write(val, psc->reg);
+
+	spin_unlock_irqrestore(psc->lock, flags);
+
+	return 0;
+}
+
+static void ep93xx_clk_disable(struct clk_hw *hw)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long flags = 0;
+	u32 val;
+
+	spin_lock_irqsave(psc->lock, flags);
+
+	ep93xx_regmap_read(psc->reg, &val);
+	val &= ~BIT(psc->bit_idx);
+
+	if (psc->nolock)
+		ep93xx_regmap_write(psc->reg, val);
+	else
+		ep93xx_syscon_swlocked_write(val, psc->reg);
+
+	spin_unlock_irqrestore(psc->lock, flags);
+}
+
+static const struct clk_ops clk_ep93xx_gate_ops = {
+	.enable = ep93xx_clk_enable,
+	.disable = ep93xx_clk_disable,
+	.is_enabled = ep93xx_clk_is_enabled,
+};
+
+static struct clk_hw *ep93xx_clk_register_gate(const char *name,
+					const char *parent_name,
+					unsigned long flags,
+					unsigned int reg,
+					u8 bit_idx,
+					bool nolock)
+{
+	struct clk_parent_data parent_data = { };
+	struct clk_init_data init = { };
+	struct clk_psc *psc;
+	int ret;
+
+	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
+	if (!psc)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_ep93xx_gate_ops;
+	init.flags = flags;
+
+	parent_data.fw_name = parent_name;
+	parent_data.name = parent_name;
+	init.parent_data = &parent_data;
+	init.num_parents = 1;
+
+	psc->reg = reg;
+	psc->bit_idx = bit_idx;
+	psc->hw.init = &init;
+	psc->lock = &ep93xx_clk_lock;
+	psc->nolock = nolock;
+
+	ret = clk_hw_register(NULL, &psc->hw);
+	if (ret) {
+		kfree(psc);
+		return ERR_PTR(ret);
+	}
+
+	return &psc->hw;
+}
+
+static u8 ep93xx_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	u32 val;
+
+	ep93xx_regmap_read(psc->reg, &val);
+	if (!(val & EP93XX_SYSCON_CLKDIV_ESEL))
+		return 0;
+
+	if (!(val & EP93XX_SYSCON_CLKDIV_PSEL))
+		return 1;
+
+	return 2;
+}
+
+static int ep93xx_mux_set_parent_lock(struct clk_hw *hw, u8 index)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long flags = 0;
+	u32 val;
+
+	if (index >= ARRAY_SIZE(ep93xx_clk_parents))
+		return -EINVAL;
+
+	if (psc->lock)
+		spin_lock_irqsave(psc->lock, flags);
+
+	ep93xx_regmap_read(psc->reg, &val);
+	val &= ~(EP93XX_SYSCON_CLKDIV_ESEL | EP93XX_SYSCON_CLKDIV_PSEL);
+
+	if (index != 0) {
+		val |= EP93XX_SYSCON_CLKDIV_ESEL;
+		val |= (index - 1) ? EP93XX_SYSCON_CLKDIV_PSEL : 0;
+	}
+
+	ep93xx_syscon_swlocked_write(val, psc->reg);
+
+	if (psc->lock)
+		spin_unlock_irqrestore(psc->lock, flags);
+
+	return 0;
+}
+
+static bool is_best(unsigned long rate, unsigned long now,
+		     unsigned long best)
+{
+	return abs(rate - now) < abs(rate - best);
+}
+
+static int ep93xx_mux_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
+{
+	unsigned long rate = req->rate;
+	struct clk_hw *parent_best = NULL;
+	unsigned long parent_rate;
+	unsigned long best_rate = 0, actual_rate, mclk_rate;
+	unsigned long parent_rate_best;
+	int div, pdiv;
+	int i;
+
+	/*
+	 * Try the two pll's and the external clock
+	 * Because the valid predividers are 2, 2.5 and 3, we multiply
+	 * all the clocks by 2 to avoid floating point math.
+	 *
+	 * This is based on the algorithm in the ep93xx raster guide:
+	 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
+	 *
+	 */
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
+
+		parent_rate = clk_hw_get_rate(parent);
+		mclk_rate = parent_rate * 2;
+
+		/* Try each predivider value */
+		for (pdiv = 4; pdiv <= 6; pdiv++) {
+			div = DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);
+			if (div < 1 || div > 127)
+				continue;
+
+			actual_rate = DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
+
+			if (is_best(rate, actual_rate, best_rate)) {
+				best_rate = actual_rate;
+				parent_rate_best = parent_rate;
+				parent_best = parent;
+			}
+		}
+	}
+
+	if (!parent_best)
+		return -EINVAL;
+
+	req->best_parent_rate = parent_rate_best;
+	req->best_parent_hw = parent_best;
+	req->rate = best_rate;
+
+	return 0;
+}
+
+static unsigned long ep93xx_ddiv_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long rate = 0;
+	u32 val;
+	int pdiv, div;
+
+	ep93xx_regmap_read(psc->reg, &val);
+	pdiv = ((val >> EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) & 0x03);
+	div = val & 0x7f;
+	if (div > 0)
+		rate = DIV_ROUND_CLOSEST(parent_rate * 2, (pdiv + 3) * div);
+
+	return rate;
+}
+
+static int ep93xx_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	int pdiv, div, npdiv, ndiv;
+	unsigned long actual_rate, mclk_rate, rate_err = -1;
+	int found = 0;
+	u32 val;
+
+	ep93xx_regmap_read(psc->reg, &val);
+	mclk_rate = parent_rate * 2;
+
+	for (pdiv = 4; pdiv <= 6; pdiv++) {
+		div = DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);
+		if (div < 1 || div > 127)
+			continue;
+
+		actual_rate = DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
+
+		if (!found || abs(actual_rate - rate) < rate_err) {
+			npdiv = pdiv - 3;
+			ndiv = div;
+			rate_err = abs(actual_rate - rate);
+			found = 1;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	/* Clear old dividers */
+	val &= ~0x37f;
+
+	/* Set the new pdiv and div bits for the new clock rate */
+	val |= (npdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | ndiv;
+
+	ep93xx_syscon_swlocked_write(val, psc->reg);
+
+	return 0;
+}
+
+static const struct clk_ops clk_ddiv_ops = {
+	.enable = ep93xx_clk_enable,
+	.disable = ep93xx_clk_disable,
+	.is_enabled = ep93xx_clk_is_enabled,
+	.get_parent = ep93xx_mux_get_parent,
+	.set_parent = ep93xx_mux_set_parent_lock,
+	.determine_rate = ep93xx_mux_determine_rate,
+	.recalc_rate = ep93xx_ddiv_recalc_rate,
+	.set_rate = ep93xx_ddiv_set_rate,
+};
+
+static struct clk_hw *clk_hw_register_ddiv(const char *name,
+					  unsigned int reg,
+					  u8 bit_idx)
+{
+	struct clk_init_data init = { };
+	struct clk_psc *psc;
+	int ret;
+
+	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
+	if (!psc)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_ddiv_ops;
+	init.flags = 0;
+	init.parent_data = ep93xx_clk_parents;
+	init.num_parents = ARRAY_SIZE(ep93xx_clk_parents);
+
+	psc->reg = reg;
+	psc->bit_idx = bit_idx;
+	psc->lock = &ep93xx_clk_lock;
+	psc->hw.init = &init;
+
+	ret = clk_hw_register(NULL, &psc->hw);
+	if (ret) {
+		kfree(psc);
+		return ERR_PTR(ret);
+	}
+
+	return &psc->hw;
+}
+
+static unsigned long ep93xx_div_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	u32 val;
+	u8 index;
+
+	ep93xx_regmap_read(psc->reg, &val);
+	index = (val & psc->mask) >> psc->shift;
+	if (index > psc->num_div)
+		return 0;
+
+	return DIV_ROUND_CLOSEST(parent_rate, psc->div[index]);
+}
+
+static long ep93xx_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long best = 0, now;
+	bool assigned = false;
+	int i;
+
+	for (i = 0; i < psc->num_div; i++) {
+		if ((rate * psc->div[i]) == *parent_rate)
+			return rate;
+
+		now = DIV_ROUND_CLOSEST(*parent_rate, psc->div[i]);
+
+		if (!assigned || is_best(rate, now, best))
+			best = now;
+		assigned = true;
+	}
+
+	return best;
+}
+
+static int ep93xx_div_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct clk_psc *psc = to_clk_psc(hw);
+	u32 val;
+	int i;
+
+	ep93xx_regmap_read(psc->reg, &val);
+	val &= ~psc->mask;
+	for (i = 0; i < psc->num_div; i++)
+		if (rate == DIV_ROUND_CLOSEST(parent_rate, psc->div[i])) {
+			val |= i << psc->shift;
+			break;
+		}
+
+	if (i == psc->num_div)
+		return -EINVAL;
+
+	ep93xx_syscon_swlocked_write(val, psc->reg);
+
+	return 0;
+}
+
+static const struct clk_ops ep93xx_div_ops = {
+	.enable = ep93xx_clk_enable,
+	.disable = ep93xx_clk_disable,
+	.is_enabled = ep93xx_clk_is_enabled,
+	.recalc_rate = ep93xx_div_recalc_rate,
+	.round_rate = ep93xx_div_round_rate,
+	.set_rate = ep93xx_div_set_rate,
+};
+
+static struct clk_hw *clk_hw_register_div(const char *name,
+					  const char *parent_name,
+					  unsigned int reg,
+					  u8 enable_bit,
+					  u8 shift,
+					  u8 width,
+					  const char *clk_divisors,
+					  u8 num_div)
+{
+	struct clk_parent_data parent_data = { };
+	struct clk_init_data init = { };
+	struct clk_psc *psc;
+	int ret;
+
+	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
+	if (!psc)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &ep93xx_div_ops;
+	init.flags = 0;
+	parent_data.fw_name = parent_name;
+	parent_data.name = parent_name;
+	init.parent_data = &parent_data;
+	init.num_parents = 1;
+
+	psc->reg = reg;
+	psc->bit_idx = enable_bit;
+	psc->mask = GENMASK(shift + width - 1, shift);
+	psc->shift = shift;
+	psc->div = clk_divisors;
+	psc->num_div = num_div;
+	psc->lock = &ep93xx_clk_lock;
+	psc->hw.init = &init;
+
+	ret = clk_hw_register(NULL, &psc->hw);
+	if (ret) {
+		kfree(psc);
+		return ERR_PTR(ret);
+	}
+
+	return &psc->hw;
+}
+
+struct ep93xx_gate {
+	unsigned int idx;
+	unsigned int bit;
+	const char *name;
+};
+
+static const struct ep93xx_gate ep93xx_uarts[] = {
+	{ EP93XX_CLK_UART1, EP93XX_SYSCON_DEVCFG_U1EN, "uart1" },
+	{ EP93XX_CLK_UART2, EP93XX_SYSCON_DEVCFG_U2EN, "uart2" },
+	{ EP93XX_CLK_UART3, EP93XX_SYSCON_DEVCFG_U3EN, "uart3" },
+};
+
+static void ep93xx_uart_clock_init(void)
+{
+	unsigned int i;
+	struct clk_hw *hw;
+	u32 val;
+	unsigned int clk_uart_div;
+
+	ep93xx_regmap_read(EP93XX_SYSCON_PWRCNT, &val);
+	if (val & EP93XX_SYSCON_PWRCNT_UARTBAUD)
+		clk_uart_div = 1;
+	else
+		clk_uart_div = 2;
+
+	hw = clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1, clk_uart_div);
+	ep93xx_clk_data->hws[EP93XX_CLK_UART] = hw;
+
+	/* parenting uart gate clocks to uart clock */
+	for (i = 0; i < ARRAY_SIZE(ep93xx_uarts); i++) {
+		hw = ep93xx_clk_register_gate(ep93xx_uarts[i].name,
+					"uart",
+					CLK_SET_RATE_PARENT,
+					EP93XX_SYSCON_DEVCFG,
+					ep93xx_uarts[i].bit,
+					false);
+
+		ep93xx_clk_data->hws[ep93xx_uarts[i].idx] = hw;
+	}
+}
+
+static const struct ep93xx_gate ep93xx_dmas[] = {
+	{ EP93XX_CLK_M2P0, EP93XX_SYSCON_PWRCNT_DMA_M2P0, "m2p0" },
+	{ EP93XX_CLK_M2P1, EP93XX_SYSCON_PWRCNT_DMA_M2P1, "m2p1" },
+	{ EP93XX_CLK_M2P2, EP93XX_SYSCON_PWRCNT_DMA_M2P2, "m2p2" },
+	{ EP93XX_CLK_M2P3, EP93XX_SYSCON_PWRCNT_DMA_M2P3, "m2p3" },
+	{ EP93XX_CLK_M2P4, EP93XX_SYSCON_PWRCNT_DMA_M2P4, "m2p4" },
+	{ EP93XX_CLK_M2P5, EP93XX_SYSCON_PWRCNT_DMA_M2P5, "m2p5" },
+	{ EP93XX_CLK_M2P6, EP93XX_SYSCON_PWRCNT_DMA_M2P6, "m2p6" },
+	{ EP93XX_CLK_M2P7, EP93XX_SYSCON_PWRCNT_DMA_M2P7, "m2p7" },
+	{ EP93XX_CLK_M2P8, EP93XX_SYSCON_PWRCNT_DMA_M2P8, "m2p8" },
+	{ EP93XX_CLK_M2P9, EP93XX_SYSCON_PWRCNT_DMA_M2P9, "m2p9" },
+	{ EP93XX_CLK_M2M0, EP93XX_SYSCON_PWRCNT_DMA_M2M0, "m2m0" },
+	{ EP93XX_CLK_M2M1, EP93XX_SYSCON_PWRCNT_DMA_M2M1, "m2m1" },
+};
+
+static void ep93xx_dma_clock_init(void)
+{
+	int i;
+	struct clk_hw *hw;
+
+	for (i = 0; i < ARRAY_SIZE(ep93xx_dmas); i++) {
+		hw = ep93xx_clk_register_gate(ep93xx_dmas[i].name,
+					"hclk", 0,
+					EP93XX_SYSCON_PWRCNT,
+					ep93xx_dmas[i].bit,
+					true);
+
+		ep93xx_clk_data->hws[ep93xx_dmas[i].idx] = hw;
+	}
+}
+
+static int ep93xx_clk_probe(struct platform_device *pdev)
+{
+	unsigned int clk_usb_div;
+	unsigned long clk_spi_div;
+	struct clk_hw *hw;
+	u32 value;
+
+	ep93xx_regmap_read(EP93XX_SYSCON_CLKSET2, &value);
+	clk_usb_div = (((value >> 28) & 0xf) + 1);
+	hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
+	hw = ep93xx_clk_register_gate("ohci-platform",
+				"usb_clk", 0,
+				EP93XX_SYSCON_PWRCNT,
+				EP93XX_SYSCON_PWRCNT_USH_EN,
+				true);
+	ep93xx_clk_data->hws[EP93XX_CLK_USB] = hw;
+
+	/*
+	 * EP93xx SSP clock rate was doubled in version E2. For more information
+	 * see:
+	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
+	 */
+	clk_spi_div = 1;
+	if (ep93xx_chip_revision() < EP93XX_CHIP_REV_E2)
+		clk_spi_div = 2;
+	hw = clk_hw_register_fixed_factor(NULL, "ep93xx-spi.0", "xtali", 0, 1, clk_spi_div);
+	ep93xx_clk_data->hws[EP93XX_CLK_SPI] = hw;
+
+	/* pwm clock */
+	hw = clk_hw_register_fixed_factor(NULL, "pwm_clk", "xtali", 0, 1, 1);
+	ep93xx_clk_data->hws[EP93XX_CLK_PWM] = hw;
+
+	ep93xx_uart_clock_init();
+
+	/* touchscreen/adc clock */
+	hw = clk_hw_register_div("ep93xx-adc",
+				"xtali",
+				EP93XX_SYSCON_KEYTCHCLKDIV,
+				EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
+				EP93XX_SYSCON_KEYTCHCLKDIV_ADIV,
+				1,
+				adc_divisors,
+				ARRAY_SIZE(adc_divisors));
+
+	ep93xx_clk_data->hws[EP93XX_CLK_ADC] = hw;
+
+	/* keypad clock */
+	hw = clk_hw_register_div("ep93xx-keypad",
+				"xtali",
+				EP93XX_SYSCON_KEYTCHCLKDIV,
+				EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
+				EP93XX_SYSCON_KEYTCHCLKDIV_KDIV,
+				1,
+				adc_divisors,
+				ARRAY_SIZE(adc_divisors));
+
+	ep93xx_clk_data->hws[EP93XX_CLK_KEYPAD] = hw;
+
+	/*
+	 * On reset PDIV and VDIV is set to zero, while PDIV zero
+	 * means clock disable, VDIV shouldn't be zero.
+	 * So i set both dividers to minimum.
+	 */
+	/* ENA - Enable CLK divider. */
+	/* PDIV - 00 - Disable clock */
+	/* VDIV - at least 2 */
+	/* Check and enable video clk registers */
+	ep93xx_regmap_read(EP93XX_SYSCON_VIDCLKDIV, &value);
+	value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
+	ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_VIDCLKDIV);
+
+	/* check and enable i2s clk registers */
+	ep93xx_regmap_read(EP93XX_SYSCON_I2SCLKDIV, &value);
+	value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
+	/*
+	 * Override the SAI_MSTR_CLK_CFG from the I2S block and use the
+	 * I2SClkDiv Register settings. LRCLK transitions on the falling SCLK
+	 * edge.
+	 */
+	value |= EP93XX_SYSCON_I2SCLKDIV_ORIDE | EP93XX_SYSCON_I2SCLKDIV_SPOL;
+	ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_I2SCLKDIV);
+
+	/* video clk */
+	hw = clk_hw_register_ddiv("ep93xx-fb",
+				EP93XX_SYSCON_VIDCLKDIV,
+				EP93XX_SYSCON_CLKDIV_ENABLE);
+
+	ep93xx_clk_data->hws[EP93XX_CLK_VIDEO] = hw;
+
+	/* i2s clk */
+	hw = clk_hw_register_ddiv("mclk",
+				EP93XX_SYSCON_I2SCLKDIV,
+				EP93XX_SYSCON_CLKDIV_ENABLE);
+
+	ep93xx_clk_data->hws[EP93XX_CLK_I2S_MCLK] = hw;
+
+	/* i2s sclk */
+	hw = clk_hw_register_div("sclk",
+				"mclk",
+				EP93XX_SYSCON_I2SCLKDIV,
+				EP93XX_SYSCON_I2SCLKDIV_SENA,
+				16, /* EP93XX_I2SCLKDIV_SDIV_SHIFT */
+				1,  /* EP93XX_I2SCLKDIV_SDIV_WIDTH */
+				sclk_divisors,
+				ARRAY_SIZE(sclk_divisors));
+
+	ep93xx_clk_data->hws[EP93XX_CLK_I2S_SCLK] = hw;
+
+	/* i2s lrclk */
+	hw = clk_hw_register_div("lrclk",
+				"sclk",
+				EP93XX_SYSCON_I2SCLKDIV,
+				EP93XX_SYSCON_I2SCLKDIV_SENA,
+				17, /* EP93XX_I2SCLKDIV_LRDIV32_SHIFT */
+				2,  /* EP93XX_I2SCLKDIV_LRDIV32_WIDTH */
+				lrclk_divisors,
+				ARRAY_SIZE(lrclk_divisors));
+
+	ep93xx_clk_data->hws[EP93XX_CLK_I2S_LRCLK] = hw;
+
+	/* IrDa clk uses same pattern but no init code presents in original clock driver */
+	return 0;
+}
+
+static const struct of_device_id ep93xx_clk_dt_ids[] = {
+	{ .compatible = "cirrus,ep9301-clk", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ep93xx_clk_driver = {
+	.probe  = ep93xx_clk_probe,
+	.driver = {
+		.name = "ep93xx-clk",
+		.of_match_table = ep93xx_clk_dt_ids,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(ep93xx_clk_driver);
+
+static void __init ep93xx_clock_init(struct device_node *np)
+{
+	int i;
+	int ret;
+	u32 value;
+	struct clk_hw *hw;
+	struct device_node *parent;
+	unsigned long clk_pll1_rate;
+	unsigned long clk_pll2_rate;
+	unsigned int clk_f_div;
+	unsigned int clk_h_div;
+	unsigned int clk_p_div;
+
+	ep93xx_clk_data = kzalloc(struct_size(ep93xx_clk_data, hws,
+				EP93XX_NUM_CLKS),
+				GFP_KERNEL);
+
+	if (!ep93xx_clk_data)
+		return;
+
+	/*
+	 * This way all clock fetched before the platform device probes,
+	 * except those we assign here for early use, will be deferred.
+	 */
+	for (i = 0; i < EP93XX_NUM_CLKS; i++)
+		ep93xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	parent = of_get_parent(np);
+	if (!parent) {
+		pr_err("no syscon parent for clk node\n");
+		return;
+	}
+
+	ep93xx_map = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(ep93xx_map)) {
+		pr_err("no syscon regmap\n");
+		return;
+	}
+
+	/*
+	 * We check that the regmap works on this very first access,
+	 * but as this is an MMIO-backed regmap, subsequent regmap
+	 * access is not going to fail and we skip error checks from
+	 * this point.
+	 */
+	ret = ep93xx_regmap_read(EP93XX_SYSCON_CHIPID, &value);
+	if (ret || (value & 0xffff) != EP93XX_SYSCON_CHIPID_ID) {
+		pr_err("failed to read global status register\n");
+		return;
+	}
+
+	/* Determine the bootloader configured pll1 rate */
+	ep93xx_regmap_read(EP93XX_SYSCON_CLKSET1, &value);
+	if (!(value & EP93XX_SYSCON_CLKSET1_NBYP1))
+		clk_pll1_rate = EP93XX_EXT_CLK_RATE;
+	else
+		clk_pll1_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
+
+	hw = clk_hw_register_fixed_rate(NULL, "pll1", "xtali", 0, clk_pll1_rate);
+	ep93xx_clk_data->hws[EP93XX_CLK_PLL1] = hw;
+
+	/* Initialize the pll1 derived clocks */
+	clk_f_div = fclk_divisors[(value >> 25) & 0x7];
+	clk_h_div = hclk_divisors[(value >> 20) & 0x7];
+	clk_p_div = pclk_divisors[(value >> 18) & 0x3];
+
+	hw = clk_hw_register_fixed_factor(NULL, "fclk", "pll1", 0, 1, clk_f_div);
+	ep93xx_clk_data->hws[EP93XX_CLK_FCLK] = hw;
+	hw = clk_hw_register_fixed_factor(NULL, "hclk", "pll1", 0, 1, clk_h_div);
+	ep93xx_clk_data->hws[EP93XX_CLK_HCLK] = hw;
+	hw = clk_hw_register_fixed_factor(NULL, "pclk", "hclk", 0, 1, clk_p_div);
+	ep93xx_clk_data->hws[EP93XX_CLK_PCLK] = hw;
+
+	/* Dma probing uses subsys_initcall, so we require to init them early */
+	ep93xx_dma_clock_init();
+
+	/* Determine the bootloader configured pll2 rate */
+	ep93xx_regmap_read(EP93XX_SYSCON_CLKSET2, &value);
+	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
+		clk_pll2_rate = EP93XX_EXT_CLK_RATE;
+	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
+		clk_pll2_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
+	else
+		clk_pll2_rate = 0;
+
+	hw = clk_hw_register_fixed_rate(NULL, "pll2", "xtali", 0, clk_pll2_rate);
+	ep93xx_clk_data->hws[EP93XX_CLK_PLL2] = hw;
+
+	ep93xx_clk_data->num = EP93XX_NUM_CLKS;
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, ep93xx_clk_data);
+}
+
+CLK_OF_DECLARE_DRIVER(ep93xx, "cirrus,ep9301-clk", ep93xx_clock_init);
-- 
2.37.4

