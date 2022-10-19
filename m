Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85421604FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJSSfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJSSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:35:18 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF2516CA71
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:13 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id cr19so9001924qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqPl+RdDZasj+PMC0bHfA3Xf0sYC/j0J/r3M/mDgoBg=;
        b=o/FMt/dqQwSaauSgcCCt+Lp/GhEMH7INlOVFF7bKazItclGN+dZS4C6OPftGCm7yaV
         HW+IX4CDFx5YbMUzVuy3vsWHfz9a9132q9osoR+z9y+jLCQ+cA27CFfH6eQIXszCuuka
         lU83AJmF/njieS1eLbhGdF7fsSFPU8B0CWX7TVvm4Dmedi6nSlL6qulf/gwNmK98Iu0m
         GRBjPsh2e5DiKu0xro8BK7Wgb1J6NFclRtQiFPIlbQ4cG1meSCrYURC0Sy31kke2OM3e
         oHVIrCgAmvFW0IuKyB3DS4mIWF+3tsL+1xCR2wRbfRI8hdNMDovYaUWnBz/9urGFs0Zd
         9niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqPl+RdDZasj+PMC0bHfA3Xf0sYC/j0J/r3M/mDgoBg=;
        b=eSNB0x6PBi7Qds9vidbjMP9zAhZbeqBU72wzXDxa7U6QU9+WyG493EYYfYHyrHDYPO
         6+V/ZPrQjyoJYAq/GiHV2jEbex1nbwCyeg7PW49R9RHUsshjl3SGF+sNAM6YUy95v5p0
         aYeftqnaMUEBQmXGNZzPGNBSnMp7dKKQ1B5zNbRgopxC2IjLmb34vqbuh7DG9lVzkKYK
         X1DB4K/kTpxsHspCrBFwucDXOPZ1p2X2i2QZIPprfuzIX9fZHc7S+H+J5TcCzAIEZa1p
         PYHGXrah/4bAhk8qgfDedDwpiQovM0KZ7Blc1m4170TyOLYEPIlJZUKG/5vabGGwtxAt
         dTSA==
X-Gm-Message-State: ACrzQf06/t3QpHsnUwAvPiDjiSleMNQZizG6YNsF6O8k5hDwSzrFuDAC
        NJIoBAm7213sgVBq7EEtEi8=
X-Google-Smtp-Source: AMsMyM6nAoV2eyE2dqFHeh9P5TIJXAGNHQomyab/USOy0QEgmazGDATW/pBybh4N5XuEUz2fLItqhA==
X-Received: by 2002:a05:622a:1210:b0:35b:bbed:9b13 with SMTP id y16-20020a05622a121000b0035bbbed9b13mr7654239qtx.606.1666204512288;
        Wed, 19 Oct 2022 11:35:12 -0700 (PDT)
Received: from sophie ([143.244.47.100])
        by smtp.gmail.com with ESMTPSA id fb20-20020a05622a481400b0039442ee69c5sm4495264qtb.91.2022.10.19.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:35:11 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 4/5] memblock tests: add generic NUMA tests for memblock_alloc_exact_nid_raw
Date:   Wed, 19 Oct 2022 13:34:11 -0500
Message-Id: <44611cd9c0939cdf2e3f232298b547efee4d772a.1666203644.git.remckee0@gmail.com>
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
2.25.1

