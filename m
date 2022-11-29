Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF3263C846
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiK2TYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiK2TYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:24:20 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C24B6D4A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749650; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1RX/ZzdghYIWu8xoGXfoZAVlUhjaMzV0pc+gin64as=;
        b=3OHE2ic0oVpFuxqPpyT/Mdaw8vhcmHTmDgShalr2vdOMtgU5/1cDtGIHY/R3cgU4ilZQ05
        rXDgQkFqIejTG6ONSv2LH+xtVA0yM0dFxPgd18IEAU4J2zBcSUjXjRi0UoEvPITs32F0vv
        UKHgf7gGZwN2SbUobuvcqHtqQsSI3Ao=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 23/26] drm: vc4: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:19:39 +0000
Message-Id: <20221129191942.138244-10-paul@crapouillou.net>
In-Reply-To: <20221129191942.138244-1-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
 <20221129191942.138244-1-paul@crapouillou.net>
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

Use the RUNTIME_PM_OPS() and pm_ptr() macros to handle the
.runtime_suspend/.runtime_resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_PM is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Emma Anholt <emma@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 56abb0d6bc39..6000c7032b92 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -368,7 +368,6 @@ void vc4_v3d_bin_bo_put(struct vc4_dev *vc4)
 	mutex_unlock(&vc4->bin_bo_lock);
 }
 
-#ifdef CONFIG_PM
 static int vc4_v3d_runtime_suspend(struct device *dev)
 {
 	struct vc4_v3d *v3d = dev_get_drvdata(dev);
@@ -397,7 +396,6 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 int vc4_v3d_debugfs_init(struct drm_minor *minor)
 {
@@ -525,7 +523,7 @@ static void vc4_v3d_unbind(struct device *dev, struct device *master,
 }
 
 static const struct dev_pm_ops vc4_v3d_pm_ops = {
-	SET_RUNTIME_PM_OPS(vc4_v3d_runtime_suspend, vc4_v3d_runtime_resume, NULL)
+	RUNTIME_PM_OPS(vc4_v3d_runtime_suspend, vc4_v3d_runtime_resume, NULL)
 };
 
 static const struct component_ops vc4_v3d_ops = {
@@ -557,6 +555,6 @@ struct platform_driver vc4_v3d_driver = {
 	.driver = {
 		.name = "vc4_v3d",
 		.of_match_table = vc4_v3d_dt_match,
-		.pm = &vc4_v3d_pm_ops,
+		.pm = pm_ptr(&vc4_v3d_pm_ops),
 	},
 };
-- 
2.35.1

