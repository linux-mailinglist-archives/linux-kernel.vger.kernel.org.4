Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657777305C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFNRPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjFNRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:15:05 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A381BF0;
        Wed, 14 Jun 2023 10:15:03 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q9U5D-00Exj2-C7; Wed, 14 Jun 2023 18:14:59 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1q9U5C-000I0t-0z;
        Wed, 14 Jun 2023 18:14:58 +0100
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v8 3/5] pwm: dwc: add PWM bit unset in get_state call
Date:   Wed, 14 Jun 2023 18:14:55 +0100
Message-Id: <20230614171457.69191-4-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614171457.69191-1-ben.dooks@sifive.com>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are not in PWM mode, then the output is technically a 50%
output based on a single timer instead of the high-low based on
the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.

This may only be an issue on initialisation, as the rest of the
code currently assumes we're always going to have the extended
PWM mode using two counters.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v8:
 - fixed rename issues
v4:
 - fixed review comment on mulit-line calculations
---
 drivers/pwm/pwm-dwc-core.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 4b4b7b9e1d82..38cd2163fe01 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -122,24 +122,31 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	u64 duty, period;
+	u32 ctrl, ld, ld2;
 
 	pm_runtime_get_sync(chip->dev);
 
-	state->enabled = !!(dwc_pwm_readl(dwc,
-				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
+	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
+	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
+	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 
-	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
-	duty += 1;
-	duty *= dwc->clk_ns;
-	state->duty_cycle = duty;
+	state->enabled = !!(ctrl & DWC_TIM_CTRL_EN);
 
-	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
-	period += 1;
-	period *= dwc->clk_ns;
-	period += duty;
-	state->period = period;
+	/* If we're not in PWM, technically the output is a 50-50
+	 * based on the timer load-count only.
+	 */
+	if (ctrl & DWC_TIM_CTRL_PWM) {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = (ld2 + 1)  * dwc->clk_ns;
+		period += duty;
+	} else {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = duty * 2;
+	}
 
 	state->polarity = PWM_POLARITY_INVERSED;
+	state->period = period;
+	state->duty_cycle = duty;
 
 	pm_runtime_put_sync(chip->dev);
 
-- 
2.39.2

