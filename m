Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4504A601D45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiJQXGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiJQXF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:05:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F053284E58;
        Mon, 17 Oct 2022 16:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnbwoAAvaARGuQ9T2LiI5cLgBO1mWmDpf2Tpo3IDbOBmYloTxPo0D8FbDuuTdAUr4ayZCApOs1bmT4vIdjKWPv7kAaoW0RFnrMh/XAfKb9n9Czc9qs1hfyGzdwDLdp8kf96R4nGmAVqwbDIQ+a4kinxCcjPn2zHkzJzE5diwcVmoPQKqnvjQwbvagmCUaV2Sif/TCRyNoaJpB/qREjla6NJznzu60t40b5ydv6yeeYns2cuioVY5WaKA1Lv2OwkDX2TKxoW4NYllXUQS5d8fxI3MPU2r6pLWfTYteN1cUU90gA3iRC70zfTUhBAMQZ+/6Hl7hteA/v4B7Wn+JuWv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83OZRIvitM222fOcogL3i3tPVuHaJXb1DWqJ2DZfAsw=;
 b=kHhyAapHGYj1lE0WzFS0yj91d5XJJOILDszz0HMCO+Riyi1wGTaX63LV0DrViA1BwStJxYGuLygtBPWkocH01mclVP8EwSvRimJObVn1fl9f5LLhkuha4tTutHLujPR+LK9bIoWXRPfg70J5SauQoQpBYbEHWiPop/qo2a8ErT4yxzA6YhmRf+wpyD2Hl0Z/3IssU2+bcg6HRFkBFSFYW3bKOXVOKtKc2pdSCS9JKg+sWNb0vfvSXu9+cL1nWjuuNI4i8/YThhwqp1RzyzHFjClLKNycV3cbSxSfcs0b5oY1KVW3u1wxHv0cYqaHdbvJNU3uq03/K8atDY7CqSBIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83OZRIvitM222fOcogL3i3tPVuHaJXb1DWqJ2DZfAsw=;
 b=I3R2CkZDeDJt1oCmEoSVBIoRG8XL1BDqXLV97Pynarpjz5F2OOMLEOq8NZVLY2qwLCCEbGNYO4t3COdm5eF7niuqzcX9E2s1ZD8ezQh7yssC93dKY0/yUqzJbVVP0vGOE6iAewB2IipI3mD1sgyolpIqhLeQaGQFIbQ+PuJpJBbA9v5UO5QCoJS39gY+AbrIKR+mwZyMkk76k2n6B1t++VI9G/mfvVTHA6HsncnQcOnSdobBQhEnxKYAagS1q/xi9lA/dNx+lqA/qYxI+ljUB1FTqR0pBr2P2OK7sCqYQ75BWaJbzWmlsIPXCrSaxlAFe1GtiCZ69KTSGf3MwtD3zg==
