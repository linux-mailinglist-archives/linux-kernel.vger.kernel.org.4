Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1563D12F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiK3I54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiK3I5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:57:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8572CE0A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669798672; x=1701334672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wUhL46G8FczpkZOn55ukJFkU1wtUnvW4RJiQUOueOmw=;
  b=L22zVcbUXLw3oi0isFiokU7qnNAdeTwelHanWr9oeyDeqC0BzO9mfPNJ
   ZcrcE7kr2Iy4Tcsei8Lopvd+mfejACYO1D/22gLR5f4115eguWtYeL374
   aQaKZrnMSyUxOdIWtJT2vTJl/b9KFwnsgbElyTA9QIcxBP5c6PJEKGNm4
   P70BAsyKrxUR5pySNdMUZf9p1rO9SMoswWug67ZEBU4rFV+FY0CzeT5fg
   MwA7ARhwYEQ2ZlNXeSvcl70c85FE4ezAk3dHohbdRUqY++MzM5gYDAPld
   w5M3d7syM9w96UD326tHY1CK9137c7lfWhlwOS4nFm4J4dVg06nLazICQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295039302"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="295039302"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 00:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="973026150"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="973026150"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2022 00:57:48 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 2/2] mm/slub, kunit: Add a test case for kmalloc redzone check
Date:   Wed, 30 Nov 2022 16:54:51 +0800
Message-Id: <20221130085451.3390992-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130085451.3390992-1-feng.tang@intel.com>
References: <20221130085451.3390992-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc redzone check for slub has been merged, and it's better to add
a kunit case for it, which is inspired by a real-world case as described
in commit 120ee599b5bf ("staging: octeon-usb: prevent memory corruption"):

"
  octeon-hcd will crash the kernel when SLOB is used. This usually happens
  after the 18-byte control transfer when a device descriptor is read.
  The DMA engine is always transferring full 32-bit words and if the
  transfer is shorter, some random garbage appears after the buffer.
  The problem is not visible with SLUB since it rounds up the allocations
  to word boundary, and the extra bytes will go undetected.
"

To avoid interrupting the normal functioning of kmalloc caches, a
kmem_cache mimicing kmalloc cache is created with similar flags, and
kmalloc_trace() is used to really test the orig_size and redzone setup.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  since v2:
    * only add SLAB_KMALLOC to SLAB_CACHE_FLAGS and SLAB_FLAGS_PERMITTEDa,
      and use new wrapper of cache creation(Vlastimil Babka)

  since v1:
    * create a new cache mimicing kmalloc cache, reduce dependency
      over global slub_debug setting (Vlastimil Babka)

 lib/slub_kunit.c | 22 ++++++++++++++++++++++
 mm/slab.h        |  4 +++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 5b0c8e7eb6dc..ff24879e3afe 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -135,6 +135,27 @@ static void test_clobber_redzone_free(struct kunit *test)
 	kmem_cache_destroy(s);
 }
 
+static void test_kmalloc_redzone_access(struct kunit *test)
+{
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
+				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
+	u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
+
+	kasan_disable_current();
+
+	/* Suppress the -Warray-bounds warning */
+	OPTIMIZER_HIDE_VAR(p);
+	p[18] = 0xab;
+	p[19] = 0xab;
+
+	kmem_cache_free(s, p);
+	validate_slab_cache(s);
+	KUNIT_EXPECT_EQ(test, 2, slab_errors);
+
+	kasan_enable_current();
+	kmem_cache_destroy(s);
+}
+
 static int test_init(struct kunit *test)
 {
 	slab_errors = 0;
@@ -154,6 +175,7 @@ static struct kunit_case test_cases[] = {
 #endif
 
 	KUNIT_CASE(test_clobber_redzone_free),
+	KUNIT_CASE(test_kmalloc_redzone_access),
 	{}
 };
 
diff --git a/mm/slab.h b/mm/slab.h
index c71590f3a22b..7cc432969945 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -344,7 +344,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 			  SLAB_ACCOUNT)
 #elif defined(CONFIG_SLUB)
 #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
-			  SLAB_TEMPORARY | SLAB_ACCOUNT | SLAB_NO_USER_FLAGS)
+			  SLAB_TEMPORARY | SLAB_ACCOUNT | \
+			  SLAB_NO_USER_FLAGS | SLAB_KMALLOC)
 #else
 #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE)
 #endif
@@ -364,6 +365,7 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 			      SLAB_RECLAIM_ACCOUNT | \
 			      SLAB_TEMPORARY | \
 			      SLAB_ACCOUNT | \
+			      SLAB_KMALLOC | \
 			      SLAB_NO_USER_FLAGS)
 
 bool __kmem_cache_empty(struct kmem_cache *);
-- 
2.34.1

