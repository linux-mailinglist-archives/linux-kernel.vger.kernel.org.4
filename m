Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289F65EB358
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiIZVmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIZVmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:42:02 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43E72EFF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:42:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r7-20020a632047000000b00439d0709849so4647483pgm.22
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=76mzZG8/jT1+bjf01zpv/Lk3fUtOoX1xhCJ2wZs46XQ=;
        b=qYgovExtvBiK7AVfYH0c2CxLh55mWFDCQaFUwYaO+sfaVrru5Lx4qvN/KW4nd47+3G
         1/3YBXRVc1cslXf6UR4tmsP+Ca+NbxbIO7zeK82x0Ya2nwt90EnhbuckJSgJpsq8+qpm
         uVtiviWTl6wFDZGNhFeDYVKYVOmVAyI0SeWCJq7HTSWBMLNf92cxLwqnxnBCx6ga5v5g
         kwXKRXcvlZxRqTnYzRNVp/+0hzLmP5cUSOLyCgB3g26Ay1FhYziD5kxy/XW4zdWKlGl3
         diqEArkyDAvWRN4GRGE4VB4MtHeORWihLpinFp445CDilralOV0UNbvgbQC+skm13uNn
         OjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=76mzZG8/jT1+bjf01zpv/Lk3fUtOoX1xhCJ2wZs46XQ=;
        b=6SR3hozHO1Aivbsd250xV0Ug/Cs7ISerD8Kj0fQiyrqCuCtK73RPdkUObB8Sh4PJvE
         26EFADc/QXKXZzwC2H5BbCSONH1SmgVADDpAs9WeB/SecHIFQr4bKMnG9lp6jzpF4wAO
         arLAUUbmg5OSxmbFqtFSSjNiMEYrh3yEUKXzBlE+aNx3Xe4mkYcucoeGOVWGSsHh3Ogu
         13U4AgjAwyhKBmy7Xk/1oDSyX0E59yH8qNfnSESL5Yv2otajFWz14GmaMITDePpENO4p
         ij8YkVFAR6aMgAxlEiv0HhlsE/Bq1g0jfVZ7tYvbKjKnGCrhQ6VhNC+NAVYTyEV5AEdk
         xicA==
X-Gm-Message-State: ACrzQf0oVbcJNCLFqQzC9NTcWp9AGgTWSv6upDMZBDsf3E+nt5vjEgZK
        2OsYPIGtBeHQSSo0buWKIZGYpEWFiMYCYw==
X-Google-Smtp-Source: AMsMyM4hyVKbiL0f2aO9Wa5XTT2ln5eD9BPWIhrkCxh8NJspMz8jQx3AzK12tqg84gLcl9mCvq9La+7JCjfJow==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a05:6a00:890:b0:558:17b6:1b6 with SMTP id
 q16-20020a056a00089000b0055817b601b6mr8689879pfj.21.1664228521554; Mon, 26
 Sep 2022 14:42:01 -0700 (PDT)
Date:   Mon, 26 Sep 2022 21:41:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926214157.843812-1-wonchung@google.com>
Subject: [PATCH v2] drm/sysfs: Link DRM connectors to corresponding Type-C connectors
From:   Won Chung <wonchung@google.com>
To:     wonchung@google.com, bleung@google.com, pmalani@chromium.org,
        heikki.krogerus@linux.intel.com, imre.deak@intel.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a symlink pointing to USB Type-C connector for DRM connectors
when they are created. The link will be created only if the firmware is
able to describe the connection beween the two connectors.

Signed-off-by: Won Chung <wonchung@google.com>
---
Changes from v1:
- Fix multiple lines to single line


 drivers/gpu/drm/drm_sysfs.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 430e00b16eec..6a9904fa9186 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -11,12 +11,14 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/component.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/i2c.h>
 #include <linux/kdev_t.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <drm/drm_connector.h>
@@ -95,6 +97,34 @@ static char *drm_devnode(struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
 }
 
+static int typec_connector_bind(struct device *dev,
+	struct device *typec_connector, void *data)
+{
+	int ret;
+
+	ret = sysfs_create_link(&dev->kobj, &typec_connector->kobj, "typec_connector");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&typec_connector->kobj, &dev->kobj, "drm_connector");
+	if (ret)
+		sysfs_remove_link(&dev->kobj, "typec_connector");
+
+	return ret;
+}
+
+static void typec_connector_unbind(struct device *dev,
+	struct device *typec_connector, void *data)
+{
+	sysfs_remove_link(&typec_connector->kobj, "drm_connector");
+	sysfs_remove_link(&dev->kobj, "typec_connector");
+}
+
+static const struct component_ops typec_connector_ops = {
+	.bind = typec_connector_bind,
+	.unbind = typec_connector_unbind,
+};
+
 static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
 
 /**
@@ -355,6 +385,13 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 	if (connector->ddc)
 		return sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");
+
+	if (dev_fwnode(kdev)) {
+		r = component_add(kdev, &typec_connector_ops);
+		if (r)
+			drm_err(dev, "failed to add component\n");
+	}
+
 	return 0;
 
 err_free:
@@ -367,6 +404,9 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
 	if (!connector->kdev)
 		return;
 
+	if (dev_fwnode(connector->kdev))
+		component_del(connector->kdev, &typec_connector_ops);
+
 	if (connector->ddc)
 		sysfs_remove_link(&connector->kdev->kobj, "ddc");
 
-- 
2.37.3.998.g577e59143f-goog

