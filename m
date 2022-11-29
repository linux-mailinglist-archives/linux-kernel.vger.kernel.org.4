Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C257363C842
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiK2TXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiK2TXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:23:08 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A939871F34;
        Tue, 29 Nov 2022 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749604; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xhXji4Y+jhqcOTFhwZwVtyTneAtmSmQbVx8ey6pfJQ=;
        b=SzUFz0XtJ4YpefbdR3mI5Ff+SUtGRV9becw/4NPtLVcjWh8MC+kmiDcXNcTSfqfOewQXiC
        gr+XKa4d+90PNCZg3w+KQL1jDRL6p0VMl1jJMvg/+AvpugtlnsjvCZ2oSfK/MmKah7Fw0V
        4LA1jwFn+vpghGDsuax9H3egmlUy2iA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 20/26] drm: tegra: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:19:36 +0000
Message-Id: <20221129191942.138244-7-paul@crapouillou.net>
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
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
---
 drivers/gpu/drm/tegra/dpaux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 7dc681e2ee90..3c84e73d5051 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -598,7 +598,6 @@ static int tegra_dpaux_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int tegra_dpaux_suspend(struct device *dev)
 {
 	struct tegra_dpaux *dpaux = dev_get_drvdata(dev);
@@ -657,10 +656,9 @@ static int tegra_dpaux_resume(struct device *dev)
 	clk_disable_unprepare(dpaux->clk);
 	return err;
 }
-#endif
 
 static const struct dev_pm_ops tegra_dpaux_pm_ops = {
-	SET_RUNTIME_PM_OPS(tegra_dpaux_suspend, tegra_dpaux_resume, NULL)
+	RUNTIME_PM_OPS(tegra_dpaux_suspend, tegra_dpaux_resume, NULL)
 };
 
 static const struct tegra_dpaux_soc tegra124_dpaux_soc = {
@@ -694,7 +692,7 @@ struct platform_driver tegra_dpaux_driver = {
 	.driver = {
 		.name = "tegra-dpaux",
 		.of_match_table = tegra_dpaux_of_match,
-		.pm = &tegra_dpaux_pm_ops,
+		.pm = pm_ptr(&tegra_dpaux_pm_ops),
 	},
 	.probe = tegra_dpaux_probe,
 	.remove = tegra_dpaux_remove,
-- 
2.35.1

