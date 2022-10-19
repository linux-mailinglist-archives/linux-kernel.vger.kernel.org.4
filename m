Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45353604FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJSSfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJSSfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:35:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C2015ECFC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d13so11310209qko.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX7XgBBhC8k/Fiy0Z1EoKyTVV23oJRpPtTW7UWiIlgk=;
        b=KordIFXGcwl8SE7OE+1/6nnJ+rgrVuFdllmtv29wJwKOPsNKeH2J4/ZDj38CYFHGMN
         CF4KyhOHA9nz/iX4L10FHzO89+es9b2eA39Z2+IYcAyWY4Xz49nn3kBxCzD5DKj2mO8o
         Wcqf0h2VklZFWNcnkrpLfLFBT5ojYupEr/Z6+iORF7UJ1JjzY0qugJEErPlpaomizw5l
         SUBVGiP0AG/zWM3gkSMLPuAhoSX6xrumH02js/WLYaiVhzQkIEkdyeVQk6yr7n7uCbQa
         oZZhXd5g5Oi9BErovpwGO3SNmcU4Z0Mn1bPRNCgdXYRkqWgV/m+7b8hVMAM8lqqCAIbj
         fZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VX7XgBBhC8k/Fiy0Z1EoKyTVV23oJRpPtTW7UWiIlgk=;
        b=nSGQqtHIG5CpXXG+gf4IwxdsBkLbQ69vvuTPIT7EH0mVCAmEpRYmzDvUs8FZZ64G49
         +eJg1c3desNVfGp0jQ3Kyb9Iev5nZN7hr8q4walTHJIWDun1BlJwjmitOm2B+v05WBFq
         JRbxKBc1tyQb0X1OYISvump0j9Mqw8MKsUdVwfFnUZWBHZ8HFwJDUSZhF9DgafJSZ8ZT
         sGFiB+8kX9DYfuES7b9opcyCgVynRTy4wL+ILupFAndEX78RCTR5JUJd2ule48g5+7fC
         LMajIJDj6btle2k07TVD+y+s+3ZoTj080cWqTDTOHAwUBqCrkbJc9kTgrwwy6/XxPQys
         Zcqw==
X-Gm-Message-State: ACrzQf0BIA3FFM3Skwrk/qupX0tKfcKXpI2xyQ4EZ/YVzWhmc7KyP6gS
        6Y66rSkp/MB6tvKBoc4NXO4=
X-Google-Smtp-Source: AMsMyM4Z25dcuyx3XJzBgCWMPzBOQquyr6yqVFhZ9ctMXsAnxXg/T74M8/tyvgYv5RhnIEABfI0OSQ==
X-Received: by 2002:a05:620a:1911:b0:6ee:d2eb:2ef9 with SMTP id bj17-20020a05620a191100b006eed2eb2ef9mr6354153qkb.202.1666204509637;
        Wed, 19 Oct 2022 11:35:09 -0700 (PDT)
Received: from sophie ([143.244.47.100])
        by smtp.gmail.com with ESMTPSA id cn15-20020a05622a248f00b0034305a91aaesm4345788qtb.83.2022.10.19.11.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:35:09 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 3/5] memblock tests: add bottom-up NUMA tests for memblock_alloc_exact_nid_raw
Date:   Wed, 19 Oct 2022 13:34:10 -0500
Message-Id: <3ff61f3f8ae28082e5d28e469040216e707e6690.1666203643.git.remckee0@gmail.com>
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
tests set nid != NUMA_NO_NODE. These tests are run with a bottom-up
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
 .../memblock/tests/alloc_exact_nid_api.c      | 282 ++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_exact_nid_api.c b/tools/testing/memblock/tests/alloc_exact_nid_api.c
index 79150784b373..b97b5c04de05 100644
--- a/tools/testing/memblock/tests/alloc_exact_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.c
@@ -288,12 +288,286 @@ static int alloc_exact_nid_top_down_numa_no_overlap_low_check(void)
 	return 0;
 }
 
+/*
+ * A test that tries to allocate a memory region in a specific NUMA node that
+ * has enough memory to allocate a region of the requested size.
+ * Expect to allocate an aligned region at the beginning of the requested node.
+ */
+static int alloc_exact_nid_bottom_up_numa_simple_check(void)
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
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(req_node));
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
+ *  |           +---------------------------------------+         |
+ *  |           |               requested               |         |
+ *  +-----------+---------------------------------------+---------+
+ *
+ *  |           +------------------+-----+                        |
+ *  |           |     reserved     | new |                        |
+ *  +-----------+------------------+-----+------------------------+
+ *
+ * Expect to allocate an aligned region in the requested node that merges with
+ * the existing reserved region. The total size gets updated.
+ */
+static int alloc_exact_nid_bottom_up_numa_part_reserved_check(void)
+{
+	int nid_req = 4;
+	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+	void *allocated_ptr = NULL;
+	struct region r1;
+	phys_addr_t size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t total_size;
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
+	total_size = size + r1.size;
+
+	memblock_reserve(r1.base, r1.size);
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(new_rgn->size, total_size);
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(req_node));
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
+ *  |           +-----------+                                      |
+ *  |           |    rgn    |                                      |
+ *  +-----------+-----------+--------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a memory region at the beginning
+ * of the requested node.
+ */
+static int alloc_exact_nid_bottom_up_numa_split_range_low_check(void)
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
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), req_node_end);
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
+ *                                          min_addr
+ *                                         |         max_addr
+ *                                         |         |
+ *                                         v         v
+ *  |    +---------------+        +-------------+---------+         |
+ *  |    |   requested   |        |    node1    |  node2  |         |
+ *  +----+---------------+--------+-------------+---------+---------+
+ *                                         +         +
+ *  |    +---------+                                                |
+ *  |    |   rgn   |                                                |
+ *  +----+---------+------------------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a memory region that starts at
+ * the beginning of the requested node.
+ */
+static int alloc_exact_nid_bottom_up_numa_no_overlap_split_check(void)
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
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(req_node));
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
+ *  |-----+                                                          |
+ *  | rgn |                                                          |
+ *  +-----+----------------------------------------------------------+
+ *
+ * Expect to drop the lower limit and allocate a memory region that starts at
+ * the beginning of the requested node.
+ */
+static int alloc_exact_nid_bottom_up_numa_no_overlap_low_check(void)
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
+	ASSERT_EQ(new_rgn->base, req_node->base);
+	ASSERT_LE(region_end(new_rgn), region_end(req_node));
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
 /* Test case wrappers for NUMA tests */
 static int alloc_exact_nid_numa_simple_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_exact_nid_top_down_numa_simple_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_numa_simple_check();
 
 	return 0;
 }
@@ -303,6 +577,8 @@ static int alloc_exact_nid_numa_part_reserved_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_exact_nid_top_down_numa_part_reserved_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_numa_part_reserved_check();
 
 	return 0;
 }
@@ -312,6 +588,8 @@ static int alloc_exact_nid_numa_split_range_low_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_exact_nid_top_down_numa_split_range_low_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_numa_split_range_low_check();
 
 	return 0;
 }
@@ -321,6 +599,8 @@ static int alloc_exact_nid_numa_no_overlap_split_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_exact_nid_top_down_numa_no_overlap_split_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_numa_no_overlap_split_check();
 
 	return 0;
 }
@@ -330,6 +610,8 @@ static int alloc_exact_nid_numa_no_overlap_low_check(void)
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
 	alloc_exact_nid_top_down_numa_no_overlap_low_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_numa_no_overlap_low_check();
 
 	return 0;
 }
-- 
2.25.1

