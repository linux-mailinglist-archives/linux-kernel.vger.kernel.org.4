Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215605B80AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiINFPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiINFPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:15:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B53D40558
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8nkZhjf3C6B0ZXi2OOQL4wfsMMy435tg9RgCyERS5xOJfFZ0EQXnsowOrdKpA3ApMKEXaZg77zMJH9bx+n0B0jvT8F0K+PKgsgQKsP/RixKoI2Am8vZJSiAFCyVnRCCZKgM/xzhcf8Taq9WLoTDVodc9Cqiczxbff6dRq8pLqBxhFgbPWQXpGTk77mzSLsxyc73MvlTgsfc9fXrlxMZvnoRabf6N6WbqNyAFKRNDhwa48foQSyZhd+P/Yc1CmdLWCXp2/SwWP9CSnH4FXTatxI7wvvjs4oSbis4H++bV7doirgWDv/C1Z4NqZywt8eLoO7yREkftS+xc2HR4WENUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wxaUJIbGhCHKiJ4xA6f3ny6iEHUBuskYU3dRTGQSQ4=;
 b=BcAuY3zcMqiq/wZS/gWKimpkBXpkS5Gc0K9LVMdRelzq6+IEUoktgUfjDekF8qAtlknCopoSvZpj9JIhnfRB+q5EUQwsWaUYKr/8g1lzCX78g5mFg0l7CgRIWkdg0hOcwFHf6rETzcNmhRp+SPPaJVu42kxLALaG8RufYwyb33vBqHIgRItr4GbfHi7VsX8PZtVNiyXqDSLtrqsDCK3Xv5lYln60M45GEJ+tP55q5+psV0x40g+HDL5c6+6A1bFqMvwJt7pJdlB4xQ9VGl1dEcM/MudPatvpKJ/3i7Ue8eq63eFbmz73agRZC68QC5epzxMrYsxyFAATYGCuW+Amiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wxaUJIbGhCHKiJ4xA6f3ny6iEHUBuskYU3dRTGQSQ4=;
 b=rhDZsx2nddciDzBFAF7FmQOgPP/2/Zd5SIIxKIWzg0stbrkmB+TS735oDL3hOU5Zl5NMlr6HfjsPQYaocio4ffv/cHwI0ROQcNI/k8FVgt6Sm5IrxW9kfIb/xargjJ/YTwnmETwc34u2lOK9CeToouMOR7MuBjYN73syJSKhDCeQ4TxnO14Rmm+n5krf7Z6cnz1ydqsa6S3Q63ySuvg+ZBhe3YJ4oRfBKOyFXZw2ZuuQJqoM77BmojLH+ssqOhbnPDSXWQCtNE5F7iL0oEFx18Y5PPDeAO85V6pyYo46evWLSPtbxMwGdN7p7rWa2Ew6icEaWqX/KifP+JTnzTlqUw==
Received: from BN0PR04CA0152.namprd04.prod.outlook.com (2603:10b6:408:eb::7)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:15:22 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::17) by BN0PR04CA0152.outlook.office365.com
 (2603:10b6:408:eb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:15:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:15:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:15:04 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/13] iommu/omap: Constrain return value of ->attach_dev()
Date:   Tue, 13 Sep 2022 22:15:03 -0700
Message-ID: <20220914051503.10348-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914051503.10348-1-nicolinc@nvidia.com>
References: <20220914051503.10348-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb23ddf-7e1c-451d-be23-08da96101ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiGG1wbMZmXtSStfv8aqoDyLNmMQ8lrHfSVVXRSSC/TcXtGSGXipIRc4vLyGkwd69JXhAyl/7gay8EdU8zWsEx6aB7YZa4nJMeXdp1XLNZXaVkGtBMXx4OHeaIOzfH5PBANZzFQF93W6khr68GfI7KqTBhsevBfNF/uvpZb/Cg4m6yGJvZsctlFUtDX8OGedLHwBnnGZCrYFc6BJLHqm6QwIMkRJCuW3FtdVFKxVW5caNHcmT9+v6PrIZg9NRmuG1WPafI4IRPBnrQ+s5MPz/cP+Yw9MIhifEWN5L39ioKa/qC/1qeHrlzGPSi1E/ygYN2vCWDtjy2EzoCX0Iz9RSTonKfO3gMUzOhfXYwxk7Qa3b7t1tjRY1W2vdm3sQBBx8rlnO1yIhr/YbNuj3jZfE7vtvapgb57jJ5ENVkm9miLesJ+6SIyTA9H96FlE1GkAsv7we3iecfRI6ccqVD9lFdgTPd5dUroW5Ax1rMji9dJJEdfHrLaiY5UDXxfXBrgmpYNWjN1SsxQYCrg8gq3E/L44+SwawFMF49+DjfpmM/vgsYUX2pC50LoF7xCOtQPz0ar58pN2MTeSGIW02W5OK94kALKPwxWgZCJ9PxxEXAMfDViVvkO+1x+gyOhpQHZU3/LHFveyKAdcygQoRGRWMCU0pdyltoLWSMIIlCPTHqvers9ioXtoHPqy9amCpnDkcfGmDTwQRPw1E7DIsT3xbZ6yzUe+gRVLUvXN3ahmXvCy9RgJy/0uX/E83bv147xWION9fv218Ys4mfwNDW3GLw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(8936002)(82740400003)(110136005)(36860700001)(426003)(40460700003)(26005)(8676002)(1076003)(70206006)(478600001)(7696005)(70586007)(186003)(4326008)(86362001)(7636003)(40480700001)(5660300002)(2616005)(82310400005)(54906003)(47076005)(36756003)(2906002)(336012)(316002)(41300700001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:22.3673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb23ddf-7e1c-451d-be23-08da96101ff0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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
 drivers/iommu/omap-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d9cf2820c02e..e97ebb2c0133 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1464,15 +1464,14 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!arch_data || !arch_data->iommu_dev) {
 		dev_err(dev, "device doesn't have an associated iommu\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	spin_lock(&omap_domain->lock);
 
 	/* only a single client device can be attached to a domain */
 	if (omap_domain->dev) {
-		dev_err(dev, "iommu domain is already attached\n");
-		ret = -EBUSY;
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -1480,6 +1479,7 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (ret) {
 		dev_err(dev, "failed to allocate required iommu data %d\n",
 			ret);
+		ret = -ENODEV;
 		goto init_fail;
 	}
 
@@ -1490,6 +1490,7 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = omap_iommu_attach(oiommu, iommu->pgtable);
 		if (ret) {
 			dev_err(dev, "can't get omap iommu: %d\n", ret);
+			ret = -ENODEV;
 			goto attach_fail;
 		}
 
-- 
2.17.1

