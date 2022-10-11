Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A85FACA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJKGWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJKGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A8760DA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665469290; x=1697005290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qxV4gyJ/ejlW/tPGTWrK8Ih4YPly+7yJn9Z1PGkJMw=;
  b=hLkZ9tdstUoXucqVo7lHgfjQPkEuVMQ7UoRs+2IcyRgHpdsmd6xjIhIv
   6Zqd/FT/8DFj4xSgf/qVnA/LcoYcmsRjpYZBbZsKTdXr+feL+6j76JNVN
   rUy5/y1giLUMStrIyfbYThjBk7dVlz2YSssm3LAgSFLzmWx85+AZ81BBO
   zgdctNa8paGmHFnjF/TSRq9awDxhjOM3g4mNR5rK5RN3ZXUOEl3IWbeJb
   fEg3aKvqvMc+HHBtVryk+OSFX6jftsY8IUNRwIQaFLVoyPAD0fzsSXIda
   U9cNU74YSyhCfkD0juSqCz9NwJDF0JB/m6+hRRT3HtNtiOEeD7FqcpOhy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284149486"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="284149486"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 23:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577321977"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="577321977"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2022 23:21:14 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] memblock test: Add test to memblock_add() 129th region
Date:   Tue, 11 Oct 2022 14:21:20 +0800
Message-Id: <20221011062128.49359-2-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011062128.49359-1-shaoqin.huang@intel.com>
References: <20221011062128.49359-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Add 129th region into the memblock, and this will trigger the
memblock_double_array() function, this needs valid memory regions. So
using dummy_physical_memory_init() to allocate a large enough memory
region, and split it into a large enough memory which can be choosed by
memblock_double_array(), and the left memory will be split into small
memory region, and add them into the memblock. It make sure the
memblock_double_array() will always choose the valid memory region that
is allocated by the dummy_physical_memory_init().
So memblock_double_array() must success.

Another thing should be done is to restore the memory.regions after
memblock_double_array(), due to now the memory.regions is pointing to a
memory region allocated by dummy_physical_memory_init(). And it will
affect the subsequent tests if we don't restore the memory region. So
simply record the origin region, and restore it after the test.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/tests/basic_api.c | 93 ++++++++++++++++++++++++
 tools/testing/memblock/tests/common.c    |  7 +-
 tools/testing/memblock/tests/common.h    |  6 +-
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index a13a57ba0815..4d61a4b474be 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -423,6 +423,98 @@ static int memblock_add_near_max_check(void)
 	return 0;
 }
 
+/*
+ * A test that trying to add the 129th memory block.
+ * Expect to trigger memblock_double_array() to double the
+ * memblock.memory.max, find a new valid memory as
+ * memory.regions.
+ */
+static int memblock_add_many_check(void)
+{
+	int i;
+	void *orig_region;
+	struct region r = {
+		.base = SZ_16K,
+		.size = SZ_16K,
+	};
+	phys_addr_t new_memory_regions_size;
+	phys_addr_t base, size = SZ_64;
+	phys_addr_t gap_size = SZ_64;
+
+	PREFIX_PUSH();
+
+	reset_memblock_regions();
+	memblock_allow_resize();
+
+	dummy_physical_memory_init();
+	/*
+	 * We allocated enough memory by using dummy_physical_memory_init(), and
+	 * split it into small block. First we split a large enough memory block
+	 * as the memory region which will be choosed by memblock_double_array().
+	 */
+	base = PAGE_ALIGN(dummy_physical_memory_base());
+	new_memory_regions_size = PAGE_ALIGN(INIT_MEMBLOCK_REGIONS * 2 *
+					     sizeof(struct memblock_region));
+	memblock_add(base, new_memory_regions_size);
+
+	/* This is the base of small memory block. */
+	base += new_memory_regions_size + gap_size;
+
+	orig_region = memblock.memory.regions;
+
+	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
+		/*
+		 * Add these small block to fulfill the memblock. We keep a
+		 * gap between the nearby memory to avoid being merged.
+		 */
+		memblock_add(base, size);
+		base += size + gap_size;
+
+		ASSERT_EQ(memblock.memory.cnt, i + 2);
+		ASSERT_EQ(memblock.memory.total_size, new_memory_regions_size +
+						      (i + 1) * size);
+	}
+
+	/*
+	 * At there, memblock_double_array() has been succeed, check if it
+	 * update the memory.max.
+	 */
+	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	/* memblock_double_array() will reserve the memory it used. Check it. */
+	ASSERT_EQ(memblock.reserved.cnt, 1);
+	ASSERT_EQ(memblock.reserved.total_size, new_memory_regions_size);
+
+	/*
+	 * Now memblock_double_array() works fine. Let's check after the
+	 * double_array(), the memblock_add() still works as normal.
+	 */
+	memblock_add(r.base, r.size);
+	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
+	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
+
+	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
+	ASSERT_EQ(memblock.memory.total_size, INIT_MEMBLOCK_REGIONS * size +
+					      new_memory_regions_size +
+					      r.size);
+	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	dummy_physical_memory_cleanup();
+
+	/*
+	 * The current memory.regions is occupying a range of memory that
+	 * allocated from dummy_physical_memory_init(). After free the memory,
+	 * we must not use it. So restore the origin memory region to make sure
+	 * the tests can run as normal and not affected by the double array.
+	 */
+	memblock.memory.regions = orig_region;
+	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
+
+	test_pass_pop();
+
+	return 0;
+}
+
 static int memblock_add_checks(void)
 {
 	prefix_reset();
@@ -438,6 +530,7 @@ static int memblock_add_checks(void)
 	memblock_add_twice_check();
 	memblock_add_between_check();
 	memblock_add_near_max_check();
+	memblock_add_many_check();
 
 	prefix_pop();
 
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index 3f795047bbe1..f43b6f414983 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -5,8 +5,6 @@
 #include <linux/memory_hotplug.h>
 #include <linux/build_bug.h>
 
-#define INIT_MEMBLOCK_REGIONS			128
-#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 #define PREFIXES_MAX				15
 #define DELIM					": "
 #define BASIS					10000
@@ -115,6 +113,11 @@ void dummy_physical_memory_cleanup(void)
 	free(memory_block.base);
 }
 
+phys_addr_t dummy_physical_memory_base(void)
+{
+	return (phys_addr_t)memory_block.base;
+}
+
 static void usage(const char *prog)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index d6bbbe63bfc3..cc82b85151b6 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -10,9 +10,12 @@
 #include <linux/printk.h>
 #include <../selftests/kselftest.h>
 
-#define MEM_SIZE		SZ_16K
+#define MEM_SIZE		SZ_32K
 #define NUMA_NODES		8
 
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+
 enum test_flags {
 	/* No special request. */
 	TEST_F_NONE = 0x0,
@@ -124,6 +127,7 @@ void setup_memblock(void);
 void setup_numa_memblock(const unsigned int node_fracs[]);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
+phys_addr_t dummy_physical_memory_base(void);
 void parse_args(int argc, char **argv);
 
 void test_fail(void);
-- 
2.34.1

