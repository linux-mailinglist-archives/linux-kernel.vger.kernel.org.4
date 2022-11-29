Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1565A63B9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK2GhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2GhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:37:00 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE40532E3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 22:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669703819; x=1701239819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mjnKay8jU2S2Yvtj+sHUiviWAPaCCXEzlMpUe4IYiY=;
  b=BRDcQ8RLxKBNxjXIazw+5ZxE+WszOzpwPaxafZGe2sINwuB+3u31Df6s
   brgZRFeFUtwdwbdg8hTT/f8JqfmEVoP+wVPuO1EiLBsvK5KeRHhIHKXG9
   JTKXJGVJEku3+x7D9OfscT6KxzwqYl2R3DT9LxLWLTAV0wvnfQ8/02pqX
   d77NyZrdOYkwEziAzoHFHKWki+mxwedUQqQlU7bxa8Zt44wM4K0njqSnB
   MAIVSwhhcWIMmF4IfQmofC1t1Y9+eQJ5rr5A45opjPDJKxTCohGL92hsW
   3nKDAeKXl9xbe3yqTbsraDa3uCAT+VkDZiPlxrm0F5/8qnXqogfZMy2jt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377178792"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="377178792"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 22:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="645784217"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="645784217"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2022 22:36:56 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Marco Elver <elver@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 2/2] mm/slub, kunit: Add a test case for kmalloc redzone check
Date:   Tue, 29 Nov 2022 14:33:58 +0800
Message-Id: <20221129063358.3012362-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129063358.3012362-1-feng.tang@intel.com>
References: <20221129063358.3012362-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
kmem_cache mimicing kmalloc cache is created with similar and all
necessary flags to have kmalloc-redzone enabled, and kmalloc_trace()
is used to really test the orig_size and redzone setup.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:
 
  since v1:
  * create a new cache mimicing kmalloc cache, reduce dependency
    over global slub_debug setting (Vlastimil Babka)

 lib/slub_kunit.c | 23 +++++++++++++++++++++++
 mm/slab.h        |  3 ++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index a303adf8f11c..dbdd656624d0 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -122,6 +122,28 @@ static void test_clobber_redzone_free(struct kunit *test)
 	kmem_cache_destroy(s);
 }
 
+static void test_kmalloc_redzone_access(struct kunit *test)
+{
+	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_kmalloc", 32, 0,
+				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE|DEFAULT_FLAGS,
+				NULL);
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
@@ -141,6 +163,7 @@ static struct kunit_case test_cases[] = {
 #endif
 
 	KUNIT_CASE(test_clobber_redzone_free),
+	KUNIT_CASE(test_kmalloc_redzone_access),
 	{}
 };
 
diff --git a/mm/slab.h b/mm/slab.h
index c71590f3a22b..b6cd98b16ba7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -327,7 +327,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 /* Legal flag mask for kmem_cache_create(), for various configurations */
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
-			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
+			 SLAB_KMALLOC | SLAB_SKIP_KFENCE | \
+			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS)
 
 #if defined(CONFIG_DEBUG_SLAB)
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
-- 
2.34.1

