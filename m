Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508805B8058
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiINEiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiINEix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:38:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA81474FD;
        Tue, 13 Sep 2022 21:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An8YwwxD+PA2ky9EUY4kKKob36mcu3+LhsMkyllwSZXGlMBuQ49RSGsd8dp0CY4fa6Nl3aNQJhUY1TiVak0G6lO1hrloI4nvK/95Z+KxkyVNurpPZj7Mq3x3aN4dz3aXKg9uyTNG6wrrbJW2tBW8yJlnzzVxkzSdO9cZzKTLVsEDZ6gFMz07tsziNaa1brNMcFVi6+V/28xm8vXbQ7WAKQYbtnxK1fv1SHVvts+heF8v4gY38Z1TYdIh5WZ9pq8ej2GFmNHrD1xv/M8nXvuymdjTqrEtLCHKnbnqI4aOXplkV99b+d3gRFwhm22gbk9pYHhB6nhUxaESWxhzYwO4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQewsZcBZMGXp6++77Ve2YjjtguE1Y+Yz61mHh/SYuM=;
 b=UMR7N3yzMBCG4HSg6Ouy6BoUWFklqMkiktsl59cBYnOwbKMiIZFZXKgm7NErRjGHz0LsgqHjf0FuHnm6WREaerx+5skGVMHQVpMFqQfWDvLW8fwP7TTyKZD7XiaA/Cd7jRNVr10YCU2hJ8JVu6ym7RxsRsrsdMdKhiMaDaM/OnXA+ZZ9K0JwZP99dnkAlkbh70x4VVeZMWDMKKIVOf9k2PksaCpz3he2VhVum+0pu9FkxFaXUJzzcr+2yZIcMjale1H/ZT2T+EJ+qyjrzSzDZgSiN/s4TeFdSer1GNxHJOuBWn7b67MORj6kZzJl8V46VdBMHUCfXKQdD06LhAkbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQewsZcBZMGXp6++77Ve2YjjtguE1Y+Yz61mHh/SYuM=;
 b=f/MPU4WWRzGYlDBEXwi9sMtKnnBZmgPrciGFyP6HmHwuI0Ak00cBhjGbtVOyQXyY1i+ylnQU4fYrxu0QTwHq/Yi/+NEJ+EBR6/NsmtD2qskX6XMpcJfIcNmP5k4ICiDMqjcU3Sldwri2tCSHzFMf9TXtoiOuOuSliewEt5gTOBChVLwvyBzL14z0NF8qP0YCkf466ZqFaW/i82Tb4tvLd8Z0VKtTQ8nxDIR3ew9+GjaOKDc07GuxODK1l1iZnCs0vK2tPPWYxinoA0omKI2ndQaHy8cWNOFhblFX4Idb06S5GONedyGvoQ7hwCxXVeX/2Hqq8tIYUIDROZxaQiGSwA==
