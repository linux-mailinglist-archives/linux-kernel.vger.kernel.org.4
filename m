Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C2A5E5DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIVIyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiIVIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:54:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784D187;
        Thu, 22 Sep 2022 01:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFLQkbTiRPPeX23BAb/oqs7wDkvwTBmQxCI5pOrP96nZc5lKXOZll19EyodDYc4p4fRVL5MCs/QFd+f2wNptiQk/IJNmapE2fjwaoHSmehpngW2QrD1x6uIGFB/sxpHDxgygnffJW93jYU+IPnKZqh5Dmhamf3+ogPFOjI3thvrbIFmEWaJHmdspRqXuQAeVJmp8clSBvzbHuJEBxMBvoPaxXxXMtEnfM632oL2dq3n0kXi4SVXElul3bSD+cwgZkrxlXWcYme27sDW7egNK61ZhhX8IBog3Hu7wjh+U1HMhg7m6iWQu4g6p4mx34qUNtdH+9xyUtPTuZSBq1ms7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJrjmAc0pwysxVfPiHm1a9gW6M2TTJhqbFF8UbIQWMg=;
 b=XephvHkKso9Cp+bYh9equEIOSCHOD8tN3lfGRAIgX+GukoM843h7ON+n/c/MYWN4zp19s8sUqsTMly4blAr2CjG/LXI6+N/njRLzwOPagO1DVQczfNvKSyANz2txP40fxsYPsSdYnGHINn6dszHZoOyrDPv4zsJIYotrO3uQ504GWiGKSmC9zLUDtXGv4dCOvPE9TGUgbZYrdA1an11cvGWmsuehclDdwAXXC897wBfcrM/V355dzVuvKXRcQ9V7bBh+PcPVq9QQwxoiIQ+wnEK31Gj44BrPpHCOKzr18+id8lQs7jbLQsiENwfdAdcPA8AMOh7fDuiWwKwb5SSJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJrjmAc0pwysxVfPiHm1a9gW6M2TTJhqbFF8UbIQWMg=;
 b=rzcew0eaYVUoResuXoc3pNHTVlSA9iaQME9JLUDHo0r/vcDykXYeU6xDfg/cvlejl9eWbTutvh80bNPSGqDlUURnoJJDsifmmcU1bwOR3Zvg9W1yi/ErS+tiH8ksqL3L+r3+jTWatK2tNFjPRVmVrumjOcmQCQtLuUZKvXdL7R48yIUL3G3C4oB6bdjTuVryeuL5PwpWJP1NnGgk1uJFHQ1vbb15Optx8mmmoEaUKiGJ/nH+yCFUoMfpS7Kj/xzTi0+iboC1yAbsASYE0vF4E44hoRl19oLb4Z4iF+FkwIZw3AqfTlRI2hlnD9XmgRjowRQNPMd+uBCkH93dpIEHaw==
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 08:54:25 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::49) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7 via Frontend
 Transport; Thu, 22 Sep 2022 08:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 08:54:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 01:54:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 01:54:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 01:54:11 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <matthias.bgg@gmail.com>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <jean-philippe@linaro.org>, <sricharan@codeaurora.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <quic_jjohnson@quicinc.com>, <konrad.dybcio@somainline.org>,
        <yong.wu@mediatek.com>, <thierry.reding@gmail.com>,
        <vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <tglx@linutronix.de>,
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
Subject: [PATCH v5 3/6] iommu: Add return value rules to attach_dev op and APIs
Date:   Thu, 22 Sep 2022 01:54:08 -0700
Message-ID: <6da77154f1a49c9c2dc2dc4674b3b91cd19862d0.1663836372.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663836372.git.nicolinc@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb38435-aae7-4daf-8dd6-08da9c780c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRgs6ixIXLPu4eFdHduve/reHJ5Gqopv6g10J1fKTcwos9yfMpxcJRoImbccKADoeDDjscpfmzEsC61yYMT7qg7efEBf9lItvoeo+d0C8g622/FBMydGpJuvUORUfEb4YLiqKzJjbc8jPTAiSrH33KTPJfyv3YIikBrfu2HecdDqEI1j05PXtlA8mWymwv6lUfAJfnSo7hY7opZIhl6ZNof84ar44c0qFAXVEiArjAbvidUqRBxRaSULfh49Zo0A2Ag38UY9UYMxbNG5IpuPSWlC1+5LoQGzne5JDG8qnNWJ3oB3fsCAJYHfVTs9gD4uKiXoH9wIopTXEHxOil7leAbzMbT9G0sMApADpmHe3QWQNpYe4mFQ4pv9QVB6bCHkvwnSPGH3uyuRvCRUNxwxH6m4Ne91l3uFd860byNCLprQmPdt4OE4Q29h1TmU4Ym8tjGFdAMb0oqenOSfYWbkzE2fmWAZ9+YYKZLHJnDX6CZJrjj4IsZ5dIz74UfHzJpDC4cfTtMKnRkfUK/91lqugoSyR+pDyeEZRT6uwFfBigLig3VX7i6UwyS5J6NPui3XT5oVfroSTt7FexVsj2EY+VfYLAk0L8l/iTI1UfZ6yS2z6qRN7PYzq7EhbbOpJ/Ljsdjeqqe7ZEbH7sZtMoUTT2TKV0K2w/ygGqW8hnbWa6de9PS+P929BvIZJuxXkligTE1U4+lIPSI8WZ/rNnY8uYGVMs829IV49ayV1jD9ejFVG1MumhOn6Og257UflWz/5rB7cc/qoYHj8E650Lq/Fp7bhaDD+3/NDOgON+8jiOIZypFGChBo/ktqolgqAyV+YtTO33NkZnRm1DcjR6Bbig==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(47076005)(5660300002)(36860700001)(82310400005)(83380400001)(2616005)(7636003)(86362001)(40460700003)(186003)(2906002)(316002)(336012)(54906003)(40480700001)(921005)(356005)(7696005)(26005)(426003)(7416002)(4326008)(8676002)(7406005)(70586007)(70206006)(478600001)(110136005)(6666004)(41300700001)(36756003)(82740400003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 08:54:24.5058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb38435-aae7-4daf-8dd6-08da9c780c8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

