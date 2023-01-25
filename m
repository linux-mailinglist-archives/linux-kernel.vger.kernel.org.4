Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC15E67BCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjAYUin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjAYUiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:16 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC55CFE1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:08 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g15so16917ild.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpy0cOVfK4F6f9ncMq3cj66TYMa4mKfP9CUrXJEdxTg=;
        b=TWV8wMFDKNXBp8LyUMYYmYWrF8cZDRtuzuNXn1mLzLMypVaSkOh8oTER+04ZDuh2mV
         BrmASw+dQ4yN0ZpvuhBe3oNPNSfyAMgyijDgVCuU1mVNhRCIMTT7/S1SDSgS0eEcoG6d
         JKPNFOrHb05Q5fEnybVwPaiJ/Qe53gsfj1bP8Tb5gB/My2TSuAXhUkMMljGE2aYsZIL3
         cET+MdfylZ5fGqe8jmNit3RkPKRSs2VvPnfPSciZHHJQfF2dcu9eRCbk2yOPkT6J30Jl
         xv4dXo3obpUy64/PjI6AkjYfukIMG5DRtDV2m71Y4D9ZBJGifprxy1Jfb0riNjxuEFPe
         QNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpy0cOVfK4F6f9ncMq3cj66TYMa4mKfP9CUrXJEdxTg=;
        b=Lo0FVNxQdflHoYAVJw6UvES6+NbAvRqYUM2+b00h6uMtNbUDKFNMINFwvAj7yc+Bb3
         lFAfqk+CzVyzazA5mswHuQQwZlg2dm+GOyRS9X5r0v1XsdBgZ21nw7iKYjvCluqf2L9L
         si9tdmUx53ktD69Yt7XFkMoaBSimu+43ORBXOw5KxBs4pXU7aTQSyfe7NkpH5HPpyTbX
         PXP2FHOjMdfyDN9+z3+jZmjHTsjmVv5vFCQRGXPJ+YMSxpM3j53DJAuitBU/a/XyUplv
         NViONLOLe42yOmTSNEVElRFqVetl1/GR8gE27ECLAGeE9rgd09OBrtmQXwqVtZK6F9sq
         wAgw==
X-Gm-Message-State: AO0yUKWF98FiRnUGUhwi2umKZyB9uIwBPclWtwWKGpcmJNDoGUS6eja+
        vrLFg7oMK/1d0Rl5eJuc3cwQAxQvcks=
X-Google-Smtp-Source: AK7set91Vk82/inU4wE1cqLdpZl7tyW1wrabuUXppQ+nvECvIdXf4JiVXdt7yWOy4lHnA34aQpJiLg==
X-Received: by 2002:a92:c267:0:b0:310:ae72:32a0 with SMTP id h7-20020a92c267000000b00310ae7232a0mr820233ild.21.1674679087884;
        Wed, 25 Jan 2023 12:38:07 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:07 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 10/19] dyndbg-API: split DECLARE_(DYNDBG_CLASSMAP) to $1(_DEFINE|_USE)
Date:   Wed, 25 Jan 2023 13:37:34 -0700
Message-Id: <20230125203743.564009-11-jim.cromie@gmail.com>
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

DECLARE_DYNDBG_CLASSMAP's job was to allow modules to declare the debug
classes/categories they want dyndbg to >control on their behalf.  Its
args give the class-names, their mapping to class_ids, and the sysfs
interface style (usually a class-bitmap).  Modules wanting a drm.debug
style knob need to create the kparam, and call module_param_cb() to
wire the sysfs node to the classmap.  DRM does this is in drm_print.c

In DRM, multiple modules declare identical DRM_UT_* classmaps, so that
the class'd prdbgs are modified across those modules in a coordinated
way across the subsystem, by either explicit class DRM_UT_* queries to
>control, or by writes to /sys/module/drm/parameters/debug (drm.debug)

This coordination-by-identical-declarations is weird, so this patch
splits the macro into _DEFINE and _USE flavors.  This distinction
follows the definition vs declaration that K&R gave us, improving the
api; _DEFINE is used once to specify the classmap, and multiple users
_USE the single definition explicitly.

Currently the latter just reuses the former, and still needs all the
same args, but that can be tuned later; the _DEFINE can initialize an
(extern/global) struct classmap, and _USE can, well use/reference
that struct.

Also wrap DYNDBG_CLASSMAP_USEs with ifdef DRM_USE_DYNAMIC_DEBUG to
balance with the one around drm_print's use of DYNDBG_CLASSMAP_DEFINE.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +++-
 drivers/gpu/drm/display/drm_dp_helper.c |  4 +++-
 drivers/gpu/drm/drm_crtc_helper.c       |  4 +++-
 drivers/gpu/drm/drm_print.c             |  2 +-
 drivers/gpu/drm/i915/i915_params.c      |  4 +++-
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  4 +++-
 include/linux/dynamic_debug.h           | 20 ++++++++++++----
 lib/test_dynamic_debug.c                | 32 ++++++++++++-------------
 8 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cd4caaa29528..a7a3a382c4a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -189,7 +189,8 @@ int amdgpu_vcnfw_log;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
@@ -200,6 +201,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_LEASE",
 			"DRM_UT_DP",
 			"DRM_UT_DRMRES");
+#endif
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 16565a0a5da6..8fa7a88299e7 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -41,7 +41,8 @@
 
 #include "drm_dp_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
