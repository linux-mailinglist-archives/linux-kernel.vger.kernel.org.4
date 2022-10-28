Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C598611229
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJ1NDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiJ1NDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:03:00 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7471C2F2D;
        Fri, 28 Oct 2022 06:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejNoGiaggHJC3wrxWJid7PeynIYvcRwe1jFVJujOjmlLjgDjUA8mcK2/7m4L/1XVpiYjG7DRrn1qww8PPORtkayN5zxeE/vQKnE9IwPdOMdDSM7TcJxfRwTV7UMuBCnzFcLWXdwznY/qRfGFbhg7wIcpFP9RJf3BUQ1sFQM6Z+dM6JFGbrplZIHHhDz07SuF6PSNEvhT9maVyZX0qohMCnwcdupm9ArAy+YxlVelbBRgUtB6lyR2YjfhF03vzscIDsi7IsEbvWC7hLgipoOYMX806SrORGF64uZ90g7grThCtYMH/5XLUmlXOAQr6AAPX5izKqcsGdCRAxIsASBPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX9a5NQCui3EmelUBuL6tUUBvUkS2Lt4E9Z9Ko17AUg=;
 b=JY1KAkQ1M3g+JM47cOBGGRBk/bdeaujYe+ggLbuBxy6yP32Xiq8OUuR1S41GcqhMhk+gB7ZAcP2PYkVTIuoYH3NYdkJktrDxGGwxiIBYoYgeenQwtXGCFmvT+8O2bCRaPVohoCBkdtzLkEJskVB0i87mCKiJEoGSP4IqZGi/c3HRdarPO2YINWrC1apH/WAerqRoWBp2/pVcKTzoE34+fUt43qXFJXAg+pwoDTgdlq7g5pUIMP/z2GT5UAPKnQjca3B+g/d5g++/7jyJcLJgKwL48Xlo4BA+7OXyIHw1XCQYYOvMCG8kbbZvAft8AVk/R04PVkQfuloxUziv4ogweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX9a5NQCui3EmelUBuL6tUUBvUkS2Lt4E9Z9Ko17AUg=;
 b=M/TMGju8bwOVv1yETMQBp+gj7DFTujGCG8kmv+2qpYDqwLpKOLPcRHnpdrQL3RZ3G0r59xv9AzMj1Efg0LtyJt12e2XIOwWEu3//gZ1Es0RomqDgbcRuvjanmRBbbC1TMnXqxi8NUayBLJSZiHPk1KtTZbH8eWiguTwuhBJPaJV+j8No36610vBRlFMAN7ilt2uyXZu7xr6/RcV1MVMVS6AjlmTtXVXtflY9zoz4VwECt23hzudV0KKMFSUAs6qa8xsMYhxlZnV8gUMl+KIasuMwzSOI3zZaJYdDXTtzPozHCN0H04CCYG5WZE+Yu4PLztCXgY00bvvxBaneoBuy8g==
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 13:02:57 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::9f) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 13:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 13:02:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 06:02:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 06:02:49 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 06:02:44 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <joro@8bytes.org>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
        <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v9 1/4] iommu: Add dummy dev_iommu_fwspec_get() helper
