Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0203067BD12
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbjAYUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbjAYUie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:34 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E75DC3A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:14 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b15so7117707ils.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnMUEjJ7hDYerikZFh4H7GzHFAs+BMIlQC4nGPQ5N2I=;
        b=FcNDSYof9Lay+btdEWScxDBua9r+A+J3FA8L+k9PTpwA7V6TUokaJdmDbBWmT74byc
         VZHoTUss+DjVe5EdvqBl5r883mYNrsiPMW72Go/cM+92tpU4Mauj4cbqmXYUrNqQlC1t
         8WnpP30SjH6wgnFfBjFWEZHXZf46+d+kNGHIiR8f/rCjQSLiunhrvClRK3bMaDBkD9uJ
         WbFx1539MrSSIBoKkLKRQuX7sD6QZFL/bQ2JCfNvUng0FtEKSKDD3bez/EwGT1klE+wf
         jqFiAboAEUpt/KkV+KY0hIMzDMJdOWOZaEBV/8pCihkAdQKoZJc6qtyJxTV87R29p5zV
         BFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnMUEjJ7hDYerikZFh4H7GzHFAs+BMIlQC4nGPQ5N2I=;
        b=NYIf6ky7PAKj6h7qgi+e2RlWy4VtkfxjQlvoQ2xXtR2MCoev7dbW0oWCTk8IhlBrOT
         elNjlDXOkrm/TvY3UmDSjEV0b6DKSU3pKpfGDdY8wQllME5KkT6Os5I1spQFg/TL3Mo5
         c/XTiLR1gdku1dpJatleDSaQ1ItoiiROiXYrCAmekANLUdzlrIDkkM2oxmvtI2V0/oRX
         brB5FwSiNUIBvvXRc4tQNlBsk3Eyis+Pn5A7Qm3/0Srgjoddo641UZGVwGmYSoNpN04j
         SZwTtB96QzLGSoTvKdXXN2+wxJtVoEueW7oGC/Nf3kv5x2gjICF1VaiOWvrrXX1UezqX
         0a8g==
X-Gm-Message-State: AFqh2krLNLKY9wLRBQpnYmeN6xgw9wqGg0471o5HWudMu1O4ro8BBgYd
        PR0PpgOmm1Vol8wMFS1gLl4a76ALUI8=
X-Google-Smtp-Source: AMrXdXuwrG7A4zgbzJ5nbwOXdQfr7f/bB7faEgcW+LgrJcgHZ/aY8zra4ZTSCxU+aBpgjvVY11JKqQ==
X-Received: by 2002:a92:cb8c:0:b0:30f:15a6:8857 with SMTP id z12-20020a92cb8c000000b0030f15a68857mr22396686ilo.29.1674679093459;
        Wed, 25 Jan 2023 12:38:13 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:13 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 15/19] test-dyndbg: build test_dynamic_debug_submod
Date:   Wed, 25 Jan 2023 13:37:39 -0700
Message-Id: <20230125203743.564009-16-jim.cromie@gmail.com>
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

CONFIG_DRM_USE_DYNAMIC_DEBUG=y has a regression; drm subsystem
modules, which depend upon drm.ko and use the drm.debug API, do not
get enabled when __drm_debug is set by `modprobe drm debug=0x1f`.

With =N, __drm_debug is checked before logging the msg, so the
end-of-modprobe debug=$init affected all later checks.  But with =y,
each run-time check is replaced by a static-key that is set at
end-of-modprobe.

This creates a chicken-egg dependency; i915 must be modprobed before
its drm.debugs are enabled, but drm.ko (and __drm_debug=$init) must be
done before modprobe i915, so its callsites arent there yet to be
enabled.

The fix is to split DECLARE_DYNDBG_CLASSMAP to:

DYNDBG_CLASSMAP_DEFINE - invoked in 'parent'
DYNDBG_CLASSMAP_USE - invoked in dependent, to USE the exported definition

To prove the fix w/o involving DRM, we need 2 modules, one dependent
on the other.  Add test_dynamic_debug_submod.ko, which _USEs the
classmaps _exported by test_dynamic_debug.ko

To keep code to a minimum, test_dynamic_debug.c ifdefs on
TEST_DYNAMIC_DEBUG_SUBMOD to build either parent or dependent, with
either DYNDBG_CLASSMAP_DEFINE or DYNDBG_CLASSMAP_USE invocations.

