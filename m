Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FA75006A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGLHt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGLHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:49:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB21BE5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689148173; x=1720684173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WgH5xLOkBW2Y/oZqJhHhP4ppJv8kSHk1fii5X3wpokk=;
  b=frTpFi+hRbB7igPVzLdH8Dl29Gnm342nilq9/Hd+EJzahUlRi+w98OIz
   f15La4HTkRhNZD0aqtxl5fBNLccgwY16Xdr424t5qIKPf5i7MOQtzFGst
   F3YOW7/dMbfau5yjmSSd4MSmz90a2efZ3qaU8ZmPQxLnHynvLhTZzEVte
   e5Olwoa9mAdXZgdPBNjlkOSz2K0z6jaf0Z0QniW7vTa5uIICI11MECQvd
   ZAVrk8l7zTCqrItEYrS+te/TSsQnkBd0LC4SkYnnR+y145E5c/OMtRH5d
   9UK85e+jc5gNtFZvaPDSER8uhkGtU4/te7/1c/oWVQZbJylxzL0a4ofVz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354734622"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="354734622"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 00:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="698744941"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="698744941"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 00:49:28 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH 4/4] dax, kmem: calculate abstract distance with general interface
Date:   Wed, 12 Jul 2023 15:49:00 +0800
Message-Id: <20230712074900.404064-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712074900.404064-1-ying.huang@intel.com>
References: <20230712074900.404064-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
used for slow memory type in kmem driver.  This limits the usage of
kmem driver, for example, it cannot be used for HBM (high bandwidth
memory).

So, we use the general abstract distance calculation mechanism in kmem
drivers to get more accurate abstract distance on systems with proper
support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
fallback only.

Now, multiple memory types may be managed by kmem.  These memory types
are put into the "kmem_memory_types" list and protected by
kmem_memory_type_lock.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/dax/kmem.c           | 54 +++++++++++++++++++++++++++---------
 include/linux/memory-tiers.h |  2 ++
 mm/memory-tiers.c            |  2 +-
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 898ca9505754..837165037231 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -49,14 +49,40 @@ struct dax_kmem_data {
 	struct resource *res[];
 };
 
-static struct memory_dev_type *dax_slowmem_type;
+static DEFINE_MUTEX(kmem_memory_type_lock);
+static LIST_HEAD(kmem_memory_types);
+
+static struct memory_dev_type *kmem_find_alloc_memorty_type(int adist)
+{
+	bool found = false;
+	struct memory_dev_type *mtype;
+
+	mutex_lock(&kmem_memory_type_lock);
+	list_for_each_entry(mtype, &kmem_memory_types, list) {
+		if (mtype->adistance == adist) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		mtype = alloc_memory_type(adist);
+		if (!IS_ERR(mtype))
+			list_add(&mtype->list, &kmem_memory_types);
+	}
+	mutex_unlock(&kmem_memory_type_lock);
+
+	return mtype;
+}
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
 	unsigned long total_len = 0;
 	struct dax_kmem_data *data;
+	struct memory_dev_type *mtype;
 	int i, rc, mapped = 0;
 	int numa_node;
+	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -71,6 +97,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
+	mt_calc_adistance(numa_node, &adist);
+	mtype = kmem_find_alloc_memorty_type(adist);
+	if (IS_ERR(mtype))
+		return PTR_ERR(mtype);
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
@@ -88,7 +119,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
-	init_node_memory_type(numa_node, dax_slowmem_type);
+	init_node_memory_type(numa_node, mtype);
 
 	rc = -ENOMEM;
 	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
@@ -167,7 +198,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 err_res_name:
 	kfree(data);
 err_dax_kmem_data:
-	clear_node_memory_type(numa_node, dax_slowmem_type);
+	clear_node_memory_type(numa_node, mtype);
 	return rc;
 }
 
@@ -219,7 +250,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		 * for that. This implies this reference will be around
 		 * till next reboot.
 		 */
-		clear_node_memory_type(node, dax_slowmem_type);
+		clear_node_memory_type(node, NULL);
 	}
 }
 #else
@@ -251,12 +282,6 @@ static int __init dax_kmem_init(void)
 	if (!kmem_name)
 		return -ENOMEM;
 
-	dax_slowmem_type = alloc_memory_type(MEMTIER_DEFAULT_DAX_ADISTANCE);
-	if (IS_ERR(dax_slowmem_type)) {
-		rc = PTR_ERR(dax_slowmem_type);
-		goto err_dax_slowmem_type;
-	}
-
 	rc = dax_driver_register(&device_dax_kmem_driver);
 	if (rc)
 		goto error_dax_driver;
@@ -264,18 +289,21 @@ static int __init dax_kmem_init(void)
 	return rc;
 
 error_dax_driver:
-	destroy_memory_type(dax_slowmem_type);
-err_dax_slowmem_type:
 	kfree_const(kmem_name);
 	return rc;
 }
 
 static void __exit dax_kmem_exit(void)
 {
+	struct memory_dev_type *mtype, *mtn;
+
 	dax_driver_unregister(&device_dax_kmem_driver);
 	if (!any_hotremove_failed)
 		kfree_const(kmem_name);
-	destroy_memory_type(dax_slowmem_type);
+	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
+		list_del(&mtype->list);
+		destroy_memory_type(mtype);
+	}
 }
 
 MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 9377239c8d34..aca22220cb5c 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -24,6 +24,8 @@ struct memory_tier;
 struct memory_dev_type {
 	/* list of memory types that are part of same tier as this type */
 	struct list_head tier_sibiling;
+	/* list of memory types that are managed by one driver */
+	struct list_head list;
 	/* abstract distance for this specific memory type */
 	int adistance;
 	/* Nodes of same abstract distance */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 9a734ef2edfb..38005c60fa2d 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -581,7 +581,7 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 {
 	mutex_lock(&memory_tier_lock);
-	if (node_memory_types[node].memtype == memtype)
+	if (node_memory_types[node].memtype == memtype || !memtype)
 		node_memory_types[node].map_count--;
 	/*
 	 * If we umapped all the attached devices to this node,
-- 
2.39.2

