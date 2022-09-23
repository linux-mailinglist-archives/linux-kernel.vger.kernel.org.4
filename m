Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA445E74BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiIWHTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiIWHS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:18:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF0312A4B7;
        Fri, 23 Sep 2022 00:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJHxjxjKBKoRELTVeMFT8rz6fyMxeg0I9A+Tq6+hRGH0dT3OYzVwoGa/Rrkq+Um/Wk+aTH3pZy2QgDmhgANNIkDUFM3qov/zj3kpL3iLLh5Von/3piABQxo9NmVD9eD+NDVh+30M5jXaC9+WrYFEnfh0Xebxqi5QPlEsUaceG/c5Y4lLmrfhqRJr3aQBqe2f9bwfyi2u/TuuD+HiWZ8wSMPmDd2dO4NAWmpavib5YnGnw69GL19rEPZ+lhe9jDbNUwR6ZtmVD39Pim7e6F3Pl5IYgx4kdpK0w0zuWmll2cfQYrUuJynwdj0qEdRDrBzPzsMc7sXg8y0wBaCxzxDuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRiBvP68Uab8yBr834AJHBWnp7688abiJFpvB0PALhE=;
 b=eh+BtQ9mdg+CefVCZTg8a1Gw1e8vbNGHm7W1fLE6RCVx5G1cQ+k0pZ9ZbU+NUdUiR7+/5IClab9IJ/04t4RyDrXCRdv3zSQhB7eSlJPl6zN6W+ZWnlWGEBVmN9iBs36kGnQAC/EmtOuAaJzHRSiQ2mCSNxkEsFNu1vHGE3wBRLu7hk27ZkVQ+pH5Q0fjORcr4gmzaKcbI4hkI6zOPWLK8AyU/KfmnoZUquLsvu5MaJGaKUz72WU4xyMUI9TwXbIn1+WyoITyUVinnQRXigm1rMUkO9SMtPw+O7kfU1X3jwabLvdXdagU8dV9R3bdqwlyrVirF8LJKPuHEcSE11cADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRiBvP68Uab8yBr834AJHBWnp7688abiJFpvB0PALhE=;
 b=ddced6HLVUfSinVqiO40HgCkEB9kviLcq0PDzTga0wEkWpsiwIISwqBrvzLPDpokpAsNfasXa3Pt/wlVHCVA0a14rPfhDljCNPVADk0UgRmM/cU5dn1QxuWgnR91VbC+k5PbhpWjiNrqvf23X6CbG88K8d3cAmbm4DhbeAX0VADRT6KibTaz5avRdMkA+To8CwCC5lD+J3NPiZjkSlLsEVqmX/U1Kr8ViTvb4+McUHUVsF8U8c+z0SlwuBHiQu31JbyjYd4emPFXLne2A0G9wBkeQySF0YZKvrVAJen6CV480zj7C0g7QYJVDBBtObr/wU9VsSkRKLsT9txTvm9cIw==
Received: from DM6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:5:190::14)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 07:18:24 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::90) by DM6PR11CA0001.outlook.office365.com
 (2603:10b6:5:190::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 07:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 07:18:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 23 Sep
 2022 00:18:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 00:18:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 00:18:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 23 Sep 2022 00:18:12 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <suravee.suthikulpanit@amd.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>, <thierry.reding@gmail.com>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <jean-philippe@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
        <tglx@linutronix.de>, <christophe.jaillet@wanadoo.fr>,
        <thunder.leizhen@huawei.com>, <yangyingliang@huawei.com>,
        <quic_saipraka@quicinc.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v6 4/5] iommu: Use EINVAL for incompatible device/domain in ->attach_dev
Date:   Fri, 23 Sep 2022 00:18:10 -0700
Message-ID: <b83855da7ca69a0ecdb0bf5f2cef62608c82feca.1663899032.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663899032.git.nicolinc@nvidia.com>
References: <cover.1663899032.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: f07b0c43-4fed-4490-567b-08da9d33cd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFv8VhofpgAza50wADAwEemhUCLV3G7Ual01bikEGRRo4mexO6/bsHdl3QUSdr5eblt6zY+UD5zcn5g8VKvSuSK1Xa7RnZLPo54cQKFqdbzE3O0JavpAzjQkj5paOFZtfDlLxr/aNXADfls+zEmofwuThR7mh8tE5BeMLJp0X/sO0ePQ9+Gj4gyWCRP0+j1mpdjfuUPUDbMAkhE0mohVgvKDgtrqEdW4f8IBIu5no3MvK05JsWhQJsWrlKdQDICkEOM3SVQSnwvYjuVlzw+6epIM5iYhD8yxeP/cKBB+WKy5ZJzK0eDXFgLdB1Ycgyivwpk+dAVeO8IbcZ1oAMr8E7jYJ08mVEiRfo2bTaL44xw0HnXraxPA+8rFK3kpNBiqut9trUfUiwUIj7J7YbFQQSr7ORArp8dglWUodyblwTwPcHHXo+PVJCwVlg+CN87RWYwLQlTDyHV41N7465NklaLK0313LkNoANAxMpi6BoH7K8NnRn//zL4m4xtow059soixUWzYlNjSidKXhmMsa3HF5J83uQTB3IHKqDwXaWMEeWVmzeZ05Wg8IymPUWscD2hv29RGozGBXJa30+ZZZUKkMBBKAZfEpM59tzxp9VTNjrW72kyDX021FbFhVb3mKPE7I7rzyciE4yY616X7FmCfaHVN/Ui+4OfPOYRPivnndrFBOTGOWBwSJQPPL2GdxkGqhWl0yfm35tCGzxmP588wy+5buvGIUoQhbYxNeVWefsWVmTs/im4SFTXz99Z+K2mpgIS86vdAkkuwzkrGP9EFMiE2RA/XU+/reU/gZxg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(356005)(7636003)(110136005)(316002)(54906003)(82740400003)(70586007)(70206006)(186003)(2906002)(2616005)(478600001)(47076005)(4326008)(41300700001)(8676002)(26005)(40480700001)(82310400005)(7416002)(5660300002)(86362001)(36860700001)(336012)(426003)(36756003)(7696005)(83380400001)(40460700003)(8936002)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:18:24.1049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07b0c43-4fed-4490-567b-08da9d33cd78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the new rules in include/linux/iommu.h kdocs, update all drivers
->attach_dev callback functions to return EINVAL in the failure paths that
are related to domain incompatibility.

