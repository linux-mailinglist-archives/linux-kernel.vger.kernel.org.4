Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461317098B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjESNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjESNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:49:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF6B3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyZxTYAv3BPILFJ5r/0PqmttOG/hnlUBFGFm+Vxw6GthCD69ry9yJw0+5AZ58/3sl7ciIAHBc7yD5HbqVmk0EjOUnOm4+IJ2FWzo+G49IgXm27Ygg851NY/jBkeHQ2KeGNEghoLopbD6GGtSKydFqDzwhQB5+EU3LxaVay0ImQZ7EXfW2ZL3y7PxrZpAgRUD+aHhAgNj/M12z/TWY8drci7O9/hRBSiO2JnVUZhxPuEXAb9HU/NcFwKPxshyTvIntYtO6YUxrdyk82pEobLg/F8zPD5JNiH9Sl5W9t/Yt0dIlBKH/nm8SzBjwjENlNCdLNU3FcUCUog94EmBE2UQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de6G/yYKlDcG5Llc/8vFOzpCkyOlrDMdqhJBg50LCeo=;
 b=DsWfE82YHKoHC3rmIAREd8Z0dpEYH8nE+NNFnFqTf5u+MweO/9irtKjw34SsKgtVw5SocvS+p6FV1BYaf1cbry6+uk4LLxKOxCTcZgT4f0x8WOZsuJcCIdvhPk5IIRb7cx24UmiLcWc1iCynuiFJ0TBr8yA/IvhHf3ET4rm6akwdmt4Azy/G3T4zkRegANdpAgtUF8m1lrPhx0PTviezaUkVxq10s4jvA9CLHqUd1Z0mAZlPNPi84aKZCXMVjBMHbUb5Y8Eg0sA7o7Ke862ZGt2NZPANXmvIjbuQou0IrVBsZtpmI6feHN7s6zEVlxK+g1tKV3wriRk6tezqEeQR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de6G/yYKlDcG5Llc/8vFOzpCkyOlrDMdqhJBg50LCeo=;
 b=bJp2DXGU+cLOIeAaWcgchxztSlHfqlDohq2dlI0MN/G7PAQfL/s8oeefh43ufpwyAi6gqG20xRuz0kRyAExD8DRUxE2Npd/ig0B+Vv1TAtZC+Q57lLPvLwiQuB4vYpAKwyMh1DYIGaEx2y12gdB41wulO7oCpSfA02R63yhku0ZjCpDchkqbeQBWv3mFeVxxzyNSioypWXHlukLyz+4jqbg86pXK4rt64Z3Q3qZz2ilUWjge3DIHzP6eWxKtyMP0enCPU53wiSc/1rewrn7c1TsYX1SfTE4/6Bn9Bm9ia9y4Jlzbo2ICjg9+otHBG5c+QeRE8hImGesZipRVQqoOOg==
Received: from MW4PR04CA0076.namprd04.prod.outlook.com (2603:10b6:303:6b::21)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 13:49:28 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::cd) by MW4PR04CA0076.outlook.office365.com
 (2603:10b6:303:6b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 13:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.22 via Frontend Transport; Fri, 19 May 2023 13:49:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 06:49:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 06:49:14 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 06:49:14 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Jason Sequeira" <jsequeira@nvidia.com>
Subject: [PATCH v5 3/3] genirq: Use the maple tree for IRQ descriptors management
Date:   Fri, 19 May 2023 08:49:02 -0500
Message-ID: <20230519134902.1495562-4-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519134902.1495562-1-sdonthineni@nvidia.com>
References: <20230519134902.1495562-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: d633fc48-963e-47b9-606f-08db586fdd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fY1FQpFe5izY+aylyb0Hb66QC2+lu0XPR8mRFkXdTKSS/cYZm8s6imm/D66hkRBE7yH6pSO2No953GAl4bpn+Vz5EEVRFbBBWXdFD0oLqAYAz7M+1vRtKHGqJTl9EffEAFNLHZnasCKqufr7YUlJRLXrjPYlL0mCg63wccZ5Z0ndRXbmDx+f7WC00R+Z45+Fuf5YtOpTo76enP2nrZY1AfQFS4M8Ut/NuRLi1qooAqEpGETbh1C39p/yhOWupVzv6sXizBde/mJyU1foezfSFiRCLFiGW9/ar7/TjmO4eFmewxlFQ9k1YVZkltsB2BKSWUxZQQTurUd0l7tdnkjKAdGAgzyIQ6QpANfqgtarJaAXVytGVAKZokK+nwUWWpFOB75YZeZ9yMF9LWn42lzMQA8Jn/Q51uPhz/vqtiSlr1vq4ld9hE4rYAB5psJ57pN/dBKGLtemViIgYLO5OK5FLmv5EsPWmT/qGVLL8IxhiV3MRFrkBXS5IqzsVUtjK/NUqJuNcRBtFCK03KjqatRLZJwisqwRR8ywhuxH2qMVM4ZWRgQlbQeynYnsJdSYMJF7gYQuDj83UJOjsDjT8jcfreL00slCcRd2NAYiNAtBO0slwDqVs7pZdQb4kNF7fJp2cjPm70LmM4iTwugV6pNyl48sqv5l0vx4ED36HlV5jySpfTm42B+FTPUPTci6rlWyw4jgYWWZb4NxFvMHJ3V/jVeyEnAabmSwjlo2zOScv5EWP0b0udAZDh0NtJFWlFRt
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(26005)(40460700003)(1076003)(107886003)(7696005)(36756003)(426003)(36860700001)(83380400001)(47076005)(40480700001)(86362001)(336012)(82310400005)(2616005)(7636003)(82740400003)(186003)(356005)(110136005)(54906003)(5660300002)(478600001)(316002)(2906002)(4326008)(8676002)(8936002)(41300700001)(70206006)(70586007)(66899021)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 13:49:27.6988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d633fc48-963e-47b9-606f-08db586fdd28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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
 kernel/irq/irqdesc.c   | 57 ++++++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 26 deletions(-)

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
index e0d9dd9b36f9..27ca1c866f29 100644
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
 
 static unsigned int irq_find_at_or_after(unsigned int offset)
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
@@ -844,7 +851,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  * irq_get_next_irq - get next allocated irq number
  * @offset:	where to start the search
  *
- * Returns next irq number at or after offset or nr_irqs if none is found.
+ * Returns next irq number after offset or nr_irqs if none is found.
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-- 
2.25.1

