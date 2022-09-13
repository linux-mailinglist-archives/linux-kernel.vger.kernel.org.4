Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31E75B6745
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIMFVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIMFVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:21:38 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28184DF17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:21:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id cb8so7888240qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1XRWs8o5mhtjVjekWksqEPPsUOrfZ/THf/lKjCmIa8Q=;
        b=gFqek4JUZfWndRZ9qqE8eUQBNHTMqm5WrRW+VYq7FE+UM3BKOEt/AGLwoGuV5iJpfJ
         jARd+iEAfO7TJrDy9U6THQ8tgoGOgBROnbVOKeYalBKUZ8tEAYO9FW5N4jZv/O/inzEB
         94JXSCg6b74DPdB42obFT6v0KtT0Z71XfCnTnK1GQ9rvTM3WI3nUKfPR33/LvX8sV1Yd
         +jjC2bOLiBYofIvXDIDbC2089GEUbe1nXOHcMjgxZ1cNBj8DRFaceN1+s9WjKi5gcqNC
         RoomHVQBir2l/NroZOWlgMO2SD3yz8lJ6qSiAmuhEOv5gUH3wI7/K7TlOEaQBgqhLtZV
         u9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1XRWs8o5mhtjVjekWksqEPPsUOrfZ/THf/lKjCmIa8Q=;
        b=yvAXm6btNn7QisZ9oSaKBK5zFlHKybzgGyyUc+h+6hstT0SUP538Lj1tP8U/xzz8wk
         ZtFQqoWiwUlEAh62k6LnRzLDADeuYPbYGQLprlASnL4zdFTIfiFugNCtPKnp9rOxKKU/
         uyvaPcd15ys6vmQVFCiBXLTJUZfij5xEduio3U/EZd2RLSM4L4J4ZtQfEVntIMiG1sqL
         +HsUGv8LC7UuUkwxoi6VccdobEoWS2yoLi2kW066Ay/0UxmpLkfuWLCv6VIYLWpS+KVe
         yGkHa1pg2JJUy1CBpsjDR3gv521lOAIujpiC8Nu6aMGe/Sqy5A4U5DS5nBD0flKxcGhx
         1pzA==
X-Gm-Message-State: ACgBeo1anGl8inUAvkaQbMHw4sXjOPW3X/Yl0Tfly2/NYWhbBVmMEOMC
        ysf8k8q0X7BBGzNG75BR8Uk=
X-Google-Smtp-Source: AA6agR5i5KHaoyIW3+pSFlCGQxEgfI5IUvoNndua0LD3juvvYNqU1YmfjNOPHkAEQ3JyyoHpY7l4+w==
X-Received: by 2002:a05:622a:13cc:b0:342:fa43:95ac with SMTP id p12-20020a05622a13cc00b00342fa4395acmr26571539qtk.508.1663046495849;
        Mon, 12 Sep 2022 22:21:35 -0700 (PDT)
Received: from sophie ([45.134.140.166])
        by smtp.gmail.com with ESMTPSA id fz16-20020a05622a5a9000b00342fc6a8e25sm8095390qtb.50.2022.09.12.22.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 22:21:35 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v6 4/4] memblock tests: add generic NUMA tests for memblock_alloc_try_nid*
Date:   Tue, 13 Sep 2022 00:21:12 -0500
Message-Id: <4b2c7e6e5f3a9837939e99293c77e0e6fc3ae4f9.1663046060.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663046060.git.remckee0@gmail.com>
References: <cover.1663046060.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for memblock_alloc_try_nid() and memblock_alloc_try_nid_raw()
where the simulated physical memory is set up with multiple NUMA nodes.
Additionally, two of these tests set nid != NUMA_NO_NODE. All tests are
run for both top-down and bottom-up allocation directions.

The tested scenarios are:

Range unrestricted:
- region cannot be allocated:
      + none of the nodes have enough memory to allocate the region

Range restricted:
- region can be allocated in the specific node requested without dropping
  min_addr:
      + the range fully overlaps with the node, and there are adjacent
        reserved regions
- region cannot be allocated:
      + nid is set to NUMA_NO_NODE and the total range can fit the region,
        but the range is split between two nodes and everything else is
        reserved

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 197 +++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 7247fa145d7d..2c2d60f4e3e3 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -2316,6 +2316,173 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
 	return 0;
 }
 
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
+static int alloc_try_nid_numa_large_region_generic_check(void)
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
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
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
+static int alloc_try_nid_numa_reserved_full_merge_generic_check(void)
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
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr, nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
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
+static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
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
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   min_addr, max_addr,
+						   NUMA_NO_NODE);
+
+	ASSERT_EQ(allocated_ptr, NULL);
+
+	test_pass_pop();
+
+	return 0;
+}
+
 /* Test case wrappers for NUMA tests */
 static int alloc_try_nid_numa_simple_check(void)
 {
@@ -2427,6 +2594,33 @@ static int alloc_try_nid_numa_no_overlap_high_check(void)
 	return 0;
 }
 
+static int alloc_try_nid_numa_large_region_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_try_nid_numa_large_region_generic_check);
+	run_bottom_up(alloc_try_nid_numa_large_region_generic_check);
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_reserved_full_merge_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_try_nid_numa_reserved_full_merge_generic_check);
+	run_bottom_up(alloc_try_nid_numa_reserved_full_merge_generic_check);
+
+	return 0;
+}
+
+static int alloc_try_nid_numa_split_all_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_try_nid_numa_split_all_reserved_generic_check);
+	run_bottom_up(alloc_try_nid_numa_split_all_reserved_generic_check);
+
+	return 0;
+}
+
 int __memblock_alloc_nid_numa_checks(void)
 {
 	test_print("Running %s NUMA tests...\n",
@@ -2443,6 +2637,9 @@ int __memblock_alloc_nid_numa_checks(void)
 	alloc_try_nid_numa_no_overlap_split_check();
 	alloc_try_nid_numa_no_overlap_low_check();
 	alloc_try_nid_numa_no_overlap_high_check();
+	alloc_try_nid_numa_large_region_check();
+	alloc_try_nid_numa_reserved_full_merge_check();
+	alloc_try_nid_numa_split_all_reserved_check();
 
 	return 0;
 }
-- 
2.25.1