Received: from BN0PR04CA0153.namprd04.prod.outlook.com (2603:10b6:408:eb::8)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 23:02:11 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::24) by BN0PR04CA0153.outlook.office365.com
 (2603:10b6:408:eb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 23:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 23:02:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 16:01:56 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 16:01:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 16:01:54 -0700
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
Subject: [PATCH v7 2/5] iommu: Add return value rules to attach_dev op and APIs
Date:   Mon, 17 Oct 2022 16:01:22 -0700
Message-ID: <bd56d93c18621104a0fa1b0de31e9b760b81b769.1666042872.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1666042872.git.nicolinc@nvidia.com>
References: <cover.1666042872.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|BL1PR12MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 5508daa0-38ff-4d5b-6877-08dab0939ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGTb2JPrXNXA64F6YZ4Z053hknGT4ed1UZwnUvroI9tXZTsxsmB0drJBjUybOjRxOlZ2uWgpc4NZExU994iw8yBMjks5vHaxsSeLdB/iwSLlVO1Xs+6u67GF/f1+jpkwkK/kpWZVilFPTZAwt00T7bkxPAN4uYxd3oOWgL1P6WJ+jxiutBLS3QESyAqTH2Z4a/J1DK6vxMNOYdzFEsWzM2aAykd9UYOda9S+nQToRhzQLrElP6WmwlK95lFoMRhqCWER4HOHj+bTM36DaxYYG9lrS68na9i5VBD2juxadCm78J6rlb2uCmwhiPTs4zsKzBngxSjQXomnWgfTj1R0Rm0INvIoaA2tdRmBjJ2SgebMWSI7BTRekQi/hcM2eIbgehl5BcEUFrghLLQ7M7YmWSotabqOZll1UdjjxJPjrlKaJ72dvZIhOnEe0Ujfe+hdVu+vhvKqzrMb/CiBEQ4msBHeXsEdNV4lEEnp9Zr6W8WI/mQdv2GM4cgUcFqemTVN0+oDBzl9U9lApn8235zRQjS+SwOYs0yosyglGJtJOHHvL3YZSZv1nuZDyQ5ZCPJVsNwvJWbYwUm7k4RohJywgn/dx5QMPtJBbAByErKKpg29dyrTjOGVFNuhJaqVddQJaIN1XbR1lkwupWmGy/Cyeibgu0fbusEJfQEHMkhTFLg8rf7QLZLo1TSecJJnyOFQ0V5Us6jDAMbVG+hxUcLt+91vouvKUeMGSpaWaRc+yFCrLaMCZVLO/GlqV1hk4sENxPs5HJUHQqzK+u6vwgGEJg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(82740400003)(478600001)(356005)(7636003)(110136005)(4326008)(2616005)(36756003)(7696005)(40460700003)(54906003)(316002)(186003)(70586007)(70206006)(47076005)(426003)(336012)(6666004)(8676002)(40480700001)(83380400001)(5660300002)(2906002)(26005)(8936002)(86362001)(7416002)(7406005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:02:11.4541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5508daa0-38ff-4d5b-6877-08dab0939ff8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cases like VFIO wish to attach a device to an existing domain that was
not allocated specifically from the device. This raises a condition
where the IOMMU driver can fail the domain attach because the domain and
device are incompatible with each other.

This is a soft failure that can be resolved by using a different domain.

Provide a dedicated errno EINVAL from the IOMMU driver during attach that
the reason why the attach failed is because of domain incompatibility.

VFIO can use this to know that the attach is a soft failure and it should
continue searching. Otherwise, the attach will be a hard failure and VFIO
will return the code to userspace.

Update kdocs to add rules of return value to the attach_dev op and APIs.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 24 ++++++++++++++++++++++++
 include/linux/iommu.h | 12 ++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4893c2429ca5..3c0c5d64bb50 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1949,6 +1949,18 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
+/**
+ * iommu_attach_device - Attach an IOMMU domain to a device
+ * @domain: IOMMU domain to attach
+ * @dev: Device that will be attached
+ *
+ * Returns 0 on success and error code on failure
+ *
+ * Note that EINVAL can be treated as a soft failure, indicating
+ * that certain configuration of the domain is incompatible with
+ * the device. In this case attaching a different domain to the
+ * device may succeed.
+ */
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2075,6 +2087,18 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 	return ret;
 }
 
+/**
+ * iommu_attach_group - Attach an IOMMU domain to an IOMMU group
+ * @domain: IOMMU domain to attach
+ * @group: IOMMU group that will be attached
+ *
+ * Returns 0 on success and error code on failure
+ *
+ * Note that EINVAL can be treated as a soft failure, indicating
+ * that certain configuration of the domain is incompatible with
+ * the group. In this case attaching a different domain to the
+ * group may succeed.
+ */
 int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	int ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a325532aeab5..6f3569340e8a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -266,6 +266,18 @@ struct iommu_ops {
 /**
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
+ *  Return:
+ * * 0		- success
+ * * EINVAL	- can indicate that device and domain are incompatible due to
+ *		  some previous configuration of the domain, in which case the
+ *		  driver shouldn't log an error, since it is legitimate for a
+ *		  caller to test reuse of existing domains. Otherwise, it may
+ *		  still represent some other fundamental problem
+ * * ENOMEM	- out of memory
+ * * ENOSPC	- non-ENOMEM type of resource allocation failures
+ * * EBUSY	- device is attached to a domain and cannot be changed
+ * * ENODEV	- device specific errors, not able to be attached
+ * * <others>	- treated as ENODEV by the caller. Use is discouraged
  * @detach_dev: detach an iommu domain from a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
-- 
2.17.1

