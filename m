Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA86C6DBC48
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 19:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDHRPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDHRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 13:15:38 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD839039
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 10:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW5Zf++eOUHY+0dInIh3CfP8LdB2bVQ2jFu/1LEr890Dyfkz6y9QLaRqGv3IOq+YK/UIVFUvZJduMS3PFOPaxtlsjawHUTdM/pXuKt0xqD7y7mI2paTdz6PWEC1Gfdc60AkasFoJYBouPhwZ11kyWaHBWIAAG8vc+w4c/1bQt6uyTWgB1vkASrIVcQVK6QPc0gWyqUXSTcZDafOGirvu6NAokwUJNdF4OlbihPJv9Q7QOeM8RzkB+35kiy/7PE4/HePKASXk46om/gkGSbcr69ygxzycqzeCetjfAM0O42ZEKY70mIK4CT++8ar/NuiDIIlanGIMJU3wgsddeTmpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkLIcfRxzpXyRiMGwqBTKZaXIqEzmMDORigtOmxoe/E=;
 b=ZtcM2u7e3NMo/5KmhXNb5LduZ/1OMzmcItuwGHzR8FevXAmZdrVV3Qwo/iOIRubyogiNI4BvkHkKFFMMZxGFTPGWCAwX+OS+hF55ZK8G4EwTZCMtDULecurv6BdmFg3y936V9APGi/UYKglkcABgSe2tkvGGoJRRstxYWHHC/96Vw8ITyejpGoSuZCQH7rwQSLaHAabyfgwuV1ZIhQFs84I2qcYXcuu1pA6yVZZYh/ukqXJol0vR3u1hM3SH7GpazLKp5kY0K6x4EX3bF5/l7x2Alb1SX01qqQ7FWW9P2VQX5e02MOhGhCrON5b3PeaCbtJgX8T7BbYC+7rGD0ODJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkLIcfRxzpXyRiMGwqBTKZaXIqEzmMDORigtOmxoe/E=;
 b=DKrUpwGRulT7BdH+M1ve3SQJwvIG6WEvu39dOnA2MNPpjvtUR5SMM5ygC1VKnvYM6UMAKQNU3az5kWLS1geO1YswPd46ufEDKEV1319tSnTBpe1TudBvaAyQhelzot0RPulPQwmL8qE4SnYcFeOC4Uu7YbvMuesQbQUUOPoxLNycFsa70tJweCUKSYO2qPX2cG2qx2Y2vofKdhCCayzI5YkGc2rVgzNHQBAGpGoQy5JcLrLAQP4Yctu0IgDxC9dJgwtIUdY0LjgeosDbaClmlCq32mX8Y+hUw3DTwoTqk2DUQx2fw7PPJA4bqSn+ZP4GiN9JTS1g2jy0ye5I20f1Vg==
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Sat, 8 Apr
 2023 17:15:34 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::c5) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Sat, 8 Apr 2023 17:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.20 via Frontend Transport; Sat, 8 Apr 2023 17:15:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 8 Apr 2023
 10:15:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sat, 8 Apr 2023 10:15:29 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sat, 8 Apr 2023 10:15:28 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 1/3] genirq: Use hlist for managing resend handlers
Date:   Sat, 8 Apr 2023 12:15:24 -0500
Message-ID: <20230408171526.3059039-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230408171526.3059039-1-sdonthineni@nvidia.com>
References: <20230408171526.3059039-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f28643-dead-461b-5435-08db3854dd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iE1j07dxMaB+NZH23TRvpE67ZGHjjzEiME2zt0dmxLxI1CrN5ilmTrKwBf19JJXIr67Nf8eBMJ4W33T8hRz2wqpIeQBiKedzBxdJohALNHXUPdMoZRApPhMxJQsEYdY996WnVV3lzRN1oPLDz2eDBCH6/cunUWpjOspLymezpU7ISzb3Q1+/V8uKqMb3jHQiUzI0H2G55yrbOCwMXOP4ddeMgCp5OGMlXErTa+lUuI96fULc223v9mYX8kjwdPMIgZqfLdbHaWTfj12+b1OCzVm7JnEFOllu/CtqvkjM6xANZXSIGpkgFfpIpP/g0iW2FDmUuLjpr72kILu9SUTJiJ0iVHbUVtV+4MWO+Yg8WG6KnKNXZDMDpH/ZYaFMHfsLXEXPGz5j7ztJ15dC3uokDp7UVeDsaphiV17tqTKNlxJknmji6MQX5D2fopa1UBHt4cCJt6GI396/QhXPwUE6kPLKpUZD22q9EFedJ3iH5qiOH2bUTcxgHvHVIAHrNL38rO/GPviEEOI0nQ3pVazuvNnKeSM5a20/mOcTlwTDh4IFqSNBDrCn0n09NP/LufbyZYhGxx0SihC/64vLemdEtscxq0hm2bpyAuvl6pB/XACoS3d5Vr4XDdKPL+3fadhAIsj0XqhMrKgutyD+rcAilTd3yzJ7i+0sSBKhKZS8bkbwvMxSuw8l8rDN5EWZVTsqhU1QDIt3SBe38U/bcXqj2WySwAsGgliv6n1n4Xw59iE0s+TvBv6c3Z1tXo8c8swV
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(316002)(66899021)(40480700001)(6666004)(36756003)(41300700001)(82310400005)(40460700003)(8936002)(47076005)(110136005)(7696005)(86362001)(2616005)(54906003)(186003)(336012)(426003)(82740400003)(1076003)(356005)(5660300002)(26005)(83380400001)(36860700001)(7636003)(2906002)(70206006)(478600001)(70586007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 17:15:34.1505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f28643-dead-461b-5435-08db3854dd3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
 kernel/irq/resend.c     | 41 ++++++++++++++++++++++++-----------------
 5 files changed, 35 insertions(+), 17 deletions(-)

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
index 240e145e969f..47543b5a0edb 100644
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
index 0c46e9fe3a89..d3db2628a720 100644
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
@@ -70,16 +68,25 @@ static int irq_sw_resend(struct irq_desc *desc)
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

