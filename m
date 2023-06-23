Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966A573C417
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjFWWZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjFWWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:25:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FCE2727
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:25:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa79605a3bso11268755e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687559142; x=1690151142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVDfyQp1D2UHXpL1ZVItWp64PNlbA4FYgRcewIHu8Ww=;
        b=PRuOCVqjhaiUIaUxHpcOBEuD6ZfRhG69YI9VhpRhJBg/QRW8qHokII2mDUDfTkEvKb
         j5XmH5Dnv+539X4Yu3HnU2WPe9mnfR6Lm4OVBFbS3IvhFBzZ6KHFOqoGVuXxWBd+BoMw
         LNLpD2UixobZWhUHVRCICdr09zBrDVUX/tFNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687559142; x=1690151142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVDfyQp1D2UHXpL1ZVItWp64PNlbA4FYgRcewIHu8Ww=;
        b=TQ4zZdTb9YKBx42zr3CVIIFu7IBCpGitsbSbjJEKyjT+iFYJTDWw56Fs6fE5idIseM
         OV/+YyWXRztKJ5EN+buGNdNlgh2xr8A0t46XIEwIbNv0NDBC4wIzkdoVFEPbO4GkUBVt
         6OX3XlCErtw2UnC08uPUbDyWIoL+2pXHhDWVbKVwR2VfUWJVYfkY1Yskjc39cu0XIMIQ
         e0ls5GK0Uz5OuAstwJXmoVhamPGSUuxxeAco08xd5VsIRnHGTD805BCS43VrdmC8fHXF
         oBXFe8tV1ykiIvlEdPK2EMQtFhCT2NMUAdkIHg3B007ER7mIuNnIyRiSDGJPAXw6FOBe
         4Jew==
X-Gm-Message-State: AC+VfDx+jpiJHjSdPbwKUWkYPuqQFa8i3xoPiPUtILdcHVhuDM11Ezf9
        9RCIbUayh+jrb9fh4qM3pjPO+A==
X-Google-Smtp-Source: ACHHUZ7pe50hzgM5iLC2579qWnSeqdzLoUZ3+Orq7sbVqA9W1K1hggz4Fbs/PlyG3wmdZULYjOJhjA==
X-Received: by 2002:a05:600c:138c:b0:3fa:7bf0:7a81 with SMTP id u12-20020a05600c138c00b003fa7bf07a81mr2995293wmf.0.1687559141956;
        Fri, 23 Jun 2023 15:25:41 -0700 (PDT)
Received: from big-boopo.mynetworksettings.com (pool-108-46-233-209.nycmny.fios.verizon.net. [108.46.233.209])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0030c2e3c7fb3sm453223wrp.101.2023.06.23.15.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:25:41 -0700 (PDT)
From:   Jim Shargo <jshargo@chromium.org>
To:     mairacanal@riseup.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Jim Shargo <jshargo@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] drm/vkms: Add a module param to enable/disable the default device
Date:   Fri, 23 Jun 2023 18:23:48 -0400
Message-ID: <20230623222353.97283-7-jshargo@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230623222353.97283-1-jshargo@chromium.org>
References: <20230623222353.97283-1-jshargo@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many testing circumstances, we will want to just create a new device
and test against that. If we create a default device, it can be annoying
to have to manually select the new device instead of choosing the only
one that exists.

The param, enable_default, is defaulted to true to maintain backwards
compatibility.

Signed-off-by: Jim Shargo <jshargo@chromium.org>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 44 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 314a04659c5f..1cb56c090a65 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -42,17 +42,26 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+static bool enable_default_device = true;
+module_param_named(enable_default_device, enable_default_device, bool, 0444);
+MODULE_PARM_DESC(enable_default_device,
+		 "Enable/Disable creating the default device");
+
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
-MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
+MODULE_PARM_DESC(enable_cursor,
+		 "Enable/Disable cursor support for the default device");
 
 static bool enable_writeback = true;
 module_param_named(enable_writeback, enable_writeback, bool, 0444);
-MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector support");
+MODULE_PARM_DESC(
+	enable_writeback,
+	"Enable/Disable writeback connector support for the default device");
 
 static bool enable_overlay;
 module_param_named(enable_overlay, enable_overlay, bool, 0444);
-MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
+MODULE_PARM_DESC(enable_overlay,
+		 "Enable/Disable overlay support for the default device");
 
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
@@ -278,10 +287,7 @@ void vkms_remove_device(struct vkms_device *vkms_device)
 static int __init vkms_init(void)
 {
 	int ret;
-	struct platform_device *pdev;
-	struct vkms_device_setup vkms_device_setup = {
-		.configfs = NULL,
-	};
+	struct platform_device *default_pdev = NULL;
 
 	ret = platform_driver_register(&vkms_platform_driver);
 	if (ret) {
@@ -289,19 +295,27 @@ static int __init vkms_init(void)
 		return ret;
 	}
 
-	pdev = platform_device_register_data(NULL, DRIVER_NAME, 0,
-					     &vkms_device_setup,
-					     sizeof(vkms_device_setup));
-	if (IS_ERR(pdev)) {
-		DRM_ERROR("Unable to register default vkms device\n");
-		platform_driver_unregister(&vkms_platform_driver);
-		return PTR_ERR(pdev);
+	if (enable_default_device) {
+		struct vkms_device_setup vkms_device_setup = {
+			.configfs = NULL,
+		};
+
+		default_pdev = platform_device_register_data(
+			NULL, DRIVER_NAME, 0, &vkms_device_setup,
+			sizeof(vkms_device_setup));
+		if (IS_ERR(default_pdev)) {
+			DRM_ERROR("Unable to register default vkms device\n");
+			platform_driver_unregister(&vkms_platform_driver);
+			return PTR_ERR(default_pdev);
+		}
 	}
 
 	ret = vkms_init_configfs();
 	if (ret) {
 		DRM_ERROR("Unable to initialize configfs\n");
-		platform_device_unregister(pdev);
+		if (default_pdev)
+			platform_device_unregister(default_pdev);
+
 		platform_driver_unregister(&vkms_platform_driver);
 	}
 
-- 
2.41.0.162.gfafddb0af9-goog

