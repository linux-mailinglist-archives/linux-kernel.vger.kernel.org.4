Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445855E962E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIYV1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiIYV1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:27:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76829CBF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:17 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y2so3120277qtv.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B03Bi+65NaX8/Pr/N9BYK3Eqgzig4DJIQAoxxtHUJhE=;
        b=XMPYRrXeS6D3B/rxaVJ+fpet9OJithcON1sBk1cZjI6V40OJCsfkoYp6A+VLxKlB5w
         0JzxOAXzLAJo3itPL3Qj5221mlDoKFewPviX/BIiRDzodv8E6FG88vGRl2ANuYe9tdxH
         IbhdsfPkjjM6WAWHuaNGcumz0tL4AnE2tawlclkPLPnTmh1+pw+8o0KDKisZe92ZYQ77
         TmONO6JMZ8i1n/daN7vm9tppNDdCKhuKB3+DUCmBhO/wOA645OtphIr35KMxdnVT4BZR
         LccaM2S/yVqnvSZGBhNKK6GS3sPJpy/2h1AKNM1wziBYFjZ0ZojVB1+LdyEQseIUwVrS
         XZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B03Bi+65NaX8/Pr/N9BYK3Eqgzig4DJIQAoxxtHUJhE=;
        b=WlCF0xelTZJAelDG8ZjXjYOVTFcKl3wRIW/7aimhHkib54xicQaUorcrU/Yg8Ft2Mv
         lg3hPOLxlYSJv3Bn0bfMXLTKGwWLSh+wxQVI+3jzGQWkDlRfY+5v1cuWe34Iqn+13jsh
         NaWknkFx7TsZZF+JVZLfLEF9wi+CMEsqcTXLHIi7fAgrQ2oWLMIjBUp6Cn6uWC5Yq4zH
         F7fbqmtGkiT1hip0oc445Zkj4GMNzQEpy40cUMPyK2s4MlOkHTwzLNqUlJ4lZNJeGoq/
         cZ2az3JX8ohKvfUTWRZ89GwtUf0AWu4OCRi8Id9sLYLAuVX5CD32u1BNt5Ak9MeJ6NFn
         UVJA==
X-Gm-Message-State: ACrzQf3yUvHimbX/j0fb930/Ulcri2KoUgr77ct/X3k0sFbJqyidH2rJ
        SLfenqCirdoZ2cbDsrk5xenYbOc4DQs=
X-Google-Smtp-Source: AMsMyM5QwlaiO/nzu9+0/lg8eJxFrgOnSD8+lZ8HGTRDvvriu4YXG4BhQ3IrEeMaDfL9ttywDWATkg==
X-Received: by 2002:a05:622a:20e:b0:35d:430:dd75 with SMTP id b14-20020a05622a020e00b0035d0430dd75mr15716720qtx.492.1664141236666;
        Sun, 25 Sep 2022 14:27:16 -0700 (PDT)
Received: from sophie ([185.156.46.189])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a414c00b006ce1bfbd603sm4842065qko.124.2022.09.25.14.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 14:27:16 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/5] memblock tests: add range tests for memblock_alloc_exact_nid_raw
Date:   Sun, 25 Sep 2022 16:26:52 -0500
Message-Id: <c73a6fd7fc3fa4529a6e444b9602d9c63ded91fd.1664138928.git.remckee0@gmail.com>
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

