Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9D5B8091
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiINFNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiINFNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:13:17 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B1C46605;
        Tue, 13 Sep 2022 22:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtEaQp3Qy0ERDdyQV/2uvoxTcTQRzTmuqsj/zbxwyje2j/yIgtlu3/ERMiowiDq9GVs2BkYLUXjv3OfXBAe3bMzT13vyHo/CVID8G+GrK506wQ+e3SOomrz14IrkblvoDcjlQav4lnJGJUswsyn9BruxID+gW/5cY4o5yXmo9polCBf0iguM3hjo4UMUSOrXRvGfF2De6mE8dS3dJlNbyBJspdKok8KXzfkVESGHsFGWGXt9sjBlCRTtluG6IZ851eBOFNSZcU8WgV+NT1V+ThFrQmsfxJx6sWGEHP+J+Tph7/wXu7wExIhbCulHWhxYdLGS79aIwqSEHdO9GkpHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unWC6su4TYXmqDEOlDuaRyUpogsCCTes7oHL6iBr7Os=;
 b=ARLUCYq6MP3urI+Y2IiEU+mJJZExP8eSsWjKWQb0YxQttZVgQ5GGEtBV+yABIigIKlu0vJzO3bWPEweVmFr+o2C25gV3f1bz7hFoP0M0hpCuC5p8Kha5KKwDaLxi9MMHevz6FbYptYCxQ6rhLdDsQCBPSFxjIOQ2GyRF2t/7Dv1M41b786+tsQBkLJLDbDErnEvyxiRoBlF8Hk96SbDZCBwoIl1H0GDSCieV1GmFhIfzatQRMqactdhQeodYSrfrws64h2yQM7nr8IR50AlaUgUEmI6O7U9VK4KJSEENtvsoFfEPWyyZKX7LYVS+VH1KJR5NYc5O0CQ/nEydB3pepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWC6su4TYXmqDEOlDuaRyUpogsCCTes7oHL6iBr7Os=;
 b=VqbPWnue0jHYmYFxgybT2qT7fIAebx2xNf5vKjJy30dKn6awAtA87VI1ax6pRSOCk6YuPu2Y26HVgi5KiveVu2v7igKkSjuJW2lw6sgZlktjKWv2c5vn8S8TfJ7cpmEN2efgM/L3/SeqZMPef50EToL4aMpdSyZAWduTWv0mBJOE61r7uwGFnZEG9U3ZaCL07a4IuIi0fP1bYh3/lzE5ui8ZPCDCJEGFLPOUQlBMKS97lFEWEcm4+ii8P2A5x0zAeevbanLOUdNNja+w7yD+5hHCW/9Zu/Pcz/fHxzn0FFFgDx+6gUJdaNaQUqiIOyl6kz3VwYX4KvWYG+5DrPf2wg==
Received: from BN9PR03CA0512.namprd03.prod.outlook.com (2603:10b6:408:131::7)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:13:15 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::66) by BN9PR03CA0512.outlook.office365.com
 (2603:10b6:408:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:12:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:12:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:12:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:12:56 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <sricharan@codeaurora.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/13] iommu/msm: Add missing __disable_clocks calls
Date:   Tue, 13 Sep 2022 22:12:55 -0700
Message-ID: <20220914051255.10049-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 73051755-2386-48e2-de3f-08da960fd39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ROmnzpYnpBpKf6U6BX58DhouK5dc+AcVIrPkoZOinoRyW7DjPHgv7FYOcbSL2eV9ASY4aXVKgzn30isBqJKL/uk+43m12rMA2W/3quscIsPq/PAJFfxo8Atk2PM9zCXtXETqChv7NKC1j77Yrw58eVZvad5JsdbU5d4NwWDEPjq+4TD2t+FB/+HcNKb0WLQFysM793YRRnLhXrRM3aPi8v6o6J3qqqWGXncj9+FO1YaHBHSUp2RIWelm4PiUbZ+GbnYZz6RlUewpYWdCR7NjdFCvl9QNGLnjfhZIbiJAd1ri4CICM8+AYklv2AsZoCA341PXlGKEojhySOG5P1mtcVKiwuqi9o3Y1Pg+ZfAFyUFVCzhHFW8ahS7sE7bzPwFwH5cvV4i2uwyADndKX44pM86JOntYkP4cqnhqxpOD0uWf/ZMt9pkTk2liiDpgWloplb8dNxupPkFxhkS7CTtOnAfHz91r0sKi9ITKvzmMcAGmf6SfkS8sBIvf6N26tdV1blSxIRbnf7F4xg9TNgozZjnIpTgzowClMRlQkei8jJd+LlFGWhfanl4m93LvUMskQQSYcV79cCuz9jAsoVxcE+ha/TDhzhkpIbC22cjdl4g4FpBWOeKH/eNKLT6sUVKi4UdsoLelGzcBW9e/72TR3AizqxksX7W4JNdaZuoMtpkX0Hct4JYRWlDevLY/sFLqURWLM/Hm+hKx2l8CGa8ov4Y4GeL/hYR8iG2AWKe3DjDr1a+jp3bFYy9/d1mEGgi3ySAFEC6E/231efCfsOmDw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(426003)(2906002)(36756003)(4326008)(70206006)(26005)(316002)(8676002)(7416002)(47076005)(186003)(336012)(2616005)(82740400003)(110136005)(356005)(70586007)(82310400005)(1076003)(41300700001)(7636003)(54906003)(83380400001)(86362001)(8936002)(40480700001)(36860700001)(478600001)(40460700003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:14.3133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73051755-2386-48e2-de3f-08da960fd39a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock is not symmetrically disabled in the error-out routines.

Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
Cc: stable@vger.kernel.org
Cc: Sricharan R <sricharan@codeaurora.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/msm_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6a24aa804ea3..a7d41ba4a47b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -418,6 +418,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			list_for_each_entry(master, &iommu->ctx_list, list) {
 				if (master->num) {
 					dev_err(dev, "domain already attached");
+					__disable_clocks(iommu);
 					ret = -EEXIST;
 					goto fail;
 				}
@@ -425,6 +426,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 					msm_iommu_alloc_ctx(iommu->context_map,
 							    0, iommu->ncb);
 				if (IS_ERR_VALUE(master->num)) {
+					__disable_clocks(iommu);
 					ret = -ENODEV;
 					goto fail;
 				}
-- 
2.17.1

