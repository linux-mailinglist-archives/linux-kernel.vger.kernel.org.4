Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705246FC4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjEILRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjEILRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:17:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8646B4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONc/SpHJkv0v3hHI2bCCf+c9v926ntiRbzv2NBWmb61Oqn4NjTHnDmDEU71av4j1NT2aA1VeWxv4dHJgrgOin18SEXho89ZaJdzgEG8DcqcXNfVXZhvGOkFffrj7yFo+rrgazRU/lcrMiYwP8lswNS3ZhRDB5GMbB2CTd9sDz5KptgEkVxvyRXCqLsrd8BlrGyJC5jx+E4GRBzYPlnWfNoqlpAUiF19VuHt4aTaF/WQrmp6i3GHCN3Q+xX3jqWpuHJFnqi29HRjBL1FSiUG50juI5tZG6rIoWA8NHRH2b98Q0NFduej1H4+HplnrQqclycZmuNlg28x1F4rGvOUkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAzvRax9ZO4PmRWi817wjYzFwxMNMYQCmsDk4g2BsW8=;
 b=H5WWZ3ME7pWGks0bSXMDR/0jrVGGDLB22yk8XrEq32mBIUW33U6bVlzMslpEPlDJUW96mUN3u49l6afbh4S3hY+PhtuneoO33hNWoA8ODp/XVgJkRjMu1ZCYbCWPhbs703WblciX2en6nlL83nUR7/Y3yWKgP+wgqUUyFLP7Br2IVvJY+bJeL5eKYGZWCD8edgjOCG0i5yhhu4c8tPc3ta2UuUx+DdM3WVSKiKLHkPjQwc21hkqI0DbYzsUFmxKfVxtdkxGYZxeLMjxsmko9xW5SF8o+TGIcd7k8nOv4KIL2/XCV4YwjNQhHIibOsaYJ0Qob/mD03cZ9kDqGvdUCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAzvRax9ZO4PmRWi817wjYzFwxMNMYQCmsDk4g2BsW8=;
 b=RE0WYlj0Higus/JlTgISf7B1n0DLpB+GyI2AXgtfmUDjEOErbGfQxa+hkAGszNwUdGb1LifVHC5VbQWHIeYDRB6dV4RiMia0kYjhD5i1GagSME0z7AtxwhsxUun4lkHAR5UpSusiWiDWkhRFctZUr4YYtgeTsXuZAfqkULfYri8=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 11:17:31 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::68) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 11:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 11:17:31 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 06:17:29 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/5] iommu/amd: Switch amd_iommu_update_ga() to use modify_irte_ga()
Date:   Tue, 9 May 2023 07:16:42 -0400
Message-ID: <20230509111646.369661-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7bc51b-472f-4233-8fb4-08db507efb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeBSJD07Zq+PRQMxwKHjv2GrSOBTrQYdEfsJKX6UY0yJgMK263korBGx9rsLH7ozvwNB3VRLshzMAwm1rlm71ANtJsbggSrE5ciWL6F5SXgMMoKnRZFqogYI+yE1usOhnWeI/DxPmTgihtwuovRIsWu6dGfXxr1XVd9Zjlrv6aqPmSKboR/Y6yBOHtJPsn8VPGHdFBQTT0ZePfPYjjmHzlUaYMF3BHizjcnZVctkit5bMJJ7Ek9VZEYdLQ+5zew+wRXAAjOUxABj9B1bNBreUpuYwT3yXcDnc7GO7c2d6fQJEPtrctAYB4sB7cVmQvfXHHcAfPeEFsQd+R2/n6yc2pwjz0PFDA5XQKWFKYTbpMuWoOsd9F6Cl1iyu5PR3IzbnnYQkjguwnRAw8Qt9JNU1K2bIpmuA0tkAD13JTDwFwLqAzBEE8wowAK2NdjUx/m069qZ6UN7hiQXeFtPejYHvJtvlxIebNTqogspklG+IR9RDx9lnjBxyDaCXdxGcVW7Jp2pFM4NzZKt26DjIo3yaIuSPnPhF4JQ4WMFUNrzImqPTRXHPPLH17CpjlX8PrF5YeBLA+qpspnVvhw4MjzI19UoC8wdUluPSmBo/+IImyda5DdL628urAWlqm5p9RvxJoFuZWl+Xd+WZcBKTQWdHBGeb/14dLA28ooMJTrkGil/wyf4eCUYWOBtZh+eJ6FuEEF47C5LLZBDbLi8wmHnU54oY2YuP01kArxbBgQ91Mk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(54906003)(110136005)(8936002)(6666004)(7696005)(41300700001)(316002)(8676002)(26005)(44832011)(478600001)(70586007)(70206006)(1076003)(4326008)(2906002)(83380400001)(426003)(336012)(40460700003)(16526019)(186003)(2616005)(36860700001)(82740400003)(356005)(81166007)(40480700001)(47076005)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:17:31.6230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7bc51b-472f-4233-8fb4-08db507efb62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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

From: Joao Martins <joao.m.martins@oracle.com>

The modify_irte_ga() uses cmpxchg_double() to update the IRTE in one shot,
which is necessary when adding IRTE cache disabling support since
the driver no longer need to flush the IRT for hardware to take effect.

Please note that there is a functional change where the IsRun and
Destination bits of IRTE are now cached in the struct amd_ir_data.entry.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ebb155bfef15..4a3a7346ab21 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3700,44 +3700,26 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 
 int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 {
-	unsigned long flags;
-	struct amd_iommu *iommu;
-	struct irq_remap_table *table;
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
-	int devid = ir_data->irq_2_irte.devid;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
-	struct irte_ga *ref = (struct irte_ga *) ir_data->ref;
 
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !ref || !entry || !entry->lo.fields_vapic.guest_mode)
+	    !entry || !entry->lo.fields_vapic.guest_mode)
 		return 0;
 
-	iommu = ir_data->iommu;
-	if (!iommu)
-		return -ENODEV;
-
-	table = get_irq_table(iommu, devid);
-	if (!table)
+	if (!ir_data->iommu)
 		return -ENODEV;
 
-	raw_spin_lock_irqsave(&table->lock, flags);
-
-	if (ref->lo.fields_vapic.guest_mode) {
-		if (cpu >= 0) {
-			ref->lo.fields_vapic.destination =
-						APICID_TO_IRTE_DEST_LO(cpu);
-			ref->hi.fields.destination =
-						APICID_TO_IRTE_DEST_HI(cpu);
-		}
-		ref->lo.fields_vapic.is_run = is_run;
-		barrier();
+	if (cpu >= 0) {
+		entry->lo.fields_vapic.destination =
+					APICID_TO_IRTE_DEST_LO(cpu);
+		entry->hi.fields.destination =
+					APICID_TO_IRTE_DEST_HI(cpu);
 	}
+	entry->lo.fields_vapic.is_run = is_run;
 
-	raw_spin_unlock_irqrestore(&table->lock, flags);
-
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
-	return 0;
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
+			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 #endif
-- 
2.31.1

