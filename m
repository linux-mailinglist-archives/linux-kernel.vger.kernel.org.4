Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2068035E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjA3A5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjA3A5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:57:42 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86871D902
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:57:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHcABKldkwwFAulh93KksM8ZsG5VcukM7meoykmDiGLb9BoA6n0+vhbQKCFa4Yqhc+9Q5Mp8EPFCtxLF6pRHPJ23bxEnWC+nkA8A6uQiYtw9g81ihpDRNrc87aRZ5VpT6PnGc/hJrorctg3CtmO49BPnA09Ki6oIZbjqCW2V19tx3zLOxD66PrpiRWiFV9AV3QwzSXHFXOeL3c+ejwFkg5eqbHNHHGLdvHYpFeGFdgONkK0UOjXdNbPs+HS4qapViYeSj2AZ894r/50pciq5tIsOOwsBFZ6hZerraNGWZfvVik/wL1EbOOgA8Z53CYkw4fJaIrzp9GSDz803XBzOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhmD9vN4o0O4nOaFm8xTn+HlOYw/61BbKs+8PhsBJr4=;
 b=aaI2KqZKu8YwVGoRt5YrUW02X4AuC4glcXGnglo3sJsJW9byHNrDy6FdOqQyzTUil6WayGMYpwT8DOBnyXcI9NHVKHEurwAVWkTY6RpN/U10RwvYzaFHuQrW5vVbyJyBazD7eF1SeqroCBMOVKelPco0vzRmMaLyIhPpA0MNhiTQNmsS4xviBWAfZER3Lpu9ZZ3sYDtIVjiJtwLg0ZemC6VM4asXKUoYNNPdT+InZz3D34F0icwM6EEBYgUD4nE5a9gEkfkY0LgkM80pciVvOh4jDTt5T/y/+m9nNCOMBLBGF+WKR7AlgqfXqk6XRgD5vpQ9Q+j8DQrwS3rWI3BTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhmD9vN4o0O4nOaFm8xTn+HlOYw/61BbKs+8PhsBJr4=;
 b=TNnSEtlxdMRAFfswE0d8sR37IFYrsJlKf2L9tEgn8+9dpAaa+resopKe7L+aD+hRDrOQowhjDqLENgzUFJW2gI6R1Mgwvw3U0eb4gObrrYa3FZd26EA5x+uWTnyqMuvKrAU7iJ50CcU4pI0nF2zTNHFAzjFZNrhBTVQ7wZ4nJSsUa1ChtV9iighbKYVf+pRDj45CohGIOqM0Xhde9MJFFel06jTMgvOs1vn6MizdFT+kM80g+yKuF6XTkZwiDynuB9uFvikpEKCEGIV/THY1vspfyrhhZ2eWaKhVH0Ref44PibOfv4jZGvmPnl+uhbofWeVP2T17aVaFOZ83b4fobw==
Received: from CY5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:930::35) by
 BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 00:57:37 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::a6) by CY5PR13CA0019.outlook.office365.com
 (2603:10b6:930::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20 via Frontend
 Transport; Mon, 30 Jan 2023 00:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.3 via Frontend Transport; Mon, 30 Jan 2023 00:57:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:29 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:29 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 16:57:28 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] genirq: Introduce two helper functions
Date:   Sun, 29 Jan 2023 18:57:23 -0600
Message-ID: <20230130005725.3517597-4-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130005725.3517597-1-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|BL0PR12MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8611bb-fcc8-45aa-c0ce-08db025cfb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkh4scsXdwc2BT2zNRzAkk92boWbCVSLtmF5keWhXC4OdjUbOclouKU1F3iqTsGpI3ZazDh8ymxmbY9EnXB4p7X6Sl0V4txb1tjBqow0bCen7o4TdOqoEbMeW6weu3rl3A8nWzXauBnTLfVNfO9DKim3c3oodYMc32g1yYEwJQPUiWerRT2PNwwiKMb0mmKcPkUIGa29nMo8I1WvyUa5sVHUw+ZAyVn3IxgpkcXFHXKszXXZtK6d8Es1n2GGN/Ie6TtozJmyx2Wm+kkGvau3oq1IhagrLqhLWeVpcEPPeJrB4Auy8FviXFR8sNFOZ6Z8GNdQ8hbdivNU77YL9WgEkb0WRZQQs3JWmBb8zypeRGtUZd6ghv6DCCA3I3c3I2RerKCWlV3DkQnz5HwYfpAzqPcpmor0H0Rq4+CgX08Ts21kNr9iObMdA4sgD0Siwq0rJY9u+N8zV3uGwNMEsfdeURPg9VB1jjDjMckfpqNSdg2bz5BBqPRuYEsGkhH+PfVJAEKvmzTHip9dOckB6XLmhpbds1h1ZGrhPsprwV40SWhASQTbkRQyGBz4W8udQnffYUaVtqhMtiYeC2KJf4gBnbkGSFr3rkvC8EwTdrV8XTAhy6j3482ydUzQIt2iFS6XO7qZaRLRVlOz7nY6Wq1QC8a8jOoMnwdt0q77QjYHoa0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39850400004)(376002)(346002)(136003)(451199018)(46966006)(36840700001)(83380400001)(2616005)(86362001)(47076005)(426003)(336012)(7636003)(82740400003)(82310400005)(356005)(36860700001)(2906002)(7696005)(36756003)(1076003)(186003)(26005)(478600001)(40480700001)(6666004)(8676002)(8936002)(4326008)(41300700001)(70586007)(70206006)(54906003)(5660300002)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 00:57:37.3249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8611bb-fcc8-45aa-c0ce-08db025cfb01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4995
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce helper functions irq_find_free_area() and irq_find_next_irq().
The first function is used to locate available free space for a new IRQ,
and the second one is used to find the next valid IRQ.

