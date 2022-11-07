Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86D61EAFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKGG2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiKGG23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:28:29 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8C3383
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:28:25 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso13628805pjc.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTSSKgG3Yp3aB8BYATFTlrpIDBxPxVeFy9k267yWkvQ=;
        b=A7lmvbiLx8z1BPP9MOFAbyckwHZlkJZfRj+HDDdTom9NxJdapKDMlz4L2hxLrAeVUD
         AJjtjT5AsvUF1Vn3KzG5XxoF+H8NEt45X7g0KlsCs4aJVc4GqJ114rEZXpfT8/tV8PKB
         mqMuFUu3eKGU1CNOZRoTajSbek4bMvysJYQywNOGQ4NPOJmvr1CFgco9BMSWs1cv9fzR
         x4xV0yBLKBeQCHe6aajfC25RAHQgf6hUpM08+8J39K3zkz95n/toQXsHJcDX4Dzfx7+i
         mOF0vICj41QE1SufFvdlm/u76ztWkergkB16klgooqicebO5qttOgF9DUUcAuetrBiTd
         NJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTSSKgG3Yp3aB8BYATFTlrpIDBxPxVeFy9k267yWkvQ=;
        b=IRUOyGAHmfGPwRkueurnC3NHKO/FRk49inMSdL018+hjXYAUMcWEJ5dtp/KVdkxTZ3
         mzpBrpcZptWIe1/2QSBy1l7oY0M6cWyQ1TXmNkFTci1M31M7EsFg6NKEDncZez/bPdZ+
         ZC472EUY42Kv3yPN8pfXUMN9l5r9McqUkp9PC37pC97aBXh6Q/GkYeOorZ5cJK2ldqNa
         KmTLz+bhvONE9HRwB2uqhtzmQEVimbi0l+nLrXmCnG+mJwRORMeRuB2JBzQBMZJy130R
         GCivG0iD6gZ+Ar4OxAtF0FREDshBpsSAULf14BFGkZT2klHmWskvo/IB3NVRJ015jZZY
         m7mA==
X-Gm-Message-State: ACrzQf2NWvEBo+NzamUCN/0NtKe3v5uOoTjnE7HaT3BSJ9xMqmjOIxJ1
        4WLlV0CBy5TIvOTYWarlOtl1QxKbKBU=
X-Google-Smtp-Source: AMsMyM5cZTQ9X3QYbb8rx2HcJYF5WZWdzoNzut/2M9ukHSk1DsLOagGa97GRshtjPveJJNrA0hLKrw==
X-Received: by 2002:a17:90b:3901:b0:213:dfd5:a75f with SMTP id ob1-20020a17090b390100b00213dfd5a75fmr41381124pjb.233.1667802504500;
        Sun, 06 Nov 2022 22:28:24 -0800 (PST)
Received: from sophie ([89.46.114.207])
        by smtp.gmail.com with ESMTPSA id oa1-20020a17090b1bc100b00212e8945d97sm5337082pjb.56.2022.11.06.22.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 22:28:24 -0800 (PST)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 1/5] memblock tests: introduce range tests for memblock_alloc_exact_nid_raw
Date:   Mon,  7 Nov 2022 00:28:05 -0600
Message-Id: <5a4b6d1b6130ab7375314e1c45a6d5813dfdabbd.1667802195.git.remckee0@gmail.com>
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

Add TEST_F_EXACT flag, which specifies that tests should run
memblock_alloc_exact_nid_raw(). Introduce range tests for
memblock_alloc_exact_nid_raw() by using the TEST_F_EXACT flag to run the
range tests in alloc_nid_api.c, since memblock_alloc_exact_nid_raw() and
memblock_alloc_try_nid_raw() behave the same way when nid = NUMA_NO_NODE.

Rename tests and other functions in alloc_nid_api.c by removing "_try".
Since the test names will be displayed in verbose output, they need to
be general enough to refer to any of the memblock functions that the
tests may run.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/Makefile               |   2 +-
 tools/testing/memblock/main.c                 |   2 +
 .../memblock/tests/alloc_exact_nid_api.c      |  22 +
 .../memblock/tests/alloc_exact_nid_api.h      |   9 +
 tools/testing/memblock/tests/alloc_nid_api.c  | 546 +++++++++---------
 tools/testing/memblock/tests/alloc_nid_api.h  |   1 +
 tools/testing/memblock/tests/common.h         |   2 +
 7 files changed, 320 insertions(+), 264 deletions(-)
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
index 000000000000..6406496623a0
--- /dev/null
+++ b/tools/testing/memblock/tests/alloc_exact_nid_api.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "alloc_exact_nid_api.h"
+#include "alloc_nid_api.h"
+
+#define FUNC_NAME			"memblock_alloc_exact_nid_raw"
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
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 2c2d60f4e3e3..49ef68cccd6f 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -18,18 +18,29 @@ static const unsigned int node_fractions[] = {
 	 625, /* 1/16 */
 };
 
