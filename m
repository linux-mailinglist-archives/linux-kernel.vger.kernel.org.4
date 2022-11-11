Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602F662645F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiKKWRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiKKWRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:17:32 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996114D5CE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:31 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id m15so3177174ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBHr2ZjMIn1S0OUBpb0FkCWEXhP52ED+leKw5VXHrf4=;
        b=QyXa6kioC9PHuHc5q4tYYdkN+b6tLueVWsyoERUyPiCd0PsG9SIDzfqnW0VSRSs2Fc
         4DWTWOWGjVoXHQMswU5gDQobCI6xddG7D6HfK9PqHgvZUfVa2w+JywXvLtd1/bl1oAHW
         8cXiMtlxkRW2au2ab88MzHBxDIQD9ijHcnefZDpNJ1FVmMJKBjqOSihGR76UOBOMAgIw
         h7Ns5CHc2tNWHsXd2f15QL93SgS9pETPRNwA1W/0+0k9VYv2s/zC3CpGcVjwBiUFZsh2
         0k78bBgAvyIxMyY+g76x+7FUCZMMXE+3iDjHMDBI0jnb0dp3x+SbfnHLArvAQKeP4mof
         ixaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBHr2ZjMIn1S0OUBpb0FkCWEXhP52ED+leKw5VXHrf4=;
        b=umpLFEsG8Sh8d9r5HMNnnaX9DxMCXWfB98qMh6G2v4GvVCpOQWP8Vt4MBeWPhJKfBY
         xGDa6RjbgIOVIVGYfufcjzIh8iZdnp1g2JWDPm/hfyrXYg2qBT8GqeDc0QdLclXdxVZe
         opRS6j+82tCc1SiTh/DbQ1xiGZJ5XdPLaMrbOu4rssHFd7ytZIEXd0PBd3R5Ft4r0NWy
         TotA+UZpj9FcQDfEhdJzxleQd8f/+lEj5mJl8cBic+UaBNsTnSF0vQaV9P7uZwp/KW2n
         P5q83zxws9wau409Z4/c5Fr3NgfqH9SWdyi3+AU8wyFTVnuhqiTHdsxS6F2FCDOzrcg7
         oRtw==
X-Gm-Message-State: ANoB5pnNfxUAi1qZKgOZJvmZ5JcUG6Acwka0XrEXwoEBaHQwVNAa6G1q
        sZ1tWdg2oslJEhjIskzflvw=
X-Google-Smtp-Source: AA0mqf5KWClhZgEHN2ai5TCS9VG9xOcdCROjBau0cht34TOpNu7c/ykshi7z/485jWj/REsBgqEWSA==
X-Received: by 2002:a05:6e02:1d05:b0:2fa:b6c0:80fd with SMTP id i5-20020a056e021d0500b002fab6c080fdmr2005180ila.164.1668205050922;
        Fri, 11 Nov 2022 14:17:30 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id c5-20020a928e05000000b002f611806ae9sm1113457ild.60.2022.11.11.14.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:17:30 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 6/7] dyndbg: clone DECLARE_DYNDBG_CLASSMAP to REFERENCE_DYNDBG_CLASSMAP
Date:   Fri, 11 Nov 2022 15:17:14 -0700
Message-Id: <20221111221715.563020-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111221715.563020-1-jim.cromie@gmail.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <20221111221715.563020-1-jim.cromie@gmail.com>
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

DECLARE_DYNDBG_CLASSMAPs job is to allow modules to declare the debug
classes/categories they want dyndbg to >control.  Its args name the
class-names, and the sysfs interface style (usually a class-bitmap).
A separate module_param_cb wires the sysfs node to the classmap.

In DRM, multiple modules declare identical DRM_UT_* classmaps, so that
they are modified across those modules in a coordinated way, by either
explicit class DRM_UT_* queries to >control, or by writes to drm.debug
(/sys/module/drm/parameters/debug).

This coordination-by-identical-declarations is weird, so this patch
splits the macro into DECLARE and REFERENCE (USE?) flavors.  This
distinction improves the api; DECLARE is used once to specify the
classmap, and multiple users REFERENCE the single declaration
explicitly.

Currently the latter just reuses the former, and still needs all the
same args, but that can be tuned later; the DECLARE can initialize the
(extern/global) struct classmap, and REFERENCE can, well reference
that struct.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
RFC: s/REFERENCE_/USE_/ ??
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/display/drm_dp_helper.c |  2 +-
 drivers/gpu/drm/drm_crtc_helper.c       |  2 +-
 drivers/gpu/drm/i915/i915_params.c      |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  2 +-
 include/linux/dynamic_debug.h           | 10 ++++++++++
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3c9fecdd6b2f..5c733d96fe4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -188,7 +188,7 @@ int amdgpu_vcnfw_log;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+REFERENCE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 16565a0a5da6..1f20c1e721a4 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -41,7 +41,7 @@
 
 #include "drm_dp_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+REFERENCE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 7d86020b5244..4675c95c90b4 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -51,7 +51,7 @@
 
 #include "drm_crtc_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+REFERENCE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index d1e4d528cb17..14ebbbf53821 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -29,7 +29,7 @@
 #include "i915_params.h"
 #include "i915_drv.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+REFERENCE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index fd99ec0f4257..b943bf2a36fe 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -71,7 +71,7 @@
 #include "nouveau_svm.h"
 #include "nouveau_dmem.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+REFERENCE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
 			"DRM_UT_KMS",
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 41682278d2e8..76430bac7f79 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -111,6 +111,16 @@ struct ddebug_class_map {
 #define NUM_TYPE_ARGS(eltype, ...)				\
         (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
+/*
+ * refer to the classmap instantiated once, by the macro above.  This
+ * distinguishes the multiple users of drm.debug from the single
+ * definition, allowing them to specialize.  ATM its a pass-thru, but
+ * it should help regularize the admittedly wierd sharing by identical
+ * definitions.
+ */
+#define REFERENCE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
+	DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, __VA_ARGS__)
+
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
-- 
2.38.1

