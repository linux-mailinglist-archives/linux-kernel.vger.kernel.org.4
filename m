Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37556B21FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCIKz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjCIKzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:55:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5359647410
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IISH63EXsGuTAJ3CMFaD8mgS2G5Tkm83lnvSwONTpqeHRmGwL4+qjdFDPGoxuOWRWZ5sE8ieGLxwP68DqPdLVfGydkzq6opfWco0Llm4qYenWUp+wTBNY5RDb9t7ByL7o0V6w/wwIiRQnopaz+Xp6VAXUNd3wnyvlb6AeM4913t0Z5YYy5CNVUuvG3er6ojYQLVknHtO5gV0Fs9FulNuQmSrcWpLcluYsqr6qvNy6VicIIig1U5WrPYMrnUtjmiN/FE4wdqHs060LB4+5R6VCTDoYxCsBK3I1NJGUw204zU9GLPnP2ao88G27pMcJ71CJPkve5DqW6eFt1honoFhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROCSFJ+OhHO2HWfCKnJ+03se15MOoPB3m1JFGtF+Y8E=;
 b=YW+Oc7Y3fYbXO1wK/DTQCBjWGKRyyFCelsT9IVyrgqTXlB6fSl8TzBkaQX2H8aParO31GnDznVNpLefMfuWPZbGWZ0YksAY9M2Km4gwB26u9jnQs5bGinW/7SrC+aMqVjKKrjJIwTWLYKZKXBbhcJT8YN/lLJyN9Z8qxurJx5eyT7aZl/kOk8ngYvJ2FH8GcmhCf9WtXGJkjZ5Em7T4CUTFArL0lSvOwsayY0LU3A+HmxGC4nRE0WdpXOZgLdnmicfo6d32ZY5rVEBeS2KveiY3yOpyN+sa1SEMqTUBJnFieQGowNX9dpa2Vvg9AILXNLkjbdxudidTnCdqbv8gB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROCSFJ+OhHO2HWfCKnJ+03se15MOoPB3m1JFGtF+Y8E=;
 b=VEF2qZAXS/nJn8m6Xj/BU1m7S+2dowNh1JET4dno8qlJj5Am99BQqr/gRFX2G8DM4hydGivYOfb57iq5FCMKkyV4ZQL7v1lOYCmipsJYqrcmMbQDlcNQ1LOFdayAcrr0HTB5bTN/NZI5Lp54ESRv85wgQ3qbRJTngS07P3hvPNm3OsbIcs4xppnmrtMGtq6ToiNKypBE8ck+PTjU6LeWuuy57TkDYI14Vxn0ykIQxqGWo54rz6dW+UHZP4ZBPRevduO5CvpfZHC+B5c7oeiBw2aVWIqmMnXF9mG7wLuTKzcC4yD219hO8hON6ptw3F6LeBlYj7HOR0fJU/wOdtE2ag==
Received: from BN9PR03CA0803.namprd03.prod.outlook.com (2603:10b6:408:13f::28)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 10:54:53 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::31) by BN9PR03CA0803.outlook.office365.com
 (2603:10b6:408:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Thu, 9 Mar 2023 10:54:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:43 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:43 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:42 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED type of allocations
Date:   Thu, 9 Mar 2023 02:53:48 -0800
Message-ID: <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e658049-009d-4d57-8189-08db208cb6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRmoxe7y4ayn4t5sFJsES5enyYtF/unh+JBQUcKF9u665zOAsPji5tk26wFnUZyE/AcKZMa8iaG0ieewsreuyxn/9a+M7LoCfXuijpL9EWXlapF5bKxFFBS9VXzyt0OgtpgyRtEHo3UFibBF24xrEJ0vcbH5GKBymmQxJ/KuWYWx1+HPVlL7pqFehRtbCKpjc3A67N+poMYa+GbSm0SfstdjAStL22mOgdIuTYOOm+zN9k2Z+812V6m/F2IdoOWgx9p5lR/EcKld9XMXStyyRHiPMttCARQIWcvmryRYYbRWv7a1HDhr2cCPzqxvGMuMDjHRvNRL1azV49YnarW0ztwpRTNPFcwxBAkEHMMxjhWVqdLtcNg9wQvTT7AljZMXo85LZmgcxh2XPruQOb1/FgLTEZ7yLAiyplDpyi0IJdrnQy2T7rfZUa1YzGn3z8UlTThkHblInuxSuMZXt2TH3qd52vz219qhVopZAol3Ttz6OhL/2VcxgR0WIK6GE4O65bL1kp//Lae+0WJRjkZXQ4ZTEQrj006oyxqbgXgse+JHgTMSOlq+uUO/1baGEDJJRkxwbwGGd0PB41tabxQ1/Ca6fgGgPer70EilwzmyxWGIUxxWbgSKRmeWNuH6ZurfAJiIN9U2U2Dw8NpANMnE+aSB9+Y0tfK6cHCk/vHpsUTYoPOFL+7tSyKzCRyuVwC6rMEyRzRcC+PuOLshKOPGlmd5LKqauiY0YKqAxHVHQtiaPsSUt9LbTaOtYiV+6kk50PFFbRv/DpoR6EDJGLTjSw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(478600001)(7636003)(47076005)(82740400003)(83380400001)(36756003)(426003)(110136005)(186003)(2906002)(316002)(356005)(2616005)(7696005)(26005)(54906003)(5660300002)(70206006)(70586007)(4326008)(8676002)(7416002)(82310400005)(36860700001)(40480700001)(8936002)(40460700003)(86362001)(41300700001)(336012)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:53.6243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e658049-009d-4d57-8189-08db208cb6d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add domain allocation support for IOMMU_DOMAIN_NESTED type. This includes
the "finalise" part to log in the user space Stream Table Entry info.

Co-developed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5ff74edfbd68..1f318b5e0921 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2214,6 +2214,19 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		return 0;
 	}
 
