Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12E363D12E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiK3I5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiK3I5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:57:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8732CE0A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669798669; x=1701334669;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1es6/A3ga1m5NpXqdmla/W5OjLRqvafVSel0I0ZkrnM=;
  b=QmtXguEIvEeEoBdlGsZQyhoS+WdN+3qhv+J8ujoqdaiNaLw2rvh9X2DR
   ySaRJp57AJmkHd36zNywBpJPEcrlbtsKt4aGJ/U2CI9nuZeQ6cBewCWo7
   PbxVnBzJcd337LGCZHJUidMCZF5gimEpdjKNbaVU4jsH9wcNuP7xrQlIO
   TrSZGWw8AiozRUyKoQiiNqhWVrLBeb391OzHW2fz605AnipXxf6MY0ZK6
   VOVmIFarOF039XM25r5/bxM6TuOfoB8nWaaH21aoxGhjLNOyMm+ccGLPq
   NyvVHdBU0yo5fZPZxqLVnB+rO5M3+Mngywv1kA0O17pUr08/Wg07D7uUH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295039286"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="295039286"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 00:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="973026140"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="973026140"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2022 00:57:45 -0800
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
Subject: [PATCH v3 1/2] mm/slub, kunit: add SLAB_SKIP_KFENCE flag for cache  creation
Date:   Wed, 30 Nov 2022 16:54:50 +0800
Message-Id: <20221130085451.3390992-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
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
Babka suggested SLAB_SKIP_KFENCE flag could be used to achieve this,
and better add a wrapper function for simplifying cache creation.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  since v2:
    * Don't make SKIP_KFENCE an allowd flag for cache creation, and
      solve a bug of failed cache creation issue (Marco Elver)
    * Add a wrapper cache creation function to simplify code
     including SKIP_KFENCE handling (Vlastimil Babka)

 lib/slub_kunit.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 7a0564d7cb7a..5b0c8e7eb6dc 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -9,10 +9,25 @@
 static struct kunit_resource resource;
 static int slab_errors;
 
+/*
+ * Wrapper function for kmem_cache_create(), which reduces 2 parameters:
+ * 'align' and 'ctor', and sets SLAB_SKIP_KFENCE flag to avoid getting an
+ * object from kfence pool, where the operation could be caught by both
+ * our test and kfence sanity check.
+ */
+static struct kmem_cache *test_kmem_cache_create(const char *name,
+				unsigned int size, slab_flags_t flags)
+{
+	struct kmem_cache *s = kmem_cache_create(name, size, 0,
+					(flags | SLAB_NO_USER_FLAGS), NULL);
+	s->flags |= SLAB_SKIP_KFENCE;
+	return s;
+}
+
 static void test_clobber_zone(struct kunit *test)
 {
-	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_alloc", 64, 0,
-				SLAB_RED_ZONE|SLAB_NO_USER_FLAGS, NULL);
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_alloc", 64,
+							SLAB_RED_ZONE);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kasan_disable_current();
@@ -29,8 +44,8 @@ static void test_clobber_zone(struct kunit *test)
 #ifndef CONFIG_KASAN
 static void test_next_pointer(struct kunit *test)
 {
-	struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
-				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_next_ptr_free",
+							64, SLAB_POISON);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 	unsigned long tmp;
 	unsigned long *ptr_addr;
@@ -74,8 +89,8 @@ static void test_next_pointer(struct kunit *test)
 
 static void test_first_word(struct kunit *test)
 {
-	struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
-				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_1th_word_free",
+							64, SLAB_POISON);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kmem_cache_free(s, p);
@@ -89,8 +104,8 @@ static void test_first_word(struct kunit *test)
 
 static void test_clobber_50th_byte(struct kunit *test)
 {
-	struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
-				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_50th_word_free",
+							64, SLAB_POISON);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kmem_cache_free(s, p);
@@ -105,8 +120,8 @@ static void test_clobber_50th_byte(struct kunit *test)
 
 static void test_clobber_redzone_free(struct kunit *test)
 {
-	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
-				SLAB_RED_ZONE|SLAB_NO_USER_FLAGS, NULL);
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_free", 64,
+							SLAB_RED_ZONE);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
 
 	kasan_disable_current();
-- 
2.34.1

