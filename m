Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2C6DFA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjDLPha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjDLPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:37:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE503ABB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:37:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmcX6-0003bP-Ac; Wed, 12 Apr 2023 17:37:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmcX4-00AlqQ-Hk; Wed, 12 Apr 2023 17:37:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmcX3-00CeDT-To; Wed, 12 Apr 2023 17:37:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Lee Jones <lee@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH] counter: stm32-timer-cnt: Reset TIM_TISEL and TIM_SMCR to their default value
Date:   Wed, 12 Apr 2023 17:37:09 +0200
Message-Id: <20230412153709.3557323-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zc5B2LGRs54BHs4aCdePhpxua9fygSYRDSyPsSaXvAQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkNtAjdw2NqpObCpDcSjUHHwcgtWq3IXeDtu5dJ I147vXR/4mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZDbQIwAKCRCPgPtYfRL+ Tp3rB/9E4lY5pFlQ/4pLFl+7NMDzGTrTBIIBMaxCTZWaTETyfr5PUiCqal1MUl/FpK3Khbuvta3 JcXl5LfsAqib1UZUiBlJ66qf5ZlmzRh3T6t6W7GVkse1jkXL09lVsqYrSpkmWWer9Lw0nOIqoxX hKeAtgq8QLP58Uobmjj8roK9B0ksBexK5ExKmelOXbM+cRKpLPuUE1EKrk8Gfo06jg8M9TbbQiH JhFDgnqpvQjAtn9TKsW4myrklpeCbHSKt+W0SLtiPP2lSyi8Xsk3RV51ZjwrmTa4uIARJuISjLL HSucF4MYaDb5abCW18X9ZzjwO8SQVmjyLDrBmbfNuzMZEu9r
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver assumes that the input selection register (TIM_TISEL) is at
its reset default value. Usually this is the case, but the bootloader
might have modified it. Also reset the SMCR register while at it.

This bases on the effectively same patch submitted by Olivier Moysan for
pwm-stm32.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

note that the patch by Olivier Moysan[1] for pwm-stm32 is expected to
appear in Thierry's tree soon. It added the definition of TIM_TISEL in
the same way, so the two patches should merge just fine. Alternatively
you can commit it to a tree that already has the pwm change (and then
drop the change to include/linux/mfd/stm32-timers.h from this one).

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20221213102707.1096345-1-olivier.moysan@foss.st.com

 drivers/counter/stm32-timer-cnt.c | 4 ++++
 include/linux/mfd/stm32-timers.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 9bf20a5d6bda..d001d77f17ac 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -342,6 +342,10 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	/* Reset input selector to its default input and disable slave mode */
+	regmap_write(priv->regmap, TIM_TISEL, 0x0);
+	regmap_write(priv->regmap, TIM_SMCR, 0x0);
+
 	/* Register Counter device */
 	ret = devm_counter_add(dev, counter);
 	if (ret < 0)
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 5f5c43fd69dd..1b94325febb3 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -31,6 +31,7 @@
 #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
 #define TIM_DCR		0x48	/* DMA control register    */
 #define TIM_DMAR	0x4C	/* DMA register for transfer */
+#define TIM_TISEL	0x68	/* Input Selection         */
 
 #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
 #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

