Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6506DBC49
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDHRPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjDHRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 13:15:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12893C2
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 10:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QemcPDSuqVwO0qMUd+hqQr1vVvHGogEg3XnH6UCs0nhGrICjsKTjdLtOA1SidjBOtfrIfUOuAmTZfIKLPChcy8QESi+aX4uPMK0RZNDqGVO15u13bq2HXHK3FykbGYbDn22PZh+zje1bEviHVodwb/hS4oNnfS2pXOudv1C8Gn86wmZvLurwi97Ppj6Fu7aSEU9/Y0Ize5cX/oUvxFW4Y/8Uiop8t9hghPbkGzSpcdMTuTK80WOpBYXvBPF/3Yj9AbEI2swpa+iNfuVKTsNN1OYX0NL5qRpBukIY8TC92DaZm5RARcXs9kQnkJfylu6ZzK5j8hAacsXgfId7WI4qOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uglQS5xpx6UJQfkJzY2t+omyn2N5w55p9ibk1COrzgk=;
 b=FIzwF3xrMwCd5YTQ0mVEs/7lSdrqlADsO+g4KeSSeNoYQtV5j6fpRcdpQgdb1+Mahk77ER6aboLQarTf26zsv1XcfzYY2BGeF43ZoZG8wA6n1bp64ZQzRQdfHex0hVeXE46/yn2/c1C3FedeFJCeSIAermwbOiyNM99u/CAW6VrAcgy3NOpXMUIa3CnL+GK0Nn4OCNycU2LvI5cJMM4Nmz5ie9yDypER3jOErCwYnR0Ck9aCX4V4ARGBhvo75oaB/pcrmU3/bV07iZUN54WlUKaX7MGTitaBcpj6fpGbIkYhD0ibtK4jocckk/TRw+d56vk2BP/8MMPo8OhzG1Dmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uglQS5xpx6UJQfkJzY2t+omyn2N5w55p9ibk1COrzgk=;
 b=cD2iUVrulpnpDuLBgddiew7dzVkLyXLqcqzkMVqbEhEor46tt85h+a3+6c/pc2VujZigpUlxS2cdQ/DmtfF7uA6SehvmOiEN2Mw7MUsnG+PtWnDnTU+23Z+B5CeZeUp/fTOh0cyR+zUIipXbHy649/166M32LHFPCejETIrgFcWTvOfu9mDtz/VUOOR+lOlWCJZfvPxyG2YUCc7puhneGqbVdzCdlAKlfPFK2STX0+wIV+LlGeVdttNwzN/9nEswKaHcoqIc1FZx+JY3YDvDebrAudwmwbPfcCu4CfIFs5eMD+jjARpQ4dhcx6nJHlYBgZO99zGtwVtklqpESdAaVA==
Received: from MW4PR03CA0079.namprd03.prod.outlook.com (2603:10b6:303:b6::24)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Sat, 8 Apr
 2023 17:15:31 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f6) by MW4PR03CA0079.outlook.office365.com
 (2603:10b6:303:b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Sat, 8 Apr 2023 17:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Sat, 8 Apr 2023 17:15:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 8 Apr 2023
 10:15:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sat, 8 Apr 2023 10:15:30 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sat, 8 Apr 2023 10:15:29 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 2/3] genirq: Encapsulate sparse bitmap handling
Date:   Sat, 8 Apr 2023 12:15:25 -0500
Message-ID: <20230408171526.3059039-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230408171526.3059039-1-sdonthineni@nvidia.com>
References: <20230408171526.3059039-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 047281f5-dee2-461e-40f5-08db3854db70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKvmiux4rl3vsnm92UoRs8n5/OpWhCUYkJSZ9ngDkxECtiZdXQD1cI3KB5xaBaoR/SjTjq6D5zQuPk8kipMKA5Cqe53/mKLJ+EFLqmeK0WPyi/0Kivzc+V7GqZcD7HQIO7PkxchaN/McpOYF30+sWr8y6VIXbl8HDqrWILhgapIUPCc6Zs62dDlS8MUfC6ZQALMbs9sZRZUT6H/ihgMZtwUXo9o53w9TEYr6xxfIwpB3S3V39ZugbLCz78RnbCkEX3OCp3oWU7HJ8PWnAffY0fjedQGTaLTq5F/7VtFtceDFUGGjiwIeXm0Tu9mDhW79z8db0t7k9DqrTO2r56JFnB9q+KZT5wV4eB0fpvvqKgI1aDqmPF40ub5ue+IKu2gM8UtizQt2mMwzIwjLylTfMASKmugVgVxkLZhrFiGQ9AlLCIIl9HHHh6jUwWqvNu5oCvn0SXxNlgdxGRu8fCfKoBd7BFBub8EaGQVl0XBi+tEQIGUgg0VVJXvH7/7LCyNt2b6OHYoOWxy8mFYP05+6d3M7ApWHQF0WG6Ci/Qn1/YlsHWKEQJH/GdNwIAHwXCvpZURQSYdAawFT1I8EhItCGwm/yS/lAc2QQVkJ2y1L8As6ZmLsmU20j5AeyFvWdoibkrYOdQUIYFwrrGcBwKWm0KmSmhp8fMMw/VeUj96gtilfPwlPTZvRKfYqrS50Sk3XUM/28pUBd76SB75FQuXK1s42eXM5RXaYQkTVYSbizUQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(7696005)(478600001)(86362001)(40480700001)(47076005)(83380400001)(36756003)(82740400003)(7636003)(356005)(2616005)(36860700001)(426003)(336012)(6666004)(2906002)(54906003)(110136005)(316002)(186003)(1076003)(26005)(8676002)(41300700001)(8936002)(5660300002)(82310400005)(4326008)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 17:15:31.2095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047281f5-dee2-461e-40f5-08db3854db70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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
index 47543b5a0edb..e0c259769d3a 100644
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
@@ -816,8 +827,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 
 	mutex_lock(&sparse_irq_lock);
 
-	start = bitmap_find_next_zero_area(allocated_irqs, IRQ_BITMAP_BITS,
-					   from, cnt, 0);
+	start = irq_find_free_area(from, cnt);
 	ret = -EEXIST;
 	if (irq >=0 && start != irq)
 		goto unlock;
@@ -842,7 +852,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	return irq_find_next_irq(offset);
 }
 
 struct irq_desc *
-- 
2.25.1