-static inline const char * const get_memblock_alloc_try_nid_name(int flags)
+static inline const char * const get_memblock_alloc_nid_name(int flags)
 {
+	if (flags & TEST_F_EXACT)
+		return "memblock_alloc_exact_nid_raw";
 	if (flags & TEST_F_RAW)
 		return "memblock_alloc_try_nid_raw";
 	return "memblock_alloc_try_nid";
 }
 
-static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
-					       phys_addr_t align,
-					       phys_addr_t min_addr,
-					       phys_addr_t max_addr, int nid)
-{
+static inline void *run_memblock_alloc_nid(phys_addr_t size,
+					   phys_addr_t align,
+					   phys_addr_t min_addr,
+					   phys_addr_t max_addr, int nid)
+{
+	assert(!(alloc_nid_test_flags & TEST_F_EXACT) ||
+	       (alloc_nid_test_flags & TEST_F_RAW));
+	/*
+	 * TEST_F_EXACT should be checked before TEST_F_RAW since
+	 * memblock_alloc_exact_nid_raw() performs raw allocations.
+	 */
+	if (alloc_nid_test_flags & TEST_F_EXACT)
+		return memblock_alloc_exact_nid_raw(size, align, min_addr,
+						    max_addr, nid);
 	if (alloc_nid_test_flags & TEST_F_RAW)
 		return memblock_alloc_try_nid_raw(size, align, min_addr,
 						  max_addr, nid);
@@ -50,7 +61,7 @@ static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
  *
  * Expect to allocate a region that ends at max_addr.
  */
-static int alloc_try_nid_top_down_simple_check(void)
+static int alloc_nid_top_down_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -65,9 +76,9 @@ static int alloc_try_nid_top_down_simple_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
 	max_addr = min_addr + SZ_512;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
@@ -102,7 +113,7 @@ static int alloc_try_nid_top_down_simple_check(void)
  *
  * Expect to allocate an aligned region that ends before max_addr.
  */
-static int alloc_try_nid_top_down_end_misaligned_check(void)
+static int alloc_nid_top_down_end_misaligned_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -118,9 +129,9 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
 	max_addr = min_addr + SZ_512 + misalign;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
@@ -153,7 +164,7 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
  * Expect to allocate a region that starts at min_addr and ends at
  * max_addr, given that min_addr is aligned.
  */
-static int alloc_try_nid_exact_address_generic_check(void)
+static int alloc_nid_exact_address_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -168,9 +179,9 @@ static int alloc_try_nid_exact_address_generic_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
@@ -205,7 +216,7 @@ static int alloc_try_nid_exact_address_generic_check(void)
  * Expect to drop the lower limit and allocate a memory region which
  * ends at max_addr (if the address is aligned).
  */
-static int alloc_try_nid_top_down_narrow_range_check(void)
+static int alloc_nid_top_down_narrow_range_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -219,9 +230,9 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_512;
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -257,7 +268,7 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
  *
  * Expect no allocation to happen.
  */
-static int alloc_try_nid_low_max_generic_check(void)
+static int alloc_nid_low_max_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 	phys_addr_t size = SZ_1K;
@@ -270,9 +281,9 @@ static int alloc_try_nid_low_max_generic_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -295,7 +306,7 @@ static int alloc_try_nid_low_max_generic_check(void)
  *
  * Expect a merge of both regions. Only the region size gets updated.
  */
-static int alloc_try_nid_min_reserved_generic_check(void)
+static int alloc_nid_min_reserved_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -315,9 +326,9 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 
 	memblock_reserve(reserved_base, r1_size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r2_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r2_size, alloc_nid_test_flags);
@@ -347,7 +358,7 @@ static int alloc_try_nid_min_reserved_generic_check(void)
  *
  * Expect a merge of regions. Only the region size gets updated.
  */
-static int alloc_try_nid_max_reserved_generic_check(void)
+static int alloc_nid_max_reserved_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -365,9 +376,9 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 
 	memblock_reserve(max_addr, r1_size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r2_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r2_size, alloc_nid_test_flags);
@@ -400,7 +411,7 @@ static int alloc_try_nid_max_reserved_generic_check(void)
  * updated. The total size field gets updated.
  */
 
-static int alloc_try_nid_top_down_reserved_with_space_check(void)
+static int alloc_nid_top_down_reserved_with_space_check(void)
 {
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
@@ -428,9 +439,9 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
@@ -465,7 +476,7 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
  * Expect to merge all of the regions into one. The region counter and total
  * size fields get updated.
  */
-static int alloc_try_nid_reserved_full_merge_generic_check(void)
+static int alloc_nid_reserved_full_merge_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -491,9 +502,9 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
@@ -527,7 +538,7 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
  * Expect to merge the new region with r2. The second region does not get
  * updated. The total size counter gets updated.
  */
-static int alloc_try_nid_top_down_reserved_no_space_check(void)
+static int alloc_nid_top_down_reserved_no_space_check(void)
 {
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
@@ -555,9 +566,9 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
@@ -596,7 +607,7 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
  * Expect no allocation to happen.
  */
 
-static int alloc_try_nid_reserved_all_generic_check(void)
+static int alloc_nid_reserved_all_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
@@ -620,9 +631,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -636,7 +647,7 @@ static int alloc_try_nid_reserved_all_generic_check(void)
  * bigger than the end address of the available memory. Expect to allocate
  * a region that ends before the end of the memory.
  */
-static int alloc_try_nid_top_down_cap_max_check(void)
+static int alloc_nid_top_down_cap_max_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -650,9 +661,9 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 	min_addr = memblock_end_of_DRAM() - SZ_1K;
 	max_addr = memblock_end_of_DRAM() + SZ_256;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -673,7 +684,7 @@ static int alloc_try_nid_top_down_cap_max_check(void)
  * smaller than the start address of the available memory. Expect to allocate
  * a region that ends before the end of the memory.
  */
-static int alloc_try_nid_top_down_cap_min_check(void)
+static int alloc_nid_top_down_cap_min_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -687,9 +698,9 @@ static int alloc_try_nid_top_down_cap_min_check(void)
 	min_addr = memblock_start_of_DRAM() - SZ_256;
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -719,7 +730,7 @@ static int alloc_try_nid_top_down_cap_min_check(void)
  *
  * Expect to allocate a region that ends before max_addr.
  */
-static int alloc_try_nid_bottom_up_simple_check(void)
+static int alloc_nid_bottom_up_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -734,9 +745,9 @@ static int alloc_try_nid_bottom_up_simple_check(void)
 	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
 	max_addr = min_addr + SZ_512;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
@@ -771,7 +782,7 @@ static int alloc_try_nid_bottom_up_simple_check(void)
  *
  * Expect to allocate an aligned region that ends before max_addr.
  */
-static int alloc_try_nid_bottom_up_start_misaligned_check(void)
+static int alloc_nid_bottom_up_start_misaligned_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -787,9 +798,9 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 	min_addr = memblock_start_of_DRAM() + misalign;
 	max_addr = min_addr + SZ_512;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 	rgn_end = rgn->base + rgn->size;
 
 	ASSERT_NE(allocated_ptr, NULL);
@@ -824,7 +835,7 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
  * Expect to drop the lower limit and allocate a memory region which
  * starts at the beginning of the available memory.
  */
-static int alloc_try_nid_bottom_up_narrow_range_check(void)
+static int alloc_nid_bottom_up_narrow_range_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -838,9 +849,9 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_512;
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -873,7 +884,7 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
  * updated. The total size field gets updated.
  */
 
-static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
+static int alloc_nid_bottom_up_reserved_with_space_check(void)
 {
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
@@ -901,9 +912,9 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
@@ -942,7 +953,7 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
  * Other regions are not modified.
  */
 
-static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
+static int alloc_nid_bottom_up_reserved_no_space_check(void)
 {
 	struct memblock_region *rgn1 = &memblock.reserved.regions[2];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[1];
@@ -971,9 +982,9 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r3_size, alloc_nid_test_flags);
@@ -1000,7 +1011,7 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
  * bigger than the end address of the available memory. Expect to allocate
  * a region that starts at the min_addr.
  */
-static int alloc_try_nid_bottom_up_cap_max_check(void)
+static int alloc_nid_bottom_up_cap_max_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -1014,9 +1025,9 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 	min_addr = memblock_start_of_DRAM() + SZ_1K;
 	max_addr = memblock_end_of_DRAM() + SZ_256;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1037,7 +1048,7 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
  * smaller than the start address of the available memory. Expect to allocate
  * a region at the beginning of the available memory.
  */
-static int alloc_try_nid_bottom_up_cap_min_check(void)
+static int alloc_nid_bottom_up_cap_min_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -1051,9 +1062,9 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM() - SZ_256;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1070,133 +1081,133 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
 }
 
 /* Test case wrappers for range tests */
-static int alloc_try_nid_simple_check(void)
+static int alloc_nid_simple_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_simple_check();
+	alloc_nid_top_down_simple_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_simple_check();
+	alloc_nid_bottom_up_simple_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_misaligned_check(void)
+static int alloc_nid_misaligned_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_end_misaligned_check();
+	alloc_nid_top_down_end_misaligned_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_start_misaligned_check();
+	alloc_nid_bottom_up_start_misaligned_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_narrow_range_check(void)
+static int alloc_nid_narrow_range_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_narrow_range_check();
+	alloc_nid_top_down_narrow_range_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_narrow_range_check();
+	alloc_nid_bottom_up_narrow_range_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_reserved_with_space_check(void)
+static int alloc_nid_reserved_with_space_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_reserved_with_space_check();
+	alloc_nid_top_down_reserved_with_space_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_reserved_with_space_check();
+	alloc_nid_bottom_up_reserved_with_space_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_reserved_no_space_check(void)
+static int alloc_nid_reserved_no_space_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_reserved_no_space_check();
+	alloc_nid_top_down_reserved_no_space_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_reserved_no_space_check();
+	alloc_nid_bottom_up_reserved_no_space_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_cap_max_check(void)
+static int alloc_nid_cap_max_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_cap_max_check();
+	alloc_nid_top_down_cap_max_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_cap_max_check();
+	alloc_nid_bottom_up_cap_max_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_cap_min_check(void)
+static int alloc_nid_cap_min_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_cap_min_check();
+	alloc_nid_top_down_cap_min_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_cap_min_check();
+	alloc_nid_bottom_up_cap_min_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_min_reserved_check(void)
+static int alloc_nid_min_reserved_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_min_reserved_generic_check);
-	run_bottom_up(alloc_try_nid_min_reserved_generic_check);
+	run_top_down(alloc_nid_min_reserved_generic_check);
+	run_bottom_up(alloc_nid_min_reserved_generic_check);
 
 	return 0;
 }
 
-static int alloc_try_nid_max_reserved_check(void)
+static int alloc_nid_max_reserved_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_max_reserved_generic_check);
-	run_bottom_up(alloc_try_nid_max_reserved_generic_check);
+	run_top_down(alloc_nid_max_reserved_generic_check);
+	run_bottom_up(alloc_nid_max_reserved_generic_check);
 
 	return 0;
 }
 
