Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24A26B21EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjCIKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCIKys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:48 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF646179
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tnf9Uc693BFIgWrDArU2BFV25oh4qxkx6N5p6md0gEqrDpIHszhK2WfvoaJ8NHFPlI97pvTCbUDJ8Jxwk9C+0WwbCZAcPUPeuITfdDCSPEG7RYuj/939kpE7MpxAyBKLkcqktAGBTKhjqCwdgJpEX7uDDOE9wmoccGZgXLb7h+T+z+LYDTrNw30bLhCRU8ZaGWrqK1X2DDTbA41TmOcE9zp17rzwUxwlkuHTmf4tIAfVgmGLkTjl33y7QFJtsB4/XR/FL7aH+Roy02dUtyQmHOf/njjZlGpL826SmFzHD18nB/mVhP1EfczY6c4Vc2de8IBGubVLcg0WEI8B3FHdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oQ6kddw9272X4EaqFsjJqO46o5w+MkB4mjzLJs4WdY=;
 b=bDLPhZzE1VyofWQvqJGFLG1P0QeS/SaKHvfamBtPm3M6egWj1LAVKpwpQX3KPD29b9+ng48k6C6mORTYirxjZRw4RS0DsjTx0y4tHBc+nk4TqL4onLEk9+W0AJTBZniYdf8y/eG3jdXnhKns1ABxCeK4xPkEc0aDZdhYGp2kGDwFajga5oIHTPKK/o2kpiwJHp7CUG9+WPcLKia1vUUvkxCRc9OlZc7jEt2WU5vUlVWt8CawQmMFPHj36tNGhmM79UZEPQlC8KhVG4o5M+/mLzcgaLDE1Kgbmf1LgAmyf5cJ5Y+iBKekfmsRKYTJzjWuR8zTjRoloal6hconGROW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oQ6kddw9272X4EaqFsjJqO46o5w+MkB4mjzLJs4WdY=;
 b=Kt7XPqNixtnvnGhg2MXi9d5dwfFJbwNyonmaiBsDxgpstntaGfQ27Ukk/oe06S5bV5ceRnX8ZZsmF52kklz3pvSdKDZuo0AfAnNIsfyMDnIPAvyjMHYnpEA4LXUWiUi3EOLAIPnOxLc++iBOz/ndwzeA83B4LXg5Y1ePB8KRx0P6OIGvco9t/GsoncRLEK1PKKpg4CTA+O+ReD/lgGfZLXgcoJJzap5LrN9CSHFR/sEDJudCfvSHYIEkaa1NO7tIh3Az6K1agq475545F7iuvSpTiZ8W7W/ekxTKYSxiFMKmkyF1StxMpRdX17tuikxEee3ow6RMKeko2v41lS/n+g==
Received: from BN9PR03CA0843.namprd03.prod.outlook.com (2603:10b6:408:13d::8)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 10:54:43 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::60) by BN9PR03CA0843.outlook.office365.com
 (2603:10b6:408:13d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Thu, 9 Mar 2023 10:54:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:34 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 02/14] iommufd: Add nesting related data structures for ARM SMMUv3
