Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D564E6FE2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjEJRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjEJRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:01:15 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19095B8A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBZ45y7aAWgyC/4NX6fYMfgDf3lMoY/3LB2hAgWdFSG2TCJORSnzwC7UokNT5aNbCa3r+4jwA34rf8xLnfPC96jrbdV/CMI9SB4P5zZTvIsbWlkbFzSwkGgFL5nyKaG65EnNSrEvzFd5/7k9qfw+paU1bcJXO5/zS8XoYnIsFL0PQ/JMXSU5VVcwhzdHzQuOKv8s7Vtx7Mv88ynTtlbCwSPrlcNKeF6R8ErLm0f9Ki7ZctFJYLgLzDMFqODWCCJddjc3mEbWa+yaArHi7HyBWZuj/MmITBWbB5sbGzWor7I2vcCyJQ5td0so1bfSJ5Yfq5817JvT0zljbQYnryCzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFLC00jB/KVomE98R0BHTtpUnBx/WQpeDClWbKV05AI=;
 b=VpUovj6PinZEokhKi5T4LN41k7kOcjrkpn0dXgml/Ue1tIAiIp0kyLttaFBMdTG3tQapJtMqXZcxqdxHxxLLOLL2zw8YA+lrVqvL7nUNeBm6wdA7XqUzZVZgd0jGVjHnLvJH1JDna1TJsFbiXzKKNTtYMOzKJqWk6AhE8Dry9Yms7utmnMSTRol7S7CC/iZoUXbYWBSZcP/hepd4B1D4OyeABfrA3lCww3I4Pp1QrH+oBKExMKPPjB8xvpaU1yNibntK0x8PmW4UTQoCNqfQruwpmqY6X6K59Xc8sJlEC1B2z8qTWlQqLQEBTuLmIqibCiNV86bvaBzftKncJCRO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFLC00jB/KVomE98R0BHTtpUnBx/WQpeDClWbKV05AI=;
 b=dtLEjN+Pnv3B6fd1ujsX2YidFqyDfXhR89Ccj8eDKYwBAjM9O4RkcN/XuG366ndLjGOI5fIJoanCBkz/uJJBkGxcglNA0xUZq2HA/yAezJ2YjEPKAfvrsF0mF+ka98Jc86BvpjgvX5nwVkF30BIW50LFkPOUBRalCgXE7PmObs7QbQozin08n+QMPJS7CUQQ/9dMEa5tPSi3g3C8klDA58ieSJ94nMTO0ZwoejKlX/tEJV/03PfjEPR5RUfD+of3HRW0FAUxNiQLU788OEtDQUEK1/E6Dc9f5MlGtzDBiuj4S35pLz3D6gphXt2Hm/eN0wjjBN8tTJ6gKj5sbAouNw==
Received: from DM6PR06CA0023.namprd06.prod.outlook.com (2603:10b6:5:120::36)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 17:01:02 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::75) by DM6PR06CA0023.outlook.office365.com
 (2603:10b6:5:120::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19 via Frontend
 Transport; Wed, 10 May 2023 17:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 17:01:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 10:00:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 10:00:49 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 10:00:48 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Jason Sequeira" <jsequeira@nvidia.com>
Subject: [PATCH v4 2/3] genirq: Encapsulate sparse bitmap handling
Date:   Wed, 10 May 2023 12:00:32 -0500
Message-ID: <20230510170033.3303076-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510170033.3303076-1-sdonthineni@nvidia.com>
References: <20230510170033.3303076-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b61b5b-9665-415c-5e5c-08db517822d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdwbJRFOWrbQ3e6uOAw6g4Up2D27X/j9AIuZ79URFFCy4n6EbVqkC564NcILkfnjAlBXRSx9MqzD2hkI9gUKZu2qL2T03zap1dSwHaZ0xdluMGWMaawIoA77mkV5eGcTCwipOBlqZ0gxcrqw2eYVR25phDwG7nXce1gP2TMstCL9CvQMHUTpfOctQe0RLNz2yFonFvIfvVgjv9/gwnP4iv0t6YA6MAQVYEO8bEReG33nYUgbQNgqIL4n39dnqQGTLGnVPuBiqcW9AFeE9X2N/Zo5CZ0JRgSxW0RjqZFJl/MeGwW/OoITIbDjp9Q+fvI9OIp7WLwyIpN7SY+9g8HofmIdxW1bN7pjgbOSkTud/8Huy6jHbHE5S9/Un4FRupBRON6BC+Z9xMRoMsRxL4pInapfoVptIn+XLo58oICkr2TtXnfbalgiR+1olKhe2vVpj+J/jHMpfGrMTe9w+Fzz4WypIsz2kKGo9meEUC4aU0FOsYShGyWKJ4aItRn3fQcEoa9pLU5xbUTiwu/RKySyacW8oFKlQzf2L0N6RVgExfqJaDaDXfUfDJ7r5shFMIYQMpNwwPnog9MOEk8QkNlQt5l9kHhnSGwX8CTVEwBUlsyt3CLHm01F0SLi0JhbgurFSwaLvRxGDR3ee91DtuhVZmfCs2Uswa+G0LH2U3YnXiLI1jowykVsv0S1g7q7KkHGYimA44po/1vv02S1gGNNww==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(70206006)(70586007)(478600001)(110136005)(54906003)(82740400003)(7636003)(356005)(36860700001)(4326008)(316002)(47076005)(41300700001)(83380400001)(7696005)(426003)(336012)(6666004)(82310400005)(2616005)(40460700003)(8936002)(86362001)(8676002)(26005)(40480700001)(5660300002)(107886003)(1076003)(2906002)(186003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:01:02.4388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b61b5b-9665-415c-5e5c-08db517822d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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
index f4cb34c87ae7..a741a37d3641 100644
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

