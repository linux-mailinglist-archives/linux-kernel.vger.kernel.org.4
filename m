Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892866B21F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjCIKz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCIKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D060459E7A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMaCUukIFAooyETFmLGTqolPuqk3Z9QkBzPGj9Uoh1t+6nlFGON1SJd0A4ddVoViThNdstQezEJ57iuyi1byGuSmsvJDcUR+T2ZZdPYFcDI7DUO4DtFayEFmQyYkpt4NUBFpJLGwGETaM6QQRR9zHPGDE/LFXqRR49qL0WByi6vixe8CCGVloxG/Vxg2Wn5NoNqdIkluVdsPVp5H7YEdnC/FOHg554OevKvHYO178YGD8wQaKHWgEGu9Gzr7ZGvcWPZMMUCh+Fsyjd7jrlDuasbITc8byvJpIv36YhNBKGACP2L/ksZWIspzO3ERq8QvfLERGAPDXzmQ7FQTxyKnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6mV0v4fbbmz39mZPKbnbHbmd90snt/MKRfL1nKdO9I=;
 b=feF7h13e9rg1Vngcb92uWz8GZ3QkrF/gtr+B3s3AXBByjesCZAJFvSsgRhUDDvihMFJViRo9aSjyjT/wF7vqiVC5XrTIZPutfIDzVPwl7Xjdzsakf0R5rw+NZqERnIDmSLTOOHrYGK9/e4MxCETjwEvd0OxPztKG4FMuQbOiZpfQx2y3KA6YEkyYMr7BiijM154r0jiC+wY4YXQd2ukpdBQjhts9JFRBSCZrjhGruFHI47XWC/ea5Trmzrj9pVqg0yd0W2b/fQc7D5nnyElpXvqr3XSNJpYhq4G/TYKnM8kguNW16wTMPWIDGCeH3tFR+DHCIyheyLJtDO+a6kV2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6mV0v4fbbmz39mZPKbnbHbmd90snt/MKRfL1nKdO9I=;
 b=Z24a2LaKyftfxSwWa9hMs9rWUQXWWbfzwb4IlRJ804XQHB9/8S9LEHHVZngD3G0JOprwNhsqApgwtr7ZqqZBoDxRH+xknH7RgVp2wmMXqBI/i9HOZy/FCoajwDOr7DIBQE23O1CsqOTc67cOa6At3lmU53UWgcBd//RmdjA8/gfIi6h9GqfMpLRPoXnoAlFC7ZvfvoVbFA++2duPYE7y23DT/vK0YTORs3Eq4HPJu5sJUpJK3jm/GaLsN5rITvgyIPz9M58jlZTJplTo+LjlIKcLqSnq1GQ2UZPlyUqWRkoPkYjNCVLdYKplKKhU4TFfhjXlGvNEiRiWr23zIJ1j4w==
Received: from MN2PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:d4::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 10:54:48 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::71) by MN2PR04CA0009.outlook.office365.com
 (2603:10b6:208:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Thu, 9 Mar 2023 10:54:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:39 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:39 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:39 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 08/14] iommu/arm-smmu-v3: Prepare for nested domain support
