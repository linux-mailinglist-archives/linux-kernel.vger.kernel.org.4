Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233C760921A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJWJtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJWJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:49:20 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F96BCEE
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518544; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1iDgRdVM2mercE3ut+EO5L+yG7WE7yznsiwCD0Lt98=;
        b=TV0MZndoXOwRdei9zSfLhWa8OCd/Mx1VRctmJ+aRpmw2y0BpV5PBMUbL1ZHx4TdadNlq6O
        Q6s9CxhKrGZwCUCdcK249ntpNbNZLu5jar3PpZGFzs3TAaCJvVXZEv/9Ie8uN9526IFWF0
        x9hrx+LyPF/zcEb/yFrt+gvQZfwOXfo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 02/28] mfd: aat2870: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:26 +0100
Message-Id: <20221023094852.8035-3-paul@crapouillou.net>
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
 drivers/mfd/aat2870-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index a17cf759739d..8a3967c3f026 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -409,7 +409,6 @@ static int aat2870_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int aat2870_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -438,10 +437,9 @@ static int aat2870_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(aat2870_pm_ops, aat2870_i2c_suspend,
-			 aat2870_i2c_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(aat2870_pm_ops, aat2870_i2c_suspend,
+				aat2870_i2c_resume);
 
 static const struct i2c_device_id aat2870_i2c_id_table[] = {
 	{ "aat2870", 0 },
@@ -451,7 +449,7 @@ static const struct i2c_device_id aat2870_i2c_id_table[] = {
 static struct i2c_driver aat2870_i2c_driver = {
 	.driver = {
 		.name			= "aat2870",
-		.pm			= &aat2870_pm_ops,
+		.pm			= pm_sleep_ptr(&aat2870_pm_ops),
 		.suppress_bind_attrs	= true,
 	},
 	.probe		= aat2870_i2c_probe,
-- 
2.35.1

