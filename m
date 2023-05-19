Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277FB708D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjESA4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjESA4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:56:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48639E4A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEC8G41FweqFak0FO7JqUDyWlLprbaud403qkm68vDSNaTCfzyVLduaMqugD2TKtpxD6/7b8vtguoQtJM21IwgGt2GMrsPaLSqpQEOCYuHXclWHXZSpKvbvMX4nYQvzclCeocuof2/KS1GPrd9aJg5li8ixtAb0tmMFccY78+fVLrzp/9UG77Kqjtuwld6Evw7GPTldypvaFXv5waqvOGgRmGjR6UXBTFQbXCPBPE4XW4hSkCOOxKn2pGjf0GoBqn5h4H39gQXFq4Tsl6ogICe5qMusWwKKQ/5F/kk3b9wQLMLyPJ6egu89xDBd0+JVeCZcFPr93oBGSLIsf3Id6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq73+IZrlw9jHoBVbO87NURLM734QIXFzrUPsqkI7Ro=;
 b=maxotJNwtrgJTXaOpLzQvAp6W0iezsx/kpNXy6d494bAZnjlrgsjMRzG57qUKIFdQzMWFkt5nzZEhhZxKfllIyanDeT6UVhs98pK8Lf8JSAvb+NnogWOqHSQdqpgJ7azrcnjO4VsUMvBIJR3p8i67Hq0agcgATKLiSiiuHbSpFm6Oi5d2pCoiPXp1W0bMM/uVFmnaVKxzeyM2+mj4lnyCPq5wtd8DB1Jsr43CXlKyLAz3pRZ98VMo0ri7avSu6xPFjUteYvluL1uwMhSapwjqmYMx0S6EnI75y6+QrAB+QVZ7KpJQG5UAFjaF7kIGs6z2yq/4aBu9q2o5doUa4yvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq73+IZrlw9jHoBVbO87NURLM734QIXFzrUPsqkI7Ro=;
 b=utBvS0dSO6rNmYov6r6FECmUe9RwMIu65YacaQWkkxj7gO/EPFnpj3aTvl3rhATDetAlB8q+kL8hgoIcZoOCPimG3mvEXQVObXaAj6blvfcMa+DgZ/FPEf8Tdpufo8i8xVzn5kbf9FKypQ574f8ne7+8MXdWqB2wiBxW2g1hWNI=
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 00:56:05 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::2b) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 00:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 00:56:05 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 19:56:03 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 2/5] iommu/amd: Remove the unused struct amd_ir_data.ref
Date:   Thu, 18 May 2023 20:55:26 -0400
Message-ID: <20230519005529.28171-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e30c014-20f3-41cb-6325-08db5803d36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8Zah0cCRG7b0vbynZB8D9hsEpjuIGaua05YqpxEnZSkMf7f3y3imDqlo5dCIPAJdr3fbVDOsNvpNr8ioTxFb3JNG2bIVt/ToCRPJgLy7rYMD2JX3GNRrNAVXUL137fANn2vjJ0dDQiJW+EjZg6tmnqfmcXNgfeR6ubRl0lVve3+NcZwh/j8mw8n8VXQI2yZjP/soQS7lukK2tL+Vydum4ncMIpGQnJmHegqxjZmcVjNRHrJMaqYC6uDvn4rBaSJrmQUAwRinDIjXY0a8mELBFafmsITDGEyYxAw3D9F7hjH0xKWXYqcPaVZaMdKQiF7Nlw9Atsktti+bXBVbSlysbGeeetIGkDlkZJ0m113TJHdbsAxZ8RsrGdZCaIhtbjEUfdxRpX62kgAk+Ad6oosCHcR/bQqp6GPfKuAWTbskYeTNWC1M6DKvdmswiqZ7r48xAKvoOIwVw6MEPK3tDVmL21UabgikJSKXxx5D+zW6lzmu58Qty108eh4DnkEU9h4dEBl1xeqd7u1uUD4zaTqYaCau9Cm/3Dtq9MsxqWs7xcgWH/JiMlALG22of/Vf5WZjIL1rsw75Znrv8YVnga1z8Qmfkwe/euxvCZ4PVjSVmadaaeOOV4RfJH/PBDkQFmpvCULsJTR5705y+bw5GPJ/dokn2IH9BkRyN2xxh8tSIPIBc8gOYwmRTBWwDE8Bt3xxQmSltOsavYNtYfJSuxx77IFnRVptyw/SGmjnH8EU89eDCdqTt7DPYXxu07ZHhe/CrWHgzpvrNOml3oLQnv4Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(81166007)(356005)(82740400003)(36756003)(40460700003)(8676002)(8936002)(5660300002)(44832011)(41300700001)(82310400005)(4326008)(316002)(86362001)(40480700001)(70206006)(70586007)(426003)(336012)(83380400001)(47076005)(110136005)(16526019)(1076003)(26005)(186003)(2906002)(7696005)(478600001)(6666004)(2616005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:56:05.6580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e30c014-20f3-41cb-6325-08db5803d36c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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

Since the amd_iommu_update_ga() has been switched to use the
modify_irte_ga() helper function to update the IRTE, the parameter
is no longer needed.

Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 -
 drivers/iommu/amd/iommu.c           | 17 +++++++----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3d684190b4d5..a0ff1e852efc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -993,7 +993,6 @@ struct amd_ir_data {
 	struct irq_2_irte irq_2_irte;
 	struct msi_msg msi_entry;
 	void *entry;    /* Pointer to union irte or struct irte_ga */
-	void *ref;      /* Pointer to the actual irte */
 
 	/**
 	 * Store information for activate/de-activate
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4a3a7346ab21..0c4a2796bb0a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2999,7 +2999,7 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
 }
 
 static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
-			  struct irte_ga *irte, struct amd_ir_data *data)
+			  struct irte_ga *irte)
 {
 	bool ret;
 	struct irq_remap_table *table;
@@ -3026,9 +3026,6 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 	 */
 	WARN_ON(!ret);
 
-	if (data)
-		data->ref = entry;
-
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
@@ -3117,7 +3114,7 @@ static void irte_ga_activate(struct amd_iommu *iommu, void *entry, u16 devid, u1
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
 	irte->lo.fields_remap.valid = 1;
-	modify_irte_ga(iommu, devid, index, irte, NULL);
+	modify_irte_ga(iommu, devid, index, irte);
 }
 
 static void irte_deactivate(struct amd_iommu *iommu, void *entry, u16 devid, u16 index)
@@ -3133,7 +3130,7 @@ static void irte_ga_deactivate(struct amd_iommu *iommu, void *entry, u16 devid,
 	struct irte_ga *irte = (struct irte_ga *) entry;
 
 	irte->lo.fields_remap.valid = 0;
-	modify_irte_ga(iommu, devid, index, irte, NULL);
+	modify_irte_ga(iommu, devid, index, irte);
 }
 
 static void irte_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid, u16 index,
@@ -3157,7 +3154,7 @@ static void irte_ga_set_affinity(struct amd_iommu *iommu, void *entry, u16 devid
 					APICID_TO_IRTE_DEST_LO(dest_apicid);
 		irte->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(dest_apicid);
-		modify_irte_ga(iommu, devid, index, irte, NULL);
+		modify_irte_ga(iommu, devid, index, irte);
 	}
 }
 
@@ -3508,7 +3505,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry, ir_data);
+			      ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
 
@@ -3538,7 +3535,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry, ir_data);
+			      ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
 
@@ -3719,7 +3716,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	entry->lo.fields_vapic.is_run = is_run;
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry, ir_data);
+			      ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 #endif
-- 
2.31.1

