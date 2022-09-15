Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B9D5B95CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiIOH4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIOH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:56:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E163D97509;
        Thu, 15 Sep 2022 00:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At37551KHQmkLTeKmsASpqND/+tLqP2VgQtR4ayf2MPoB0AT6GnWZJOIv3mG++Oo6owVjKwkwAwpTmKxa2ahP4iuOrB+eXZY+73fWoDt/ojybCeHveetBfz3NmS98KSvzB4rzMqODGL+v/Y9spE4GKV+UKNhepN21Tb8yXspbQVgNbYZhZKZLs5+XWYK8bo10xu0F2Ua6lFaALh7WOVK0/h9jH4nLux+c6RFDdMKaoZ9W7NXls2yGckcN4KV+a4m6n/O67Uco6FGZDuCkbSHaHm9/gsdT8qXPW61VLp6Tjoa/jUqEd07DnUIjX4WtwhnzDS1w22bEERBKtt/HmCPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unWC6su4TYXmqDEOlDuaRyUpogsCCTes7oHL6iBr7Os=;
 b=GWg7hdPMQguMPxR2kxYIzibJVGKA7hVNxLyGpKcSW5Ro/9rWO+s1fGvVn1PbVhTx367zG+8ZkyPjCUU5768f8SKhp+efRy5EWNYbJlIljOaNR4p8nAqHBX8H8S+cSU3g+ba62udCOUOtbRiT5hsdK2SQ9aN/Wxt42msU3mDWgLLFxL20T+6bAq5dVc3omIFhwyPSWmznLUzckvcBdzPurjI+J/v5IyR1GyzzbHUB0vyzLfYybIvGnKpcKiFW9rQA+8LvDFYrHAN/kjOpowA+Haw0GsEFDBoZGFS65zWva1cRjojUtWrUN3xYEZ8qQRIoSQ7MbowfYNm4U8Z451H2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWC6su4TYXmqDEOlDuaRyUpogsCCTes7oHL6iBr7Os=;
 b=GnmFA2mSznbjKYM85BUNOMIiZId9XG+Y+jF7dXu0UKhG8nyUlBVjjTXt7AnNeNn2JuDEpM5NOYzU6vqkXVup2g32cpjS+Nhd2wqv2ElyfIeb327V3fusZMyatsc4Q1Q1BLlOPFpIIX8kRuNU2pC0YRC4LlXqjJn3r7TGXbVRavIx1xmDuUVNj/PGkrbkbVVgAO1hA1IzPRNvf/ykXm68pCcp21FMvxosRk9SgDltyla7NQp/XnHK8QcRsNUJ4oN535NFUAA4toAI4r8iKDiCB3GqqquXHY5pTm7jZsXgJQPgaDhOWA7Enf51d4KgpwzPVPQC7P001+pNYXcCjR8bdg==
Received: from DM6PR10CA0020.namprd10.prod.outlook.com (2603:10b6:5:60::33) by
 SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.14; Thu, 15 Sep 2022 07:56:22 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::1d) by DM6PR10CA0020.outlook.office365.com
 (2603:10b6:5:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 07:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 07:56:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 15 Sep
 2022 00:56:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 00:56:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 15 Sep 2022 00:56:14 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <sricharan@codeaurora.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/6] iommu/msm: Add missing __disable_clocks calls
Date:   Thu, 15 Sep 2022 00:56:08 -0700
Message-ID: <031c4ec032025a299d72665118d58dd48aa936ac.1663227492.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663227492.git.nicolinc@nvidia.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|SA0PR12MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: fc126afe-969f-4e97-b831-08da96efc848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fa00DKS/Oj6/RioFyY8K171XJoFv6l42ykQhyi0Lxu2qmAdWEGgWwALZJM8RYRlRlidSmKqL6GqZKr6+FdrPDTos7SaGCAqTlB0W+/XgT49F3xDXMDBe5omB22dUUJzczVcT9jqIdS9RMPFgd0OeyhcpigizVDO1/gDbjTIB31gUB6KlJEzQ7BfGF51oz4ISxx5fFrZz2Tc50fMPxVkd0EnVa3OS9g27MwRyndlLkf/aEpHbsay+UGephBt4XPhidybuGsc2LHrZvowuP2BvtCFbdheYwPcPhQ84PcmtfNQ/vxfy+BY0OlKAZKb3thOtCTrQyWDwIXJ4YMgE+LwSIPAzo5cQARVsqmtomUNDB/6lQn9tmFUcE/KstEJqscr8qCQ/+cGQIauVnqo1geSWrCfeKYX3Ns72f65dByJiEZ5PKLkxvzlupBH/EM/HHne6ZB9PkZGdhgAFHRPdertAgt/dGCCqCLI2KzsWiUr6253I+mj/sSf3hwUUwFrS1HCUx6FtsdXsmTafucInN9AXBcA0rjBvA0+Y1XJXElSUCFrxe3dotd0fDwpM5uJHTnYgKynIzgkxvBFQR/KgXLDAS3XHnxN46CDZQQdfS9TGC0fi5HhE+5p13qzrdGaAFdSAaRGPh+Gs04RtbAmUBmo4D1RvKEIJH+ooRR04/2bbkEW615ICfOqdek7KMoTUH58j2VfoiC3wjYbFGCpG0YH2sqFiCGPjNGe7ekpRVP6cR0JBi294YRR52WUtO68k0tstSTM4c8+1uGiUh6WLjpvdpw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(47076005)(41300700001)(478600001)(2616005)(426003)(186003)(336012)(83380400001)(26005)(7696005)(2906002)(7416002)(40460700003)(70586007)(316002)(70206006)(40480700001)(82310400005)(4326008)(5660300002)(110136005)(54906003)(8936002)(8676002)(86362001)(7636003)(356005)(36860700001)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:56:22.6499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc126afe-969f-4e97-b831-08da96efc848
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
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

