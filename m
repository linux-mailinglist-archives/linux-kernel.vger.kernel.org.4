Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363F67098B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjESNte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjESNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:49:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1491AB7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mepquQpfFl3mAgX4wZTxvIlBAd6k45JSz5S30EJoZJRl8UGSxT1LMribJq7oPSkswwPPqxWMdRrRghp4wC8GjxTBvoRdf7zt9EDJg7C12CHjgyDuCj5kr+MFruaLiP0I2f6ZrUYENUipWswyISjo/NH1+V6cY2VE8RFkWjXH7TimbKzyilCUrpF9775bNs6iafhV7nXQbijZ7n/PlemUt69Vw+gd03EYfBt4524DzKDgv/df6Tleq5O+I/EUY/VGe1/oQbW6hEQOT7h7bft2dXmQApWx/ZfhVEsqyXKlLe9p5KStmLgUaoktYuEmwDotYGphd+8X8uNdE2rGQu8LNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH2FJ3ygWRVmXHPyWjnyKBW3RGtReAKw2JojLX8VxJo=;
 b=cJW0eRs8FFWOfgY2gndrabHTAFAAoDSvX6nQZKepHBgUbw+mAI58c4+2EyGXTtxlSN+rQM7N9zsMywpICCiWO4dryNQQjVArvVmv0Ir5XXkcAn+22FRkYV8pbPhsOMAh3WO9SYVhtYOohut0crCzJ1eVHNkkSkXvZ8IXgVfE5EKSZEEa0+o70Q1m3o2SRSxOIkNI3d8Idmewv6iNE+IlaR0KKgymzcSg0AX8EkOoOICeCUYQT043zMNF8YPBeN/hXgWwzik9EUN1Fh/HrQv26i75VE3Mp/8rOLVvgcXXl9vCE+XC8XQdXp6Vrz8vTOFcUxIZ19S3RHE/YDQ3RiGujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH2FJ3ygWRVmXHPyWjnyKBW3RGtReAKw2JojLX8VxJo=;
 b=rlVCLz7siUiQ4udS6Vr6M+BOXUc4wsE3ejXfL3oIZ9jXlZS16nVz9zMEb9Pio4gv/oVMoXycOgAyoYpbQtg5GWG/HIZ4az+S6bS35poh2Bna1LFz+vAnaSUZK2VhWnm5f1JetgYBjMq6pF4fwKamR56UoHUAGt5yeeSLK+QnySzeQ0PER64ukYHY+y6C02Cy1026uK9a1OT6GHw/jBYBzPjXnXkN0tQ+mMhIU8ATUo3Q07waI1lqT8FQBQ/hk2sdEuK99AqU3UmUac/zJ9wAzcj7hNokPgqy5N/13pIVoSXH5rVHY1aTIgXAsaDr+vE52ku2y8zdZSZEJ9Z+RqK8Gg==
