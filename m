Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D526FC4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjEILR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjEILRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:17:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599F55B8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMbX5fDwZJPVfJ6BQ0ju4rTSYjS/UcnyVqF0Q8LZTu5ruCDUDsc1oEnAW6IphvNFIC3va/a2tvkuzIwK4qf7r2RH6p3dyfnkK1BmAwr3i753atGKdEtOfx5vg9MJdR11R7MwAqA4waJqMlx7YQ9bcuZvZUqE6sXeXynIxyGhWelo8X4ukgmhfrbAWceNXgwMAzEBTeTy+gJLgqzMwU2eLsBk8UQKYL9ySGBY6MXc4vxg0iB1/PT/zG+Kzsd7j0vHrWYDt4pthP6DyuZiGDMl/ybyTC4mLL8CdpjXDk300Lh2XE5lqmKelMsxN+XwifC5EqbEZLU1HYDLyTTOeMZmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3tsa/MDtLn/bv/bcyLy1vi8+ZAH59E3e5Tn3pns+sY=;
 b=COzaFFyamAUvi9qUBcjJafTB5DoZFOmUTrfWwawyiRPxYHC/cWwyrsgiejWEJvP5i9vUmk1WY0Y8SuhhmkATDfMzn9OqbssEFMEekmbU4p0YUHRkJSkjN7/jVWryEQaMdAWz9GzkrlDPJlV9ELrzZV16o6yUpxomr5tagoJfobAFw+A/CF+dQprPvraIMqGtTfHsVtrhIioGhr77PfmCFwdsLmoUfqpgyRB4L0ykdBeniQG4km0HefUeR91dYJqEVX9UR/I5l45a3anZTi42eUI7r31nJfGXIfsRUJ5DRwWVslTME/zPnccnva97dLflHZ84CuTukAq8ThS53xtvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3tsa/MDtLn/bv/bcyLy1vi8+ZAH59E3e5Tn3pns+sY=;
 b=E62CUgPk6MkMXEsYgnXiEtygP+vDL/9kZmOShB1t5hoDOuXbXcyHJPSqIQUUAMk21IZB/lsyxIWC2PPUMbuxsqsbZgSUAAntT8KHbL3E800AlX5m/q9/unH5I2hqy1MiVrRG8n68UGsEqqttNE85d1rdlLcE1s0Ije7vr0yscnk=
Received: from BN8PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:d4::31)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 11:17:37 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::15) by BN8PR04CA0057.outlook.office365.com
 (2603:10b6:408:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 11:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 11:17:37 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 06:17:35 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 5/5] iommu/amd: Improving Interrupt Remapping Table Invalidation
Date:   Tue, 9 May 2023 07:16:46 -0400
Message-ID: <20230509111646.369661-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
References: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|PH0PR12MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9ca461-cf51-4a79-dfa3-08db507efed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHkWL54c0k56bIDJx7CH6YuVyTGVSD8oAlR+9/pwr7nBfKCo81lN9Sil0AmfbQGOnaFS+QtIfQT3wGCGZtBwO915d0us1fl60df+ZCnEXO2z+f5DWTHGgBpFxOBFy/REHhfUgQv+vp5sodSlglRkFdWY/DuND5yKCf4ZKZNPNdFpAD2s1ZttMRuvyQ9PfrcskqC+I53Sux99O/4TPPRZEoL9ihEj29P/YOcggljS41sirXlLkJhZjQfkF3ZZr2LnjTl69lxm7J/rjT9rCxwTsMk+r8N39YnOsNYlkQSU+rOFziD6uNwMylaz9zEMDQ4HakppZc668hlNvhaxAPcAMNpVrwQ5yUeQDNDo0WtH5/gxm1Vm18/QjI9TLVnpuJk32jbPbG3ly5CFT1UOny7RvMvFR4yvzWV9jQTueIIGHd8dGD5YRYnSU1L4iFMDy3PD4b0RUheAyFLcgiOLmluFNiIRAiNw/yilyeAJeqV2yEaiaVbaU3Zm39qQSK7ynJTTo7UDI2KkoZqezy6YTS8+gAvxhbJ64gwHh5NByKjgQEqACSXW/PnSfr3ngcL0tHiRSJLVZZwcTcOPOns8LMGhRUEYloXOL+OjH5qYOnBSsmig9gXUC/SiY+ejEf8260RnAgZO2bLgie3DIAs7zZsOAmVemadcft+HIFL5EWEYb6xQzTdVXUde7rduBijvY2ezlsWTZTw3ihHPp4hNpgC61nIAODS50+M9ZI3VOdK7HIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(2616005)(2906002)(40460700003)(186003)(36756003)(16526019)(478600001)(44832011)(6666004)(7696005)(40480700001)(110136005)(316002)(356005)(4326008)(70206006)(82740400003)(70586007)(1076003)(83380400001)(81166007)(26005)(41300700001)(36860700001)(86362001)(5660300002)(8676002)(336012)(426003)(82310400005)(8936002)(47076005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:17:37.3791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9ca461-cf51-4a79-dfa3-08db507efed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
index 01d131e75de4..798cfc01b715 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1747,7 +1747,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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