+	if (domain->type == IOMMU_DOMAIN_NESTED) {
+		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1) ||
+		    !(smmu->features & ARM_SMMU_FEAT_TRANS_S2)) {
+			dev_dbg(smmu->dev, "does not implement two stages\n");
+			return -EINVAL;
+		}
+		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
+		smmu_domain->s1_cfg.s1fmt = user_cfg->s1fmt;
+		smmu_domain->s1_cfg.s1cdmax = user_cfg->s1cdmax;
+		smmu_domain->s1_cfg.cdcfg.cdtab_dma = user_cfg->s1ctxptr;
+		return 0;
+	}
+
 	if (user_cfg_s2 && !(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
 		return -EINVAL;
 	if (user_cfg_s2)
@@ -2863,6 +2876,11 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 }
 
+static const struct iommu_domain_ops arm_smmu_nested_domain_ops = {
+	.attach_dev		= arm_smmu_attach_dev,
+	.free			= arm_smmu_domain_free,
+};
+
 static struct iommu_domain *
 __arm_smmu_domain_alloc(unsigned type,
 			struct arm_smmu_domain *s2,
@@ -2877,11 +2895,15 @@ __arm_smmu_domain_alloc(unsigned type,
 		return arm_smmu_sva_domain_alloc();
 
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_NESTED &&
 	    type != IOMMU_DOMAIN_DMA &&
 	    type != IOMMU_DOMAIN_DMA_FQ &&
 	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
+	if (s2 && s2->stage != ARM_SMMU_DOMAIN_S2)
+		return NULL;
+
 	/*
 	 * Allocate the domain and initialise some of its data structures.
 	 * We can't really finalise the domain unless a master is given.
@@ -2889,10 +2911,14 @@ __arm_smmu_domain_alloc(unsigned type,
 	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
 	if (!smmu_domain)
 		return NULL;
+	smmu_domain->s2 = s2;
 	domain = &smmu_domain->domain;
 
 	domain->type = type;
-	domain->ops = arm_smmu_ops.default_domain_ops;
+	if (s2)
+		domain->ops = &arm_smmu_nested_domain_ops;
+	else
+		domain->ops = arm_smmu_ops.default_domain_ops;
 
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->devices);
@@ -2923,8 +2949,16 @@ arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
 	const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	unsigned type = IOMMU_DOMAIN_UNMANAGED;
+	struct arm_smmu_domain *s2 = NULL;
+
+	if (parent) {
+		if (parent->ops != arm_smmu_ops.default_domain_ops)
+			return NULL;
+		type = IOMMU_DOMAIN_NESTED;
+		s2 = to_smmu_domain(parent);
+	}
 
-	return __arm_smmu_domain_alloc(type, NULL, master, user_cfg);
+	return __arm_smmu_domain_alloc(type, s2, master, user_cfg);
 }
 
 static struct iommu_ops arm_smmu_ops = {
-- 
2.39.2

