Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBF6175AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKCEjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKCEjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:39:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC72113E39;
        Wed,  2 Nov 2022 21:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw3Y0Rz/NzVtvvjpPSXfGoakyEUZ6Wxej9Wf2he/G1ZELJzUghmWRjtTvuPngedCvjCVE09mz/z6yn9fUt35wlb9ZxYPGxmfzKUR3eme3pnZS72YpXLfPoUiN7pOa+l8sOMIxjKujY4uxWR+B66VdWE6WIxNlPkYf9uaokFM7VhB7vUMzmDiRV/rh51Q7cBZfHgI4fSyEz/xb4J1Y67FlSFQAxDQqd7ggkCQQHU+G6/49l+pfpvNP79Qw0sgd1VmYT0NyZ31IPnz/3wRWoClHI3CTibiIMOP3Ok38Qu1tIWXwu+/0HByICbWwWhBEcnWw/8AB+j+vEHlnup+yPnSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOe3tdJRd878bJJt9S8xdg0gSuSIR/ugq8eLK5r+2OY=;
 b=VP32l3j7o8tdbxOgYASxJp6Y/gyddG+ZohLsA42KQoWWpKKQ9tQZggLizN+mwTo5CTrwea7COjAOWcGQmiSaujdRqAz3TOLaVGk8r1FWUiQz0arorXMOLd9P9Lvr7NvrK1WpNLUwpvQs4j9xDP9t8nKYtOdaAr2e61tPAAF5ew1rTmMJKTZNsLPCnRXn3Lf0uHE241Y25QD0uM0l7wdYty8k8QtNtBmZHWCSbxpz33c2Io69r3jZF8K0D4afQqVn3Kw+2PNvn3iwng8AtJHqvjq2zkcLVIUvB2TjMXivYtBvtbPT1sqwQfN9yIOL7L0iEVaiCDSxPAyoweWE3UvXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOe3tdJRd878bJJt9S8xdg0gSuSIR/ugq8eLK5r+2OY=;
 b=b9YGY8/EFvUVfZ3Jb+ap4YseYYwJsVBwmJG7jKxQ/vJlldcY4m2RJS9yoewbRJKxXnwOeGvu9wvv5ieNvSfhug9Fw9N2Dkz8lOrvsWBWJNo0ns0kdYMRDPiLvcEYMwN38hKgbihJi3nBZq1gvTWi24GzlgrngQx2SFLHybg61n12mP+PfMVyHsZY4LPULuZPQDPefxL/q648RpLced1YB2g5BAeg44RP/eV6rjHDKBjK8203ZLiEdfr9zx3X/Xdkz7U4jeg1PR4kbYac2M1OlplxItLhT3vUGSeUETNsAj+WLXlmwddw0Tj8p+UKVkCzKWQCkii+7oYYi/4a3cKPUQ==
Received: from MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::21)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 04:39:10 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::42) by MW4P221CA0016.outlook.office365.com
 (2603:10b6:303:8b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Thu, 3 Nov 2022 04:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 04:39:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 21:38:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 21:38:59 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 21:38:54 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <joro@8bytes.org>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
        <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
Date:   Thu, 3 Nov 2022 10:08:49 +0530
Message-ID: <20221103043852.24718-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: dafdc173-8727-4487-e8e3-08dabd5559c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeieWi24wSWr18zRt3Z1hcyyQR1KvP8fIGhX2YodgJU//WbKfdbk9qNnphLZiBtcB8nXuY9/fO/lXHxAZusEh3B8FP3SO75aBb99PFT+WoYKZZxkIfRp2qDH6a9YJyoiZp3s00D0Z/Fttdrn3rvo+i4yTKtTN+rP2shU2UIKv6NvE9AvG+XnPbEb+gmqdaaIUx90V6YHlmIkYdAfKLFIgBf3vVwtEJnW9vDg/tXNaW/EBXTokJpmYOqshgPg4UY5LhXkVL3nnTzouNil331V+ezPyd0DvIfXjIrKLKoeUomwfmQPhEerupi3M3Bo2UaGMCKgPoJcWgd16DOp4OWAyayVuJj2xtETqa0Y771RVXcIquIe4oVkUzC8pRKPDdnRgpVW4wwiCLAOSVqfbN9WwZ/BVluqFLyNRvrbdjAcIdQQlKiHc5IQGrI8FDSqLsDvjYjjazDXYZbGVvmgf5715D1Lc+QRCIodN9Mx73qjreYvrGzromgmv9fMKxgOrXFWWpiZNpsBzswRDHKU88zdp/p1t7J/0iqNfZTQMeNpZXk5MLAJsbiJS0pWTxghRQX4UWoISrGt/BQuI26bl+taoKO635/Hw6gg2FGH3aWpHohGzRegqQjBRoFeao6wWEwPc2Fnw1+CkLfladnBoeQoo98UmUir/6T87rETdgckaRog+E0OxEx/ZVlpTcETtL+hPAvjP03MjpQTfuaSotHqfcTY2+NifQpVIDPAeXhO8I0GH92d0UO8Pnnv+BxxH1oRLbR+gxzwv8BAUMFIyo7XVg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(86362001)(82310400005)(40480700001)(36860700001)(36756003)(107886003)(110136005)(40460700003)(82740400003)(7636003)(316002)(356005)(6666004)(54906003)(2616005)(478600001)(426003)(41300700001)(5660300002)(26005)(8936002)(336012)(7416002)(8676002)(4326008)(186003)(7696005)(1076003)(47076005)(70586007)(70206006)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 04:39:10.1617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dafdc173-8727-4487-e8e3-08dabd5559c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to fully make use of the !IOMMU_API stub functions, make the
struct iommu_fwspec always available so that users of the stubs can keep
using the structure's internals without causing compile failures.

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

