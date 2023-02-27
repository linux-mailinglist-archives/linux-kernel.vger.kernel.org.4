Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A26A4738
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjB0Qmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjB0Qmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:42:43 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020021.outbound.protection.outlook.com [52.101.61.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C223107
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:42:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2CumN9YzvN0hG49YQ3LKtIQEYb1wwgBOEta9CANCMvA4MAPcy1MC/KeKESPCjJZSX8OMrQy5fWal8Je4lDwFPN/ij6CSrCiO+8EHyaNRfPSsunLVtmo9rqAqbOk+cTqhqqlVRbwHZHt0mD3Q8aihFEAVnONH8M3Y5e9X/1j28cy5Vd3ZkdcxhlSnVwavMeKbmSkQNgLCMs7a+TyH3Xj+DMLepZSB9Sjvs0k/YcWKSgds5K4NPvIYSy5O6gzJbyCIPtoeA+MP96jz0BFiROBXlQ4ifhYhS/rtkCgnZJthqt/yX2Hj/2Ln2NTHfow3uU259URwhoRmxIT95Ju6HqfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huZNkWlTjjQ55cVmPorFyLqWXcDKXvQLcAbdL1NRNnM=;
 b=hMfiBZXc/WRqnh6vgH84SwRMEYc4fBcgirTsiOpwsDfmnUZImTAat6O56pEcJ9mqzLKYFQJiz+c1AeWvVNUVJFCVUbpzHgBKN9XyL+KbktAvGbDBUxYR5PGHwysUdvO1swVrjljnYz751T5ljOaVv0X7VqauFR/nmssWOVZ9inUuRfIczA8rwznz8UYa2aSOKubVNYAUZwKIZ0BYMs1XMJbZB0T40IPrOScHyNlLNmfoNr6d+t7KZfuaqoFI7er9a5Axi4FHb7sD8cl1v9XAExujJHLmEtsQUCgnLa/c1314/0wpkcfLStm4UCzUO1l/Fjg8AlS976Xy0gbqEDfiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huZNkWlTjjQ55cVmPorFyLqWXcDKXvQLcAbdL1NRNnM=;
 b=SBM5yc6CNzneLF6DSXHlB88zi5Msr/B0x3yonwNmAy/G4dtwoVKUrjwUip6VkJ4Y5mZHXaNIRHO9VaAEDFU2CykHh358hupqFzpvafAgtAGFB9I40F8LywcL8efFNZPsUGmsrdKXKnWSc4gqmwySM4JyWkHFQv4EK93+j7VLlW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3043.namprd21.prod.outlook.com (2603:10b6:208:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.4; Mon, 27 Feb
 2023 16:42:39 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::caf1:81fb:4297:bf17]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::caf1:81fb:4297:bf17%7]) with mapi id 15.20.6178.004; Mon, 27 Feb 2023
 16:42:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water mark in debugfs
