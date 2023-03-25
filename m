Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556216C8FEA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCYRyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCYRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:54:02 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B095BE190
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOoMn/MCxjiap1g9vzszfTBbHKt4TTG2dtrzCEQAdGc8mXjCQ1mTJygaZA/8ktJ5at8n9YHaLUPdRiFwrOEQLwg8KxyjOIxOCIdE6PYikmmNmjXR9ek/MRfuQwKVLuen0BN3l0jVI2NdvpOFiV0JzoZN+imldbhLhMfmLe1uy+gyp6MzedZPt0mt57GNB3OwCqb6IK5c9eVXi9/8PKorLgB68g6HBm7OWeV/4mvHGvceHzk5le9DWD+CgA0jw8Rhv0+CFBKW3n71SN41g30m/Mkk/l/TdcU1I7NFdO1BXHrGxqcfNfkilY6BzU5mCoMXyPvsLZ/fWGpFR5/bPFFc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ4TDw78HgpYLN6SMzdVuCCWaip9zjb3EAurMhRfIow=;
 b=LLfH0z1nEofILlZVE3xmVgHKNnD/aAwkMElaiekTLkzPdTRy3pHZ14LibKhC1+TfjZzXQnmFZwhddTxeuNhWxcHu4ZpjExGY+GgxpVjcWk4G3fepHjnoSmSD3cvZU0LyxJgr66V9+nzRFcsuDNZL7vTyDPSiQhUoVRHVs8NBgDQ/vmh2XrEl7COSBXXH7RbEGMdKcURhFUiYny+armyZ56FdLI5YH4b4/dxdjRUu/zaZhSPraCjfubm/Tr8t+RSwvGq5xYKNMcDs9mLCjb5a9BAvG3F8mtJh31pXzS6LpjQ7ROpbNe5Z5WDKNRQtpPvhBo8Q/DQJ7vNQK98MnomYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ4TDw78HgpYLN6SMzdVuCCWaip9zjb3EAurMhRfIow=;
 b=ixyQFAvgF5BztXtZ1NZku3LT5lr95pnuTtASBd4hLD2NAiraDdgdHgDCfiUBAFFkJ2ftP+oO19hyWvqBkPrByxVe+XSr4vnR8+1C9YTbIkIoYcRPkXuXu4l7B8lJsThNuJaokEeSN6w2jCVnLyMl0pSGiOS+95AC/SI0d1fQ3y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BYAPR21MB1336.namprd21.prod.outlook.com (2603:10b6:a03:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.9; Sat, 25 Mar
 2023 17:53:57 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%3]) with mapi id 15.20.6254.009; Sat, 25 Mar 2023
 17:53:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water mark in debugfs
