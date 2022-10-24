Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5229760BEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJXXbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJXXbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:31:32 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC68E7AE;
        Mon, 24 Oct 2022 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666644742; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xak1hhi2ZXgbcAJgD44C+AwcAkXWEuIXNRLIGjZ6/V8=;
        b=BT7X4ojFfsnA/z0K4xQ9xt0xKjIe+Y3K9UTqeUi22nPxgECWzdT8xZj6o3SR86Aj5EFyQp
        mA3k4mYgDmL/0+hpBIM1GI1AEz0Bt2Trq6p/O5Z9ArFc1cHm13OatrZtQKO7Vo7rwBTckm
        PGfl/xO9c5iQmmHRmm54wy2LFaSfIdw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@opendingux.net, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] pwm: jz4740: Force dependency on Device Tree
Date:   Mon, 24 Oct 2022 21:52:11 +0100
Message-Id: <20221024205213.327001-4-paul@crapouillou.net>
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

Ingenic SoCs all require CONFIG_OF, so there is no case where we want to
use this driver without CONFIG_OF.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/Kconfig      |  2 +-
 drivers/pwm/pwm-jz4740.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..1fe420a45f91 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -283,7 +283,7 @@ config PWM_IQS620A
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MIPS || COMPILE_TEST
-	depends on COMMON_CLK
+	depends on COMMON_CLK && OF
 	select MFD_SYSCON
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 65462a0052af..c0afc0c316a8 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -269,19 +269,18 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	return devm_pwmchip_add(dev, &jz4740->chip);
 }
 
-static const struct soc_info __maybe_unused jz4740_soc_info = {
+static const struct soc_info jz4740_soc_info = {
 	.num_pwms = 8,
 };
 
-static const struct soc_info __maybe_unused jz4725b_soc_info = {
+static const struct soc_info jz4725b_soc_info = {
 	.num_pwms = 6,
 };
 
-static const struct soc_info __maybe_unused x1000_soc_info = {
+static const struct soc_info x1000_soc_info = {
 	.num_pwms = 5,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id jz4740_pwm_dt_ids[] = {
 	{ .compatible = "ingenic,jz4740-pwm", .data = &jz4740_soc_info },
 	{ .compatible = "ingenic,jz4725b-pwm", .data = &jz4725b_soc_info },
@@ -289,12 +288,11 @@ static const struct of_device_id jz4740_pwm_dt_ids[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-#endif
 
 static struct platform_driver jz4740_pwm_driver = {
 	.driver = {
 		.name = "jz4740-pwm",
-		.of_match_table = of_match_ptr(jz4740_pwm_dt_ids),
+		.of_match_table = jz4740_pwm_dt_ids,
 	},
 	.probe = jz4740_pwm_probe,
 };
-- 
2.35.1