These helper functions will be later modified to utilize the Maple data
structure in a later patch. Additionally, in order to align the moving
to the new data structure, the IRQ_BITMAP_BITS is renamed to
MAX_SPARSE_IRQS.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/irq/internals.h |  4 ++--
 kernel/irq/irqdesc.c   | 28 +++++++++++++++++++---------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 2fd17057ed4b..5d741b0e7d5e 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -12,9 +12,9 @@
 #include <linux/sched/clock.h>
 
 #ifdef CONFIG_SPARSE_IRQ
-# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
+# define MAX_SPARSE_IRQS	(NR_IRQS + 8196)
 #else
-# define IRQ_BITMAP_BITS	NR_IRQS
+# define MAX_SPARSE_IRQS	NR_IRQS
 #endif
 
 #define istate core_internal_state__do_not_mess_with_it
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a4911f7ebb07..aacfb4826c5e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -131,7 +131,18 @@ int nr_irqs = NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
 
 static DEFINE_MUTEX(sparse_irq_lock);
-static DECLARE_BITMAP(allocated_irqs, IRQ_BITMAP_BITS);
+static DECLARE_BITMAP(allocated_irqs, MAX_SPARSE_IRQS);
+
+static int irq_find_free_area(unsigned int from, unsigned int cnt)
+{
+	return bitmap_find_next_zero_area(allocated_irqs, MAX_SPARSE_IRQS,
+					  from, cnt, 0);
+}
+
+static unsigned int irq_find_next_irq(unsigned int offset)
+{
+	return find_next_bit(allocated_irqs, nr_irqs, offset);
+}
 
 #ifdef CONFIG_SPARSE_IRQ
 
@@ -519,7 +530,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 
 static int irq_expand_nr_irqs(unsigned int nr)
 {
-	if (nr > IRQ_BITMAP_BITS)
+	if (nr > MAX_SPARSE_IRQS)
 		return -ENOMEM;
 	nr_irqs = nr;
 	return 0;
@@ -537,11 +548,11 @@ int __init early_irq_init(void)
 	printk(KERN_INFO "NR_IRQS: %d, nr_irqs: %d, preallocated irqs: %d\n",
 	       NR_IRQS, nr_irqs, initcnt);
 
-	if (WARN_ON(nr_irqs > IRQ_BITMAP_BITS))
-		nr_irqs = IRQ_BITMAP_BITS;
+	if (WARN_ON(nr_irqs > MAX_SPARSE_IRQS))
+		nr_irqs = MAX_SPARSE_IRQS;
 
-	if (WARN_ON(initcnt > IRQ_BITMAP_BITS))
-		initcnt = IRQ_BITMAP_BITS;
+	if (WARN_ON(initcnt > MAX_SPARSE_IRQS))
+		initcnt = MAX_SPARSE_IRQS;
 
 	if (initcnt > nr_irqs)
 		nr_irqs = initcnt;
@@ -813,8 +824,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 
 	mutex_lock(&sparse_irq_lock);
 
-	start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
-					   from, cnt, 0);
+	start = irq_find_free_area(from, cnt);
 	ret = -EEXIST;
 	if (irq >=0 && start != irq)
 		goto unlock;
@@ -839,7 +849,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	return irq_find_next_irq(offset);
 }
 
 struct irq_desc *
-- 
2.25.1