Received: from MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::30)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 04:38:51 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::fd) by MW4P222CA0025.outlook.office365.com
 (2603:10b6:303:114::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 04:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 04:38:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 21:38:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 21:38:38 -0700
Received: from build-petlozup-20220913T015306864.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Tue, 13 Sep 2022 21:38:38 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>, Prathamesh Shete <pshete@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Process wake events during resume
Date:   Wed, 14 Sep 2022 04:38:31 +0000
Message-ID: <20220914043831.654836-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3cffee-da32-49fb-015a-08da960b0586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoILvC0n8mb2NngeE25Syh+hd5sTBoAmS8b0I1f7SfNWpeniWkKppr8ZbcwR7wshl13X1LQk8sNm+SbuJlrcu+kfEiLsrfm9kNaW2BXK+GmsrdAOY7sM9G2P8ckEQoJAWdaSp0OriKziKkwpKQoYrBJ3bRH3t22myIRruwbUY9zN+6qb3Zfr3vIeaHcEoJddLssJck1bJtahsKMocJLHeQN0il0W40FxCrw2nImvn7HY8tArzQnJIIOpCRVRmrfeLyPaU8CRbgL/ateRkHuKcm3WUttxrwE4sMb5DmaDXNQOaR2vsRW7IkocZVwEJHYcijzYiUktaJZKEkHnT/A0xjpI5u8Bz4Qdr/0BxxHRYJ2JRoa0AsHqSZ0seWAaxig+DeAtbvS91zAvelP5FQAIgJ+SxPcSOe471Xub//sXIzs9t6aC9qdRBW61tX+8E44hdPGS8ZTjPpRjVzgSz4R5iAUUdPIuMVv5K23gc3axWMTBQabjZfgA/W7jnTSsHeXAoetP1Gz36x+4C1Ls8i0DHVlARNpFdEYE/qFUijXlAAUc91rF5Lu/QBgHKNjbQjyxyxpDWK0snv4DyWpIpGjfDdt3u529UI/MAnOQAajYq6ac2z9FIPWmb/qxO1f4qMjOXro0gzLS3rJ7jPF4tZYQS7ox7e7mrC39BmAsYTZuOhMty6+CA8Lss2ny2usuX51yd4ALKKW0hCO+c4qJ9wLJPrW67gRlk9np5MWK/o2XURmBX5l6r08zp9QFx6j+OouPggq2qNOpPNnR8Lfc6vTNibH+KozAdqAMOPnivhpHgs8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(86362001)(47076005)(426003)(7696005)(8676002)(7636003)(316002)(356005)(478600001)(40480700001)(110136005)(82740400003)(336012)(107886003)(54906003)(36756003)(36860700001)(2906002)(2616005)(83380400001)(26005)(70586007)(186003)(8936002)(1076003)(82310400005)(5660300002)(921005)(40460700003)(41300700001)(6666004)(70206006)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 04:38:50.6883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3cffee-da32-49fb-015a-08da960b0586
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PMC resume, translate tier2 SC7 wake sources back into
irqs and do generic_handle_irq() to invoke the interrupt handlers
for edge triggered wake events such as sw-wake.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 8c7b46ac6ad6..f275af15f2d0 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -27,6 +27,7 @@
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
@@ -3181,6 +3182,40 @@ static void wke_clear_wake_status(void)
 				WAKE_AOWAKE_STATUS_W((i * 32) + wake));
 	}
 }
+
+/* translate sc7 wake sources back into irqs to catch edge triggered wakeups */
+static void process_wake_event(int index, u32 status)
+{
+	int irq;
+	irq_hw_number_t hwirq;
+	int wake;
+	unsigned long flags;
+	struct irq_desc *desc;
+	unsigned long ulong_status = (unsigned long)status;
+
+	dev_info(pmc->dev, "Wake[%d:%d]  status=0x%x\n", (index + 1) * 32,
+		index * 32, status);
+	for_each_set_bit(wake, &ulong_status, 32) {
+		hwirq = wake + 32 * index;
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+		irq = irq_find_mapping(pmc->domain, hwirq);
+#else
+		irq = hwirq;
+#endif
+		desc = irq_to_desc(irq);
+		if (!desc || !desc->action || !desc->action->name) {
+			dev_info(pmc->dev, "Resume caused by WAKE%d, irq %d\n",
+				(wake + 32 * index), irq);
+			continue;
+		}
+		dev_info(pmc->dev, "Resume caused by WAKE%d, %s\n",
+			(wake + 32 * index), desc->action->name);
+		local_irq_save(flags);
+		generic_handle_irq(irq);
+		local_irq_restore(flags);
+	}
+}
 #endif /* CONFIG_ARM64 */
 
 static int tegra_pmc_suspend(struct device *dev)
@@ -3219,6 +3254,15 @@ static int tegra_pmc_resume(struct device *dev)
 	struct tegra_pmc *pmc = dev_get_drvdata(dev);
 
 	tegra_pmc_writel(pmc, 0x0, PMC_SCRATCH41);
+#else /* CONFIG_ARM64 */
+	int i;
+	u32 status;
+
+	for (i = 0; i < WAKE_NR_VECTORS; i++) {
+		status = readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i));
+		status = status & readl(pmc->wake + WAKE_AOWAKE_TIER2_ROUTING(i));
+		process_wake_event(i, status);
+	}
 #endif
 
 	return 0;
-- 
2.17.1

