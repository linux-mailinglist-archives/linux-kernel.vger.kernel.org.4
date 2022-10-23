Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA2609220
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJWJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiJWJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:50:42 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD03ECD0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518547; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3M9dCoUiG7SdzuIW6iaf9KAa+/qkvhEMPsTc9+Iggvw=;
        b=Hu+oDwDkdnYZX6c5HGfyuyRIFGXcLqOLji3RgwBRZ+GeLGd5dcKaBrd9841snyAius7VDJ
        QzIVd3YQBUbp29WD/XwyqhT/wfhuWldPSFkkqGJ4dvjgMdOD21GNC7l6SooEacairfkNxu
        7+pX0qcDiCtlUui5J/nBk3vSaICD9Fk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 08/28] mfd: stpmic1: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:32 +0100
Message-Id: <20221023094852.8035-9-paul@crapouillou.net>
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
---
 drivers/mfd/stpmic1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index eb3da558c3fb..7d8b0c0548fe 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -162,7 +162,6 @@ static int stpmic1_probe(struct i2c_client *i2c,
 	return devm_of_platform_populate(dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stpmic1_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -187,9 +186,8 @@ static int stpmic1_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(stpmic1_pm, stpmic1_suspend, stpmic1_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stpmic1_pm, stpmic1_suspend, stpmic1_resume);
 
 static const struct of_device_id stpmic1_of_match[] = {
 	{ .compatible = "st,stpmic1", },
@@ -201,7 +199,7 @@ static struct i2c_driver stpmic1_driver = {
 	.driver = {
 		.name = "stpmic1",
 		.of_match_table = of_match_ptr(stpmic1_of_match),
-		.pm = &stpmic1_pm,
+		.pm = pm_sleep_ptr(&stpmic1_pm),
 	},
 	.probe = stpmic1_probe,
 };
-- 
2.35.1