Date:   Thu, 9 Mar 2023 02:53:44 -0800
Message-ID: <4740f8a40caf68ccc1f9fee5fcdf1604546fb354.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: be2ff6f0-63a3-4ba8-619f-08db208cb3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwPJdVdK50NWl1RQoHrKWqqf96pSzR8xjQ48o18mSHVZ4HZcoKUGxqVbunfw/vAOovtQ2p6wHj1OdbI4tSJRVDhLKjaN5FQVVt2vJ8ogoNE5y0FeDSv9PxVPU6o6kxb0KDvAmrtDrDKiOe2lS7nvnDPbffeqcbRlURkjYQXnemgIBzQ5hc+3tzpcL+3x90frnBGRdaF9xB67djRLxborrzw5o4AP5KnDx5UhMuVRcoqfzUlEQ+OIjx07XwHxPXYPVIqf/uYxQCD/6LBjUd6pJChLfDh6CvdDrJfceIUibwHJPudhqm7bTbfmG+JUUEggegLpoJs1VaLBoVXrEUqECaJqfyjfwQpuul3nEAKKVzpynVSeL9PQmkcc00Rk51byT9Z+3u1IzqQhgR3dj3fAe8THjf55ofTm+V7aoEHnts9u7o14jewCrOXJPkmYD2aumxfEE6RseHe7a26Js+7J8F9JEI1dA+BPDYvPselkJ0eyfYfearqjUIIHjRo7NBRRslyq+TwovftWdFLueBsbghRx+9zMSYOq3muI/O6AHuy0KKQuao+kPfEGWLcIZYAy36uqfrN2vc2eqwHl/gNZFIJKgU+1/5wSnTUPtiG6fNLvqGMDMsXeZ4GUYbj3CKCGZxilWEhlBVb2JKQehO5CBfd/3EM9XM1qWSRklDbc4b2yvppyTV2P0XfcrjAL5nQCqNes7c/BR/I3IaPevTQ/yEpA7KkDItvyo4GgMucoqGjchL72WUh6tAeAPBebv83o
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(36756003)(82740400003)(83380400001)(47076005)(426003)(36860700001)(186003)(26005)(6666004)(2616005)(7696005)(336012)(41300700001)(40460700003)(8936002)(70206006)(70586007)(86362001)(8676002)(2906002)(4326008)(7416002)(5660300002)(356005)(7636003)(316002)(40480700001)(478600001)(54906003)(110136005)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:48.3569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2ff6f0-63a3-4ba8-619f-08db208cb3b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a nested translation setup, the device is attached to a stage-1 domain
that represents the guest-level Context Descriptor table. A Stream Table
Entry for a 2-stage translation needs both the stage-1 Context Descriptor
table info and the stage-2 Translation table information, i.e. a pair of
s1_cfg and s2_cfg.

Add an "s2" pointer in struct arm_smmu_domain, so a nested stage-1 domain
can simply navigate its stage-2 domain for the s2_cfg pointer. Also, add
a to_s2_cfg() helper for this purpose, and use it at proper places.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 21d819979865..fee5977feef3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -100,6 +100,24 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 	} while (arm_smmu_options[++i].opt);
 }
 
+static struct arm_smmu_s2_cfg *to_s2_cfg(struct arm_smmu_domain *smmu_domain)
+{
+	if (!smmu_domain)
+		return NULL;
+
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_S1:
+		if (smmu_domain->s2)
+			return &smmu_domain->s2->s2_cfg;
+		return NULL;
+	case ARM_SMMU_DOMAIN_S2:
+		return &smmu_domain->s2_cfg;
+	case ARM_SMMU_DOMAIN_BYPASS:
+	default:
+		return NULL;
+	}
+}
+
 /* Low-level queue manipulation functions */
 static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 {
@@ -1277,6 +1295,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
 			s1_cfg = &smmu_domain->s1_cfg;
+			s2_cfg = to_s2_cfg(smmu_domain);
 			break;
 		case ARM_SMMU_DOMAIN_S2:
 			s2_cfg = &smmu_domain->s2_cfg;
@@ -1846,6 +1865,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_s2_cfg *s2_cfg = to_s2_cfg(smmu_domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd;
 
@@ -1860,7 +1880,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+		cmd.tlbi.vmid	= s2_cfg->vmid;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
@@ -1931,6 +1951,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 					  size_t granule, bool leaf,
 					  struct arm_smmu_domain *smmu_domain)
 {
+	struct arm_smmu_s2_cfg *s2_cfg = to_s2_cfg(smmu_domain);
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
 			.leaf	= leaf,
@@ -1943,7 +1964,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+		cmd.tlbi.vmid	= s2_cfg->vmid;
 	}
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1a93eeb993ea..6cf516852721 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -709,6 +709,7 @@ enum arm_smmu_domain_stage {
 };
 
 struct arm_smmu_domain {
+	struct arm_smmu_domain		*s2;
 	struct arm_smmu_device		*smmu;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
-- 
2.39.2