-static int alloc_try_nid_exact_address_check(void)
+static int alloc_nid_exact_address_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_exact_address_generic_check);
-	run_bottom_up(alloc_try_nid_exact_address_generic_check);
+	run_top_down(alloc_nid_exact_address_generic_check);
+	run_bottom_up(alloc_nid_exact_address_generic_check);
 
 	return 0;
 }
 
-static int alloc_try_nid_reserved_full_merge_check(void)
+static int alloc_nid_reserved_full_merge_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_reserved_full_merge_generic_check);
-	run_bottom_up(alloc_try_nid_reserved_full_merge_generic_check);
+	run_top_down(alloc_nid_reserved_full_merge_generic_check);
+	run_bottom_up(alloc_nid_reserved_full_merge_generic_check);
 
 	return 0;
 }
 
-static int alloc_try_nid_reserved_all_check(void)
+static int alloc_nid_reserved_all_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_reserved_all_generic_check);
-	run_bottom_up(alloc_try_nid_reserved_all_generic_check);
+	run_top_down(alloc_nid_reserved_all_generic_check);
+	run_bottom_up(alloc_nid_reserved_all_generic_check);
 
 	return 0;
 }
 
-static int alloc_try_nid_low_max_check(void)
+static int alloc_nid_low_max_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_low_max_generic_check);
-	run_bottom_up(alloc_try_nid_low_max_generic_check);
+	run_top_down(alloc_nid_low_max_generic_check);
+	run_bottom_up(alloc_nid_low_max_generic_check);
 
 	return 0;
 }
