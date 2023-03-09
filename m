Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771F46B21F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCIKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCIKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610446179
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta4P3bCpv4A1VFWTPxgdTj+7w9H/P5WK07RzuEKZ3nBlKKoNoeGj6Yh7bIUajsHmbdLlXm/QadzGiPLDhyVF5bV/zZHs6HPsqZGp/wXzAPh8Eb9s1lqdPHmo5oC/Yju6yfjFOXPfD8u3Ibv4bvRC0fqa5ch7icZfvxfRYiElFoiFR11HxD8bpNcHftdB0ZC3D8SqOOFfyhhY85NyQdmVLIXLR2ziZ8e5T5yBZ6zCu4gpP6YXNQl/RZHhXxKXFor9QE5wk0GJ1tW5wCeLWysozb6t/ww13q0TZOYYQvvhbsvjy8JRzcPSKUo4D23VvXtQF5Aj7etLsRWMKbphgTtgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veohshV62f6X/GkXmFLi4CeciGkHfiBxeuF+YJjXtLo=;
 b=m56a9lGvGDlmkR0YxapSrblinqkIQZ/eNtfGuLE+0z8Nae3cL/4Nwe8xemo64wFb/+bS90RswR0QDsXmbG9QmjpP2EMEfJ/gTw2C7EUaYwZ/Hz3IgQPX/kLfDmglq4BBeC6jazqJdmqc0T6hWBcWvAlFmDtxREKjeqCIo1VUM04Nx84loSyMu359g+avIEvdkk5FlW1o59R6mz5A9OK6fQj1N8aum3/uF3TxKx2CUREcQMAT5mYWXD6bGQGQbsdYEdkQXr8KJDExmz39JlACkcMQXHad7l0DSNKtuH9PS6ci3tl4RdCsVkn+dukhmwGQh07NmigYBYNk9i3zGko6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veohshV62f6X/GkXmFLi4CeciGkHfiBxeuF+YJjXtLo=;
 b=rbZ2XX6ccck5zvRrHOMju5is3tmUZy5IYvngQEfdwSq0ICKFVxHZEgCCo2TvusdBlG++fsV7JfZ841BfRusfLgljJuA1dVYlWAt4gE4sXHEjVKMDIOrSx8+vPwWRkhDUjGwk3D2qlQ1dwj4C3ZAXRwasOu7LUqbEolLcmtpraKv41LGc3Cr8Wj9HG0IUCq0WwOxLVpnbJrr82HKScxKuqmDN9FZ7nsAljZN8vcKVxJNVOcxn8nR2kRIWrxaUoKxsemhMYThgTLKnWji0A8/84FFYo/ZBi63BNTtBhyGNPJzor8AHAQkuPROYactzAHOw24gJjbWtVh9yBkbsJhKP6A==
Received: from MN2PR04CA0034.namprd04.prod.outlook.com (2603:10b6:208:d4::47)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 10:54:50 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::5c) by MN2PR04CA0034.outlook.office365.com
 (2603:10b6:208:d4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Thu, 9 Mar 2023 10:54:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:40 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:40 -0800
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
Subject: [PATCH v1 09/14] iommu/arm-smmu-v3: Implement arm_smmu_get_unmanaged_domain
Date:   Thu, 9 Mar 2023 02:53:45 -0800
Message-ID: <b8053ba35deb6dbfe2c4d4c61189d5e5012b51c8.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|DM8PR12MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f1d7c0-8736-4fbf-1a93-08db208cb4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/u6jxisrhtQWdzb5C8FpfgPCfK5IlQ5JYljqF2Stp1f+qwWkYejuu462BzXW6v/gjZYt2G3PictpGK4QkJGCKn04gUVLohRLnajLwf6dizWgojlodkApPXVVFaAfOTWj8G6r0HFK48G+SlH3l9EpBPRzE8odJX6AMXAI68gOtDWmp4PytbbxtPN/IachK/Qh7gdt6D5BwpT2E89RIaE7Ti7tvkDKuIfedua9berQlVinHmoHR5/RquQI0iRf39+5cgCuLsEcn0lNkXpVn3+5IPiKXyJnRDgiGFGexEhIFahV/ZEQFo5XPVVZDz2DCll7nl3HtnUBh9YwJkxB1aaZ2THTSZ9MuvsfEJ6d7ttvRg6CxrF34TAwQKRrdAfu8WfM27tg/6z2bP6v1s/Mk+UnTwyQVpG5S70GgWFzQOaD/kJKdVecWeScI6WK+eNjXI+32LTZsQLTuECAER9f/i121uzuvW3g+jUGKARl6BmPEkxg7LfvCM75hg9hDNRrBUFryui/YcICvBrm0f3BI7LbODKF04Z4/EqyN2yOEJy/lmpveuRJ3FcPpS3OswG78zsU4MTs3hkZlJOfkSAMFLH0l5Q2blNA9CxvGDAOPW+1S3LOEXPHm2JzXNABZlY3/hN3OqTYvXLEDr1ttDG/OzA2htFjbEb9Vl60gpWDGzrzTno9nkKbOg9RHXtVWSNBW/R45azLsbu14ZdcUi2hzCD68Kvr24F13Zasi1QOBmcFtHyg+kUiewdUYrEdpLWuWNm
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(46966006)(40470700004)(36840700001)(2906002)(7416002)(5660300002)(26005)(8676002)(8936002)(36756003)(41300700001)(70206006)(4326008)(70586007)(40460700003)(110136005)(40480700001)(316002)(86362001)(54906003)(356005)(7696005)(478600001)(7636003)(6666004)(82740400003)(36860700001)(186003)(2616005)(82310400005)(47076005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:50.0132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f1d7c0-8736-4fbf-1a93-08db208cb4b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a 1-stage translation setup, a device is attached to an iommu_domain
(ARM_SMMU_DOMAIN_S1) that is IOMMU_DOMAIN_UNMANAGED type.

In a 2-stage translation setup, a device is attached to an iommu_domain
(ARM_SMMU_DOMAIN_S1) that is IOMMU_DOMAIN_NESTED type, which must have
a valid "s2" pointer for an iommu_domain (ARM_SMMU_DOMAIN_S2) that is
IOMMU_DOMAIN_UNMANAGED type.

Add a function to return the correct iommu_domain pointer accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fee5977feef3..18ab5d516cf2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2082,6 +2082,17 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	return &smmu_domain->domain;
 }
 
+static struct iommu_domain *arm_smmu_get_unmanaged_domain(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_domain *smmu_domain = master->domain;
+
+	if (smmu_domain->s2)
+		return &smmu_domain->s2->domain;
+
+	return &smmu_domain->domain;
+}
+
 static int arm_smmu_bitmap_alloc(unsigned long *map, int span)
 {
 	int idx, size = 1 << span;
@@ -2878,6 +2889,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc		= arm_smmu_domain_alloc,
+	.get_unmanaged_domain	= arm_smmu_get_unmanaged_domain,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.39.2

