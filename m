Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B496E13CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDMR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:58:00 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590D171F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBMwId5S7AdHutn+3CWGyOh/bneFF8BNYGphT84iweWHE5+V6LXpzVN16N80kUbBNmCNkYIEGVNXcwWH3U+NOwPWb/lFSUxBPJY3e/Bt22IP8bMoZdq6vrqPltTEMgR55vm2mkHgfElENIEhAOv6aaKqMU0o9luG3OL7qFhUke+nwWtCvm01IxE0XUrTb2Fb0sM42nP/zwUa0SxuHsaftdoVTkua0Lj9XzOnQzqPzOhvOBhaFixR9mU3UlOSPeP1AjECWH9eQYduXpY1aSNnYAiCswogRs/AtcVV+S+T+0AhleKyrqND/mhWUnZaukGrXkw/NjsHARIjmE1SHcawLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo8yGxXdUvySDCRJdDK24a47E76hT8Ht2tAm5iorA4w=;
 b=kouJMsd49qgPgvstu9B3189UG/oAujC7fzz3dpqCg86Fb/8dS64a4hqsCqAoz8qiA8f6brPr0lJFVGhZ+9qWLa5vnPHzaFKK3zSD9lDcxGx5dJmZvyoPguYZBM+d9i4Xa4MW8JbPa9NR1+dBu4ut+DqOU1DjfStzUZw5uURY2wJwPnxmrUS1nEyoShkLyS6ehMEH18xjId91Bkqn6kAijuHlmtlbLHje/czJz0sscsw5FJP91qHvz4ttDZJe//hmc0J5/CcBJqKqEEjNswpnWrilRmnhm93grJhvP2Jpn/TLn6PIY9ScVgP66UEa5mhFDlv0ab4rcqwWOTdxRYpsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo8yGxXdUvySDCRJdDK24a47E76hT8Ht2tAm5iorA4w=;
 b=Oiuoj4hQMqqy4OqhVIhWAKoriIVl9vOBb3ixzcm0eCcmwYqUJa4WfnglzuJVpMar4X3m5Vl7xv4At16tvdyOnl1dOXXF+poxnYUXJrcQpkldg6z9WLoerJtOWxCIrx7iwkjxdlk+55gNDI87+x2LDGPav+kOpHFQ3VhEylKwYVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1500.namprd21.prod.outlook.com (2603:10b6:5:25f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.6; Thu, 13 Apr
 2023 17:57:56 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%3]) with mapi id 15.20.6319.006; Thu, 13 Apr 2023
 17:57:56 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com,
        petr.tesarik.ext@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v4 1/1] swiotlb: Track and report io_tlb_used high water marks in debugfs
