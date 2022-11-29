Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C2F63C843
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiK2TX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbiK2TXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:23:36 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651A3720A5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749648; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byA101qNki62ObkCL8sU230sS3WvAvBk1eSOioaQ+Uo=;
        b=xqxyzatqfCp2mjbE69daFfXtIjZ4QvdVLh2PYEeHXgWkb3ZrlKAU17Gcn7E/yncUJGdXTD
        arvHBFkJyfH25CtDPs+dv84vwOhZ7Cyn8/NhBWVnL+iZj1WgOjaCAw/PzKdYQ0XVxGhwgX
        4d5Wok+WXHlhY7ju3rpmaCRY+80POEA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Jyri Sarha <jyri.sarhai@iki.fi>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>
Subject: [PATCH v2 21/26] drm: tilcdc: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:19:37 +0000
Message-Id: <20221129191942.138244-8-paul@crapouillou.net>
In-Reply-To: <20221129191942.138244-1-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
 <20221129191942.138244-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Jyri Sarha <jyri.sarhaı@iki.fi>
---
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomba@kernel.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 80615ecdae0b..4ca426007dc8 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -496,7 +496,6 @@ static const struct drm_driver tilcdc_driver = {
  * Power management:
  */
 
-#ifdef CONFIG_PM_SLEEP
 static int tilcdc_pm_suspend(struct device *dev)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
@@ -518,11 +517,9 @@ static int tilcdc_pm_resume(struct device *dev)
 	pinctrl_pm_select_default_state(dev);
 	return  drm_mode_config_helper_resume(ddev);
 }
-#endif
 
-static const struct dev_pm_ops tilcdc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(tilcdc_pm_suspend, tilcdc_pm_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(tilcdc_pm_ops,
+				tilcdc_pm_suspend, tilcdc_pm_resume);
 
 /*
  * Platform driver:
@@ -597,7 +594,7 @@ static struct platform_driver tilcdc_platform_driver = {
 	.remove     = tilcdc_pdev_remove,
 	.driver     = {
 		.name   = "tilcdc",
-		.pm     = &tilcdc_pm_ops,
+		.pm     = pm_sleep_ptr(&tilcdc_pm_ops),
 		.of_match_table = tilcdc_of_match,
 	},
 };
-- 
2.35.1

