Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A33653047
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiLUL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiLUL3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:29:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94210AF;
        Wed, 21 Dec 2022 03:29:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70741B81B5D;
        Wed, 21 Dec 2022 11:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9F4C433EF;
        Wed, 21 Dec 2022 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671622176;
        bh=feIQeLBCKbMw33fIxCd4lR4wOK3el1cUidVk9jOR93M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hs3yqjAsxpdPSCX0mJi8C1/3P99vNfSe4JyV4l4nWG+Yi7L0/9bD0LSrGBs2OAM/z
         pk3xjgTkMMy5o+JOOWOD1ybeaR8jWoBGtJPhx5S62I6aRs673Qa2gz2A6EPB49+ZL4
         l66/vgEsLx8PouGXplrt1QWINGUYsl+ad9Gn8O9TffYO/cW/F+847FuD1gAJuUS7Gz
         bkanE6xFTTPXy5thv/2dvBWrjoah9WWDKnOeL4MaEux6uKmaFf9LXDna3AMt/ojSXY
         jwsB5Om9B8L3MOlXo90LOWqO096yCVqQTfTqKY0io9yh6EgFeZ2XZ8kLQO+NmwwNhj
         rv3wJOV69icJA==
From:   Conor Dooley <conor@kernel.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v13 1/2] pwm: add microchip soft ip corePWM driver
Date:   Wed, 21 Dec 2022 11:29:12 +0000
Message-Id: <20221221112912.147210-2-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221112912.147210-1-conor@kernel.org>
References: <20221221112912.147210-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add a driver that supports the Microchip FPGA "soft" PWM IP core.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pwm/Kconfig              |  10 +
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-microchip-core.c | 436 +++++++++++++++++++++++++++++++
 3 files changed, 447 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index dae023d783a2..f42756a014ed 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -393,6 +393,16 @@ config PWM_MEDIATEK
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mediatek.
 