@@ -1204,22 +1215,22 @@ static int alloc_try_nid_low_max_check(void)
 static int memblock_alloc_nid_range_checks(void)
 {
 	test_print("Running %s range tests...\n",
-		   get_memblock_alloc_try_nid_name(alloc_nid_test_flags));
+		   get_memblock_alloc_nid_name(alloc_nid_test_flags));
 
-	alloc_try_nid_simple_check();
-	alloc_try_nid_misaligned_check();
-	alloc_try_nid_narrow_range_check();
-	alloc_try_nid_reserved_with_space_check();
-	alloc_try_nid_reserved_no_space_check();
-	alloc_try_nid_cap_max_check();
-	alloc_try_nid_cap_min_check();
+	alloc_nid_simple_check();
+	alloc_nid_misaligned_check();
+	alloc_nid_narrow_range_check();
+	alloc_nid_reserved_with_space_check();
+	alloc_nid_reserved_no_space_check();
+	alloc_nid_cap_max_check();
+	alloc_nid_cap_min_check();
 
-	alloc_try_nid_min_reserved_check();
-	alloc_try_nid_max_reserved_check();
-	alloc_try_nid_exact_address_check();
-	alloc_try_nid_reserved_full_merge_check();
-	alloc_try_nid_reserved_all_check();
-	alloc_try_nid_low_max_check();
+	alloc_nid_min_reserved_check();
+	alloc_nid_max_reserved_check();
+	alloc_nid_exact_address_check();
+	alloc_nid_reserved_full_merge_check();
+	alloc_nid_reserved_all_check();
+	alloc_nid_low_max_check();
 
 	return 0;
 }
@@ -1229,7 +1240,7 @@ static int memblock_alloc_nid_range_checks(void)
  * has enough memory to allocate a region of the requested size.
  * Expect to allocate an aligned region at the end of the requested node.
  */
