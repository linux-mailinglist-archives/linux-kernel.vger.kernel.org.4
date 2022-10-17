Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2684601D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiJQXKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiJQXIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:08:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469085585;
        Mon, 17 Oct 2022 16:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQoEi9v4CaMciPrveoQ4hOMhEdj9XfnsKFB0zmIEdppbs1bjPvx61rPfX35arIuq2hCj85v/3GicHk+nhSe5DfmPerqjQeqGD105DIGfMsWjP6igIWnzW8yY5u+UlQRTm0LwhKUjONddKFOCSVGvUUfJvM5l/bo1bwIHLDzw9ciZzAd8v1GNH9dFjMddcTqQb/UHs4BchBmmNjKjWh+Yk+7LsTTRaEq5jab65o/kTkqpoBArobbnzoykQ6qpQGSnacMm0bIbyxWDoolVmfLG6+hEykpW3y5q2IpOpadr/u8XUCINwNw6cNf3SMcfCy7sSGC7+Tdpq0ur2xrQkGrcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scc7vrirRVcL8XzNKnuTWYRhUwokIrL6E4cMmUCt3Sg=;
 b=CsBZpCpKI+ZFcxEZoe4xauLZ4X0UUxwjqxNB9ZyY3UK26vyUEYuhS0pGlE0StQfLOa8DBPeSK6Mj659SHQzRAOiRwGEFb97SdrTq6MkQnkfhpXyFWbI9KeJEfjh0jQEPsvCFhwakfw4ZimzHoEhsd0MRnR08ECjx1EPOKNCVbTsqc7DUuWkfbbT7xnz3Kt4+XPEN5/hfN2Jxc7NFCvh1H3PkuMCK7n++QnOlGoxXpg0MLLhXsUD+nJPfR1jz8RwsYbk52sl4LGz4AJW8EyiF9gKMttQM6jpJ4Y5NOKMR7SpFbXv2WsEaD9rWuK9e7/LxHZPxzdLFdeMFCQP7Tp5RuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scc7vrirRVcL8XzNKnuTWYRhUwokIrL6E4cMmUCt3Sg=;
 b=CM7fWgdP2gVwOaRl9AYKVwR1VgDshwBzsiE6UrWC7Omd3MceUobMNq0HUxyKw5MKCPGTsdfaTvNv6hpwxiXRvLTBdSoW8NVqgjmiwViSh+uiisDzIA3G0G1rnv0SjvaA+9QXJIt90hx6yj9Q3a+Gx0wOiCEeIXSlCqwF8sL6qa+NTxoyRdiKdq1/H2Cvpc6Exz4nShQBsLKoDXXCkCldT5mQB2IgAxqkxiJapgN2SnDcCBLolMvS3aIPCkLZFnCDaodXtJk3jKDotG97r1rnWZI1Q8tTxjc6ffXS3CEpYj7r3cfonS/AGqCoIDAwfmJ4O7dRSfcrYWdTzQqRX8hl8w==
Received: from BN0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:408:ec::11)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 23:02:39 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::aa) by BN0PR04CA0096.outlook.office365.com
 (2603:10b6:408:ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 23:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 23:02:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 16:02:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 16:02:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 16:02:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <quic_jjohnson@quicinc.com>, <suravee.suthikulpanit@amd.com>,
        <robdclark@gmail.com>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <yong.wu@mediatek.com>,
        <matthias.bgg@gmail.com>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <jean-philippe@linaro.org>,
        <tglx@linutronix.de>, <shameerali.kolothum.thodi@huawei.com>,
        <christophe.jaillet@wanadoo.fr>, <yangyicong@hisilicon.com>,
        <yangyingliang@huawei.com>, <quic_saipraka@quicinc.com>,
        <jon@solid-run.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v7 4/5] iommu: Use EINVAL for incompatible device/domain in ->attach_dev
Date:   Mon, 17 Oct 2022 16:02:21 -0700
Message-ID: <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1666042872.git.nicolinc@nvidia.com>
References: <cover.1666042872.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|CH0PR12MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f853e77-116a-454c-3126-08dab093b041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dAtlg/n/MAltIN+Tor6ovwTMDtdDddGciZfIcuzEJ0WP5UTqRmsN/tUs0yE4qWVi/OSstzsSyVDl64EzCgKZdGXz72U1nwMSw3SPCdnFDYn9RSlOvnduZcRQrVu0ldQdCovatjfBijZbEAou2aywrRZFh2PirkDjYRpmWko3XqUGFl5UEyGdjVFsdJKe//G4LWsKGdYNQ9K9GLdgIl3ZbUr8v15cJ6UrJEqY/+/nf+zHO1UA6z/mGCl9p6oJQ1LOtGv4ZNj4vkrFSFkop+zxBcCSjhotkr0x/k+8MCOzMWamemyHfe5+qD4bPnracuP4X/8W2Q5U3AuuIHj+9YdAFPgJSToM1PKRkg/WaybrYfFGinzuFgj9qlmLmzhI9cFeqvQHlVu58ljQ0vcw7uJcONlEOcqlU/PKrbymX6VEqqYwkAgsbBrwB8VE/Ry+WL/3ElMO7ze44GTjgbPChD8mqItiZlaeVg42MaAYNrRo1qQ+hOmDPgj2VjvxKI7qqmfY7rweYrW3izVhmu13C6agFNw05vlVas/VaN6cycgMNBAVh65kz6zzxy+fR8sqfhNTH2+JDnc+3bC+g+NEOga7T0FNEasraYHiae7iTS6pQcdx8LBtgi6Fdyexdlxm2T9p7VRdNOJGr/nXUJrDIMlf6t7nTy2WDdxeMjrPWh0zZtP/JnQBX/oWiJIYTtIQawt8sZTQEQtsDJ/s8Hb3vhIYx+z2cVg438oEx++z7QwMzlgj21XBpnu3G1+H8m7aT+4uuZxhTXsmCkgWsckLV+eddpLx8WW9KkG1FclyZXJJ5E=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(36860700001)(86362001)(7416002)(7406005)(2906002)(5660300002)(82740400003)(336012)(47076005)(2616005)(186003)(426003)(7636003)(356005)(83380400001)(316002)(7696005)(478600001)(26005)(110136005)(54906003)(70586007)(70206006)(82310400005)(40480700001)(41300700001)(4326008)(8936002)(6666004)(40460700003)(8676002)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:02:38.7433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f853e77-116a-454c-3126-08dab093b041
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
index ba47c73f5b8c..01fd7df16cb9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2430,23 +2430,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
index 6c1114a4d6cc..3bca3cc1ceae 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1150,9 +1150,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
index 3869c3ecda8c..bfd7b51eb5db 100644
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
index a8b36c3fddf1..1ac94f7fc8be 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4189,19 +4189,15 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
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
index 3b30c0752274..22230cc15dcd 100644
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
index 3f153f9e0ac5..2fd7702c6709 100644
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
index fadd2c907222..e02793375598 100644
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
index f0caf9a4f6f8..9e0ca757fa42 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -732,8 +732,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

