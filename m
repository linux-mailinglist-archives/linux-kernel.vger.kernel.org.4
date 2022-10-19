Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F34604FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJSSfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJSSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:35:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F1A1552DF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:08 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l28so12267773qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGXe7jLtYGY1YP2N1w0hr8ZmPtDOoXLhtl5xhD+f2+E=;
        b=Da6KovRipl4p7VJ+YDz1DhvDQ5tXjiDXp95hz6yoE8+dUvdVeC7zs8bqlvWiKHxLE2
         KZd6lpMNIxrI4VMvmYySzEw+jYAUYd3gLeywm2jwToOjpKepW07Z2+nO/FnTS9JqQgzI
         LbLh22zZHCAe9lUUjnuSnr7dHbhRqU/Jfp2STOW4UGGZzq3AsPtkCLjjegB2kD4t6AQ/
         SFAEsMk8JlbdKdfqdY3WaBsMwnQ8A3vRwk9KRrIGyA7rByeuijBoDXJLtVg8bL4nbGiL
         jOa/1crNsFXjA04Cx5K5sKnmauRKCoSb+khv4lze5QRbXFpUyL1akTCsj5esGcazF8Dk
         PfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGXe7jLtYGY1YP2N1w0hr8ZmPtDOoXLhtl5xhD+f2+E=;
        b=IrryWsNkR9H64Wccu6Sp6d31PeYKjpDhF98FDOUMrsxJjD63LbbPiY3Qy6y/lkglNc
         QDsvsNsBcw6HZf3/WApaomqjGUTj3fBUkVYqSpWNOOaLETlegDojOudMggfpbkj9YTaC
         TMPJRPWF3iu4Y7LUQQ+wO6SOsaG/1zABH5OKF5rCKe+Pc6MEARrSnzqPa7n5b/oslqFf
         ssiKazXaKMbs3m/CDsUfm2w0sD/yIAYmKv1ERY2NblxEMdh9Fm48nz1FX1oLv2CGR/Oq
         0tkYaElPA8OveaVkpdTLRyNxhok590NatzmANzUrfBy5l5hbYapVrpaz+aXK4sYgZqAw
         yHFg==
X-Gm-Message-State: ACrzQf3gr2WRWPCZ7y9MbAYmZh9tSuJnGf0WnTb9H2fM4Sb5lRuKwk4Q
        wHJRrgnLYWH88b6tJ2ccnBg=
X-Google-Smtp-Source: AMsMyM7zG0wd+P6EZxgab7HjpBCmzgcwheAjoVWWXcPKbfU4Lk0JMfcz9TWxjDwG6xoPEzOg6Wr7ng==
X-Received: by 2002:ac8:7d4c:0:b0:399:b8eb:749e with SMTP id h12-20020ac87d4c000000b00399b8eb749emr7556022qtb.446.1666204507249;
        Wed, 19 Oct 2022 11:35:07 -0700 (PDT)
Received: from sophie ([143.244.47.100])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a40d000b006eeb3165554sm5537313qko.19.2022.10.19.11.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:35:06 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 2/5] memblock tests: add top-down NUMA tests for memblock_alloc_exact_nid_raw
Date:   Wed, 19 Oct 2022 13:34:09 -0500
Message-Id: <cf1f686743ff8f1da9618088b7f0ea0ba4ebaecb.1666203643.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666203642.git.remckee0@gmail.com>
References: <cover.1666203642.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for memblock_alloc_exact_nid_raw() where the simulated physical
memory is set up with multiple NUMA nodes. Additionally, all of these
tests set nid != NUMA_NO_NODE. These tests are run with a top-down
allocation direction.

The tested scenarios are:

Range unrestricted:
- region can be allocated in the specific node requested:
      + there are no previously reserved regions
      + the requested node is partially reserved but has enough space

Range restricted:
- region can be allocated in the specific node requested after dropping
  min_addr:
      + range partially overlaps with two different nodes, where the
        first node is the requested node
      + range partially overlaps with two different nodes, where the
        requested node ends before min_addr
      + range overlaps with multiple nodes along node boundaries, and
        the requested node ends before min_addr

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 .../memblock/tests/alloc_exact_nid_api.c      | 344 ++++++++++++++++++
 .../memblock/tests/alloc_exact_nid_api.h      |  16 +
 2 files changed, 360 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_exact_nid_api.c b/tools/testing/memblock/tests/alloc_exact_nid_api.c
index 6406496623a0..79150784b373 100644
--- a/tools/testing/memblock/tests/alloc_exact_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.c
@@ -4,6 +4,349 @@
 
 #define FUNC_NAME			"memblock_alloc_exact_nid_raw"
 
