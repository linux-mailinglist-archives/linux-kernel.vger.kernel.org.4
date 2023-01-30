Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A964A68035C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjA3A5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3A5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:57:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1E9BBAD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:57:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaY6DBCZz471v+cN2XsXY8Z5urmbhTwVypvSUX3UvHoRnAsCtdLawR2eBYaLcLf9ITqQ/6yLD9n/txd7B905xrv9uezYclnFP+9K1RbHpQES9NV6U6khR/A5/zOIjjFCr+CjIlweuMRlqHdoC5XZyj1k8K5Pj1XaBLGMYBdyY+1BtO/5x7yYVue4mEnO9+FSjz4QAPEG2paGjDCzHV3HFjsi734BQmAHcRRSg/Ewa2z+P1qMiWtvSGZBtIMteWnznQjkjn2wqjfdaUSz3/MhZYZ4e5y34F0G86VZ3NpDuBiO8clWHs+CjD/Dq8bwTrsYzxXKRWNkAlAX3ASLk08dUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkfYWlwKb/p1ZWP0Yi6oWxoN4cs5C1HoCJ++mocitkw=;
 b=RtJnP0eK1eNtVA4xvztsHyDCLuUbn706dltq8s/U+RO7lU/o0jfHaCH2uszL/0qGKAKzIIEAszh6L0onEE7gLQyYuJHypatHWyQmJdsMGs1yo/EwmDKdRn/tve2+UyZtgy8JTzqAx5fewSlQAI+1NHBfSI22pHQtCfjtZmGaUcvMInNEg5i6ZEIaDPrpa5wnxfDGyW2R1iSZULFomacg+v43ktAaiY7R0r4rhV+3YNrw0DQsHcYPx5dyA+2OXRMICChrd6C3cuA6XWI+0v0sCtWoxpf5qCb4cCw+r4QJpJlywMGFOwsijsSu71rHLHgCHKqOVtJvcwxgkWDCfS+8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkfYWlwKb/p1ZWP0Yi6oWxoN4cs5C1HoCJ++mocitkw=;
 b=AT7VVkwa+dZ40oIuz06U2HqzHdr04xZ56tDzIvXELND6sHT50PlIpQ05hj3EjtblD3whsA78pEsXChZDscRn7x3ytGQnoS+va2trORToQjaDvtpXvyU8yVwTiFZf9R1kX5P0wwJNN6mKcqIGLs8fmGg+ANUn+qj80ACHlzGAhF4V/aVu0Ef9C+acGLn5Uhhgl7LZ7KUqGlYLPtQ+I3M+Z0dlYIZabmOWAnopilZUVE161ADAYFubC+4alry3KpAYMSnA23Y8oICzcLmSgMcANH8Z3B20S2qRVXsOeRTbIwTQCH9u3kz+/R6mnU8kvF0AnAbPuMLbksEX6dwS730+xQ==
Received: from CY5PR13CA0027.namprd13.prod.outlook.com (2603:10b6:930::15) by
 DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.33; Mon, 30 Jan 2023 00:57:34 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::5b) by CY5PR13CA0027.outlook.office365.com
 (2603:10b6:930::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20 via Frontend
 Transport; Mon, 30 Jan 2023 00:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.3 via Frontend Transport; Mon, 30 Jan 2023 00:57:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:28 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:27 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 16:57:27 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] genirq: Use hlist for managing resend handlers
