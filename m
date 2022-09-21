Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD795BF915
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIUIYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiIUIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:23:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514AE564E3;
        Wed, 21 Sep 2022 01:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6K2oTMt5OZPr5xUZOfWGl819xgS0AESm9Kz+IeC96CBgsnvJkgAyx5UKU3ZFNfpG8FNDgJgyD73V3xiaTbb86zANLqYncJpThaxCEOmtd18oiTouvxAWJE3rZGCShwDgac25ZUTRHiZBMw+jQyDFHWzgtsrF+duGALkVSo5FtP40qog5i2qkOPB0B9BXAhMdfZdTCLkhWz0WdpY0GEVxqkWHhapQZ8IMuQhnKsNFyERPc68VdZjUROnALNRsx56LYgcQiKOtRe6NinOEyx4uwLRgfOOIJ/HXpNfEPzs190CBfVtCNRA8Bo5LkSK5+FD+0sJrS54iRI3mZvLPD8z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUuZ+Zjpj5ybs1qjjUFFijxxk0TQIcq4LwJzlyUIp4g=;
 b=Un2/d8KBs+lxo5yycHGWsKHVI2BHgV8pkt87O4okfME6PHoFF4yGLPAaNp0N0WACv/IsEC3t9v8vbUPW49rEu2/rKzy9mYuWSQAP5olwYjn/0w3lV306Fl5bhrcu0Nkq8+JcUjtqKw9fmle9R5LLeixxuG9oGm+e45CBICGpKiYCBjJHZ1B/acGnlblLCoKSdRGArYtVhfCTjtJCDYioidDo+TChfEC1wkDF0wK2s097YuFXKWajWUDBKfYumTNs7TGLN3qeekw48HQFMEp+KpaUG2IG/xWzLLZGrtMr7/AI+O+ScMV9nSfJ2AGRY41JBm8CcA1oeR3BIY2VdeWRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUuZ+Zjpj5ybs1qjjUFFijxxk0TQIcq4LwJzlyUIp4g=;
 b=FXqUDEd10koWHazMUSx+uCMF+YL74FCOOJVNiQRoZ0C09w4UsCijoKPuRnXX3JVnzeO24CPC0Q1sGBzq0GtplNdwHfcnLuz7/MesaiL5q/LUtTqzCNkqB6/zEQ6JInnmGwKFEX5VsrFXHcib6Yc+GzjkQ2CUzMK5Re8l9JTNS6Qwqal0kcc0JvE1yZVv04KRYN+/w0iDr0n6Qm69A71dQljoMA55mx8MlK+IBCRxKXwyKLEVq7Lcf6XXKMt2yWtRTLWIi0jK74Aw0fasq7K5QZHcMZHo8dY0YRWgp6Lxpsv3abVea3y1xFVhDPAwnihTiYszf4KWo0bUYOlsBd9sBw==
Received: from DM5PR07CA0062.namprd07.prod.outlook.com (2603:10b6:4:ad::27) by
 MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 08:23:36 +0000
Received: from DS1PEPF0000B076.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::4) by DM5PR07CA0062.outlook.office365.com
 (2603:10b6:4:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Wed, 21 Sep 2022 08:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000B076.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 08:23:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 21 Sep
 2022 01:23:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 01:23:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 21 Sep 2022 01:23:19 -0700
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
Subject: [PATCH v4 3/6] iommu: Add return value rules to attach_dev op and APIs
Date:   Wed, 21 Sep 2022 01:23:16 -0700
Message-ID: <8c3dbf153b63a3002a46bab6e707c63fd8635bb8.1663744983.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663744983.git.nicolinc@nvidia.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B076:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfc07d9-8227-4586-7575-08da9baa9480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWxKC9JyW260RPU5WFEiQ68d3Ok5wDXiJ7dFoRBsy8ug2yu6L6a2GQIuWGZU5qd/vbbsQS3HCtH5BBVHHqgw2l60z3SzoiD6/H5QH4/8yEYvNhA8Xq+MiUERYYNR6uHjIx8q1VjQc/wOYmlCD738oCIZnXBx6DayUBiIoEfA8+wjwAey5Fc1M0RWi43aMYIfijvJ506/5zQ7S0T9HF/YhyBIPi5VzjV5cOmxY+nAW/bEWibJkIpbDGB9NNUOa9WpaCLNkcFhkn6vOHUQ+zMKMGtIzyBqO2ktp/XwXaBjIg5pGGpBl28Ap/eXP+dFvGEOudZ5vROXz0Z2b/oZ8GS7glitMA2dTyk/bTAgqBt7CmSKpqH3sajpoFSoCv2/yMaMrcLGeqZWQSnpN9u6c2oADLjLMirOGZFOPfW12kBy+Vyi3WtYHu7dTsXJVmlB5jCOuHLPqh+J5IFYNuiWowx5IlelZZ10hMOT3tmjR5iKL8iOb0ORwd5c+7pP/kZAfGB3jd2juek9IYUA+tcec25vC+SC8IdoHjX2SXKvKnkYySH4QCIOlNLsJsnKE6x2voXuw+g4tTJFZ6FLKGXaYD5tyOuCY/1JtvZW9U1q2pF68jcK1Qtf54CQH9uFrUk2U8CskK2A/fB2QzTKCTl2Nz7p5TeOF9p+7xNe6bzVGa16zKkQsAR47cmOIRghvFY6bq6kdwPpZfIBJAvFgDK6F3dmG47AgtA3tyRND4YpYhYDypfjEkJnb+h65BU1FDgTPNDsCQZIA/EN5LeXhy3qGzAwr8Jp68HPrADRnso7PzIsg1NdKKQ8RFVM7pmoJrznNbbWO2a708BYIAbBlj2OLpEpEQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(110136005)(54906003)(316002)(41300700001)(7406005)(5660300002)(47076005)(6666004)(40460700003)(70206006)(8936002)(83380400001)(7416002)(8676002)(82310400005)(86362001)(7636003)(7696005)(4326008)(70586007)(26005)(36756003)(336012)(356005)(186003)(921005)(2906002)(426003)(40480700001)(82740400003)(36860700001)(2616005)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:23:36.2976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfc07d9-8227-4586-7575-08da9baa9480
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B076.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
 include/linux/iommu.h | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a808146b50f..1d1e32aeaae6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1975,6 +1975,17 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
+/**
+ * iommu_attach_device - Attach a device to an IOMMU domain
+ * @domain: IOMMU domain to attach
+ * @dev: Device that will be attached
+ *
+ * Returns 0 on success and error code on failure
+ *
+ * Note that EINVAL may be returned as a soft failure if the domain and device
+ * are incompatible due to some previous configuration of the domain, in which
+ * case attaching the same device to a different domain may succeed.
+ */
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2101,6 +2112,17 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 	return ret;
 }
 
+/**
+ * iommu_attach_group - Attach an IOMMU group to an IOMMU domain
+ * @domain: IOMMU domain to attach
+ * @group: IOMMU group that will be attached
+ *
+ * Returns 0 on success and error code on failure
+ *
+ * Note that EINVAL may be returned as a soft failure if the domain and group
+ * are incompatible due to some previous configuration of the domain, in which
+ * case attaching the same group to a different domain may succeed.
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

