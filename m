Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918A95EAD0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIZQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIZQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:47:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73DE6567;
        Mon, 26 Sep 2022 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664206817; x=1695742817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4XhPcRJh4ka65SQONH+kTJV7Dl3Cx9q/CZr71E/oqUk=;
  b=U6HuBRkKdHmVWrPA9exPF5ns+TMV/vd6krlfHwuLe63Ep9pC3rKHUEV3
   uBDjhPU3rQvabo7nRKz6G9mZo6n3PI6tHciRDVCQD8Hvet0MT1LwuLqSG
   U4cLJyUBFKg6kbeJy60dx7XfOKp3uktdSeVil9EptEBirk4vujcyREW3l
   2iJ1WoFLSDGAQ2xCp9mhLGZIFYfa4DSFXViM2vUDvdEbBkXopYtStG1fc
   hhkYPq6QdfgSPS7Dgn1vBolvLKPxUX5cysnjk8Tg82FbNEgjnuTHV3jHO
   EBbFI3Znk/Pdc7aYUGYpok4/VJpNqyYMx/Sp35EpCd89Mgu7QtXJLX12s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="362889948"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="362889948"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 08:40:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="763480818"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="763480818"
Received: from bsochack-mobl2.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.128.215])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 08:40:07 -0700
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
Subject: [PATCH v12 0/9] Fixes integer overflow or integer truncation issues in page lookups, ttm place configuration and scatterlist creation
Date:   Mon, 26 Sep 2022 18:39:44 +0300
Message-Id: <20220926153953.3836470-1-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes integer overflow or integer truncation issues in
page lookups, ttm place configuration and scatterlist creation, etc.
We need to check that we avoid integer overflows when looking up a page,
and so fix all the instances where we have mistakenly used a plain integer
instead of a more suitable long.
And there is an impedance mismatch between the scatterlist API using
unsigned int and our memory/page accounting in unsigned long. That is we
may try to create a scatterlist for a large object that overflows returning
a small table into which we try to fit very many pages. As the object size
is under the control of userspace, we have to be prudent and catch the
conversion errors. To catch the implicit truncation as we switch from
unsigned long into the scatterlist's unsigned int, we use improved
overflows_type check and report E2BIG prior to the operation. This is
already used in our create ioctls to indicate if the uABI request is simply
too large for the backing store. 
And ttm place also has the same problem with scatterlist creation,
and we fix the integer truncation problem with the way approached by
scatterlist creation.
And It corrects the error code to return -E2BIG when creating gem objects
using ttm or shmem, if the size is too large in each case.
In order to provide a common macro, it moves and adds a few utility macros
into overflow/compiler header.
Introduces overflows_type() and __castable_to_type(). overflows_type()
tests if a variable or constant value would  overflow another variable or
type. This can be used as a constant expression for static_assert() (which
requires a constant expression[2][3]) when used on constant values. This
must be constructed manually, since __builtin_add_overflow() does not
produce a constant expression[4]. Additionally adds __castable_to_type(),
similar to __same_type(), for checking if a constant value will fit in a
given type (i.e. it could be cast to the type without overflow). Add unit
tests for overflows_type(), __same_type(), and __castable_to_type() to the
existing KUnit "overflow" test. And Introduce check_assign() and
check_assign_user_ptr(). the check_assign() macro which performs an
assigning source value into destination pointer along with an overflow
check and check_assign_user_ptr() macro which performs an assigning source
value into destination pointer type variable along with an overflow check.
If an explicit overflow check is required while assigning to a user-space
ptr, assign_user_ptr() can be used instead of u64_to_user_ptr() to assign
integers into __user pointers along with an overflow check.
In order to implement check_assign(), overflows_type() on top of updated
check_add_overflow() macro, this series include the patch which came from
Kees [1] (this patch is under reviewing from other patch mail). 

[1] https://lore.kernel.org/all/202208311040.C6CA8253@keescook/
[2] https://en.cppreference.com/w/c/language/_Static_assert
[3] C11 standard (ISO/IEC 9899:2011): 6.7.10 Static assertions
[4] https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html
    6.56 Built-in Functions to Perform Arithmetic with Overflow Checking
    Built-in Function: bool __builtin_add_overflow (type1 a, type2 b,
                                                    type3 *res)

v12: Introduce updated overflows_type() and __castable_to_type() (Kees)
     Change to use static_assert(__castable_to_type(n ,T)) style since the
     assert_same_typable() macro has been dropped. (G.G)
