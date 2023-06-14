Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C504C7305CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjFNRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjFNRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:15:06 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698A1BE8;
        Wed, 14 Jun 2023 10:15:03 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q9U5C-00Exj3-Uq; Wed, 14 Jun 2023 18:14:59 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1q9U5C-000I0p-0v;
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
Subject: [PATCH v8 2/5] pwm: dwc: make timer clock configurable
Date:   Wed, 14 Jun 2023 18:14:54 +0100
Message-Id: <20230614171457.69191-3-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614171457.69191-1-ben.dooks@sifive.com>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configurable clock base rate for the pwm as when being built
for non-PCI the block may be sourced from an internal clock.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v8:
 - add reviewed by, fixed issue with previous renames.
v7:
 - remove the "struct clk *" clk field from dwc_pwm_ctx, not used here,
v6:
 - removed DWC_CLK_PERIOD_NS as it is now not needed
v4:
 - moved earlier before the of changes to make the of changes one patch
v2:
  - removed the ifdef and merged the other clock patch in here
---
 drivers/pwm/pwm-dwc-core.c | 9 +++++----
 drivers/pwm/pwm-dwc.h      | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index b693cb7fa812..4b4b7b9e1d82 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -49,13 +49,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
+	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
 	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    DWC_CLK_PERIOD_NS);
+				    dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -130,12 +130,12 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	duty += 1;
-	duty *= DWC_CLK_PERIOD_NS;
+	duty *= dwc->clk_ns;
 	state->duty_cycle = duty;
 
 	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 	period += 1;
-	period *= DWC_CLK_PERIOD_NS;
+	period *= dwc->clk_ns;
 	period += duty;
 	state->period = period;
 
@@ -160,6 +160,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
+	dwc->clk_ns = 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 56deab4e28ec..64795247c54c 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS(dwc_pwm);
 #define DWC_TIMERS_COMP_VERSION	0xac
 
 #define DWC_TIMERS_TOTAL	8
-#define DWC_CLK_PERIOD_NS	10
 
 /* Timer Control Register */
 #define DWC_TIM_CTRL_EN		BIT(0)
@@ -43,6 +42,7 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-- 
2.39.2

