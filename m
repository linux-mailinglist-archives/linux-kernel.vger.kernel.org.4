Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D05B697D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiIMIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiIMIZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:25:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D8175A4;
        Tue, 13 Sep 2022 01:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNWDERu5Ic1D438c5rFdMu/LL70WSHBJNQyN0kf8aPVp9WQSat7J618tnldVWg0XRjv/1tWYu8fA0uDbnM6HFJN73+twjEK4kq1SMfegrY0Qke/mrFiXstJgJaZDfUuTxmcgEPZK2CpsGiLbbXHa/4xfk99TtRRmxIxfu6nR2cJ9L7G3RcZxXLP5ZgGjfwzbluwxV9Q+++92TAFbsAr9r1G+j8Vr1ZkI8mBp0YJv9UPNn4DZGr4MZirpx6EN7UwctdnwYw7u2bEnDhMoeJhZgdDVJi6PRSZJ8SP5bpTp+E4Hez/R4wePnicUInkX8XamBXqWZtqqalnqnr4HrJ5DGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unWC6su4TYXmqDEOlDuaRyUpogsCCTes7oHL6iBr7Os=;
 b=nlgJHVECOVEGbtiO/kHgP9OVtooLXla3KI8jp5N56tgrBcILkBnUCRsJRC9ISX2AcFR3V0KKxBQcgJD1/rzWnt8NeowLRm4x4donSYVInMgO+QGMcP8P9mtdfzutMaJZ9Hq78oEjlME2lnEdRi+G9U/dx3ujBXtHGPfcB3E5sgRbF9TDSSh5AxAOU93AT2+zFLhipQi/C3CGBikdS2U7TS7O1UpGYJPMdtb8rksomyP5ygwFYVSINY504Jkxr2CnvRxBSTXi48nslTkYr7WFeXHeopRWT2CH4uV1yKW4fjG39mWbXUG3/VVocS2dk7EeyH533Gg2qBtcp7tBJwRbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWC6su4TYXmqDEOlDuaRyUpogsCCTes7oHL6iBr7Os=;
 b=T6uTKa7/Zyq+kVhXHMV16JYaH8YNyQPALy6pLFBlDIIzf/+kj70Vs8qtIE24DdrJCFKJqdxwHFLKIynXDrYNyRWPUOSp89XwxtehXsY9DOX9UICbNdnNVm+K1jigP6P+JpM8JbHVcF+Ash/km3UJXsvH6ADEv//QHnddTPrd6wzy2g1pvpsMnyvoptrf4NLelZRRyB3xOXUcT8Ln3Q5kRN8bj/F7g5yrqNOCMpx6D/7nh37jEit1tb4JRIgzUnr/3SuYUsDdsu4woG0HkAoLhlVmAk1LjRPV18Hf35HOfN2bfD+rQ2VuidlWvoGWBHvFSzkNy6INmcoH/zV8zhu29g==
Received: from DM6PR04CA0021.namprd04.prod.outlook.com (2603:10b6:5:334::26)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 08:24:57 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::33) by DM6PR04CA0021.outlook.office365.com
 (2603:10b6:5:334::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 08:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 08:24:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 08:24:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 01:24:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 01:24:54 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <sricharan@codeaurora.org>
CC:     <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH 1/5] iommu/msm: Add missing __disable_clocks calls
Date:   Tue, 13 Sep 2022 01:24:44 -0700
Message-ID: <20220913082448.31120-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913082448.31120-1-nicolinc@nvidia.com>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aab0ddb-ed9f-4596-e82e-08da9561716a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /T5ilKBQ6RgvNbgtzksVs9px3xVmWgQMKCOi0OhstYeyHYRM8UaBxhnpiHcGrb/0wy4x7JJGrdKsPyHmrbW7W1/iZlOA38xS1zs4V+qbmdMNSAFXrBDLZ3wZX/+AHlvw2yGSo3MrgJjQnMPHlmLwWd4dyPNYsSFz4UQsFZrwXMY2LPWoPNgVtUvV3s4un5Fh1DaLLPiIQxbJBmPnVmSvpRmGB3pcedoUUZNu13mQKqrtnL0Wxx+ysRRQc8Rn9by6Fb4zRNoNoJHWC6ed9gpPcEZ5zF4t1gEVnjD0F+1FalUnyB8zf4WRRH8093hoX0seSj7TiU9Jldjs6bQ1VQXtm4ReIIiHQUUrHZcwFYBxHaB9A1lBVYGEGHhXysqr0JvbjO9TZipGLQRDPuZWfCZhN6gZPrOI262uVJx43YalzCmd6IEqm0waQ7+qCLEkx8dhANUL3rfJuCMTZuvvMb8L7DkDHwVSxCeZuVeY5hz41CJNaObmiyu9yZoqwmoG/Tsfry/50A1iIB3x2vXX3rg6jX81txHEs44e+ND8SRYkwJj3NoKNiGLjTJ/3UJQAt4y/yonsmomm5zIcwzhPDe3pZbeugP2rY3ld7ezMg159omcZimBD7aSnzoWh5WThzfhove8zTLLQTFCWx2NrH+OJzFZaM/dv4L2juPMZ7IGyasHfQhAItUOFi3FUlbY6H4BU5VpO9HP7SEhqSBR2GVZF9ylu7NHRyG67e6f1sIxu+2csJNBzS3Lbr7IGYPec632aXPwLBlH9ntiM6prBQIbeibODn4y6FSsz+PWy9Ux+kHQd5WxTVs09THGdYgFGAZDZ6beQvR9lvmNoNGa8Q6PSABIcSgEFv/ZpM6meJ5wbgqloRuwURswKQH66cdo/jf31
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(186003)(83380400001)(86362001)(82740400003)(82310400005)(40460700003)(2616005)(8936002)(1076003)(7416002)(316002)(336012)(8676002)(40480700001)(36756003)(81166007)(356005)(4326008)(26005)(110136005)(41300700001)(7696005)(36860700001)(7406005)(921005)(2906002)(54906003)(6666004)(47076005)(426003)(70206006)(478600001)(70586007)(5660300002)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 08:24:57.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aab0ddb-ed9f-4596-e82e-08da9561716a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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

