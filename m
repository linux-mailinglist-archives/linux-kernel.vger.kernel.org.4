Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7271634A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjE3OMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjE3OMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:12:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78990C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnifeT/X7nb4zWVLn89nfytgmX8SbM6wlND5afWzkrPjdTqvfaiwd00acmfkE68G6aXhMT0Qtt7fblTv+jfefYwEgFF7iYSLmGf5epKrhUOVC7e7jNG4bEX4XNiSXK6lDZtBG99QY/FkL/vHkCMFpI9HTt1ZYCOJSHmjBFnG9+pkfwSfXMy1/3XUcaCcbXneQUDLA519J7v7HIxl2Oj7rkmTD5Qtuu/yq9CeeiMu3wtNU0//62thjUdj+yV+OwZJSyG1VDKcROmKI4aIUssmzQi2lM7K8sQ0Rogk2WjQGDFJ8MPCEG0Zo+50SGWn2qDnMcKQ/shyJfGk6wS27EM8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwp6QcqdIjJgyKwXurCoaU7OraxSAQG+ziatjruJRhA=;
 b=bMRosdIpeTD8tp6wCSeXpLSrpJLrQ4cRrE0yj3NVOqtEDhGZ9If4uj5Kiu7FmcrWer998I/KZ0/CejzcCu4XT8R5YjlRENyZdlqkHATnDCuec1w75Pz8Q/cz+HfBObcOJO6CpDe4y1PPexCoceKPXtch62MvnglY21RfcTv0LJpSD5AWVDJYzyn/QdFhB1Z9hpvhG1nscKrETcRjciAtDfDlRKq1ik/EkzW7Nd8o0SOQQoYkajqMJhQ1VAwpvPm6npVhUFa6n9QXQrmbKRPKuovJ8V3+jKaBvem9UpWThr+B1szFQ7xDLl/GuvKW1VemxERA/4vNAvz7dmdWBtQGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwp6QcqdIjJgyKwXurCoaU7OraxSAQG+ziatjruJRhA=;
 b=bUpYV6PnShqXxKNp19nZO9c1aF8Z3iTRYQgnLxbgnT42yEUKTlg7YSR37bA241jT7Sldn7U+jN2Tw2JDPyrLM1xXPNxzx9ZzH7VXq3DMlBDJTTzW37A8eU7iSK6T4bLD7TEPzg12WnS6SLlr3yGAmoav+yoIRsGDamc1R5DD3ns=
Received: from SJ0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:a03:3a0::33)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:12:04 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::fc) by SJ0PR03CA0268.outlook.office365.com
 (2603:10b6:a03:3a0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 14:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:12:02 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 09:11:59 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        <jsnitsel@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 2/5] iommu/amd: Remove the unused struct amd_ir_data.ref
Date:   Tue, 30 May 2023 10:11:34 -0400
Message-ID: <20230530141137.14376-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6087b7-72af-49f3-2e03-08db6117d787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nl7OorybJfJD3S4uIGujxASw9+FJTVYPlilE+DGTI1cyG3JHIV2bMVwkN6Z/gNvgow1X5cjvZpGrHRsJcDwXnvpYz+ghZFpUrJ4PpwnRKEbI2bUN9+WUHVM19fkBUQCqi7/jCYj2ZD3U5w49nhDbE15f7N7UuiapooVDCHHkfzmkpH8OKUepY0t8dYWcrWJGRsgg+/EEmkBbdvibRptwQ5IKoXUyn9r7d+LEDbSmM5MmLvLf82DRGbuUAeHJR04sulFg1p65HEfCYaIMA0q3rNFW9wqmM3/g+WlsaL7Jxk+Xxop8/563+qNHvVfOiUuyBZjT4NGbIO3HFGt4f2Esm1Vt4aeVlvMoT0ZDW1/NjXnAFI7hSH4+PeMuvSws5p43U30ZMVCcqx1z/ihgMo3QNbkfSyMuNNVdUVTuyfPhx/OKfUwwfVfkGevtvmbr6yT1eaupTnWN8Y9wG6sdTI6Rgdv41ojOeihI89MetnTGFAnuXXVyzJjzR7VRvdnbBaC0Aj7EVoia8wocmnHEeHoxnrvxlhClAcfHC0rO7JLecaGfmCnymH3MpEOQbcdi7klTJIXHDFYD1tbbj7+KnFvvIlplqbNuXY5XeQKvVBlGtpkX3KWec4JNU3XtqZF5Ob503nDsZtoMl80lCbzwEMZVsS4xy5H12Iyd6i1ZzPPqMaf8pHeGAAUHtAQFkObsadOfbT+Um6CohEWw+Q8vuL8Bp64++mRCPgPtMueQjnKrVymEkuDn2u+Yyk+uOp/XaCFWGP5qk1EFu/a+B6g00kNFKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(47076005)(83380400001)(2616005)(426003)(336012)(2906002)(16526019)(186003)(40480700001)(36756003)(82740400003)(356005)(81166007)(36860700001)(8936002)(8676002)(86362001)(478600001)(4326008)(70206006)(70586007)(5660300002)(41300700001)(7696005)(6666004)(316002)(26005)(1076003)(110136005)(82310400005)(44832011)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:12:02.9597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6087b7-72af-49f3-2e03-08db6117d787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the amd_iommu_update_ga() has been switched to use the
modify_irte_ga() helper function to update the IRTE, the parameter
is no longer needed.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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

