Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF193680361
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjA3A6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjA3A5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:57:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614C1D907
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdif9+gC+YqED77/z7Prh9voqo+l5TZRqvfwhaHK8eK3nKAApHCEPok47Obx/4jYywoAVXwEmKeSdzKB5dfVgw8IxRO4AzvsX4Tt6wTEQXgQvZSQLlun+3ieSpCSM7eWZttoxJ/bTjhmEKbdvrxNBk9QjNYbxrhqty5sUu+sduPixdZWSQNUzA+SJYHYZMP7zmysOWS5vYFsXFYKk1L4OdrzqneG6YFhAZZPpiwMylomdPV4Lb7BKkG4vZapAFFyTth6glvbZkOffQGld/ihGVGyZJ5YBeBRCBuzo2xuWuQKriUB0kCxWDY7KbBgn8TqXE5KMuk0nXihdrJOOspC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v9WfyT8WB4VHt8ZMWtIo74b8GKNJCGheVaBwTRAisw=;
 b=ZpT1FfnL+mpOjyOmV2v4l+jTba1MaCrzBTgoXxydtzQ05kkSN6dPNdYaNt08fHrfNAyN4+XRFpAXh2Bh7TSe/hMMUbIF54uAuMkxCGiWJRdy/B6wQTA/Aptxu1peiFaXOUJo2q+SFO3GWtLCehq8DF6P5n+0g81FngGB4OLjCaw32jdY9MxAJee+1CaL3DzNdR2lOP+zs2B6man7yM/5sJVgUuSIthEpBzsWg+PofW0/QY6gyvQt6IaXoukOQ2+C+no8mPTmC/LL5vQ4YhP7rJZq90kgtraYM2BxjX5941PeCeSJtW/lLMbGdCAUpG+HQ4z5gxHQ76LqS51un4DpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v9WfyT8WB4VHt8ZMWtIo74b8GKNJCGheVaBwTRAisw=;
 b=jqnTxu+IZZ86sZPJnrEILMXU4dZcYOMrCA/y+Ctkydbi8g/b4lnEXvWrlEN9/M92y32efRarSguwPUCOLdp3W2dJLdE8xQOl0Bs8a2xggXhnISd+Bvw7BODZ6fJglhBkHgRgsAWkZ3tm9hwmJuOp2C16oqNzTKeJH925KWof/4bSVY5zjLpqB19KT6NDfFHkQ2yUZWlEey8OQNOPyhWqPyiTPxsxZShMrz2evhmNgjU8xAYJirWnN7HR1bC6qbqDHh0AI2qaNthHxqXkLWwiX8uGLbElVkO0FJEnLd9qZg7EEjeogBkWOQZVaec0TjuBmADli5RCJStkRA0a/RXl6Q==
Received: from MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 00:57:42 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::6c) by MW2PR16CA0070.outlook.office365.com
 (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 00:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 00:57:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:31 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 16:57:30 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] genirq: Use the maple tree for IRQ descriptors management
