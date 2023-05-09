Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F96FC4C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjEILRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjEILRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:17:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F2446BD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+6Xt8GIie9liSRr5kam6ThoUToLoWyA75DoWCNbvcyeT3D3Mnv5j/HOYeVLkCwRavbxQIDEC8HhrglnOhm+BkWojyuhdWMzw+K1yumPE1t6Mdsqu6p7x7G3EGPI091B+nmndaCACw5gfURvMFJfs7gOGVM9X7VEdGb2fnwmZXMc6G7uXIbtJMnN6NSBHSj3ujsLscOxlSL+JvgQ2IPCkljVhUBi8k45rAbpVjO5fpFoy5uI/qDYdmk2fG1lAn6KH+JESJaNfIm2uFi0J7JxPPNEP/bo35kWdPlFmlYXqvMVvi50Xk6ZwBYxlNHgyKyGGdm7E95VZTJ84dmFoIoD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq73+IZrlw9jHoBVbO87NURLM734QIXFzrUPsqkI7Ro=;
 b=YM/OxELfiXp45IuS4KFotZIiDh4oHg3groRsXHjE7AD5GtyKUEHLfRNJ7KV2G79tSPIkjGjAc6HGYjL3fLL3pks5TV1y5QL6DxhIi8XWn/VQW7rteqo5l8W1tW4AwaVMsWNPpBcI3XMHH+f2X8IpNputiLP9Na8S3tfETFDc95rHgJOcpkrcEleGaJv3ZJike7KEW0udl0KRZxO3bZa89n8XIsPB++bbvbtVWBGo2MUAE+V3QcI8ld2YroPNg8/QL9sYw85xuWGLsiSoWLnrJwKkYcGfFQoE4W9lZSDePhi91mAFm6ta30lnoatBbuhPCSDe5R95AOPFPqUBVEW+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq73+IZrlw9jHoBVbO87NURLM734QIXFzrUPsqkI7Ro=;
 b=ke/+HaYZ/wCSbMhfrVBqkTltSDJwcnB6d+0WkiP/UD96duLiIOyz2hWwh5e3XBvUCcowbdQ+y6lDoA70OlfsooELHrNlbZIaLgk0uZcz3yf2xAZ2QCnKez87NRhl4T1qO979JmmqWyR1g2QuwzQSqZx+abjCQrUDTtyOI/33HFo=
Received: from BN1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:408:e2::34)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 11:17:33 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::df) by BN1PR13CA0029.outlook.office365.com
 (2603:10b6:408:e2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 11:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 11:17:32 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 06:17:30 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/5] iommu/amd: Remove the unused struct amd_ir_data.ref
Date:   Tue, 9 May 2023 07:16:43 -0400
Message-ID: <20230509111646.369661-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e38e9a-20cd-4f5f-c3da-08db507efc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ummg7Bp7LIoVQkz/0wpAK0f6gnpl+NwPyaUwToURUsflgoPAHmz4fiTwF4bv15rlUsb5wwON+4TAyOB3cg4ZSYrg67jmQK5T6pTJ1iQhioivMY7JwrhorEXQaFpYJzY6hc96eCbvSElkkdAcqxLWhfhzjXro0rvFBsgkDRG98cbKCUyP1/UZoBNY/j3pi7wlOEpKeZbh2lHaDtgQ6MP3WJrLe7Ykz46Fh0ZhAqxv+yKU2hIqGfcohznOmlNQ1A+8DhUQqhk0TQ1o209olb/0gFwZadBYcJF/jfC0Pf6rh4sKp78uYrjo5hb10GSfGl4RvqEsDJPIk5X4DQWwiKoSbIxfeu0d5oLDd7HuQMX8d/SMXiRm5zP2NwS55gguht51yfOMWdBGT7GGG/Kz/V8lq0/gB11IFCG/nF59vpuVR3esncDNZROlV1RdaB6MapzAHTUYzx0sPhBqbixuz62rND0NVDIkTJCQoxhcSxUPg9YY+ycXskqtf6wdHIHSmt1Tb31cH9f/I4iRjJUuDOdTPbBgD5O3GcTVhE5IyR6NkdMzywifLr2QcDHkRhZRic4XcEqkRoBAXf733W/khSjYFfgNisBWs+1Wnj1ZuXFxQ4/c+63+E/+T9cKBaVWxXp995JGrFPIsmIALozw+bMULgaJ+A/jTAZlbTPiYvlwAXfp5g8f5KSZruZ4M224fX0Es5yB/4ufsPE3TgzOtlaRw0xd/lZWdUKKmzlT2TFywPbHoxh6myv6qEjHcV9U0nwsMmrX/qCAcTKlw5L1btEW85Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(186003)(26005)(1076003)(83380400001)(36860700001)(47076005)(2616005)(16526019)(316002)(4326008)(70586007)(70206006)(356005)(81166007)(336012)(426003)(40460700003)(110136005)(478600001)(6666004)(7696005)(82740400003)(82310400005)(86362001)(54906003)(40480700001)(8676002)(8936002)(5660300002)(44832011)(2906002)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:17:32.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e38e9a-20cd-4f5f-c3da-08db507efc2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

