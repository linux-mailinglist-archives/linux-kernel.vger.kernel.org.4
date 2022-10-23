Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB1609226
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJWJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiJWJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:51:46 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DACE75FDA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518551; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VklgnW+uBOCoO+RRy4aqJ12OaIfCdghjrJSE0/tnQoc=;
        b=VAwl/6kfncV2uyXCN6oQ65qasZTcAlL1v5LXBI4n++1IXjBf9NTOsXuBouV+GbrXVdyn9s
        E1WmT5sZQUZd5c/BOXywoizANoLKuVfi1JnkBs+lKC2k+k4/uk077o/27ZZFJE59XiUL5X
        JmAGepzU2NX8mRZYrKfquHoDD8Ky3eM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 14/28] mfd: tc6387xb: Remove #ifdef guards for PM related functions
Date:   Sun, 23 Oct 2022 10:48:38 +0100
Message-Id: <20221023094852.8035-15-paul@crapouillou.net>
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
 drivers/mfd/tc6387xb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index e846e4d26b6e..5392da6ba7b0 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -40,7 +40,6 @@ static const struct resource tc6387xb_mmc_resources[] = {
 
 /*--------------------------------------------------------------------------*/
 
-#ifdef CONFIG_PM
 static int tc6387xb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
@@ -67,10 +66,6 @@ static int tc6387xb_resume(struct platform_device *dev)
 
 	return 0;
 }
-#else
-#define tc6387xb_suspend  NULL
-#define tc6387xb_resume   NULL
-#endif
 
 /*--------------------------------------------------------------------------*/
 
@@ -220,8 +215,8 @@ static struct platform_driver tc6387xb_platform_driver = {
 	},
 	.probe		= tc6387xb_probe,
 	.remove		= tc6387xb_remove,
-	.suspend        = tc6387xb_suspend,
-	.resume         = tc6387xb_resume,
+	.suspend        = pm_sleep_ptr(tc6387xb_suspend),
+	.resume         = pm_sleep_ptr(tc6387xb_resume),
 };
 
 module_platform_driver(tc6387xb_platform_driver);
-- 
2.35.1

