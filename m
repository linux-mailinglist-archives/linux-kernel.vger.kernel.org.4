Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7961EAFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiKGG2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiKGG2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:28:33 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2566334
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:28:31 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id c2so10174014plz.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P3GXLwjs/AzRC+Yyz4W1T1PxERupjghE5iW4kXnA/o=;
        b=U5GxdAo1RNjvZ6+u+mGdkxoyMlS7rSLanZa9RtJ8ETL+RySplCSfyErplB31LTlj5I
         EdCAx78IBm3QIwmm1NgBwxHd+gBeef8D2DbG3Y20LUMt0sYlqisFsERi5bjEQeKsbzB/
         f5FpA58ZkwsSnmTl7/xcIXleq21y7hIBFItQGuCWgBqtYUVS6n4A672v9IlTypfQsJyS
         ttJBig5CgoKBuS6cYYWSDZyTxRi93UIpyzsZm3W6abDP8oU11uRow8CYRDFZ0MdipLOS
         8xQvi1wfZaTZRt+9+PXnNl2qwrscgHHpKC2VJE4m6pubB4MpilvNb5WKh+r14i1Bv8ZF
         jQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P3GXLwjs/AzRC+Yyz4W1T1PxERupjghE5iW4kXnA/o=;
        b=2RcqNP3W+699YS+aFqhSNuLSNV8YIY5liV0zIKgt/18eUBSI9wr8exmYKD7KQ2cab5
         vDb7VMiVLaEYSPb3TwIfsO1WpCkzddMhXTFp63pK/ANbJ5epR1jgKlvK2F6HNa0c2Oxk
         4IbO8iYRZRHjPA1KSkijC17Ss0Cw0okhwACzMSyJqCN8pqdZ1phGDYrucKk8zo5APhjN
         eWOUNk2gbup1Z1vci3BTImC9mjuZETN2o1vQON5r0bVhcjtsv2+cps7rLshcchCaGrRN
         n5AIQxQeAKramGDzklJAXYS6pBPgrYrVI7v7a27c2nomhmIZ6uFeZGU3ysd8NyF9axKv
         6lhg==
X-Gm-Message-State: ACrzQf39hAzqRS/Hp0aIUQmF4r+Ck1STOhPYEIN1JI6apFunfhzisc5E
        6VIXu1KWv6OL6Y7xAVx1JSNJzFOIQ38=
X-Google-Smtp-Source: AMsMyM633YHqj+OKe0PK48RQEOxat+9YZvp8a94jG78Wnu2+1nCQq9qaAi0yguBOywGkiwpsYxq6Lg==
X-Received: by 2002:a17:903:1351:b0:188:53bd:877a with SMTP id jl17-20020a170903135100b0018853bd877amr564004plb.84.1667802511046;
        Sun, 06 Nov 2022 22:28:31 -0800 (PST)
Received: from sophie ([89.46.114.207])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b0018869119e37sm4111525pln.142.2022.11.06.22.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 22:28:30 -0800 (PST)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 4/5] memblock tests: add generic NUMA tests for memblock_alloc_exact_nid_raw
Date:   Mon,  7 Nov 2022 00:28:08 -0600
Message-Id: <51b14da46e6591428df3aefc5acc7dca9341a541.1667802195.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667802195.git.remckee0@gmail.com>
References: <cover.1667802195.git.remckee0@gmail.com>
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
memory is set up with multiple NUMA nodes. Additionally, all but one of
these tests set nid != NUMA_NO_NODE. All tests are run for both top-down
and bottom-up allocation directions.

The tested scenarios are:

Range unrestricted:
- region cannot be allocated:
      + there are no previously reserved regions, but requested node is
        too small
      + the requested node is fully reserved
      + the requested node is partially reserved and does not have
        enough space
      + none of the nodes have enough memory to allocate the region

Range restricted:
- region can be allocated in the specific node requested without
  dropping min_addr:
      + the range fully overlaps with the node, and there are adjacent
        reserved regions
- region cannot be allocated:
      + range partially overlaps with two different nodes, where the
        second node is the requested node
      + range overlaps with multiple nodes along node boundaries, and
        the requested node starts after max_addr
      + nid is set to NUMA_NO_NODE and the total range can fit the
        region, but the range is split between two nodes and everything
        else is reserved

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 .../memblock/tests/alloc_exact_nid_api.c      | 465 ++++++++++++++++++
 1 file changed, 465 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_exact_nid_api.c b/tools/testing/memblock/tests/alloc_exact_nid_api.c
