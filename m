Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22BC63C826
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiK2TU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiK2TUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:20:01 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332936A75F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749487; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQiyTX8wK8bz1FK4zLI6UMcS5iFl/EIYvLZ25w1z2hk=;
        b=UlZUjdqIcjHt0kk5+sXN+BbX4J3j2MtOsL/0PflEA0D3qoy5E1E2fGM88f29OjxBCmzgOl
        0WfpBy7Xq9RhO88Nyq3YIZLqr6HVEkyjYIf47Q742qRyBaCLkHD8QzJGyRSonTAMRgnAap
        ZhAfRnXaME+QL3T5JfTA2tnSOAzECjs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Stefan Agner <stefan@agner.ch>,
        Alison Wang <alison.wang@nxp.com>
Subject: [PATCH v2 13/26] drm: fsl-dcu: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:17:20 +0000
Message-Id: <20221129191733.137897-14-paul@crapouillou.net>
In-Reply-To: <20221129191733.137897-1-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
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

Use the DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros to handle
the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Stefan Agner <stefan@agner.ch>
Cc: Alison Wang <alison.wang@nxp.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 8579c7629f5e..474ad45c73be 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -164,7 +164,6 @@ static const struct drm_driver fsl_dcu_drm_driver = {
 	.minor			= 1,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int fsl_dcu_drm_pm_suspend(struct device *dev)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
@@ -209,11 +208,9 @@ static int fsl_dcu_drm_pm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops fsl_dcu_drm_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(fsl_dcu_drm_pm_suspend, fsl_dcu_drm_pm_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(fsl_dcu_drm_pm_ops,
+				fsl_dcu_drm_pm_suspend, fsl_dcu_drm_pm_resume);
 
 static const struct fsl_dcu_soc_data fsl_dcu_ls1021a_data = {
 	.name = "ls1021a",
@@ -363,7 +360,7 @@ static struct platform_driver fsl_dcu_drm_platform_driver = {
 	.remove		= fsl_dcu_drm_remove,
 	.driver		= {
 		.name	= "fsl-dcu",
-		.pm	= &fsl_dcu_drm_pm_ops,
+		.pm	= pm_sleep_ptr(&fsl_dcu_drm_pm_ops),
 		.of_match_table = fsl_dcu_of_match,
 	},
 };
-- 
2.35.1

