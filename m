Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F15B6982
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiIMIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiIMIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:25:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8961AD84;
        Tue, 13 Sep 2022 01:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn3kloO+/OeFw25NHx/yjyTwlTw38kMTqkGk/UPDyJ3U8fxF/cphGt6GAymxqHDQc3bvCt+Xsf45CvRY9VNkYw/JyaC3xKNr+kWVE6G3QhVtH85me6k+IbIargEyf9iYom8QrrMf2vV9Fr6ho/dcdUAisvxIO1TgpjactVr1+Y8XefuUb8GJU7arclyx4LCXRttLvvqWD9Exg29o9koZKpfhVgzycDW8R/tX1C6n0PwaKCKVwfunn2Hf1SD7FR6tiXalaOAvxKyUDnFTkWus4WaeWwm+Ycgq3sAgotK+zREGQfYyCdJfu58/shYazL6IArYGxilbXV81ZX/P4cZ6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6vEq2T9zOoWy75OwmmBdA5B+UgWY7E+TveTierSzWY=;
 b=MFm1Zolk9iFNCRbnmFngCdaauXzhflPhx5BrlMVGNQJ1vBmzEorJ8b2rkOLCK+q1ZuLMQin/eYNPhTpdFfd2lwv1/1gxWhMKOSXOAxwU7sgqlUpudxDv0xXBhwrVJPGp0Ej9a/yHWFsCf/TiBuAGRCi5+C1Nv2JoB5L4PDg+eWTEw8Dtw2MdzgdaxnMr8mFznBwAd/Rda9Wteq3IM+rg2cuABoS8oqpa4JIKnXayNIuI+P+BKG88Xw67sFj1HAb0wEL8ooRfawhO4p1j1Y9wcKRxyTIFGYjdMpi3/JROwXSzRD8cjNQJCfwTopSGinU00tM4CsOTcmNXwlBiECMRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6vEq2T9zOoWy75OwmmBdA5B+UgWY7E+TveTierSzWY=;
 b=Hb/WZewrmi/1rOhNyz/5hdAJpPGINEPsl/FB7wLKT7VcCULPUlXW5MRHI8UhClDRxt39vjnaUapJWqDIJVJYkKPKdm5/LKJw/UC6//Q/vnyov1IIeI5w79nPvYRUHLIyIFUOJb0gEkvyxT9UY5XXC3Vw+2TF/pGUsm0sTqM3ac4WId+FWEq59/L9jWqItPY4IsSvVJh2i6nZYB5hkP/4S9eXUgYcpSMjcYHglYcXcNWDP/MNDFSTkJG7AduGsnAC9PEZvj3840DjvbUzB8SAWaTkj/fw42ojMEACBvhO/EQwpZPltbkQa3RMC5DTiRQ+e+2wXQw9jZl4ivsSH1qvJA==
