Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE42732258
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjFOWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjFOWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:01:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3EF2971;
        Thu, 15 Jun 2023 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866466; x=1718402466;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LdChvoFmNnlAlHfrYI7/8PGxZ7XvW/yi15/tTemhtfg=;
  b=GTxm7YErEpKjoyHoB3oScxINCTusKrDxfcI93Cax0r0Vmi7TQPIJ1oNH
   iTQsKC/O1TwPrlMTZrARA3rvOE7Lk8nReUzjpB6OV+K6xCl/G/ae2h3jX
   DFS24IE92Xpr0uh5263kZOM/yx+ybqM5VDLan01z6PuuuN+9WqXlCXCjJ
   mWA71fWDjlp8OGnRoyD/Y75qSf/r0R0hnAh7262Y6V2Q1/ql/lo7A1JVR
   aHB9r/Rd5WGZyyfz0ihr+DC6Y9SdsA96Dy57V9pq9aAFYIc7VVsXUIF1W
   dUYAgtCQsdtzZtE9p3eNA3qgPcNsI3oPzUp06RbyckEHRLD0igO7NFVhW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343791154"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343791154"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715770103"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715770103"
Received: from smaurice-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.120.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:02 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 15 Jun 2023 16:00:25 -0600
Subject: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
In-Reply-To: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=3515;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=LdChvoFmNnlAlHfrYI7/8PGxZ7XvW/yi15/tTemhtfg=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCndXTIrHz/Xtq+wu3jBMy+xfr7Z2f+L9vlN3p4Y4pMm5
 Fuz/uL9jlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEzEoZ2R4Z39gVmZulYpD7hq
 8jebSH29eWRVeLbZhgq57OPHdj2TtWL4p9A1+afr1TyLVbl3Vb3rfussnLe0fDf3Zh3pBRbef1J
 3cAIA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DAX memory regions originating from CXL memory expanders or
NVDIMMs, the kmem driver may be hot-adding huge amounts of system memory
on a system without enough 'regular' main memory to support the memmap
for it. To avoid this, ensure that all kmem managed hotplugged memory is
added with the MHP_MEMMAP_ON_MEMORY flag to place the memmap on the
new memory region being hot added.

To do this, call add_memory() in chunks of memory_block_size_bytes() as
that is a requirement for memmap_on_memory. Additionally, Use the
mhp_flag to force the memmap_on_memory checks regardless of the
respective module parameter setting.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/kmem.c | 49 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 7b36db6f1cbd..0751346193ef 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/memory-tiers.h>
+#include <linux/memory_hotplug.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -105,6 +106,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	data->mgid = rc;
 
 	for (i = 0; i < dev_dax->nr_range; i++) {
+		u64 cur_start, cur_len, remaining;
 		struct resource *res;
 		struct range range;
 
@@ -137,21 +139,42 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		res->flags = IORESOURCE_SYSTEM_RAM;
 
 		/*
-		 * Ensure that future kexec'd kernels will not treat
-		 * this as RAM automatically.
+		 * Add memory in chunks of memory_block_size_bytes() so that
+		 * it is considered for MHP_MEMMAP_ON_MEMORY
+		 * @range has already been aligned to memory_block_size_bytes(),
+		 * so the following loop will always break it down cleanly.
 		 */
-		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, MHP_NID_IS_MGID);
+		cur_start = range.start;
+		cur_len = memory_block_size_bytes();
+		remaining = range_len(&range);
+		while (remaining) {
+			mhp_t mhp_flags = MHP_NID_IS_MGID;
 
-		if (rc) {
-			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
-					i, range.start, range.end);
-			remove_resource(res);
-			kfree(res);
-			data->res[i] = NULL;
-			if (mapped)
-				continue;
-			goto err_request_mem;
+			if (mhp_supports_memmap_on_memory(cur_len,
+							  MHP_MEMMAP_ON_MEMORY))
+				mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+			/*
+			 * Ensure that future kexec'd kernels will not treat
+			 * this as RAM automatically.
+			 */
+			rc = add_memory_driver_managed(data->mgid, cur_start,
+						       cur_len, kmem_name,
+						       mhp_flags);
+
+			if (rc) {
+				dev_warn(dev,
+					 "mapping%d: %#llx-%#llx memory add failed\n",
+					 i, cur_start, cur_start + cur_len - 1);
+				remove_resource(res);
+				kfree(res);
+				data->res[i] = NULL;
+				if (mapped)
+					continue;
+				goto err_request_mem;
+			}
+
+			cur_start += cur_len;
+			remaining -= cur_len;
 		}
 		mapped++;
 	}

-- 
2.40.1

