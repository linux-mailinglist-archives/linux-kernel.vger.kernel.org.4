Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778467BCFF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjAYUix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbjAYUiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:21 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C305D93D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:10 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id p12so1588ilq.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDPJAYdKLEdQblt6ktavPWelw6rNVhYcEEPUN0RMT1I=;
        b=W3Ky8nLoAb0y3R+ldW3oKmbw8upJ6lBigDDP/1rAfqL8jzNIsn/awIbfzxEaY8iR3i
         x1myMKLV8cd0LN642UUqu8W7Uog7BY58vazhhjrE5y/1yOTGODvCP47tKkURTUffuMj+
         CZyG1f7vFCWXgECumJsj40T+ncpB5uGq1XLf6I0hP2pkz7ieithxxQZlJxmNA+Ks+xUP
         wtSclTO/8NBPqzrxKo867fgnFA3mtDcslqn8149p1szWdKYuLWLJJO3KEwSrlQW/jZ1M
         IxbyBdTWLVKoGgLEdXuAZHFUDZwvAM7lXSWn7lqcZH7t3Mxbb7h5JS1cxEmXkO/Zbnwp
         9zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDPJAYdKLEdQblt6ktavPWelw6rNVhYcEEPUN0RMT1I=;
        b=EX9iYFlAPgTIQ5mhoUZl6ob7uU0/Idn8xXsH3e/snkIAgJLvFz+Qbb1LvHK/OBtH30
         T10vPwSyznmX6Yk7s5lPLUUqICNX6q9uOxsz7eOdt7oPk9jsvjSlB+P4xLOypUbFxvCP
         KXvP6Wl/hL4HjBReQWBqGbDYRr3ICMHEWVsBmsvWZTwM8o9Akft96zNYcGI8uMzM8x0X
         XsA7Rk+PjmHnXqEsoVqEX4VUuTUx0fBuJky+bv1TY6AeOck6TqIuiSheFVGL1IGvZBmm
         YX6zP/5oZ34yY37kpuvkUXfiBOCLr0XPjEew84MyG7rYL82f2FQguXulzox2M9BG3P5f
         l1vg==
X-Gm-Message-State: AO0yUKXQAHnoMkYqfiiPEZ9BK51cUWy/AldLg7cLp/eJ3jjT7ubiMGnl
        EfRMpWhrtrkWxZgH+0w262bK0AyPURo=
X-Google-Smtp-Source: AK7set8gR1dUF61yRz2B6WQ5tB9/qCT1EGwv6OZBRZQ8Mqy1amfGMF+KfW6lsG7TNb/srUF58lcnRA==
X-Received: by 2002:a05:6e02:214b:b0:310:937d:7644 with SMTP id d11-20020a056e02214b00b00310937d7644mr6286473ilv.18.1674679089818;
        Wed, 25 Jan 2023 12:38:09 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:09 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 12/19] dyndbg-API: DYNDBG_CLASSMAP_USE drop extra args
