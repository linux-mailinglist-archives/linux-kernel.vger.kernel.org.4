Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090095B80AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiINFPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiINFPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:15:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C697402DC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHXzUy9IeQF5XSbrWjlMldouN0v6PkPqcJM12RJIha0n+3gXXtZPEzG1i8WLF3wEeEn4wrlNsmYIHTLe2jRr5ErBwq0PrbcQFZCwJyNnIlhjMb6kVpZd2Kj9i2YODCeBEtOjBVi1II+53DpztJkFHo+Poab7NjBQ0pCKRpw67p/Abj7Di6UvLWz9UNbYWrizKKdaqxg4Do2ULwIdEiLRyQq7DbLdAq2+mYe6bTi40t9AZUbj5Pwrq0P3MI6bQlakSOC/VkiZk40GXwQ5Gl7dGaVSRv+P8pQr2QxsQWKJuUW8lcr1WCGCxoO+xQ6i5HpZ4rr+Q542pCO7pjHlwFJDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4qOGhmkmtTPc8GR3IbldsD9FaZjny5xJgWI9KSO5hM=;
 b=jblRF245VzwyVBZVV+BEdNL7HltcNSiLw+657u2zGfDLkLzSVCFXUsIUlB4nrVzsYMckJcYpnKZpub9RBNVOLATUAJ2yqz45woyM2e8UtjOD62NnohLa82fsdqzsLnvgDNKo6ncPPcD1oCYoWjjZRmMFV9krp/8rakbiEVDcxJ/58HoXBS0SR0N4GlkD7Q4sdKOjRuOp7GXRn8kV3JrXUoUCUuicQf57ec3FIK98ErOJETrAo+yLs3Ud2HtIf3C7RcvnRuAHMwfICrnkb4Dh9h0XqksLJAuJZdo7f+TFcKDu0rs35IHoMGEGAXu2j84LJxZUt6Mh1yGUHCGDuBigVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4qOGhmkmtTPc8GR3IbldsD9FaZjny5xJgWI9KSO5hM=;
 b=kxBFgtf5STpWfT9mmyKt8tM2kX2TkrvmuNO1GAlFCGscQ3DnPTWMqoTL1A4sL41gQM5fCYELj3o0wnHZlN8ki68PcWVRde2EO9rp070k/oiTo617KdVPIQLeo9LPnN0UB/zA5XVH8Ul7UfDFyvsGOeRgWxwyaEq+iEL4Fz//13wFgVxB3YHg0K+7XDokhjMAfEM4OgmJM6Pntyvfrv8mVWFPik/zzFN1g9sUrJ+wCV92esklxNntY5WwkZ5YuSUpA5u2S9lo4z8CKi2t9VXzzD1hEgfxHE7M7Ju0emI3tYfS25l/lkKZPse6vWO+OQwjJFhiUUR771Cx32wh70eX5w==
Received: from BN0PR04CA0159.namprd04.prod.outlook.com (2603:10b6:408:eb::14)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:15:27 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::d1) by BN0PR04CA0159.outlook.office365.com
 (2603:10b6:408:eb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:15:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:15:09 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/13] iommu/intel: Constrain return value of ->attach_dev()
Date:   Tue, 13 Sep 2022 22:15:09 -0700
Message-ID: <20220914051509.10391-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|BY5PR12MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: a43ac227-e929-47d1-2e1c-08da961022b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txfi47JrXsXfQEcBGmhCge3q26n4XRPtRj0MqxZAPG8QfIth0GH+yLYQZigf8s6fcoHCxZTBTPLfXsHqe8WCFTjOyqNhT1FRR37yvdRpCSrfsiz/rDnI12uyKoDGL4fzHKD/MulBP6kSKBft9PwUSzfDPtxM9U3mivAmq4oHQf74OzBneGiZzUPmqTqrzsJttC+XNT1wIS5iWiTYjK4MePJD0leRkI3PeEzwWfm+iqx6QOTDq4UMcsXRhpodkp/EPDEXIaAXnZsADQURP4Frh1v9LxF73S0bayYaMMufyN/ThKx5rDf1Y9JiUTSZI7X1GqeH09zY6V6XegeXg56di5VlKlynCPkp5EHHeO5I+PnUgc58Js48oDvhRL5ome7JZavYcDQRHquTOWcqr4IMibZJIze/KUiNHiuK/BTOiBxn8b2nA/qbmBPeejzlwnNwjoWRcbpcGgswSNpW9ycHOqECcrIGpJhqkHY6lWKXf6SX3BI/CoQOkFeGITTCYdBbPWCjf11Lf8fTbuLHbA30nZmlgoJrLN8S3yTmIegfKZM4u8t491hpp+aLHYEBHHJ4iEwjaMzOjq9QLGVc7NI/gsTaZ4D9+CPUdPTIUHHcRSEQsdej8IxB3qS1zDO5ZuV/Q03OEIJL6sY1LPHdqrowEixpsYjWjrzgqzTmM8DukxxpnrJfitTl84ADACONwEQx1S1gV167KPko5BccvU/9Jv9FHT93MbQj2z0Dqet6je5CssRR/Hj/79/PmteiWbNPFIl3pwIoe4TL7yIKZ+7Crg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(426003)(83380400001)(356005)(40460700003)(8936002)(2906002)(336012)(110136005)(26005)(8676002)(41300700001)(36756003)(7636003)(7696005)(82310400005)(186003)(70586007)(40480700001)(478600001)(82740400003)(1076003)(70206006)(5660300002)(36860700001)(316002)(86362001)(4326008)(54906003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:27.0232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43ac227-e929-47d1-2e1c-08da961022b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
 drivers/iommu/intel/iommu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1f2cd43cf9bc..34a54b74899e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2457,8 +2457,10 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		return -ENODEV;
 
 	ret = domain_attach_iommu(domain, iommu);
-	if (ret)
+	if (ret) {
+		ret = -ENODEV;
 		return ret;
+	}
 	info->domain = domain;
 	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
@@ -2470,6 +2472,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
 			dmar_remove_one_dev_info(dev);
+			ret = -ENOMEM;
 			return ret;
 		}
 
@@ -2486,6 +2489,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
+			ret = -ENODEV;
 			return ret;
 		}
 	}
@@ -2494,6 +2498,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(dev);
+		ret = -ENODEV;
 		return ret;
 	}
 
@@ -4158,19 +4163,15 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
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
-- 
2.17.1

