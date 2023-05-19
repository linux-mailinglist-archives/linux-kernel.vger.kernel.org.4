Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D12A708D22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjESA40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjESA4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:56:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07CC10DF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXrsfhm0uF0jReUqlcUDW49nZ1h98M7rZsXmlHlq1O2yb75U7mMnXcYnVPKQIAyLKdhqqhFIVJ7HiEIgEaMMmbCsgJFkczEMKDJcQtJxv3eum8vp5w5wTIAfeXlRryZtLuJ7KNmbxDN54iQT3Sv6oQgPcWdq5UQ/fa5YORCdke7Z+X8Ebn83EDBMwPABBSwub+em5edGdCHvJY3Io+N745rRDtKggrm6SvjIuma/7PYGB2bHWR+c75lBQ+eQ6XH/n8mVtyQD210V0/4bmCkBB/MdtY7rnIwFX65hRi3A+hxPIYq+8N+U5JyKJVG9tSAVuw/AA0jFesym+UsCncY1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBhOL0jUPEE03ICFVxiMjPZqqR2ysO3QoiGzRk2CjJE=;
 b=XhPexjSINKiB7Ea4WQ/hdIGHa64X/i9h19+qvZ+vIT/CDyfZDf7z7x7Jg3QPGJhZZGywJkPxYL3aXUj2aMp8Tpg1nx1WAsFBA+A6NmYQkRgoqboasn78itEmq9Q3iEHzfEDBplksFz5Lpxyi193qsVqhM4MHcEDP9KoWTEhUZzQOo8zudUNNYrPd1ZHRsUt3l04Hv84AZ7F/ZGROx/dFcp9Dwv2DZxDLWomJ/sOjGpSoxW4T5eZSq5rDb07kQOVCO9VVMPbVGZWjoy7J8hwg/EkdVvT0xm2FchQxORiVP36jYUvOq6RZkQ3eEUmntqF+cJp4qT3qOErF2oo0ko/XZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBhOL0jUPEE03ICFVxiMjPZqqR2ysO3QoiGzRk2CjJE=;
 b=g+kDhmIQgiHJ0IplSvGu5C/1oQZU5oXpTs/xMgzczcyxnlkbT6w9LYus7A9EiJy8FCv841EPlsdKzekCbOBgEsf/wOaYHn+wQvSfwg5jGZU746MNYSPoRYgQ6Oqpw/kYQ7xb6oWPB/VqqtXKk6KlBoJhQDNKZ1xZxV3D09omFaA=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 00:56:10 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::be) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 00:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 00:56:10 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 19:56:07 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 5/5] iommu/amd: Improving Interrupt Remapping Table Invalidation
Date:   Thu, 18 May 2023 20:55:29 -0400
Message-ID: <20230519005529.28171-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: c417290f-4a6a-4f55-0ee3-08db5803d61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /N0SyD1Je0bHBayAcpfF95+XH2XTkhsYhD77T+Z53qZ6Qg08TjurACrN/C/ImDq/nNJpOFfRUwdNto/kUlIl2kuGDhjoqvRS982HIxaKPH0g0J3WUKQWBggCg1M09vpSyx6qlq16P10GF9popY+0kLBmIGNF5dPxJ2laU0TuzXrmBGBbz4x+ved2689nP8MAkvFH6tryagfqwGkZvEMTmJUXKtHhDFhI6TUlkPtaDRMZX7NNvncvFCR96y1Cnil17alZSLCKS6JRMLaL2zGKN1tA+yyc/8hAMbNVg/64XbTF/AE3x2zPalzaCdMkpzaAHt4hC84fpKsVVyl/Cwgb15eYT9RpViD1FAj36YFfoPSqzgZDngpezxIs+udDdNLd61Mo7DABxgY/IDCE6pRFR0D7/5aCdhJRjjZRse5C1Zw6oJD9dLZvp7sXS6ZonnAo3xv2M08I2Zh9Yk/JarHO27/dsZYYtU8XNB9E8CFbrWWHiWzsu+Tc25tz0BH9pn/3cgVrgbG8TnBTiXb1VHSqY7lFvSgeG4Kp2rg6jQzET+HYNWY+NCcJpZ859GxKPqzN/EbbUpnmr24RO0iKGB1b1xtlqZyXOK/L72EzIkv4Gdadokg6FDBrg9XOWjpUapsV62KVT26ty/z4NpZv3vqujYxxuQhEcgqlN9Gc61FxaRdlUtnYQGvtDAaiGhwpj5r2gDfMLj0r1CG5in0p7y6KBpg+XDJyx3gGOVJTnAY4OvSYutMw2uz3qhgRlaPj0pCp2vxKhR1zezMMGnRTGe3zTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(44832011)(8676002)(8936002)(316002)(4326008)(70586007)(70206006)(5660300002)(41300700001)(86362001)(2616005)(426003)(47076005)(336012)(110136005)(40460700003)(54906003)(478600001)(36756003)(40480700001)(7696005)(6666004)(1076003)(186003)(26005)(16526019)(36860700001)(83380400001)(82310400005)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:56:10.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c417290f-4a6a-4f55-0ee3-08db5803d61b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invalidating Interrupt Remapping Table (IRT) requires, the AMD IOMMU driver
to issue INVALIDATE_INTERRUPT_TABLE and COMPLETION_WAIT commands.
Currently, the driver issues the two commands separately, which requires
calling raw_spin_lock_irqsave() twice. In addition, the COMPLETION_WAIT
could potentially be interleaved with other commands causing delay of
the COMPLETION_WAIT command.

Therefore, combine issuing of the two commands in one spin-lock, and
changing struct amd_iommu.cmd_sem_val to use atomic64 to minimize
locking.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            |  2 +-
 drivers/iommu/amd/iommu.c           | 27 ++++++++++++++++++++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 486a052e37ca..2fa65da2a9a5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -744,7 +744,7 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 *cmd_sem;
-	u64 cmd_sem_val;
+	atomic64_t cmd_sem_val;
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 	/* DebugFS Info */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fc0392d706db..16737819f79a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1750,7 +1750,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	iommu->pci_seg = pci_seg;
 
 	raw_spin_lock_init(&iommu->lock);
-	iommu->cmd_sem_val = 0;
+	atomic64_set(&iommu->cmd_sem_val, 0);
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 51c2b018433d..57ae4a8072d3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1182,11 +1182,11 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	if (!iommu->need_sync)
 		return 0;
 
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-
-	data = ++iommu->cmd_sem_val;
+	data = atomic64_add_return(1, &iommu->cmd_sem_val);
 	build_completion_wait(&cmd, iommu, data);
 
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
 	ret = __iommu_queue_command_sync(iommu, &cmd, false);
 	if (ret)
 		goto out_unlock;
@@ -1284,11 +1284,28 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 
 static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 {
+	int ret;
+	u64 data;
+	unsigned long flags;
+	struct iommu_cmd cmd, cmd2;
+
 	if (iommu->irtcachedis_enabled)
 		return;
 
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
+	build_inv_irt(&cmd, devid);
+	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	build_completion_wait(&cmd2, iommu, data);
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+	ret = __iommu_queue_command_sync(iommu, &cmd, true);
+	if (ret)
+		goto out;
+	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
+	if (ret)
+		goto out;
+	wait_on_sem(iommu, data);
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
 void iommu_flush_all_caches(struct amd_iommu *iommu)
-- 
2.31.1

