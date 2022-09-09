Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4865B35EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIIK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiIIK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:59:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA406192AB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662721184; x=1694257184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqnvQZZmqlppIrLqxR7AWPt8tNJLCHPb5qBykGHKpmQ=;
  b=dWrJl5z1rG0CN9ug05/SRVhHXgQdUPd436IAKGrIUib90FaiMAUyttYE
   Oqconu6brNP/Bq/lE44aGWUQisfzAU00j4DopvwcDElwA+RgQobasTw15
   9m2OivX2l6wEGiKwxLnQrA4T7gc+vEiBmmsD2M4dMYByGwIOOitag1bgl
   gzDOnT0QLswIX90/aWdh/31Vg1Pqsy151t9vuCTcJkPmeG03D+f+/LXHQ
   L/s9X70GG+1dUixp2a+g0hbmK40EvbPnLjmfzN50GcgExMOaU8Nu+F4e0
   fIRUATwPWxNq5oucAybpp/EABEjS8/IA+a21UgVeGeYXXsMIHAbCGfL5s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297449528"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="297449528"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:59:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="704370317"
Received: from clbarnes-mobl.amr.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.42.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:59:41 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com
Subject: [PATCH v10 2/9] overflow: Move and add few utility macros into overflow
Date:   Fri,  9 Sep 2022 19:59:06 +0900
Message-Id: <20220909105913.752049-3-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It moves overflows_type utility macro into overflow header from i915_utils
header. The overflows_type can be used to catch the truncaion (overflow)
between different data types. And it adds check_assign() macro which
performs an assigning source value into destination pointer along with an
overflow check. overflow_type macro has been improved to handle the
different data types between source and destination by check_add_overflow
macro. It also adds check_assign_user_ptr macro which performs an assigning
source value into destination pointer type variable along with an overflow
check. If an explicit overflow check is required while assigning,
check_assign_user_ptr() can be used to assign integers into pointers along
with an overflow check.

v3: Add is_type_unsigned() macro (Mauro)
    Modify overflows_type() macro to consider signed data types (Mauro)
    Fix the problem that safe_conversion() macro always returns true
v4: Fix kernel-doc markups
v6: Move macro addition location so that it can be used by other than drm
    subsystem (Jani, Mauro, Andi)
    Change is_type_unsigned to is_unsigned_type to have the same name form
    as is_signed_type macro
v8: Add check_assign() and remove safe_conversion() (Kees)
    Fix overflows_type() to use gcc's built-in overflow function (Andrzej)
    Add overflows_ptr() to allow overflow checking when assigning a value
    into a pointer variable (G.G.)
v9: Fix overflows_type() to use __builtin_add_overflow() instead of
    __builtin_add_overflow_p() (Andrzej)
    Fix overflows_ptr() to use overflows_type() with the unsigned long type
    (Andrzej)
v10: Remove a redundant type checking for a pointer. (Andrzej)
     Use updated check_add_overflow macro instead of __builtin_add_overflow
     (G.G)
     Add check_assign_user_ptr() macro and drop overflows_ptr() macro(Kees)

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v5)
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com> (v9)
---
 drivers/gpu/drm/i915/i915_user_extensions.c |  6 +-
 drivers/gpu/drm/i915/i915_utils.h           |  5 +-
 include/linux/overflow.h                    | 64 +++++++++++++++++++++
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_user_extensions.c b/drivers/gpu/drm/i915/i915_user_extensions.c
index c822d0aafd2d..80ec8390b0d8 100644
--- a/drivers/gpu/drm/i915/i915_user_extensions.c
+++ b/drivers/gpu/drm/i915/i915_user_extensions.c
@@ -50,11 +50,11 @@ int i915_user_extensions(struct i915_user_extension __user *ext,
 		if (err)
 			return err;
 
-		if (get_user(next, &ext->next_extension) ||
-		    overflows_type(next, ext))
+		if (get_user(next, &ext->next_extension))
 			return -EFAULT;
 
-		ext = u64_to_user_ptr(next);
+		if (check_assign_user_ptr(next, ext))
+			return -EFAULT;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 6c14d13364bf..efd3d69b78f7 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/sched/clock.h>
+#include <linux/overflow.h>
 
 #ifdef CONFIG_X86
 #include <asm/hypervisor.h>
@@ -111,10 +112,6 @@ bool i915_error_injected(void);
 #define range_overflows_end_t(type, start, size, max) \
 	range_overflows_end((type)(start), (type)(size), (type)(max))
 
-/* Note we don't consider signbits :| */
-#define overflows_type(x, T) \
-	(sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
-
 #define ptr_mask_bits(ptr, n) ({					\
 	unsigned long __v = (unsigned long)(ptr);			\
 	(typeof(ptr))(__v & -BIT(n));					\
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 19dfdd74835e..9e8fc8f03e7a 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -5,6 +5,7 @@
 #include <linux/compiler.h>
 #include <linux/limits.h>
 #include <linux/const.h>
+#include <linux/types.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -127,6 +128,69 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	(*_d >> _to_shift) != _a);					\
 }))
 
+/**
+ * check_assign - perform an assigning source value into destination pointer
+ *                along with an overflow check.
+ *
+ * @value: source value
+ * @ptr: Destination pointer address
+ *
+ * Returns:
+ * If the value would overflow the destination, it returns true. If not return
+ * false. When overflow does not occur, the assigning into destination from
+ * value succeeds. It follows the return policy as other check_*_overflow()
+ * functions return non-zero as a failure.
+ */
+#define check_assign(value, ptr) __must_check_overflow(({	\
+	check_add_overflow(0, value, ptr);			\
+}))
+
+/**
+ * check_assign_user_ptr - perform an assigning source value into destination
+ *                         pointer type variable along with an overflow check
+ *
+ * @value: source value; a source value is expected to have a value of a size
+ *         that can be stored in a pointer-type variable.
+ * @ptr: destination pointer type variable
+ *
+ * u64_to_user_ptr can be used in the kernel to avoid warnings about integers
+ * and pointers of different sizes. But u64_to_user_ptr is not performing the
+ * checking of overflow. If you need an explicit overflow check while
+ * assigning, check_assign_user_ptr() can be used to assign integers into
+ * pointers along with an overflow check. If ptr is not a pointer type,
+ * a warning message outputs while compiling.
+ *
+ * Returns:
+ * If the value would overflow the destination, it returns true. If not return
+ * false. When overflow does not occur, the assigning into ptr from value
+ * succeeds. It follows the return policy as other check_*_overflow() functions
+ * return non-zero as a failure.
+ */
+#define check_assign_user_ptr(value, ptr) __must_check_overflow(({		\
+	uintptr_t kptr;								\
+	check_assign(value, &kptr) ? 1 : (({ ptr = (void * __user)kptr; }), 0);	\
+}))
+
+/**
+ * overflows_type - helper for checking the overflows between data types or
+ *                  values
+ *
+ * @x: source value or data type for overflow check
+ * @T: destination value or data type for overflow check
+ *
+ * It compares the values or data type between the first and second argument to
+ * check whether overflow can occur when assigning the first argument to the
+ * variable of the second argument. Source and Destination can be different data
+ * types.
+ *
+ * Returns:
+ * True if overflow can occur, false otherwise.
+ */
+#define overflows_type(x, T) __must_check_overflow(({	\
+	typeof(T) v = 0;				\
+	check_add_overflow((x), v, &v);			\
+}))
+
 /**
  * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
  *
-- 
2.37.1