Date:   Sat, 25 Mar 2023 10:53:10 -0700
Message-Id: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:303:b6::30) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|BYAPR21MB1336:EE_
X-MS-Office365-Filtering-Correlation-Id: 75182aaa-b389-4fb6-c8cb-08db2d59e824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/Vvmqjkv6igfBsYOTG0yUN4OY8KY1rO8qr3MpskAxWPWtFBi3q5HiL4zYWos2vl4scUZP9cB8FgnTgNzqvr7geJ0Q5Abn0LEEbLBQmpqJE4IbZOi8+LMEfjbq6hERKcSl1mvxrnquwmkb694dz2ub/J8hzKDmxlP6GZA4ZiIuG6uLjWbZGK5GjFI2y2prri2Uy8HBgzOz8hBRnee90rfJ1ZNPgZbuxWZ51pjmG6fqAeGMfeDujIBREV6TzT7IHvr640tAVAiTlYfzX8IYZjdEYaYEN/3CoXpxu+3CZ9/IzYGlmjwVlt6rLc3NJgolPp19TrlyJHe+EEvhL7vGCpnJkQiAhOBDTzGZC+twLBrpoifkwltxcmh+XOggXqsEA8UUdpweIOG+bVFJ0haxaF+NuH/FV7MXD9TuOpRyT+s437GipoqONJ2tOcMaBVpvPTOmkHP8qp/kyZjd/lucTOH5UFgcwgmLAwc82wNTKjvmzcIskWtJH9od5QQGeh5NzgJV40DXUVK2KnDKfa1w/UtqURHSA+6FDxjAAZoqCJN8VjTLGsG/bATf8PcxACBcjJSMALHsWBZz05L9YP4PzWz+cKybth5BzswbRFwew9iBQ3Xw4v2K8bSoCdq5/xUsrTn0szjA5J4FeKpTUbI29fSOe97SQ3am3DrlYIwOMDSvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(82960400001)(38100700002)(38350700002)(86362001)(36756003)(83380400001)(66946007)(6506007)(52116002)(26005)(82950400001)(186003)(41300700001)(2906002)(8676002)(5660300002)(6666004)(8936002)(4326008)(66556008)(107886003)(2616005)(478600001)(66476007)(10290500003)(6486002)(6512007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+oE9kEHd9kYy4umdOTif+oKIWLqeILygSxrIV8ldH64XcHKkEqDq9vXSFkPg?=
 =?us-ascii?Q?/0ONWisiSJOUmiNBM/p+RtWUw1R6Ao/lUDykqROOefEtByd8xdcX8GKm/OOv?=
 =?us-ascii?Q?Loqz0fMJtsKUEDjdUD/oDQNBPEBsNSNzNiGcuYNV1ArYgfOB6FnfOfNPB7QD?=
 =?us-ascii?Q?VJWlyCTbSD89Zq77QmBORsTA5TgVvlW3oE1VDaocENnHlzXJEY7GoRdrG7O2?=
 =?us-ascii?Q?9JSWDfVNcVCCampidQXGvwYe44b2HakzxZ6/GPoBg0ZuxqRA3c5pOpGrdiKc?=
 =?us-ascii?Q?DNLA4FqcgDuXrBfBhCy9Et1x1eu4amPF3bcq8XFjPTJtSEWlXx29r9KHpf3+?=
 =?us-ascii?Q?O3QxtRu+9HRjnhDqyRIhYYlWSGcaWfrXg+c5EkvS80/oGbVSGCp9zuEdMPtJ?=
 =?us-ascii?Q?UFVRvQzoJi89CZOq2RBkFDbHmTzNhBZPJk4T+0soRy0dEGsOg3RtfAp7fqSt?=
 =?us-ascii?Q?L9PMBP13ksAaGBSBVAy+zOeFXNnnGpCxe3Vnl7t+gwQ5Qc+pHRVJ9wG+onDg?=
 =?us-ascii?Q?wIItBlo2l9cCv89Fi66G9DgowMakSksgGqS8n3C7S+waJF0S4cKzEZGu31hN?=
 =?us-ascii?Q?fyf+KX8qE92EsePDtQRrD4oEt0D1ZPibUKzBGPoh+QqxGvw6cyb51fTgQzek?=
 =?us-ascii?Q?JqhzsT3tXdlhDAMVqM3eMOR+Faw437WUiBBgQg/ZVz1iD7EQYqh9aLSJOU8h?=
 =?us-ascii?Q?7Md9l3TcdKhqKdMizpcMdmqH+I3HL/N7jYysAcF19KHyeBUd6hfv5Kvn/sGo?=
 =?us-ascii?Q?yRq4mBzyQrF31RgePO1/m1YRwtVyFXRrjjPaHhu+RItIgwP7qLvk5Ny0oM4M?=
 =?us-ascii?Q?q9crFVQb24PDDb0D+OO+PbsEpwQNffCVKcsRQ7I7FNMcj0Hpw5hdbMrC/jph?=
 =?us-ascii?Q?q1F038WW5W3jli1+aUWXGDn/P6zbXIYF5VzdFyYPCqnIv2fsohighcESMNa7?=
 =?us-ascii?Q?VHvHE9wzEPgREx1ThPOhqM91EjHdeu80V4axCjvn+exZvJ76rRguz65pzNzb?=
 =?us-ascii?Q?7Htn0SYZE5+RvHGCWBXkPDIOlWOqU5PIDABbKirOiwoXWfkQHH/5D7HvY9xZ?=
 =?us-ascii?Q?58eMNxiW5AA8rVMNIumsBItn/ABtNidyP+jIe6Urp1y93FUvB6KTcQaj5VaC?=
 =?us-ascii?Q?xcm+Oa0pt5Z4GJ6Cz90UfX9TxChD1BCO0ecISmOmrZ2kdnriVLDBr5zLhEya?=
 =?us-ascii?Q?HtaQciIAf6MYdtwmaOs5kftiw4Y/emFsWtkvxRmZ4qYkfRoRrRLe1oN0NwBF?=
 =?us-ascii?Q?iKOgBMMmHmpyj/ERQSK+AnzgC8YWV9aeydYpSKxqRSysOkMwhmFyONu2h299?=
 =?us-ascii?Q?0Qtl9PiXGUBt7yP8NtOewU+VsQ+FzGx4MOUOsYVVct/CpAZj/ArXGy2Py/ZV?=
 =?us-ascii?Q?snvVIxaczudmZkZGJftM3BOAVpf3xZfHAAQPsuSwtbSV0pJZzCiBW/wm6AKb?=
 =?us-ascii?Q?UZcAGyGUiB7bN6jL9XAb0SYPVA29e64eST+2TG8+YZoIczpXrGHLTG5ovAL7?=
 =?us-ascii?Q?/pqU6aDozsojTxDXXIPDYKgma+gkhfCJnIN0Q7XMHvBEg4w3Bf/QfXNLzFar?=
 =?us-ascii?Q?BOwoHjCoWDYbAdQDjt4cBY1e/kkffUHlKQZmgXSi?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75182aaa-b389-4fb6-c8cb-08db2d59e824
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 17:53:57.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvP2FsYtncDPnL4lw930SYpTcIqekCOilpZy70JwFbjCpjMkMhC/eQyaSTa3OBIYcuZpiZkKDXdRwu9TW81b9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1336
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swiotlb currently reports the total number of slabs and the instantaneous
in-use slabs in debugfs. But with increased usage of swiotlb for all I/O
in Confidential Computing (coco) VMs, it has become difficult to know
how much memory to allocate for swiotlb bounce buffers, either via the
automatic algorithm in the kernel or by specifying a value on the
kernel boot line. The current automatic algorithm generously allocates
swiotlb bounce buffer memory, and may be wasting significant memory in
many use cases.

To support better understanding swiotlb usage, add tracking of the
the high water mark usage of swiotlb bounce buffer memory. Report the
high water mark in debugfs along with the other swiotlb metrics.  Allow
the high water to be reset to zero at runtime by writing to it.

Since a global in-use slab count is added alongside the existing
per-area in-use count, the mem_used() function that sums across all
areas is no longer needed.  Remove it and replace with the global
in-use count.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Changes in v2:
* Only reset the high water mark to zero when the specified new value
  is zero, to prevent confusion about the ability to reset to some
  other value [Dexuan Cui]

---
 kernel/dma/swiotlb.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f9f0279..3e50639 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -76,6 +76,9 @@ struct io_tlb_slot {
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
 
+static atomic_long_t total_used = ATOMIC_LONG_INIT(0);
+static atomic_long_t used_hiwater = ATOMIC_LONG_INIT(0);
+
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
  *
@@ -587,6 +590,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	unsigned long flags;
 	unsigned int slot_base;
 	unsigned int slot_index;
+	unsigned long old_hiwater, new_used;
 
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= mem->nareas);
@@ -659,6 +663,14 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	area->index = wrap_area_index(mem, index + nslots);
 	area->used += nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
+
+	new_used = atomic_long_add_return(nslots, &total_used);
+	old_hiwater = atomic_long_read(&used_hiwater);
+	do {
+		if (new_used <= old_hiwater)
+			break;
+	} while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater, new_used));
+
 	return slot_index;
 }
 
