Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E064A63C7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiK2TSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiK2TR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:17:59 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEB20198
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749469; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gAnxaoVqEWoM5vi/BaBgxdiGzKVxjjTsGqnEeIglYs=;
        b=Lb3U8DMaMv86BzMM+cDyhB6ZOmgECsaSU4wa2llVOeq8427YF/e+LM6bLEc1eB2cFI1SR4
        cHxQpiRDgnycev9zdcpVoeoXS8zV88XDwRPGji+L3Mg5C3mOXy4zBHGWVfl5/M/4DS7Aw9
        BVcFIFgpdnmmm+0yq9xtiNKl35K8Sfs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 01/26] drm: modeset-helper: Add DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS macro
Date:   Tue, 29 Nov 2022 19:17:08 +0000
Message-Id: <20221129191733.137897-2-paul@crapouillou.net>
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

This macro can be used with simple drivers, which have their
"struct drm_device" registered as their "struct device"'s drvdata, and
only call drm_mode_config_pm_{suspend,resume}.

The macro will define a "struct dev_pm_ops" with the name passed as
argument. This object cannot be referenced directly; instead, the
pm_sleep_ptr() macro should be used, like this:

DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS(foo_pm_ops);

static struct platform_driver foo_driver = {
    .driver.pm = pm_sleep_ptr(&foo_pm_ops),
    ...
};

This ensures that the generated code will be dropped by the compiler in
the case where CONFIG_PM has been disabled in the config.

v2: instead of exporting a dev_pm_ops, introduce the
    DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS() macro.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/drm/drm_modeset_helper.h | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index 995fd981cab0..2ecf0e5c2e16 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -41,4 +41,42 @@ int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 int drm_mode_config_helper_suspend(struct drm_device *dev);
 int drm_mode_config_helper_resume(struct drm_device *dev);
 
+/**
+ * DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS - Generate simple PM callbacks
+ *
+ * This macro can be used by simple drivers that would otherwise only call
+ * drm_mode_config_helper_suspend / drm_mode_config_helper_resume in their PM
+ * callbacks. It will generate a struct dev_pm_ops of the given name, that can
+ * then be referenced in the device_driver structure.
+ *
+ * Note that it is only valid if the driver's drm_device has been registered as
+ * the struct device's drvdata.
+ *
+ * Additionally, the generated dev_pm_ops structure should not be referenced
+ * directly; instead, the pm_sleep_ptr() macro should be used, like this:
+ *
+ * DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS(foo_pm_ops);
+ *
+ * static struct platform_driver foo_driver = {
+ *	.driver.pm = pm_sleep_ptr(&foo_pm_ops),
+ *	...
+ * };
+ *
+ * This ensures that the generated code will be dropped by the compiler in the
+ * case where CONFIG_PM has been disabled in the config.
++ */
+
+#define DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS(_name) \
+	static int __##_name##_drm_mode_config_pm_suspend(struct device *dev) \
+	{ \
+		return drm_mode_config_helper_suspend(dev_get_drvdata(dev)); \
+	} \
+	static int __##_name##_drm_mode_config_pm_resume(struct device *dev) \
+	{ \
+		return drm_mode_config_helper_resume(dev_get_drvdata(dev)); \
+	} \
+	static DEFINE_SIMPLE_DEV_PM_OPS(_name, \
+					__##_name##_drm_mode_config_pm_suspend, \
+					__##_name##_drm_mode_config_pm_resume)
+
 #endif
-- 
2.35.1