+config PWM_MICROCHIP_CORE
+	tristate "Microchip corePWM PWM support"
+	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	help
+	  PWM driver for Microchip FPGA soft IP core.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-microchip-core.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..a65625359ece 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
+obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
new file mode 100644
index 000000000000..047fa708b9fc
--- /dev/null
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -0,0 +1,436 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * corePWM driver for Microchip "soft" FPGA IP cores.
+ *
+ * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ * Documentation:
+ * https://www.microsemi.com/document-portal/doc_download/1245275-corepwm-hb
+ *
+ * Limitations:
+ * - If the IP block is configured without "shadow registers", all register
+ *   writes will take effect immediately, causing glitches on the output.
+ *   If shadow registers *are* enabled, a write to the "SYNC_UPDATE" register
+ *   notifies the core that it needs to update the registers defining the
+ *   waveform from the contents of the "shadow registers".
+ * - The IP block has no concept of a duty cycle, only rising/falling edges of
+ *   the waveform. Unfortunately, if the rising & falling edges registers have
+ *   the same value written to them the IP block will do whichever of a rising
+ *   or a falling edge is possible. I.E. a 50% waveform at twice the requested
+ *   period. Therefore to get a 0% waveform, the output is set the max high/low
+ *   time depending on polarity.
+ * - The PWM period is set for the whole IP block not per channel. The driver
+ *   will only change the period if no other PWM output is enabled.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/ktime.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define PREG_TO_VAL(PREG) ((PREG) + 1)
+
+#define MCHPCOREPWM_PRESCALE_MAX	0x100
+#define MCHPCOREPWM_PERIOD_STEPS_MAX	0xff
+#define MCHPCOREPWM_PERIOD_MAX		0xff00
+
+#define MCHPCOREPWM_PRESCALE	0x00
+#define MCHPCOREPWM_PERIOD	0x04
+#define MCHPCOREPWM_EN(i)	(0x08 + 0x04 * (i)) /* 0x08, 0x0c */
+#define MCHPCOREPWM_POSEDGE(i)	(0x10 + 0x08 * (i)) /* 0x10, 0x18, ..., 0x88 */
+#define MCHPCOREPWM_NEGEDGE(i)	(0x14 + 0x08 * (i)) /* 0x14, 0x1c, ..., 0x8c */
+#define MCHPCOREPWM_SYNC_UPD	0xe4
+#define MCHPCOREPWM_TIMEOUT_MS	100u
+
+struct mchp_core_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	struct mutex lock; /* protect the shared period */
+	ktime_t update_timestamp;
+	u32 sync_update_mask;
+	u16 channel_enabled;
+};
+
+static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mchp_core_pwm_chip, chip);
+}
+
+static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+				 bool enable, u64 period)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u8 channel_enable, reg_offset, shift;
+
+	/*
+	 * There are two adjacent 8 bit control regs, the lower reg controls
+	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
+	 * and if so, offset by the bus width.
+	 */
+	reg_offset = MCHPCOREPWM_EN(pwm->hwpwm >> 3);
+	shift = pwm->hwpwm & 7;
+
+	channel_enable = readb_relaxed(mchp_core_pwm->base + reg_offset);
+	channel_enable &= ~(1 << shift);
+	channel_enable |= (enable << shift);
+
+	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
+	mchp_core_pwm->channel_enabled &= ~BIT(pwm->hwpwm);
+	mchp_core_pwm->channel_enabled |= enable << pwm->hwpwm;
+
+	/*
+	 * Notify the block to update the waveform from the shadow registers.
+	 * The updated values will not appear on the bus until they have been
+	 * applied to the waveform at the beginning of the next period.
+	 * This is a NO-OP if the channel does not have shadow registers.
+	 */
+	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm))
+		mchp_core_pwm->update_timestamp = ktime_add_ns(ktime_get(), period);
+}
+
+static void mchp_core_pwm_wait_for_sync_update(struct mchp_core_pwm_chip *mchp_core_pwm,
+					       unsigned int channel)
+{
+	/*
+	 * If a shadow register is used for this PWM channel, and iff there is
+	 * a pending update to the waveform, we must wait for it to be applied
+	 * before attempting to read its state. Reading the registers yields
+	 * the currently implemented settings & the new ones are only readable
+	 * once the current period has ended.
+	 */
+
+	if (mchp_core_pwm->sync_update_mask & (1 << channel)) {
+		ktime_t current_time = ktime_get();
+		s64 remaining_ns;
+		u32 delay_us;
+
+		remaining_ns = ktime_to_ns(ktime_sub(mchp_core_pwm->update_timestamp,
+						     current_time));
+
+		/*
+		 * If the update has gone through, don't bother waiting for
+		 * obvious reasons. Otherwise wait around for an appropriate
+		 * amount of time for the update to go through.
+		 */
+		if (remaining_ns <= 0)
+			return;
+
+		delay_us = DIV_ROUND_UP_ULL(remaining_ns, NSEC_PER_USEC);
+		if ((delay_us / 1000) > MAX_UDELAY_MS)
+			msleep(delay_us / 1000 + 1);
+		else
+			usleep_range(delay_us, delay_us * 2);
+	}
+}
+
+static u64 mchp_core_pwm_calc_duty(const struct pwm_state *state, u64 clk_rate,
+				   u8 prescale, u8 period_steps)
+{
+	u64 duty_steps, tmp;
+	u16 prescale_val = PREG_TO_VAL(prescale);
+
+	/*
+	 * Calculate the duty cycle in multiples of the prescaled period:
+	 * duty_steps = duty_in_ns / step_in_ns
+	 * step_in_ns = (prescale * NSEC_PER_SEC) / clk_rate
+	 * The code below is rearranged slightly to only divide once.
+	 */
+	tmp = prescale_val * NSEC_PER_SEC;
+	duty_steps = mul_u64_u64_div_u64(state->duty_cycle, clk_rate, tmp);
+
+	return duty_steps;
+}
+
+static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_device *pwm,
+				     const struct pwm_state *state, u64 duty_steps,
+				     u8 period_steps)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u8 posedge, negedge;
+	u8 period_steps_val = PREG_TO_VAL(period_steps);
+
+	/*
+	 * Setting posedge == negedge doesn't yield a constant output,
+	 * so that's an unsuitable setting to model duty_steps = 0.
+	 * In that case set the unwanted edge to a value that never
+	 * triggers.
+	 */
+	if (state->polarity == PWM_POLARITY_INVERSED) {
+		negedge = !duty_steps ? period_steps_val : 0u;
+		posedge = duty_steps;
+	} else {
+		posedge = !duty_steps ? period_steps_val : 0u;
+		negedge = duty_steps;
+	}
+
+	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
+	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
+}
+
+static void mchp_core_pwm_calc_period(const struct pwm_state *state, unsigned long clk_rate,
+				      u16 *prescale, u8 *period_steps)
+{
+	u64 tmp;
+
+	/*
+	 * Calculate the period cycles and prescale values.
+	 * The registers are each 8 bits wide & multiplied to compute the period
+	 * using the formula:
+	 * (clock_period) * (prescale + 1) * (period_steps + 1)
+	 * so the maximum period that can be generated is 0x10000 times the
+	 * period of the input clock.
+	 * However, due to the design of the "hardware", it is not possible to
+	 * attain a 100% duty cycle if the full range of period_steps is used.
+	 * Therefore period_steps is restricted to 0xFE and the maximum multiple
+	 * of the clock period attainable is 0xFF00.
+	 */
+	tmp = mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
+
+	/*
+	 * The hardware adds one to the register value, so decrement by one to
+	 * account for the offset
+	 */
+	if (tmp >= MCHPCOREPWM_PERIOD_MAX) {
+		*prescale = MCHPCOREPWM_PRESCALE_MAX - 1;
+		*period_steps = MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
+
+		return;
+	}
+
+	*prescale = div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
+	/* PREG_TO_VAL() can produce a value larger than UINT8_MAX */
+	*period_steps = div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
+}
+
+static inline void mchp_core_pwm_apply_period(struct mchp_core_pwm_chip *mchp_core_pwm,
+					      u8 prescale, u8 period_steps)
+{
+	writel_relaxed(prescale, mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+	writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
+}
+
+static int mchp_core_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
+				      const struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	bool period_locked;
+	unsigned long clk_rate;
+	u64 duty_steps;
+	u16 prescale;
+	u8 period_steps;
+
+	if (!state->enabled) {
+		mchp_core_pwm_enable(chip, pwm, false, pwm->state.period);
+		return 0;
+	}
+
+	/*
+	 * If clk_rate is too big, the following multiplication might overflow.
+	 * However this is implausible, as the fabric of current FPGAs cannot
+	 * provide clocks at a rate high enough.
+	 */
+	clk_rate = clk_get_rate(mchp_core_pwm->clk);
+	if (clk_rate >= NSEC_PER_SEC)
+		return -EINVAL;
+
+	mchp_core_pwm_calc_period(state, clk_rate, &prescale, &period_steps);
+
+	/*
+	 * If the only thing that has changed is the duty cycle or the polarity,
+	 * we can shortcut the calculations and just compute/apply the new duty
+	 * cycle pos & neg edges
+	 * As all the channels share the same period, do not allow it to be
+	 * changed if any other channels are enabled.
+	 * If the period is locked, it may not be possible to use a period
+	 * less than that requested. In that case, we just abort.
+	 */
+	period_locked = mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
+
+	if (period_locked) {
+		u16 hw_prescale;
+		u8 hw_period_steps;
+
+		hw_prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+		hw_period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
+
+		if ((period_steps + 1) * (prescale + 1) <
+		    (hw_period_steps + 1) * (hw_prescale + 1))
+			return -EINVAL;
+
+		/*
+		 * It is possible that something could have set the period_steps
+		 * register to 0xff, which would prevent us from setting a 100%
+		 * or 0% relative duty cycle, as explained above in
+		 * mchp_core_pwm_calc_period().
+		 * The period is locked and we cannot change this, so we abort.
+		 */
+		if (hw_period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX)
+			return -EINVAL;
+
+		prescale = hw_prescale;
+		period_steps = hw_period_steps;
+	} else {
+		mchp_core_pwm_apply_period(mchp_core_pwm, prescale, period_steps);
+	}
+
+	duty_steps = mchp_core_pwm_calc_duty(state, clk_rate, prescale, period_steps);
+
+	/*
+	 * Because the period is per channel, it is possible that the requested
+	 * duty cycle is longer than the period, in which case cap it to the
+	 * period, IOW a 100% duty cycle.
+	 */
+	if (duty_steps > period_steps)
+		duty_steps = period_steps + 1;
+
+	mchp_core_pwm_apply_duty(chip, pwm, state, duty_steps, period_steps);
+
+	mchp_core_pwm_enable(chip, pwm, true, pwm->state.period);
+
+	return 0;
+}
+
+static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	int ret;
+
+	mutex_lock(&mchp_core_pwm->lock);
+
+	mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
+
+	ret = mchp_core_pwm_apply_locked(chip, pwm, state);
+
+	mutex_unlock(&mchp_core_pwm->lock);
+
+	return ret;
+}
+
+static int mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u64 rate;
+	u16 prescale;
+	u8 period_steps, duty_steps, posedge, negedge;
+
+	mutex_lock(&mchp_core_pwm->lock);
+
+	mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
+
+	if (mchp_core_pwm->channel_enabled & (1 << pwm->hwpwm))
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	rate = clk_get_rate(mchp_core_pwm->clk);
+
+	prescale = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE));
+
+	period_steps = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD));
+	state->period = period_steps * prescale;
+	state->period *= NSEC_PER_SEC;
+	state->period = DIV64_U64_ROUND_UP(state->period, rate);
+
+	posedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
+	negedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
+
+	mutex_unlock(&mchp_core_pwm->lock);
+
+	if (negedge == posedge) {
+		state->duty_cycle = state->period;
+		state->period *= 2;
+	} else {
+		duty_steps = abs((s16)posedge - (s16)negedge);
+		state->duty_cycle = duty_steps * prescale * NSEC_PER_SEC;
+		state->duty_cycle = DIV64_U64_ROUND_UP(state->duty_cycle, rate);
+	}
+
+	state->polarity = negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops mchp_core_pwm_ops = {
+	.apply = mchp_core_pwm_apply,
+	.get_state = mchp_core_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id mchp_core_of_match[] = {
+	{
+		.compatible = "microchip,corepwm-rtl-v4",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mchp_core_of_match);
+
+static int mchp_core_pwm_probe(struct platform_device *pdev)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm;
+	struct resource *regs;
+	int ret;
+
+	mchp_core_pwm = devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GFP_KERNEL);
+	if (!mchp_core_pwm)
+		return -ENOMEM;
+
+	mchp_core_pwm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
+	if (IS_ERR(mchp_core_pwm->base))
+		return PTR_ERR(mchp_core_pwm->base);
+
+	mchp_core_pwm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(mchp_core_pwm->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(mchp_core_pwm->clk),
+				     "failed to get PWM clock\n");
+
+	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask",
+				 &mchp_core_pwm->sync_update_mask))
+		mchp_core_pwm->sync_update_mask = 0;
+
+	mutex_init(&mchp_core_pwm->lock);
+
+	mchp_core_pwm->chip.dev = &pdev->dev;
+	mchp_core_pwm->chip.ops = &mchp_core_pwm_ops;
+	mchp_core_pwm->chip.npwm = 16;
+
+	mchp_core_pwm->channel_enabled = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0));
+	mchp_core_pwm->channel_enabled |=
+		readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(1)) << 8;
+
+	ret = devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+
+	/*
+	 * Enabled synchronous update for channels with shadow registers
+	 * enabled. For channels without shadow registers, this has no effect
+	 * at all so is unconditionally enabled.
+	 */
+	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
+	mchp_core_pwm->update_timestamp = ktime_get();
+
+	return 0;
+}
+
+static struct platform_driver mchp_core_pwm_driver = {
+	.driver = {
+		.name = "mchp-core-pwm",
+		.of_match_table = mchp_core_of_match,
+	},
+	.probe = mchp_core_pwm_probe,
+};
+module_platform_driver(mchp_core_pwm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("corePWM driver for Microchip FPGAs");
-- 
2.38.1