Received: from BN9PR03CA0526.namprd03.prod.outlook.com (2603:10b6:408:131::21)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 13:49:27 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::b8) by BN9PR03CA0526.outlook.office365.com
 (2603:10b6:408:131::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 13:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 13:49:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 06:49:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 06:49:13 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 06:49:12 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Jason Sequeira" <jsequeira@nvidia.com>
Subject: [PATCH v5 1/3] genirq: Use hlist for managing resend handlers
Date:   Fri, 19 May 2023 08:49:00 -0500
Message-ID: <20230519134902.1495562-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519134902.1495562-1-sdonthineni@nvidia.com>
References: <20230519134902.1495562-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef4fca2-9b71-48e6-f7a7-08db586fdc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddJjIXlGormTXTxPBTbEKBMUA4+bOdO6tEXrQWIw7ADnAGXd4FKII0YHpWcoOGZpoZhVdNOe1c9XCQ1K3EFr27Ggs2+ULeVdWuziIaF3IKJVGHfIVXOnuJddxINlKB/mIrCqcqkXShZgTFKVVuaBit/uJCEk5G3DRpG9TcQQRtYxD7OYNQ2OpRgApTC5I/k9d5HWWp8jGfrGMJ+8sWo31l/1mM3OXNsEm1z58iMAwUvhi2/opI3gOy+XhYZoU93OxdT9uFES1uwMlNsZTxBhd2DdF3Z4j3xw+yT5SqupzcYyRVH7UwwweyekI3hqe0CJ53dF9Y0XiUWWGISEaDzDZ/AF11ft5gr/ccXYxw9ySaSdQk4KHaN7dmWWni6gmDWx9Hr5LQ4NM1bMmEIQjIMZN1STPpjV4O3kXQIXBF5jFz1ul3Tudc8FxjNadOPhE/nWuDtP9YNo7HMVeZ8kHlkJY5tnm0IgMvEc91LpwWloB067jmDrWFRC6mqLPE8Grzin6jwhekoI7rCnOLO83qeq/Dp1XIPYt/mvrh/n0PQdaeylmuTkrV5YKvQD/DOzn7jJvBhLxyRy1dSIR8hh3K2kwcAV1okdWv+BYpMysPe9W7M/XoXFILamDD0wpGG2ZN2dOESpiSlu321aGyb1gHGlzoVNLAwxC+ncwbcZYA//grQo0uUkWmuOzL2XMP5J10boRIVsvQWIzejl1Ly5kezdt5ZiFt2/md5vojRUKRnURcMtbv1k85moJRSy3nV1ELjR
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(316002)(5660300002)(8936002)(8676002)(41300700001)(4326008)(66899021)(110136005)(2906002)(40460700003)(70206006)(70586007)(36860700001)(54906003)(36756003)(40480700001)(6666004)(7696005)(1076003)(186003)(107886003)(26005)(82740400003)(47076005)(2616005)(86362001)(356005)(7636003)(336012)(426003)(82310400005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 13:49:26.3728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef4fca2-9b71-48e6-f7a7-08db586fdc69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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

The current implementation utilizes a bitmap for managing IRQ resend
handlers, which is allocated based on the SPARSE_IRQ/NR_IRQS macros.
However, this method may not efficiently utilize memory during runtime,
particularly when IRQ_BITMAP_BITS is large.

Address this issue by using the hlist to manage IRQ resend handlers
instead of relying on a static bitmap memory allocation. Additionally,
a new function, clear_irq_resend(), is introduced and called from
irq_shutdown to ensure a graceful teardown of the interrupt.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 include/linux/irqdesc.h |  3 +++
 kernel/irq/chip.c       |  1 +
 kernel/irq/internals.h  |  2 ++
 kernel/irq/irqdesc.c    |  2 ++
 kernel/irq/resend.c     | 47 ++++++++++++++++++++++++++---------------
 5 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 844a8e30e6de..d9451d456a73 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -102,6 +102,9 @@ struct irq_desc {
 	int			parent_irq;
 	struct module		*owner;
 	const char		*name;
+#ifdef CONFIG_HARDIRQS_SW_RESEND
+	struct hlist_node	resend_node;
+#endif
 } ____cacheline_internodealigned_in_smp;
 
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fec..2eac5532c3c8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -306,6 +306,7 @@ static void __irq_disable(struct irq_desc *desc, bool mask);
 void irq_shutdown(struct irq_desc *desc)
 {
 	if (irqd_is_started(&desc->irq_data)) {
+		clear_irq_resend(desc);
 		desc->depth = 1;
 		if (desc->irq_data.chip->irq_shutdown) {
 			desc->irq_data.chip->irq_shutdown(&desc->irq_data);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b557579..51fc8c497c22 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -113,6 +113,8 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
 
 /* Resending of interrupts :*/
 int check_irq_resend(struct irq_desc *desc, bool inject);
+void clear_irq_resend(struct irq_desc *desc);
+void irq_resend_init(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 240e145e969f..b401b89b226a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -415,6 +415,7 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	desc_set_defaults(irq, desc, node, affinity, owner);
 	irqd_set(&desc->irq_data, flags);
 	kobject_init(&desc->kobj, &irq_kobj_type);
+	irq_resend_init(desc);
 
 	return desc;
 
@@ -581,6 +582,7 @@ int __init early_irq_init(void)
 		mutex_init(&desc[i].request_mutex);
 		init_waitqueue_head(&desc[i].wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
+		irq_resend_init(desc);
 	}
 	return arch_early_irq_init();
 }
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 0c46e9fe3a89..edec335c0a7a 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -21,8 +21,9 @@
 
 #ifdef CONFIG_HARDIRQS_SW_RESEND
 
-/* Bitmap to handle software resend of interrupts: */
-static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
+/* hlist_head to handle software resend of interrupts: */
+static HLIST_HEAD(irq_resend_list);
+static DEFINE_RAW_SPINLOCK(irq_resend_lock);
 
 /*
  * Run software resends of IRQ's
@@ -30,18 +31,17 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
 static void resend_irqs(struct tasklet_struct *unused)
 {
 	struct irq_desc *desc;
-	int irq;
-
-	while (!bitmap_empty(irqs_resend, nr_irqs)) {
-		irq = find_first_bit(irqs_resend, nr_irqs);
-		clear_bit(irq, irqs_resend);
-		desc = irq_to_desc(irq);
-		if (!desc)
-			continue;
-		local_irq_disable();
+
+	raw_spin_lock_irq(&irq_resend_lock);
+	while (!hlist_empty(&irq_resend_list)) {
+		desc = hlist_entry(irq_resend_list.first, struct irq_desc,
+				   resend_node);
+		hlist_del_init(&desc->resend_node);
+		raw_spin_unlock(&irq_resend_lock);
 		desc->handle_irq(desc);
-		local_irq_enable();
+		raw_spin_lock(&irq_resend_lock);
 	}
+	raw_spin_unlock_irq(&irq_resend_lock);
 }
 
 /* Tasklet to handle resend: */
@@ -49,8 +49,6 @@ static DECLARE_TASKLET(resend_tasklet, resend_irqs);
 
 static int irq_sw_resend(struct irq_desc *desc)
 {
-	unsigned int irq = irq_desc_get_irq(desc);
-
 	/*
 	 * Validate whether this interrupt can be safely injected from
 	 * non interrupt context
@@ -70,16 +68,31 @@ static int irq_sw_resend(struct irq_desc *desc)
 		 */
 		if (!desc->parent_irq)
 			return -EINVAL;
-		irq = desc->parent_irq;
 	}
 
-	/* Set it pending and activate the softirq: */
-	set_bit(irq, irqs_resend);
+	/* Add to resend_list and activate the softirq: */
+	raw_spin_lock(&irq_resend_lock);
+	hlist_add_head(&desc->resend_node, &irq_resend_list);
+	raw_spin_unlock(&irq_resend_lock);
 	tasklet_schedule(&resend_tasklet);
 	return 0;
 }
 
+void clear_irq_resend(struct irq_desc *desc)
+{
+	raw_spin_lock(&irq_resend_lock);
+	hlist_del_init(&desc->resend_node);
+	raw_spin_unlock(&irq_resend_lock);
+}
+
+void irq_resend_init(struct irq_desc *desc)
+{
+	INIT_HLIST_NODE(&desc->resend_node);
+}
 #else
+void clear_irq_resend(struct irq_desc *desc) {}
+void irq_resend_init(struct irq_desc *desc) {}
+
 static int irq_sw_resend(struct irq_desc *desc)
 {
 	return -EINVAL;
-- 
2.25.1

