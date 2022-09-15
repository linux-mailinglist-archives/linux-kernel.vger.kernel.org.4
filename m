Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D65B95C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiIOHyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIOHyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:54:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCFF58DC3;
        Thu, 15 Sep 2022 00:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbKu0aSPTAyeursEZ8a8xW6AYwty4TURGwYrPSGJzvxHSv23hr+Sx0GV04SXdXhP49GsX0V0BbgmUKWXyG8MIRpx7mO4JYrx0S3ArET9mG4pmeksVOM4lwwfiaheGaAvr1edUeb2fBXcHqeFja+eU3n3EibFeTcafAsQQQGmSQXZV/pVEFiIzvzj2SUn8A1w5yhTU7GhbFFYedXoHVDW1XtbsaAy3Ea9eKn+NRkLiKM/IPH/nYcXtzUP9BzINGtRGrYpL/T0UtDsD3HgY2QBsBWNIlO/rTtl5xdc/S0LMtOWX/FZUJWUGroWWYPLmBXAP/Mm45wGnummbJLnu7mm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4++iVSopDD7PZ9pvc6GGvWnim/xl1FguP/v4ZG2nL8=;
 b=K936KmBMXxG3XMy4vzECdu/66FM0ZFbfsUiqHzfswQjNB8HKy7OgHzzvhBfQ7xnDXPI0GL/OI1XqOjmWCWpMCEyN/ZeFD4G+QytQcgukPi7HDKmBoi7bMxCJPzko7hy6sggLiE5HAQzgfmkXZNxynBbLYVECIJbBsdU/BMo4914wvd3t13Ni/CjJd8lx43HDMRRTO2WN2I3G2seZKRbfeVfyJImquNg5T4PLaJ8Ki3g+9uRDmKkutdvpV+ixu4hB9rlgBGwdNLdrVYtsxF8d6F1/vOBjWQ/Hat+ZrK8fhyEDtDcjlhdE/yUUrQU7XiPRW7fVKDiUfGS+wh/ImhiYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4++iVSopDD7PZ9pvc6GGvWnim/xl1FguP/v4ZG2nL8=;
 b=AOwzrKoHutfUT73BOYSwcef4PRmGA9ZOo3JK7oNj8kAQw93afheposn9m969VV9d9YbJo+I5HWzA+wPZwP/IhmZN0PnHGH5yY8mrDMoAA9kaBxLxgwKartRWoR56I4el5/4fvPRoGLLmeYfUEDevCXvFGOR8U2F/kQjQRqldDaJqBtf/nwUSc1t+OSVVA9hQ49SjoqcMLRr7vfhu5Gk2kq0kc2GOzhG+kFrSUfwv6c4d5zZdH+e1qsE74nvCWd1Vdum+0vQ8qE2vZsTn5CtVfIfCrOxjsEyVbHPlUmT8tNqegNNfakt51Q86eGUjWRdU9h2ruybjNL8cFutsNt9aYw==
Received: from MW4PR04CA0185.namprd04.prod.outlook.com (2603:10b6:303:86::10)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Thu, 15 Sep
 2022 07:54:07 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::26) by MW4PR04CA0185.outlook.office365.com
 (2603:10b6:303:86::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 07:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 07:54:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 15 Sep
 2022 00:53:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 00:53:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 00:53:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 15 Sep 2022 00:53:51 -0700
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
Subject: [PATCH v3 3/6] iommu: Add return value rules to attach_dev op and APIs
Date:   Thu, 15 Sep 2022 00:53:36 -0700
Message-ID: <822a983febf7e259aa2aca70dddd382810b96117.1663227492.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663227492.git.nicolinc@nvidia.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 831f3a5c-281f-4224-4878-08da96ef776d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0ijxw3EtCKf8jruw/BHqXP8sW20J7Pcx1ATV6p8OMn6Ladu95lNgrRFWSAuLKuM4EV7XAZnfkxYO1RIRnBJG+nHUO4IjQQFADX8WIxSmnli/1YPHC6f4rQcGbE0BoMOpG2gUTnyzNDdxVbzrRwkW+CCnmLoGGlTebE6myCZ0bYPPslTQ8DyKinT5fLLa9g5nexUakRDvLn5pHUuew96T17oAgsbadYQVjmC+c7AP5IvXxxuEHj17kmTUYp0cO0VbP3CVI4lxdaKnuL6+rPTtj/vKRkAl4MpmwPLud+QWWGWNchtjQaG3yyKisw40EaJVIFDTGL9edIenxpfrA6Gspbyp9jkkxKHHKOxXvVzOiuNinseWyDGRrAWmoxMkjClBrLXQ1IoA9XvGkbUyDRpkSCrh3WxIZ05Zx+bWLMHkghPPs4WEmNw3SKEHEpzoUQTqZ6BtJBCqXeMsn/p2BWtRfE1eDtWUJZTz1ZsIiGkTmhPhhYF05uPdLFqCVC343x9WDLuGn+Bi/OY4LYnVstZAkN8iFrk2jRPlw/HXmY3BfEOlgjnCaLt3xaJaEam2+qxESlmWHuSeGEi8KtBBRFj6Ox0+lqXzWOw6GDJ75ji/ka+WjBMX+3yMPHzUgfX/VgWOoTrYWYes1wopYdP4Ei1khteCuttwvo1i99nWHHcmruVdAyUVucyRil1a/IO1I9f9B4imNve6/2Snj3y2R3ZprL5ORAoFZYCdB+UhRIUZt4zvZFA4y2iClmSpjrtSif6LZ5wpu/RhIac/laIU7Tgg7zxEIyzaJmhU8xMQB6gvkWZ15f2tGDlBbTPl4XnPHUfuj6VLy1quOaPMaR60GEuYg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(26005)(8936002)(6666004)(36756003)(356005)(86362001)(2906002)(82310400005)(7406005)(7636003)(316002)(478600001)(426003)(82740400003)(4326008)(54906003)(47076005)(83380400001)(336012)(40460700003)(7696005)(36860700001)(8676002)(921005)(186003)(5660300002)(7416002)(41300700001)(70206006)(40480700001)(110136005)(2616005)(70586007)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:54:06.9784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f3a5c-281f-4224-4878-08da96ef776d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
 drivers/iommu/iommu.c | 24 ++++++++++++++++++++++++
 include/linux/iommu.h | 12 ++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a808146b50f..e4d2ee99a264 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1975,6 +1975,18 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
+ * are incompatible: if the domain has already been used or configured in some
+ * way, attaching the same device to a different domain may succeed. Otherwise,
+ * it may still represent some fundamental problem.
+ */
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2101,6 +2113,18 @@ static int __iommu_attach_group(struct iommu_domain *domain,
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
+ * are incompatible: if the domain has already been used or configured in some
+ * way, attaching the same group to a different domain may succeed. Otherwise,
+ * it may still represent some fundamental problem.
+ */
 int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
 	int ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..90960fa8cd91 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -266,6 +266,18 @@ struct iommu_ops {
 /**
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
+ *  Return:
+ * * 0		- success
+ * * EINVAL	- the device and domain are incompatible. If this is due to some
+ *		  previous configuration of the domain, drivers shouldn't log an
+ *		  error, since it is legitimate for a caller to test reuse of an
+ *		  existing domain. Otherwise, it may still represent some other
+ *		  fundamental problem
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

