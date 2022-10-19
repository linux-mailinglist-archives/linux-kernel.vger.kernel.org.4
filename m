Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26088604FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJSSfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJSSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:35:11 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B99144E14
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:06 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id mg6so11969623qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j28206r4aar9dcV8glgarv2w0NeTqsai5FCE2wcIBDw=;
        b=j3XAAGGyFGfkmUhsg66vpLmY7woVrEV0c8I1HjDWP5AbLg0WHyAEP+sF+NOs5g28oh
         HJi+STqKi92VPo85NR5R/LlzU/MBL1wrIVCkJlGnjLce4yoKnkC+4LI44HK4pI1VKm6U
         g3CRET/0cCLqTG1bF+35f7krGle7iFOq6+iLj2qAI3anmuQwCAFhwyCfeqcTF9RC+vt5
         FKkcdJkzS9NAMvsxPknbJdLm5SOaRACaltwyQ28SZyZ388eRh4Y6yt2gbPwE1hBaYT2y
         +F0lVcuweNoMAUvuTNk/J9F2j0zDy4n5lm1HxKMQxhaGkHM/3DSpFNCvxxNExDqivuIl
         ChRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j28206r4aar9dcV8glgarv2w0NeTqsai5FCE2wcIBDw=;
        b=BGUGuFOo7fEM65npFxHw6xs3HXqKjO43ntaEknjy7PRgRu2nh6aMLBGzCT2G6BIgHw
         8AhOSfPiCtct5H9rEbS+e55frvE0O2AF6EKGYplGLp3Fv11vZy7avRoxWPrLIEG8TgXE
         F8SS2YelfEiwaXn61BHEZa+Qvp0peHE4FylRXxSUUOGZGqii+TNHGkbxOUfAsqqxiZ3S
         o7wZVTviMJqJrEb7Jy9as/fWek/a3l0WRevgXzHuShoZsx3wy87IZe4JohOGWOQY8r0I
         CbZJRtaLlLQA4Q7aY3u0neOOGDVnPZx7g0kutwC4zjCIEzmvF9UTBc/hsRCanXrSw8Z4
         UchQ==
X-Gm-Message-State: ACrzQf3v/IV/itaYfZK3WobXpTZ5vvRTGKdui/Jor1D+8NnRqnglFImm
        gCtE8kbs+hN+pZ4S4igcMRE=
X-Google-Smtp-Source: AMsMyM7Zp4+yKny/XkFe8EPH8y1ghm/PPMeKnCuUf6NsvyX4eg/tPDvD0ov0svincs6gL32f+u1Hlw==
X-Received: by 2002:a0c:e1c6:0:b0:4af:aa3c:987c with SMTP id v6-20020a0ce1c6000000b004afaa3c987cmr8163993qvl.60.1666204504804;
        Wed, 19 Oct 2022 11:35:04 -0700 (PDT)
Received: from sophie ([143.244.47.100])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8580d000000b00399d5d564b7sm4725917qtg.56.2022.10.19.11.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:35:03 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 1/5] memblock tests: introduce range tests for memblock_alloc_exact_nid_raw
Date:   Wed, 19 Oct 2022 13:34:08 -0500
Message-Id: <d5481026b5b75e919e6497968453e86ab79b77d0.1666203643.git.remckee0@gmail.com>
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

Add TEST_F_EXACT flag, which specifies that tests should run
memblock_alloc_exact_nid_raw(). Introduce range tests for
memblock_alloc_exact_nid_raw() by using the TEST_F_EXACT flag to run the
range tests in alloc_nid_api.c, since memblock_alloc_exact_nid_raw() and
memblock_alloc_try_nid_raw() behave the same way when nid = NUMA_NO_NODE.

