Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A65FACA8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJKGWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJKGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A4988A0D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665469292; x=1697005292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OlGIODpv04YEUz28eV6/esNGVmMut18UL3VgBHg/Gxc=;
  b=dqJXbN/pTUjdhE0g7NlHSkJaCS98ZYvAtd+8SKnMz3cvNrMlYHE4B5eW
   Ly60rR+LUYHDJ3mUBh3s2pn7Pc+ZgEpZk8jjjGTOJmYzLCUIyksrzl5My
   duLATrvcWFRAGe6Yb6wJuMeH4xf94ydq2o+wsHRVldzj7dFQex8SD3Szc
   HyhyDhw/1CBJpDR/+kCWkckw0xiwN7TYQ0A/R85NpgryxJLP/MmjNHes/
   uHFckK4VeUgqwjlVPfbw4KeO1aUqimEqs9wfZCZ8aq4aW0/d2UpOxUm0e
   HWlZqpgSxsTi6U6VteQqmBOOmQButETa6EnW01H9RHCkH8AtyMjLDrjKI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284149492"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="284149492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 23:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577321991"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="577321991"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2022 23:21:18 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] memblock test: Add test to memblock_reserve() 129th region
Date:   Tue, 11 Oct 2022 14:21:21 +0800
Message-Id: <20221011062128.49359-3-shaoqin.huang@intel.com>
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

Reserve 129th region in the memblock, and this will trigger the
memblock_double_array() function, this needs valid memory regions. So
using dummy_physical_memory_init() to allocate a valid memory region.
At the same time, reserve 128 faked memory region, and make sure these
reserved region not intersect with the valid memory region. So
memblock_double_array() will choose the valid memory region, and it will
success.

Also need to restore the reserved.regions after memblock_double_array(),
to make sure the subsequent tests can run as normal.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/tests/basic_api.c | 91 ++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 4d61a4b474be..c07a1ab0f19b 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -892,6 +892,96 @@ static int memblock_reserve_near_max_check(void)
 	return 0;
 }
 
+/*
+ * A test that trying to reserve the 129th memory block.
+ * Expect to trigger memblock_double_array() to double the
+ * memblock.memory.max, find a new valid memory as
+ * reserved.regions.
+ */
+static int memblock_reserve_many_check(void)
+{
+	int i;
+	void *orig_region;
+	struct region r = {
+		.base = SZ_16K,
+		.size = SZ_16K,
+	};
+	phys_addr_t memory_base = SZ_128K;
+	phys_addr_t new_reserved_regions_size;
+
+	PREFIX_PUSH();
+
+	reset_memblock_regions();
+	memblock_allow_resize();
+
+	/* Add a valid memory region used by double_array(). */
+	dummy_physical_memory_init();
+	memblock_add(dummy_physical_memory_base(), MEM_SIZE);
+
+	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
+		/* Reserve some fakes memory region to fulfill the memblock. */
+		memblock_reserve(memory_base, MEM_SIZE);
+
+		ASSERT_EQ(memblock.reserved.cnt, i + 1);
+		ASSERT_EQ(memblock.reserved.total_size, (i + 1) * MEM_SIZE);
+
+		/* Keep the gap so these memory region will not be merged. */
+		memory_base += MEM_SIZE * 2;
+	}
+
+	orig_region = memblock.reserved.regions;
+
+	/* This reserve the 129 memory_region, and makes it double array. */
+	memblock_reserve(memory_base, MEM_SIZE);
+
+	/*
+	 * This is the memory region size used by the doubled reserved.regions,
+	 * and it has been reserved due to it has been used. The size is used to
+	 * calculate the total_size that the memblock.reserved have now.
+	 */
+	new_reserved_regions_size = PAGE_ALIGN((INIT_MEMBLOCK_REGIONS * 2) *
+					sizeof(struct memblock_region));
+	/*
+	 * The double_array() will find a free memory region as the new
+	 * reserved.regions, and the used memory region will be reserved, so
+	 * there will be one more region exist in the reserved memblock. And the
+	 * one more reserved region's size is new_reserved_regions_size.
+	 */
+	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 2);
+	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE +
+						new_reserved_regions_size);
+	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	/*
+	 * Now memblock_double_array() works fine. Let's check after the
+	 * double_array(), the memblock_reserve() still works as normal.
+	 */
+	memblock_reserve(r.base, r.size);
+	ASSERT_EQ(memblock.reserved.regions[0].base, r.base);
+	ASSERT_EQ(memblock.reserved.regions[0].size, r.size);
+
+	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 3);
+	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE +
+						new_reserved_regions_size +
+						r.size);
+	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
+
+	dummy_physical_memory_cleanup();
+
+	/*
+	 * The current reserved.regions is occupying a range of memory that
+	 * allocated from dummy_physical_memory_init(). After free the memory,
+	 * we must not use it. So restore the origin memory region to make sure
+	 * the tests can run as normal and not affected by the double array.
+	 */
+	memblock.reserved.regions = orig_region;
+	memblock.reserved.cnt = INIT_MEMBLOCK_REGIONS;
+
+	test_pass_pop();
+
+	return 0;
+}
+
 static int memblock_reserve_checks(void)
 {
 	prefix_reset();
@@ -906,6 +996,7 @@ static int memblock_reserve_checks(void)
 	memblock_reserve_twice_check();
 	memblock_reserve_between_check();
 	memblock_reserve_near_max_check();
+	memblock_reserve_many_check();
 
 	prefix_pop();
 
-- 
2.34.1

