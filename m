Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532B35E9631
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiIYV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiIYV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:27:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ECB2A717
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:21 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x18so3137773qkn.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AnSl/+Yx5Yy04UR1QvyY6oxDRVK8JRL9AgwGNDJ8kEQ=;
        b=D9RO48YLgDTWj6DXKQMN5oQ/z0OOcAnW57pCeR0KrXdpB+Ja8z+INuB4uTIZ4rm0CQ
         y6GmZrXjWo0MyAn2p5HrpaGajuHBgStX5fv8HuJXcbRfDYhHTvZqr9TRPyWEsuywmxp7
         jVSCP3TTa3jPAnshFoLlExkaV5O1WjcoI6BHdQKCDX9tLd8xuEBOMwxuaYzHOJDvLVxx
         vUstHiux+qAFlUM8p+cPtw+3eDbmzhJ5oZq0dKA6tYm4cZ4BFnflC47FJTeLo9OkbhJh
         AUnz9W8a4UCGRfY8MJ4GTsajjT9zf73MiWiE+/oBrTPp3ULGKEP0CKfFIu3ZDBuq6//m
         kLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AnSl/+Yx5Yy04UR1QvyY6oxDRVK8JRL9AgwGNDJ8kEQ=;
        b=NLF/lhRb1EAOZPigLwwCaHR7TY3U4srz0xXFxArkG74wN/DwUfnNFQdXITtecUb17j
         0eTaB4wyC0T29CUV0puvp/AINyTFkZbIiPjg4lGvxHFGwEoLaVZG2e4gSiGW1coK9H4C
         vBiq09No35RFBRjAaMJXST0Dt/SDUKHbgOHM8KPYIsY5nFKNi1dPwEOmswSQZs8DNp1D
         Dt/2XO8SMAN2zJeER9Jrj5FKfva9sp/znReL77Cb9snThT9iurTalxQgMNqTLVIcp3Wf
         L5WAkXtGM6Us0LSXf9YKemTUxnTT2XuQ8KuUJoTZESCunSvoF29gWETSAalDJ3e3HTZr
         RU3Q==
X-Gm-Message-State: ACrzQf2Z+LYGc8+UZox3ZLOFxnevnmK8rKJ1EpbKGxkaOvq1mhKdsAVm
        HcE5gCFhOXpEypQmsJBEkXFhHSj6pFs=
X-Google-Smtp-Source: AMsMyM6HxE6WVnNDmJbtC+zVohCvtEQyifDdqBDPWn2P1QnvlWw+vs8cvdPT6WWGfEZXP7830AIGkA==
X-Received: by 2002:a05:620a:2903:b0:6cf:920f:435c with SMTP id m3-20020a05620a290300b006cf920f435cmr3148352qkp.741.1664141240856;
        Sun, 25 Sep 2022 14:27:20 -0700 (PDT)
Received: from sophie ([185.156.46.189])
        by smtp.gmail.com with ESMTPSA id o22-20020ac872d6000000b0035d420c4ba7sm542379qtp.54.2022.09.25.14.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 14:27:20 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 4/5] memblock tests: add generic NUMA tests for memblock_alloc_exact_nid_raw
Date:   Sun, 25 Sep 2022 16:26:55 -0500
Message-Id: <a1776e195f8e1a08cc828be3bb9760b1d59e8ddd.1664138929.git.remckee0@gmail.com>
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
index 63279d1e35b1..0f9a84867207 100644
--- a/tools/testing/memblock/tests/alloc_exact_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.c
@@ -1746,6 +1746,390 @@ static int alloc_exact_nid_bottom_up_numa_no_overlap_low_check(void)
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
@@ -1802,6 +2186,78 @@ static int alloc_exact_nid_numa_no_overlap_low_check(void)
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
@@ -1812,6 +2268,15 @@ int __memblock_alloc_exact_nid_numa_checks(void)
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

