Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A394C5E4F63
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIUS1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIUS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:26:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798449F0F6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:26:58 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o23-20020a17090aac1700b002006b02384fso8904540pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=vFrM7jTrAe8cGuQWt79XnjMjIT7+U0OcgpCLaS8L5xY=;
        b=aI6utDeZbSBgGg2dXRRFWszZJP5AtEa1SM6gifQL6mGZxV43Anh3XmPMI1EZUipHXE
         L24qw71oZJvZrYGfiNfElLFQ3S6Lhhg3IrJ+aL0I727X8z2YYvHlQmYWVQWQtd2V3xVu
         wzBePcqNZ9g2y/zempi724MQ2oYQtT6XpaKWJRqESDRvNpg37u2I0ooRZiSfh3KnyO0B
         CE0nhLGF1WVNKwRK0i/p2Jka7qDdS5GoKXBnNd+5GcRSW+/sX1hxEte5rXOmbHvIEOpI
         FPtSkMa2fl7zu7H3QlEufH18ScmCh5c86wIf9qRrhQDGVvfaYN09ljaBqPRaZNg4JhEP
         3K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=vFrM7jTrAe8cGuQWt79XnjMjIT7+U0OcgpCLaS8L5xY=;
        b=j5H3rt3m1PbMILuIKGV3oL42nXoy8GkoaJ1lCIC1TDkPJg5KFigVRH8a/syS4xC13j
         qefRcI16hQFL7B2g5Ah72t6zpX8FsETejDCtTexP45IhMM/ghTU4GHx9aPuKaWGkdnrT
         YooUnqpZfJ1Uk1J8isWmf3y9IVJq3uuH29DeXc1sQ1TVOXc4ouwXVKlYS1EhGIEtownC
         FrPwd2w00CmGImraD/x3uz42hocnTH5pFBecHD5xf95nUxFoma52D1Mj3ZHX1q52HOGw
         M4Lg2Q9IcB8I8ram+9FNcsabW+UyvRef7V+whhasnRGGI18RunZkq/jd8K3q/7vRgiZd
         ae9w==
X-Gm-Message-State: ACrzQf3cx3zbB9yyEPk6wTRKHQbNhHT0OFsmJD9wTy8RFxC2TyEr/wFd
        u993FiqUaqwfedvjLNwFjvfoBp4Kj9u7+w==
X-Google-Smtp-Source: AMsMyM4kWbXlK3DtWnqQ2eraV9ytOrd//B5Pe7HOQCc89/e6XZ/wCSghpbf9AZHMyiE//nHzCp7Y6/PRkbnPYw==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90a:ab91:b0:202:a520:56c9 with SMTP
 id n17-20020a17090aab9100b00202a52056c9mr11260998pjq.1.1663784818046; Wed, 21
 Sep 2022 11:26:58 -0700 (PDT)
Date:   Wed, 21 Sep 2022 18:26:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921182637.4056670-1-wonchung@google.com>
Subject: [PATCH] drm/sysfs: Link DRM connectors to corresponding Type-C connectors
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
 drivers/gpu/drm/drm_sysfs.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 430e00b16eec..8270b02e6783 100644
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
@@ -95,6 +97,36 @@ static char *drm_devnode(struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
 }
 
+static int typec_connector_bind(struct device *dev,
+	struct device *typec_connector, void *data)
+{
+	int ret;
+
+	ret = sysfs_create_link(&dev->kobj, &typec_connector->kobj,
+		"typec_connector");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&typec_connector->kobj, &dev->kobj,
+		"drm_connector");
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
@@ -355,6 +387,13 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
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
@@ -367,6 +406,9 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
 	if (!connector->kdev)
 		return;
 
+	if (dev_fwnode(connector->kdev))
+		component_del(connector->kdev, &typec_connector_ops);
+
 	if (connector->ddc)
 		sysfs_remove_link(&connector->kdev->kobj, "ddc");
 
-- 
2.37.2.789.g6183377224-goog

