Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2260F0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiJ0HAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiJ0G7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:59:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF2DF5BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666853980; x=1698389980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V14uG5yjLb6jlXg9bU1RN+1W4f8+KLhPzp7C9u7WGug=;
  b=WJSPINb2jE75FhasQPI+Jj8BjAXLIIKUPlwsTL8YxH9UBiBUBRp+b3K4
   pgP/UbtGwi0clDzCVWW/LZL1NBL9xyqGxJCE76cV1eA2Q8Vh3Pm6n7yF0
   92/BFQDQX/Yvndeh5KwNwduawtudeRk/aVeNmYrX1N/WAvGRGMzTIzuM9
   zsaMoShXRLRbZHCbz69VSByh5t7gYKegZYWivY9Tw5Yhn0C8qYo8NG90C
   A/2TJfoVIEzd1ffLJ+r7Q6gT8edQl0e7adS2KMPJudOUWQ1FtFMCwPHPO
   fFdNJIyqzAJU3k2DjVD/KA6CCluxIzXT08UiZXbGjXXulADZw+w1vVMLR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="291449137"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="291449137"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 23:59:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="774884708"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="774884708"
Received: from yunfeima-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.212.241])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 23:59:35 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [RFC] memory tiering: use small chunk size and more tiers
Date:   Thu, 27 Oct 2022 14:59:25 +0800
Message-Id: <20221027065925.476955-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need some way to override the system default memory tiers.  For
the example system as follows,

type		abstract distance
----		-----------------
HBM		300
DRAM		1000
CXL_MEM		5000
PMEM		5100

Given the memory tier chunk size is 100, the default memory tiers
could be,

tier		abstract distance	types
                range
----		-----------------       -----
3		300-400			HBM
10		1000-1100		DRAM
50		5000-5100		CXL_MEM
51		5100-5200		PMEM

If we want to group CXL MEM and PMEM into one tier, we have 2 choices.

1) Override the abstract distance of CXL_MEM or PMEM.  For example, if
we change the abstract distance of PMEM to 5050, the memory tiers
become,

tier		abstract distance	types
                range
----		-----------------       -----
3		300-400			HBM
10		1000-1100		DRAM
50		5000-5100		CXL_MEM, PMEM

2) Override the memory tier chunk size.  For example, if we change the
memory tier chunk size to 200, the memory tiers become,

tier		abstract distance	types
                range
----		-----------------       -----
1		200-400			HBM
5		1000-1200		DRAM
25		5000-5200		CXL_MEM, PMEM

But after some thoughts, I think choice 2) may be not good.  The
problem is that even if 2 abstract distances are almost same, they may
be put in 2 tier if they sit in the different sides of the tier
boundary.  For example, if the abstract distance of CXL_MEM is 4990,
while the abstract distance of PMEM is 5010.  Although the difference
of the abstract distances is only 20, CXL_MEM and PMEM will put in
different tiers if the tier chunk size is 50, 100, 200, 250, 500, ....
This makes choice 2) hard to be used, it may become tricky to find out
the appropriate tier chunk size that satisfying all requirements.

So I suggest to abandon choice 2) and use choice 1) only.  This makes
the overall design and user space interface to be simpler and easier
to be used.  The overall design of the abstract distance could be,

1. Use decimal for abstract distance and its chunk size.  This makes
   them more user friendly.

2. Make the tier chunk size as small as possible.  For example, 10.
   This will put different memory types in one memory tier only if their
   performance is almost same by default.  And we will not provide the
   interface to override the chunk size.

3. Make the abstract distance of normal DRAM large enough.  For
   example, 1000, then 100 tiers can be defined below DRAM, this is
   more than enough in practice.

4. If we want to override the default memory tiers, just override the
   abstract distances of some memory types with a per memory type
   interface.

This patch is to apply the design choices above in the existing code.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Hesham Almatary <hesham.almatary@huawei.com>
Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 include/linux/memory-tiers.h | 7 +++----
 mm/memory-tiers.c            | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 965009aa01d7..2e39d9a6c8ce 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -7,17 +7,16 @@
 #include <linux/kref.h>
 #include <linux/mmzone.h>
 /*
- * Each tier cover a abstrace distance chunk size of 128
+ * Each tier cover a abstrace distance chunk size of 10
  */
-#define MEMTIER_CHUNK_BITS	7
-#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
+#define MEMTIER_CHUNK_SIZE	10
 /*
  * Smaller abstract distance values imply faster (higher) memory tiers. Offset
  * the DRAM adistance so that we can accommodate devices with a slightly lower
  * adistance value (slightly faster) than default DRAM adistance to be part of
  * the same memory tier.
  */
-#define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
+#define MEMTIER_ADISTANCE_DRAM	((100 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE / 2))
 #define MEMTIER_HOTPLUG_PRIO	100
 
 struct memory_tier;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fa8c9d07f9ce..e03011428fa5 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -165,11 +165,10 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 	bool found_slot = false;
 	struct memory_tier *memtier, *new_memtier;
 	int adistance = memtype->adistance;
-	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
-	adistance = round_down(adistance, memtier_adistance_chunk_size);
+	adistance = rounddown(adistance, MEMTIER_CHUNK_SIZE);
 	/*
 	 * If the memtype is already part of a memory tier,
 	 * just return that.
@@ -204,7 +203,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 	else
 		list_add_tail(&new_memtier->list, &memory_tiers);
 
-	new_memtier->dev.id = adistance >> MEMTIER_CHUNK_BITS;
+	new_memtier->dev.id = adistance / MEMTIER_CHUNK_SIZE;
 	new_memtier->dev.bus = &memory_tier_subsys;
 	new_memtier->dev.release = memory_tier_device_release;
 	new_memtier->dev.groups = memtier_dev_groups;
@@ -641,7 +640,7 @@ static int __init memory_tier_init(void)
 #endif
 	mutex_lock(&memory_tier_lock);
 	/*
-	 * For now we can have 4 faster memory tiers with smaller adistance
+	 * For now we can have 100 faster memory tiers with smaller adistance
 	 * than default DRAM tier.
 	 */
 	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
-- 
2.35.1

