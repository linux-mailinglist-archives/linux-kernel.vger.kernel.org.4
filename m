Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388A86D2E2F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 06:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjDAEqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 00:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjDAEqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 00:46:11 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC7FF03
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 21:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf6uvZpZuQQuAqBDPyuw7Dq86QtDQt7dRiSd+PT0inRl5UdXTejVWRaBLEGprN3Iho9NB5GHHUpP7uK2tHZ23YEPF59Z2CyxTsk5otFgIH0rJLxYL/nYcvYTnu8Q2cmCiKJJE035W83jULg4gC59TiomF5lZBUivGaUalMJAwtaaMP620G9i699J8bZkPdiZKcf+fqWqiUBlv5g0gQTlCbPlxF08UEDEFeCciiF2IAkT52xlBURXWj3k05iw0ZHX0NKYlBCve4dgvx+tPME1eBOnPTCsi7/9FlvhDgZQuPeo4yZxE6YHQAMbNnOmx0btSKnvshRjrllNbUyzYb9XMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzrQNY7r01O2nau9qg2MZq4BUNEK5Re1t9CsW7YHzyA=;
 b=LKArXlylTV8qJVhuMPva9vfMPcyJe3fy4wWmG+BwM5D457FPkoIbKkByQgSX936PeTgL69fSJ2kx4aTI/KlNIJDSI1ZEYtGpUE6wo0oRXZLHYeRc2/uSixoqPSEA68eXT6ky5XtziYC0QXQ7Agz/BXC1QgC/KIRiEaS/7UyovT1RUau99+PbLOQE9b/1GSSAkVp/X/NXrT6bqdZ57Hg9IX4CtOVsXybrxZWB6SYCZEZdvbKo0YfptUS03vj9ere6LnTxGUASOoatb+WIEsp3yxMTZv3lsPlkXFFXntEdJNeaKS76txg6QP2A7beNID13a1gCoxkT/kLfClQGwZXnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzrQNY7r01O2nau9qg2MZq4BUNEK5Re1t9CsW7YHzyA=;
 b=BbyJjiS7NEQI4vprCXfv0R7sO9Ji47zYKikCyo6EiT9iEcjVFuS9OaDk2XD2NkVvv+ii+zBD7O2TFmKh58RJADACpd/+jAXohykAKbu2BjXl9PPobFtWZ3f8q/NjN+FSBd/KL72G1TqOz+KuP1G0+4yc4ZQynU0x6SvFbxEIz/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by IA1PR21MB3594.namprd21.prod.outlook.com (2603:10b6:208:3e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.14; Sat, 1 Apr
 2023 04:46:07 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%4]) with mapi id 15.20.6277.013; Sat, 1 Apr 2023
 04:46:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high water mark in debugfs
