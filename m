Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3AB66434F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbjAJOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbjAJOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:32:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C6DFF7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:32:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjFOBr/CrC/3iXjeKExbK4XJg5iC/fGJqcwq2OtholnDYIlQGgs5DlFR5pL6xYesMGLcvANpHbalqa+UN168YES0nfqFo5Do711QRJbIe93nvlsfXWrG+udurZPu89reuSOxqLOMfLHRf5XVb6InnrO/qoOJbX0RmjBgBuaujoRcIW/IRgTUnS2GEmOnWMgOfcqrwg/UujhbhomZ17VLSLy7DWtOarY1Ce6e1YHeSUvzzM3kjtufPcxa7FX+TJzk2Yn6wmRCIotEbpl14Qaop3n0Xc4+Us4ddyjRpASy9bzkwtYxSXHWYWoVsFld+rC2uaeuc8CpnB4m9l9nNyu2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjUmZ8NdtlWmtG6YX+A6YHtPFOZFATTgkzAlw3oUF1k=;
 b=BSXq0Ub18jctUcaomiZOPEJuaTOG6yVrEf2p1uwSin9YznzF1i1bZmLblO/paub++HyBtYYdty89enU1g3td92DhlOc3NkYu/BH+GZhYx9VRdz9EtoDTEwz3BwhkpFRcB8nmviQnqpfX2qhqOmsjWpWwNx6Ns/4K4u3wNrWPQp3mvZByX2gvZn3SzPCSJ/8kDSOt5GRW0IkgNN3qQc1WqkYAihbntxNHVM/X/10HuC2gTWHPYqppOtGm5yvTuGGNDoafHEPSxmWynICifdbkADcvcg/B2vylwJe2PHoJf4HYsfrYgRTBRW5Fhg/xIT1L0lu7FOIPfVwQNgVLd6RzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjUmZ8NdtlWmtG6YX+A6YHtPFOZFATTgkzAlw3oUF1k=;
 b=SlzmlgduzTZlxki7/KkCAVOTZlzAtVzSgrYsGFDorPxILs23qpt7OWeBAhkUDtLo8NZRkpE42SFMiEywMWfYycTAyI/8DB37oqHh53w9F67cenVaeW+G8UW2GAwwCTMEoW0irioCsBELmoeCGk00hC/2b+mgtYnaO4VDw3NwZfs=
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:32:16 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::a3) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Tue, 10 Jan 2023 14:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 14:32:15 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 08:31:55 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>,
        <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/4] iommu/amd: Introduce structure amd_iommu_svm_ops.is_snp_guest()
Date:   Tue, 10 Jan 2023 08:31:35 -0600
Message-ID: <20230110143137.54517-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d072e2-52e0-4af3-adf7-08daf317787e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkWHGL76rdfUP0fA6okYx/6FuaKVHEkFSH3YB5BHi0kt8+nXWITQ4hAV4c5oXnn4vJQ9kCSEp2j5KH1H03ajg3qEFt+GfxRVXgN4OLnA4ZB7KVjs2TnI+IzTfmtRmwsdTyTC0bOnNoxzfuXtnK8uJfL8GM8D5aDM+PDi/ciYUdmuoSoFOWJ9sEXtouVX/MXms0GOIxPPqG5OEQwUiM362yOkxGwPPOEoPmRcW28e9ir3cmSt38FUYqvIfVyynlpKyFzCS6cZM9QQSU6icBBxI/1mbh4SMOAEiC2S5Oq5z0r+msbJkYmxwTbsvXUXMrrD68XOo3lbpCidDGo2LLWwi2BQo6ptewkg1wa5EDNN8PRmX8stdXKwLWKAvPdRBqvOKdLl+HQMcs66jSm0ZQ1C8biYpO2m7HRD+SVSR5bFS0SfwlJOajXNuoEIV9en3D5aV52yt/B6obT14rzQ/jg2ELIYLwaKJdjCWIJeEgQ0TuUsdKiBpdcYgYyoOrY2N9ciNlOfN0BN544rE9tOVoDtAnbNU1XI1y4NCd9KwWMVmnDcOWtb2LvDKLlyndQazJNbejqFbnaWcLQXVl6lm+3Tzyc+DAXt5pcSyse14wqAEOyvuTdPpteuWA8Ydnngou1/EVEp/IjTS5j4tL7MBzUnJVBYT50N8jpl5ZBeX9MKbWZhQXySQZefs1bnGuIilOzJBfi4DgoQFXoE+FoRHU+qNIJ0FWjStpNdNoxT+v24CpA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(8676002)(54906003)(86362001)(70206006)(4326008)(83380400001)(70586007)(40460700003)(110136005)(41300700001)(426003)(5660300002)(2906002)(44832011)(316002)(8936002)(2616005)(1076003)(82310400005)(40480700001)(336012)(16526019)(186003)(26005)(47076005)(6666004)(7696005)(36860700001)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:32:15.7243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d072e2-52e0-4af3-adf7-08daf317787e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure can be used to provide call-back functions, which
are called by the AMD IOMMU driver when it needs to handle certain
operations.

SVM driver can define handler for each operation in the struct
amd_iommu_svm_ops and register the structure using the
amd_iommu_register_svm_ops() function.

Initially, it contains a function pointer is_snp_guest(), which
is used to check whether SNP is active for a KVM guest.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 10 ++++++++++
 include/linux/amd-iommu.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 681ab1fdb7d5..a03723930f70 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -754,6 +754,16 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 	}
 }
 
+static const struct amd_iommu_svm_ops *amd_iommu_svm_ops;
+
+int amd_iommu_register_svm_ops(const struct amd_iommu_svm_ops *ops)
+{
+	amd_iommu_svm_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL(amd_iommu_register_svm_ops);
+
 #ifdef CONFIG_IRQ_REMAP
 static int (*iommu_ga_log_notifier)(u32);
 
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 953e6f12fa1c..d4837af75550 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 
 struct amd_iommu;
+struct kvm;
 
 /*
  * This is mainly used to communicate information back-and-forth
@@ -26,6 +27,10 @@ struct amd_iommu_pi_data {
 	void *ir_data;
 };
 
+struct amd_iommu_svm_ops {
+	bool (*is_snp_guest)(struct kvm *kvm);
+};
+
 #ifdef CONFIG_AMD_IOMMU
 
 struct task_struct;
@@ -205,6 +210,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
+int amd_iommu_register_svm_ops(const struct amd_iommu_svm_ops *ops);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 int amd_iommu_snp_enable(void);
-- 
2.32.0

