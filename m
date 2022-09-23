Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65165E74BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIWHTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIWHSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:18:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5312A49A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGXNqFGhOknuEPMYgKZZXbyaVgtUxmZWafkMktFCke7GVZ8VsRzHv0bOYyG/42LTWNAp+TXSqtG+mOE5wjuQbFWrZj7SAHMOwKFp27w2qGGPIH14uMPSNQoYKeVDN+NiHsC/LDh6eT3bSc8olprs03GCmF1iCUXxNPZ4MlnrNVrIfm2yNhYsnVPpIxc5mcYtsyo0k0fGAgQwVDmAo3JShoE8cnTsSr4u2xmix/MYEeZ8RAIeXoaxwYNhEko8LSr5gOy+eoGb4Txb3lNe6FBj6g58gytfGlfE7ti8hkyEYmNUF7X9ueaS9VGiv8iRlI6xUNmdyl4lAlZlPfV0dtQBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbfMwAYwJ3pKjs2uyFVOf7om7FtU8aOpQYMWbXrhj4w=;
 b=IElEDt8NTAO5PQPDg0zHFocjyr2eD6KQmabKMKbW18yLfazqE91A2NC9vugnifktVDTqEtnN7zL/XEiKSnaDsNGSwYeO8jDE3VnptXhGQGcvrc7WtfkJHRxY6d2QbO9fGbmln3t6CZa9sTR1+vYMlNRnYNy+z4mj7NwZ93HiCl7Ap/5BXEdKsVaB2WkArse4n498fZjPeL+zNXVTN5PWyaJ16G1uyC6LX7VU/AsM4bkXf+PFzRdQnvblhgAD/c7IpDYvmd0c0SYYxiiUb02yy3fbqbFdj7tarsyWuLmiNzyLek94nwNCUhQgOemQHjCOnteJ1EeGLcjJPJv3fgGZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=mediatek.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbfMwAYwJ3pKjs2uyFVOf7om7FtU8aOpQYMWbXrhj4w=;
 b=tCR+kIa8CMMHmUOLeF+K4mcCoAScEPHbbLrjhUB+40XGFwFNySXIXXHjwYc5zxjDwmbqPZgN0Kd70YqUkpNfQC2P8P+EYTRw9pjup5b8482awAUBEUSiKCfH4AkhD66MIsZm7A0F3hUOJZKFvAp0HgyzzmMt4C1+dSMmmGXAwwHEmzVWZf69TZxeF3GcqerK49UBGhdnNaoAwAXzoXPfOSR1lPo6J54sj+tjxreWbky7kpV7tpNuqDwjR2uBxE5ECArHfLJRg1d7VOcN8vp/Rsoab0Qz0F52/4bXM0aTc1bf4BsuquozqLt1ABnO9slUMvVXQ2GRmnsi/IL/S3Nyrg==
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 CH0PR12MB5170.namprd12.prod.outlook.com (2603:10b6:610:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Fri, 23 Sep 2022 07:18:49 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::c2) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Fri, 23 Sep 2022 07:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 07:18:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 23 Sep
 2022 00:18:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 00:18:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 23 Sep 2022 00:18:29 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <yong.wu@mediatek.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <matthias.bgg@gmail.com>,
        <jean-philippe@linaro.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v6 5/5] iommu: Propagate return value in ->attach_dev callback functions
Date:   Fri, 23 Sep 2022 00:18:27 -0700
Message-ID: <3b5b29b735dc5e5f4a047262f91636dbee4af981.1663899032.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663899032.git.nicolinc@nvidia.com>
References: <cover.1663899032.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|CH0PR12MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c66298-5b29-4967-334e-08da9d33dbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0o94C4QJWK1wE/DNwRbXQQk9FZ0B+3yBD1MxZ/1y436hxssO2xLRBMgF90byYJ1uqaMdxnpbp38n8WLDQ0KdQRmkXDRonwm/v4iHS0U4EP0UYwnjxFRO3dX0NJlZJpQuE7D4M16TJSN73h/Dnf5M6eN+rbY7Y03VMVikAYxkACfOiFZR0qCtRFEzkM8vDGo2jLqsCAd8WzBd93ulzcbjSPBhvrGSD6ElyuZaOrSEYTJOouJiN1vjlg1xL4bwUpqWxRPt1tQtSABhohdaRZ8uh/7oe6o2GDMw6IG832ltDYjoP2IFIEokVwIt3k1wwPa47Jii6Voj5NviBgBc+Lx8Hkwul7wrRLsE8GreSZSPlKIzyNMgj+BEMGpChivPPYtlDiWksHbOCcFl377W/HMUK2Pt5EsWj6VpsKt1taUVAfMFplYB8vww0e/5340yK99aANrKMjXohHzxvZhuopE14rkzAaRIUcqGY5/aL7ZdxW1GI9zCu8f+9finVLrIN+oCDGGQnsR4woS63fVqolhJTOY6kHIb4/l45QDUZtVzGw2MbMs/j7Z+xQLOud3lYIQI2TVvXY8Px2faIrEBn83wPHEk3qJmTH1skG7KPfsJ4XVnzP+2VI/klDZe7PcMG4DzsGqgMGb4v6zDIREGT8AdDGCKDAMBODIla0id6D3dsactLM5nWqIwNXVwcbsCMkObGiG/1ONag75TaeoYaufyCfUeYrCCgWUrAu2ppICOvtKOebLQEHJEYWkVL7nbxai0CDYk0V1lLuwXI02QIlAEg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(110136005)(426003)(47076005)(2616005)(40480700001)(336012)(186003)(86362001)(316002)(54906003)(83380400001)(5660300002)(7416002)(4326008)(40460700003)(8676002)(7696005)(8936002)(26005)(82740400003)(41300700001)(36756003)(70586007)(70206006)(2906002)(36860700001)(356005)(82310400005)(7636003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:18:48.2449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c66298-5b29-4967-334e-08da9d33dbde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
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
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
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