Also, drop adjacent error prints to prevent a kernel log spam.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 ---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +------
 drivers/iommu/intel/iommu.c                 | 10 +++-------
 drivers/iommu/ipmmu-vmsa.c                  |  2 --
 drivers/iommu/omap-iommu.c                  |  2 +-
 drivers/iommu/sprd-iommu.c                  |  4 +---
 drivers/iommu/tegra-gart.c                  |  2 +-
 drivers/iommu/virtio-iommu.c                |  3 +--
 9 files changed, 9 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d32b02336411..f96f8aad8280 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2429,23 +2429,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			goto out_unlock;
 		}
 	} else if (smmu_domain->smmu != smmu) {
-		dev_err(dev,
-			"cannot attach to SMMU %s (upstream of %s)\n",
-			dev_name(smmu_domain->smmu->dev),
-			dev_name(smmu->dev));
-		ret = -ENXIO;
+		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
 		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
-		dev_err(dev,
-			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
-			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
 		   smmu_domain->stall_enabled != master->stall_enabled) {
-		dev_err(dev, "cannot attach to stall-%s domain\n",
-			smmu_domain->stall_enabled ? "enabled" : "disabled");
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dfa82df00342..dbd12da31707 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1167,9 +1167,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * different SMMUs.
 	 */
 	if (smmu_domain->smmu != smmu) {
-		dev_err(dev,
-			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
-			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
 		ret = -EINVAL;
 		goto rpm_put;
 	}
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 17235116d3bb..37c5ddc212c1 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -381,13 +381,8 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 	 * Sanity check the domain. We don't support domains across
 	 * different IOMMUs.
 	 */
-	if (qcom_domain->iommu != qcom_iommu) {
-		dev_err(dev, "cannot attach to IOMMU %s while already "
-			"attached to domain on IOMMU %s\n",
-			dev_name(qcom_domain->iommu->dev),
-			dev_name(qcom_iommu->dev));
+	if (qcom_domain->iommu != qcom_iommu)
 		return -EINVAL;
-	}
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 31bc50e538a3..b1788b3d3b2d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4181,19 +4181,15 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
-		return -EOPNOTSUPP;
+		return -EINVAL;
 
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
 		addr_width = cap_mgaw(iommu->cap);
 
-	if (dmar_domain->max_addr > (1LL << addr_width)) {
-		dev_err(dev, "%s: iommu width (%d) is not "
-		        "sufficient for the mapped address (%llx)\n",
-		        __func__, addr_width, dmar_domain->max_addr);
-		return -EFAULT;
-	}
+	if (dmar_domain->max_addr > (1LL << addr_width))
+		return -EINVAL;
 	dmar_domain->gaw = addr_width;
 
 	/*
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1d42084d0276..f5217a4cb9b3 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -628,8 +628,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 		 * Something is wrong, we can't attach two devices using
 		 * different IOMMUs to the same domain.
 		 */
-		dev_err(dev, "Can't attach IPMMU %s to domain on IPMMU %s\n",
-			dev_name(mmu->dev), dev_name(domain->mmu->dev));
 		ret = -EINVAL;
 	} else
 		dev_info(dev, "Reusing IPMMU context %u\n", domain->context_id);
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 447e40d55918..be12f49140c7 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1472,7 +1472,7 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	/* only a single client device can be attached to a domain */
 	if (omap_domain->dev) {
 		dev_err(dev, "iommu domain is already attached\n");
-		ret = -EBUSY;
+		ret = -EINVAL;
 		goto out;
 	}
 
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 511959c8a14d..945576039c9e 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -237,10 +237,8 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	size_t pgt_size = sprd_iommu_pgt_size(domain);
 
-	if (dom->sdev) {
-		pr_err("There's already a device attached to this domain.\n");
+	if (dom->sdev)
 		return -EINVAL;
-	}
 
 	dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
 	if (!dom->pgt_va)
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index e5ca3cf1a949..ed53279d1106 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -112,7 +112,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	spin_lock(&gart->dom_lock);
 
 	if (gart->active_domain && gart->active_domain != domain) {
-		ret = -EBUSY;
+		ret = -EINVAL;
 	} else if (dev_iommu_priv_get(dev) != domain) {
 		dev_iommu_priv_set(dev, domain);
 		gart->active_domain = domain;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 4c652773fd6c..87128266b6e3 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -733,8 +733,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 */
 		ret = viommu_domain_finalise(vdev, domain);
 	} else if (vdomain->viommu != vdev->viommu) {
-		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
 
-- 
2.17.1