@@ -52,6 +53,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_LEASE",
 			"DRM_UT_DP",
 			"DRM_UT_DRMRES");
+#endif
 
 struct dp_aux_backlight {
 	struct backlight_device *base;
diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index a209659a996c..7e6b25446303 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -50,7 +50,8 @@
 
 #include "drm_crtc_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
@@ -61,6 +62,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_LEASE",
 			"DRM_UT_DP",
 			"DRM_UT_DRMRES");
+#endif
 
 /**
  * DOC: overview
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 5b93c11895bb..4b697e18238d 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -56,7 +56,7 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 module_param_named(debug, __drm_debug, ulong, 0600);
 #else
 /* classnames must match vals of enum drm_debug_category */
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+DYNDBG_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index d1e4d528cb17..b5b2542ae364 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -29,7 +29,8 @@
 #include "i915_params.h"
 #include "i915_drv.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
@@ -40,6 +41,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_LEASE",
 			"DRM_UT_DP",
 			"DRM_UT_DRMRES");
+#endif
 
 #define i915_param_named(name, T, perm, desc) \
 	module_param_named(name, i915_modparams.name, T, perm); \
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 80f154b6adab..e4146b9af357 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -71,7 +71,8 @@
 #include "nouveau_svm.h"
 #include "nouveau_dmem.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+DYNDBG_CLASSMAP_USE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
@@ -82,6 +83,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_LEASE",
 			"DRM_UT_DP",
 			"DRM_UT_DRMRES");
+#endif
 
 MODULE_PARM_DESC(config, "option string to pass to driver core");
 static char *nouveau_config;
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 81b643ab7f6e..1cdfd62fd2e4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -56,7 +56,7 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-enum class_map_type {
+enum ddebug_class_map_type {
 	DD_CLASS_TYPE_DISJOINT_BITS,
 	/**
 	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, one per bit.
@@ -86,17 +86,19 @@ struct ddebug_class_map {
 	const char **class_names;
 	const int length;
 	const int base;		/* index of 1st .class_id, allows split/shared space */
-	enum class_map_type map_type;
+	enum ddebug_class_map_type map_type;
 };
 
 /**
- * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
+ * DYNDBG_CLASSMAP_DEFINE - define the class_map that names the
+ * debug classes used in this module.  This tells dyndbg the authorized
+ * classnames it should manipulate.
  * @_var:   a struct ddebug_class_map, passed to module_param_cb
  * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
  * @_base:  offset of 1st class-name. splits .class_id space
  * @classes: class-names used to control class'd prdbgs
  */
-#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
+#define DYNDBG_CLASSMAP_DEFINE(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
 	static struct ddebug_class_map __aligned(8) __used		\
 		__section("__dyndbg_classes") _var = {			\
@@ -108,6 +110,16 @@ struct ddebug_class_map {
 		.class_names = _var##_classnames,			\
 	}
 
+/*
+ * refer to the classmap instantiated once, by the macro above.  This
+ * distinguishes the multiple users of drm.debug from the single
+ * definition, allowing them to specialize.  ATM its a pass-thru, but
+ * it should help regularize the admittedly wierd sharing by identical
+ * definitions.
+ */
+#define DYNDBG_CLASSMAP_USE(_var, _maptype, _base, ...)		\
+	DYNDBG_CLASSMAP_DEFINE(_var, _maptype, _base, __VA_ARGS__)
+
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 89dd7f285e31..8d384b979e74 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -62,38 +62,38 @@ enum cat_disjoint_bits {
 	D2_LEASE,
 	D2_DP,
 	D2_DRMRES };
-DECLARE_DYNDBG_CLASSMAP(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"D2_CORE",
-			"D2_DRIVER",
-			"D2_KMS",
-			"D2_PRIME",
-			"D2_ATOMIC",
-			"D2_VBL",
-			"D2_STATE",
-			"D2_LEASE",
-			"D2_DP",
-			"D2_DRMRES");
+DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+		       "D2_CORE",
+		       "D2_DRIVER",
+		       "D2_KMS",
+		       "D2_PRIME",
+		       "D2_ATOMIC",
+		       "D2_VBL",
+		       "D2_STATE",
+		       "D2_LEASE",
+		       "D2_DP",
+		       "D2_DRMRES");
 DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
 enum cat_disjoint_names { LOW = 10, MID, HI };
-DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
-			"LOW", "MID", "HI");
+DYNDBG_CLASSMAP_DEFINE(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
+		       "LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
 DD_SYS_WRAP(disjoint_names, T);
 
 /* numeric verbosity, V2 > V1 related */
 enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
-DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
+DYNDBG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
 		       "V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7");
 DD_SYS_WRAP(level_num, p);
 DD_SYS_WRAP(level_num, T);
 
 /* symbolic verbosity */
 enum cat_level_names { L0 = 22, L1, L2, L3, L4, L5, L6, L7 };
-DECLARE_DYNDBG_CLASSMAP(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES, 22,
-			"L0", "L1", "L2", "L3", "L4", "L5", "L6", "L7");
+DYNDBG_CLASSMAP_DEFINE(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES, 22,
+		       "L0", "L1", "L2", "L3", "L4", "L5", "L6", "L7");
 DD_SYS_WRAP(level_names, p);
 DD_SYS_WRAP(level_names, T);
 
-- 
2.39.1

