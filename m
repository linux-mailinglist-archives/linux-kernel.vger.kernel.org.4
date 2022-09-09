Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7B5B33AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIIJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiIIJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:24:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC51177AC;
        Fri,  9 Sep 2022 02:23:09 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP9Qs26TTzmV5k;
        Fri,  9 Sep 2022 17:18:45 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:22:23 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 17:22:22 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] ACPI: HMAT: remove unused dev_fmt() and redundant prefixing 'HMAT'
Date:   Fri, 9 Sep 2022 17:56:24 +0800
Message-ID: <20220909095624.3719051-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macro dev_pmt() and redundant prefixing 'HMAT' from pr_*() calls.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/acpi/numa/hmat.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index c3d783aca196..23f49a2f4d14 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -9,7 +9,6 @@
  */
 
 #define pr_fmt(fmt) "acpi/hmat: " fmt
-#define dev_fmt(fmt) "acpi/hmat: " fmt
 
 #include <linux/acpi.h>
 #include <linux/bitops.h>
@@ -302,7 +301,7 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 	u8 type, mem_hier;
 
 	if (hmat_loc->header.length < sizeof(*hmat_loc)) {
-		pr_notice("HMAT: Unexpected locality header length: %u\n",
+		pr_notice("Unexpected locality header length: %u\n",
 			 hmat_loc->header.length);
 		return -EINVAL;
 	}
@@ -314,12 +313,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 	total_size = sizeof(*hmat_loc) + sizeof(*entries) * ipds * tpds +
 		     sizeof(*inits) * ipds + sizeof(*targs) * tpds;
 	if (hmat_loc->header.length < total_size) {
-		pr_notice("HMAT: Unexpected locality header length:%u, minimum required:%u\n",
+		pr_notice("Unexpected locality header length:%u, minimum required:%u\n",
 			 hmat_loc->header.length, total_size);
 		return -EINVAL;
 	}
 
-	pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
+	pr_info("Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
 		hmat_loc->flags, hmat_data_type(type), ipds, tpds,
 		hmat_loc->entry_base_unit);
 
@@ -363,13 +362,13 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 	u32 attrs;
 
 	if (cache->header.length < sizeof(*cache)) {
-		pr_notice("HMAT: Unexpected cache header length: %u\n",
+		pr_notice("Unexpected cache header length: %u\n",
 			 cache->header.length);
 		return -EINVAL;
 	}
 
 	attrs = cache->cache_attributes;
-	pr_info("HMAT: Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
+	pr_info("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
 		cache->memory_PD, cache->cache_size, attrs,
 		cache->number_of_SMBIOShandles);
 
@@ -424,24 +423,24 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 	struct memory_target *target = NULL;
 
 	if (p->header.length != sizeof(*p)) {
-		pr_notice("HMAT: Unexpected address range header length: %u\n",
+		pr_notice("Unexpected address range header length: %u\n",
 			 p->header.length);
 		return -EINVAL;
 	}
 
 	if (hmat_revision == 1)
-		pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
+		pr_info("Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->reserved3, p->reserved4, p->flags, p->processor_PD,
 			p->memory_PD);
 	else
-		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
+		pr_info("Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->flags, p->processor_PD, p->memory_PD);
 
 	if ((hmat_revision == 1 && p->flags & ACPI_HMAT_MEMORY_PD_VALID) ||
 	    hmat_revision > 1) {
 		target = find_mem_target(p->memory_PD);
 		if (!target) {
-			pr_debug("HMAT: Memory Domain missing from SRAT\n");
+			pr_debug("Memory Domain missing from SRAT\n");
 			return -EINVAL;
 		}
 	}
@@ -449,7 +448,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 		int p_node = pxm_to_node(p->processor_PD);
 
 		if (p_node == NUMA_NO_NODE) {
-			pr_debug("HMAT: Invalid Processor Domain\n");
+			pr_debug("Invalid Processor Domain\n");
 			return -EINVAL;
 		}
 		target->processor_pxm = p->processor_PD;
@@ -840,7 +839,7 @@ static __init int hmat_init(void)
 	case 2:
 		break;
 	default:
-		pr_notice("Ignoring HMAT: Unknown revision:%d\n", hmat_revision);
+		pr_notice("Ignoring: Unknown revision:%d\n", hmat_revision);
 		goto out_put;
 	}
 
@@ -848,7 +847,7 @@ static __init int hmat_init(void)
 		if (acpi_table_parse_entries(ACPI_SIG_HMAT,
 					     sizeof(struct acpi_table_hmat), i,
 					     hmat_parse_subtable, 0) < 0) {
-			pr_notice("Ignoring HMAT: Invalid table");
+			pr_notice("Ignoring: Invalid table");
 			goto out_put;
 		}
 	}
-- 
2.25.1

