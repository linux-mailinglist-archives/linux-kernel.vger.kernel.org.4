Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120A760922D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJWJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJWJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:53:52 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE32857227
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518555; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDdXMBaOyK7oXLIUXU8KO8h1827AMeVClKPmuTxxjYw=;
        b=UVcgkd2hqBcVTDUblKW3Y+9nk5/fMeVVyGZYIWvhDzaCIWOkUxmwBQdyN3JQupoMFszBVp
        yI+asK4EPSJltpmZ7zS7Caj/JDgmv3A6Eva7yNng/Ed+fBnDg482KqaaeuLKQ0ThFT1T3h
        b6DQA5qDSaJPv3K1ERHiG5kKTzsyI1g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 21/28] mfd: max77686: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:45 +0100
Message-Id: <20221023094852.8035-22-paul@crapouillou.net>
In-Reply-To: <20221023094852.8035-1-paul@crapouillou.net>
References: <20221023094852.8035-1-paul@crapouillou.net>
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

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/max77686.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 2ac64277fb84..f8e863f3fc95 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -226,7 +226,6 @@ static int max77686_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max77686_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -261,14 +260,13 @@ static int max77686_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(max77686_pm, max77686_suspend, max77686_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(max77686_pm, max77686_suspend, max77686_resume);
 
 static struct i2c_driver max77686_i2c_driver = {
 	.driver = {
 		   .name = "max77686",
-		   .pm = &max77686_pm,
+		   .pm = pm_sleep_ptr(&max77686_pm),
 		   .of_match_table = max77686_pmic_dt_match,
 	},
 	.probe_new = max77686_i2c_probe,
-- 
2.35.1

