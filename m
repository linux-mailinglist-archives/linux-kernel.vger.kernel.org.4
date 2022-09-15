Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12C85B95DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiIOH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiIOH7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:59:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2079.outbound.protection.outlook.com [40.107.96.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4611F9751F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL5sbpJKtwwaKGqA9Vm1TiBanQPxX3FCfS0bdeAWmiXVINa1XTx80MWaDHPg1EtWoqsRSzO3JEXLdgtAAKUgWAs498RCHvkJjLtUlz4Okm65sW8LskxFbrcFmYXRnQwfBGlkaHqpFdIb298GxXKDkq2CRD+YTD4NCipWmvibueX2C9DqSLdE9XnAUETzYpxmx8589lAssau9ku2RTYmvY9IyVmmaIl1mBRzlcfZ4awBb96Da3xEobTvxKikptQ/tGcYLXaodl2/BpxUsGxpe/Gnb/dHAJTUKqR9i5s4EuYrlSuTqGbIC+PwDvpVstRjMnaH/T2Wyb4MmOB1lvlBNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfQaMqK1friW6Q1YOcu8fec3/nE/LM+iYWmCLgxzogs=;
 b=Nj9c4QbURjBWZtDiihJxlF+NjOhxXnHY5fJjGdhCp3+On766gkCSZVqvUa+K59Y/tAxsr3bcLVH3Wd3LMJB9lzfLVW7YTLeSmFluQmrAfdG9FqPBMBjxRYNtZ7ArWNeHPXx2CBHbD3puPXMwUxwq/Qtr21zJLstVEsD12DqBNXcT+5Ir2Xmhgc8nsERD0FutKtASsZYmHFu6wn3jbGlrFj5VJbep06rOsQtOCAYFX9w0hOoMYSStd9mmQI66zmo9nlFODNkmUI+gy5McfDotS3OWt+eitsEZDcGZd0sbcPL7xsMzbtp8UcoqOjJ2z3if2DnZCKm71v8YO/Ssys1RJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=mediatek.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfQaMqK1friW6Q1YOcu8fec3/nE/LM+iYWmCLgxzogs=;
 b=C0HcDFW8Ak4DFJ2pbo0/9jO8deSBx+q55I8o+cyG1cMGyiA3LQ5xGwFIBsRa3USDY/bXM1a1UAxSYPO2jqBSFazM9Je2Wqt3wmq423RxuHvZLF018TWU1lGLDRMdgWpT5yADNyRKvBFCIiYGz7DaHlbgldowsciqczbuOwRSXvbfebcZVWgCR/2hhQxH3kraf2xcaVb3hzBxBwrsPdhBICHyQJJ3f+LGrjhKMbClqSyF20WEoV95jIsP1JlvGMtMJO0ldiukKOh5lcoVgoVEpEgJBzWj6ItH6IwJbo5tgQT5hHfWuox61Rz6OyrSrdV9+EEW6XgtkcYlNoAmAuh+0Q==
Received: from BN9PR03CA0635.namprd03.prod.outlook.com (2603:10b6:408:13b::10)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Thu, 15 Sep
 2022 07:59:09 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::8a) by BN9PR03CA0635.outlook.office365.com
 (2603:10b6:408:13b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Thu, 15 Sep 2022 07:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 07:59:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 15 Sep
 2022 00:58:56 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 00:58:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 15 Sep 2022 00:58:55 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <yong.wu@mediatek.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <matthias.bgg@gmail.com>,
        <jean-philippe@linaro.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v3 6/6] iommu: Propagate ret for a potential soft failure EINVAL
Date:   Thu, 15 Sep 2022 00:58:45 -0700
Message-ID: <cd613152e5175b5ffac643ee017b1d800e766d99.1663227492.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663227492.git.nicolinc@nvidia.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: fceb390a-b0d5-42cc-51b4-08da96f02aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lt6HvkJJ3oRO8UoW0Q9Yrmv2nc106Fm2Z+xnYwT8r4PLcO/7OqS47AP3aGF0bsqIcmf//xYzNSxEr94hY1jq+fvke6uu4HZIOWfg1a+9e95J52ZSz15l4p9lvcD82M9HS5EUkhj5SLM20ykP9SFWSnb4LLxPs0jSGDQJS12tw5kTF1hV2vYW4zRO/xhmbqekPs9OJNsntWelEPQ4Vxnfl6KoibAchNHNoGLbKcGFmC5J15oSIPGEcT018FyR/CUcqHeBdH3rZqvf+t6pOInuyL47QMYpNCwF7hMTQWOn6XNAaBj7KWSIMPXpLjNiFBan73rfnnowMa8aGkqJ3LNJHJ792PhX4s1LKXYQh6SJ9WjvDXFkBh+cZ/gb0hpSOpKSxwjJSTxQ8DuukrjhnRElAGxaUf7v6VvcTC03aAfTELZe10rzBGk4gbIXGLw4BPt7Dvqu1c1gcVTBBNwkPKOLsJ7/5MgSihRRDwWvUBkRTZb2nRsM+ngwjUt0l9DHPkdH+kIHYIdryR/wR+wyyEEAoxsr6NAj5VjAAsVOY78SXUwj3QUkljDeJUpIvxkxmXjuz28uW9yL8iMxxIMVUpXK/jC/nxIkYL1YtnwUMT1x/hSARPPKlWPIt5VHVUI5/voPN7vYU0bv+UtKw5/dJ+TRpYGEr20DS2yle1ykTJyGDKqzCBTB+MasIojKkfrmxiYfMjxiCC+17rOhzO5drS9V6QPMVvLQ0UlUtQAjaSdINPy1O/wgjGAHGWrE6x+znb7t/sMkua5X7sxc3YHnPboY8w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(336012)(2616005)(186003)(6666004)(7416002)(4326008)(8676002)(40460700003)(26005)(5660300002)(70586007)(70206006)(8936002)(82740400003)(36756003)(36860700001)(356005)(86362001)(40480700001)(82310400005)(7636003)(47076005)(426003)(83380400001)(2906002)(478600001)(54906003)(7696005)(316002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:59:07.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fceb390a-b0d5-42cc-51b4-08da96f02aca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the new rules in include/linux/iommu.h kdocs, EINVAL now can be
used to indicate that domain and device are incompatible by a caller that
treats it as a soft failure and tries attaching to another domain.

Either mtk_iommu or virtio driver has a place that returns a hard failure
instead of the return value from the function call, where an incompatible
errno EINVAL could potentially occur.

Propagate the real return value to not miss a potential soft failure.

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
index caca0a638c4d..f1ecc5589626 100644
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

