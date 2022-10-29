Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC0612092
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ2Ff0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJ2FfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:35:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F0357565
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667021721; x=1698557721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APZf4orwR0bmaXXk1zd0xukTX05Ic5bjW94jeQ9JrPw=;
  b=bGOZ1J8ZIePIKuuoaYf/oc2hAZGg1IAUAh9SSvrpPNFu3ZQwCebezVfS
   53wj9/Vek6KNPgfpgeGmdYY4diqPZagwgWfbb5etdiwXn5hJsddHhUlzb
   o5jsjEmm2IDEarXGqQmsNMYvF2UPJRAfHaIVdcLE6lcmii944obf+yNwm
   ddOX+lWR7v5MXN1CBxEpYKK789h0bTwjl+RmU384Dq3aQjEeznn4J0MPI
   oTFOeFan4ir47Gq3ii4m/dE5eWNZKJPvKygvjxUUOksSfc4U9o5rZMNsL
   o9+6bBz2YNJTT83V86UWFNgt1vfUZYxNuXNHxToeHQ2f+54uPx/kcjjZx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="335288949"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="335288949"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 22:35:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="758319635"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="758319635"
Received: from tgajewsk-mobl.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.140.235])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 22:35:19 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     ndesaulniers@google.com
Cc:     peterz@infradead.org, llvm@lists.linux.dev,
        ashutosh.dixit@intel.com, andi.shyti@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bitfield: Use argument type for size comparison on Bitfield access macros
Date:   Sat, 29 Oct 2022 08:34:29 +0300
Message-Id: <20221029053429.38381-1-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the size comparison code that implicitly assumes that the mask argument
of bitfield access macros is an unsigned long long type.
If unsigned int type is used for mask, the first argument of Bitfield
access macros, and clang is used to compile, this [1] option causes a build
error.[2]

[1] [-Werror,-Wtautological-constant-out-of-range-compare]
[2] https://lore.kernel.org/intel-gfx/c1c548f8-71a8-0d4d-d591-58a0cd5dac20@intel.com

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
---
 include/linux/bitfield.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index c9be1657f03d..4382bd62b14f 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -9,6 +9,7 @@
 
 #include <linux/build_bug.h>
 #include <asm/byteorder.h>
+#include <linux/overflow.h>
 
 /*
  * Bitfield access macros
@@ -69,7 +70,8 @@
 				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
 				 _pfx "value too large for the field"); \
 		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
-				 __bf_cast_unsigned(_reg, ~0ull),	\
+				 __bf_cast_unsigned(_reg,		\
+						    type_max(__unsigned_scalar_typeof(_reg))), \
 				 _pfx "type of reg too small for mask"); \
 		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
 					      (1ULL << __bf_shf(_mask))); \
@@ -84,7 +86,10 @@
  */
 #define FIELD_MAX(_mask)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
+		__BF_FIELD_CHECK(_mask,					\
+				 type_min(__unsigned_scalar_typeof(_mask)), \
+				 type_min(__unsigned_scalar_typeof(_mask)), \
+				 "FIELD_MAX: ");			\
 		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
 	})
 
@@ -97,7 +102,10 @@
  */
 #define FIELD_FIT(_mask, _val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
+		__BF_FIELD_CHECK(_mask,					\
+				 type_min(__unsigned_scalar_typeof(_mask)), \
+				 type_min(__unsigned_scalar_typeof(_val)), \
+				 "FIELD_FIT: ");			\
 		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
 	})
 
@@ -111,7 +119,9 @@
  */
 #define FIELD_PREP(_mask, _val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
+		__BF_FIELD_CHECK(_mask,					\
+				 type_min(__unsigned_scalar_typeof(_mask)), \
+				 _val, "FIELD_PREP: ");			\
 		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
 	})
 
@@ -125,7 +135,9 @@
  */
 #define FIELD_GET(_mask, _reg)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
+		__BF_FIELD_CHECK(_mask, _reg,				\
+				 type_min(__unsigned_scalar_typeof(_reg)), \
+				 "FIELD_GET: ");			\
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
-- 
2.37.1

