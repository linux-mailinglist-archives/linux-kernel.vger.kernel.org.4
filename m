Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161595BF917
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiIUIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIUIYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:24:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437920BEF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC0OFVJtrAgbuZeZhnhxEbaxPauqqEfrQKQdM4ELZpHGnlbPBqT5kp9g0XtUdklsoDJBLKh8Xm4ukffKbtBZYGZGJrDdb6Oq5+c4m4VqcIrQ9W2D/YKMAh23e72jH89LljfMnGWBkJ6NqhEDVwXJquDgugbCbWf+3TyI7zTTx7HoDjnPAK9w4TmwwAotIRc3tx016YSaNu9BxSPxMHB9rALzzJMIY8BukLRo57Kams1oMF05RsDEAwRWuBZ/Uy9SKODNeNTjqcbgMjAHXibO5VNjYyfSo0E2712wakH6wM517wyCRJogTLKIqJOSEpHS3pwHPxdx8yrsiXyg2SdAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FBAlYTbzpv+ZVa52FA+ghPKRnXlfos8t8xo4q6govk=;
 b=PonVzlQr2l+P6urB0kbPZYLeQmPX1w2Uel2v+/o8EG34pUFGMyUZOAzo4jaMJ33qYZ2P5c68EfXUzQioEO59fPSP/cgXPmul7UmHHYtj6lafPP72G534RrmwFUGVC2AAtyKQDoxVS1kqUODxm8/ro0U7BqgnATUMfHmtA4FBR0+XVF0PDw3gciHnMAUJPpO6w3s6Eeo9aL0JOdug3JnS2jMa7EuxpZLwAjp2NDJBVbYKE35BehRkAe9wkjbAzKLQisrNg5oC8aR7k6TdDzsP7SUY5knPxXf58HKN9gS4462QGlU2hzyUeNGkXP1a3k0Sj39NEnKLX5qTaRSmZEV+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=mediatek.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FBAlYTbzpv+ZVa52FA+ghPKRnXlfos8t8xo4q6govk=;
 b=BG7AHOU5rhMGZlhtVVcLib+ULEZ8/QloYi8GKIbHY8XWflvJy8eXwfmp9LBHkldg1Da6r01sFGnS4xrAUKKAeAeiFL8GSoe2geuqKf4wtxCx9LOQAfYNiz6XNZWXqMyYWj/hwax7hgaTWBClfENvLLctIr33D1m5tqfO5Jm5btWAi98jAhHmggeyp4mBEupCwg1sOPZLcei6JNRfr4mejyrkAfU5cbxmr7EehyyWmU/fFYl5kZV4GlByNgwf5WewoAb+nPLx5CdFYqfyBfY8dTlS3w85CmdkVcPVs/rGYFrEqjpbwpGLuRQYWqC3A/DyMjl8Hf8dXbDfvpbqo7NRUA==
Received: from DS7PR05CA0060.namprd05.prod.outlook.com (2603:10b6:8:2f::13) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.19; Wed, 21 Sep 2022 08:24:03 +0000
Received: from DS1PEPF0000B075.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::51) by DS7PR05CA0060.outlook.office365.com
 (2603:10b6:8:2f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.7 via Frontend
 Transport; Wed, 21 Sep 2022 08:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000B075.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 08:24:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 21 Sep
 2022 01:23:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 01:23:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 21 Sep 2022 01:23:53 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <yong.wu@mediatek.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <matthias.bgg@gmail.com>,
        <jean-philippe@linaro.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v4 6/6] iommu: Propagate return value in ->attach_dev callback functions
Date:   Wed, 21 Sep 2022 01:23:52 -0700
Message-ID: <821361c6f523555cd33f0982d9fa2e1e9db70bd5.1663744983.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663744983.git.nicolinc@nvidia.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B075:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 02397e8e-c7b8-4b57-a5e4-08da9baaa493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CijtECgqBsGDdx7DawBoRTpRSPYWLnRJYMX5CRfg5Z5iWNWXjg2FnDG6ZOUSfE2a4g8MLbpF3vwo5ocsXnOFDR1xUULlDeMRw0bNEIjpxjm7tXDwdR/qp0JP69Z8OS0o6wkFApWDum7+QmJdLc3ZNJ9fs1EWkBFWMA0K6ompawas4fpWaV3TTKbyEhM1TWE61FXKFbjNLnftBFraynsYdoV/b1pATGErCQB+hTHOdU9U+/Fu/0yFXom2P/e4moTgk0oiILB+yTWMw7H4Z15t+yhgIMf5G/R/4UYg6eyUiJIzEcfEjHW1IDNmc5WQ3aBxxYDyRFcLO+IRzDVuziioFkyJJZc2kMbMIV0PO4+Zt9SrWSgoNBGUkcbRhmBrDZjnrA7sWg99WONSVahe2c1I/18WOBiAUdns+kCdQdTHw9utDHx/5MJD+/5pkRcDHCAX1IYoSYQ82Z9y8630TjeLL0vNcsa2ne0aYcXvXxD/fQAPs0xnn3t4Ga8g0ame5bGmr6YPFDhmjj1BcPW37a3jeNSAFac5LItfNMnsf8D2ThpogwNoYCVIf53KaCrw0aQ/RqKJgRneU3jkKkXK9zuVzaTzXRF4H84dXG12Pt/q9uVw62y0qEJrUaBEJ2e5bFcTEJG7usq861g3vSVyWxtNY+S424s3DI34ecLwNsHrKHgwtI2udaVrUOMq0hYNcvg+MB5vTrfIwZRGfI2lrCbemFRKp2BdLakz7UTkRNEuZJ5dllb8gQcjuhev1jdJhrXn3EZX2ic6RCb/NN01KG/NA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(40460700003)(86362001)(82740400003)(36756003)(356005)(478600001)(5660300002)(36860700001)(336012)(7416002)(2906002)(186003)(70206006)(4326008)(54906003)(110136005)(8676002)(70586007)(8936002)(316002)(7636003)(83380400001)(426003)(41300700001)(40480700001)(47076005)(2616005)(7696005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:24:03.2669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02397e8e-c7b8-4b57-a5e4-08da9baaa493
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B075.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_iommu and virtio drivers have places in the ->attach_dev callback
functions that return hardcode errnos instead of the returned values, but
callers of these ->attach_dv callback functions may care. Propagate them
directly without the extra conversions.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/mtk_iommu.c    | 2 +-
 drivers/iommu/virtio-iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index be1a7d1cc630..c30dc8f81778 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -666,7 +666,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		ret = mtk_iommu_domain_finalise(dom, frstdata, region_id);
 		if (ret) {
 			mutex_unlock(&dom->mutex);
-			return -ENODEV;
+			return ret;
 		}
 		dom->bank = &data->bank[bankid];
 	}
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 87128266b6e3..35de7b433b17 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -696,7 +696,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
 			vdomain->viommu = NULL;
-			return -EOPNOTSUPP;
+			return ret;
 		}
 	}
 
-- 
2.17.1

