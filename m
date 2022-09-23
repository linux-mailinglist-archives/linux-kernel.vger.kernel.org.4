Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ABC5E74B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIWHRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIWHRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:17:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA4912A49D;
        Fri, 23 Sep 2022 00:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOC3FMu8JYPZElD67s0rSTFLweOIqhmRGFFD5LgJx8X/1KEsH5p/jBatf3y/Le8pvHfSV3UW9L2/jQJd8Lc/BRJ/ml0vUjQytnn89JQ/nGmeIaja9KUovhnvD31AurWZGOmHRTPIUJ5lu0v0pfk9Lef02+WnQmWBoy/wxFE+HR28d6VkHtf7+Mx8HIfRYe0uCFJLNI91vBTX9Dfb34z4e98x08P+2JCNXloPRFRABd42fv9YkFC3vWT5OMygNaxtRVEDRuUP/HUeSmdFys5jwSAB8GFhQnZev+n32AsTxMIeLCL9d1NXn3tNn3DlCKDu0TNHnQJ0cuozK5jrmmRF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYMKpkpS9ba8j+RZsvMkycIUdHSqGCVNAQ4fLXx8euU=;
 b=AYjPZIIhBgh6vsgXD6dzTsZ35DCceXYXC2E29ch64a5Vt0ymttX5+44i3ZUgADdo29pWQOI91uCM8cpeX7L3tDKthKf1w3CjrF7ENwfHaASrvcNGPCSpp6pgfqCm77TzbY0t6jEo+jKcu2Gb4STU/pJPbb2pvrFIp2G9aMjOa9mEf1qxW27yyCd+7WQePM8y2vB55cXTvgEgRaQFfly9EFg8IhiFyadHM+TqNWlk6dVoyNYRnZc/weYdUlZ7fMIUd78RnV5kp8cENVowbxFcZhEXn686x6BssAFfG2LMXGOhkTTHJLaAYeCoEwFZ+8mn2oPeVvQwBTcWG7+WE6/lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYMKpkpS9ba8j+RZsvMkycIUdHSqGCVNAQ4fLXx8euU=;
 b=JneMjicmwYEtRW+K794LYXAogzeyZ7Y7JtMCQHo75Q3LFpJh3mNRxId9teuEMUtGdrBfqdcMse6gcKEIdtUrDieKulrO/PNrbTQs8pvKvlmZxtnsKh76t+IAAQfIqBBbU0iCTt9VzF33/bogB/8jPpnvEcHq7dnpjCv1/aq+j8GhlKW7nEb24+V7gaXdrQyKxmuhkoLskhTYWq9C6McA8wxjPhGfmQcp2Dqh7h+dCbILRD1W0Wzg7Ok3VBFY+q5Fn/JB/zA0UiH3JwjU+L8OOCej77KbF3MayZHA0AqpxmEiT1YQzUy+IjDFNtrJzo1IlFFYgG7umQFraHVlVXgbZQ==
Received: from DM5PR07CA0075.namprd07.prod.outlook.com (2603:10b6:4:ad::40) by
 DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Fri, 23 Sep 2022 07:17:31 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::35) by DM5PR07CA0075.outlook.office365.com
 (2603:10b6:4:ad::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 07:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 07:17:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 23 Sep
 2022 00:17:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 00:17:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 00:17:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 23 Sep 2022 00:17:19 -0700
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
        <shameerali.kolothum.thodi@huawei.com>, <tglx@linutronix.de>,
        <christophe.jaillet@wanadoo.fr>, <thunder.leizhen@huawei.com>,
        <yangyingliang@huawei.com>, <quic_saipraka@quicinc.com>,
        <jon@solid-run.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v6 2/5] iommu: Add return value rules to attach_dev op and APIs
Date:   Fri, 23 Sep 2022 00:17:17 -0700
Message-ID: <3dcbf9eca9da17cec4b89d60a1691618b2236fe8.1663899032.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663899032.git.nicolinc@nvidia.com>
References: <cover.1663899032.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|DM4PR12MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: 3791989c-2e35-4a12-3da0-08da9d33ada6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YRhpJrLHF4NW2yPkjDSR++g8ybAloE659fV1doQhrNXb0Tpu+T2iNeIpBvKObx4EZlW/PrLNJ1lk+JCoBYHD5yS6GDaGbLfx7/qfb7/BPQZ5IqvyQ6RFPPpwrRuyvIOfDMeTH1YVm0h0JWuU1oRQwsO6SddP9toWMPhiLcw6uiwh0qGbXyYDGMB3yH/hM4DR9qc63UiBYdl75nbCLPSudKCMm9Il/vof3/bXKBSX0SYbs3ijzg7Itwu7jkRvmh5weVmpqGQ+A/Z6F7lp+hv8DByu+YXpKlueCa56VvF9KqWpzEA+PNfyPbHFV/ZILkJkWOdgBSh14TI+pfGKyivqthEgxwbBYDVh/K9pdoNibBFXw665KQy7SPuecDvYIKOm1GGe8Ao6lQm6xnlyvRs8dRGIlORZnRis46KDr14pXsDRnapf+bOhWoCs0Xz9rdMSSb7ZENmE0HzA+WyS0VOdSU4wWSDK6UIuR6zoBMr1kJHWUsLOQkvuh99jSygBINmXo9vBA2eIELaDYjg8YLnpTKOL4pWH1cNOFexkDRY5ygdvEeGwzcSAkIUxtNH0XVCqxkJaBzzBv0jGjhiEFS2NnuUXYJo0z/V+rXPMClmMs/UFd1f34YxnKXaj3kM94ZyYH+EuOPjUDxXKxcxVEiDDHkgq3SOo6bI/rWV5gH/WfbPbbzqvsxKRSnTOsgdap28YcoOGc+NhxvJXR38KVH9ttVk2S966AjGcpAkfCiKGOk/3YM1uWPBSHXz75euljnWSV77f9ZwzrworSWnyD4rDA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(7406005)(7416002)(5660300002)(54906003)(8936002)(110136005)(36756003)(8676002)(40460700003)(316002)(41300700001)(82310400005)(356005)(4326008)(70206006)(70586007)(478600001)(26005)(7696005)(83380400001)(47076005)(86362001)(7636003)(186003)(40480700001)(336012)(426003)(2616005)(36860700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:17:30.7186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3791989c-2e35-4a12-3da0-08da9d33ada6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 3a808146b50f..5f7f9605db48 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1975,6 +1975,18 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
@@ -2101,6 +2113,18 @@ static int __iommu_attach_group(struct iommu_domain *domain,
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
index ea30f00dc145..13a33b04e867 100644
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

