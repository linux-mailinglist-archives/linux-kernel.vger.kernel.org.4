Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1B63B9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiK2Gg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2Gg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:36:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C964E528A8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 22:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669703816; x=1701239816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sS0dUVwwbqCbyVXenUC31s2Bure2EG6lW7uFTvRVHFs=;
  b=YhqTiB94Cl/0CAxJ4eYzlo8gc0S2D+NBn8Kw+ggkHJnCYKF0NmZDDfhz
   dSuxeAWgIBlqYzIArBgjOzrNR88WFWfkiyoSqJyL8jB8l38CraEvm8UB8
   FEEddru8d33Q0wezDgn5JoUGM3VJ25sB4NkwaDvNcpLniJfZhKTt23+/x
   kmYBkpo/bJ/FvL5PtSyOvJko8blN/5w0qkuA1odyQhAcgfkQ1MGtjO92e
   NUBfa7kIZ/vUYYmIztlvu0n8X/5a6Z7DOIg6mKN7ekz8bdcPNiURzljmT
   ZAvcmitSedkkeEvLuTWrscdgW6VyUvwb/IG/yBibykb3lq2INSBvGCo0i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377178779"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="377178779"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 22:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="645784210"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="645784210"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2022 22:36:53 -0800
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
Subject: [PATCH v2 1/2] mm/slub, kunit: add SLAB_SKIP_KFENCE flag for cache creation
Date:   Tue, 29 Nov 2022 14:33:57 +0800
Message-Id: <20221129063358.3012362-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
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

When kfence is enabled, the buffer allocated from the test case
could be from a kfence pool, and the operation could be also
caught and reported by kfence first, causing the case to fail.

With default kfence setting, this is very difficult to be triggered.
By changing CONFIG_KFENCE_NUM_OBJECTS from 255 to 16383, and
CONFIG_KFENCE_SAMPLE_INTERVAL from 100 to 5, the allocation from
kfence did hit 7 times in different slub_kunit cases out of 900
times of boot test.

To avoid this, initially we tried is_kfence_address() to check this
and repeated allocation till finding a non-kfence address. Vlastimil
Babka suggested SLAB_SKIP_KFENCE flag could be used to achieve this
more simply.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 lib/slub_kunit.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 7a0564d7cb7a..a303adf8f11c 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -6,13 +6,15 @@
 #include <linux/kernel.h>
 #include "../mm/slab.h"
 
+#define DEFAULT_FLAGS	(SLAB_SKIP_KFENCE | SLAB_NO_USER_FLAGS)
+
 static struct kunit_resource resource;
 static int slab_errors;
 
 static void test_clobber_zone(struct kunit *test)
 {
 	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_alloc", 64, 0,
-				SLAB_RED_ZONE|SLAB_NO_USER_FLAGS, NULL);
+				SLAB_RED_ZONE|DEFAULT_FLAGS, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kasan_disable_current();
@@ -30,7 +32,7 @@ static void test_clobber_zone(struct kunit *test)
 static void test_next_pointer(struct kunit *test)
 {
 	struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
-				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
+				SLAB_POISON|DEFAULT_FLAGS, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 	unsigned long tmp;
 	unsigned long *ptr_addr;
@@ -75,7 +77,7 @@ static void test_next_pointer(struct kunit *test)
 static void test_first_word(struct kunit *test)
 {
 	struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
-				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
+				SLAB_POISON|DEFAULT_FLAGS, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kmem_cache_free(s, p);
@@ -90,7 +92,7 @@ static void test_first_word(struct kunit *test)
 static void test_clobber_50th_byte(struct kunit *test)
 {
 	struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
-				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
+				SLAB_POISON|DEFAULT_FLAGS, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kmem_cache_free(s, p);
@@ -106,7 +108,7 @@ static void test_clobber_50th_byte(struct kunit *test)
 static void test_clobber_redzone_free(struct kunit *test)
 {
 	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
-				SLAB_RED_ZONE|SLAB_NO_USER_FLAGS, NULL);
+				SLAB_RED_ZONE|DEFAULT_FLAGS, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kasan_disable_current();
-- 
2.34.1

