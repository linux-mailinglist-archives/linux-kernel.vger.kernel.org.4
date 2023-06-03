Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B179720D22
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 04:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbjFCCJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 22:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbjFCCJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:09:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F734E63;
        Fri,  2 Jun 2023 19:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685758178; x=1717294178;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0hJMjkHkP89rfwhPu6kPTDLYbVJWhkUm9t7eLmXGvlc=;
  b=gTnsQsfrDhHK+u61fuRVfWkt7DSFABgpPsCiZbjOfuyrAT5uWfZXjUBs
   57xEMK/UoDKjzT1M0pWR65IJwvYJzmwEX+5aSR46CbW64cdiNxZCDXz5u
   Ea0RZUw+kXC8mso7phyxEPRJ4sfJo89ztaUgM2E8kEodnJXua9+rkT9uG
   J6YAx/RZDyTRN7AWdjkt4yZlvOTbuQdPiun/XxE+9slL4ZujuV3DCg4UG
   3ZJaeAEfDpV0NZatN6gZSRxpjdMTCrJxOMAcwdsPT6hMn31EB4Qxm0wUS
   KyLuD1U5nlB1tmDl1yhJXkOEs/43CZ5DJ723wychtKwWy5WlT7YsZzsmy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="340649457"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="340649457"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852354422"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="852354422"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.97.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:09:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 02 Jun 2023 19:09:24 -0700
Subject: [PATCH RFC 4/4] dax/bus: Remove unnecessary reference in
 alloc_dax_region()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-dax-region-put-v1-4-d8668f335d45@intel.com>
References: <20230602-dax-region-put-v1-0-d8668f335d45@intel.com>
In-Reply-To: <20230602-dax-region-put-v1-0-d8668f335d45@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Yongqiang Liu <liuyongqiang13@huawei.com>,
        Paul Cassella <cassella@hpe.com>, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685758165; l=3727;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=0hJMjkHkP89rfwhPu6kPTDLYbVJWhkUm9t7eLmXGvlc=;
 b=h+bWgJ3qSIdj/EAGT1xs+38BAs20p/pFFmvnjS5xGpX1ZfEYrwqiL/b98IYQKtcO0Pyp94reN
 TH2URAb3gZBAYVKG0d2P5cvNhWCAN5Z7GnIaqBSgYazRlbKWajzaBFp
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers to alloc_dax_region() maintain the device associated
with the dax_region until the dax_region is referenced by the dax_dev
they are creating.

Remove the extra kref that alloc_dax_region() takes.  Add a comment to
clarify the reference counting should additional callers be grown later.

Cc: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Paul Cassella <cassella@hpe.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/bus.c       | 13 ++++++-------
 drivers/dax/cxl.c       |  4 ----
 drivers/dax/hmem/hmem.c |  3 ---
 drivers/dax/pmem.c      |  8 +-------
 4 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 899e29d107b4..ed34d8aa6b26 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -583,7 +583,11 @@ static void dax_region_unregister(void *region)
 	dax_region_put(dax_region);
 }
 
-/* The dax_region reference returned should be dropped with dax_region_put() */
+/*
+ * Caller is responsible to ensure the parent device stays live while the
+ * returned dax_region is in use.  Or as is typically the case, a separate
+ * reference should be taken.
+ */
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
 		unsigned long flags)
@@ -626,13 +630,8 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		return NULL;
 	}
 
-	/* Hold a reference to return to the caller */
-	kref_get(&dax_region->kref);
-	if (devm_add_action_or_reset(parent, dax_region_unregister,
-				     dax_region)) {
-		kref_put(&dax_region->kref, dax_region_free);
+	if (devm_add_action_or_reset(parent, dax_region_unregister, dax_region))
 		return NULL;
-	}
 	return dax_region;
 }
 EXPORT_SYMBOL_GPL(alloc_dax_region);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index bbfe71cf4325..5ad600ee68b3 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -29,10 +29,6 @@ static int cxl_dax_region_probe(struct device *dev)
 		.size = range_len(&cxlr_dax->hpa_range),
 	};
 	dev_dax = devm_create_dev_dax(&data);
-
-	/* child dev_dax instances now own the lifetime of the dax_region */
-	dax_region_put(dax_region);
-
 	return IS_ERR(dev_dax) ? PTR_ERR(dev_dax) : 0;
 }
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index b4831a3d3934..46e1b343f26e 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -39,9 +39,6 @@ static int dax_hmem_probe(struct platform_device *pdev)
 		.size = region_idle ? 0 : range_len(&mri->range),
 	};
 	dev_dax = devm_create_dev_dax(&data);
-
-	/* child dev_dax instances now own the lifetime of the dax_region */
-	dax_region_put(dax_region);
 	return IS_ERR(dev_dax) ? PTR_ERR(dev_dax) : 0;
 }
 
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index f050ea78bb83..a4f016d7f4f5 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -13,7 +13,6 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	int rc, id, region_id;
 	resource_size_t offset;
 	struct nd_pfn_sb *pfn_sb;
-	struct dev_dax *dev_dax;
 	struct dev_dax_data data;
 	struct nd_namespace_io *nsio;
 	struct dax_region *dax_region;
@@ -65,12 +64,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 		.pgmap = &pgmap,
 		.size = range_len(&range),
 	};
-	dev_dax = devm_create_dev_dax(&data);
-
-	/* child dev_dax instances now own the lifetime of the dax_region */
-	dax_region_put(dax_region);
-
-	return dev_dax;
+	return devm_create_dev_dax(&data);
 }
 
 static int dax_pmem_probe(struct device *dev)

-- 
2.40.0

