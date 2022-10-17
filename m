Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6696601D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJQXHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiJQXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:06:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10DB84E5A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajhyn/NnBBjR5jNcM50fI90VkbEEN2NdCwBivyqRqVGIdrGhkTFhVcCwqXoR4s3f1hpLigPQY36A5q7HRTvua5RikMCcJIehTzcKsNuw3Oj2lPcuewd5Uorq95aGtgt+mW7gLUp12tX4Eix4clLZyJ5HR37lqpnoJI4k7i9H77zKvO86T/Fs4hTstDLT79C3+V54+o5/pHKYIdI7MKNCqVvj/Z+ILTQ5OqqZzcLWmfAQCXcsRAk7oSFJWhY1Lle2o8N1J4SmFhGzRcGbdWfCp4fCosNBsoSvyqpOFXCvxAwWU/5is3aYpxaxrmWxvpaUOiireQEVKI0UiWxun2QKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkfNKy7kBz07Xahm5eQ7Vb3aISDZT2P21keDziNvtKk=;
 b=IpbK7Ycpr3ZLhAKSLsw0IMzOrgbvbEsYeyuRsZ0/JJeHpJha1hVLdM2hYGzEy45+WhdR1sREokKl1BNEdsDo3+WlT9hrPv/IEXwM/8PmcE9cX5bZJ6wWoCK6C6DygQTkldKZre2R61BC4XLBj+mP6Olj3ziwBRlqgka0M7jPhvpbrVLFGHSNsW7JGCr8GJeSiP8o/NEIsgIcP0Mm83WSSSOGwAfkJU23vwh4HDFFTnHeNdsISIvBz9Y7sIBkdAsrUETNF4KjFhhOwOLfdtDFDq3ltN7wMo2Q5SwUEhEo3ntGdTdX3SBgCyOOCZMpemLaF0jWLFPqc3Y4uNg/Z2xnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkfNKy7kBz07Xahm5eQ7Vb3aISDZT2P21keDziNvtKk=;
 b=WYCkB/WEGSoFA9etL9jfO3gYDY2zfodmuSajFlo3JlT6lVPzppTjr78pUnMfu/cm4ScHPVYYVBa3j9bR46rYeEyQo8ZUlsYytqN5fkHCnUGd1dQ2s5SO5FYvt2ti869uHTH4EIvnjQSrvbaBVH7Df7eC3+lMK+FFEV+e2S/RHUDtLYILi7Ps8joiCGz0V7sOpb538WrC2Um0Icm1y3DoUEjHIsEqrvrMgQiduVkhPB8Qj/mvlfYKseK4XgBQ1xxiHYSQFASzIDvoD1dS6gxH7ctdj8HxQnOonkHYng4XvlemYc61BDHoAuaH7YorBigkj3vsSBXD5fiT9/cmH6cvcQ==
Received: from MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 23:02:46 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::87) by MW4PR04CA0068.outlook.office365.com
 (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 23:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 23:02:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 16:02:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 16:02:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 16:02:37 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <yong.wu@mediatek.com>,
        <matthias.bgg@gmail.com>, <jean-philippe@linaro.org>,
        <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v7 5/5] iommu: Propagate return value in ->attach_dev callback functions
Date:   Mon, 17 Oct 2022 16:02:36 -0700
Message-ID: <ca8c5a447b87002334f83325f28823008b4ce420.1666042873.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1666042872.git.nicolinc@nvidia.com>
References: <cover.1666042872.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a8ffc0-564a-4070-4368-08dab093b488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vregawATSCx03eZMk9lgOypWNxewB8KbG0coHOMXIAqWbztO3WEz5xYv2Bo329LOVq9hA0P8t0LYzYRSEIAni81n8TLQtffl75RuLtu5q7dozsAgO1Nyv8pudGBhtmVGDb7Bf75b3jDoEny+aNOMrOIEHsZStMTBfOQRABgf4Gu7XrbUxReMwFYlAVBgeTl+EXJJ8d5JFPIFh1IxY94GjAb9dPUQni9sLGrTUpEFfP7fipIbO777HspG+d/451zBTXIFIdPTpY+YcW9GB2gf9pmddmKKngZzpd4kxb8OxDlL9OFG4dlRWXFxVgMCnZlx+txQjoBTgy1ynWAjjZBlF8wyqxwaelPVASKp08kivDwGOZ1oaTIkJOPfhg+oZ04t6Kdakzgmes6zt0GoIKfwYDWYRf7KpXoqsd7/ocBOq6TRUg3Rp0cBiM5T7xREWEZghuc/PmT+Dx6XcrVLGKADU6wKpZvBfkm6FhWfGVBY52ADEZUjU+D4h71btXHqsOA2G/4qSPRqKwkC391hM3NM5dnVeOe6LI9Cpb/DJ9oH/81gpv1yvCocmZyFt6WWceu+HbcCWzgiKrxgvgctLDaj0skjEqTuk4atmn9u/wDOmHWyc9byWAUd47SypFmVLOJWffR+rivBgMkqDk4xr4knMUbwv2wfnWc+ZJ3b/eIMlQ1/YkT4LLEGPNiRRYTaiOmTx+NU51xKVQmC4JnbYIONOUJOYVvulYE6fILg3nJ453zdRb+S6VWVUky37Pm77kYGWveQWf5FW503W8ayPMKFhQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(82740400003)(40460700003)(356005)(7636003)(8936002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(70206006)(70586007)(4326008)(8676002)(86362001)(36860700001)(316002)(110136005)(40480700001)(336012)(54906003)(82310400005)(47076005)(426003)(186003)(7696005)(2616005)(26005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:02:46.0919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a8ffc0-564a-4070-4368-08dab093b488
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/mtk_iommu.c    | 2 +-
 drivers/iommu/virtio-iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f3dc2aba188e..660c5296f338 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -668,7 +668,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		ret = mtk_iommu_domain_finalise(dom, frstdata, region_id);
 		if (ret) {
 			mutex_unlock(&dom->mutex);
-			return -ENODEV;
+			return ret;
 		}
 		dom->bank = &data->bank[bankid];
 	}
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 9e0ca757fa42..a204942f28fe 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -695,7 +695,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
 			vdomain->viommu = NULL;
-			return -EOPNOTSUPP;
+			return ret;
 		}
 	}
 
-- 
2.17.1

