Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E11E71634C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjE3OMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjE3OMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:12:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFACFE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOdpDNO4kQZUBwd0sYzpQff1saappuN6OZEnTym7qM7YHBIJxDr26aIBo9tijstIbtycgoncZaQ+gFu+x/g5GcNJAn0DMTTmGZrOTuNQOdWedC5Kpi6ZnHf0pHc11Jc6Z9n1lGf+WPX7Zf2TNRWRsKCJawclHwYBWi+4bkW/5VJHIarJC6c/jLcXfc08AKIz0qa8kTIsero+UEf41btRwfqdOIBatqR3Z/0/VHeR3w2/gLyQL3SJ7i+4Q+a9jHVV3UYwiQFnyOmBejluYpT19lOznF96UAysVCi/JH/VdSEco6P6QhbMFoDZEYpDhRNgMemg9Il11E1jlhR1XkNLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVqVpbSQ/trAhvaBLYKV0USAlWtHJf5UXN7XTgy/4Kw=;
 b=V1cTBnb4Yny3mjnhGXsYI1bOVCKoVPqCB/ovTke4gmKw7QgB1lueZUmWaO+6neVOIDDoFe2GkRqJfKcg/77ME4yUJuJsd/3luwcMo+AQ2baN8G6gxYM+MuAcCsn6Kln7n53BlqLVR4rLQ3qpNVcTipysp3f1V2zHPWzfjuXkgbkRKv9dNUk6d1UN0qzujINaKYXGotjGxYs2f0ZEaqnLtjbYSPuMaR0XdziWfV4UOhq6lflJz00Srb3RRKElFSVLPpbyy8mQuyRyl1WNkZWVNnsP4w3JEfOxDdlWR8j2znDErUIu12DR1SxvZs0YgSiyMpiu4L/cofvnnGGuIpVU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVqVpbSQ/trAhvaBLYKV0USAlWtHJf5UXN7XTgy/4Kw=;
 b=uP//OT8UsVgligOL3/2BQCwDESpy/ROXBbeTeveZEhhEpYiSUXNcwPUKu5pZPQ4/5V2tOYUeSoRVSQmnDOcwiZsw4LT4YjgXusN5rGBnOkaKnh+sPnqOBaUDckm3dJdJGd0aBCufnqf8jJoJvxYcYpkfjy5EnPMuie13BRqXFTU=
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:12:07 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::9c) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:12:06 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 09:12:03 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        <jsnitsel@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 5/5] iommu/amd: Improving Interrupt Remapping Table Invalidation
Date:   Tue, 30 May 2023 10:11:37 -0400
Message-ID: <20230530141137.14376-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
References: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: c425a9ca-570c-4c04-e2c4-08db6117d9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEuSmauE/qiNR/KT4EpObdkSQyGBz+chsLxt4ee/3DrisOdtMZWULgqtrY3hNCsubrqJ68ntJFDmtv4jA+Ne8sp2JHOcfWsrOHx7W/0lN3873NxG31FaCvPI78N5GlrSk0SZp8vn+/fs08V9BnA6TGjXg2tsqafU98fhrLGMOg22PeIp2H4kndWhdQCzziv6N96f55t0qQlYHMhuSti0uDxLhOhtPPVL4Zpn8STswm+Pv8rQyIWEVaAhUE3M/whMxWJ+FtWufyEdQcgqUdLQfHW57wEK8zAO+pC5NvNOUv9VZCNw9xywb0irqzxt1y4LD2aD6pNTsGFZWI38IqmamsFT2SAzAo0kUjfmtFJpkRp8WWCxyEusO5y2GcYCb79l8tMVHPgd8dqi5O6vx7jtJDlYKTffc3TdZPgUINzOyVTVvRkRJT+6dASXEZ86pjftYA00Ha5scgblOXR1ggnrN8y44uRUmDs5E15JSYVBpe8Jd6BISKCdHuZLTQFYmpLGephuyVlsNenUlDJxXw270mlrnG5/tDm11fiYwAf+FHOj6Luizes+KFPNltjUH2LcZg/BwfGkhq8hjwMkJ9d9U7COl1YEzMSTkTSQ0/Bx1TkvA5aav12kH5fAQS0JZOzRk1OYlP4ARNdhb2yqVIlNEX6zSJyjcKAEhM2f1rKFo0FRy1TUO8QMJynbYKfCAh2EivZEgiMHT0NxsVlhVNB7czRaN/W3ny+YzBkErGBPjAxr6v2zc7zix1HjwTAbG2KpFbrAjr7IgN/OXcZk4E33lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(186003)(1076003)(2906002)(16526019)(36860700001)(2616005)(36756003)(40460700003)(83380400001)(47076005)(40480700001)(336012)(426003)(4326008)(6666004)(316002)(70586007)(70206006)(41300700001)(7696005)(110136005)(478600001)(54906003)(356005)(81166007)(82740400003)(26005)(82310400005)(44832011)(8676002)(5660300002)(86362001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:12:06.9907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c425a9ca-570c-4c04-e2c4-08db6117d9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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