Date:   Fri, 31 Mar 2023 21:45:00 -0700
Message-Id: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|IA1PR21MB3594:EE_
X-MS-Office365-Filtering-Correlation-Id: f0057b43-25d6-4505-8fe5-08db326c01ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rF165aQN+L2szMWmsXIW9CqlJJzHZb6/b+NwzyiY4VCUdf7TgrQI6r/EjbDaj0ECFxHSzBBKoOOD/BbpuNBdW/4X6WX6CVVvE70tKLhZlmh6Dt+aY1yw1pMgMKINMLaANF4RBNP9KbZjaaNYPArB+NuKKXCaZqv8FmSmqBwGzrHI+iduMjHOWtyt2repCbhmXoFzB8hlDXcml1EHJCzuNU/ibUZw8qgXpRqFyIjM9N+BNvjPDczLG2baUi9Nv9VeQD1ti3JtROchWr6Adf2lLrhBADve/t4sW6hrAyLkb1eIgpPzQv00A+YZi2hjCA4WGGiUABCNipeaAPYqJdIZvVV0nb0WM1bKu8ixhkBMD2a9cruBQ6JvRDP5kzccx71JQxYiexD4qtQPJCl3SLdoPalthZ15GI5rQKbA4n/K2lz+A8g2UOhFfbPNeTuxVyUJ0LTv1cH13AqgHhugoUtb+Pnd+YaBrtXB5X3s80S5UD77V8N1StNz+oWvof6ZqlFOytTkLhAwJ7SJzWcW1OOO/CRNadveMMxjFJs5s7883qufIyar7tD02I0PmaXQii7MzjiWUZjYQM1XI8GEkrJEUPHp1nX03SqST8qGnLRODra03L/Ju7tnAXjaFhSrhZPqmrygz34iXIZ3h+x4INVlEmq3McjgvRrM5LA9ICymTu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(4326008)(8676002)(66556008)(316002)(786003)(66946007)(66476007)(6486002)(36756003)(6512007)(6506007)(107886003)(6666004)(26005)(38350700002)(2616005)(186003)(38100700002)(83380400001)(10290500003)(41300700001)(8936002)(478600001)(52116002)(5660300002)(86362001)(2906002)(82960400001)(82950400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?erhg+B4BmizUzpUaAZ+F1TkqCgEsv/gppqF7EA68jldO5afqDTvAxVYRACSD?=
 =?us-ascii?Q?BcunlWlxv+oCtxUMrbM8OPnZf/hP5x+G79271wUWfnKCWoBOp0LB0TLJ23BZ?=
 =?us-ascii?Q?95NWuaVXfbkpCHVuQIIWjPSUNhRqiF/MNQOTQ8ImaJ+OYud4+dyjk+ZkShzf?=
 =?us-ascii?Q?DeHlV4G3NauYa6RJdN4WNl6EZGNoNTlxn58+KcWb95oqIgYGIE5qveogQR0/?=
 =?us-ascii?Q?okXtdYjupWBVy+U7UelDklj1FuiqxWJPwsyNeL/rdydcBIJlyiLvhFWyo6/5?=
 =?us-ascii?Q?mnZoFy6u/Tg8ydojxy6GLYkPw9md0gRaBG3GqFj/DtKWJqHeh+8ejCiP0+xe?=
 =?us-ascii?Q?SWawAubuDLpIsf6q88oRbZLxLfdEbIrN6HvDPbnwUWA4lrkUMJcBH3BTIVnM?=
 =?us-ascii?Q?TMyO/EnuTDb0cKMRTLiDNA+DXmciDIPr6+7AuXHR3qCPh3kQyuI8cT9p/6ik?=
 =?us-ascii?Q?Dq6YZdUC2bv8AQKGIG+qN1YMH8gIJXNsAOkgjf3JQ14eZ9dyBTXSP6cH3Mh/?=
 =?us-ascii?Q?x3yCSTbRWN6YLKRU60r/0wzOmYJ/Uwwxk97ie8YDx+okSGZ6oRpvPhemNEhX?=
 =?us-ascii?Q?S15cQVNOXMzsQJJts44pasF+7PCurdKsLRs7btJKm+5JXqeJZyBxBddbjFH6?=
 =?us-ascii?Q?nGGDCkyLMF6UW4ge1ZC34GAHkmNjBesPzFzRhVJinbzUoxNQQiuu2kBN07k9?=
 =?us-ascii?Q?rxvd+PMDN5bSh6jYijuSPMoLACBDhsCtciiP8Wn9TQDfXrAvnn70mo5Tywam?=
 =?us-ascii?Q?GPcP5JS2/Auh5/sSvmP2Rnjbt2lKyM3mPHqzYWRYM4X3VQuPqSJJW9bOQtv3?=
 =?us-ascii?Q?on8mUorQ/P//UqclMdEx5rIxaYt0F7Mpo+u0krCe9d9Z6B0rrMRu/6abQ5mS?=
 =?us-ascii?Q?RfzILpbKEI7pYBciklu4ZQK2nACA0y4EXWfRRmxR8KqO6s9JyBKRIR1FHKfc?=
 =?us-ascii?Q?L5jTvX3XQYxkL8heTAkO1XvFQbpaTZUpRcJCy/0LvCHdrWqH0xIuObsN23Ni?=
 =?us-ascii?Q?9ZPwlPASNQgFAx9MewO6NCWXnVe+W0Mrh6WtJoiC79qbBBkVwpo+DPLWTCZR?=
 =?us-ascii?Q?qaeMn+rM2VDKdqyiZutD2MO6vOIk3sk/LiTcDvDr0WKpKzPOxmp5EzJCOQbK?=
 =?us-ascii?Q?rffiOYDiH/B/5lTsMm+0OJGAIlXMFzb0NeB8+ny3xsTI4BoejJTqHz1Ra7af?=
 =?us-ascii?Q?K/TBcKZKmgKIj2gKcnw698g9gjcAv2iAexW8CNWfhRuBf5axbWKedFxknllj?=
 =?us-ascii?Q?nRfkEAbe5RJvM+uOJIoQoWuk3CAu3CzzI1D2Osx/D/d3vhegCBOBHNNjwp+N?=
 =?us-ascii?Q?LL/oPrvLYDhF+dxtzyodAVugrbjk1IP2pgWT1yPXmuubbILsFJpmZeTPNk1K?=
 =?us-ascii?Q?OBPVMoxykUpxduv5BJpmowlIzeJG4OYQz+fZ08wJG7wOT6Iybn8tHWUSZBTo?=
 =?us-ascii?Q?Ui872tyY70l3aBIlGCS8SLdqdPTJdLFR/PNESGJSUMJphMeJc1C6yxtkYucj?=
 =?us-ascii?Q?qhLmQU8gpgcwSKqZlqX+trU6uyxIjFIq6vQF0mz0FNMunC9igy5QqANDKhbs?=
 =?us-ascii?Q?1yjEEGw3t5P2Pb+xx1fhZneM08JPKViu7yd0Qsqt?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0057b43-25d6-4505-8fe5-08db326c01ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 04:46:07.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrTKPPCdWn6cdWmBSwC065UKyPnqw4FdoEA+hno8InkXbOZLN3Ngs98gNQ5Fw4LJVouMYj4O3aafPPU7cKOdzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3594
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

To support better understanding of swiotlb usage, add tracking of the
the high water mark usage of the default swiotlb bounce buffer memory
pool. Report the high water mark in debugfs along with the other swiotlb
metrics.  Allow the high water mark to be reset to zero at runtime by
writing to it.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
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

 kernel/dma/swiotlb.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d3d6be0..6587a3d 100644
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
@@ -594,6 +597,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	unsigned long flags;
 	unsigned int slot_base;
 	unsigned int slot_index;
+	unsigned long old_hiwater, new_used;
 
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= mem->nareas);
@@ -663,6 +667,17 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 		area->index = 0;
 	area->used += nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS) && mem == &io_tlb_default_mem) {
+		new_used = atomic_long_add_return(nslots, &total_used);
+		old_hiwater = atomic_long_read(&used_hiwater);
+		do {
+			if (new_used <= old_hiwater)
+				break;
+		} while (!atomic_long_try_cmpxchg(&used_hiwater,
+						  &old_hiwater, new_used));
+	}
+
 	return slot_index;
 }
 
@@ -795,6 +810,9 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		mem->slots[i].list = ++count;
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS) && mem == &io_tlb_default_mem)
+		atomic_long_sub(nslots, &total_used);
 }
 
 /*
@@ -891,10 +909,29 @@ bool is_swiotlb_active(struct device *dev)
 
 static int io_tlb_used_get(void *data, u64 *val)
 {
-	*val = mem_used(&io_tlb_default_mem);
+	*val = atomic_long_read(&total_used);
+	return 0;
+}
+
+static int io_tlb_hiwater_get(void *data, u64 *val)
+{
+	*val = atomic_long_read(&used_hiwater);
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
 	return 0;
 }
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_hiwater, io_tlb_hiwater_get,
+				io_tlb_hiwater_set, "%llu\n");
 
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
@@ -906,6 +943,8 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, NULL,
 			&fops_io_tlb_used);
+	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, NULL,
+			&fops_io_tlb_hiwater);
 }
 
 static int __init __maybe_unused swiotlb_create_default_debugfs(void)
-- 
1.8.3.1