Rename tests and other functions in alloc_nid_api.c by removing "_try".
Since the test names will be displayed in verbose output, they need to
be general enough to refer to any of the memblock functions that the
tests may run.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/Makefile               |   2 +-
 tools/testing/memblock/main.c                 |   2 +
 .../memblock/tests/alloc_exact_nid_api.c      |  22 +
 .../memblock/tests/alloc_exact_nid_api.h      |   9 +
 tools/testing/memblock/tests/alloc_nid_api.c  | 542 +++++++++---------
 tools/testing/memblock/tests/alloc_nid_api.h  |   1 +
 tools/testing/memblock/tests/common.h         |   2 +
 7 files changed, 317 insertions(+), 263 deletions(-)
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
index 2c2d60f4e3e3..df8e7e038cab 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -18,18 +18,27 @@ static const unsigned int node_fractions[] = {
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
+static inline void *run_memblock_alloc_nid(phys_addr_t size,
+					   phys_addr_t align,
+					   phys_addr_t min_addr,
+					   phys_addr_t max_addr, int nid)
 {
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
@@ -50,7 +59,7 @@ static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
  *
  * Expect to allocate a region that ends at max_addr.
  */
-static int alloc_try_nid_top_down_simple_check(void)
+static int alloc_nid_top_down_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -65,9 +74,9 @@ static int alloc_try_nid_top_down_simple_check(void)
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
@@ -102,7 +111,7 @@ static int alloc_try_nid_top_down_simple_check(void)
  *
  * Expect to allocate an aligned region that ends before max_addr.
  */
-static int alloc_try_nid_top_down_end_misaligned_check(void)
+static int alloc_nid_top_down_end_misaligned_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -118,9 +127,9 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
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
@@ -153,7 +162,7 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
  * Expect to allocate a region that starts at min_addr and ends at
  * max_addr, given that min_addr is aligned.
  */
-static int alloc_try_nid_exact_address_generic_check(void)
+static int alloc_nid_exact_address_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -168,9 +177,9 @@ static int alloc_try_nid_exact_address_generic_check(void)
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
@@ -205,7 +214,7 @@ static int alloc_try_nid_exact_address_generic_check(void)
  * Expect to drop the lower limit and allocate a memory region which
  * ends at max_addr (if the address is aligned).
  */
-static int alloc_try_nid_top_down_narrow_range_check(void)
+static int alloc_nid_top_down_narrow_range_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -219,9 +228,9 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
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
@@ -257,7 +266,7 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
  *
  * Expect no allocation to happen.
  */
-static int alloc_try_nid_low_max_generic_check(void)
+static int alloc_nid_low_max_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 	phys_addr_t size = SZ_1K;
@@ -270,9 +279,9 @@ static int alloc_try_nid_low_max_generic_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = min_addr + SMP_CACHE_BYTES;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -295,7 +304,7 @@ static int alloc_try_nid_low_max_generic_check(void)
  *
  * Expect a merge of both regions. Only the region size gets updated.
  */
-static int alloc_try_nid_min_reserved_generic_check(void)
+static int alloc_nid_min_reserved_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -315,9 +324,9 @@ static int alloc_try_nid_min_reserved_generic_check(void)
 
 	memblock_reserve(reserved_base, r1_size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r2_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r2_size, alloc_nid_test_flags);
@@ -347,7 +356,7 @@ static int alloc_try_nid_min_reserved_generic_check(void)
  *
  * Expect a merge of regions. Only the region size gets updated.
  */
-static int alloc_try_nid_max_reserved_generic_check(void)
+static int alloc_nid_max_reserved_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -365,9 +374,9 @@ static int alloc_try_nid_max_reserved_generic_check(void)
 
 	memblock_reserve(max_addr, r1_size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r2_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, r2_size, alloc_nid_test_flags);
@@ -400,7 +409,7 @@ static int alloc_try_nid_max_reserved_generic_check(void)
  * updated. The total size field gets updated.
  */
 
-static int alloc_try_nid_top_down_reserved_with_space_check(void)
+static int alloc_nid_top_down_reserved_with_space_check(void)
 {
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
@@ -428,9 +437,9 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
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
@@ -465,7 +474,7 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
  * Expect to merge all of the regions into one. The region counter and total
  * size fields get updated.
  */
-static int alloc_try_nid_reserved_full_merge_generic_check(void)
+static int alloc_nid_reserved_full_merge_generic_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -491,9 +500,9 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
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
@@ -527,7 +536,7 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
  * Expect to merge the new region with r2. The second region does not get
  * updated. The total size counter gets updated.
  */
-static int alloc_try_nid_top_down_reserved_no_space_check(void)
+static int alloc_nid_top_down_reserved_no_space_check(void)
 {
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
@@ -555,9 +564,9 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
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
@@ -596,7 +605,7 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
  * Expect no allocation to happen.
  */
 
-static int alloc_try_nid_reserved_all_generic_check(void)
+static int alloc_nid_reserved_all_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 	struct region r1, r2;
@@ -620,9 +629,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -636,7 +645,7 @@ static int alloc_try_nid_reserved_all_generic_check(void)
  * bigger than the end address of the available memory. Expect to allocate
  * a region that ends before the end of the memory.
  */
-static int alloc_try_nid_top_down_cap_max_check(void)
+static int alloc_nid_top_down_cap_max_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -650,9 +659,9 @@ static int alloc_try_nid_top_down_cap_max_check(void)
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
@@ -673,7 +682,7 @@ static int alloc_try_nid_top_down_cap_max_check(void)
  * smaller than the start address of the available memory. Expect to allocate
  * a region that ends before the end of the memory.
  */
-static int alloc_try_nid_top_down_cap_min_check(void)
+static int alloc_nid_top_down_cap_min_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -687,9 +696,9 @@ static int alloc_try_nid_top_down_cap_min_check(void)
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
@@ -719,7 +728,7 @@ static int alloc_try_nid_top_down_cap_min_check(void)
  *
  * Expect to allocate a region that ends before max_addr.
  */
-static int alloc_try_nid_bottom_up_simple_check(void)
+static int alloc_nid_bottom_up_simple_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -734,9 +743,9 @@ static int alloc_try_nid_bottom_up_simple_check(void)
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
@@ -771,7 +780,7 @@ static int alloc_try_nid_bottom_up_simple_check(void)
  *
  * Expect to allocate an aligned region that ends before max_addr.
  */
-static int alloc_try_nid_bottom_up_start_misaligned_check(void)
+static int alloc_nid_bottom_up_start_misaligned_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -787,9 +796,9 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
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
@@ -824,7 +833,7 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
  * Expect to drop the lower limit and allocate a memory region which
  * starts at the beginning of the available memory.
  */
-static int alloc_try_nid_bottom_up_narrow_range_check(void)
+static int alloc_nid_bottom_up_narrow_range_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -838,9 +847,9 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
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
@@ -873,7 +882,7 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
  * updated. The total size field gets updated.
  */
 
-static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
+static int alloc_nid_bottom_up_reserved_with_space_check(void)
 {
 	struct memblock_region *rgn1 = &memblock.reserved.regions[1];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[0];
@@ -901,9 +910,9 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
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
@@ -942,7 +951,7 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
  * Other regions are not modified.
  */
 
-static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
+static int alloc_nid_bottom_up_reserved_no_space_check(void)
 {
 	struct memblock_region *rgn1 = &memblock.reserved.regions[2];
 	struct memblock_region *rgn2 = &memblock.reserved.regions[1];
@@ -971,9 +980,9 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
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
@@ -1000,7 +1009,7 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
  * bigger than the end address of the available memory. Expect to allocate
  * a region that starts at the min_addr.
  */
-static int alloc_try_nid_bottom_up_cap_max_check(void)
+static int alloc_nid_bottom_up_cap_max_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -1014,9 +1023,9 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
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
@@ -1037,7 +1046,7 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
  * smaller than the start address of the available memory. Expect to allocate
  * a region at the beginning of the available memory.
  */
-static int alloc_try_nid_bottom_up_cap_min_check(void)
+static int alloc_nid_bottom_up_cap_min_check(void)
 {
 	struct memblock_region *rgn = &memblock.reserved.regions[0];
 	void *allocated_ptr = NULL;
@@ -1051,9 +1060,9 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
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
@@ -1070,133 +1079,133 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
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
@@ -1204,22 +1213,22 @@ static int alloc_try_nid_low_max_check(void)
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
@@ -1229,7 +1238,7 @@ static int memblock_alloc_nid_range_checks(void)
  * has enough memory to allocate a region of the requested size.
  * Expect to allocate an aligned region at the end of the requested node.
  */
-static int alloc_try_nid_top_down_numa_simple_check(void)
+static int alloc_nid_top_down_numa_simple_check(void)
 {
 	int nid_req = 3;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1247,8 +1256,8 @@ static int alloc_try_nid_top_down_numa_simple_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1280,7 +1289,7 @@ static int alloc_try_nid_top_down_numa_simple_check(void)
  * Expect to allocate an aligned region at the end of the last node that has
  * enough memory (in this case, nid = 6) after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_top_down_numa_small_node_check(void)
+static int alloc_nid_top_down_numa_small_node_check(void)
 {
 	int nid_req = 1;
 	int nid_exp = 6;
@@ -1299,8 +1308,8 @@ static int alloc_try_nid_top_down_numa_small_node_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1333,7 +1342,7 @@ static int alloc_try_nid_top_down_numa_small_node_check(void)
  * large enough and has enough unreserved memory (in this case, nid = 6) after
  * falling back to NUMA_NO_NODE. The region count and total size get updated.
  */
-static int alloc_try_nid_top_down_numa_node_reserved_check(void)
+static int alloc_nid_top_down_numa_node_reserved_check(void)
 {
 	int nid_req = 2;
 	int nid_exp = 6;
@@ -1353,8 +1362,8 @@ static int alloc_try_nid_top_down_numa_node_reserved_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(req_node->base, req_node->size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1386,7 +1395,7 @@ static int alloc_try_nid_top_down_numa_node_reserved_check(void)
  * Expect to allocate an aligned region at the end of the requested node. The
  * region count and total size get updated.
  */
-static int alloc_try_nid_top_down_numa_part_reserved_check(void)
+static int alloc_nid_top_down_numa_part_reserved_check(void)
 {
 	int nid_req = 4;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[1];
@@ -1408,8 +1417,8 @@ static int alloc_try_nid_top_down_numa_part_reserved_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(r1.base, r1.size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1444,7 +1453,7 @@ static int alloc_try_nid_top_down_numa_part_reserved_check(void)
  * nid = NUMA_NODES - 1) after falling back to NUMA_NO_NODE. The region count
  * and total size get updated.
  */
-static int alloc_try_nid_top_down_numa_part_reserved_fallback_check(void)
+static int alloc_nid_top_down_numa_part_reserved_fallback_check(void)
 {
 	int nid_req = 4;
 	int nid_exp = NUMA_NODES - 1;
@@ -1469,8 +1478,8 @@ static int alloc_try_nid_top_down_numa_part_reserved_fallback_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(r1.base, r1.size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1507,7 +1516,7 @@ static int alloc_try_nid_top_down_numa_part_reserved_fallback_check(void)
  * Expect to drop the lower limit and allocate a memory region that ends at
  * the end of the requested node.
  */
-static int alloc_try_nid_top_down_numa_split_range_low_check(void)
+static int alloc_nid_top_down_numa_split_range_low_check(void)
 {
 	int nid_req = 2;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1525,8 +1534,8 @@ static int alloc_try_nid_top_down_numa_split_range_low_check(void)
 	min_addr = req_node_end - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1563,7 +1572,7 @@ static int alloc_try_nid_top_down_numa_split_range_low_check(void)
  * Expect to drop the lower limit and allocate a memory region that
  * ends at the end of the first node that overlaps with the range.
  */
-static int alloc_try_nid_top_down_numa_split_range_high_check(void)
+static int alloc_nid_top_down_numa_split_range_high_check(void)
 {
 	int nid_req = 3;
 	int nid_exp = nid_req - 1;
@@ -1582,8 +1591,8 @@ static int alloc_try_nid_top_down_numa_split_range_high_check(void)
 	min_addr = exp_node_end - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1620,7 +1629,7 @@ static int alloc_try_nid_top_down_numa_split_range_high_check(void)
  * Expect to drop the lower limit and allocate a memory region that ends at
  * the end of the requested node.
  */
-static int alloc_try_nid_top_down_numa_no_overlap_split_check(void)
+static int alloc_nid_top_down_numa_no_overlap_split_check(void)
 {
 	int nid_req = 2;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1638,8 +1647,8 @@ static int alloc_try_nid_top_down_numa_no_overlap_split_check(void)
 	min_addr = node2->base - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1677,7 +1686,7 @@ static int alloc_try_nid_top_down_numa_no_overlap_split_check(void)
  * Expect to allocate a memory region at the end of the final node in
  * the range after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_top_down_numa_no_overlap_low_check(void)
+static int alloc_nid_top_down_numa_no_overlap_low_check(void)
 {
 	int nid_req = 0;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1694,8 +1703,8 @@ static int alloc_try_nid_top_down_numa_no_overlap_low_check(void)
 	min_addr = min_node->base;
 	max_addr = region_end(max_node);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1733,7 +1742,7 @@ static int alloc_try_nid_top_down_numa_no_overlap_low_check(void)
  * Expect to allocate a memory region at the end of the final node in
  * the range after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
+static int alloc_nid_top_down_numa_no_overlap_high_check(void)
 {
 	int nid_req = 7;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1750,8 +1759,8 @@ static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
 	min_addr = min_node->base;
 	max_addr = region_end(max_node);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1773,7 +1782,7 @@ static int alloc_try_nid_top_down_numa_no_overlap_high_check(void)
  * has enough memory to allocate a region of the requested size.
  * Expect to allocate an aligned region at the beginning of the requested node.
  */
-static int alloc_try_nid_bottom_up_numa_simple_check(void)
+static int alloc_nid_bottom_up_numa_simple_check(void)
 {
 	int nid_req = 3;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1791,8 +1800,8 @@ static int alloc_try_nid_bottom_up_numa_simple_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1824,7 +1833,7 @@ static int alloc_try_nid_bottom_up_numa_simple_check(void)
  * Expect to allocate an aligned region at the beginning of the first node that
  * has enough memory (in this case, nid = 0) after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_bottom_up_numa_small_node_check(void)
+static int alloc_nid_bottom_up_numa_small_node_check(void)
 {
 	int nid_req = 1;
 	int nid_exp = 0;
@@ -1843,8 +1852,8 @@ static int alloc_try_nid_bottom_up_numa_small_node_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1878,7 +1887,7 @@ static int alloc_try_nid_bottom_up_numa_small_node_check(void)
  * after falling back to NUMA_NO_NODE. The region count and total size get
  * updated.
  */
-static int alloc_try_nid_bottom_up_numa_node_reserved_check(void)
+static int alloc_nid_bottom_up_numa_node_reserved_check(void)
 {
 	int nid_req = 2;
 	int nid_exp = 0;
@@ -1898,8 +1907,8 @@ static int alloc_try_nid_bottom_up_numa_node_reserved_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(req_node->base, req_node->size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1931,7 +1940,7 @@ static int alloc_try_nid_bottom_up_numa_node_reserved_check(void)
  * Expect to allocate an aligned region in the requested node that merges with
  * the existing reserved region. The total size gets updated.
  */
-static int alloc_try_nid_bottom_up_numa_part_reserved_check(void)
+static int alloc_nid_bottom_up_numa_part_reserved_check(void)
 {
 	int nid_req = 4;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -1955,8 +1964,8 @@ static int alloc_try_nid_bottom_up_numa_part_reserved_check(void)
 	total_size = size + r1.size;
 
 	memblock_reserve(r1.base, r1.size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -1991,7 +2000,7 @@ static int alloc_try_nid_bottom_up_numa_part_reserved_check(void)
  * nid = 0) after falling back to NUMA_NO_NODE. The region count and total size
  * get updated.
  */
-static int alloc_try_nid_bottom_up_numa_part_reserved_fallback_check(void)
+static int alloc_nid_bottom_up_numa_part_reserved_fallback_check(void)
 {
 	int nid_req = 4;
 	int nid_exp = 0;
@@ -2016,8 +2025,8 @@ static int alloc_try_nid_bottom_up_numa_part_reserved_fallback_check(void)
 	max_addr = memblock_end_of_DRAM();
 
 	memblock_reserve(r1.base, r1.size);
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2054,7 +2063,7 @@ static int alloc_try_nid_bottom_up_numa_part_reserved_fallback_check(void)
  * Expect to drop the lower limit and allocate a memory region at the beginning
  * of the requested node.
  */
-static int alloc_try_nid_bottom_up_numa_split_range_low_check(void)
+static int alloc_nid_bottom_up_numa_split_range_low_check(void)
 {
 	int nid_req = 2;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -2072,8 +2081,8 @@ static int alloc_try_nid_bottom_up_numa_split_range_low_check(void)
 	min_addr = req_node_end - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2110,7 +2119,7 @@ static int alloc_try_nid_bottom_up_numa_split_range_low_check(void)
  * Expect to drop the lower limit and allocate a memory region at the beginning
  * of the first node that has enough memory.
  */
-static int alloc_try_nid_bottom_up_numa_split_range_high_check(void)
+static int alloc_nid_bottom_up_numa_split_range_high_check(void)
 {
 	int nid_req = 3;
 	int nid_exp = 0;
@@ -2130,8 +2139,8 @@ static int alloc_try_nid_bottom_up_numa_split_range_high_check(void)
 	min_addr = req_node->base - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2168,7 +2177,7 @@ static int alloc_try_nid_bottom_up_numa_split_range_high_check(void)
  * Expect to drop the lower limit and allocate a memory region that starts at
  * the beginning of the requested node.
  */
-static int alloc_try_nid_bottom_up_numa_no_overlap_split_check(void)
+static int alloc_nid_bottom_up_numa_no_overlap_split_check(void)
 {
 	int nid_req = 2;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -2186,8 +2195,8 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_split_check(void)
 	min_addr = node2->base - SZ_256;
 	max_addr = min_addr + size;
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2225,7 +2234,7 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_split_check(void)
  * Expect to allocate a memory region at the beginning of the first node
  * in the range after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_bottom_up_numa_no_overlap_low_check(void)
+static int alloc_nid_bottom_up_numa_no_overlap_low_check(void)
 {
 	int nid_req = 0;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -2242,8 +2251,8 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_low_check(void)
 	min_addr = min_node->base;
 	max_addr = region_end(max_node);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2281,7 +2290,7 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_low_check(void)
  * Expect to allocate a memory region at the beginning of the first node
  * in the range after falling back to NUMA_NO_NODE.
  */
-static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
+static int alloc_nid_bottom_up_numa_no_overlap_high_check(void)
 {
 	int nid_req = 7;
 	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
@@ -2298,8 +2307,8 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
 	min_addr = min_node->base;
 	max_addr = region_end(max_node);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2330,7 +2339,7 @@ static int alloc_try_nid_bottom_up_numa_no_overlap_high_check(void)
  *
  * Expect no allocation to happen.
  */
-static int alloc_try_nid_numa_large_region_generic_check(void)
+static int alloc_nid_numa_large_region_generic_check(void)
 {
 	int nid_req = 3;
 	void *allocated_ptr = NULL;
@@ -2344,8 +2353,8 @@ static int alloc_try_nid_numa_large_region_generic_check(void)
 	min_addr = memblock_start_of_DRAM();
 	max_addr = memblock_end_of_DRAM();
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 	ASSERT_EQ(allocated_ptr, NULL);
 
 	test_pass_pop();
@@ -2374,7 +2383,7 @@ static int alloc_try_nid_numa_large_region_generic_check(void)
  * Expect to merge all of the regions into one. The region counter and total
  * size fields get updated.
  */
-static int alloc_try_nid_numa_reserved_full_merge_generic_check(void)
+static int alloc_nid_numa_reserved_full_merge_generic_check(void)
 {
 	int nid_req = 6;
 	int nid_next = nid_req + 1;
@@ -2404,8 +2413,8 @@ static int alloc_try_nid_numa_reserved_full_merge_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr, nid_req);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr, nid_req);
 
 	ASSERT_NE(allocated_ptr, NULL);
 	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
@@ -2448,7 +2457,7 @@ static int alloc_try_nid_numa_reserved_full_merge_generic_check(void)
  *
  * Expect no allocation to happen.
  */
-static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
+static int alloc_nid_numa_split_all_reserved_generic_check(void)
 {
 	void *allocated_ptr = NULL;
 	struct memblock_region *next_node = &memblock.memory.regions[7];
@@ -2472,9 +2481,9 @@ static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
 	memblock_reserve(r1.base, r1.size);
 	memblock_reserve(r2.base, r2.size);
 
-	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
-						   min_addr, max_addr,
-						   NUMA_NO_NODE);
+	allocated_ptr = run_memblock_alloc_nid(size, SMP_CACHE_BYTES,
+					       min_addr, max_addr,
+					       NUMA_NO_NODE);
 
 	ASSERT_EQ(allocated_ptr, NULL);
 
@@ -2484,139 +2493,139 @@ static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
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
@@ -2624,22 +2633,22 @@ static int alloc_try_nid_numa_split_all_reserved_check(void)
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
@@ -2649,7 +2658,7 @@ static int memblock_alloc_nid_checks_internal(int flags)
 	alloc_nid_test_flags = flags;
 
 	prefix_reset();
-	prefix_push(get_memblock_alloc_try_nid_name(flags));
+	prefix_push(get_memblock_alloc_nid_name(flags));
 
 	reset_memblock_attributes();
 	dummy_physical_memory_init();
@@ -2671,3 +2680,12 @@ int memblock_alloc_nid_checks(void)
 
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
index d6bbbe63bfc3..ec8f9a779c83 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -18,6 +18,8 @@ enum test_flags {
 	TEST_F_NONE = 0x0,
 	/* Perform raw allocations (no zeroing of memory). */
 	TEST_F_RAW = 0x1,
+	/* Perform allocations on the exact node specified. */
+	TEST_F_EXACT = 0x2
 };
 
 /**
-- 
2.25.1

