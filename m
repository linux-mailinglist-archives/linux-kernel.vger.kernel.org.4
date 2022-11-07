Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA1161FBE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiKGRvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiKGRvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:51:21 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E58121803
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667843472; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+IpH1Q1dYPVKyLaxilWX5S98yicXsHBkC9S23qvx10=;
        b=0tiKwTfjj4UhOpeAevLbvl402I7D2NMWgngf1Q/iHCa1FNymftekv38ReVkSCMcp2rxzwa
        IM3Zhe0MlmSK6UO4Xyh3Udg2YJvZeIfJF5lhtnGRf4QYf992QMXJNQTJXwNc2UzExMP9wJ
        a7UjBsnLWx/CAYHgDcoX6uCq4V8Gpp4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 01/26] drm: modeset-helper: Export dev_pm_ops for simple drivers
Date:   Mon,  7 Nov 2022 17:50:41 +0000
Message-Id: <20221107175106.360578-2-paul@crapouillou.net>
In-Reply-To: <20221107175106.360578-1-paul@crapouillou.net>
References: <20221107175106.360578-1-paul@crapouillou.net>
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

Export a dev_pm_ops meant to be used with simple drivers, which have
their struct drm_device registered as their struct device's drvdata, and
only call drm_mode_config_pm_{suspend,resume}.

The symbol is conditionally exported if IS_ENABLED(CONFIG_PM_SLEEP), and
therefore it should always be referenced using the pm_sleep_ptr() macro.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/drm_modeset_helper.c | 32 ++++++++++++++++++++++++++++
 include/drm/drm_modeset_helper.h     |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index f858dfedf2cf..0bc9f9228a60 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -20,6 +20,9 @@
  * OF THIS SOFTWARE.
  */
 
+#include <linux/device.h>
+#include <linux/pm.h>
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
@@ -244,3 +247,32 @@ int drm_mode_config_helper_resume(struct drm_device *dev)
 	return ret;
 }
 EXPORT_SYMBOL(drm_mode_config_helper_resume);
+
+static int drm_mode_config_pm_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_suspend(drm);
+}
+
+static int drm_mode_config_pm_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_resume(drm);
+}
+
+/**
+ * drm_mode_config_pm_ops - Exported dev_pm_ops helper for simple drivers
+ *
+ * This dev_pm_ops can be used for simple drivers that would otherwise only call
+ * drm_mode_config_helper_suspend / drm_mode_config_helper_resume in their PM
+ * callbacks. It is only valid if the driver's drm_device has been registered as
+ * the struct device's drvdata.
+ *
+ * The exported symbol must always be used with the pm_sleep_ptr() macro, like
+ * this:
+ * .pm = pm_sleep_ptr(&drm_mode_config_pm_ops),
+ */
+EXPORT_SIMPLE_DEV_PM_OPS(drm_mode_config_pm_ops,
+			 drm_mode_config_pm_suspend, drm_mode_config_pm_resume);
diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index 995fd981cab0..85f29637e9c1 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -23,6 +23,8 @@
 #ifndef __DRM_KMS_HELPER_H__
 #define __DRM_KMS_HELPER_H__
 
+#include <linux/pm.h>
+
 struct drm_crtc;
 struct drm_crtc_funcs;
 struct drm_device;
@@ -41,4 +43,6 @@ int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 int drm_mode_config_helper_suspend(struct drm_device *dev);
 int drm_mode_config_helper_resume(struct drm_device *dev);
 
+extern const struct dev_pm_ops drm_mode_config_pm_ops;
+
 #endif
-- 
2.35.1

