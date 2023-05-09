Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE416FBE8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 07:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjEIFOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 01:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjEIFOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 01:14:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F179025
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683609290; x=1715145290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ci3h/ZFdl5D0Hl7kzFcbanHfMsv6+NX1ka7tFtfJ1yc=;
  b=XM+C5mHrL2DPvDQgjNznPzhQDBSw0B920c1CTHF3/FsyjEyf8BHdLANb
   1VVasaZ/S0nI1nMziWulXjB0ioRmOQBpmrgHmXgVvXTG13RjeVGy7XAji
   Xqkrj1gOqrpxz9RCQTTdHqrdvPZbzhNX0DnHHKiq/kKQB9kX6Eejs5OMu
   K+6dFn6spZ69ztXXGuQHOUwBYUCWvlxN+kr5QX+fgToF6ZtUQqrgoKFIR
   6XaENbIjQEymYGoAxrK7/m9cZ9+qJN5Tf0JLzxo9/CGmuclOD6FTV7qz1
   d6jEzUmMfZeQAAUyb09Aw2yJFngvOqTmGhd/sBS2JQZHl8d88TIYpF53L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339037109"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="339037109"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 22:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="873033253"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="873033253"
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
Subject: [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK and BIT macros
Date:   Mon,  8 May 2023 22:14:02 -0700
Message-Id: <20230509051403.2748545-3-lucas.demarchi@intel.com>
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

Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
masks for fixed-width types and also the corresponding BIT_U32(),
BIT_U16() and BIT_U8().

All of those depend on a new "U" suffix added to the integer constant.
Due to naming clashes it's better to call the macro U32. Since C doesn't
have a proper suffix for short and char types, the U16 and U18 variants
just use U32 with one additional check in the BIT_* macros to make
sure the compiler gives an error when the those types overflow.
The BIT_U16() and BIT_U8() need the help of GENMASK_INPUT_CHECK(),
as otherwise they would allow an invalid bit to be passed. Hence
implement them in include/linux/bits.h rather than together with
the other BIT* variants.

The following test file is is used to test this:

	$ cat mask.c
	#include <linux/types.h>
	#include <linux/bits.h>

	static const u32 a = GENMASK_U32(31, 0);
	static const u16 b = GENMASK_U16(15, 0);
	static const u8 c = GENMASK_U8(7, 0);
	static const u32 x = BIT_U32(31);
	static const u16 y = BIT_U16(15);
	static const u8 z = BIT_U8(7);

	#if FAIL
	static const u32 a2 = GENMASK_U32(32, 0);
	static const u16 b2 = GENMASK_U16(16, 0);
	static const u8 c2 = GENMASK_U8(8, 0);
	static const u32 x2 = BIT_U32(32);
	static const u16 y2 = BIT_U16(16);
	static const u8 z2 = BIT_U8(8);
	#endif

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/bits.h       | 22 ++++++++++++++++++++++
 include/uapi/linux/const.h |  2 ++
 include/vdso/const.h       |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 7c0cf5031abe..ff4786c99b8c 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -42,4 +42,26 @@
 #define GENMASK_ULL(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
+#define __GENMASK_U32(h, l) \
+	(((~U32(0)) - (U32(1) << (l)) + 1) & \
+	 (~U32(0) >> (32 - 1 - (h))))
+#define GENMASK_U32(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U32(h, l))
+
+#define __GENMASK_U16(h, l) \
+	((U32(0xffff) - (U32(1) << (l)) + 1) & \
+	 (U32(0xffff) >> (16 - 1 - (h))))
+#define GENMASK_U16(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U16(h, l))
+
+#define __GENMASK_U8(h, l) \
+	(((U32(0xff)) - (U32(1) << (l)) + 1) & \
+	 (U32(0xff) >> (8 - 1 - (h))))
+#define GENMASK_U8(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U8(h, l))
+
+#define BIT_U32(nr)	_BITU32(nr)
+#define BIT_U16(nr)	(GENMASK_INPUT_CHECK(16 - 1, nr) + (U32(1) << (nr)))
+#define BIT_U8(nr)	(GENMASK_INPUT_CHECK(32 - 1, nr) + (U32(1) << (nr)))
+
 #endif	/* __LINUX_BITS_H */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index a429381e7ca5..3a4e152520f4 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -22,9 +22,11 @@
 #define _AT(T,X)	((T)(X))
 #endif
 
+#define _U32(x)		(_AC(x, U))
 #define _UL(x)		(_AC(x, UL))
 #define _ULL(x)		(_AC(x, ULL))
 
+#define _BITU32(x)	(_U32(1) << (x))
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
diff --git a/include/vdso/const.h b/include/vdso/const.h
index 94b385ad438d..417384a9795b 100644
--- a/include/vdso/const.h
+++ b/include/vdso/const.h
@@ -4,6 +4,7 @@
 
 #include <uapi/linux/const.h>
 
+#define U32(x)		(_U32(x))
 #define UL(x)		(_UL(x))
 #define ULL(x)		(_ULL(x))
 
-- 
2.40.1

