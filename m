Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCBB73F2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjF0DkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjF0Djc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:39:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC0A212B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWHK06w4xl+bcdcAl2udWrmNBuS6YeILeef5/zlEH4mNJNVkg8WIJ8+ePxNELeeAPfc7dGGZ5tAxGYbU5kN2E21eM+C6xB0VMhkb6rXIE42tMnvwYuhKGPMFHhB6nQ9h/dyGCTUWpukAnjbcvCBsMYN8Mg0gFa81OvAR6MVIpZKz42cwtqlmSqRyjred7kg+lZwZ6TH+zaJGQHArZBUmeDkP6h2rwbvNjT3bGm1+n2klJh6kYMv9ylH45NBBW8srvT7AwKcx8/z0hXsjSqAjSspwB1QhqeHSOWpNngmSpYV5XBoaPNK2IupswcP/H/ympDQ021FmseEmd6pKXf7ZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rckj7AZTnXzErUM5ZBZD6uslWB5pi2z0eiEjhTCgcaQ=;
 b=iBvZkGVb5DbIClB5qCEG/VtlpeNQfoa3sGbFfENHtnq+hnwz+MZWBx4XNpD8lcbn8KU2xu+UdkrtCQ0ZdFn/OlT948chsrBFC6D8pXY/Eqp28GYNAANqAmEVKcF8NjyRZc/VFZ/FOm46n2HVwMK2TIorVVpcKcbm2XUeuYGCIT1kfuv5YKfiNm+Bkbg5R8ZG3qOrxolqU4cEBkUUwTuqH87Ao0/t4p4oYfSurRAewRq1I+YOFWaVtGZRO2GovLGYb3sVRNRh8QqkGXxre5VgivXo+MBYY2KOcQBi12fMj7M5R3q3LiZA9x3A9R6/6MNIM/NKKHFyUGi/k5kCRYZ8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rckj7AZTnXzErUM5ZBZD6uslWB5pi2z0eiEjhTCgcaQ=;
 b=Y/z9jOlpJYav08fnEJFonft9MSUr6pRHb8rDQ5SYez8ykZz4MqSIfToeAipq4abCQbV1u4Ojab/NZN0P/t+UxvWYgvgjSKPRXpyLSWDsCTWJH8YCU0DNQ8P/2BphQB9bM+i9HFs4tsKOEALrL/rXfHlbSsheedxXMcUpUPCMH19gG/8ugYzI2TLZgVWvs1aT8SMsCeGH+0mH+LbbO5kjviMMX+6A/trgCHdgax1q2rj9RVzbVi73BTTaay8WSmb0vBa8LehDGNTOW6OdhL6jurnlDP5DK7WCPY93J7WAWhyky1uU7aueIOsFJ+YXrfzzbx531KO2LOONTHxplf0IiQ==
