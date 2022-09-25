Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1655E962F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiIYV13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiIYV1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:27:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D952A26B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:19 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id c6so3315883qvn.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=O3V0nPhtlK3TXA87oz1HqqVg77ploxiQ5BsPzqU7s6E=;
        b=PCIFTRmajDOtysXry44eI1u7u25E7Vbm6nwPh8iESWSBTaH8AsczQf+YWdDDfXoXBL
         HHwsT+B/8C3tvzMOEGqcnd4NJnmjteRgMJH3N6GHY8vCE00xeDE3nI2aTF/NRHcSh1u6
         3KyKtEKlonOFHPS+506ttNgl7Y4hNzvfAq1Zt1DFyjH/b6OXgyzU+Wb4BXNJY+ne/j+f
         jWsOpYY7n4wfItI6f/u6WA8lsQM9kXyQVk7HLz/xgGAZwN4vw4CNpDM2wmvRn82YDjSL
         FfN0yblZwvwYk19Kx4MG8q/+QssygzxLd+YPTG8RJJn35TKOVpFthc/k7TACnk+yomZW
         3Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O3V0nPhtlK3TXA87oz1HqqVg77ploxiQ5BsPzqU7s6E=;
        b=RyKR3F6t0aVIUrUNjJap5Zd5yib2w+i025PQkY3a1zj/16B92EYnQre9Sw+y/4nTBE
         ocv9RaKUr7vPQIwsOjfsgiiNkUhezdiuG+j78uKY7EVXTttDzYNPPPvNZwyazvCBq92B
         9eiYs5vf0fYpOEugIK+1s7NVXYzK7o7psIPUVF7fdAv4kayao+U/19mQHzgq2ZXjatnU
         TLhA+ZiNpm8Ebj9JoXMZ2ao5Uv914HUQhRdQ+NwHVwZce4aMHLu90AK/1D/y81YIWE5I
         55Bb8gju5oFe6ix/03Ms0R1UTCd7QsmS9R+jIOXOM9G1K57ii3JCcAyadAAHkERQhe8u
         GqWg==
X-Gm-Message-State: ACrzQf3GFxphSVZ61n4kR4aGV2myYE0jrKv/Z+1uMv75YJhjNsnt5+XJ
        VU/arzT0MqC3rT83KG2j0NM=
X-Google-Smtp-Source: AMsMyM4tIek80imNXPhVyo9v9D4fFIhgOmpttXfFHXSIXFvBM1ZdS7UJjmpujwj90DdN/liDVOPmxw==
X-Received: by 2002:a05:6214:3011:b0:4ad:82d6:d579 with SMTP id ke17-20020a056214301100b004ad82d6d579mr14428920qvb.37.1664141238083;
        Sun, 25 Sep 2022 14:27:18 -0700 (PDT)
Received: from sophie ([185.156.46.189])
        by smtp.gmail.com with ESMTPSA id c10-20020a05620a11aa00b006bb83c2be40sm9921692qkk.59.2022.09.25.14.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 14:27:17 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 2/5] memblock tests: add top-down NUMA tests for memblock_alloc_exact_nid_raw
Date:   Sun, 25 Sep 2022 16:26:53 -0500
Message-Id: <2cc4c0972a472579da227007fc160d69e4f33727.1664138929.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664138928.git.remckee0@gmail.com>
References: <cover.1664138928.git.remckee0@gmail.com>
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
index 452aba1f19db..48c1b97a3f98 100644
--- a/tools/testing/memblock/tests/alloc_exact_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.c
@@ -3,6 +3,21 @@
 
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
 /*
  * A simple test that tries to allocate a memory region within min_addr and
  * max_addr range:
@@ -1190,6 +1205,334 @@ static int memblock_alloc_exact_nid_range_checks(void)
 	return 0;
 }
 
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
@@ -1199,6 +1542,7 @@ int memblock_alloc_exact_nid_checks(void)
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

