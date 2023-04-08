Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8859F6DBC4A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDHRPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 13:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjDHRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 13:15:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B2CA25
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 10:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1Y9F2Ihg0Xm4cscre/yNG2EHyBRM5QdfJF8ls9EceO0lTaApY2FmS+DDek9BzBEpkob06ad1VH1L56FKZ/RnMVIHPPGqLEdA1uhQGF7m7VPCQFk+X/2RY1ZiekE68sS4xWnFQjtZnr5moObfEuHTEnr7aFjPjNLwB2+/yIXaXIkw9H4dW6BwFjtxiiqN5es7/ekWxoLTG3T26mVVol7nJZw5+rwy5y6qz8Bu3ZhbghKF8fWNqswsxM9zxIc7h56PoqT3QhMXViOBBWgISmdVbca2ZpSLyw/sgpPpggXNkQcN/FRPNjLmZ0CF8e1djvphep3PJcq+szzZ7qIa9lG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UgW6KESOHc5sgbPe0hUdQL5gOYOFE3Axyj/hr6Gioo=;
 b=A0InTNee27RPTvfyFFqrn8D75twd36gNAtUDS8aK6l8OI038CtEmGojOhaLEerS0NraJ9BF73Bm8l8nxujnb4q+wfc/Puk36t9us84tcoM1DsotM3nl70n5gfZpTM28Hhon/bXFLtBs604RDc6wJLRAlWuiz5Dt3ZLdmkpAl4mIZGckh1JE77RT4fIKcu3LlCuS6aQeY8oGepXfBSrc1TAy32VDX7GfcDPWaJqUgXB+va5N3ymSm6E53au6i70oOXpKUwzbHHnC1OFZoBnGuoInSg/o+VBbQreQTad8xGizc9tYr8wpyu5vX8txID2ovyx+IqhXlNgvd05dqvHp2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UgW6KESOHc5sgbPe0hUdQL5gOYOFE3Axyj/hr6Gioo=;
 b=qB3whkMbg15mUMjw+QetowX1WdniPfLbRiMk1YPDKvEvFN71yic8xo4qFHaqiNb8AtUHAUnRvqPKz8AVpJX5p7PceHdHA5HlWZC8wijlrhD9YVSSQtuWSFa55ncmzi5iiAN20yNnvglVqggM/A+qCwS5+GFvMPHIKPiBIuMDp8sfvOQUn5yZj7MiDk+VCETPediN1SiyG+nKA/INfFAk3O76ZBfPdnJ95dg/kj9i18SaIcMEgaFvgUfUMd3pUYjL1qA6ccaEKywEKadxt+NbCWF1H8Zq2ViUc4JY5CVB/1jNoLP8lpZDqeOMoH3OHCk2MmyJUE1Qu3vymjRBjivcjA==
Received: from BN9PR03CA0801.namprd03.prod.outlook.com (2603:10b6:408:13f::26)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.26; Sat, 8 Apr
 2023 17:15:37 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::3e) by BN9PR03CA0801.outlook.office365.com
 (2603:10b6:408:13f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36 via Frontend
 Transport; Sat, 8 Apr 2023 17:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Sat, 8 Apr 2023 17:15:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 8 Apr 2023
 10:15:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sat, 8 Apr 2023 10:15:31 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sat, 8 Apr 2023 10:15:30 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 3/3] genirq: Use the maple tree for IRQ descriptors management