index b97b5c04de05..6e14447da6e1 100644
--- a/tools/testing/memblock/tests/alloc_exact_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.c
@@ -560,6 +560,390 @@ static int alloc_exact_nid_bottom_up_numa_no_overlap_low_check(void)
 	return 0;
 }
 
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * does not have enough memory to allocate a region of the requested size:
+ *
+ *  |   +-----+                            |
+ *  |   | req |                            |
+ *  +---+-----+----------------------------+
+ *
+ *  +---------+
+ *  |   rgn   |
+ *  +---------+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_exact_nid_numa_small_node_generic_check(void)
+{
+	int nid_req = 1;
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	size = SZ_2 * req_node->size;
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * is fully reserved:
+ *
+ *  |              +---------+             |
+ *  |              |requested|             |
+ *  +--------------+---------+-------------+
+ *
+ *  |              +---------+             |
+ *  |              | reserved|             |
+ *  +--------------+---------+-------------+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_exact_nid_numa_node_reserved_generic_check(void)
+{
+	int nid_req = 2;
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	size = req_node->size;
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	memblock_reserve(req_node->base, req_node->size);
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * is partially reserved and does not have enough contiguous memory for the
+ * allocated region:
+ *
+ *  |           +-----------------------+    |
+ *  |           |       requested       |    |
+ *  +-----------+-----------------------+----+
+ *
+ *  |                 +----------+           |
+ *  |                 | reserved |           |
+ *  +-----------------+----------+-----------+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_exact_nid_numa_part_reserved_fail_generic_check(void)
+{
+	int nid_req = 4;
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
+	ASSERT_LE(SZ_4, req_node->size);
+	size = req_node->size / SZ_2;
+	r1.base = req_node->base + (size / SZ_2);
+	r1.size = size;
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	memblock_reserve(r1.base, r1.size);
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region that spans over the min_addr
+ * and max_addr range and overlaps with two different nodes, where the second
+ * node is the requested node:
+ *
+ *                               min_addr
+ *                               |         max_addr
+ *                               |         |
+ *                               v         v
+ *  |      +--------------------------+---------+                |
+ *  |      |        first node        |requested|                |
+ *  +------+--------------------------+---------+----------------+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_exact_nid_numa_split_range_high_generic_check(void)
+{
+	int nid_req = 3;
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_512;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	min_addr = req_node->base - SZ_256;
+	max_addr = min_addr + size;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range when
+ * the requested node and the range do not overlap, and requested node starts
+ * after max_addr. The range overlaps with multiple nodes along node
+ * boundaries:
+ *
+ *        min_addr
+ *        |                                 max_addr
+ *        |                                 |
+ *        v                                 v
+ *  |     +----------+----...----+----------+        +-----------+   |
+ *  |     | min node |    ...    | max node |        | requested |   |
+ *  +-----+----------+----...----+----------+--------+-----------+---+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_exact_nid_numa_no_overlap_high_generic_check(void)
+{
+	int nid_req = 7;
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
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * does not have enough memory to allocate a region of the requested size.
+ * Additionally, none of the nodes have enough memory to allocate the region:
+ *
+ * +-----------------------------------+
+ * |                new                |
+ * +-----------------------------------+
+ *     |-------+-------+-------+-------+-------+-------+-------+-------|
+ *     | node0 | node1 | node2 | node3 | node4 | node5 | node6 | node7 |
+ *     +-------+-------+-------+-------+-------+-------+-------+-------+
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_exact_nid_numa_large_region_generic_check(void)
+{
+	int nid_req = 3;
+	void *allocated_ptr = NULL;
+	phys_addr_t size = MEM_SIZE / SZ_2;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM();
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_addr range when
+ * there are two reserved regions at the borders. The requested node starts at
+ * min_addr and ends at max_addr and is the same size as the region to be
+ * allocated:
+ *
+ *                     min_addr
+ *                     |                       max_addr
+ *                     |                       |
+ *                     v                       v
+ *  |      +-----------+-----------------------+-----------------------|
+ *  |      |   node5   |       requested       |         node7         |
+ *  +------+-----------+-----------------------+-----------------------+
+ *                     +                       +
+ *  |             +----+-----------------------+----+                  |
+ *  |             | r2 |          new          | r1 |                  |
+ *  +-------------+----+-----------------------+----+------------------+
+ *
+ * Expect to merge all of the regions into one. The region counter and total
+ * size fields get updated.
+ */
+static int alloc_exact_nid_numa_reserved_full_merge_generic_check(void)
+{
+	int nid_req = 6;
+	int nid_next = nid_req + 1;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	struct memblock_region *next_node = &memblock.memory.regions[nid_next];
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+	phys_addr_t size = req_node->size;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	r1.base = next_node->base;
+	r1.size = SZ_128;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (size + r2.size);
+
+	total_size = r1.size + r2.size + size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(new_rgn->size, total_size);
+	ASSERT_EQ(new_rgn->base, r2.base);
+
+	ASSERT_LE(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(req_node), region_end(new_rgn));
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range,
+ * where the total range can fit the region, but it is split between two nodes
+ * and everything else is reserved. Additionally, nid is set to NUMA_NO_NODE
+ * instead of requesting a specific node:
+ *
+ *                         +-----------+
+ *                         |    new    |
+ *                         +-----------+
+ *  |      +---------------------+-----------|
+ *  |      |      prev node      | next node |
+ *  +------+---------------------+-----------+
+ *                         +           +
+ *  |----------------------+           +-----|
+ *  |          r1          |           |  r2 |
+ *  +----------------------+-----------+-----+
+ *                         ^           ^
+ *                         |           |
+ *                         |           max_addr
+ *                         |
+ *                         min_addr
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_exact_nid_numa_split_all_reserved_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+	struct memblock_region *next_node = &memblock.memory.regions[7];
+	struct region r1, r2;
+	phys_addr_t size = SZ_256;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	r2.base = next_node->base + SZ_128;
+	r2.size = memblock_end_of_DRAM() - r2.base;
+
+	r1.size = MEM_SIZE - (r2.size + size);
+	r1.base = memblock_start_of_DRAM();
+
+	min_addr = r1.base + r1.size;
+	max_addr = r2.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
 /* Test case wrappers for NUMA tests */
 static int alloc_exact_nid_numa_simple_check(void)
 {
@@ -616,6 +1000,78 @@ static int alloc_exact_nid_numa_no_overlap_low_check(void)
 	return 0;
 }
 
+static int alloc_exact_nid_numa_small_node_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_numa_small_node_generic_check);
+	run_bottom_up(alloc_exact_nid_numa_small_node_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_node_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_numa_node_reserved_generic_check);
+	run_bottom_up(alloc_exact_nid_numa_node_reserved_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_part_reserved_fail_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_numa_part_reserved_fail_generic_check);
+	run_bottom_up(alloc_exact_nid_numa_part_reserved_fail_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_split_range_high_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_numa_split_range_high_generic_check);
+	run_bottom_up(alloc_exact_nid_numa_split_range_high_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_no_overlap_high_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_numa_no_overlap_high_generic_check);
+	run_bottom_up(alloc_exact_nid_numa_no_overlap_high_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_large_region_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_numa_large_region_generic_check);
+	run_bottom_up(alloc_exact_nid_numa_large_region_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_reserved_full_merge_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_numa_reserved_full_merge_generic_check);
+	run_bottom_up(alloc_exact_nid_numa_reserved_full_merge_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_numa_split_all_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_numa_split_all_reserved_generic_check);
+	run_bottom_up(alloc_exact_nid_numa_split_all_reserved_generic_check);
+
+	return 0;
+}
+
 int __memblock_alloc_exact_nid_numa_checks(void)
 {
 	test_print("Running %s NUMA tests...\n", FUNC_NAME);
@@ -626,6 +1082,15 @@ int __memblock_alloc_exact_nid_numa_checks(void)
 	alloc_exact_nid_numa_no_overlap_split_check();
 	alloc_exact_nid_numa_no_overlap_low_check();
 
+	alloc_exact_nid_numa_small_node_check();
+	alloc_exact_nid_numa_node_reserved_check();
+	alloc_exact_nid_numa_part_reserved_fail_check();
+	alloc_exact_nid_numa_split_range_high_check();
+	alloc_exact_nid_numa_no_overlap_high_check();
+	alloc_exact_nid_numa_large_region_check();
+	alloc_exact_nid_numa_reserved_full_merge_check();
+	alloc_exact_nid_numa_split_all_reserved_check();
+
 	return 0;
 }
 
-- 
2.34.1

