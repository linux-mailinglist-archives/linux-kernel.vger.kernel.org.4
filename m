Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095CA609223
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJWJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiJWJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:51:07 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165E0564F9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518549; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kZIVuuKKO+sS/oNnpnJC3ag5t6waBzISKhOioOsnm4=;
        b=F7ZT/58jdkSWGmpsKrL/S1pQ/KE/OC+iTOv51KZIWLYATApCXwIuUB+deozMGhSSoahyip
        BS7uSBZffafdO6/98lczYrr542NPNbegeyQO2xXtC7tcjds7i6G9qMZYtW4Dl2Is3KfRsT
        sN9VWAtRaEqEfE4xC1yX6xsRceeUJlE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 11/28] mfd: mcp-sa11x0: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:35 +0100
Message-Id: <20221023094852.8035-12-paul@crapouillou.net>
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

Use the new pm_sleep_ptr() macro to handle the .suspend/.resume
callbacks.

This macro allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/mcp-sa11x0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 4629dff187cd..1c9831b78cf9 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -255,7 +255,6 @@ static int mcp_sa11x0_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mcp_sa11x0_suspend(struct device *dev)
 {
 	struct mcp_sa11x0 *m = priv(dev_get_drvdata(dev));
@@ -277,17 +276,14 @@ static int mcp_sa11x0_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops mcp_sa11x0_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
 	.suspend = mcp_sa11x0_suspend,
 	.freeze = mcp_sa11x0_suspend,
 	.poweroff = mcp_sa11x0_suspend,
 	.resume_noirq = mcp_sa11x0_resume,
 	.thaw_noirq = mcp_sa11x0_resume,
 	.restore_noirq = mcp_sa11x0_resume,
-#endif
 };
 
 static struct platform_driver mcp_sa11x0_driver = {
@@ -295,7 +291,7 @@ static struct platform_driver mcp_sa11x0_driver = {
 	.remove		= mcp_sa11x0_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
-		.pm	= &mcp_sa11x0_pm_ops,
+		.pm	= pm_sleep_ptr(&mcp_sa11x0_pm_ops),
 	},
 };
 
-- 
2.35.1