Date:   Fri, 28 Oct 2022 18:32:39 +0530
Message-ID: <20221028130242.20900-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPDyKFpG9ZjVTiK3HEqioDN8ksGpRYiXL_SLSmOfm9fjJfcrsw@mail.gmail.com>
References: <CAPDyKFpG9ZjVTiK3HEqioDN8ksGpRYiXL_SLSmOfm9fjJfcrsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c22eb2c-d718-4d6e-479d-08dab8e4bbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQ9sa2FpsWMkfk9q+oxO6AIeVEmpv69PK+prSUKKx7CBtCDL8NDz7AmaVMoShicmrJEJyYS4ZXKWVjxSKnP/qI8CgTy54aIJ5X1f/YVtEr75vMKvhtfHavAe1IRe38VMITVA+qauCK2ZHHXXPvSgENuRhcbqk9DQB4j6ABXMF1URDswnUGycYabdHsqzyDoM9Wtfzx2dgssOuiiWDgFmoD2vae2mYHnZl7nP5+0/lJL662S1K09hpR/FAVRvDd8PEeWknfNXbZ4ZAUTKuH9gBNXbhkZtlkxfKnqb4e3svC50WdlHzs7+6o2N/4ZEHSE9JEeZQ3oLc/MsRXM1VkgeOpjA1vOSA2iN+6ZY8vf/H51kKin9uDtV4OWLtq0iGkiKU72mwY7RlmWtbHVNUiKXKWiDwE2Ghgads9c+0W5/X8IY9Ba3k+bzMU/20oxTCTZyxl6NgY0VJ2zJP9+2EdsnBDWrdWksH908NXr54EdHlvoA0vExd1hiLBBQ6wxGyWdoQhkGgUimY0RZt/kTgJ3yf6RHED9DJXJoW70Xd0sWUkUBj3DLpdFtlE3IF2tpLYhh1PhBuvxGkJphC+tr0d6IVHm9T0i7NCQZ8S62zKJD9wswI9CyjnYhyOOy51kdqNBj3NoR0tQWgKaIOdtjKYaJcblWCuVAOFfCE+/dgX0GSByMuXipL48U8drMKd371jhA2NMbDK33h4Yu0pb3D7iHmDDPk3rOFCuhkYSsJGBAmh93VGPJKgHiwI92zB3+5cd4faCLISjEtAURZ3EyZc+dxg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(1076003)(54906003)(83380400001)(426003)(110136005)(8936002)(316002)(7696005)(478600001)(7636003)(356005)(86362001)(47076005)(36756003)(26005)(40480700001)(107886003)(82740400003)(70206006)(41300700001)(6666004)(40460700003)(5660300002)(4326008)(336012)(2906002)(70586007)(36860700001)(186003)(8676002)(7416002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 13:02:56.7207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c22eb2c-d718-4d6e-479d-08dab8e4bbbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dummy implementation is useful to avoid a dependency on the
IOMMU_API Kconfig symbol in drivers that can optionally use the IOMMU
API.

In order to fully use this, also move the struct iommu_fwspec definition
out of the IOMMU_API protected region.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/iommu.h | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..afa829bc4356 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -173,6 +173,25 @@ enum iommu_dev_features {
 
 #define IOMMU_PASID_INVALID	(-1U)
 
+/**
+ * struct iommu_fwspec - per-device IOMMU instance data
+ * @ops: ops for this device's IOMMU
+ * @iommu_fwnode: firmware handle for this device's IOMMU
+ * @flags: IOMMU_FWSPEC_* flags
+ * @num_ids: number of associated device IDs
+ * @ids: IDs which this device may present to the IOMMU
+ */
+struct iommu_fwspec {
+	const struct iommu_ops	*ops;
+	struct fwnode_handle	*iommu_fwnode;
+	u32			flags;
+	unsigned int		num_ids;
+	u32			ids[];
+};
+
+/* ATS is supported */
+#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -600,25 +619,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
 /* FSL-MC device grouping function */
 struct iommu_group *fsl_mc_device_group(struct device *dev);
 
-/**
- * struct iommu_fwspec - per-device IOMMU instance data
- * @ops: ops for this device's IOMMU
- * @iommu_fwnode: firmware handle for this device's IOMMU
- * @flags: IOMMU_FWSPEC_* flags
- * @num_ids: number of associated device IDs
- * @ids: IDs which this device may present to the IOMMU
- */
-struct iommu_fwspec {
-	const struct iommu_ops	*ops;
-	struct fwnode_handle	*iommu_fwnode;
-	u32			flags;
-	unsigned int		num_ids;
-	u32			ids[];
-};
-
-/* ATS is supported */
-#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
-
 /**
  * struct iommu_sva - handle to a device-mm bond
  */
@@ -682,7 +682,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
 struct iommu_ops {};
 struct iommu_group {};
-struct iommu_fwspec {};
 struct iommu_device {};
 struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
-- 
2.17.1

