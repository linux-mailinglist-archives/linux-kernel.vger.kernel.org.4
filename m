Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E72680360
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjA3A56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjA3A5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:57:48 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B841D921
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:57:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBUJLkbl/woOAMEqQVF7QKVm+VvxjqCGzOCDjenWwT7L4IpS2hHOzhcyyecWUsBIWJ6qoMm6/tFB670YOAqyL4ZlNL2kQbbT+PqOCEuStNHMoTkGdW7bomIZkfASAEUo1QFa7sXbxIwb4uKrJSklkmiqf9ysEyViMXD1Q1PoKzpBXLwxNbbarbRcI3Mvd72at18Ieu6olotLV0O8UvOp2Y3QTEduv4+OKQqcA3e6Fxxs815S52eFdvetisgN/xiQqNgIEq4v0h7WXnmYzzJDXymp9zFlHGdME8gdNWB2laP5T5wYYm82+lflTQUyssau1c50hWMho9URjRAMkOpGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aul/Qf7cN6yY2oVjkqrNPbt3USVR3a1xYMDesa8HJDM=;
 b=OgnCxD52agt6+5Xl9VUtVTpX7nv2yB9aiwBN5j6K+OOcIsVcc7Ar8EOElGn9Yw/NCeMMiXuDpomzqvbaMJb/F+17gp2EZ2OLjusJJDIi0TAWI4L5zE6uVVFCEH9C2K0XYygPfNrRAM3KGz0AgO6MYlNdxgokMiSClBlz/Tq0nHv+kdHRvPPHSD1hKYoGGDWtnNezD37hLWJpI051xRGGi4jzDx3V1Z8h9aV6tMZxjnn/MgZF59F8qhxRqctVDv7cmrxfesFuxqkhFeDfCpwjMddmSjvprLT6fBuQwri2alpq2NqVvA8L19u2grCv/ffogr49HKuueJJWAihtUJzjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aul/Qf7cN6yY2oVjkqrNPbt3USVR3a1xYMDesa8HJDM=;
 b=KqJqmywARmeZVCOzD+RCgdqT6myLHoVIsM86wNcCIH97dv/toVn5nOEWNL4t3+syOf7z7xg1+SgJwN0AzcOBGqtbZs4p8DMarHnLQWlrNf6SdlSorVoF5foHzUFSWdQ6iEwRfSztcllWk8ZaL0z1MfrYY8kwCaX0kAHRG1kr55v9WySYbLZ9bEISHm2brYaWEKDhXNnNYIpYv7BWar+O7ew30BgL2tOC3OodVfBInjILop6mgddEsK/pZxa6/Wyu4Ui6+EiwFpBOwso3Jd6m7B294CeU/nZevfhRw9zwf4yFp4a5SE0/h0dUV2+3Dt6elPyAqrg+SHky5p8jp71K/Q==
Received: from MW2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:907:1::14)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 00:57:39 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::4a) by MW2PR16CA0037.outlook.office365.com
 (2603:10b6:907:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 00:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 00:57:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:30 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 16:57:29 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] genirq: Use the common function irq_expand_nr_irqs()
Date:   Sun, 29 Jan 2023 18:57:24 -0600
Message-ID: <20230130005725.3517597-5-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130005725.3517597-1-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|BL1PR12MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de7dc50-5068-417b-4c0c-08db025cfc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PaGkUZoQGUsYUv1Nj0TpS9ej/NnLbCSHwFbcCSijbU23z/KXh7Tuq16KJT39Aty42cJITeJp37JDkCunyEsdBOzypKgXwb1mJGA7VTWFoPH9tZOKnfZFPX6n5vCqghLj4zOx6ILZSk+VDDahmepHLbzcQlfK9JWUH097y7xT9H6ACEUzHgPcsN+Yl9CzH75YfLQKkksLdCujspsqBDKnMTSZRQ0efAQ7t/rPwmI4bbBZKe2X65fCRmEsdmg+4Bx3yk3/XzWe7cSaaE7vC3UT/ZgFaWtC3FOTXFiE5z2Osrchfwe/s8NlahRUDwHRqsebBvba8RMuQvVaRHEgOVsYQ8n/fRNvXeJm2RCIxfmn2P3byVa8pbK6brUX7MTAX7yFQC4STTmXRfwclH63Jl3ciDAmTEhMZ2oUpVwpIyEnivWKrWqe13SqUSv1dT+UyI/9wnvhwCC1nujnJo/ycvQA+wY3v7nR598mgz0n1z1/0eDJxVCk5VJceballtH5FVq6VWPVuGUWwUBUszwrxlTuAfbH+yE6A420urwA+laDG3A/zJ8AwY2f31zJyfQEPWbrQvFD2Koq9jYPWAIb+oPsljylI6taaXlb2VZTq/MUqNFjGZcNfD9o701trkeG2McK1d1N9uYVD9MlJPfEgBgcGH7q9RyuGOfU55pYwl6/e8RlOBYuOvMB053Fz7agxJe+3T39vA3QoEYzN7Iv035tw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(2906002)(47076005)(316002)(82310400005)(426003)(336012)(2616005)(8676002)(83380400001)(26005)(478600001)(7696005)(186003)(110136005)(1076003)(54906003)(86362001)(40480700001)(7636003)(356005)(5660300002)(41300700001)(8936002)(6666004)(4326008)(36860700001)(82740400003)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 00:57:39.0642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de7dc50-5068-417b-4c0c-08db025cfc12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the !SPARSEIRQ code path is executed, the function
irq_expand_nr_irqs() returns -ENOMEM. However, the SPARSEIRQ
version of the function can be safely used in both cases, as
nr_irqs = MAX_SPARSE_IRQS = NR_IRQS.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/irq/irqdesc.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index aacfb4826c5e..247a0718d028 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -144,6 +144,14 @@ static unsigned int irq_find_next_irq(unsigned int offset)
 	return find_next_bit(allocated_irqs, nr_irqs, offset);
 }
 
+static int irq_expand_nr_irqs(unsigned int nr)
+{
+	if (nr > MAX_SPARSE_IRQS)
+		return -ENOMEM;
+	nr_irqs = nr;
+	return 0;
+}
+
 #ifdef CONFIG_SPARSE_IRQ
 
 static void irq_kobj_release(struct kobject *kobj);
@@ -528,14 +536,6 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 	return -ENOMEM;
 }
 
-static int irq_expand_nr_irqs(unsigned int nr)
-{
-	if (nr > MAX_SPARSE_IRQS)
-		return -ENOMEM;
-	nr_irqs = nr;
-	return 0;
-}
-
 int __init early_irq_init(void)
 {
 	int i, initcnt, node = first_online_node;
@@ -630,11 +630,6 @@ static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
 	return start;
 }
 
-static int irq_expand_nr_irqs(unsigned int nr)
-{
-	return -ENOMEM;
-}
-
 void irq_mark_irq(unsigned int irq)
 {
 	mutex_lock(&sparse_irq_lock);
-- 
2.25.1