Date:   Mon, 27 Feb 2023 08:41:46 -0800
Message-Id: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:303:8c::12) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|BL1PR21MB3043:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c03b9d2-8d63-4cc7-a2a6-08db18e1a33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BILJE99M63Pv3DK4f3dblSGLsw1nUfyaFrzyheHagf8CjR3H6eW1zuxVLEYBVz3qvMnK4Kjb3QuqPpg50D3O+W+RtNaFuic8F2so1gWamTQS3K5a8/YAYncmBlTmE5GSi84g287iuCRWni7YdkMbxuCt2wL+rEs66RRi57JZGq+oafRG88VHZylvi5iDPgtOox57xyDVTTtcUiqPnwRAbDi9uHh6I2rm22SsTI4WV5t3l67Tl1PIK37UXAXMnxZ93lBdR6wwyGvXtKb9gRLTfGqk+fqOqG1t3PAIK35KgfJpFf6sQr5KAcZ+aNSMuaigbWfXAL4OAgLtN7SkXJglnfeKeYDrfZ/8p95il+w5p7CzAMOgod2jlhyFbCYax5J49V3KeV5RD8cgV+RjzngA/H+7CJchb3bCIcA5SPFe+uuZv5Q5GL6K4nM9+coA3jt4Livsj+7sjZdORD2QZbW355GtnmU1Ff4CFB0qNH3lMlL9Y+aaZUoiyR+CGm5AVHCN7VzowcFuyfLayKOjVPeGOv5BEMH8zgzyvWC0kzWSve4bYNmDQnI2a1WJBiqk5MEgecgQQkYdV9NMouIoG16BdLcCw2etQa5+qlhUQNvtxjT3TFI7Z1e2uk1oIXFVwdTRy1OaGmRr0VeGQTiGlLwZjG6FpNJEtFaPsbAnkmHYb3dJdyy4QuRcpEiehD4wzpB0rHoxoj/Q8Gc2bLlSFhHVDVCjlyG8ZeLHvv5XO7k0nTp5pJ4ajwGprpTajyj0F1fP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199018)(82950400001)(82960400001)(2906002)(316002)(478600001)(83380400001)(5660300002)(36756003)(86362001)(8936002)(8676002)(66946007)(66476007)(66556008)(4326008)(38350700002)(38100700002)(41300700001)(52116002)(6666004)(107886003)(10290500003)(2616005)(26005)(186003)(6506007)(6512007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVLIdHLCHW/trOGjAKgWM+BmZUCCoZKYZi+3FKgKEZ/Dzvl1NrXbyTZIhJY/?=
 =?us-ascii?Q?+bDe3O7k0fBaXyrxv7MvltH3h6nd8cl6uolUsVJRLFYwHV2KpceybuhSQtJ3?=
 =?us-ascii?Q?UPy56TuAw8FaT9vw2MR0rWspZKH/a9QNb7TutO2664WYYKAadFqnZGYiKA8N?=
 =?us-ascii?Q?A/DQ/mmDMPOS7G5flDGIwLZ7ok10FdJdo1/FkkHsZjnhXMRD2AH1sa0/7BI/?=
 =?us-ascii?Q?rjIUm7fFw5npue7AVEsIFMtcLlO6E97P0jfj7lWfEiK9v9eVAWIKTmhozzpX?=
 =?us-ascii?Q?6AMC4umRIUr33ksVKGJavlsyTuNo5ID31sFJS+M1rjawY93XxxxZfCfQjM+N?=
 =?us-ascii?Q?Xc5GJlLIwz9O+cg5MizL95oC+zngdMr3sUt7hdyR9XcURKSbt6Ief35uhofE?=
 =?us-ascii?Q?wkgZ9kvt/BUZR4pLdwB75Kc/gAaAjCnFSF6FBeS7GHJn9GO/R6FlGaBDBlAm?=
 =?us-ascii?Q?9ZbyTWiZ+VipMm5mBHlh3CCkaIKhgZNYYyILtAmdP2FzeSXsSmn1bTAS+8qd?=
 =?us-ascii?Q?1q9ciK75kQ5vUrjzIgKaO44eG4c+vKsqFC/tRFgADe6CE5D6k4e1bCNRxCuD?=
 =?us-ascii?Q?NvykeVxasfq614vmRSWQDA4sTDcIbbr0tIbbVT17k+SPMJzXtzsB8kqA90Cz?=
 =?us-ascii?Q?hgrOH9MqqRh8r6lsnoqzKfctQv0z4nqjzocHYRaJfushFubJtgFDESxqNF/W?=
 =?us-ascii?Q?GtB6vR3Nzg/ooeLIPs6rURCMPgBvCtVsgmTt0YnDpH5SmF1DXVPafdGeKxsq?=
 =?us-ascii?Q?WNBkFlTOF60/5a+FPlLs3OjoJ2jixjPeY57n/MyMu3JEqRDhFuPAIfgIapq6?=
 =?us-ascii?Q?Yb7NNSMxLyzXCTxPHS/e9iweCECo0a+rsBfkmQcITha7/GJ/VnU90nZSlTG3?=
 =?us-ascii?Q?eP+rn1C5i49XglX1O3GQsfCP4v2N8ea4Vvvjzve2fppQLArLD2IziG6GphFy?=
 =?us-ascii?Q?um69yTFhiSZNI9DzfXG1JoE1NEvyBalyT2LrgE3+vTHBwvISCc8MMdO3ddKw?=
 =?us-ascii?Q?7jYG31m6/9txPCUykQ1xmu8lgZOuHHomNdR7IvN4JEWK1a2JfJZJKsREU1WD?=
 =?us-ascii?Q?xSyrm+h2pOHKJBmiS/87zkebOlMgtJQyYtxXiIYP+dfhReUEDDSWv76ZQlZQ?=
 =?us-ascii?Q?6XCODPvZn4HlEn/ZH89TlA2bbWxo8FUIShv6vc3RDCRY66pR1XVQy6LM3jJn?=
 =?us-ascii?Q?CokaY1Jb6F1saBMkKqO9fgEovgSJ//XJQFDn7Hkx7khX+u2MivaxMtMC2WM/?=
 =?us-ascii?Q?Dr+z7YksjEMQm+eh5FktnDgHADPh0/6Apfqb8FiQ7ORerGDgf0F7uQY6RrSc?=
 =?us-ascii?Q?TO642jC6JFKlzcr/RzGEhwHQuQE9h0M13xKyvqnwUUtPZRSOhYQltEpMbpIY?=
 =?us-ascii?Q?dDd0W9sBiR6BuubF2lCLKnsr3KCCYhkMcSek/UTnmaSaUNKktZWWui0A08bg?=
 =?us-ascii?Q?NPw08/CQbA60hFnucQEpfRYHUa66ClKrtCDttv+xkmstYwbxQBjWE97PaCtI?=
 =?us-ascii?Q?p0el11OJgCi6F6l651ASsS/4sZHYLQ9/Cz7E1iBLH0LEVlrEozLAe83GZn0c?=
 =?us-ascii?Q?vcvwS18LV/18o592Ghp5nxBdxbZPtljI4VRFOqwu?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c03b9d2-8d63-4cc7-a2a6-08db18e1a33e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 16:42:39.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8pkHV0RJuvRbbXEhmSEoJW5v0IEkkvxnemokXMioF2+VRuyt6bPBhfCVPa2ljdwxWHKbDM9DqalvwuEjCn9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
---
 kernel/dma/swiotlb.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d3d6be0..2dc501e 100644
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
@@ -663,6 +667,14 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 		area->index = 0;
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
 
@@ -685,16 +697,6 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
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
@@ -727,7 +729,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-				 alloc_size, mem->nslabs, mem_used(mem));
+				 alloc_size, mem->nslabs, atomic_long_read(&total_used));
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
@@ -795,6 +797,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		mem->slots[i].list = ++count;
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
+
+	atomic_long_sub(nslots, &total_used);
 }
 
 /*
@@ -891,10 +895,26 @@ bool is_swiotlb_active(struct device *dev)
 
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
+	/* Write of any value resets high water mark to zero */
+	atomic_long_set(&used_hiwater, 0);
+	return 0;
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_hiwater, io_tlb_hiwater_get,
+				io_tlb_hiwater_set, "%llu\n");
 
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
@@ -906,6 +926,8 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, NULL,
 			&fops_io_tlb_used);
+	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, NULL,
+			&fops_io_tlb_hiwater);
 }
 
 static int __init __maybe_unused swiotlb_create_default_debugfs(void)
-- 
1.8.3.1

