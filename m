Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD266A35D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAMTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjAMTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:57 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB1D13CFB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:55 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id u8so11259404ilg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTR4ieke4SQncXKaVkcTEuYiRp/32On6yFfwWzPneBA=;
        b=lahi/KQ0DOsZB02/nhfjQxbV7OhjRTH7vLIlbkcZpeXdHg3dmYbzOG4jLw9mvXpXaK
         fNEH6Wf9z/A3AOI13fgKl+SB5r5Zxhsx+hlOPhyVRcULqBJh/XpYsFqsZjt5npG7TS+N
         xuy389egjEYb8wf95btNmwBIVA5D+eUuCKos5ClpCu8Ux6cBQpT/r6hbyOXikd0W2v6M
         dQxFtTq+A5arZm4We9HFCsVBEQ9s2GPnrqLqf9krJqC9T8axl7kwjzrK2Jc3IFCYizqF
         TjuDIG7Rt6DIQVQbMG5Ncv13v1Wg3aaLmIBkw8hwH/o8Jh39YxYH4zxiAGe5UHP8iTx5
         apjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTR4ieke4SQncXKaVkcTEuYiRp/32On6yFfwWzPneBA=;
        b=HsLfDQDI6YO/OT0xTMNerULAluFWdu7UNSRtnIzd8QNnpEDladS7fVRmqFfeCU5AD6
         6B7M9Yxk1Qa9Vp47PzdQZd4aeqGQI/5mZfrzSJtYDpF6HAWQc2F9SMi7D/MWZ2gHBZpZ
         uTQmXexpnMaU3ZsQd3oQWfdMPECF6QtJmDcWbUWxd2yGoHNFx7vZxx0OCT0uKU5P6Ffs
         uWQSVN1fyQ7sKkrjxqmi/vDoE5Uc75alQXh/ZpN3d/Hyrk4vnfigqT8RPJBB6++fKadZ
         ftTd9qi0OqZoo5xbtlq4ym6afd7R72uHzFBXpd1gTCg0zK3Ya3iexkNleztVS5QcgjR/
         L/sA==
X-Gm-Message-State: AFqh2koWSSwHhQSLR3Vx/QncIHiSm+uhATY3q3RmYa40ZdF1WzXaywAe
        1jFaxeqG5+FjnM0JY2DeIlLzGu2TW7Uwkg==
X-Google-Smtp-Source: AMrXdXsgxUL3/qiDQID4zmfERkh2F5ouCmFPUZidaXKyo6mdOb6sKXD5GPfpUdc2o+e9QJcYwmp2cA==
X-Received: by 2002:a92:4b0f:0:b0:30e:da56:d369 with SMTP id m15-20020a924b0f000000b0030eda56d369mr3600066ilg.7.1673638255047;
        Fri, 13 Jan 2023 11:30:55 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:54 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 12/20] dyndbg-API: DYNDBG_CLASSMAP_USE drop extra args
Date:   Fri, 13 Jan 2023 12:30:08 -0700
Message-Id: <20230113193016.749791-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113193016.749791-1-jim.cromie@gmail.com>
References: <20230113193016.749791-1-jim.cromie@gmail.com>
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
index 0075184b5d93..7bcc22ef5d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -189,17 +189,7 @@ int amdgpu_vcnfw_log;
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
index 2f747c9c8f60..5fb83336b015 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -52,17 +52,7 @@
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
index 2963cf5b0807..609edeb2a117 100644
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
2.39.0