So test_dynamic_debug_submod.c is just 2 lines: include the .c after
defining SUBMOD.  This also gives the 2 modules identical prdbg
callsites, only differing by enablement/configuration.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/Makefile                    |  3 +-
 lib/test_dynamic_debug.c        | 52 ++++++++++++++++++++++++++++-----
 lib/test_dynamic_debug_submod.c | 10 +++++++
 3 files changed, 57 insertions(+), 8 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c

diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..7f7e75f44cd7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,7 +77,7 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
-obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
+obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o test_dynamic_debug_submod.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
@@ -98,6 +98,7 @@ obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
 # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index e678884066bf..8c005c17f2db 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -6,7 +6,11 @@
  *      Jim Cromie	<jim.cromie@gmail.com>
  */
 
-#define pr_fmt(fmt) "test_dd: " fmt
+#if defined(TEST_DYNAMIC_DEBUG_SUBMOD)
+  #define pr_fmt(fmt) "test_dd_submod: " fmt
+#else
+  #define pr_fmt(fmt) "test_dd: " fmt
+#endif
 
 #define DEBUG /* enable all prdbgs (plain & class'd) at compiletime */
 
@@ -49,6 +53,14 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
 	};								\
 	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes, &_flags##_model, 0600)
 
+/*
+ * dynamic-debug imitates drm.debug's use of enums (DRM_UT_CORE etc)
+ * to define its classes/categories.  dyndbg allows class-id's 0..62,
+ * reserving 63 for plain old (non-class'd) prdbgs.  A module can
+ * define multiple classmaps, as long as they claim non-overlapping
+ * subranges.
+ */
+
 /* numeric input, independent bits */
 enum cat_disjoint_bits {
 	D2_CORE = 0,
@@ -61,7 +73,36 @@ enum cat_disjoint_bits {
 	D2_LEASE,
 	D2_DP,
 	D2_DRMRES };
+
+/* symbolic input, independent bits */
+enum cat_disjoint_names { LOW = 10, MID, HI };
+
+/* numeric verbosity, V2 > V1 related */
+enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
+
+/* symbolic verbosity */
+enum cat_level_names { L0 = 22, L1, L2, L3, L4, L5, L6, L7 };
+
+#if defined(TEST_DYNAMIC_DEBUG_SUBMOD)
+
+/* use the classmaps defined in 'parent' module below */
+DYNDBG_CLASSMAP_USE(map_disjoint_bits);
+DYNDBG_CLASSMAP_USE(map_disjoint_names);
+DYNDBG_CLASSMAP_USE(map_level_num);
+DYNDBG_CLASSMAP_USE(map_level_names);
+
+#else
+
+/*
+ * parent module, define a classmap of each of 4 types.
+ * enum values are class-ids
+ * enum symbols are stringified, used as classnames
+ * param bits are mapped in order: 0..N
+ * (a straight, obvious, linear map is encouraged)
+ */
+
 DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
+		       /* bits 0..N of param are mapped to these class-ids */
 		       D2_CORE,
 		       D2_DRIVER,
 		       D2_KMS,
@@ -75,27 +116,23 @@ DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
 DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
-/* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 10, MID, HI };
 DYNDBG_CLASSMAP_DEFINE(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES,
 		       LOW, MID, HI);
 DD_SYS_WRAP(disjoint_names, p);
 DD_SYS_WRAP(disjoint_names, T);
 
-/* numeric verbosity, V2 > V1 related */
-enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
 DYNDBG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 		       V0, V1, V2, V3, V4, V5, V6, V7);
 DD_SYS_WRAP(level_num, p);
 DD_SYS_WRAP(level_num, T);
 
-/* symbolic verbosity */
-enum cat_level_names { L0 = 22, L1, L2, L3, L4, L5, L6, L7 };
 DYNDBG_CLASSMAP_DEFINE(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES,
 		       L0, L1, L2, L3, L4, L5, L6, L7);
 DD_SYS_WRAP(level_names, p);
 DD_SYS_WRAP(level_names, T);
 
+#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
+
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
@@ -142,6 +179,7 @@ static void do_levels(void)
 
 static void do_prints(void)
 {
+	pr_debug("do_prints:\n");
 	do_cats();
 	do_levels();
 }
diff --git a/lib/test_dynamic_debug_submod.c b/lib/test_dynamic_debug_submod.c
new file mode 100644
index 000000000000..9a893402ce1a
--- /dev/null
+++ b/lib/test_dynamic_debug_submod.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kernel module for testing dynamic_debug
+ *
+ * Authors:
+ *      Jim Cromie	<jim.cromie@gmail.com>
+ */
+
+#define TEST_DYNAMIC_DEBUG_SUBMOD
+#include "test_dynamic_debug.c"
-- 
2.39.1

