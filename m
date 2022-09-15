Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05955B95CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIOH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIOH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:58:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028AC97504
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRXLEGJWAicn5NUQOyu8ag3HmQgir2PqHZBTXkol2fIS1HkoPdg6dZhSoGAiFq8q7Q7AHs4ugLExE8qMVAxa63smZlPGwF57J9xUW9J7PG/QbWBoxgkKp363TwLjI9tP4VUqTWmm3PDnHR7xe/Z77sRlU6ylw+7dBZf/8bzQqnhu8wdyTg/A3W7GgsxPbqkgGEgOCPh16fWyTQckMsbb9DG4W9KnDW7GMC3MLz/X6D625lXdrIpn9B00Q823BNgMaT+uCoxBy0mBr0qZeLIIpzVo2AqP6sgLYHlKSwovdJhul+4RZRaPN1G8bzSstRFDWdosKFSJlsrY1kW6uleJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGcXU9A3YFr5tH9FN/uC9AtJ8o+Ku4JaXjKDFv27XyA=;
 b=EJwQmmC27LEFQ8FrAX405C+uOLnW+QsDvI4CQkFWSm4niaAM77f7UHaA0QuIIOCskegeAZ50gVlDK0+Ggz3eKh/nFqmdN+dePVl2kq+rWkU1k5jvuxNs+FKL9Tc/bWu7g7hCdk/zZSViujkMF50bhDgz2D1w3NdxYo0QyIKIbeAi9QdCOv0ZE7UYq9xcr3YhY6QzNymXkfFMMIlvounaQt9fepbWIF7FDn8R1hL2OgiDdgj2flH7PJFGqOxtgPtqBtuTkMAvzpy784Yx44gCQW1PCKm/3oGuR1IbCR21/CxcDO/gjEUfPbX7TlgcBltnrHFs2OvPASQlOmVgrrfRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGcXU9A3YFr5tH9FN/uC9AtJ8o+Ku4JaXjKDFv27XyA=;
 b=hGQj2JJImKkXC8us5BRW9SvH3OyHedqBHQ2UbVE4cInjO5NetwNHoG/GpUNJJ03NzB2aYesbYRNHptTqfPGdd3iXdUcpriLD2oewJGr0HODVNHuCvNLgZiSpRNml1SgnHxohkw3/CMe4wMrw8vm55HkuIf6cCLHtgw6XR96dyiV+8mJkvdYP8YbuTOkX87wQwF4fbMtCvmDHQTdaTXOUQo839XkZfmjmDOuShjt3GPY0TfM9sbPEROSpLzW7Vbv9ER6sCtGMHi5ixs7YRpiW/5UbqGtgELbRbAE9tyMPiPiljA9JC+ZKUenub3y/8KiV3AETSMcVU7Z09W0vwCx3wg==
Received: from BN9PR03CA0335.namprd03.prod.outlook.com (2603:10b6:408:f6::10)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 07:58:35 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::e4) by BN9PR03CA0335.outlook.office365.com
 (2603:10b6:408:f6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 07:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 07:58:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 15 Sep
 2022 00:58:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 00:58:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 15 Sep 2022 00:58:21 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/6] iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
Date:   Thu, 15 Sep 2022 00:58:18 -0700
Message-ID: <1080ad9a761272a370b04ae65767447f715ba325.1663227492.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663227492.git.nicolinc@nvidia.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c16506-598d-4b21-7bef-08da96f0175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOdeJM7ZWPRa3+WWH02ELm/l7TTcKEPbk42Y+dyVvPJh1t74AOawAoG2F3jKbeq0FceOhPra6xqRQBZik5hJbJOryFtO5MFjUbQPaoKbe9YNt0wJ/m8IyJqH9zE0z45tgUbsEitRB0BZoxyq7BrztU/2xn6tZ4st5IRE/xQAwH1rANRos7tQDBZcgmjNaFscEAfcaglCPBCWxnIG/2UmlmZXqMVHio7gAZ65WvuRvz1lSbiFI4F2S0lejB04I79USeKO6oDiAlQ/NqlHk4S7HamVUgbIxD+BsU8qGRpAwqOVCOA3u2ImznGaIzwQkS+NQA8ui6wLmaYfSrMuHCESBmtPpdppSqpsB/U0JCVXtaoAPDAWN3uJ+RRDipxyFMtilP7HzLbGhxod+2zduNp+3Nk5i4eB3MAwJo6FZIcP9xpcuF5WdpAq8h1kT22VYxCG7FSsnJo69LV0T7vQcIv3tNcZ8xu063DBwS7cyRAsviIcZVtRCixDskkt/EOeFt2PwJxsTp9MSqiDa9HKxyqzKgw7cvlpZ8xMpmHDKXBsKJp9u+J7xjggD0FL6fURU7XHZlfOQTeKBmicgHUnQboZMMH6Ife7fwFibblE9oeH0lWoz56fIwBlEsuS1F7c6PeRMsFn+vMF0OFZb3FsDabQU/0EFdt1MMIKMiHVyIXkO+CErdWQLscnA9h0SQxIrOSC+0CN7xzLwBRbl3W6ohTBkK0B9xrlqhWgpp13fqdh9SQLtnEnNyOaec3rPUFf3CpSvFwW8gtdvK4cFFnutOXu6g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(26005)(36756003)(40480700001)(110136005)(36860700001)(4326008)(54906003)(316002)(41300700001)(82310400005)(70586007)(70206006)(86362001)(5660300002)(478600001)(8936002)(8676002)(7696005)(336012)(2616005)(83380400001)(426003)(47076005)(7636003)(356005)(186003)(6666004)(82740400003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:58:35.2610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c16506-598d-4b21-7bef-08da96f0175f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same checks are done in amd_iommu_probe_device(). If any of them fails
there, then the device won't get a group, so there's no way for it to even
reach amd_iommu_attach_device anymore.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 828672a46a3d..930d9946b9f7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2135,21 +2135,13 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
+	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
 	int ret;
 
-	if (!check_device(dev))
-		return -EINVAL;
-
-	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return -EINVAL;
-
 	if (dev_data->domain)
 		detach_device(dev);
 
-- 
2.17.1

