Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9066FE2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjEJRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjEJRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:01:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2555276
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3NmH8giGPl2ObqkYCculHxfKOrUOeBbVLHaQwIIWCWrq9ZtrBC3yFyhLjXPlJ5Hf30fa2Tf+C6DqJBNrFQKBlKHMdlBHSFECp9eHhP0Ysb4TDGQjmvbrYmO8S6o0qQ7KrYA6LhR7y7TuJBdfopUr6JaSgOEBN1Mgu/Qrqbny6h6bkO0+cQ1lKSjVmA1Jmmy1qrZbX0263aYW32lfJKh5aRHD4w/jGfQUj3N6fSPaiE0uNEvLIHEYdDrB8hDCNcEoC8jlLtTyzSnF7bA5SuTta56PYHdnYZzf2owjv6pCASZcYM/GIDsszwxIVcJYp/zPPVwauyBzIN7OIUXNdiQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky4CB32ozZd9qAtAa/WjvehHmvjU53PQ4iFrAkPy44w=;
 b=k+zuMk31B8IcsnRtz4+I6Jb3ZBBKU4ney46l/e7+t4QbkCSjjut074W6X3s0uiSPbEhbqD96kIylNF7mVhW0+sW/Wr8+IfrAw6TtQOYLG3XjkbM/DIADrrdGCRlz7cMRQwDgNGweS53LbQLo2X9DMaZXmy9IWxGYOU9jp3q3XkwjlLJA/YofTB5l1XVOPObDZEJbpqC0ex3dR509CxwU01F0V4an7J2VnkrkseroAexPJkjACpdW5DRThFPNn8D81GOoSzaktIO15A74EIs5Bog7ravVZSqKGqNMCQJYk+E9shKlX+6a/7W4ypfh8jqZc3AJy+wIe4ACsAgT+z8PCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky4CB32ozZd9qAtAa/WjvehHmvjU53PQ4iFrAkPy44w=;
 b=Uwnl6DvHJo1OHtomoonsLuPzi09Dxffdk9oFLcaQf67vVH44DAssh4K8tiI4VVL9q2QnQ5qLE4YmJJqVE1NJ8TRN3tcexgHUntHkw6EhvvvWDOSQQZUzdsznRgEQVwGqG+G4FEtqgENMGct544WUEsEgLTiaaL4AleuU2mvyoiUhh1eiMQMj+9gmy+z3JANk+xUkkTn5xqFx2+U/zxxaiu4PQ0IAymNR11CoNqCBBQOvo0hFf3Ew4I5lomQ4aU9gkpLzy2OHaZwBnV2uAOh/VGCETivkh90638F2AxPw60+TXw6x6thtOOj88X0z8UVnN3jx3RpXJBVY3ha9notSRQ==
Received: from MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::19)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 17:01:02 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::a1) by MW4P223CA0014.outlook.office365.com
 (2603:10b6:303:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 17:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 17:01:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 10:00:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 10:00:48 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 10:00:47 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Jason Sequeira" <jsequeira@nvidia.com>
Subject: [PATCH v4 1/3] genirq: Use hlist for managing resend handlers
Date:   Wed, 10 May 2023 12:00:31 -0500
Message-ID: <20230510170033.3303076-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510170033.3303076-1-sdonthineni@nvidia.com>
References: <20230510170033.3303076-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8ecde5-ba59-4305-8aa4-08db51782223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HItiERa+r4/iwJX+20Zam9tXqwCeOGR3MfltA2UWFBA3Y6G0VSBdgAkemBhZLKD5FXId+b/K+baDBA5nniUzrrv5Ha0DwX1rdWuOzeQmO6rsQrwMdGTXQ2VQbC9jS+7XJcUmLuRJaMdd8rnys1V97iw9qPmr5QEyB5jKj7al+ZMd3i670oY/h/j+jXkVFYGY+MDrYJlQ0LabTCmsEbBFsbBkSfp38eIR7EVV46yiV+HKsy01ZzkygVSa5dbUHN1j1KctnV75bKUNROYBjqUTmJtPC79SVJWntEZ9IinnaZhhrGnzqwEvv9+GFfKY8btkem1twoh7fW8EQop1ZpGZDImGum4m+1Tjq9qs5GCzLss7df9ujEi67UAGIP+NNaaB+KUJei8Kp5XlzKu7yBycCpfHDBjkZCGntd7bYHx3CoO3XGWgKnoP72ZeCEI6mbt5SFn/KffcNoFfTZG0cjSHiT66s6sLw7D7rxySiUY5TeIVItJ+32s0+ZP+RItWA1PgNtN9WweZnQfb7CJDW81ZSFKaEJ4qkEHm/Scvid30aqIcIFtTV7AfS0npsUVwwai42Qhx6wq2HuFxrmpLhaYvyH2u5Cv0mzn51w1Hof4Pv8QobyMfUk/HmeApgKYZ446+0tJJBuVIvLMfK97xgBTs2enfNjFNzc0/HEZq+7UbzYeFW1K1knqY2Ub6LtBkpjLb0E25QEFW3IUVXRSk3vFWA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(66899021)(4326008)(7696005)(316002)(70586007)(478600001)(70206006)(54906003)(110136005)(36756003)(86362001)(47076005)(426003)(336012)(83380400001)(107886003)(2616005)(26005)(36860700001)(1076003)(6666004)(8936002)(41300700001)(8676002)(82310400005)(5660300002)(40480700001)(2906002)(7636003)(186003)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:01:01.2799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8ecde5-ba59-4305-8aa4-08db51782223
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717
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
index fd0996274401..f4cb34c87ae7 100644
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

