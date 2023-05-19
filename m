Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2627098B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjESNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjESNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:49:33 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E203B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qmwk2J7UtRcmB7ZuhAhL92GJ8+4U+mxuJ4V2EMC7Qqwcy6qsNZrMpGG3ELJZKXhfDdgIc6i8BdMCMe7QuV1B+eC4tTnHiuQrv7B4jf+mB/SPCrwMq1o7eKjMSB6Gm+EThskWHUyqjkuWQykdzi2cDNeHPNB/MPYbnP+LJ4O/05shqxszfae1pXWpqOo5RMExLPDnPFRVinZSjJKhdTvGvJt04G1i+4Vt07T9kUEddgP1K4RVwDOfh/z94/r5NFPvlljAjne7ehO6H1Krs5O+ENWlfhAR4Tr2ZTKg0Zpyg+AnDZWDfHvdBy7/xkV8q7qCxJ+K6eXDQjWMQN9ORkwRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5gs11ceX1GI883NckqZh28QCneok6LeDTCI8QwL4JU=;
 b=Q38CJ4ZRGTWZXj1k2j6i9FqzlKcyd2uoC/GpQVQeo4uVDc44u+xfMG4Sw/8Tm6p2pXpSkT40JM0xdKAtf/fDLNpDc4iWSqqRolbU2Kt4Kodol0gzv5NslVxQvDYzq4MhHiX0waQT9bwpE73P1Ip3vlRhAc1LbUmi/+LBHVf2s9EiBXCpzk786a4gHpwp38uGmPkDqpikm3ZcvtjIhyDyJPKvu5yyTfypdz/kmt6wLt/Vutm/vGdX4Zz36RbM/FK1+v9hbCR4jfoxFkes+SHHY6gAMQXLnI96i7Z+eMigBijOPY6MzwMLzZMra51tWFk0XqSwOqyjMIVWNDrhFjXl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5gs11ceX1GI883NckqZh28QCneok6LeDTCI8QwL4JU=;
 b=An8gstgnE2mTJXRtrAmXFVcTI0gLeo3hPF5rrceHwfH/T91QT5s7CS5ruBUcOS9jSSkRuujqOiHAbhRznD0dlmwu1DqXaTLF3ymkUqnh0Rn1OvGUQmRkvkT98xEWoY5xc2nYmgAaQFUXiuGoR4TuTWW2SUAnuq/IBiRBGUVUN2/ctejPUpbMEoB67IkdduRpTwROnQmz8ii5RJuEmEsIuyzLpzG4674imv8l5pkDreXoAdXkPjNOUcYOn44Svxe2MgbewHNN1uoOq7glBv/DkWa32vuwmytqnDlDLX1xYaNpeof4waFnhCJ1Dp227jZtaT7XTWZ4INXv0kxkHpeZuw==
Received: from BN9PR03CA0531.namprd03.prod.outlook.com (2603:10b6:408:131::26)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 13:49:29 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::58) by BN9PR03CA0531.outlook.office365.com
 (2603:10b6:408:131::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20 via Frontend
 Transport; Fri, 19 May 2023 13:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 13:49:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 06:49:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 06:49:14 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 06:49:13 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Jason Sequeira" <jsequeira@nvidia.com>
Subject: [PATCH v5 2/3] genirq: Encapsulate sparse bitmap handling
Date:   Fri, 19 May 2023 08:49:01 -0500
Message-ID: <20230519134902.1495562-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519134902.1495562-1-sdonthineni@nvidia.com>
References: <20230519134902.1495562-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da37b83-3f7a-48c3-01ba-08db586fde23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56cdGMzU1L+P9TbCduGIBgUFeqFDTzqz0jHeqkTffABuJlsmHQiqS/3PaXLs/Gnb5tmg+EdOhfcH6QxmWnz4X0Uq96Rd+R0hftZ+tJGeYa/Gh5ooVXDtfLBLtEVXJRLKWWq+QQ8TI13vfvyjeVeVAuhst5kOSJ72bniLyuzyw7gjDXu5LzTclWZAdibhE29umRQD1Ciy947hN+DoLwUVbAaLl4bXh+03ZIH2jJwUlhHVteVy7hl9jvpN4HRXKFXkWfe5ECCzvJfe3g1Z1QNt+38e4mMMspCDSlf1Y1Zw1rueFyneKtlWJXx6ybfVxI7/teuAzXXDsx7jOCVTgfmtRhs3e66PEJnzOtbnJ2Va1a9zUKEOrGkskCj6GwmHdrlDGUQ2Tl3mrEutPLuV0CbOYFiKqzcGpj8mcsXZ/93NkG19imXtvqmjJta+QSucLTQ8OCEzOaOaiiG7v9Mv0J/Sx+UEZcYaTDacda9kXRPCxvaVdbhKLuwMa+oQYSnirIhVAONT1gsAvMJmU63myWKoSFqmINHey2xEbCi5MbhOMoyVd/5XWIgmOudLATJy8HlJ/OKe844fUz8AkzbCCaMD+BD7ysWdXv3snhCwmOBavyD9wXMu/oMHR+ZqtqeiLyrxOyy96vpvHBw9C7N+fN3L40qzkWdBDsV32ftm+pFBdw3PRvv/w5EdKS+YtIugM+DxoYQA4pRw1eOMqPnqhW0ph//Md46mhEyUY9F+JdhTAgEVLI7vVxoAx95mMYqRV0vH
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(40460700003)(107886003)(36860700001)(47076005)(83380400001)(336012)(426003)(36756003)(40480700001)(2616005)(82310400005)(7636003)(86362001)(186003)(82740400003)(356005)(478600001)(8676002)(8936002)(110136005)(54906003)(316002)(2906002)(5660300002)(70206006)(70586007)(41300700001)(4326008)(7696005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 13:49:29.2632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da37b83-3f7a-48c3-01ba-08db586fde23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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
 kernel/irq/irqdesc.c   | 30 ++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

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
index b401b89b226a..e0d9dd9b36f9 100644
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
+static unsigned int irq_find_at_or_after(unsigned int offset)
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
@@ -834,11 +844,11 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  * irq_get_next_irq - get next allocated irq number
  * @offset:	where to start the search
  *
- * Returns next irq number after offset or nr_irqs if none is found.
+ * Returns next irq number at or after offset or nr_irqs if none is found.
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	return irq_find_at_or_after(offset);
 }
 
 struct irq_desc *
-- 
2.25.1

