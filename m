Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232D15ED73C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiI1IN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiI1INZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:13:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BC49DFAD;
        Wed, 28 Sep 2022 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664352803; x=1695888803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WB6T+yJXx+m1nIR3FdvolGa4A9+LMo8MXrdYv+JxSW8=;
  b=eLB4/mgLhulGtEkDCHOqnXqoyOD+ptZp4vS4AXHeQWAwaUJwkyoICAN1
   2ipKZ/G3g1XpkMSu4EECkjDknN9zyVGT0WZMcw74kIX/a3HJ46Z0ULqvx
   CGzFJCo+LhnQd5s1zCMfvF44eE0K9uTg1Itif1OT0hyVZPth75bPvWtdU
   UdXnVs8oTgdnntg8TAApiZn4xJoqPUNJU9pGocy8NhrwQQnhHJGKVHcPG
   6Y6Z28Yg1Pk0PK2PuinF8VHKijx44erG6nBU6PNlJg42i7UqSdx0WNBzg
   IMKVPLASUqv13RcFoEq4YCg8l4KY3Bvzfu49fQfu37tLvD5e8RpZN7AIv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="300258247"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="300258247"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:13:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621836042"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="621836042"
Received: from maciejos-mobl.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.147.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:13:13 -0700
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
Subject: [PATCH v13 0/9] Fixes integer overflow or integer truncation issues in page lookups, ttm place configuration and scatterlist creation
Date:   Wed, 28 Sep 2022 11:12:51 +0300
Message-Id: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
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
In order to provide a common macro, it adds a few utility macros
into overflow header.
Introduce check_assign() and check_assign_user_ptr(). the check_assign()
macro which performs an assigning source value into destination pointer
along with an overflow check and check_assign_user_ptr() macro which
performs an assigning source value into destination pointer type variable
along with an overflow check. If an explicit overflow check is required
while assigning to a user-space ptr, assign_user_ptr() can be used instead
of u64_to_user_ptr() to assign integers into __user pointers along with an
overflow check. check_assign(), overflows_type() are implemented on top of
updated check_add_overflow() macro [1], and it also uses updated
overflows_type() and castable_to_type() macro [2].
Therefore this series include the patch which came from Kees [1][2]
(the both patches are under reviewing from other patch mails).

[1] https://lore.kernel.org/all/202208311040.C6CA8253@keescook/
[2] https://lore.kernel.org/lkml/20220926191109.1803094-1-keescook@chromium.org/

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
  overflow: Introduce overflows_type() and castable_to_type()

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
 drivers/gpu/drm/i915/i915_utils.h             |   4 -
 drivers/gpu/drm/i915/i915_vma.c               |   8 +-
 drivers/gpu/drm/i915/intel_region_ttm.c       |  17 +-
 include/linux/compiler.h                      |   1 +
 include/linux/overflow.h                      | 166 ++++--
 lib/overflow_kunit.c                          | 489 ++++++++++++++++--
 21 files changed, 993 insertions(+), 158 deletions(-)

-- 
2.37.1