v11: Update macro description (Andi)
     Change _Static_assert to static_assert (Rasmus)
     Rename assert_type to assert_same_type and  assert_typable to
     assert_same_typable (Rasmus)
     Update assert_same_typable macro to handle an overflow check on the
     target type when a constant value is used. (Kees)
     Add overflows_type_ret_const_expr which returns constant-expression
     value (G.G)
     Add is_unsigned_type (G.G)
     Add unit tests for overflows_type, overflows_type_ret_const_expr,
     assert_same_type and assert_same_typable. (Kees)
     Fix incorrect type assignment between different address spaces caused
     by the wrong use of __user macro. (kernel test robot)
v10: Add check_assign_user_ptr() macro and drop overflows_ptr() macro(Kees) 
     Use assert_typable instead of exactly_pgoff_t() macro (Kees)
     Remove a redundant type checking for a pointer. (Andrzej)
     Add patch "compiler_types.h: Add assert_type to catch type mis-match while compiling" and
     drop patch "util_macros: Add exact_type macro to catch type mis-match while compiling" from patch series (G.G.)
     (adding of assert_type(t1, t2) and assert_typable(t, n) were suggested by Kees v9's comments)
v9: Fix overflows_type() to use __builtin_add_overflow() instead of
    __builtin_add_overflow_p() (Andrzej)
    Fix overflows_ptr() to use overflows_type() with the unsigned long type (Andrzej)
v8: Add check_assign() and remove safe_conversion() (Kees)
    Replace safe_conversion() with check_assign() (Kees)
    Fix overflows_type() to use gcc's built-in overflow function (Andrzej)
    Add overflows_ptr() to allow overflow checking when assigning a value
    into a pointer variable (G.G.)
v7: Fix to use WARN_ON() macro where GEM_BUG_ON() macro was used. (Jani)
v6: Move macro addition location so that it can be used by other than drm subsystem (Jani, Mauro, Andi)
    Fix to follow general use case for GEM_BUG_ON(). (Jani)
v5: Fix an alignment to match open parenthesis
    Fix macros to be enclosed in parentheses for complex values
    Fix too long line warning
v4: Fix build warnins that reported by kernel test robot. (kernel test robot <lkp@intel.com>)
    Add kernel-doc markups to the kAPI functions and macros (Mauoro)
v3: Modify overflows_type() macro to consider signed data types and
	add is_type_unsigned() macro (Mauro)
    Make not use the same macro name on a function. (Mauro)
    For kernel-doc, macros and functions are handled in the same namespace,
    the same macro name on a function prevents ever adding documentation for it.
    Not to change execution inside a macro. (Mauro)
    Fix the problem that safe_conversion() macro always returns true (G.G)
    Add safe_conversion_gem_bug_on() macro and remove temporal SAFE_CONVERSION() macro. (G.G.)

Chris Wilson (3):
  drm/i915/gem: Typecheck page lookups
  drm/i915: Check for integer truncation on scatterlist creation
  drm/i915: Remove truncation warning for large objects

Gwan-gyeong Mun (4):
  overflow: Introduce check_assign() and check_assign_user_ptr()
  drm/i915: Check for integer truncation on the configuration of ttm
    place
  drm/i915: Check if the size is too big while creating shmem file
  drm/i915: Use error code as -E2BIG when the size of gem ttm object is
    too large

Kees Cook (2):
  overflow: Allow mixed type arguments
  overflow: Introduce overflows_type() and __castable_to_type()

 drivers/gpu/drm/i915/gem/i915_gem_internal.c  |   6 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |   7 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h    | 303 +++++++++--
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  27 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c      |   4 +
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |  19 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c       |  23 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |   5 +-
 .../drm/i915/gem/selftests/i915_gem_context.c |  12 +-
 .../drm/i915/gem/selftests/i915_gem_mman.c    |   8 +-
 .../drm/i915/gem/selftests/i915_gem_object.c  |   8 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c             |   9 +-
 drivers/gpu/drm/i915/i915_gem.c               |  18 +-
 drivers/gpu/drm/i915/i915_scatterlist.h       |  11 +
 drivers/gpu/drm/i915/i915_user_extensions.c   |   6 +-
 drivers/gpu/drm/i915/i915_utils.h             |   6 +-
 drivers/gpu/drm/i915/i915_vma.c               |   8 +-
 drivers/gpu/drm/i915/intel_region_ttm.c       |  17 +-
 include/linux/compiler.h                      |   1 +
 include/linux/overflow.h                      | 166 ++++--
 lib/overflow_kunit.c                          | 494 ++++++++++++++++--
 21 files changed, 1000 insertions(+), 158 deletions(-)

-- 
2.37.1