Date:   Sun, 29 Jan 2023 18:57:25 -0600
Message-ID: <20230130005725.3517597-6-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130005725.3517597-1-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e95a8d-3bdd-4ca5-ccf8-08db025cfdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyBzXCOFx4874txF1QFpaPsq9WoAWrin6p9Of9ZOo3RP8oqIYzx1ezQZMY6jrPKYG17mqFknYeuUzB2KfkeCX6YHsJeZ3u5dMedbhL0YpDoocQy9V2EaQ+dvyb3BLUm7IlrCaeb0R3tWMFapR+nz4huaFvkwy7Q2obfQ49XNoo+viS6jwbodgqoqW3GK1quI8A6EIMeU5TrFgDhycGTpG+auMhE4i8/+PjTTgQ9Fs0vG1edbY+U7nN/JhwvdlIWKTSq2YJpeyYb2U+pksHLAVUGk8ZGNkLbySPz0YfDgYTA5RKltIW7RifJZGkwVBWPrQahIOeoVZjtA+mYgnPj+8Bh76FZ/nwfayHDMtST9MVW1apWXuzA6lsDZiKq3+PeTG33EkWVA6hHvGR2v8SShGmd4lmTTU0eekOJIYbOAH8pz4p3au65Hk80hp0y1abraiceYYcehGl/Zq7cEQMFAT91RAIJzf6bth6YHnFKnj6En2blx8J29m9nL7hP9tVGBvs2GBkrmLCX3nUSq1g+1xetM1gLdYX2hU8P/VMnMMFyeGocpHM114p7hRp4VVMWJH/84Z6eVdCqIceC8AlzM+c1GwIsUbNEjPXBu2TqsZ/FiGmQrDGgiyVydQKBIZwMdj94PuE3ZrOvAagCkIKaElNzVhDxjmduLb9G6R0dUDcQr/7sSmFc1Fc943DohUstgwt/CU78j57Wq7rKA3t5hzg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(54906003)(110136005)(316002)(70586007)(4326008)(8676002)(70206006)(8936002)(41300700001)(5660300002)(36860700001)(86362001)(82740400003)(356005)(7636003)(1076003)(6666004)(186003)(26005)(66899018)(336012)(82310400005)(2906002)(40460700003)(40480700001)(47076005)(478600001)(7696005)(426003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 00:57:41.8921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e95a8d-3bdd-4ca5-ccf8-08db025cfdc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

The IRQD management can be simplified by switching to a maple tree
data structure, which offers greater flexibility and scalability.
To support modern servers, the maximum number of IRQs has been
increased to INT_MAX, which provides a more adequate value than
the previous limit of NR_IRQS+8192.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/irq/internals.h |  2 +-
 kernel/irq/irqdesc.c   | 51 ++++++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 23 deletions(-)

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
index 247a0718d028..06be5f924a7c 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -15,6 +15,7 @@
 #include <linux/radix-tree.h>
 #include <linux/bitmap.h>
 #include <linux/irqdomain.h>
+#include <linux/maple_tree.h>
 #include <linux/sysfs.h>
 
 #include "internals.h"
@@ -131,17 +132,37 @@ int nr_irqs = NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
 
 static DEFINE_MUTEX(sparse_irq_lock);
-static DECLARE_BITMAP(allocated_irqs, MAX_SPARSE_IRQS);
+static struct maple_tree sparse_irqs = MTREE_INIT_EXT(sparse_irqs,
+					MT_FLAGS_ALLOC_RANGE |
+					MT_FLAGS_LOCK_EXTERN |
+					MT_FLAGS_USE_RCU, sparse_irq_lock);
 
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
 
 static int irq_expand_nr_irqs(unsigned int nr)
@@ -363,26 +384,14 @@ static void irq_sysfs_del(struct irq_desc *desc) {}
 
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
@@ -527,7 +536,6 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		irq_sysfs_add(start + i, desc);
 		irq_add_debugfs_entry(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 
 err:
@@ -559,7 +567,6 @@ int __init early_irq_init(void)
 
 	for (i = 0; i < initcnt; i++) {
 		desc = alloc_desc(i, node, 0, NULL, NULL);
-		set_bit(i, allocated_irqs);
 		irq_insert_desc(i, desc);
 	}
 	return arch_early_irq_init();
@@ -613,6 +620,7 @@ static void free_desc(unsigned int irq)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	delete_irq_desc(irq);
 }
 
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
@@ -625,15 +633,15 @@ static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		struct irq_desc *desc = irq_to_desc(start + i);
 
 		desc->owner = owner;
+		irq_insert_desc(start + i, desc);
 	}
-	bitmap_set(allocated_irqs, start, cnt);
 	return start;
 }
 
 void irq_mark_irq(unsigned int irq)
 {
 	mutex_lock(&sparse_irq_lock);
-	bitmap_set(allocated_irqs, irq, 1);
+	irq_insert_desc(irq, irq_descs + irq);
 	mutex_unlock(&sparse_irq_lock);
 }
 
@@ -777,7 +785,6 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 	for (i = 0; i < cnt; i++)
 		free_desc(from + i);
 
-	bitmap_clear(allocated_irqs, from, cnt);
 	mutex_unlock(&sparse_irq_lock);
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
-- 
2.25.1

