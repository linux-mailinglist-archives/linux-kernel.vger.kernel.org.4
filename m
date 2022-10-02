Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB695F273B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJBXmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJBXmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:42:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC632A9D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 16:41:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j71so2251824pge.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B03Bi+65NaX8/Pr/N9BYK3Eqgzig4DJIQAoxxtHUJhE=;
        b=MzeeeoAjel/z3fSRxYPQJB1XN6ym6wzEDPQA36mh4xIYU42UJi/thQrY93CpGwEkIb
         SckgHMqnhZtW5X+rVD2JRQ28EXZVle+PI8q7oQWoPkP8cbO8kPf15lXHA2nFuY3GV4aE
         FjxF3R7T4wu8z7HjxEgBl1fKn8Z4dxX7ft31zFc+RGV6dm+e6PNv65tnLqCycq4JtAZK
         LLqVxX3i1vq4YKrdR0q2XhT19TM5m2O24c1DYQLSRE1W6WeqBL2z0AG0sK/Gm+X9qFxp
         wwENxfF74r+l/pOGf+5z8ZuI6FwPBCSSL/G/QZvFbNeTxvRU5x2NjcXz/JbwFrWp763n
         zhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B03Bi+65NaX8/Pr/N9BYK3Eqgzig4DJIQAoxxtHUJhE=;
        b=0Hp5oZ/Ph3YwjdX2hAnEoiBXS3f9cDTa8wHG5MgCf8tJnbwuMh5/yrM9Z9T1FcgS7l
         YwP3xXrr4pfUkGtXsTUKeI0fXQnvaFLR2STLhjpQynEdostliXygiKKZyCG5VSbDW02t
         9NoNWB+jg0BScyGOTT7/Yj4aneL60qgSJT27P3EWgTf5eDhfuC6dJMvRsMIpHE3OV+ML
         +o9wLCb1kzbLjNlxF0MK5YO1KrIVHieyf8rL9AGAHHdlln1ZXjM4l60H0hah6FeXsWlV
         KfjkoQtOKujEqrdpySKt/oGWZjHCBs9My76I24KWYhA6N2shBi2DaHeqZeEyVLGPrz+z
         wI1g==
X-Gm-Message-State: ACrzQf3FEab2VnHbvQK/ClkPkomMu12vAo7xDd0ZLA9hw1kO5iO190B9
        AB/w9gS+byeAYS90kfjzcfY=
X-Google-Smtp-Source: AMsMyM5yTi1+nTF5kec8wD3wo9roWUWWlcMjNQwFlJphUlzkrfHq0+BJGK+MbAL1NmoRke7VYwwMIw==
X-Received: by 2002:a63:e709:0:b0:438:98e8:d1c with SMTP id b9-20020a63e709000000b0043898e80d1cmr16739764pgi.403.1664754118938;
        Sun, 02 Oct 2022 16:41:58 -0700 (PDT)
Received: from sophie ([89.46.114.181])
        by smtp.gmail.com with ESMTPSA id 186-20020a6219c3000000b0056082e13cacsm2332066pfz.138.2022.10.02.16.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 16:41:58 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 1/5] memblock tests: add range tests for memblock_alloc_exact_nid_raw
Date:   Sun,  2 Oct 2022 18:41:34 -0500
Message-Id: <c73a6fd7fc3fa4529a6e444b9602d9c63ded91fd.1664753534.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664753534.git.remckee0@gmail.com>
References: <cover.1664753534.git.remckee0@gmail.com>
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

Add tests for memblock_alloc_exact_nid_raw() that are very similar to
the range tests for memblock_alloc_try_nid_raw().

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/Makefile               |    2 +-
 tools/testing/memblock/main.c                 |    2 +
 .../memblock/tests/alloc_exact_nid_api.c      | 1208 +++++++++++++++++
 .../memblock/tests/alloc_exact_nid_api.h      |    9 +
 4 files changed, 1220 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h

diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index 246f7ac8489b..2310ac4d080e 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -7,7 +7,7 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 TARGETS = main
 TEST_OFILES = tests/alloc_nid_api.o tests/alloc_helpers_api.o tests/alloc_api.o \
-		  tests/basic_api.o tests/common.o
+		  tests/basic_api.o tests/common.o tests/alloc_exact_nid_api.o
 DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
 OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
 EXTR_SRC = ../../../mm/memblock.c
diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
index 4ca1024342b1..278f9dec5008 100644
--- a/tools/testing/memblock/main.c
+++ b/tools/testing/memblock/main.c
@@ -3,6 +3,7 @@
 #include "tests/alloc_api.h"
 #include "tests/alloc_helpers_api.h"
 #include "tests/alloc_nid_api.h"
+#include "tests/alloc_exact_nid_api.h"
 #include "tests/common.h"
 
 int main(int argc, char **argv)
@@ -12,6 +13,7 @@ int main(int argc, char **argv)
 	memblock_alloc_checks();
 	memblock_alloc_helpers_checks();
 	memblock_alloc_nid_checks();
+	memblock_alloc_exact_nid_checks();
 
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_exact_nid_api.c b/tools/testing/memblock/tests/alloc_exact_nid_api.c
new file mode 100644
index 000000000000..452aba1f19db
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.c
@@ -0,0 +1,1208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "alloc_exact_nid_api.h"
+
+#define FUNC_NAME			"memblock_alloc_exact_nid_raw"
+
+/*
+ * A simple test that tries to allocate a memory region within min_addr and
+ * max_addr range:
+ *
+ *        +                   +
+ *   |    +       +-----------+      |
+ *   |    |       |    rgn    |      |
+ *   +----+-------+-----------+------+
+ *        ^                   ^
+ *        |                   |
+ *        min_addr           max_addr
+ *
+ * Expect to allocate a region that ends at max_addr.
+ */
+static int alloc_exact_nid_top_down_simple_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_128;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t rgn_end;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
+	max_addr = min_addr + SZ_512;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+	rgn_end = rgn->base + rgn->size;
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size);
+	ASSERT_EQ(rgn_end, max_addr);
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
+ * A simple test that tries to allocate a memory region within min_addr and
+ * max_addr range, where the end address is misaligned:
+ *
+ *         +       +            +
+ *  |      +       +---------+  +    |
+ *  |      |       |   rgn   |  |    |
+ *  +------+-------+---------+--+----+
+ *         ^       ^            ^
+ *         |       |            |
+ *       min_add   |            max_addr
+ *                 |
+ *                 Aligned address
+ *                 boundary
+ *
+ * Expect to allocate an aligned region that ends before max_addr.
+ */
+static int alloc_exact_nid_top_down_end_misaligned_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_128;
+	phys_addr_t misalign = SZ_2;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t rgn_end;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
+	max_addr = min_addr + SZ_512 + misalign;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+	rgn_end = rgn->base + rgn->size;
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size - misalign);
+	ASSERT_LT(rgn_end, max_addr);
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
+ * A simple test that tries to allocate a memory region, which spans over the
+ * min_addr and max_addr range:
+ *
+ *         +               +
+ *  |      +---------------+       |
+ *  |      |      rgn      |       |
+ *  +------+---------------+-------+
+ *         ^               ^
+ *         |               |
+ *         min_addr        max_addr
+ *
+ * Expect to allocate a region that starts at min_addr and ends at
+ * max_addr, given that min_addr is aligned.
+ */
+static int alloc_exact_nid_exact_address_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_1K;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t rgn_end;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
+	max_addr = min_addr + size;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+	rgn_end = rgn->base + rgn->size;
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
+	ASSERT_EQ(rgn_end, max_addr);
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
+ * A test that tries to allocate a memory region, which can't fit into
+ * min_addr and max_addr range:
+ *
+ *           +          +     +
+ *  |        +----------+-----+    |
+ *  |        |   rgn    +     |    |
+ *  +--------+----------+-----+----+
+ *           ^          ^     ^
+ *           |          |     |
+ *           Aligned    |    max_addr
+ *           address    |
+ *           boundary   min_add
+ *
+ * Expect to drop the lower limit and allocate a memory region which
+ * ends at max_addr (if the address is aligned).
+ */
+static int alloc_exact_nid_top_down_narrow_range_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_256;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SZ_512;
+	max_addr = min_addr + SMP_CACHE_BYTES;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, max_addr - size);
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
+ * A test that tries to allocate a memory region, which can't fit into
+ * min_addr and max_addr range, with the latter being too close to the beginning
+ * of the available memory:
+ *
+ *   +-------------+
+ *   |     new     |
+ *   +-------------+
+ *         +       +
+ *         |       +              |
+ *         |       |              |
+ *         +-------+--------------+
+ *         ^       ^
+ *         |       |
+ *         |       max_addr
+ *         |
+ *         min_addr
+ *
+ * Expect no allocation to happen.
+ */
+static int alloc_exact_nid_low_max_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_1K;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = min_addr + SMP_CACHE_BYTES;
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
+/*
+ * A test that tries to allocate a memory region within min_addr min_addr range,
+ * with min_addr being so close that it's next to an allocated region:
+ *
+ *          +                        +
+ *  |       +--------+---------------|
+ *  |       |   r1   |      rgn      |
+ *  +-------+--------+---------------+
+ *          ^                        ^
+ *          |                        |
+ *          min_addr                 max_addr
+ *
+ * Expect a merge of both regions. Only the region size gets updated.
+ */
+static int alloc_exact_nid_min_reserved_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t r1_size = SZ_128;
+	phys_addr_t r2_size = SZ_64;
+	phys_addr_t total_size = r1_size + r2_size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t reserved_base;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	max_addr = memblock_end_of_DRAM();
+	min_addr = max_addr - r2_size;
+	reserved_base = min_addr - r1_size;
+
+	memblock_reserve(reserved_base, r1_size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(r2_size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, r2_size);
+
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, reserved_base);
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
+ * A test that tries to allocate a memory region within min_addr and max_addr,
+ * with max_addr being so close that it's next to an allocated region:
+ *
+ *             +             +
+ *  |          +-------------+--------|
+ *  |          |     rgn     |   r1   |
+ *  +----------+-------------+--------+
+ *             ^             ^
+ *             |             |
+ *             min_addr      max_addr
+ *
+ * Expect a merge of regions. Only the region size gets updated.
+ */
+static int alloc_exact_nid_max_reserved_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t r1_size = SZ_64;
+	phys_addr_t r2_size = SZ_128;
+	phys_addr_t total_size = r1_size + r2_size;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	max_addr = memblock_end_of_DRAM() - r1_size;
+	min_addr = max_addr - r2_size;
+
+	memblock_reserve(max_addr, r1_size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(r2_size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, r2_size);
+
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, min_addr);
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
+ * A test that tries to allocate memory within min_addr and max_add range, when
+ * there are two reserved regions at the borders, with a gap big enough to fit
+ * a new region:
+ *
+ *                +           +
+ *  |    +--------+   +-------+------+  |
+ *  |    |   r2   |   |  rgn  |  r1  |  |
+ *  +----+--------+---+-------+------+--+
+ *                ^           ^
+ *                |           |
+ *                min_addr    max_addr
+ *
+ * Expect to merge the new region with r1. The second region does not get
+ * updated. The total size field gets updated.
+ */
+
+static int alloc_exact_nid_top_down_reserved_with_space_check(void)
+{
+	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+	phys_addr_t r3_size = SZ_64;
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (r3_size + gap_size + r2.size);
+
+	total_size = r1.size + r2.size + r3_size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(r3_size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, r3_size);
+
+	ASSERT_EQ(rgn1->size, r1.size + r3_size);
+	ASSERT_EQ(rgn1->base, max_addr - r3_size);
+
+	ASSERT_EQ(rgn2->size, r2.size);
+	ASSERT_EQ(rgn2->base, r2.base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range, when
+ * there are two reserved regions at the borders, with a gap of a size equal to
+ * the size of the new region:
+ *
+ *                 +        +
+ *  |     +--------+--------+--------+     |
+ *  |     |   r2   |   r3   |   r1   |     |
+ *  +-----+--------+--------+--------+-----+
+ *                 ^        ^
+ *                 |        |
+ *                 min_addr max_addr
+ *
+ * Expect to merge all of the regions into one. The region counter and total
+ * size fields get updated.
+ */
+static int alloc_exact_nid_reserved_full_merge_generic_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+	phys_addr_t r3_size = SZ_64;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (r3_size + r2.size);
+
+	total_size = r1.size + r2.size + r3_size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(r3_size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, r3_size);
+
+	ASSERT_EQ(rgn->size, total_size);
+	ASSERT_EQ(rgn->base, r2.base);
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
+ * A test that tries to allocate memory within min_addr and max_add range, when
+ * there are two reserved regions at the borders, with a gap that can't fit
+ * a new region:
+ *
+ *                       +    +
+ *  |  +----------+------+    +------+   |
+ *  |  |    r3    |  r2  |    |  r1  |   |
+ *  +--+----------+------+----+------+---+
+ *                       ^    ^
+ *                       |    |
+ *                       |    max_addr
+ *                       |
+ *                       min_addr
+ *
+ * Expect to merge the new region with r2. The second region does not get
+ * updated. The total size counter gets updated.
+ */
+static int alloc_exact_nid_top_down_reserved_no_space_check(void)
+{
+	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+	phys_addr_t r3_size = SZ_256;
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (r2.size + gap_size);
+
+	total_size = r1.size + r2.size + r3_size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(r3_size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, r3_size);
+
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
+
+	ASSERT_EQ(rgn2->size, r2.size + r3_size);
+	ASSERT_EQ(rgn2->base, r2.base - r3_size);
+
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range, but
+ * it's too narrow and everything else is reserved:
+ *
+ *            +-----------+
+ *            |    new    |
+ *            +-----------+
+ *                 +      +
+ *  |--------------+      +----------|
+ *  |      r2      |      |    r1    |
+ *  +--------------+------+----------+
+ *                 ^      ^
+ *                 |      |
+ *                 |      max_addr
+ *                 |
+ *                 min_addr
+ *
+ * Expect no allocation to happen.
+ */
+
+static int alloc_exact_nid_reserved_all_generic_check(void)
+{
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+	phys_addr_t r3_size = SZ_256;
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = MEM_SIZE - (r1.size + gap_size);
+	r2.base = memblock_start_of_DRAM();
+
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(r3_size, SMP_CACHE_BYTES,
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
+/*
+ * A test that tries to allocate a memory region, where max_addr is
+ * bigger than the end address of the available memory. Expect to allocate
+ * a region that ends before the end of the memory.
+ */
+static int alloc_exact_nid_top_down_cap_max_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_256;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_end_of_DRAM() - SZ_1K;
+	max_addr = memblock_end_of_DRAM() + SZ_256;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
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
+ * A test that tries to allocate a memory region, where min_addr is
+ * smaller than the start address of the available memory. Expect to allocate
+ * a region that ends before the end of the memory.
+ */
+static int alloc_exact_nid_top_down_cap_min_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_1K;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() - SZ_256;
+	max_addr = memblock_end_of_DRAM();
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
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
+ * A simple test that tries to allocate a memory region within min_addr and
+ * max_addr range:
+ *
+ *        +                       +
+ *   |    +-----------+           |      |
+ *   |    |    rgn    |           |      |
+ *   +----+-----------+-----------+------+
+ *        ^                       ^
+ *        |                       |
+ *        min_addr                max_addr
+ *
+ * Expect to allocate a region that ends before max_addr.
+ */
+static int alloc_exact_nid_bottom_up_simple_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_128;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t rgn_end;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
+	max_addr = min_addr + SZ_512;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+	rgn_end = rgn->base + rgn->size;
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
+	ASSERT_LT(rgn_end, max_addr);
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
+ * A simple test that tries to allocate a memory region within min_addr and
+ * max_addr range, where the start address is misaligned:
+ *
+ *        +                     +
+ *  |     +   +-----------+     +     |
+ *  |     |   |    rgn    |     |     |
+ *  +-----+---+-----------+-----+-----+
+ *        ^   ^----.            ^
+ *        |        |            |
+ *     min_add     |            max_addr
+ *                 |
+ *                 Aligned address
+ *                 boundary
+ *
+ * Expect to allocate an aligned region that ends before max_addr.
+ */
+static int alloc_exact_nid_bottom_up_start_misaligned_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_128;
+	phys_addr_t misalign = SZ_2;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+	phys_addr_t rgn_end;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + misalign;
+	max_addr = min_addr + SZ_512;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+	rgn_end = rgn->base + rgn->size;
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
+	ASSERT_LT(rgn_end, max_addr);
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
+ * A test that tries to allocate a memory region, which can't fit into min_addr
+ * and max_addr range:
+ *
+ *                      +    +
+ *  |---------+         +    +      |
+ *  |   rgn   |         |    |      |
+ *  +---------+---------+----+------+
+ *                      ^    ^
+ *                      |    |
+ *                      |    max_addr
+ *                      |
+ *                      min_add
+ *
+ * Expect to drop the lower limit and allocate a memory region which
+ * starts at the beginning of the available memory.
+ */
+static int alloc_exact_nid_bottom_up_narrow_range_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_256;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SZ_512;
+	max_addr = min_addr + SMP_CACHE_BYTES;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
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
+ * A test that tries to allocate memory within min_addr and max_add range, when
+ * there are two reserved regions at the borders, with a gap big enough to fit
+ * a new region:
+ *
+ *                +           +
+ *  |    +--------+-------+   +------+  |
+ *  |    |   r2   |  rgn  |   |  r1  |  |
+ *  +----+--------+-------+---+------+--+
+ *                ^           ^
+ *                |           |
+ *                min_addr    max_addr
+ *
+ * Expect to merge the new region with r2. The second region does not get
+ * updated. The total size field gets updated.
+ */
+
+static int alloc_exact_nid_bottom_up_reserved_with_space_check(void)
+{
+	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+	phys_addr_t r3_size = SZ_64;
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (r3_size + gap_size + r2.size);
+
+	total_size = r1.size + r2.size + r3_size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(r3_size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, r3_size);
+
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, max_addr);
+
+	ASSERT_EQ(rgn2->size, r2.size + r3_size);
+	ASSERT_EQ(rgn2->base, r2.base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 2);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate memory within min_addr and max_add range, when
+ * there are two reserved regions at the borders, with a gap of a size equal to
+ * the size of the new region:
+ *
+ *                         +   +
+ *  |----------+    +------+   +----+  |
+ *  |    r3    |    |  r2  |   | r1 |  |
+ *  +----------+----+------+---+----+--+
+ *                         ^   ^
+ *                         |   |
+ *                         |  max_addr
+ *                         |
+ *                         min_addr
+ *
+ * Expect to drop the lower limit and allocate memory at the beginning of the
+ * available memory. The region counter and total size fields get updated.
+ * Other regions are not modified.
+ */
+
+static int alloc_exact_nid_bottom_up_reserved_no_space_check(void)
+{
+	struct memblock_region *rgn1 = &memblock.reserved.regions[2];
+	struct memblock_region *rgn2 = &memblock.reserved.regions[1];
+	struct memblock_region *rgn3 = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	struct region r1, r2;
+	phys_addr_t r3_size = SZ_256;
+	phys_addr_t gap_size = SMP_CACHE_BYTES;
+	phys_addr_t total_size;
+	phys_addr_t max_addr;
+	phys_addr_t min_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	r1.base = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
+	r1.size = SMP_CACHE_BYTES;
+
+	r2.size = SZ_128;
+	r2.base = r1.base - (r2.size + gap_size);
+
+	total_size = r1.size + r2.size + r3_size;
+	min_addr = r2.base + r2.size;
+	max_addr = r1.base;
+
+	memblock_reserve(r1.base, r1.size);
+	memblock_reserve(r2.base, r2.size);
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(r3_size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, r3_size);
+
+	ASSERT_EQ(rgn3->size, r3_size);
+	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
+
+	ASSERT_EQ(rgn2->size, r2.size);
+	ASSERT_EQ(rgn2->base, r2.base);
+
+	ASSERT_EQ(rgn1->size, r1.size);
+	ASSERT_EQ(rgn1->base, r1.base);
+
+	ASSERT_EQ(memblock.reserved.cnt, 3);
+	ASSERT_EQ(memblock.reserved.total_size, total_size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/*
+ * A test that tries to allocate a memory region, where max_addr is
+ * bigger than the end address of the available memory. Expect to allocate
+ * a region that starts at the min_addr.
+ */
+static int alloc_exact_nid_bottom_up_cap_max_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_256;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM() + SZ_1K;
+	max_addr = memblock_end_of_DRAM() + SZ_256;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, min_addr);
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
+ * A test that tries to allocate a memory region, where min_addr is
+ * smaller than the start address of the available memory. Expect to allocate
+ * a region at the beginning of the available memory.
+ */
+static int alloc_exact_nid_bottom_up_cap_min_check(void)
+{
+	struct memblock_region *rgn = &memblock.reserved.regions[0];
+	void *allocated_ptr = NULL;
+	phys_addr_t size = SZ_1K;
+	phys_addr_t min_addr;
+	phys_addr_t max_addr;
+
+	PREFIX_PUSH();
+	setup_memblock();
+
+	min_addr = memblock_start_of_DRAM();
+	max_addr = memblock_end_of_DRAM() - SZ_256;
+
+	allocated_ptr = memblock_alloc_exact_nid_raw(size, SMP_CACHE_BYTES,
+						     min_addr, max_addr,
+						     NUMA_NO_NODE);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	ASSERT_MEM_NE(allocated_ptr, 0, size);
+
+	ASSERT_EQ(rgn->size, size);
+	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
+
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, size);
+
+	test_pass_pop();
+
+	return 0;
+}
+
+/* Test case wrappers for range tests */
+static int alloc_exact_nid_simple_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_simple_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_simple_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_misaligned_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_end_misaligned_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_start_misaligned_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_narrow_range_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_narrow_range_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_narrow_range_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_reserved_with_space_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_reserved_with_space_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_reserved_with_space_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_reserved_no_space_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_reserved_no_space_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_reserved_no_space_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_cap_max_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_cap_max_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_cap_max_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_cap_min_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	memblock_set_bottom_up(false);
+	alloc_exact_nid_top_down_cap_min_check();
+	memblock_set_bottom_up(true);
+	alloc_exact_nid_bottom_up_cap_min_check();
+
+	return 0;
+}
+
+static int alloc_exact_nid_min_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_min_reserved_generic_check);
+	run_bottom_up(alloc_exact_nid_min_reserved_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_max_reserved_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_max_reserved_generic_check);
+	run_bottom_up(alloc_exact_nid_max_reserved_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_exact_address_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_exact_address_generic_check);
+	run_bottom_up(alloc_exact_nid_exact_address_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_reserved_full_merge_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_reserved_full_merge_generic_check);
+	run_bottom_up(alloc_exact_nid_reserved_full_merge_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_reserved_all_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_reserved_all_generic_check);
+	run_bottom_up(alloc_exact_nid_reserved_all_generic_check);
+
+	return 0;
+}
+
+static int alloc_exact_nid_low_max_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	run_top_down(alloc_exact_nid_low_max_generic_check);
+	run_bottom_up(alloc_exact_nid_low_max_generic_check);
+
+	return 0;
+}
+
+static int memblock_alloc_exact_nid_range_checks(void)
+{
+	test_print("Running %s range tests...\n", FUNC_NAME);
+
+	alloc_exact_nid_simple_check();
+	alloc_exact_nid_misaligned_check();
+	alloc_exact_nid_narrow_range_check();
+	alloc_exact_nid_reserved_with_space_check();
+	alloc_exact_nid_reserved_no_space_check();
+	alloc_exact_nid_cap_max_check();
+	alloc_exact_nid_cap_min_check();
+
+	alloc_exact_nid_min_reserved_check();
+	alloc_exact_nid_max_reserved_check();
+	alloc_exact_nid_exact_address_check();
+	alloc_exact_nid_reserved_full_merge_check();
+	alloc_exact_nid_reserved_all_check();
+	alloc_exact_nid_low_max_check();
+
+	return 0;
+}
+
+int memblock_alloc_exact_nid_checks(void)
+{
+	prefix_reset();
+	prefix_push(FUNC_NAME);
+
+	reset_memblock_attributes();
+	dummy_physical_memory_init();
+
+	memblock_alloc_exact_nid_range_checks();
+
+	dummy_physical_memory_cleanup();
+
+	prefix_pop();
+
+	return 0;
+}
diff --git a/tools/testing/memblock/tests/alloc_exact_nid_api.h b/tools/testing/memblock/tests/alloc_exact_nid_api.h
new file mode 100644
index 000000000000..4408719de3b9
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _MEMBLOCK_ALLOC_EXACT_NID_H
+#define _MEMBLOCK_ALLOC_EXACT_NID_H
+
+#include "common.h"
+
+int memblock_alloc_exact_nid_checks(void);
+
+#endif
-- 
2.25.1