Date:   Sun, 29 Jan 2023 18:57:21 -0600
Message-ID: <20230130005725.3517597-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130005725.3517597-1-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d464cdb-3107-40a0-498d-08db025cf908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdQp8WWMUvSQBFIHGn2H3hisqRQv8qxCftO/0RCj/nqpenhDPvfF9HY0CpAYyI6ecdpBJL2regUXc5Qq0P/VwSe7gaYZVPb4EA7xC1CNBEbC9u8Ih6em/5xGL8G5YtUB/Lz7QAjd+rlD8I/cLvMR2KX6m1Omw5++Op36q1cJJfX6CHiVNGrIfqM81gDTm3OBGzjKdHGCJV658kp3bTil9zK2/gub18mQlaDHcjPMijo0vcT/6u18k+CjnhWMMwKn1SvCZPpyPmpis82DYutNpTQZSfWrjtgizeqrL6UYwTa9E5DOC7cqFOMRoSm2woIORj65Xz6l+d+3lyRQ24YhJSqLyMI647WiIUaNZUeMjFiro9o40D+KDn7r8JguQWAPKvIWBdisK4B1ZIoUn0EdNw6A+zuRdrLmPkPAFhEm/azaDC/fkA6RHeL6ENCgZ90bpKxidalEpgnRtmG/pr6ycUryM4Fd1VbbIwqs7QxNq9rDpFY6dMdQ3v+M18rmop9Ru+gplSr7N7f5i9Tuxy3mnl/1O4fNzc9SV3IvX7YaLe3MzzU4baAsb3wFooNdLL0MlwmCOzKY4VFqxAlsQlEGWhs9c+MOplgNGRlglKTT/fiVK3eGAY2s2znBKWziaa4bfzO4gJAnGU7xW32r8bbGttac7vndAw64ZSpCsQwb5Y9yUKZXqMOMDJRkUGLKKirmEVYvUXp5/0BNqosN5QYJvA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(66899018)(2906002)(8936002)(5660300002)(41300700001)(86362001)(83380400001)(26005)(70206006)(1076003)(6666004)(110136005)(4326008)(70586007)(40460700003)(8676002)(186003)(478600001)(7696005)(426003)(47076005)(336012)(2616005)(40480700001)(82310400005)(316002)(36756003)(82740400003)(54906003)(7636003)(356005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 00:57:34.0280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d464cdb-3107-40a0-498d-08db025cf908
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation utilizes a bitmap for managing IRQ resend
handlers, which is allocated based on the SPARSE_IRQ/NR_IRQS macros.
However, this method may not efficiently utilize memory during runtime,
particularly when IRQ_BITMAP_BITS is large.

This proposed patch aims to address this issue by using hlist to manage
IRQ resend handlers instead of relying on static memory allocation.
Additionally, a new function, clear_irq_resend(), is introduced and
called from irq_shutdown to ensure a graceful teardown of IRQD.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 include/linux/irqdesc.h |  3 +++
 kernel/irq/chip.c       |  1 +
 kernel/irq/internals.h  |  1 +
 kernel/irq/irqdesc.c    |  6 ++++++
 kernel/irq/resend.c     | 36 +++++++++++++++++++++---------------
 5 files changed, 32 insertions(+), 15 deletions(-)

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
index 5fdc0b557579..2fd17057ed4b 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -113,6 +113,7 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
 
 /* Resending of interrupts :*/
 int check_irq_resend(struct irq_desc *desc, bool inject);
+void clear_irq_resend(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index fd0996274401..21a968bc468b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -415,6 +415,9 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	desc_set_defaults(irq, desc, node, affinity, owner);
 	irqd_set(&desc->irq_data, flags);
 	kobject_init(&desc->kobj, &irq_kobj_type);
+#ifdef CONFIG_HARDIRQS_SW_RESEND
+	INIT_HLIST_NODE(&desc->resend_node);
+#endif
 
 	return desc;
 
@@ -581,6 +584,9 @@ int __init early_irq_init(void)
 		mutex_init(&desc[i].request_mutex);
 		init_waitqueue_head(&desc[i].wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
+#ifdef CONFIG_HARDIRQS_SW_RESEND
+		INIT_HLIST_NODE(&desc->resend_node);
+#endif
 	}
 	return arch_early_irq_init();
 }
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 0c46e9fe3a89..f2b23871cbef 100644
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
@@ -30,18 +31,16 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
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
+	struct hlist_node *n;
+
+	raw_spin_lock_irq(&irq_resend_lock);
+	hlist_for_each_entry_safe(desc, n, &irq_resend_list, resend_node) {
+		hlist_del_init(&desc->resend_node);
 		local_irq_disable();
 		desc->handle_irq(desc);
 		local_irq_enable();
 	}
+	raw_spin_unlock_irq(&irq_resend_lock);
 }
 
 /* Tasklet to handle resend: */
@@ -49,8 +48,6 @@ static DECLARE_TASKLET(resend_tasklet, resend_irqs);
 
 static int irq_sw_resend(struct irq_desc *desc)
 {
-	unsigned int irq = irq_desc_get_irq(desc);
-
 	/*
 	 * Validate whether this interrupt can be safely injected from
 	 * non interrupt context
@@ -70,16 +67,25 @@ static int irq_sw_resend(struct irq_desc *desc)
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
 #else
+void clear_irq_resend(struct irq_desc *desc) {}
+
 static int irq_sw_resend(struct irq_desc *desc)
 {
 	return -EINVAL;
-- 
2.25.1