Received: from BN8PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:60::32)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 08:25:03 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::d7) by BN8PR12CA0019.outlook.office365.com
 (2603:10b6:408:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Tue, 13 Sep 2022 08:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 08:25:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 08:25:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 01:25:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 01:25:00 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <sricharan@codeaurora.org>
CC:     <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback functions
Date:   Tue, 13 Sep 2022 01:24:47 -0700
Message-ID: <20220913082448.31120-5-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913082448.31120-1-nicolinc@nvidia.com>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f47266-f13c-409d-e7b2-08da956174b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTMyQHbXTZYphVPHRK4ym81oC8rXwm3Pi3lVaiqgGwZA2hdjwD3k4Th4ti/kZ+Pb9JS5VhBnuBfbej/Yl6gWqVvAgiFKCO3dpr/1qNTgMzbV2DWO5WeEeSXbKudnDOdft0Y4mjPT9VACtDROmny0sgusIUTItfkbaSqrx52FRmFuvkyD6biQFaeoIl0mCXNbfHCqTDBddNKnGjGIXoc8jzreiryycQhAMHEX6fqv5j1o7ryII8QDxxo7XFdliVwhDh8mnqW5SfF5z9I5/481hySZ3svDyZMUq3WpBfpM23TUmmPe/wNmQlHh+f5MNn51PVFDGSyJD680ADHoQOjDc2vhYlK5N0ubTWoTdlosSoy/qTSMN3BF2GScC+/ynsPjLw7s4wZBqtQIQvzUVv2tdJXKkzTVWEZHtFVkVIN2cmj51NqmdaHafFBSeFSgNngyQmsiUgM5fQueiX9sYvHm23sqKO3qCTe+aTsU35od0Vm6CKDIJFARiqx8mWjok4L+Mq0vkkdFGZhCizm0b8OXwD9zhybzL8Gi/EKrIC2r3hAO6I+QcpTkoxYZEwLVXcFmwuDcEESa406Y8bLYUvvqr1IYwZZM5XwtApiyKOr2XZSukKaHTPcRr8pARE9jJ6Qq0oyyH76d1FCuidBWIVXvibvA0RDxbsr7DEjwzCciyShFQmEoyVv/x2BQ+66fwJy++rntOJXvUtzGgtC8/6uMXrgHeZG4mfJIuTJp+hou5A693F9JMM4GlpGo54Rc6rHlBzy9aziSGsNXssc16sCOJ1rE6ET2A9mKxw5L5mmkAncaSWYeaOwwmU4szAAplO54rJ//UqwftLueLWvZJmUEYwdtsM4DykISGlKplX0gnOU=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(2616005)(336012)(426003)(186003)(82740400003)(7406005)(4326008)(110136005)(70586007)(8676002)(478600001)(7416002)(8936002)(40480700001)(70206006)(81166007)(54906003)(1076003)(36860700001)(6666004)(40460700003)(82310400005)(356005)(47076005)(316002)(26005)(83380400001)(7696005)(5660300002)(36756003)(2906002)(921005)(86362001)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 08:25:02.7334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f47266-f13c-409d-e7b2-08da956174b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the new rules in include/linux/iommu.h kdocs, update all drivers
->attach_dev callback functions to return ENODEV error code for all device
specific errors. It particularly excludes EINVAL from being used for such
error cases. For the same purpose, also replace one EINVAL with ENOMEM in
mtk_iommu driver.

Note that the virtio-iommu does a viommu_domain_map_identity() call, which
returns either 0 or ENOMEM at this moment. Change to "return ret" directly
to allow it to pass an EINVAL in the future.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 4 ++--
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 2 +-
 drivers/iommu/fsl_pamu.c                    | 6 +++---
 drivers/iommu/fsl_pamu_domain.c             | 4 ++--
 drivers/iommu/intel/pasid.c                 | 2 +-
 drivers/iommu/ipmmu-vmsa.c                  | 2 +-
 drivers/iommu/mtk_iommu.c                   | 9 ++++++---
 drivers/iommu/omap-iommu.c                  | 4 ++--
 drivers/iommu/rockchip-iommu.c              | 4 +++-
 drivers/iommu/tegra-smmu.c                  | 2 +-
 drivers/iommu/virtio-iommu.c                | 2 +-
 12 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d32b02336411..0186dfdf31fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2402,7 +2402,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_master *master;
 
 	if (!fwspec)
-		return -ENOENT;
+		return -ENODEV;
 
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dfa82df00342..771dd161545c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1137,7 +1137,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops) {
 		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
-		return -ENXIO;
+		return -ENODEV;
 	}
 
 	/*
@@ -1155,7 +1155,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
-		return ret;
+		return -ENODEV;
 
 	/* Ensure that the domain is finalised */
 	ret = arm_smmu_init_domain_context(domain, smmu, dev);
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 17235116d3bb..49d40c80afd3 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -367,7 +367,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 
 	if (!qcom_iommu) {
 		dev_err(dev, "cannot attach to IOMMU, is it on the same bus?\n");
-		return -ENXIO;
+		return -ENODEV;
 	}
 
 	/* Ensure that the domain is finalized */
diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 0d03f837a5d4..021ab3f9e6d2 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -126,7 +126,7 @@ int pamu_disable_liodn(int liodn)
 	ppaace = pamu_get_ppaace(liodn);
 	if (!ppaace) {
 		pr_debug("Invalid primary paace entry\n");
-		return -ENOENT;
+		return -ENODEV;
 	}
 
 	set_bf(ppaace->addr_bitfields, PAACE_AF_V, PAACE_V_INVALID);
@@ -194,7 +194,7 @@ int pamu_config_ppaace(int liodn, u32 omi, u32 stashid, int prot)
 
 	ppaace = pamu_get_ppaace(liodn);
 	if (!ppaace)
-		return -ENOENT;
+		return -ENODEV;
 
 	/* window size is 2^(WSE+1) bytes */
 	set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE,
