Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D46DC8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjDJP5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjDJP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:57:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D677D4EC6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVuR0BuOqVpR3KJm+Lg+D4rykBA3rnlhWjcnPQskwPUDhrZmFEeD3+QFqQqKAWTe8O3qs2Xm13dElPrnlqxSgZ5Ct9wSaFCkO7sBJebmIebyOFDx0IJkWJLQuYThlPHL/emAyWCwoNO9Ym/bNeB1UNSb4oYvPo6oeLwCZCAGkaU9KcgJWk3GJj1mZW/rvUnjpnO5+jB7pz/Tfzf4P/aCApugmcamlnKNM2OWS4Ss83vdTXZO+PIoXTPFCTL1GzWZKNuvWyby10DiqGfDB2Ga8ep412Q9o918Owk8n8NhtaNpEt5T1OBg35DlVdOotf0caGhJvBjIHxNx2SlvqWj7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aF/H+uiUkhuf5m7x27G909EICjt6oClo09RST+Zy+Q=;
 b=nyw6bhIOiTjSES7AzcINBsgy0kZjBTpW0LcO46EzUaCPIQu1Tvqi7mk7+xgAw57qtMkCezgWYUVQUl4q6NJRp07jr31Hsk0Sx5fjAcp/wXPyrSEh/SBgegNOrkBvEn4lgSGWKt3mlKAgYLY2fdvuhEeXPqgNLEU9LNs0wOAzcXsobCXt8G5I8/pgiPzmAj3yViKACURUhw41+fiYy0T9JQiSRTJDA5N847NEySe+9mRIqL+cTWLJstp+80lJrVrPgoMewVrvRBfpjq9XmqDoh4MNSGW5e9dqAVYBqSA/L2NDHFBC9n9s1bPDXc21HgYDlQhPVWH9a55UOzb4WTTmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aF/H+uiUkhuf5m7x27G909EICjt6oClo09RST+Zy+Q=;
 b=Q4kAoIwIR4akZL7RSsDztNIZ4aXL0uQEZ03Eq4+qj/akMqbNDzSxA0a1t9ENOw4yQyHmmI88VMKDlIIAokY/7wtaDAUxyVIWI3AfOLlMMuKdg06CfFB+UKliI2Umbzv67VBw+3Wy5tZAlJY3nG81IxgagfT4YZu0vXjsFnHtVkqYlkwqGGcH8Js2L3Z89W70R7SGdWxJ9LbEvcez2QbpH+eysYRUwn6h8psdJ6y/mYg1fQFfhmwZYqU+Wa9EiwPk3h/SxIctN73zeAq5QvHUwV0q34ZibbtW61tOmiioOwlbtkKncszMNdS995C4tXZmac0r6DEgPx8R3w+jgYOFNA==
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Mon, 10 Apr 2023 15:57:36 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::f9) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 15:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 15:57:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Apr 2023
 08:57:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Apr
 2023 08:57:25 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 10 Apr 2023 08:57:24 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: [PATCH v3 2/3] genirq: Encapsulate sparse bitmap handling
Date:   Mon, 10 Apr 2023 10:57:20 -0500
Message-ID: <20230410155721.3720991-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410155721.3720991-1-sdonthineni@nvidia.com>
References: <20230410155721.3720991-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: c50330b2-01cb-477b-f9a3-08db39dc4d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njLwA6lQ2RbKIxyrMX3lVOEhhXy4KCcX5KSHAXGPpmC4Q+ctd/ywQv6JHnmR5r9AXh4pciiFKGMY0eNtW6ti6YuQJzU6DDpOzsbipLB1PK+qFbcdfLXXWtgsj/32O2S5P9YQcq56tYiedFYr0YHYlVseJJeqEGTjrMf7tqvqJ29g0yToy+WO8gylG6+AxXv5Mj6731Lc6bZpxXCA7lB8C7CsQhWbcvA2HVS00lZmBbYw/nC6/6T12yO+HhlRaRrxmWNuMtwchqFiS/znUxegkbJ2t8ul4o3aeJGC4tEap+aoKOTxAMCUNbgvzjAo4+xSMHjBaftXT8FdyL5X3Kyvujdl/04WHj4z5LYFhNCRGzkJMob0bQjejxJj6hyXJU7o93BhXz3VhabGJ2cKSstOWIR8IppH1Xx7fQ/OnQkeX4FuKgI2oaVCnjDvVhwoDktuWsUeS94EGq3fsaUCAjyQ6QDc1oilyFM2WZVgfewraJz7kqn8ovWSA6obGECi7PyZbv9A9ss1kcwx3R85qMMTw9qxpzMSLYKdXrcQRayE1jfjaFva4s0v8ErXiFl/dqilLGGuvH5nS7nfN6CHVZRGmg1SAlhVRyW7tGe910INWvPhHlCo9XSjRyQkD7YAjxb1kUuSuQIxc9bWKSSy8W2jw5O/sfWwOgs6U2Z6iiHM0+Ax4zr6WT5gJ4aIsvNUaTXlo+hTfmRK0mmMKvvIVtdZEMNk+Vff091HKeSLhhFIsfFdJdJAoPZsaLTBmbXAystu
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(4326008)(478600001)(54906003)(7696005)(70586007)(8676002)(41300700001)(316002)(110136005)(86362001)(36756003)(83380400001)(426003)(2616005)(336012)(107886003)(1076003)(26005)(6666004)(8936002)(5660300002)(2906002)(82310400005)(40480700001)(36860700001)(82740400003)(356005)(7636003)(186003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 15:57:35.9060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50330b2-01cb-477b-f9a3-08db39dc4d9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the open coded sparse bitmap handling into helper functions as
a preparatory step for converting the sparse interrupt management
to a maple tree.

No functional change.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/irq/internals.h |  4 ++--
 kernel/irq/irqdesc.c   | 28 +++++++++++++++++++---------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 51fc8c497c22..f3f2090dd2de 100644
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
index b401b89b226a..9a71fc6f2c5f 100644
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
 
@@ -517,7 +528,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 
 static int irq_expand_nr_irqs(unsigned int nr)
 {
-	if (nr > IRQ_BITMAP_BITS)
+	if (nr > MAX_SPARSE_IRQS)
 		return -ENOMEM;
 	nr_irqs = nr;
 	return 0;
@@ -535,11 +546,11 @@ int __init early_irq_init(void)
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
@@ -812,8 +823,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 
 	mutex_lock(&sparse_irq_lock);
 
-	start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
-					   from, cnt, 0);
+	start = irq_find_free_area(from, cnt);
 	ret = -EEXIST;
 	if (irq >=0 && start != irq)
 		goto unlock;
@@ -838,7 +848,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	return irq_find_next_irq(offset);
 }
 
 struct irq_desc *
-- 
2.25.1