Date:   Thu, 13 Apr 2023 10:57:37 -0700
Message-Id: <1681408657-2172-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|DM6PR21MB1500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb0f3f4-998f-4962-fbe7-08db3c489c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5PNClqxhCTGxU+3bYxr3HbWNzwu2R0FiyU+JTvHHxSaQLSJ4MjEV7TMYdzjI5JYLu/WeeOQmCY0MqZvwQ9qJ3hSuqYE3582FSf9jT5f7oEixmEk8jMgBwS7B53ZL8bMiztFIK8TRLobSbs/Wc+PzpQNPDCtug1t+MofIQ+rlqoKfU9RU4qJD+SZAVvZ06kXR8UVqy6J6Qjhr8M6yNO7+Qet3PgyB/lv1cAiXvWOifqMgMB60G0vEExuY2w07I6Ju8rUMzPeQhK56a2L21zsKkQv5Qebm0Y1591prbiQgn9e29u1Q8KlJaGWoBRKBn6T8aObODyn5bvLKIJqovrn51Hw6bfyA1BZPHD4AgSxiU49g6oX7yuuKup8phiGXrxwfVGFaBLG0FLcvGJHFU8EQRiQYBoMbXDGaJ1Y2/iTfZ8h1u9hW2/FVU3v3XY9de1inh0yh94HrPYtNB2Pt24rVOecrfbMHBKrPaetBAXNoseyO8yIbll6zDVS3hKYq1Qy+KfP9Y6dTEOK1Vsg8Gq8EtC93k5D+9dVYIJaC7A2QAX7XYz1ajhtxrwJpmCCSfEGjfnmy+fY6A0PebxbbnF2Dy0AIGmUDJdeaYjXhNXHfb+Dtt94EnHtsXi5QvWyOXakcXR0964K6SObX8qwWqUuXseLPM5VM1HKtthq40bTS38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(6666004)(83380400001)(2616005)(186003)(6512007)(6506007)(26005)(86362001)(66476007)(66556008)(8676002)(82950400001)(66946007)(38100700002)(38350700002)(2906002)(82960400001)(4326008)(41300700001)(316002)(786003)(107886003)(478600001)(10290500003)(6486002)(8936002)(5660300002)(52116002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFqd3lW6EGRSgs1Ki3d8BqJFHeLC8/eBXSVZFxrsKkX0kUV/+9FKAo+xlqjq?=
 =?us-ascii?Q?EsDjEpdr3mbc/Re+VzIV0Cewm4GhI321eTKc/W/9TQGElrQAM/qpvbRv1TOO?=
 =?us-ascii?Q?jJbazJ54n041iOPW/Jtp1ADyp6j2uWto5jek0zzDM7+QVn/xgqJ6hooh0Cv1?=
 =?us-ascii?Q?/NiPVtnSRg5D5SUGXpQR1HtfbEPT0VafHK+wgpZp0xyZXNFK/WnFWTT1ABCh?=
 =?us-ascii?Q?hD/sR4H+zqaStujVNJP56e9SFg79W4gJsARdmpCBzkwZAtLf2o1MELzEMXTI?=
 =?us-ascii?Q?w4CkdFkO96afWjlEqIP0J7QHiffjf4m430c3per3ey3IsxxP3Jjz++rzeNrO?=
 =?us-ascii?Q?CvEQ2dxxZhgvu8ifNfU7DwbBlIgBHfHzkD9OiqCX+3l98/HqTklUYDEdQ/Lj?=
 =?us-ascii?Q?OIafeRWvBRf9v61OB54qAosAap3T1LMeOFS5LnIxvUp/rfujJsEUByHl2q+6?=
 =?us-ascii?Q?S7u9AJCxUmUPty++0TdNc7qicJNsKnt5ObNJvyDmrG6k4oGUQRchkmzA6tpf?=
 =?us-ascii?Q?EpOFAVECLj8r0fqAWbF52qFdlrGLSurOfDBcVymSulNolV8T4BEBfu9rv9Yw?=
 =?us-ascii?Q?rNwBgUprg38crV5/WqmiLWrkPTZZIJIfvgxhK+vMoPhLXXf+tg1Axp/5Ixzn?=
 =?us-ascii?Q?2Wjggv7+kKmtTjxgda1Uda/LK5fXxESLL2S3XwSWp8XtQ0mrY+Yau9LS5rth?=
 =?us-ascii?Q?qxXlzx9g3jPCYAdEj8cgFe8YNvHt2S/izlqn4ww84ozFI1k7tM4mlFzGW4dd?=
 =?us-ascii?Q?FLh+1Sz99rBNBZsoq8DGG1nacM/8FggLjQ9vgR0U4OcqiJCvGtMfT2fst9Eb?=
 =?us-ascii?Q?FfRl5EZagfxblP/+xvGkaG28ego/gZUNKgUvZj3ac2xrj6tCkh/sfZLg+XHk?=
 =?us-ascii?Q?hyCVyM+bWEwgdyA5BERJ72f5l66a6+66uVUj+J5wTwYDHdYlieiIfZPbfJsh?=
 =?us-ascii?Q?LgHQkZ1J+LYqB7MRlTlpZCHFcv7JvVdUIptJSJ30kWEtbsvOU48hhQPei/na?=
 =?us-ascii?Q?2NEECY4Rhm/2IS1Ahree4e0cZ9dE74mMYjmL+L2paR+wwz2eGUlcxA9SizpI?=
 =?us-ascii?Q?RwjMyjH9vKNWvfAPQahvUMCY2uzbZy2K2fWXsfq9a5rAx6utBrs7TvK3+Ggh?=
 =?us-ascii?Q?gHMN+lrqcgKsoTQT/SN5C4vUgdlAFkdgGcQUj18HW0RHzUNnH50KmRUZixbH?=
 =?us-ascii?Q?Q3+Prpy+0CCLvpWf4/fQRIUxupOjawguBocI9XCDulIjp9A3sdpQmhOIBfwI?=
 =?us-ascii?Q?f2/Eyt15VcZZhd91sbAWQzyBaKpwHByLS7sU+tg/gnZAvy6IiyEKcafqhGqC?=
 =?us-ascii?Q?xNPvsBOc6zpbr9YzQOVwJWnlz9JvX0sn9qwfX4eeHVdxPk94Vnsy/lafG8Ul?=
 =?us-ascii?Q?j5gn7yrCBvxj5PivAzXPbqTMQgUM9ZFbPOEU5zF8eDUC1Ze0ADkAEmTgcZLT?=
 =?us-ascii?Q?GM8sMQByKolf/KBYYaJkKFNToQF4pUZfSWGUUrYnUmgzHhhTROJJw5KqqW/a?=
 =?us-ascii?Q?kaxCMyg2lmIr5hJ3i3UoaljYDObBzLWVwoRcWcsKRuf9Q5W0qitCFq3E+KOM?=
 =?us-ascii?Q?3yy8isPfb8Aad68yTjPp79U3ZTtsExKXy/xjlUSp?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb0f3f4-998f-4962-fbe7-08db3c489c32
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:57:56.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUXY5JDMD7nGpxb4Xt6Vy5j58vAPGfaO+DAFt+qixFkB9llRMVLt+alMFpZvqMGfZfbvrFWlxP9DZKJ5RyiLLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

To support better understanding of swiotlb usage, add tracking of the
the high water mark for usage of the default swiotlb bounce buffer memory
pool and any reserved memory pools. Report these high water marks in
debugfs along with the other swiotlb pool metrics.  Allow the high water
marks to be reset to zero at runtime by writing to them.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
This patch is built assuming my previous patch is in place to fix
io_tlb_used reporting for reserved memory pools.

Changes in v4:
* Break out high water mark accounting into separate functions with
  stubs when CONFIG_DEBUG_FS=n. [Christoph Hellwig]

* Do high water mark accounting for each reserved memory pool as well
  as the default pool. Move the accounting variables into struct
  io_tlb_mem to support this. [Petr Tesarik]

Changes in v3:
* Do high water mark accounting only when CONFIG_DEBUG_FS=y. As
  as a result, add back the mem_used() function for the "swiotlb
  buffer is full" error message. [Christoph -- I didn't hear back
  whether this approach addresses your concern about one additional
  atomic operation when slots are allocated and again when freed. I've
  gone ahead with this new version, and we can obviously have further
  discussion.]