Date:   Thu, 9 Mar 2023 02:53:38 -0800
Message-ID: <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cae24fa-5983-45f2-41fe-08db208cb0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbuc96ajFZNCTLGRhJYRiDZtERvpg+2CpgHugDlVXgjtY7drdOzmNs5FpXNYS8JA0bma08RawTqB4/1+CtYZCdw13m6KsIKaH7/yzX0UsErKAya+j+1Pga0ncqaJml3QeDFFz7JeqSv9Lc2+kiQAK3tzFqhRTZlsjUrNqqVDHKzMGUmf3NRSo2StJtEwBgjvWCECoHLnG2fKJ8qQkLlCwlvwP9f86DcpCYrScFMiZMEUqR/NY88by5b9e2hYTAagN2yEmJHWAeqHttmTVG6Fbhhg3+a6Q71C97crK8VTjik1e9/1DhAuiyMT1e/D8bpALzpmj7SLAN+Sfq1VNYy0hCd3t+KuN+2Gk6XaSQfUzBA+uLll1IgPamTs9hyXPs55g9ux924KpMV4ojlomOM5siZB+XLVpLbYJK56+UFLON5bNOHoT+gbiD7lG+U9yue8U7+Taer1qW72MGNMBWAv/0HAjeyV0q4IgcDwMccH33nfqAXmLvUxqrgGZfERNtCeOsl2ZBpD9tKfUhdMuzJBWrUgjL4iYll2IAu0LXXLB4O4Tnm+DXnDFlkxAWRIpVBNM5nr+bDYH3GcBKiIO5M9QIPkShwFmUQK3pTIKJL0Ez2tPS/iWu5Rw4edHUkk3Gy6jp5yku/I89E+/2cu607gbi9RUp9xvrWm5pvcbHc8QIuQIb0jgAd6YUmZ0ZKyxkQNJzhK2f/OI6adQx9HTSUZQX5UmaFkN5Lm8D0VriHxpZsEt7Rdhhh/EErd3kQxBOUjLE37EpQmflp1MAnud82K9C9IjL4psO0iCqj7OXR0BTf8V9XJyVr9dPkItxeItS8R
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(36756003)(7416002)(5660300002)(26005)(36860700001)(82740400003)(7636003)(82310400005)(336012)(426003)(47076005)(83380400001)(186003)(2616005)(40480700001)(54906003)(86362001)(316002)(110136005)(41300700001)(8676002)(70206006)(70586007)(4326008)(40460700003)(356005)(7696005)(478600001)(2906002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:43.6481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cae24fa-5983-45f2-41fe-08db208cb0e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following data structures for corresponding ioctls:
               iommu_hwpt_arm_smmuv3 => IOMMUFD_CMD_HWPT_ALLOC
    iommu_hwpt_invalidate_arm_smmuv3 => IOMMUFD_CMD_HWPT_INVALIDATE

Also, add IOMMU_HW_INFO_TYPE_ARM_SMMUV3 and IOMMU_PGTBL_TYPE_ARM_SMMUV3_S1
to the header and corresponding type/size arrays.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c |  4 +++
 drivers/iommu/iommufd/main.c         |  1 +
 include/uapi/linux/iommufd.h         | 50 ++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 8f9985bddeeb..5e798b2f9a3a 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -173,6 +173,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 static const size_t iommufd_hwpt_alloc_data_size[] = {
 	[IOMMU_HWPT_TYPE_DEFAULT] = 0,
 	[IOMMU_HWPT_TYPE_VTD_S1] = sizeof(struct iommu_hwpt_intel_vtd),
+	[IOMMU_HWPT_TYPE_ARM_SMMUV3] = sizeof(struct iommu_hwpt_arm_smmuv3),
 };
 
 /*
@@ -183,6 +184,8 @@ const u64 iommufd_hwpt_type_bitmaps[] =  {
 	[IOMMU_HW_INFO_TYPE_DEFAULT] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT),
 	[IOMMU_HW_INFO_TYPE_INTEL_VTD] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT) |
 					 BIT_ULL(IOMMU_HWPT_TYPE_VTD_S1),
+	[IOMMU_HW_INFO_TYPE_ARM_SMMUV3] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT) |
+					  BIT_ULL(IOMMU_HWPT_TYPE_ARM_SMMUV3),
 };
 
 /* Return true if type is supported, otherwise false */
@@ -329,6 +332,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
  */
 static const size_t iommufd_hwpt_invalidate_info_size[] = {
 	[IOMMU_HWPT_TYPE_VTD_S1] = sizeof(struct iommu_hwpt_invalidate_intel_vtd),
+	[IOMMU_HWPT_TYPE_ARM_SMMUV3] = sizeof(struct iommu_hwpt_invalidate_arm_smmuv3),
 };
 
 int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 514db4c26927..0b0097af7c86 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -280,6 +280,7 @@ union ucmd_buffer {
 	 * path.
 	 */
 	struct iommu_hwpt_invalidate_intel_vtd vtd;
+	struct iommu_hwpt_invalidate_arm_smmuv3 smmuv3;
 };
 
 struct iommufd_ioctl_op {
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2a6c326391b2..0d5551b1b2be 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -352,10 +352,13 @@ struct iommu_vfio_ioas {
  * enum iommu_hwpt_type - IOMMU HWPT Type
  * @IOMMU_HWPT_TYPE_DEFAULT: default
  * @IOMMU_HWPT_TYPE_VTD_S1: Intel VT-d stage-1 page table
+ * @IOMMU_HWPT_TYPE_ARM_SMMUV3: ARM SMMUv3 stage-1 Context Descriptor
+ *                              table
  */
 enum iommu_hwpt_type {
 	IOMMU_HWPT_TYPE_DEFAULT,
 	IOMMU_HWPT_TYPE_VTD_S1,
+	IOMMU_HWPT_TYPE_ARM_SMMUV3,
 };
 
 /**
@@ -411,6 +414,28 @@ struct iommu_hwpt_intel_vtd {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_arm_smmuv3 - ARM SMMUv3 specific page table data
+ *
+ * @flags: page table entry attributes
+ * @s2vmid: Virtual machine identifier
+ * @s1ctxptr: Stage-1 context descriptor pointer
+ * @s1cdmax: Number of CDs pointed to by s1ContextPtr
+ * @s1fmt: Stage-1 Format
+ * @s1dss: Default substream
+ */
+struct iommu_hwpt_arm_smmuv3 {
+#define IOMMU_SMMUV3_FLAG_S2	(1 << 0) /* if unset, stage-1 */
+#define IOMMU_SMMUV3_FLAG_VMID	(1 << 1) /* vmid override */
+	__u64 flags;
+	__u32 s2vmid;
+	__u32 __reserved;
+	__u64 s1ctxptr;
+	__u64 s1cdmax;
+	__u64 s1fmt;
+	__u64 s1dss;
+};
+
 /**
  * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
  * @size: sizeof(struct iommu_hwpt_alloc)
@@ -446,6 +471,8 @@ struct iommu_hwpt_intel_vtd {
  * +------------------------------+-------------------------------------+-----------+
  * | IOMMU_HWPT_TYPE_VTD_S1       |      struct iommu_hwpt_intel_vtd    |    HWPT   |
  * +------------------------------+-------------------------------------+-----------+
+ * | IOMMU_HWPT_TYPE_ARM_SMMUV3   |      struct iommu_hwpt_arm_smmuv3   | IOAS/HWPT |
+ * +------------------------------+-------------------------------------------------+
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
@@ -463,10 +490,12 @@ struct iommu_hwpt_alloc {
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
+ * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_DEFAULT,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD,
+	IOMMU_HW_INFO_TYPE_ARM_SMMUV3,
 };
 
 /**
@@ -591,6 +620,25 @@ struct iommu_hwpt_invalidate_intel_vtd {
 	__u64 nb_granules;
 };
 
+/**
+ * struct iommu_hwpt_invalidate_arm_smmuv3 - ARM SMMUv3 cahce invalidation info
+ * @flags: boolean attributes of cache invalidation command
+ * @opcode: opcode of cache invalidation command
+ * @ssid: SubStream ID
+ * @granule_size: page/block size of the mapping in bytes
+ * @range: IOVA range to invalidate
+ */
+struct iommu_hwpt_invalidate_arm_smmuv3 {
+#define IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF	(1 << 0)
+	__u64 flags;
+	__u8 opcode;
+	__u8 padding[3];
+	__u32 asid;
+	__u32 ssid;
+	__u32 granule_size;
+	struct iommu_iova_range range;
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
@@ -609,6 +657,8 @@ struct iommu_hwpt_invalidate_intel_vtd {
  * +------------------------------+----------------------------------------+
  * | IOMMU_HWPT_TYPE_VTD_S1       | struct iommu_hwpt_invalidate_intel_vtd |
  * +------------------------------+----------------------------------------+
+ * | IOMMU_HWPT_TYPE_ARM_SMMUV3   | struct iommu_hwpt_invalidate_arm_smmuv3|
+ * +------------------------------+----------------------------------------+
  */
 struct iommu_hwpt_invalidate {
 	__u32 size;
-- 
2.39.2

