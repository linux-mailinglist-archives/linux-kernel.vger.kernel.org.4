Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F246FE2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjEJRBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjEJRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:01:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0035A7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQi1LVYbpFRHTCG4kepl8oAn1Jhrnx29Pdb+mkAacVl0Om5zwWMBoHGkeUrf6zZsfcZ3jQwUZwpW20+/a3YBOkNVWlSScQFnV1BG/LsmTpufGJK6UCBiBShrQJenU137ST6paT6IJOU4b1ac9w9zqbwusV/3D9++RFLBeWTu7fG0j2r7uGGWJ1AsTJau/oOj4sz4/Rt6zL7K/+KRgX+iuuu0P/z3o5nVdHJaBRVmlgSksvj1uq7XSKMHw9h8Q2oKIBGve4ERqFgeafVPmO+ih2Qzli1quP5sS2Ca6fVvNKXqox39/Dqe16YZbixJ08E5QKyGCeN4++1qTq3twy9z1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J5ZD9tCFDIirvnkBQdE90IzWNLfBLyMqdKr1ILBU/s=;
 b=jkKEYhbEGtueHe9e/pcK2yv2dnif2vS8Yr1r/n1y2MWeKJ7At21Y4E5lGjDVfOYAFXZOOhGMsoVK8vXZRNwVFohAIbVOQ1v4MbvtvqNBtjuxNo2+Xw/9rrhN3IR4z0zk3Zmi5wEneyZYFak8WYawQFqKjfK82eCU+6UIFOYmLjWXFCSC+NfhcVtiOTZ4aGkukt3WStvYhQbY7rLgecivvRpzPeO3dRf0NSEzqxoNKYuEUkiZXTGAKcaYKXi/eYZzS7965JVx6WVX+3EmJq9nPSgi61s1IAS06hkfo+aKvutdEiKTynk5pimx/OgHDCntj/Mmg/ZZUwz7CnAVmFeR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J5ZD9tCFDIirvnkBQdE90IzWNLfBLyMqdKr1ILBU/s=;
 b=m9705vRLaHwbDk/tyUE7w92o+Sn0r4x9ieeOl46KyXRfvUHNALQXMm73HpDk2eX8Oqk8uOkutDPdRGFCjYvPd9qhLybTPx+uc7wePTozS/kOGWbZ3clMQpOlpcXFTpAEdWuxiMdrgVBtatX3uT8xIlT207lmtAOSjl+VjIZpwe/4cZD+wU1oWgPFBw8p8Z0EWEVa1T3M+cWs3DzX0hiyk13jaYj3BLZI7hHQF/drJ1XCcNTlubTQ5r+2VcC/CTJ5Tvo3BtkdIPdYC4mG4heavSuKr9iG5EcyivlGeNVvLq/aJinp5GKYRa/K7H4Pa554oQ1/Lq5SzU7S22YZAybuKA==