@@ -211,7 +211,7 @@ int pamu_config_ppaace(int liodn, u32 omi, u32 stashid, int prot)
 		ppaace->op_encode.index_ot.omi = omi;
 	} else if (~omi != 0) {
 		pr_debug("bad operation mapping index: %d\n", omi);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	/* configure stash id */
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 011f9ab7f743..b4a1c0f79c3e 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -258,7 +258,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 	liodn = of_get_property(dev->of_node, "fsl,liodn", &len);
 	if (!liodn) {
 		pr_debug("missing fsl,liodn property at %pOF\n", dev->of_node);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	spin_lock_irqsave(&dma_domain->domain_lock, flags);
@@ -267,7 +267,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 		if (liodn[i] >= PAACE_NUMBER_ENTRIES) {
 			pr_debug("Invalid liodn %d, attach device failed for %pOF\n",
 				 liodn[i], dev->of_node);
-			ret = -EINVAL;
+			ret = -ENODEV;
 			break;
 		}
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5e7e8b020a5..712c7f3960e5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -102,7 +102,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	might_sleep();
 	info = dev_iommu_priv_get(dev);
 	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
-		return -EINVAL;
+		return -ENODEV;
 
 	pasid_table = kzalloc(sizeof(*pasid_table), GFP_KERNEL);
 	if (!pasid_table)
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1d42084d0276..cb14abcfa43a 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -607,7 +607,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 
 	if (!mmu) {
 		dev_err(dev, "Cannot attach to IPMMU\n");
-		return -ENXIO;
+		return -ENODEV;
 	}
 
 	mutex_lock(&domain->mutex);
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7e363b1f24df..dcfe728a4526 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -562,10 +562,12 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 			peri_mmuen = enable ? peri_mmuen_msk : 0;
 			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
 						 peri_mmuen_msk, peri_mmuen);
-			if (ret)
+			if (ret) {
 				dev_err(dev, "%s iommu(%s) inframaster 0x%x fail(%d).\n",
 					enable ? "enable" : "disable",
 					dev_name(data->dev), peri_mmuen_msk, ret);
+				ret = -ENODEV;
+			}
 		}
 	}
 	return ret;
@@ -607,7 +609,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
 		dev_err(data->dev, "Failed to alloc io pgtable\n");
-		return -EINVAL;
+		return -ENOMEM;
 	}
 
 	/* Update our support page sizes bitmap */
@@ -655,7 +657,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 
 	region_id = mtk_iommu_get_iova_region_id(dev, data->plat_data);
 	if (region_id < 0)
-		return region_id;
+		return -ENODEV;
 
 	bankid = mtk_iommu_get_bank_id(dev, data->plat_data);
 	mutex_lock(&dom->mutex);
@@ -678,6 +680,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		ret = pm_runtime_resume_and_get(m4udev);
 		if (ret < 0) {
 			dev_err(m4udev, "pm get fail(%d) in attach.\n", ret);
+			ret = -ENODEV;
 			goto err_unlock;
 		}
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d9cf2820c02e..447e40d55918 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1414,7 +1414,7 @@ static int omap_iommu_attach_init(struct device *dev,
 
 	odomain->num_iommus = omap_iommu_count(dev);
 	if (!odomain->num_iommus)
-		return -EINVAL;
+		return -ENODEV;
 
 	odomain->iommus = kcalloc(odomain->num_iommus, sizeof(*iommu),
 				  GFP_ATOMIC);
@@ -1464,7 +1464,7 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!arch_data || !arch_data->iommu_dev) {
 		dev_err(dev, "device doesn't have an associated iommu\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	spin_lock(&omap_domain->lock);
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ab57c4b8fade..de483b5532ed 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1051,8 +1051,10 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 		return 0;
 
 	ret = rk_iommu_enable(iommu);
-	if (ret)
+	if (ret) {
 		rk_iommu_detach_device(iommu->domain, dev);
+		ret = -ENODEV;
+	}
 
 	pm_runtime_put(iommu->dev);
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2a8de975fe63..093c10db4cb4 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -487,7 +487,7 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 	int err;
 
 	if (!fwspec)
-		return -ENOENT;
+		return -ENODEV;
 
 	for (index = 0; index < fwspec->num_ids; index++) {
 		err = tegra_smmu_as_prepare(smmu, as);
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 80151176ba12..874c01634d2b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -696,7 +696,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
 			vdomain->viommu = NULL;
-			return -EOPNOTSUPP;
+			return ret;
 		}
 	}
 
-- 
2.17.1

