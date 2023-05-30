Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40E7716348
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjE3OMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjE3OME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:12:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71DBA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzeLnHnXDF93LFYyVgB052/qL2KcN3OXFPTFSftiaXiTJ+SuSE4/GJCJh8wRQvC7k4K7oW1350Q6Ueiq4I5GJT6mgmWFF8s9pKrPdntnUlML9AxLwBnAI9u+yHBS8G62URxNisI2H9HkOpL0IuPXwWGoKNcmELG6yCYKITdUcBW3yV4lfw4vL1aLNkfR4Qp/+Ca/rPsqznL8qx6Fkaj30lcBXktsVwII0uhYdFKLWMRxxMNcB5i97ZZI9w9P7GwJMX6t0F6AlLy4enxSJY6keROktv0ORwNoEBqtLn27eeH9/mWopDvAkPQOlHEbwwCmYEV5f35fGyEsYfYipgz5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee2qB947fjXKSbJ19wva3P15EHS0kat4zofWoK3PcBo=;
 b=DdCis3VkYBQ9R/TgqePhfQJyBGioC86A7ujni5I249GRjYJuHmT3qAu+Y4vJu5movQPhN+RETqxFi8FeAD7fISbfTUTlFDHc2ANYRRSnG1JROVF3hKoRYGRCRkBUuUm9Kh6/DaPIqcqgUhWE7UXjdhp3Xm2qEdsnybPStt1bcvMIqS0hgbcYYFItjaGamIVul57tGLC/q7tLDCXgcVcJAkNcWd1ltsWr05vA/r5SEQX5bmlqW8z+CeDOhp0UMF7DcRup9xPdga0NhyYCC3lw7x6/luuN6to9PJP8HkeBSMN2tj/gx6SeGsBjvkkixK4JQmZSNm0JT+K9VilVA/3GOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee2qB947fjXKSbJ19wva3P15EHS0kat4zofWoK3PcBo=;
 b=G4Z2/Wb1yeJrUckMYfRr324NkDx2Y9kFY3Kg4zh2jhzGJKioKcAl5Kudo9oTanIyOc2RlTz/AVDupVOuxI4eSRMmtdZIXj/s/5FOSlSFsOteTLVmorF2/sUeqchByEYL8XfPpyTUvsfZuaAqdelBQ9mtX7oau35Mp3MILJFsS1I=
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:12:01 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::3) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 14:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:12:01 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 09:11:57 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        <jsnitsel@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 1/5] iommu/amd: Switch amd_iommu_update_ga() to use modify_irte_ga()
Date:   Tue, 30 May 2023 10:11:33 -0400
Message-ID: <20230530141137.14376-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf03df7-8743-4c5e-f05d-08db6117d661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/slZlIKp4jFNHiTr24gKO/rih7Uq6GNGK/1w7J1+S6xxrsxGfVKdr2FkgLGpgltRD1atwkHj91rxlAEpAJMKdZXzVX7K0j9beMsbtK4rtXRt22ACWxpPnM3bcdDqWWekh9jgB2u/TNe9fL0YiiGe0HwEGurtMsmgg+ws/Uq1Yg/K4l6qhjg6hlo4PDVZGJcI/sMZqCFGDhcMzeOmlacRp6cHLHQCTdiloranF+QxbleIL/q628gph3/LQRBhskScpV/O9S13FGqiavzIIyTCrTii/sXwEIMTGCA79g09EIdj6PBKpKMumKRQW5LWhRmP3c9nmHVyndxgUlQjjKmGSKZF3PChMPEgHlS8Myj0bgDFN0JmSsGRl4aGC7L4tVRzCq6F0iRW2qY6DTIRRNaMjdnvAox9n8eBT/uYSHpHl658WDVPlq0GEaH9AsDxbhojKQK8FKUfQrrDH4Lq94SrxCWJzknvueTCd6VgTb0R/y30atwWgT4Te97j0qJU0PR035OkRVV7DgzCbXCbBDwMO+m4SCeHS/ICTnk93/aUesdNzGZUQ8a3dT4wrmbG1q/yNk1t7InQds7IECcwtLdW8n7XY/AjGKgmNm7Ai+VZg3dZRR573JqqzgppnATDSYql2P2aIdypgo7B8maFoCJXIU5MIBHBagHELKjjYHoixhGzoRCP8am4GNEI2P2/QrCVaRt8AeKCAY4iHe1a+5rv5o6se/zefapTl6ShKvm97Q5N5r0RdTWImK27u8M0aaGHaT5rS9jqqQGq960R+ugVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(36860700001)(41300700001)(7696005)(6666004)(16526019)(186003)(47076005)(83380400001)(426003)(336012)(2616005)(478600001)(40460700003)(110136005)(54906003)(82740400003)(82310400005)(70206006)(70586007)(4326008)(356005)(81166007)(40480700001)(316002)(5660300002)(8676002)(8936002)(44832011)(2906002)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:12:01.0535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf03df7-8743-4c5e-f05d-08db6117d661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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