Received: from MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::35)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 17:01:04 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::b0) by MW4P221CA0030.outlook.office365.com
 (2603:10b6:303:8b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 17:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 17:01:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 10:00:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 10:00:50 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 10:00:49 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Jason Sequeira" <jsequeira@nvidia.com>
Subject: [PATCH v4 3/3] genirq: Use the maple tree for IRQ descriptors management
Date:   Wed, 10 May 2023 12:00:33 -0500
Message-ID: <20230510170033.3303076-4-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510170033.3303076-1-sdonthineni@nvidia.com>
References: <20230510170033.3303076-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|BN9PR12MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f434805-4b4c-400a-0d17-08db51782392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baw4tfPsgWLLKl5p8wB3ZFoTA6of07tcNEQ/VPHiL2ba0jN/PuhsAJQCzJn6DXOCLiJ0ioUmgU1/OqUrBICkqbX/RjDTUzgjW7a89y9xqRS8vku5sofBlpoFnv8XACEPTuN8DdIFbFeuqOda2CL0tqxcaWZCrztB1qh0iZNtbgI6ezJpVtvSG44n6JnNWS80TevhJNJq5zFfidg1Ps5qSvt91HqxK73kNVZWHQ594C6NmKX7kDNLRVbn7tfaalrQEj3ZRFqGG2iY7a/aRoAJFettBpSicB0rEzRjwxXPI2U5xKJa/YcaHigpyWMsUxB8kTi1zD6RkyrFMqhUbaj+Dnu3WpfD4bWwv2Uv/mSn/E+rdzef20UFVaaAW914rt0de7Yv1mvw+Y849W0BCgAsceuobv/bTbm0EJCWpD3quaBV/+UwuCBxmLYeZGMCgpxbF3ogRRDxG2+w8/V0SvbDg+kA9TK3nyXSsAqnwPOy+mIDGljSS3oa5kDinztjCTOSakuKVFp4pZAVai5zF1WI34ubpwbIAE+FK7QZAAxmWq2p4R7vHCTe2H4Xahu6NzeKWVIaMDVjlsEWdM2yjjlV+dqDIADr54QO9EItIMnZG+roWhBkqtW60CXWEa1b9HdZI455CdbcqYWrHB9KMc7EYulQtwBRR/eNypNaIt8YAN1U7YDW77sgHFcSRdHs4FMM2TdX+vFCAHU7LqWWTsTwUy634++k05qd2x49lwPacOp2NNhNbkmkEuHdYSk25Qrz
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(7696005)(66899021)(41300700001)(5660300002)(40460700003)(8676002)(8936002)(478600001)(40480700001)(54906003)(316002)(82740400003)(110136005)(7636003)(356005)(6666004)(26005)(4326008)(36756003)(70586007)(70206006)(2616005)(86362001)(186003)(2906002)(83380400001)(47076005)(36860700001)(336012)(426003)(1076003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:01:03.6350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f434805-4b4c-400a-0d17-08db51782392
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation uses a static bitmap and a radix tree
to manage IRQ allocation and irq_desc pointer store respectively.
However, the size of the bitmap is constrained by the build time
macro MAX_SPARSE_IRQS, which may not be sufficient to support the
high-end servers, particularly those with GICv4.1 hardware, which
require a large interrupt space to cover LPIs and vSGIs.

The maple tree is a highly efficient data structure for storing
non-overlapping ranges and can handle a large number of entries,
up to ULONG_MAX. It can be utilized for both storing interrupt
descriptors and identifying available free spaces.

The interrupt descriptors management can be simplified by switching
to a maple tree data structure, which offers greater flexibility
and scalability. To support modern servers, the maximum number of
IRQs has been increased to INT_MAX, which provides a more adequate
value than the previous limit of NR_IRQS+8192.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/irq/internals.h |  2 +-
 kernel/irq/irqdesc.c   | 55 ++++++++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index f3f2090dd2de..7bdb7507efb0 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -12,7 +12,7 @@
 #include <linux/sched/clock.h>
 
 #ifdef CONFIG_SPARSE_IRQ
-# define MAX_SPARSE_IRQS	(NR_IRQS + 8196)
+# define MAX_SPARSE_IRQS	INT_MAX
 #else
 # define MAX_SPARSE_IRQS	NR_IRQS
 #endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a741a37d3641..0db3ad799a3f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -12,8 +12,7 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
-#include <linux/radix-tree.h>
-#include <linux/bitmap.h>
+#include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
 
@@ -131,17 +130,39 @@ int nr_irqs = NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
 
 static DEFINE_MUTEX(sparse_irq_lock);
-static DECLARE_BITMAP(allocated_irqs, MAX_SPARSE_IRQS);
+static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
+					MT_FLAGS_ALLOC_RANGE |
+					MT_FLAGS_LOCK_EXTERN |
+					MT_FLAGS_USE_RCU,
+					sparse_irq_lock);
 
 static int irq_find_free_area(unsigned int from, unsigned int cnt)
 {
-	return bitmap_find_next_zero_area(allocated_irqs, MAX_SPARSE_IRQS,
-					  from, cnt, 0);
+	MA_STATE(mas, &sparse_irqs, 0, 0);
+
+	if (mas_empty_area(&mas, from, MAX_SPARSE_IRQS, cnt))
+		return -ENOSPC;
+	return mas.index;
 }
 
 static unsigned int irq_find_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	unsigned long index = offset;
+	struct irq_desc *desc = mt_find(&sparse_irqs, &index, nr_irqs);
+
+	return desc ? irq_desc_get_irq(desc) : nr_irqs;
+}
+
+static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
+{
+	MA_STATE(mas, &sparse_irqs, irq, irq);
+	WARN_ON(mas_store_gfp(&mas, desc, GFP_KERNEL) != 0);
+}
+
+static void delete_irq_desc(unsigned int irq)
+{
+	MA_STATE(mas, &sparse_irqs, irq, irq);
+	mas_erase(&mas);
 }
 
 #ifdef CONFIG_SPARSE_IRQ
@@ -355,26 +376,14 @@ static void irq_sysfs_del(struct irq_desc *desc) {}
 
 #endif /* CONFIG_SYSFS */
 
-static RADIX_TREE(irq_desc_tree, GFP_KERNEL);
-
-static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
-{
-	radix_tree_insert(&irq_desc_tree, irq, desc);
-}
-
 struct irq_desc *irq_to_desc(unsigned int irq)
 {
-	return radix_tree_lookup(&irq_desc_tree, irq);
+	return mtree_load(&sparse_irqs, irq);
 }
 #ifdef CONFIG_KVM_BOOK3S_64_HV_MODULE
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
 
-static void delete_irq_desc(unsigned int irq)
-{
-	radix_tree_delete(&irq_desc_tree, irq);
-}
-
 #ifdef CONFIG_SMP
 static void free_masks(struct irq_desc *desc)
 {
@@ -517,7 +526,6 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		irq_sysfs_add(start + i, desc);
 		irq_add_debugfs_entry(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 
 err:
@@ -557,7 +565,6 @@ int __init early_irq_init(void)
 
 	for (i = 0; i < initcnt; i++) {
 		desc = alloc_desc(i, node, 0, NULL, NULL);
-		set_bit(i, allocated_irqs);
 		irq_insert_desc(i, desc);
 	}
 	return arch_early_irq_init();
@@ -612,6 +619,7 @@ static void free_desc(unsigned int irq)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	delete_irq_desc(irq);
 }
 
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
@@ -624,8 +632,8 @@ static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		struct irq_desc *desc = irq_to_desc(start + i);
 
 		desc->owner = owner;
+		irq_insert_desc(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 }
 
@@ -637,7 +645,7 @@ static int irq_expand_nr_irqs(unsigned int nr)
 void irq_mark_irq(unsigned int irq)
 {
 	mutex_lock(&sparse_irq_lock);
-	bitmap_set(allocated_irqs, irq, 1);
+	irq_insert_desc(irq, irq_desc + irq);
 	mutex_unlock(&sparse_irq_lock);
 }
 
@@ -781,7 +789,6 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 	for (i = 0; i < cnt; i++)
 		free_desc(from + i);
 
-	bitmap_clear(allocated_irqs, from, cnt);
 	mutex_unlock(&sparse_irq_lock);
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
-- 
2.25.1

