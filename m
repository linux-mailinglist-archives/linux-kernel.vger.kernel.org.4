Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5A728233
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjFHOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjFHOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:06:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF52722
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:06:25 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1q7GHK-0007QF-H0; Thu, 08 Jun 2023 16:06:18 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
Date:   Thu, 08 Jun 2023 16:06:02 +0200
Subject: [PATCH] pwm: stm32: Implement .get_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-pwm-stm32-get-state-v1-1-db7e58a7461b@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAErggWQC/x2N0QqDMAxFf0XyvECtQ2W/MvaQtpkGtJOmbgPx3
 xf2ds+FwzlAuQgr3JoDCr9F5ZUN2ksDcaY8MUoyBu9853o34vZZUevaeZy42qLKeG3dECKlNIw9
 mBlIGUOhHGdz874sdm6Fn/L9p+6P8/wBf0QZ1HoAAAA=
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.12-dev-aab37
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop stm32_pwm_detect_channels() from disabling all channels and count
the number of enabled PWMs to keep the clock running. Implement the
&pwm_ops->get_state callback so drivers can inherit PWM state set by
the bootloader.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Make the necessary changes to allow inheriting PWM state set by the
bootloader, for example to avoid flickering with a pre-enabled PWM
backlight.
---
 drivers/pwm/pwm-stm32.c | 75 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 62e397aeb9aa..e0677c954bdf 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -52,6 +52,21 @@ static u32 active_channels(struct stm32_pwm *dev)
 	return ccer & TIM_CCER_CCXE;
 }
 
+static int read_ccrx(struct stm32_pwm *dev, int ch, u32 *value)
+{
+	switch (ch) {
+	case 0:
+		return regmap_read(dev->regmap, TIM_CCR1, value);
+	case 1:
+		return regmap_read(dev->regmap, TIM_CCR2, value);
+	case 2:
+		return regmap_read(dev->regmap, TIM_CCR3, value);
+	case 3:
+		return regmap_read(dev->regmap, TIM_CCR4, value);
+	}
+	return -EINVAL;
+}
+
 static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
 {
 	switch (ch) {
@@ -486,9 +501,40 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static int stm32_pwm_get_state(struct pwm_chip *chip,
+			       struct pwm_device *pwm, struct pwm_state *state)
+{
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	int ch = pwm->hwpwm;
+	unsigned long rate;
+	u32 ccer, psc, arr, ccr;
+	u64 dty, prd;
+	int ret;
+
+	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
+	if (ret)
+		return ret;
+
+	state->enabled = ccer & (TIM_CCER_CC1E << (ch * 4));
+	state->polarity = (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	regmap_read(priv->regmap, TIM_PSC, &psc);
+	regmap_read(priv->regmap, TIM_ARR, &arr);
+	read_ccrx(priv, ch, &ccr);
+	rate = clk_get_rate(priv->clk);
+
+	prd = (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);
+	state->period = DIV_ROUND_UP_ULL(prd, rate);
+	dty = (u64)NSEC_PER_SEC * (psc + 1) * ccr;
+	state->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
+
+	return ret;
+}
+
 static const struct pwm_ops stm32pwm_ops = {
 	.owner = THIS_MODULE,
 	.apply = stm32_pwm_apply_locked,
+	.get_state = stm32_pwm_get_state,
 	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
 };
 
@@ -579,30 +625,22 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
 	priv->have_complementary_output = (ccer != 0);
 }
 
-static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
+static int stm32_pwm_detect_channels(struct stm32_pwm *priv, int *n_enabled)
 {
-	u32 ccer;
-	int npwm = 0;
+	u32 ccer, ccer_backup;
+	int npwm;
 
 	/*
 	 * If channels enable bits don't exist writing 1 will have no
 	 * effect so we can detect and count them.
 	 */
+	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
 	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
+	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
 
-	if (ccer & TIM_CCER_CC1E)
-		npwm++;
-
-	if (ccer & TIM_CCER_CC2E)
-		npwm++;
-
-	if (ccer & TIM_CCER_CC3E)
-		npwm++;
-
-	if (ccer & TIM_CCER_CC4E)
-		npwm++;
+	npwm = hweight32(ccer & TIM_CCER_CCXE);
+	*n_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
 
 	return npwm;
 }
@@ -613,7 +651,9 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_pwm *priv;
+	int n_enabled;
 	int ret;
+	int i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -635,7 +675,10 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	priv->chip.dev = dev;
 	priv->chip.ops = &stm32pwm_ops;
-	priv->chip.npwm = stm32_pwm_detect_channels(priv);
+	priv->chip.npwm = stm32_pwm_detect_channels(priv, &n_enabled);
+
+	for (i = 0; i < n_enabled; i++)
+		clk_enable(priv->clk);
 
 	ret = pwmchip_add(&priv->chip);
 	if (ret < 0)

---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230608-pwm-stm32-get-state-4107bcadd786

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>