Received: from BN0PR04CA0204.namprd04.prod.outlook.com (2603:10b6:408:e9::29)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 03:34:02 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::53) by BN0PR04CA0204.outlook.office365.com
 (2603:10b6:408:e9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 03:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 03:34:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 20:33:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 26 Jun 2023 20:33:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 26 Jun 2023 20:33:51 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <robin.murphy@arm.com>, <will@kernel.org>
CC:     <jgg@nvidia.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <yangyicong@hisilicon.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass with a pasid support
Date:   Mon, 26 Jun 2023 20:33:26 -0700
Message-ID: <20230627033326.5236-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1f21d2-3a62-4297-b12a-08db76bf598d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1iCHhN5/tEHfZoXTUsKj46I2/LGl0TtG3AOgFNA/RTIJ/+B3WzsLy1XIwlKDFvE1ZMwL1uhx632YvomCrgxMnm89BGVd/FJxM9yRrRJURY9U97wPApjsxy8ko14boHwT5rqOMNWWpNp9ssgmhStUeMzul6e1nxtwhayGL86vvhQyke2b0NQEPfcbKj2qdcRc+hbxnaMKoosu+ELXf7AVU5ZJUaz1dtN7G1RFN0Qc/G0SxJXYueP9F6XOl/xaqYLwRvChzug+M2hCg+OThU5WNrkfUZMEZxKG9bTc9ZlTnSjhFt11PWaGP9RdXEIIoA8zQ4wSwvweckWCSahNeKw6UI+R2T+j3kugpjX2pNiqlV23AwnJ5kA1UvCc1Df6kTGjtG6T2NOEaG51Mji8NzjuH0puZjxPQILuNrvWxcIzO+koxTQ3oTUxmbcpzNc3sSaGJKNfJgCr2v7GEDBx9iSgtiWP++BdAIHvjcEEAWgUXNaw2h/hRoCLpBlwUqSrFnHG8Ax7c4P5zwUx6GA4ySyesz5F8GYkzbWfA76MWWenyAMeFCP1XlrWrjSSd/vAfULrqe/RUvCd9CPOmocM6D29hBr0Xqd2J3Rkd1/aa6hZpd3c8D5iSnb/+i2EnmRiagTn0Vv+lWmLph2grlcbyttZVZi9wEu5o9kW0fF0LT5AKrqC2AWCw9+BTJGA8IM0vsVHRuI39o4kkCPk+5ewN9l6BA7asY6GPUhvtKuHJ7Mo9Mol/XDuTLO1lgq3TNgeHUqvD4glDc6fraoW0zoVwqDGZ71t8YSCVzxyLO/8KHvjUs=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(1076003)(36860700001)(82310400005)(47076005)(7696005)(6666004)(54906003)(110136005)(83380400001)(336012)(426003)(26005)(2616005)(2906002)(478600001)(186003)(5660300002)(356005)(40460700003)(36756003)(70206006)(4326008)(316002)(82740400003)(40480700001)(70586007)(7636003)(86362001)(41300700001)(8936002)(8676002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 03:34:01.4315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1f21d2-3a62-4297-b12a-08db76bf598d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver would
skip the allocation of a CD table and set the CONFIG field of the STE
to STRTAB_STE_0_CFG_BYPASS. This works well for devices that only have
one substream, i.e. PASID disabled.

However, there could be a use case, for a pasid capable device, that
allows bypassing the translation at the default substream while still
enabling the pasid feature, which means the driver should not skip the
allocation of a CD table nor simply bypass the CONFIG field. Instead,
the S1DSS field should be set to STRTAB_STE_1_S1DSS_BYPASS and the
SHCFG field should be set to STRTAB_STE_1_SHCFG_INCOMING.

Add s1dss and shcfg in struct arm_smmu_s1_cfg, to allow configurations
in the finalise() to support that use case. Then, set them accordingly
depending on the iommu_domain->type and the master->ssid_bits.

Also, add STRTAB_STE_1_SHCFG_NONSHAREABLE of the default configuration
to distinguish from STRTAB_STE_1_SHCFG_INCOMING of the bypass one.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..8dc7934a0175 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1350,11 +1350,12 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
-			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
+			 FIELD_PREP(STRTAB_STE_1_S1DSS, s1_cfg->s1dss) |
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
-			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
+			 FIELD_PREP(STRTAB_STE_1_STRW, strw) |
+			 FIELD_PREP(STRTAB_STE_1_SHCFG, s1_cfg->shcfg));
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		    !master->stall_enabled)
@@ -2119,6 +2120,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 		goto out_unlock;
 
 	cfg->s1cdmax = master->ssid_bits;
+	if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
+		cfg->s1dss = STRTAB_STE_1_S1DSS_BYPASS;
+		cfg->shcfg = STRTAB_STE_1_SHCFG_INCOMING;
+	} else {
+		cfg->s1dss = STRTAB_STE_1_S1DSS_SSID0;
+		cfg->shcfg = STRTAB_STE_1_SHCFG_NONSHAREABLE;
+	}
 
 	smmu_domain->stall_enabled = master->stall_enabled;
 
@@ -2198,7 +2206,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+	/*
+	 * A master with a pasid capability might need a CD table, so only set
+	 * ARM_SMMU_DOMAIN_BYPASS if IOMMU_DOMAIN_IDENTITY and non-pasid master
+	 */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY && !master->ssid_bits) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
 		return 0;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e..8052d02770d0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -244,6 +244,7 @@
 #define STRTAB_STE_1_STRW_EL2		2UL
 
 #define STRTAB_STE_1_SHCFG		GENMASK_ULL(45, 44)
+#define STRTAB_STE_1_SHCFG_NONSHAREABLE	0UL
 #define STRTAB_STE_1_SHCFG_INCOMING	1UL
 
 #define STRTAB_STE_2_S2VMID		GENMASK_ULL(15, 0)
@@ -601,6 +602,8 @@ struct arm_smmu_s1_cfg {
 	struct arm_smmu_ctx_desc_cfg	cdcfg;
 	struct arm_smmu_ctx_desc	cd;
 	u8				s1fmt;
+	u8				s1dss;
+	u8				shcfg;
 	u8				s1cdmax;
 };
 
-- 
2.41.0

