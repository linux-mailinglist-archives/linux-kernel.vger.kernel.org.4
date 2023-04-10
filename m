Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF26DC8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjDJP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDJP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:57:33 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F32F171C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNL590l8fj9U20A+OUSMPvoGuBicY9cOdyjr3mBO8TIxfKbYJ6ddTmBvxLtIYaQihPynNl6ZnJr4ZWh/VIQmso01rZFKLo2M9fQr/VpB2ItyArIbtBrUCuVmSZineaFwy47IOVJarJ/5WcUUhu/9bRjZFGys88AsSHIitSBb+YntoIC01NQ67lpIHAqmnd3qd053rhogJ264xkIXj+FPCI4d7VCnPNUAfEazqyl4TfXYZjPD7RFsS3ZuHJc6CAX+mrNSulUF+w9v0/EEDcKfXkgFssnIvUgpYSbt76wHyQpX3UgE6eS1JKRGJIMCsw5wvCgD/r6A22SWcPeoTR6QXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH2FJ3ygWRVmXHPyWjnyKBW3RGtReAKw2JojLX8VxJo=;
 b=OXHo1b3f9YfAaj0jxzk15e48Keky5q6lJ1va+tPEGtT/A15kYprRruAy+EIIgXKUpVu0nWZlxqHLmbdLuueutIIlC1vwDgBbWyIQ9arGAhEdgFcPDJnHnf5g5i5FnLXYREzsJymJY7VXnM9WVNQP6HqE3PIV27xB59EwBpdpKuoCW8krbmKClhlhDvwpS+HtWwKHRZCMJXTJq3XE/ZaCMy9jRsypSxFTHzzzM0xTxG1bjBJ9TRhpEs6Ov8WWmF1QqbFKsbMyeXu3cAO2rdzszvd0gcby5f7kwYbD/OGfKEBnAAp0pwnIB+BKggc7fjiQLLTAGDpqUjWsOOXThGJY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH2FJ3ygWRVmXHPyWjnyKBW3RGtReAKw2JojLX8VxJo=;
 b=KYzheKwCyUv9nx/8DReoXlin2yxC88fVOVwh1RUT2a83MeHwdAj2YIM9paGDsAoLAh/3mbw8zI6W+1G+yluGta+rhGt/C0ysvpOzEvbZXPPXlrQOEotzLlnJfp2raQDqdd4QLaL3YEfwAdtFs8JZLJCvVx6OSJ4EB/2v1OkYbf1NA4VVqq0NU/FNvoSXYLwhOP8SSV1C0mG+6bHr6Y/YjMxsXCfadyNPgn45ny2RuAjrlP8vxfxDEO4Tut2tfL8MuMEFKzm+4DdC7/taVJAbNOSbA15U6UEeqYFeHkXoSIUlZtTTtqXS4tshjGxZrID81uiNfHvrm7hA9lA3XKUFtA==
Received: from DS7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::29) by
 PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 15:57:28 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::b2) by DS7P222CA0008.outlook.office365.com
 (2603:10b6:8:2e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 15:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.27 via Frontend Transport; Mon, 10 Apr 2023 15:57:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Apr 2023
 08:57:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Apr
 2023 08:57:24 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 10 Apr 2023 08:57:24 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: [PATCH v3 1/3] genirq: Use hlist for managing resend handlers
Date:   Mon, 10 Apr 2023 10:57:19 -0500
Message-ID: <20230410155721.3720991-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410155721.3720991-1-sdonthineni@nvidia.com>
References: <20230410155721.3720991-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: c04ef78d-6e44-4aa1-f46e-08db39dc48d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRlHh+bKWj+gmQkOQOX8u9Dd9GRAB35qhNb6cRAafB7sYMe3D7b2NYWhkYQly3bC42THQ0q3EHbBjVPYdpF2MqdRyMK0GaYqXLmlZu7N4mLh8ZzwfuUmuPSSnCKat/nfJ7qw6io6rlltnmr7Y1SJGeNczxp2HKjU6JeVeCLkVv304AM8KX4mojcidpzx+h74LizAKBFO6tCvCJYdxxFcukBlzMAqm6O3+3AdNF9XtnKiUB2la2N+FZBS+STCHEgc/Y0eSgMW6ZO+PFtAdSIiYNzvHZVoqcHE1/XiMjWZLjgJlQFzCzhC7g6HVPOHdVkweN5ZC4VD56mzhmoWfpF2cf9Jnn3hSDZvmvebks/kvsFTiJT1tn3adxsmJ3TVXuy3tKDkQBjXfCGxzl7rIWJys3s90vifAiDM8TVkenEHz51lLx8f6m1uUuQaXblVcTROGtn15HrhwvVROt590GIUsmflHfvNdbN3Ur1pef78wQOQrjURlla4ebV2BUlPdgZP8NhhMF4zT/JwiCYx7dp0eTBlAEjkTTQ/gw4Y3n6L4zJuzaWuxSj/RJFRaP8RVT7ifZWsgvpzfEr4V+Tl7V/Xa+T7WkGr5ZzyoNCxg2xNrRb+AYKPJ7BZw3Vd+SVO6CXmHDxMR8yjCcoxTNEM4YrMJDnOwYGOZOHsYeBDtC7YLvOJX9hWAbkCSww4hDu3QIp8JPj1oCtuEFg6Z42un8TxPYFtWu0k4fkC2IjfX9Lf25+TSW08A77Yy4HjPzHvlbEw
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(316002)(110136005)(82310400005)(54906003)(356005)(7636003)(36860700001)(82740400003)(70586007)(8676002)(70206006)(86362001)(478600001)(4326008)(83380400001)(336012)(426003)(47076005)(2616005)(186003)(41300700001)(36756003)(2906002)(1076003)(26005)(7696005)(66899021)(40460700003)(40480700001)(8936002)(6666004)(107886003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 15:57:27.9482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04ef78d-6e44-4aa1-f46e-08db39dc48d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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

