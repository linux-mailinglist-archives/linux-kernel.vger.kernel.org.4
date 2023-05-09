Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABD6FBE8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 07:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjEIFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 01:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbjEIFOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 01:14:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D99028
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 22:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683609291; x=1715145291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/zV+bBMFzqzEbY+zzFUi37/thW9CxZ9azFDevSUQdV0=;
  b=EJ0ErFeEMyLQqq7fhYPEDJ3JavD+UZ6nsYN0jo+wFtG/8j9vC3B4qCKO
   q5eDVBBu88+Jn7ei73QVeKL0UglOiHpHGEFoUa974ZbJS5fO/EdV9nAgW
   280en2mHw28wbh+QE5u/23rPriVgzNbyd9UA8ZV1VUhBYJrFR+EG8FcMO
   i6SdvdGPFADoE6YEQu9W2MvfPYPmmLjvuAKzdyOMfdCX+kqkFN0A2gz2h
   mvVYNCDhydf6CT+21fdBcPsddhaSuDunot18XTHOH9eIQ7LFcZBO2R9WI
   5Y5QHRshjhU9vmvjMEdYyyOveH+wMY6As8YuqyuB+bWkmPCnIJhMSkXlv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339037116"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="339037116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 22:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="873033256"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="873033256"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 22:14:45 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/3] drm/i915: Temporary conversion to new GENMASK/BIT macros
Date:   Mon,  8 May 2023 22:14:03 -0700
Message-Id: <20230509051403.2748545-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509051403.2748545-1-lucas.demarchi@intel.com>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the REG_* macros from i915_reg_defs.h to use the new macros
defined in linux/bits.h. This is just to help on the implementation
of the new macros and not intended to be applied.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_reg_defs.h | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_reg_defs.h b/drivers/gpu/drm/i915/i915_reg_defs.h
index 622d603080f9..61fbb8d62b25 100644
--- a/drivers/gpu/drm/i915/i915_reg_defs.h
+++ b/drivers/gpu/drm/i915/i915_reg_defs.h
@@ -17,10 +17,7 @@
  *
  * @return: Value with bit @__n set.
  */
-#define REG_BIT(__n)							\
-	((u32)(BIT(__n) +						\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
-				 ((__n) < 0 || (__n) > 31))))
+#define REG_BIT(__n) BIT_U32(__n)
 
 /**
  * REG_BIT8() - Prepare a u8 bit value
@@ -30,10 +27,7 @@
  *
  * @return: Value with bit @__n set.
  */
-#define REG_BIT8(__n)                                                   \
-	((u8)(BIT(__n) +                                                \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&         \
-				 ((__n) < 0 || (__n) > 7))))
+#define REG_BIT8(__n) BIT_U8(__n)
 
 /**
  * REG_GENMASK() - Prepare a continuous u32 bitmask
@@ -44,11 +38,7 @@
  *
  * @return: Continuous bitmask from @__high to @__low, inclusive.
  */
-#define REG_GENMASK(__high, __low)					\
-	((u32)(GENMASK(__high, __low) +					\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&	\
-				 __is_constexpr(__low) &&		\
-				 ((__low) < 0 || (__high) > 31 || (__low) > (__high)))))
+#define REG_GENMASK(__high, __low) GENMASK_U32(__high, __low)
 
 /**
  * REG_GENMASK64() - Prepare a continuous u64 bitmask
@@ -59,11 +49,7 @@
  *
  * @return: Continuous bitmask from @__high to @__low, inclusive.
  */
-#define REG_GENMASK64(__high, __low)					\
-	((u64)(GENMASK_ULL(__high, __low) +				\
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&		\
-				 __is_constexpr(__low) &&		\
-				 ((__low) < 0 || (__high) > 63 || (__low) > (__high)))))
+#define REG_GENMASK64(__high, __low) GENMASK_ULL(__high, __low)
 
 /**
  * REG_GENMASK8() - Prepare a continuous u8 bitmask
@@ -74,11 +60,7 @@
  *
  * @return: Continuous bitmask from @__high to @__low, inclusive.
  */
-#define REG_GENMASK8(__high, __low)                                     \
-	((u8)(GENMASK(__high, __low) +                                  \
-	       BUILD_BUG_ON_ZERO(__is_constexpr(__high) &&      \
-				 __is_constexpr(__low) &&               \
-				 ((__low) < 0 || (__high) > 7 || (__low) > (__high)))))
+#define REG_GENMASK8(__high, __low) GENMASK_U8(__high, __low)
 
 /*
  * Local integer constant expression version of is_power_of_2().
-- 
2.40.1

