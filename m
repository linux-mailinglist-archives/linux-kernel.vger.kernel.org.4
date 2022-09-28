Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32EC5ED744
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiI1INz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiI1INo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:13:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39269CD66A;
        Wed, 28 Sep 2022 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664352823; x=1695888823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a15giGE9U8MfRV7QFZGLrBfnIa+lhGBT+wMMe9HhDqQ=;
  b=DM9KW3MwKnzA9v8zOrtpRZVEanPdJBArB4gRnUbmeWjuRNBL+P1hz13a
   +jJh+1NNoHMv2RGSA/TwZ3BRJi3GPTqtPmuPnUi7ZyaOG/wiKdtHVncif
   g7gGEWjYS2x02Dd3hwG//Sg9h9SZ6ywm0p1/k3PyibSWVBA+Jb623jcad
   ezVM5plkD2m3XA8w/UJTK7VWGqP3u/8btNYlStdTmGWIVZAkhIYbS7bE7
   Ba7g06Ty7c04ayQH0BtIkBhEPeoqRfYSBBjR5LEp0a3s4IDB/ll27dSeV
   ZnkUe2FyXt7dDCTkHzdbAj25dcK+hXg25DgZmkKxKI7soJTtuPODujRj8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="284671713"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="284671713"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:13:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621836209"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="621836209"
Received: from maciejos-mobl.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.147.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:13:32 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Subject: [PATCH v13 2/9] overflow: Introduce check_assign() and check_assign_user_ptr()
Date:   Wed, 28 Sep 2022 11:12:53 +0300
Message-Id: <20220928081300.101516-3-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check_assign() macro which performs an assigning source value into
destination pointer along with an overflow check and
check_assign_user_ptr() macro which performs an assigning source value into
destination pointer type variable along with an overflow check. If an
explicit overflow check is required while assigning to a user-space ptr,
assign_user_ptr() can be used instead of u64_to_user_ptr() to assign
integers into __user pointers along with an overflow check.

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
v11: Fix incorrect type assignment between different address spaces caused
     by the wrong use of __user macro. (kernel test robot)
     Update macro description (G.G)
v12: Remove overflows_type() macro here. updated overflows_type() macro
     will be added in a subsequent patch (G.G)

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
Acked-by: Kees Cook <keescook@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/i915/i915_user_extensions.c |  6 +--
 include/linux/overflow.h                    | 44 +++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

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
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 19dfdd74835e..8ccbfa46f0ed 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -5,6 +5,7 @@
 #include <linux/compiler.h>
 #include <linux/limits.h>
 #include <linux/const.h>
+#include <linux/types.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -127,6 +128,49 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
+	check_assign(value, &kptr) ? 1 : (({ ptr = (void __user *)kptr; }), 0);	\
+}))
+
 /**
  * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
  *
-- 
2.37.1

