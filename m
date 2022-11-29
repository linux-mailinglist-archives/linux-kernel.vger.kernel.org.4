Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79263C816
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiK2TUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiK2TTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:19:12 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051456D48F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749480; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJfb607OEPZzj5jgkFphMZxTPqxtnHJHM51G7bS3xhg=;
        b=NHeNnfajuJj9RKYJuLwf++m+ogVpTx5mJDmSLqyL7XYR/Sv/A8mIz8XsTQlKwTWAcwC8L5
        tMJKHInbAvfNrr0xxTdaa88NpD4bqf3cgKpPG+SlGkoBYqtCAlbq9OrAHuYzYK1wmkiCp5
        mMJ22m4Cwp4riY9CkZMFeJsyHG6w47c=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/26] drm: mxsfb: Define and use generic PM ops
Date:   Tue, 29 Nov 2022 19:17:14 +0000
Message-Id: <20221129191733.137897-8-paul@crapouillou.net>
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
Cc: Marek Vasut <marex@denx.de>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 810edea0a31e..c63d2eb3b379 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -398,25 +398,7 @@ static void mxsfb_shutdown(struct platform_device *pdev)
 	drm_atomic_helper_shutdown(drm);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mxsfb_suspend(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-
-	return drm_mode_config_helper_suspend(drm);
-}
-
-static int mxsfb_resume(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-
-	return drm_mode_config_helper_resume(drm);
-}
-#endif
-
-static const struct dev_pm_ops mxsfb_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mxsfb_suspend, mxsfb_resume)
-};
+DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS(mxsfb_pm_ops);
 
 static struct platform_driver mxsfb_platform_driver = {
 	.probe		= mxsfb_probe,
@@ -425,7 +407,7 @@ static struct platform_driver mxsfb_platform_driver = {
 	.driver	= {
 		.name		= "mxsfb",
 		.of_match_table	= mxsfb_dt_ids,
-		.pm		= &mxsfb_pm_ops,
+		.pm		= pm_sleep_ptr(&mxsfb_pm_ops),
 	},
 };
 
-- 
2.35.1