-static int alloc_try_nid_top_down_numa_simple_check(void)
+static int alloc_nid_top_down_numa_simple_check(void)
 {
 	int nid_req = 3;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1247,8 +1258,8 @@ static int alloc_try_nid_top_down_numa_simple_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1280,7 +1291,7 @@ static int alloc_try_nid_top_down_numa_simple_check(void)
  * Expect to allocate an aligned region at the end of the last node that has
  * enough memory (in this case, nid = 6) after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_top_down_numa_small_node_check(void)
+static int alloc_nid_top_down_numa_small_node_check(void)
 {
 	int nid_req = 1;
 	int nid_exp = 6;
@@ -1299,8 +1310,8 @@ static int alloc_try_nid_top_down_numa_small_node_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1333,7 +1344,7 @@ static int alloc_try_nid_top_down_numa_small_node_check(void)
  * large enough and has enough unreserved memory (in this case, nid = 6) after
  * falling back to NUMA_NO_NODE. The region count and total size get updated.
  */
-static int alloc_try_nid_top_down_numa_node_reserved_check(void)
+static int alloc_nid_top_down_numa_node_reserved_check(void)
 {
 	int nid_req = 2;
 	int nid_exp = 6;
@@ -1353,8 +1364,8 @@ static int alloc_try_nid_top_down_numa_node_reserved_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(req_node->base, req_node->size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1386,7 +1397,7 @@ static int alloc_try_nid_top_down_numa_node_reserved_check(void)
  * Expect to allocate an aligned region at the end of the requested node. The
  * region count and total size get updated.
  */
-static int alloc_try_nid_top_down_numa_part_reserved_check(void)
+static int alloc_nid_top_down_numa_part_reserved_check(void)
 {
 	int nid_req = 4;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[1];
@@ -1408,8 +1419,8 @@ static int alloc_try_nid_top_down_numa_part_reserved_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(r1.base, r1.size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1444,7 +1455,7 @@ static int alloc_try_nid_top_down_numa_part_reserved_check(void)
  * nid = NUMA_NODES - 1) after falling back to NUMA_NO_NODE. The region count
  * and total size get updated.
  */
-static int alloc_try_nid_top_down_numa_part_reserved_fallback_check(void)
+static int alloc_nid_top_down_numa_part_reserved_fallback_check(void)
 {
 	int nid_req = 4;
 	int nid_exp = NUMA_NODES - 1;
@@ -1469,8 +1480,8 @@ static int alloc_try_nid_top_down_numa_part_reserved_fallback_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(r1.base, r1.size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1507,7 +1518,7 @@ static int alloc_try_nid_top_down_numa_part_reserved_fallback_check(void)
  * Expect to drop the lower limit and allocate a memory region that ends at
  * the end of the requested node.
  */
-static int alloc_try_nid_top_down_numa_split_range_low_check(void)
+static int alloc_nid_top_down_numa_split_range_low_check(void)
 {
 	int nid_req = 2;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1525,8 +1536,8 @@ static int alloc_try_nid_top_down_numa_split_range_low_check(void)
 	min_addr = req_node_end - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1563,7 +1574,7 @@ static int alloc_try_nid_top_down_numa_split_range_low_check(void)
  * Expect to drop the lower limit and allocate a memory region that
  * ends at the end of the first node that overlaps with the range.
  */
-static int alloc_try_nid_top_down_numa_split_range_high_check(void)
+static int alloc_nid_top_down_numa_split_range_high_check(void)
 {
 	int nid_req = 3;
 	int nid_exp = nid_req - 1;
@@ -1582,8 +1593,8 @@ static int alloc_try_nid_top_down_numa_split_range_high_check(void)
 	min_addr = exp_node_end - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1620,7 +1631,7 @@ static int alloc_try_nid_top_down_numa_split_range_high_check(void)
  * Expect to drop the lower limit and allocate a memory region that ends at
  * the end of the requested node.
  */
-static int alloc_try_nid_top_down_numa_no_overlap_split_check(void)
+static int alloc_nid_top_down_numa_no_overlap_split_check(void)
 {
 	int nid_req = 2;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1638,8 +1649,8 @@ static int alloc_try_nid_top_down_numa_no_overlap_split_check(void)
 	min_addr = node2->base - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1677,7 +1688,7 @@ static int alloc_try_nid_top_down_numa_no_overlap_split_check(void)
  * Expect to allocate a memory region at the end of the final node in
  * the range after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_top_down_numa_no_overlap_low_check(void)
+static int alloc_nid_top_down_numa_no_overlap_low_check(void)
 {
 	int nid_req = 0;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1694,8 +1705,8 @@ static int alloc_try_nid_top_down_numa_no_overlap_low_check(void)
 	min_addr = min_node->base;
 	max_addr = region_end(max_node);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1733,7 +1744,7 @@ static int alloc_try_nid_top_down_numa_no_overlap_low_check(void)
  * Expect to allocate a memory region at the end of the final node in
  * the range after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
+static int alloc_nid_top_down_numa_no_overlap_high_check(void)
 {
 	int nid_req = 7;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1750,8 +1761,8 @@ static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
 	min_addr = min_node->base;
 	max_addr = region_end(max_node);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1773,7 +1784,7 @@ static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
  * has enough memory to allocate a region of the requested size.
  * Expect to allocate an aligned region at the beginning of the requested node.
  */
-static int alloc_try_nid_bottom_up_numa_simple_check(void)
+static int alloc_nid_bottom_up_numa_simple_check(void)
 {
 	int nid_req = 3;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1791,8 +1802,8 @@ static int alloc_try_nid_bottom_up_numa_simple_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1824,7 +1835,7 @@ static int alloc_try_nid_bottom_up_numa_simple_check(void)
  * Expect to allocate an aligned region at the beginning of the first node that
  * has enough memory (in this case, nid = 0) after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_bottom_up_numa_small_node_check(void)
+static int alloc_nid_bottom_up_numa_small_node_check(void)
 {
 	int nid_req = 1;
 	int nid_exp = 0;
@@ -1843,8 +1854,8 @@ static int alloc_try_nid_bottom_up_numa_small_node_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1878,7 +1889,7 @@ static int alloc_try_nid_bottom_up_numa_small_node_check(void)
  * after falling back to NUMA_NO_NODE. The region count and total size get
  * updated.
  */
-static int alloc_try_nid_bottom_up_numa_node_reserved_check(void)
+static int alloc_nid_bottom_up_numa_node_reserved_check(void)
 {
 	int nid_req = 2;
 	int nid_exp = 0;
@@ -1898,8 +1909,8 @@ static int alloc_try_nid_bottom_up_numa_node_reserved_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(req_node->base, req_node->size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1931,7 +1942,7 @@ static int alloc_try_nid_bottom_up_numa_node_reserved_check(void)
  * Expect to allocate an aligned region in the requested node that merges with
  * the existing reserved region. The total size gets updated.
  */
-static int alloc_try_nid_bottom_up_numa_part_reserved_check(void)
+static int alloc_nid_bottom_up_numa_part_reserved_check(void)
 {
 	int nid_req = 4;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1955,8 +1966,8 @@ static int alloc_try_nid_bottom_up_numa_part_reserved_check(void)
 	total_size = size + r1.size;
 
 	memblock_reserve(r1.base, r1.size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1991,7 +2002,7 @@ static int alloc_try_nid_bottom_up_numa_part_reserved_check(void)
  * nid = 0) after falling back to NUMA_NO_NODE. The region count and total size
  * get updated.
  */
-static int alloc_try_nid_bottom_up_numa_part_reserved_fallback_check(void)
+static int alloc_nid_bottom_up_numa_part_reserved_fallback_check(void)
 {
 	int nid_req = 4;
 	int nid_exp = 0;
@@ -2016,8 +2027,8 @@ static int alloc_try_nid_bottom_up_numa_part_reserved_fallback_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(r1.base, r1.size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2054,7 +2065,7 @@ static int alloc_try_nid_bottom_up_numa_part_reserved_fallback_check(void)
  * Expect to drop the lower limit and allocate a memory region at the beginning
  * of the requested node.
  */
-static int alloc_try_nid_bottom_up_numa_split_range_low_check(void)
+static int alloc_nid_bottom_up_numa_split_range_low_check(void)
 {
 	int nid_req = 2;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -2072,8 +2083,8 @@ static int alloc_try_nid_bottom_up_numa_split_range_low_check(void)
 	min_addr = req_node_end - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2110,7 +2121,7 @@ static int alloc_try_nid_bottom_up_numa_split_range_low_check(void)
  * Expect to drop the lower limit and allocate a memory region at the beginning
  * of the first node that has enough memory.
  */
-static int alloc_try_nid_bottom_up_numa_split_range_high_check(void)
+static int alloc_nid_bottom_up_numa_split_range_high_check(void)
 {
 	int nid_req = 3;
 	int nid_exp = 0;
@@ -2130,8 +2141,8 @@ static int alloc_try_nid_bottom_up_numa_split_range_high_check(void)
 	min_addr = req_node->base - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2168,7 +2179,7 @@ static int alloc_try_nid_bottom_up_numa_split_range_high_check(void)
  * Expect to drop the lower limit and allocate a memory region that starts at
  * the beginning of the requested node.
  */
-static int alloc_try_nid_bottom_up_numa_no_overlap_split_check(void)
+static int alloc_nid_bottom_up_numa_no_overlap_split_check(void)
 {
 	int nid_req = 2;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -2186,8 +2197,8 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_split_check(void)
 	min_addr = node2->base - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2225,7 +2236,7 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_split_check(void)
  * Expect to allocate a memory region at the beginning of the first node
  * in the range after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_bottom_up_numa_no_overlap_low_check(void)
+static int alloc_nid_bottom_up_numa_no_overlap_low_check(void)
 {
 	int nid_req = 0;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -2242,8 +2253,8 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_low_check(void)
 	min_addr = min_node->base;
 	max_addr = region_end(max_node);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2281,7 +2292,7 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_low_check(void)
  * Expect to allocate a memory region at the beginning of the first node
  * in the range after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
+static int alloc_nid_bottom_up_numa_no_overlap_high_check(void)
 {
 	int nid_req = 7;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -2298,8 +2309,8 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
 	min_addr = min_node->base;
 	max_addr = region_end(max_node);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2330,7 +2341,7 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
  *
  * Expect no allocation to happen.
  */
-static int alloc_try_nid_numa_large_region_generic_check(void)
+static int alloc_nid_numa_large_region_generic_check(void)
 {
 	int nid_req = 3;
 	void *allocated_ptr = NULL;
@@ -2344,8 +2355,8 @@ static int alloc_try_nid_numa_large_region_generic_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 	ASSERT_EQ(allocated_ptr, NULL);
 
 	test_pass_pop();
@@ -2374,7 +2385,7 @@ static int alloc_try_nid_numa_large_region_generic_check(void)
  * Expect to merge all of the regions into one. The region counter and total
  * size fields get updated.
  */
-static int alloc_try_nid_numa_reserved_full_merge_generic_check(void)
+static int alloc_nid_numa_reserved_full_merge_generic_check(void)
 {
 	int nid_req = 6;
 	int nid_next = nid_req + 1;
@@ -2404,8 +2415,8 @@ static int alloc_try_nid_numa_reserved_full_merge_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2448,7 +2459,7 @@ static int alloc_try_nid_numa_reserved_full_merge_generic_check(void)
  *
  * Expect no allocation to happen.
  */
-static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
+static int alloc_nid_numa_split_all_reserved_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 	struct memblock_region *next_node = &memblock.memory.regions[7];
@@ -2472,9 +2483,9 @@ static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -2484,139 +2495,139 @@ static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
 }
 
 /* Test case wrappers for NUMA tests */
-static int alloc_try_nid_numa_simple_check(void)
+static int alloc_nid_numa_simple_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_simple_check();
+	alloc_nid_top_down_numa_simple_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_simple_check();
+	alloc_nid_bottom_up_numa_simple_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_small_node_check(void)
+static int alloc_nid_numa_small_node_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_small_node_check();
+	alloc_nid_top_down_numa_small_node_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_small_node_check();
+	alloc_nid_bottom_up_numa_small_node_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_node_reserved_check(void)
+static int alloc_nid_numa_node_reserved_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_node_reserved_check();
+	alloc_nid_top_down_numa_node_reserved_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_node_reserved_check();
+	alloc_nid_bottom_up_numa_node_reserved_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_part_reserved_check(void)
+static int alloc_nid_numa_part_reserved_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_part_reserved_check();
+	alloc_nid_top_down_numa_part_reserved_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_part_reserved_check();
+	alloc_nid_bottom_up_numa_part_reserved_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_part_reserved_fallback_check(void)
+static int alloc_nid_numa_part_reserved_fallback_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_part_reserved_fallback_check();
+	alloc_nid_top_down_numa_part_reserved_fallback_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_part_reserved_fallback_check();
+	alloc_nid_bottom_up_numa_part_reserved_fallback_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_split_range_low_check(void)
+static int alloc_nid_numa_split_range_low_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_split_range_low_check();
+	alloc_nid_top_down_numa_split_range_low_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_split_range_low_check();
+	alloc_nid_bottom_up_numa_split_range_low_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_split_range_high_check(void)
+static int alloc_nid_numa_split_range_high_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_split_range_high_check();
+	alloc_nid_top_down_numa_split_range_high_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_split_range_high_check();
+	alloc_nid_bottom_up_numa_split_range_high_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_no_overlap_split_check(void)
+static int alloc_nid_numa_no_overlap_split_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_no_overlap_split_check();
+	alloc_nid_top_down_numa_no_overlap_split_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_no_overlap_split_check();
+	alloc_nid_bottom_up_numa_no_overlap_split_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_no_overlap_low_check(void)
+static int alloc_nid_numa_no_overlap_low_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_no_overlap_low_check();
+	alloc_nid_top_down_numa_no_overlap_low_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_no_overlap_low_check();
+	alloc_nid_bottom_up_numa_no_overlap_low_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_no_overlap_high_check(void)
+static int alloc_nid_numa_no_overlap_high_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
 	memblock_set_bottom_up(false);
-	alloc_try_nid_top_down_numa_no_overlap_high_check();
+	alloc_nid_top_down_numa_no_overlap_high_check();
 	memblock_set_bottom_up(true);
-	alloc_try_nid_bottom_up_numa_no_overlap_high_check();
+	alloc_nid_bottom_up_numa_no_overlap_high_check();
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_large_region_check(void)
+static int alloc_nid_numa_large_region_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_numa_large_region_generic_check);
-	run_bottom_up(alloc_try_nid_numa_large_region_generic_check);
+	run_top_down(alloc_nid_numa_large_region_generic_check);
+	run_bottom_up(alloc_nid_numa_large_region_generic_check);
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_reserved_full_merge_check(void)
+static int alloc_nid_numa_reserved_full_merge_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_numa_reserved_full_merge_generic_check);
-	run_bottom_up(alloc_try_nid_numa_reserved_full_merge_generic_check);
+	run_top_down(alloc_nid_numa_reserved_full_merge_generic_check);
+	run_bottom_up(alloc_nid_numa_reserved_full_merge_generic_check);
 
 	return 0;
 }
 
-static int alloc_try_nid_numa_split_all_reserved_check(void)
+static int alloc_nid_numa_split_all_reserved_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	run_top_down(alloc_try_nid_numa_split_all_reserved_generic_check);
-	run_bottom_up(alloc_try_nid_numa_split_all_reserved_generic_check);
+	run_top_down(alloc_nid_numa_split_all_reserved_generic_check);
+	run_bottom_up(alloc_nid_numa_split_all_reserved_generic_check);
 
 	return 0;
 }
@@ -2624,22 +2635,22 @@ static int alloc_try_nid_numa_split_all_reserved_check(void)
 int __memblock_alloc_nid_numa_checks(void)
 {
 	test_print("Running %s NUMA tests...\n",
-		   get_memblock_alloc_try_nid_name(alloc_nid_test_flags));
+		   get_memblock_alloc_nid_name(alloc_nid_test_flags));
 
-	alloc_try_nid_numa_simple_check();
-	alloc_try_nid_numa_small_node_check();
-	alloc_try_nid_numa_node_reserved_check();
-	alloc_try_nid_numa_part_reserved_check();
-	alloc_try_nid_numa_part_reserved_fallback_check();
-	alloc_try_nid_numa_split_range_low_check();
-	alloc_try_nid_numa_split_range_high_check();
+	alloc_nid_numa_simple_check();
+	alloc_nid_numa_small_node_check();
+	alloc_nid_numa_node_reserved_check();
+	alloc_nid_numa_part_reserved_check();
+	alloc_nid_numa_part_reserved_fallback_check();
+	alloc_nid_numa_split_range_low_check();
+	alloc_nid_numa_split_range_high_check();
 
-	alloc_try_nid_numa_no_overlap_split_check();
-	alloc_try_nid_numa_no_overlap_low_check();
-	alloc_try_nid_numa_no_overlap_high_check();
-	alloc_try_nid_numa_large_region_check();
-	alloc_try_nid_numa_reserved_full_merge_check();
-	alloc_try_nid_numa_split_all_reserved_check();
+	alloc_nid_numa_no_overlap_split_check();
+	alloc_nid_numa_no_overlap_low_check();
+	alloc_nid_numa_no_overlap_high_check();
+	alloc_nid_numa_large_region_check();
+	alloc_nid_numa_reserved_full_merge_check();
+	alloc_nid_numa_split_all_reserved_check();
 
 	return 0;
 }
@@ -2649,7 +2660,7 @@ static int memblock_alloc_nid_checks_internal(int flags)
 	alloc_nid_test_flags = flags;
 
 	prefix_reset();
-	prefix_push(get_memblock_alloc_try_nid_name(flags));
+	prefix_push(get_memblock_alloc_nid_name(flags));
 
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
@@ -2671,3 +2682,12 @@ int memblock_alloc_nid_checks(void)
 
 	return 0;
 }
+
+int memblock_alloc_exact_nid_range_checks(void)
+{
+	alloc_nid_test_flags = (TEST_F_RAW | TEST_F_EXACT);
+
+	memblock_alloc_nid_range_checks();
+
+	return 0;
+}
diff --git a/tools/testing/memblock/tests/alloc_nid_api.h b/tools/testing/memblock/tests/alloc_nid_api.h
index 92d07d230e18..2b8cabacacb8 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.h
+++ b/tools/testing/memblock/tests/alloc_nid_api.h
@@ -5,6 +5,7 @@
 #include "common.h"
 
 int memblock_alloc_nid_checks(void);
+int memblock_alloc_exact_nid_range_checks(void);
 int __memblock_alloc_nid_numa_checks(void);
 
 #ifdef CONFIG_NUMA
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index cc82b85151b6..4f23302ee677 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -21,6 +21,8 @@ enum test_flags {
 	TEST_F_NONE = 0x0,
 	/* Perform raw allocations (no zeroing of memory). */
 	TEST_F_RAW = 0x1,
+	/* Perform allocations on the exact node specified. */
+	TEST_F_EXACT = 0x2
 };
 
 /**
-- 
2.34.1