Date:   Sat, 8 Apr 2023 12:15:26 -0500
Message-ID: <20230408171526.3059039-4-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230408171526.3059039-1-sdonthineni@nvidia.com>
References: <20230408171526.3059039-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f94f58-20b0-4310-7fff-08db3854defa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TKMETXxdRVoSpxqZFbm9TpaY+D8bmYvQ73Hk2HNU7/sPt8mbud2cyGMABs58hqN7a+s/arlp1FajIWv4Pup219JnJ7kFHJXLY8ccg4eAdXQnWHLrNG2kPxVm18u1zcqK2qqlxK4zRXAyWcryzJ30knuVpspz35im7T9PiVbEfhD5S5NRALUCeVRIoJmqiP4bgjvis+69ITmZEiPHy1tNGSNdx1UZfWRk/rLYxIUiMFpBNEKQRKFXLP2Valzcfm+yju+3JENq+0H93e2tP5btwqMaCSOsyfo1jwaLJT2Cv3+eFIQsC7DsO2osX5m7xKZ7ugsfErhSkjf4QgHnImZ5r44TToD1RojlUhn8rJmCL8zQWOsDHgnE0ukQurwzW2Eyd3w6gWQYEWBAZAGccGL6lkn8fpT6mJlPFh2D+UvT3PyCBOb3AwZvhcvxwIDVShB0HRN9OCOdnOA2gw2bPCWYxIi+opEAjsKvMuPRSX7Vx3Fhkx6o8Gg5hNVWTA4CjozeJcJ1ikGgq18vczwIJaVy3+8wvF20ygfNpfh+72TJK/XB+WWIORPv42dwu6z/7HVbtUHA7JKOH7RwRLmQvaek2DDGMlhIoQUmyiMCK6bRgZDoeJQsnfhBBeIk3bTeTCIKMFDXF9PMwOkbg3EBIcPRnaTLStjmQ9Vpx96NZUQmLIJzb1c8Q38n6ZO7cG1RlYZ0HzxhepbvWhPh6u39TcstYMFljsq77AFa018PLRo7NlREGCyEbwWAE5Q9U6DpWhH
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(6666004)(86362001)(82310400005)(66899021)(2906002)(5660300002)(426003)(40480700001)(1076003)(478600001)(2616005)(186003)(47076005)(7696005)(83380400001)(336012)(26005)(70206006)(36860700001)(7636003)(4326008)(70586007)(110136005)(41300700001)(8676002)(54906003)(8936002)(356005)(82740400003)(40460700003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 17:15:37.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f94f58-20b0-4310-7fff-08db3854defa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
require a large interrupt space to cover LPIs and vSGIs

The maple tree is a highly efficient data structure for storing
non-overlapping ranges and can handle a large number of entries,
up to ULONG_MAX. It can be utilized for both storing IRQD and
identifying available free spaces.

The interrupt descriptors management can be simplified by switching
to a maple tree data structure, which offers greater flexibility
and scalability. To support modern servers, the maximum number of
IRQs has been increased to INT_MAX, which provides a more adequate
value than the previous limit of NR_IRQS+8192.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/irq/internals.h |  2 +-
 kernel/irq/irqdesc.c   | 54 +++++++++++++++++++++++-------------------
 2 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5d741b0e7d5e..e35de737802c 100644
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
index e0c259769d3a..e2e95e937c11 100644
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
 
@@ -131,17 +130,38 @@ int nr_irqs = NR_IRQS;
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
+	struct irq_desc *desc = mt_next(&sparse_irqs, offset, nr_irqs);
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
@@ -355,26 +375,14 @@ static void irq_sysfs_del(struct irq_desc *desc) {}
 
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
@@ -519,7 +527,6 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		irq_sysfs_add(start + i, desc);
 		irq_add_debugfs_entry(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 
 err:
@@ -559,7 +566,6 @@ int __init early_irq_init(void)
 
 	for (i = 0; i < initcnt; i++) {
 		desc = alloc_desc(i, node, 0, NULL, NULL);
-		set_bit(i, allocated_irqs);
 		irq_insert_desc(i, desc);
 	}
 	return arch_early_irq_init();
@@ -616,6 +622,7 @@ static void free_desc(unsigned int irq)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	delete_irq_desc(irq);
 }
 
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
@@ -628,8 +635,8 @@ static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		struct irq_desc *desc = irq_to_desc(start + i);
 
 		desc->owner = owner;
+		irq_insert_desc(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 }
 
@@ -641,7 +648,7 @@ static int irq_expand_nr_irqs(unsigned int nr)
 void irq_mark_irq(unsigned int irq)
 {
 	mutex_lock(&sparse_irq_lock);
-	bitmap_set(allocated_irqs, irq, 1);
+	irq_insert_desc(irq, irq_desc + irq);
 	mutex_unlock(&sparse_irq_lock);
 }
 
@@ -785,7 +792,6 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 	for (i = 0; i < cnt; i++)
 		free_desc(from + i);
 
-	bitmap_clear(allocated_irqs, from, cnt);
 	mutex_unlock(&sparse_irq_lock);
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
-- 
2.25.1

