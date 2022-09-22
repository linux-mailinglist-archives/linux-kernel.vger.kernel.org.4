Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F45E5E06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIVIzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiIVIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:55:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266538459;
        Thu, 22 Sep 2022 01:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYahsBS+EovGIEJjNIIzV6MORykMpVwEYk9crzmWK9J60qBZvaO6HWxXcRnDfpJux2MU3EFyO73Ve7qzlJeLRpZYR41q3+VYe+fYdEfQibfeBSgj+hDCkowxiALqBJfGLTRfau4S6ngMXIJkskTvLEHD7K79lOHjnGfG+xDHARvELOgYIRTqhDS/pec1jE8TsQHQfNPNrmej3TC+EYa5PQ6EKaUOCPKYQmUlrLgiy/grFFgNAdU7yOPAc0nhgIGcw+CI/dShjSQn8nGWEQRmVknncbsqu6hRXEsuiIL8uCPOlUztBPssgQxSjNyDAscLnjqV9sSc5PjtrEBndrSiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6RDcSdVHjHbpLbVw3O506y8KAleFfHcA4+qqblUE+U=;
 b=BwqeAr9S3lgePEOgylS5n8pBg0Cl9J9VLfpctfyorsq3IZN3Cor/08J/8NiN08Ewns4u+7b0vuO6+WoHpdkar7LCOf7xmQldBXnpgI6xWTk4svq/4eRC5qVOWNLXcV24QuHvNCilGeNN0o1L+/5oZ6EoYnKgwE2okWFwXFyBu+FUDlYLY9xtQBFlTtFEolsx8h5t09kwi1zcb+ckYtEDFecuX00yiYKgkfOnHfbYk8uGbiOBnYkArIstzqpqT468ocn8YQBaGQMZXw13hmYgc4hjxdNsaS/FGoWsC3v50f32pAZjroUvoXz1R+NSuciJANBYUY9Qp/Ncn0/h43Xjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6RDcSdVHjHbpLbVw3O506y8KAleFfHcA4+qqblUE+U=;
 b=hUAHXsqA84yZUoD0bXSYuEA2lQ8cT/yIJ5VDqm87mb5pUpUC3gnN/NLZWe1syL/M8r6WBjQ9jNk8s1q+ZhYTinpN7Nk71V4PUEEclcdKpzgw63DNEFYcbjiCWSZDX1aXUsNdW+7Te3SReABnHj0TcJWk4MUGL82TmUEW+2T57iU9xnfDCHFpSfkTus+ZYJmbBGs2IAMDs+D4cCjcZTTTaDNWp2Hx8sOpq9G0aGjsbKJmfRN9u+W0kuJm/uLNdKaWZJPc77VynXxjN3uSckOuH/rwbG7FzMI0jjw96dYL3PU81V/2nsqGIPsiETqY4CKxSk07itRB5xlkqHVV0i43YA==
Received: from BN9PR03CA0952.namprd03.prod.outlook.com (2603:10b6:408:108::27)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 08:54:53 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::4f) by BN9PR03CA0952.outlook.office365.com
 (2603:10b6:408:108::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Thu, 22 Sep 2022 08:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 08:54:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 01:54:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 01:54:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 01:54:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 01:54:35 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <matthias.bgg@gmail.com>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <jean-philippe@linaro.org>, <sricharan@codeaurora.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <konrad.dybcio@somainline.org>, <yong.wu@mediatek.com>,
        <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <christophe.jaillet@wanadoo.fr>, <thunder.leizhen@huawei.com>,
        <quic_saipraka@quicinc.com>, <jon@solid-run.com>,
        <yangyingliang@huawei.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v5 5/6] iommu: Use EINVAL for incompatible device/domain in ->attach_dev
Date:   Thu, 22 Sep 2022 01:54:34 -0700
Message-ID: <9cfa41b3aceba02cacba33d86849277f5d1c3684.1663836372.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663836372.git.nicolinc@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|CH0PR12MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b8cdb0-c53d-4d80-90ef-08da9c781d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjbgruD7s/B5fkNiPFa7U2d3l+gYO/g290ye3LNzZtGgIyThRInu4by6CZkELHQL0vUnFlmIDnCKe7MtbIbmK1vjQpqIP1UsDTXMLtpscGtuaLxa/RI+fUSautItFcp7LLd8ln8dLJJX0s96jsF8rjprKxQogvgkJdSqz/kJ7spTMJKBvfjqxhZ/1Qj1gQqb8HMiKbDUjFw98JVdhlqvN6zMyt/0PB8ABbN3TBvzMUxuhAuf3lY9Mf8q5mCmMmQDV1w4n7nmZc+OFiKWfnfiUGCeK3gTf4wUy9WOPrjoLqXsj6slzfN0bowMaWEaxzK7unra9GUYmmIbCEX59vWYMJv2Wyt59XJxQuoYx1T0GsRYIxQKru0GelDD7Fi9IUqpg11v55GarI44StUWM5rB8GSsVKoWHX+WwEkciKb6Tm23i/T9vrXHklRvyFwMloLtADe7V3/cxNeQtPu5Eo28SzgeTa8mvhNfu3hENx1dpsHH8AXqUfDBORQys+vKtEhmvgehBYSgvGSBo91lr9DyiJUAW0pIT2KkcvmFjl9DsWDZGTNVbOD5Akfa9zZRmXtEB9GjZ28KwPexsWcg4BC6N+s7JmcnJkFCXjmv+kjW4n9Qlv1evzubP0j3kHjg/W2HC1XzalJdrlm605jTtrQ2ri5Ayow6SH5C2HV/Z9ctfeJ3YG8tvtRN0Ag1HW4yP7f6gr8FbZcCU3ejWcTfkMP7mLrQBvgamL1aPl1O6OaSUd/9bDs1cOp4TovxsPFPYqNSa3ZDS0e8WnmXX/2uN00t+4mpjtFI7FAXmp5d1ZkWkGn56zRzyEtD6EL9gbqeWVco8fSgnlupLlr0wykucrILGh4eVBYe3qxZZTqzPnE39e0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(186003)(47076005)(426003)(336012)(7636003)(82310400005)(356005)(8936002)(26005)(921005)(70586007)(70206006)(7696005)(8676002)(4326008)(41300700001)(86362001)(40480700001)(82740400003)(36756003)(40460700003)(36860700001)(2616005)(7416002)(7406005)(2906002)(83380400001)(478600001)(5660300002)(54906003)(316002)(110136005)(2101003)(83996005)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 08:54:52.9485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b8cdb0-c53d-4d80-90ef-08da9c781d83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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

