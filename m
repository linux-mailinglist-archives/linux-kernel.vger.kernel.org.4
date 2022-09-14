Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997EE5B8092
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiINFNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiINFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:13:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3237246605;
        Tue, 13 Sep 2022 22:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRcZ4kOCS8zybL5U6kE+I/oM+6eWys+lOIFXHM+jreYl0SXwl0mnok6jKGx+Qt9ffZyN8316pA3w7KSk1iTOLgufJmXA2d/bul4+L3lHJOOBrWpLh2IL5WktSJEDKqTL12ivSv3p4gNIJWhT7+eLUjYfyPiJBleoKUdBqBcf6E990RQNLRqnqBBi7csXEk/8mi4WVBKhWCnjranZh0niN+luydMmxbj7wK1Ca3clY0Pf8IYDpJom/Gb9dYMBRasIlhlMxbCC8I5eUblOngKo9VGv4bMrn+h/4n6ew+m1XspKZVWF7UjyXxJxeYFIanxp0ehSoe4cOOd2r2MRvNaAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQfwQ8B19qzsewAiPCbzGezxjNE1rBQ7WVb5Iyuo+g8=;
 b=QRN3Kqf33uyoG4iw51iR4eFLBHFLtKCsnZjtu8RXUPSC+j/2yW5okmkYc94vPS/lXIppA+zToMcut79zM7iVmaLsIhhEpUFJUrBjClCY7P20x3cJ8BMIPG3B7MkIkMPpJng7AEZDFDAp8rKc/ED4pkUnwVRgvKJe2n9OAS2LVyFu8EwMr9UyaDarxMyLQOpK/feOKX/8r5RcXo0x0amjaUxufqIGF9M/tUlXbeeebP0YyyhVVB40MOo8TcSYQ4rvpISeNFHxQ5x3CA9hx6/ncVthvm3hsPzvIlQkf2QmNBk61FxyRwE0PmCTHNPLTFpj8ZlnA0zxgDg1HJ+rq9l/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQfwQ8B19qzsewAiPCbzGezxjNE1rBQ7WVb5Iyuo+g8=;
 b=bxyxU7jNWTjTUXXxf/QO2LqhN7Yt8vP4IDv+ojlE/VDWPmLgWRt+eLstPv4sFg7Y5rzP+riQKYhwtGLw5td/swc9U3qauw/mm+I3fQ1bvXmUHEOL8hoMjRh50AOxvKEY4NFx1X7NDRlY+xda3dodC4ecDzsxJP4RxylVF3xN+K6d5Ypb2+IUVJjN83ZHa8PtQY09DiGlTwMjyBP8H/H1+5DeJNLzYe9lzL1A00jlrJ6B9jeIV4drJDTm6mjcYocVaH8yhGnMpgz74gbm0x1YTLKLx9OArhknJSKywVEzUQvHh2JFLfCg/FS5yYuXimX7GQ8BEJTNM6yhYA3R8q8eKA==
Received: from BN8PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:94::17)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 05:13:13 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::d7) by BN8PR03CA0004.outlook.office365.com
 (2603:10b6:408:94::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:12:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 22:12:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:12:57 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robdclark@gmail.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <christophe.jaillet@wanadoo.fr>, <thunder.leizhen@huawei.com>,
        <quic_saipraka@quicinc.com>, <yangyingliang@huawei.com>,
        <jon@solid-run.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 04/13] iommu/arm: Constrain return value of ->attach_dev()
Date:   Tue, 13 Sep 2022 22:12:57 -0700
Message-ID: <20220914051257.10093-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fef873-959b-4483-6a3b-08da960fd2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Bt42bFDcVlRlBA3WAjTioXA9cWq9jRX4jT0+SpBayp5zuDeaj/vmAXNT1C0u0+aUoRyyLzG6UYYB1GskYfIyKGIueEGwzqIwIQnEARL5sxrWZrhB1EOFyFPPqES7e5Bg9zwQRP6UcaQRt0iqUMDWHe7vWI3ablwFd+6ksAgwU5WC3npeD0dO0vadwFOzpyqLtjRTMhbkBvuYCL78ZfeurXjF4iY1x79c4+th8HsSKJZkLo9Lju8yPb+HozIwaLrw7Klu90+x3PIKXCabPAsjcD3Cd14MLcrnw5uFQ4p1LJFK26bYJy1XalH9H7zARl5IwGqdwivuuV+A0sKBuTDj8mKaPpY9sjmWR1kGRDjtlceMjulmSh6PjoTYQIb9c7EtoQTmoabPkbX/IkWHN4t/ocws7Mo7PKbR71XPMDcmPc29j9zmNd0KuG+sc4k2HjyjfNM60uRrWKjKhm4ExfgyBzEJv860Dees+NeCGFogaseOMfrOIeuSaDLAgN7GWuzIIATGOqG7DWVnNtg2P2u0Oy+Cn0CX56pnSzsWeQgGOQa5ZzpSSjgTT58L53ohDkla/RnmIKzl+5oqK02fOLpp0mEawN2nChzJ62BgyBpASLbnYOXzK6L1hj0tHFTKoI6YbxczN4NduVZzcsCp9m5Bv+djn5coWUV+iLl6kuRIkGqjgIYKPXc4gkVz6p6agDnOdfSkbnQbyEukDubWD7PnPvfD1pheYpKNPQ2C0CKCDFXzuSdSUePaGXEJVobPkc0/LcW4eEWCmzuSMJ2jon+1kJQXz8FKy7GlrhMph0acDU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(7636003)(356005)(186003)(2616005)(1076003)(8676002)(54906003)(110136005)(5660300002)(4326008)(70586007)(336012)(86362001)(40480700001)(7696005)(40460700003)(7416002)(316002)(8936002)(36860700001)(478600001)(2906002)(82740400003)(36756003)(426003)(41300700001)(82310400005)(26005)(70206006)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:13.1806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fef873-959b-4483-6a3b-08da960fd2f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure attach_dev() callback functions only return errno values expected
from the attach_dev() op. In particular, only return -EINVAL when we are
sure that the device is incompatible with the domain.

Also drop any dev_err next to -EINVAL, following the attach_dev op kdocs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++-----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  7 ++-----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  9 ++-------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d32b02336411..8b5a2e8de7e2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2402,7 +2402,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_master *master;
 
 	if (!fwspec)
-		return -ENOENT;
+		return -ENODEV;
 
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
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
index dfa82df00342..63a488f2f16c 100644
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
index 17235116d3bb..542fa8c4b6cb 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -367,7 +367,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 
 	if (!qcom_iommu) {
 		dev_err(dev, "cannot attach to IOMMU, is it on the same bus?\n");
-		return -ENXIO;
+		return -ENODEV;
 	}
 
 	/* Ensure that the domain is finalized */
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
-- 
2.17.1

