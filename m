Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147F45B6985
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiIMIZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiIMIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:25:12 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8F1EAD8;
        Tue, 13 Sep 2022 01:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBwYjf3mwTvkNYxLpoXRg/xN6fhe7Unu3/Jz9uyVofT9hGiwsBO083sAtM+qawvAayWcW/SvdS4HeBDq+s2OZDac9FwvHSG9nN1WJg8JF/B26LY9wLJlLLO9nTj8H0iKGUAapYDd6MSP57mjNR9tQrLTUB3k7k3+1Tbl2oFgRfIQmyz438REa0B2C2sNIHiTXZVmRD5hW3cN+pdIx3jmD9V2oIV5WO+kZ3fc16eLcMJpsA+3oVfWDCG651T+zByMh8Ibkx1vNTD69EWv0oOcHid0qyrhpoOpnIWVVw8ONe3fTl6vYKrbC5Lf051hIyzU9qdoWBg2hMdJSj5k/2tfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC5zJvjMSL/zbIqKWSSekvhPcuLKzz6f8pK4KXsDzIY=;
 b=euPjtgYdacjdhC54MYtE5LferI9IxIRIpLzkrMKAwRP24JqWH6WAnoggZnsoiG3ul7jvdcASjJwTYAYWSqACWFBN0hDdke3113wJOcCx0qneiAMeSc2NHOi8NR8zn2Wc6TLMPn0F8FU92/ygeOuLtCbVIJK7zRi7YRGuTJd0VEyb6/MRT8udAYIlXV7rb1v3vxM2WsLifqbdH41xo7N3s9eLwUW+2q61eijhdlT1W2WdgELcWS+f75+TkqTuCOcb/ALzw4rvr+CA54bGj3I10E32ihM/4xA9SuPLhmIGNCwwza4tJ6NCXGABSr2lt3WFz8BxPY+SHexU0RH2Ay6S6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC5zJvjMSL/zbIqKWSSekvhPcuLKzz6f8pK4KXsDzIY=;
 b=FbGgPlIBCGAnX/utlNpasyERcsutaTkjnNC6KdWELkI7b8fs1MKTHozHgSCCYF8pJZIFVJwEOIKT6q/ZH5tU8AzGEMabH/8JS44ZruKWrEAZzgTqZiQjXDmT6ZblzOJ18l7jD1W/nUksMNK2l5fKQqc2T3bbo1Gu+kqWL26bKKUJHx/TFayzgw8zKBqpPp53aWZ+QX4uB11iW0vp+6qImU55cW5oCWIn/2Jl4CaKg9AMkaYoFadwoMTAiFlpXU8p13La2lyB2c+b4r6Nr5TcuUVc0CHU+81oes9L/Gkp4azELXh9NTbmDav0sOBkEjnHUwXpna123LeEPdP9lyAULw==
Received: from DS7PR03CA0345.namprd03.prod.outlook.com (2603:10b6:8:55::29) by
 PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 08:25:08 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::a5) by DS7PR03CA0345.outlook.office365.com
 (2603:10b6:8:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 08:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.12 via Frontend Transport; Tue, 13 Sep 2022 08:25:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 08:25:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 01:25:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 01:25:02 -0700
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
Subject: [PATCH 5/5] iommu: Use EINVAL for incompatible device/domain in ->attach_dev
Date:   Tue, 13 Sep 2022 01:24:48 -0700
Message-ID: <20220913082448.31120-6-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913082448.31120-1-nicolinc@nvidia.com>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b1a77a-d97d-4e80-398d-08da95617794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2A6Ov+7fJIqbRFURc7GL2c2CLtvc1FfBfL/xh2lDcPeUG3juunJl85FWH2JaLCiwo+zoXkwXdYqXl16y88EkZpgo7WvFKX9TXRYe9lAOeWWHFlAgzS3tT0dVA3cc+B5zXTAIYduSkoOXajd80zZxsJEEPtF2cuh34sA7ym9wBxnJpuJNJHj7/wJ0FrG+G3eUp2ETNyTQMCKytq9/Frl6PT4jCSvaktIkGMBNLieDiwjeOc/6kwhdP0SL3nW2LpCLubCrai+B3uXz72NsO+PGKRBhmf9WUkCKq/YtB6YfhPBepwQDe0vD4m/NXYbgOqTCeSkpAzHPPstbGqfsmtHkH66Vo6Q0nyuLxf2qQKCJAfajma5HL20fYePsav1knYx9hOtW5adGI9FFmrs7MIbBvOfAqMgZolXv9yqys/S9pLi9+gcTcIMR4M889gvg5tpF1pOclYWKCH5FXQ5gMg/XTUzlp/PdXzoJfl4qe86IZdtEo6O4K9kwOfkVuDe6oc7GyzbknvsYG2dcNdpLgpmQwFCKZnDHBQjJtpu7/6q58fGgnKdWVFPMComWMAUyV7/kTlcC5af02zy0GA/m5j3M6V8G2eGSOkah6eFNzgeL/fY9v0Ovo3qsvdRaKdnU6MCLT1lpiAXPoKHAuSht/5Zj/JtLAuEaWoX5wRULQsGLywIfyY51RKFC2TayYGFKIA0HcbOJb93apPbEspWyDTGPfiQFxlwSqOtpQxL+tmo0JPYey93eVnC/aB1MKdrmT25yTJavfLa45aN1/2vJ6+7lhWlnVZcClmOft5TYhyVKYpK3IT+Cwdn/lLQxx1YMtMB7SkOqXqQo9We4eUli8aPRsnzvJpEMY9NSC9LvYV8oJ8V6xI29Ku4gUVOABUH6ieW2dhsetS+5NtQlOFSZhaW79w==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(110136005)(7406005)(47076005)(6666004)(316002)(82740400003)(2906002)(8936002)(7416002)(41300700001)(82310400005)(5660300002)(81166007)(54906003)(86362001)(356005)(478600001)(83380400001)(186003)(7696005)(2616005)(26005)(426003)(40480700001)(921005)(336012)(1076003)(4326008)(70206006)(70586007)(36756003)(8676002)(2101003)(36900700001)(83996005)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 08:25:07.0978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b1a77a-d97d-4e80-398d-08da95617794
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the new rules in include/linux/iommu.h kdocs, update all drivers
->attach_dev callback functions to return EINVAL in the failure paths that
are related to domain incompatibility.

Also drop adjacent error prints to prevent a kernel log spam, since EINVAL
exclusively means an incompatibility error.

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
 drivers/iommu/virtio-iommu.c                |  4 ++--
 9 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0186dfdf31fe..8b5a2e8de7e2 100644
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
index 771dd161545c..63a488f2f16c 100644
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
index 49d40c80afd3..542fa8c4b6cb 100644
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
index 1f2cd43cf9bc..51ef42b1bd4e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4158,19 +4158,15 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
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
index cb14abcfa43a..cb8ce8af0bff 100644
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
index 874c01634d2b..a252cd1daf70 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -733,8 +733,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 */
 		ret = viommu_domain_finalise(vdev, domain);
 	} else if (vdomain->viommu != vdev->viommu) {
-		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+		/* cannot attach to foreign vIOMMU */
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
 
-- 
2.17.1