@@ -681,16 +693,6 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	return -1;
 }
 
-static unsigned long mem_used(struct io_tlb_mem *mem)
-{
-	int i;
-	unsigned long used = 0;
-
-	for (i = 0; i < mem->nareas; i++)
-		used += mem->areas[i].used;
-	return used;
-}
-
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		unsigned int alloc_align_mask, enum dma_data_direction dir,
@@ -723,7 +725,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-				 alloc_size, mem->nslabs, mem_used(mem));
+				 alloc_size, mem->nslabs, atomic_long_read(&total_used));
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
@@ -791,6 +793,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		mem->slots[i].list = ++count;
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
+
+	atomic_long_sub(nslots, &total_used);
 }
 
 /*
@@ -887,10 +891,29 @@ bool is_swiotlb_active(struct device *dev)
 
 static int io_tlb_used_get(void *data, u64 *val)
 {
-	*val = mem_used(&io_tlb_default_mem);
+	*val = (u64)atomic_long_read(&total_used);
 	return 0;
 }
+
+static int io_tlb_hiwater_get(void *data, u64 *val)
+{
+	*val = (u64)atomic_long_read(&used_hiwater);
+	return 0;
+}
+
+static int io_tlb_hiwater_set(void *data, u64 val)
+{
+	/* Only allow setting to zero */
+	if (val != 0)
+		return -EINVAL;
+
+	atomic_long_set(&used_hiwater, val);
+	return 0;
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_hiwater, io_tlb_hiwater_get,
+				io_tlb_hiwater_set, "%llu\n");
 
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
@@ -902,6 +925,8 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, NULL,
 			&fops_io_tlb_used);
+	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, NULL,
+			&fops_io_tlb_hiwater);
 }
 
 static int __init __maybe_unused swiotlb_create_default_debugfs(void)
-- 
1.8.3.1