+/*
+ * contains the fraction of MEM_SIZE contained in each node in basis point
+ * units (one hundredth of 1% or 1/10000)
+ */
+static const unsigned int node_fractions[] = {
+	2500, /* 1/4  */
+	 625, /* 1/16 */
+	1250, /* 1/8  */
+	1250, /* 1/8  */
+	 625, /* 1/16 */
+	 625, /* 1/16 */
+	2500, /* 1/4  */
+	 625, /* 1/16 */
+};
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * has enough memory to allocate a region of the requested size.
+ * Expect to allocate an aligned region at the end of the requested node.
+ */
+static int alloc_exact_nid_top_down_numa_simple_check(void)
+{
+	int nid_req = 3;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	ASSERT_LE(SZ_4, req_node->size);
+	size = req_node->size / SZ_4;
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
+	ASSERT_LE(req_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * is partially reserved but has enough memory for the allocated region:
+ *
+ *  |           +---------------------------------------+          |
+ *  |           |               requested               |          |
+ *  +-----------+---------------------------------------+----------+
+ *
+ *  |           +------------------+              +-----+          |
+ *  |           |     reserved     |              | new |          |
+ *  +-----------+------------------+--------------+-----+----------+
+ *
+ * Expect to allocate an aligned region at the end of the requested node. The
+ * region count and total size get updated.
+ */
+static int alloc_exact_nid_top_down_numa_part_reserved_check(void)
+{
+	int nid_req = 4;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[1];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	struct region r1;
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	ASSERT_LE(SZ_8, req_node->size);
+	r1.base = req_node->base;
+	r1.size = req_node->size / SZ_2;
+	size = r1.size / SZ_4;
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	memblock_reserve(r1.base, r1.size);
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
+	ASSERT_LE(req_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, size + r1.size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region that spans over the min_addr
+ * and max_addr range and overlaps with two different nodes, where the first
+ * node is the requested node:
+ *
+ *                                min_addr
+ *                                |           max_addr
+ *                                |           |
+ *                                v           v
+ *  |           +-----------------------+-----------+              |
+ *  |           |       requested       |   node3   |              |
+ *  +-----------+-----------------------+-----------+--------------+
+ *                                +           +
+ *  |                       +-----------+                          |
+ *  |                       |    rgn    |                          |
+ *  +-----------------------+-----------+--------------------------+
+ *
+ * Expect to drop the lower limit and allocate a memory region that ends at
+ * the end of the requested node.
+ */
+static int alloc_exact_nid_top_down_numa_split_range_low_check(void)
+{
+	int nid_req = 2;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_512;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t req_node_end;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	req_node_end = region_end(req_node);
+	min_addr = req_node_end - SZ_256;
+	max_addr = min_addr + size;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, req_node_end - size);
+	ASSERT_LE(req_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region that spans over the min_addr
+ * and max_addr range and overlaps with two different nodes, where the requested
+ * node ends before min_addr:
+ *
+ *                                         min_addr
+ *                                         |         max_addr
+ *                                         |         |
+ *                                         v         v
+ *  |    +---------------+        +-------------+---------+          |
+ *  |    |   requested   |        |    node1    |  node2  |          |
+ *  +----+---------------+--------+-------------+---------+----------+
+ *                                         +         +
+ *  |          +---------+                                           |
+ *  |          |   rgn   |                                           |
+ *  +----------+---------+-------------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a memory region that ends at
+ * the end of the requested node.
+ */
+static int alloc_exact_nid_top_down_numa_no_overlap_split_check(void)
+{
+	int nid_req = 2;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *node2 = &memblock.memory.regions[6];
+	void *allocated_ptr = NULL;
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	size = SZ_512;
+	min_addr = node2->base - SZ_256;
+	max_addr = min_addr + size;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
+	ASSERT_LE(req_node->base, new_rgn->base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range when
+ * the requested node and the range do not overlap, and requested node ends
+ * before min_addr. The range overlaps with multiple nodes along node
+ * boundaries:
+ *
+ *                          min_addr
+ *                          |                                 max_addr
+ *                          |                                 |
+ *                          v                                 v
+ *  |-----------+           +----------+----...----+----------+      |
+ *  | requested |           | min node |    ...    | max node |      |
+ *  +-----------+-----------+----------+----...----+----------+------+
+ *                          +                                 +
+ *  |     +-----+                                                    |
+ *  |     | rgn |                                                    |
+ *  +-----+-----+----------------------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a memory region that ends at
+ * the end of the requested node.
+ */
+static int alloc_exact_nid_top_down_numa_no_overlap_low_check(void)
+{
+	int nid_req = 0;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *min_node = &memblock.memory.regions[2];
+	struct memblock_region *max_node = &memblock.memory.regions[5];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_64;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	min_addr = min_node->base;
+	max_addr = region_end(max_node);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(new_rgn->size, size);
+	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/* Test case wrappers for NUMA tests */
+static int alloc_exact_nid_numa_simple_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_numa_simple_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_part_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_numa_part_reserved_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_split_range_low_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_numa_split_range_low_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_no_overlap_split_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_numa_no_overlap_split_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_no_overlap_low_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_numa_no_overlap_low_check();
+
+	return 0;
+}
+
+int __memblock_alloc_exact_nid_numa_checks(void)
+{
+	test_print("Running %s NUMA tests...\n", FUNC_NAME);
+
+	alloc_exact_nid_numa_simple_check();
+	alloc_exact_nid_numa_part_reserved_check();
+	alloc_exact_nid_numa_split_range_low_check();
+	alloc_exact_nid_numa_no_overlap_split_check();
+	alloc_exact_nid_numa_no_overlap_low_check();
+
+	return 0;
+}
+
 int memblock_alloc_exact_nid_checks(void)
 {
 	prefix_reset();
@@ -13,6 +356,7 @@ int memblock_alloc_exact_nid_checks(void)
 	dummy_physical_memory_init();
 
 	memblock_alloc_exact_nid_range_checks();
+	memblock_alloc_exact_nid_numa_checks();
 
 	dummy_physical_memory_cleanup();
 
diff --git a/tools/testing/memblock/tests/alloc_exact_nid_api.h b/tools/testing/memblock/tests/alloc_exact_nid_api.h
index 4408719de3b9..cef419d55d2a 100644
--- a/tools/testing/memblock/tests/alloc_exact_nid_api.h
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.h
@@ -5,5 +5,21 @@
 #include "common.h"
 
 int memblock_alloc_exact_nid_checks(void);
+int __memblock_alloc_exact_nid_numa_checks(void);
+
+#ifdef CONFIG_NUMA
+static inline int memblock_alloc_exact_nid_numa_checks(void)
+{
+	__memblock_alloc_exact_nid_numa_checks();
+	return 0;
+}
+
+#else
+static inline int memblock_alloc_exact_nid_numa_checks(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
 
 #endif
-- 
2.25.1

