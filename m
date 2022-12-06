Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06C643A11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiLFAfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiLFAff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:35 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3020BF7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:10 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x13so5865684ilp.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OlqAVdvyqqiVyTjTWaSqPn3OANos9Aj5vBF/fh+B7U=;
        b=YFOK2V9wjKW/Oo1x+9HuOkLN+9AquBXUA70mCXvorqcl2nCNRYyIFlkDWpd51ROAN4
         dBpoef7KmUKfYar+JO82ufcsoBTfNNl9tIeA591VPmk0RUidt8wB2ayruNhgyc8q7g8s
         jUtHAFU5h5SNknHzIv9/cPIG1Rsu03PvbuiZE6z8IywK4kPSk5MTeAI0fXZY2TuRqvnA
         K5l80SihOx25ryFXbxfch9dTNCrOr5p3kAd/m07bluRMM0nDFySvv4KNGPY0oiSFXPMu
         cJ3IUBG0hE06AAarAnLcrPgIyhHW8SmtqqjWkOOLAg9FEQ8wOu5STEHvFo3p92UDkP78
         uLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OlqAVdvyqqiVyTjTWaSqPn3OANos9Aj5vBF/fh+B7U=;
        b=fsHVJlaKu7SV1kPvyktVN++lvcu1N7t0eWbn0PedGFSZcoI4SMUbNBqgtwmrVAoZYU
         nR7FQQaV84XEWU+nDSthmM/YVgmJHjS+3dwWmM1K5qmSfkh9IjUoPXqyq+QWWIsk+N6s
         as5B5UR+xmdnXCA7o5tm8Zl6NFp7lmOBOd/5vzkCieisDOJBLnlDoHf/1R8WvpMmwIe5
         TCPWZt7btSzy2NOzvDmCvo8zZplojMmmeIhLvbV0XhdVqIKkqvDzGrgzxX99U62uL51l
         0jeAJBznZXvvH1LF6QyIZiWCpX1MppH0WYJpfwl8jzpFc49Tx7Snw93ZxDeGfxAH3Pmt
         xoAw==
X-Gm-Message-State: ANoB5plVCGtzbPEdVSFUOYUCb3OUG9PM405k00tKYCeKqYdv9Wy3DSre
        ON4WgwnJMMbZ++buDMcvuQDTbjqfPBPXgw==
X-Google-Smtp-Source: AA0mqf6VrCePpRaMYDydeXhqjekmzGAwcuJFdpoJ9FGZdi9FOYU7uzNez0MgcFyy/8mbZPp+YUI47Q==
X-Received: by 2002:a92:c8c9:0:b0:2ff:e4b1:5436 with SMTP id c9-20020a92c8c9000000b002ffe4b15436mr37065011ilq.305.1670286909058;
        Mon, 05 Dec 2022 16:35:09 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:08 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 11/17] dyndbg-API: DYNDBG_CLASSMAP_USE drop extra args
Date:   Mon,  5 Dec 2022 17:34:18 -0700
Message-Id: <20221206003424.592078-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206003424.592078-1-jim.cromie@gmail.com>
References: <20221206003424.592078-1-jim.cromie@gmail.com>
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
index dabbe1a9180c..0088fc354c98 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -92,13 +92,15 @@ struct ddebug_class_map {
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
@@ -118,16 +120,18 @@ struct ddebug_class_user {
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
 	extern struct ddebug_class_map _var[];				\
-	static struct ddebug_class_user __used				\
+	struct ddebug_class_user __used					\
 	__section("__dyndbg_class_refs") _uname = {			\
 		.user_mod_name = KBUILD_MODNAME,			\
 		.map = _var,						\
-- 
2.38.1

