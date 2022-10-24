Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6660BEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJXXcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJXXbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:31:46 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017771D4DFA;
        Mon, 24 Oct 2022 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666644743; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HPp+33aYNoQqAGKipSoPytGt3HFjbS0IYlzYnBXZnaU=;
        b=jmCmEXMjhFZ7z+eIBo9HtNqhmipvRftvCUfSkfxFDQLiBRNfB9VrBmbvT96g75zhyIZIce
        shnY8wpFnn7y/GovUG363mZ+WURakSFyv420pdTbBDBiPOx0yoe+99bQVAb/OULG5PUbgE
        R7g4gCSz49qRygDCKTsSTHba6xJ1CCw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@opendingux.net, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] pwm: jz4740: Use regmap_{set,clear}_bits
Date:   Mon, 24 Oct 2022 21:52:13 +0100
Message-Id: <20221024205213.327001-6-paul@crapouillou.net>
In-Reply-To: <20221024205213.327001-1-paul@crapouillou.net>
References: <20221024205213.327001-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify a bit the code by using regmap_set_bits() and
regmap_clear_bits() instead of regmap_update_bits() when possible.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index c0afc0c316a8..22fcdca66081 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -88,8 +88,7 @@ static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 
 	/* Enable PWM output */
-	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
-			   TCU_TCSR_PWM_EN, TCU_TCSR_PWM_EN);
+	regmap_set_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm), TCU_TCSR_PWM_EN);
 
 	/* Start counter */
 	regmap_write(jz->map, TCU_REG_TESR, BIT(pwm->hwpwm));
@@ -129,8 +128,7 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	 * In TCU2 mode (channel 1/2 on JZ4750+), this must be done before the
 	 * counter is stopped, while in TCU1 mode the order does not matter.
 	 */
-	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
-			   TCU_TCSR_PWM_EN, 0);
+	regmap_clear_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm), TCU_TCSR_PWM_EN);
 
 	/* Stop counter */
 	regmap_write(jz->map, TCU_REG_TECR, BIT(pwm->hwpwm));
@@ -204,8 +202,8 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
 
 	/* Set abrupt shutdown */
-	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
-			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
+	regmap_set_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+			TCU_TCSR_PWM_SD);
 
 	if (state->enabled) {
 		/*
-- 
2.35.1

