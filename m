Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489CC5B6812
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIMGmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiIMGmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:42:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DF58526
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663051331; x=1694587331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4y1rYIKX4fqF3zCci/fAjCkU8Jw0wyitSdCTFzi5Ss=;
  b=mjSob+YMQYY64k3ihyki+pZfl863gax3uHEjNt2/LFUbjM7KgfQV0CMI
   e1JsANF+WLhlHPLUZL6UmH1pwOuFf7WHhM5sgZJ2L9yIagDQIAE7f6Kmt
   NTVzMysNuxmVzv0TYZfmgzTy+vPAFOfm1tp7Dlqxthp4KLzGFCgq02PJx
   UGrJIrsrS9bHgpKrYWv+d7ryZu37wzzXLDmQQAn0SWDLAC7ODY6O2nJZY
   nWdeV3V6kkCRnib5B3FFIf0XlHMxK6mOdEFGf8nrPA8OnQlW9TCQJvEmu
   0kqdbjzm47icjKmow91RVNIuS6oRb6u5ujoHfzKkDs6Tvg85OmuuSRCnh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324296478"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="324296478"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678428866"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 12 Sep 2022 23:41:53 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] memblock test: Add test to memblock_reserve() 129th region
Date:   Tue, 13 Sep 2022 14:41:31 +0800
Message-Id: <20220913064138.407601-3-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913064138.407601-1-shaoqin.huang@intel.com>
References: <20220913064138.407601-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 tools/testing/memblock/tests/basic_api.c | 90 ++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 7120fd8e47b1..1924524ad868 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -895,6 +895,95 @@ static int memblock_reserve_near_max_check(void)
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
+		.size = MEM_SIZE,
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
+	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE +
+						new_reserved_regions_size);
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
@@ -909,6 +998,7 @@ static int memblock_reserve_checks(void)
 	memblock_reserve_twice_check();
 	memblock_reserve_between_check();
 	memblock_reserve_near_max_check();
+	memblock_reserve_many_check();
 
 	prefix_pop();
 
-- 
2.34.1