Date:   Wed, 25 Jan 2023 13:37:36 -0700
Message-Id: <20230125203743.564009-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125203743.564009-1-jim.cromie@gmail.com>
References: <20230125203743.564009-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop macro args after _var.  Since DYNDBG_CLASSMAP_USE no longer
forwards to DYNDBG_CLASSMAP_DEFINE, it doesn't need those args to
forward.  Keep only the _var arg, which is the extern'd struct
classmap with all the class info.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +---------
 drivers/gpu/drm/display/drm_dp_helper.c | 12 +---------
 drivers/gpu/drm/drm_crtc_helper.c       | 12 +---------
 drivers/gpu/drm/i915/i915_params.c      | 12 +---------
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 12 +---------
 include/linux/dynamic_debug.h           | 30 ++++++++++++++-----------
 6 files changed, 22 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a7a3a382c4a6..6c57e598b7d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -190,17 +190,7 @@ int amdgpu_vcnfw_log;
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
 #if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DYNDBG_CLASSMAP_USE(drm_debug_classes);
 #endif
 
 struct amdgpu_mgpu_info mgpu_info = {
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 8fa7a88299e7..3bc188cb1116 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -42,17 +42,7 @@
 #include "drm_dp_helper_internal.h"
 
 #if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DYNDBG_CLASSMAP_USE(drm_debug_classes);
 #endif
 
 struct dp_aux_backlight {
diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 7e6b25446303..1780db9de069 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -51,17 +51,7 @@
 #include "drm_crtc_helper_internal.h"
 
 #if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DYNDBG_CLASSMAP_USE(drm_debug_classes);
 #endif
 
 /**
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index b5b2542ae364..e959d0384ead 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -30,17 +30,7 @@
 #include "i915_drv.h"
 
 #if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DYNDBG_CLASSMAP_USE(drm_debug_classes);
 #endif
 
 #define i915_param_named(name, T, perm, desc) \
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index e4146b9af357..ad341411687f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -72,17 +72,7 @@
 #include "nouveau_dmem.h"
 
 #if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DYNDBG_CLASSMAP_USE(drm_debug_classes);
 #endif
 
 MODULE_PARM_DESC(config, "option string to pass to driver core");
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 397ac8294230..91015d1a04e0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -90,13 +90,15 @@ struct ddebug_class_map {
 };
 
 /**
- * DYNDBG_CLASSMAP_DEFINE - define the class_map that names the
- * debug classes used in this module.  This tells dyndbg the authorized
- * classnames it should manipulate.
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
+ * DYNDBG_CLASSMAP_DEFINE - define debug-classes used by a module.
+ * @_var:   name of the classmap, exported for other modules coordinated use.
  * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
  * @_base:  offset of 1st class-name. splits .class_id space
- * @classes: class-names used to control class'd prdbgs
+ * @classes: enum-map - symbol names are "classnames", vals are .class_ids
+ *
+ * @classes vals are _ddebug.class_ids used in the module, the symbol
+ * names are stringified; they authorize "class FOO" to >control.
+ * Connection to a kernel-param is done separately.
  */
 #define DYNDBG_CLASSMAP_DEFINE(_var, _maptype, _base, ...)		\
 	const char *_var##_classnames[] = { __VA_ARGS__ };		\
@@ -116,16 +118,18 @@ struct ddebug_class_user {
 	struct ddebug_class_map *map;
 };
 /**
- * DYNDBG_CLASSMAP_USE - Use a classmap DEFINEd in another module.
- * This lets dyndbg initialize the dependent module's prdbgs from the
- * other module's controlling sysfs node.
+ * DYNDBG_CLASSMAP_USE - refer to a classmap, DEFINEd elsewhere.
+ * @_var: name of the exported classmap
+ *
+ * This registers the module's use of another module's classmap defn,
+ * allowing dyndbg to find the controlling kparam, and propagate its
+ * settings to the dependent module being loaded.
  */
-#define DYNDBG_CLASSMAP_USE(_var, ...)					\
-	DYNDBG_CLASSMAP_USE_(_var, __UNIQUE_ID(ddebug_class_user),	\
-			     __VA_ARGS__)
-#define DYNDBG_CLASSMAP_USE_(_var, _uname, ...)				\
+#define DYNDBG_CLASSMAP_USE(_var)					\
+	DYNDBG_CLASSMAP_USE_(_var, __UNIQUE_ID(ddebug_class_user))
+#define DYNDBG_CLASSMAP_USE_(_var, _uname)				\
 	extern struct ddebug_class_map _var;				\
-	static struct ddebug_class_user __used				\
+	struct ddebug_class_user __used					\
 	__section("__dyndbg_class_refs") _uname = {			\
 		.user_mod_name = KBUILD_MODNAME,			\
 		.map = &_var,						\
-- 
2.39.1

