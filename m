Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4366A63C7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiK2TTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiK2TTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:19:02 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144965B851;
        Tue, 29 Nov 2022 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749478; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3kGaBl+P4U1/h949YafFHG5seRrZ54TXepde/Fhij8=;
        b=kwEYPgxoRUvmgmDZgDfr7K/4Nn5SbezOwCc0k/h3X080oKq9a9Xj70tanEW+KEEOVuPxpJ
        rL45gmZBqARfV7xGUCwObl2/Edrqr2czan00pClSefHDumeRA65jH//CWM7h5mxiEOgXIR
        ggmTDVYzhX+bVVSx1kFWhbvczDnvX6o=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 05/26] drm: tegra: Define and use generic PM ops
Date:   Tue, 29 Nov 2022 19:17:12 +0000
Message-Id: <20221129191733.137897-6-paul@crapouillou.net>
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

Use the new DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS() macro to create a
"struct dev_pm_ops" that can be used by this driver, instead of using
custom PM callbacks with the same behaviour.

v2: Use the DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS() macro instead of an
    exported dev_pm_ops.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
---
 drivers/gpu/drm/tegra/drm.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index a1f909dac89a..c844444ff522 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1329,25 +1329,6 @@ static int host1x_drm_remove(struct host1x_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int host1x_drm_suspend(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-
-	return drm_mode_config_helper_suspend(drm);
-}
-
-static int host1x_drm_resume(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-
-	return drm_mode_config_helper_resume(drm);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(host1x_drm_pm_ops, host1x_drm_suspend,
-			 host1x_drm_resume);
-
 static const struct of_device_id host1x_drm_subdevs[] = {
 	{ .compatible = "nvidia,tegra20-dc", },
 	{ .compatible = "nvidia,tegra20-hdmi", },
@@ -1389,10 +1370,12 @@ static const struct of_device_id host1x_drm_subdevs[] = {
 	{ /* sentinel */ }
 };
 
+DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS(tegra_pm_ops);
+
 static struct host1x_driver host1x_drm_driver = {
 	.driver = {
 		.name = "drm",
-		.pm = &host1x_drm_pm_ops,
+		.pm = pm_sleep_ptr(&tegra_pm_ops),
 	},
 	.probe = host1x_drm_probe,
 	.remove = host1x_drm_remove,
-- 
2.35.1