* Remove unnecessary u64 casts. [Christoph Hellwig]

* Track slot usage and the high water mark only for io_tlb_default_mem.
  Previous versions incorrectly included per-device pools. [Petr Tesarik]

Changes in v2:
* Only reset the high water mark to zero when the specified new value
  is zero, to prevent confusion about the ability to reset to some
  other value [Dexuan Cui]

 include/linux/swiotlb.h |  7 ++++++
 kernel/dma/swiotlb.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index bcef10e..6dc4598 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -87,6 +87,11 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  * @for_alloc:  %true if the pool is used for memory allocation
  * @nareas:  The area number in the pool.
  * @area_nslabs: The slot number in the area.
+ * @total_used:	The total number of slots in the pool that are currently used
+ *		across all areas. Used only for calculating used_hiwater in
+ *		debugfs.
+ * @used_hiwater: The high water mark for total_used.  Used only for reporting
+ *		in debugfs.
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -102,6 +107,8 @@ struct io_tlb_mem {
 	unsigned int area_nslabs;
 	struct io_tlb_area *areas;
 	struct io_tlb_slot *slots;
+	atomic_long_t total_used;
+	atomic_long_t used_hiwater;
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index db43de82..e498d75 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -608,6 +608,39 @@ static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int index)
 	return index;
 }
 
+#ifdef CONFIG_DEBUG_FS
+/*
+ * Track the total used slots with a global atomic value in order to have
+ * correct information to determine the high water mark. The mem_used()
+ * function gives imprecise results because there's no locking across
+ * multiple areas.
+ */
+
+static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int nslots)
+{
+	unsigned long old_hiwater, new_used;
+
+	new_used = atomic_long_add_return(nslots, &mem->total_used);
+	old_hiwater = atomic_long_read(&mem->used_hiwater);
+	do {
+		if (new_used <= old_hiwater)
+			break;
+	} while (!atomic_long_try_cmpxchg(&mem->used_hiwater,
+					  &old_hiwater, new_used));
+}
+
+static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
+{
+	atomic_long_sub(nslots, &mem->total_used);
+}
+
+#else /* !CONFIG_DEBUG_FS */
+
+static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int nslots) {}
+static void dec_used(struct io_tlb_mem *mem, unsigned int nslots) {}
+
+#endif /*CONFIG_DEBUG_FS */
+
 /*
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
@@ -702,6 +735,9 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	area->index = wrap_area_index(mem, index + nslots);
 	area->used += nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
+
+	inc_used_and_hiwater(mem, nslots);
+
 	return slot_index;
 }
 
@@ -834,6 +870,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		mem->slots[i].list = ++count;
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
+
+	dec_used(mem, nslots);
 }
 
 /*
@@ -935,11 +973,37 @@ static int io_tlb_used_get(void *data, u64 *val)
 	*val = mem_used(mem);
 	return 0;
 }
+
+static int io_tlb_hiwater_get(void *data, u64 *val)
+{
+	struct io_tlb_mem *mem = data;
+
+	*val = atomic_long_read(&mem->used_hiwater);
+	return 0;
+}
+
+static int io_tlb_hiwater_set(void *data, u64 val)
+{
+	struct io_tlb_mem *mem = data;
+
+	/* Only allow setting to zero */
+	if (val != 0)
+		return -EINVAL;
+
+	atomic_long_set(&mem->used_hiwater, val);
+	return 0;
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_hiwater, io_tlb_hiwater_get,
+				io_tlb_hiwater_set, "%llu\n");
 
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
 {
+	atomic_long_set(&mem->total_used, 0);
+	atomic_long_set(&mem->used_hiwater, 0);
+
 	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
 	if (!mem->nslabs)
 		return;
@@ -947,6 +1011,8 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, mem,
 			&fops_io_tlb_used);
+	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, mem,
+			&fops_io_tlb_hiwater);
 }
 
 static int __init __maybe_unused swiotlb_create_default_debugfs(void)
-- 
1.8.3.1

