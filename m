Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A276F6D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjEDNvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjEDNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:51:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAAA1737
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiBYJOXI8uziAp2Kd/iV3b7DlA96JGiWQ0y9l6PRikMUOdkUrq+J549XqHG0n0EQLOStA2nGN7lGiCM2qrYK7eUBIz7rNcydzOJpv+O/3G9vrvUyGHkDTUqH2tVutxOssjuocJu+CRrcyjxWXfWKsGhdYgiUN9hNJMOW10oIr4o626wKJMrjyVctCD130uEVTgxQvA5mm7J0UYPlF59gf8HWwY7dKeFCKJC+mPm0rnIL24mhRqwZgcQ6xrM34xCBCzE78azFGyaiYlPyQ9awBGsONMKXVwAywwdaB9DRiB56Mlj2W6jYSePRcXeKm/a4TiUYxKFN2GOZtHOFr8878w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYKcgc6KntO4tcux7G5aqtLTQl1Gd3hHUH/9u/WwfDw=;
 b=NApPJWwKAyWpoSzcg2gI0Yx818ztpGSpNti4S8FELmfue0sHhPBSwalgSoAQ05as/nLEFPOjLXuvKLaxsb4LsLaijB2H5IcnuOEYe+iL/Youv7/1pKgkQdbvkQrCDBCynD8cFs5Te0vaqVfRcxPk+eZAwTDKvw8auga7rAVNNxkCZawkQGKiZ3QbijsplfzoGrVpMWV9q9VsVzIv9YZONZnsUpWEir62dO6kz9maS4y6XZEyAs3hZm7N46r89ZF5wpMIJcc2sGsemFatvKRFbSdvathnU7Tnx7T6MczASChqaJceB9Sv3ky+AKkxAz8RZFBLNYQwE7BOS8AYkXmPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYKcgc6KntO4tcux7G5aqtLTQl1Gd3hHUH/9u/WwfDw=;
 b=ectioDBu6mmpWH1WGOMi3hFD84edRQos+eSguhbF+e6Q58WNvM+PpQvaf+ewHyNwSBUJN4z3UYOroFcSmmlz2D26ZcVNVnXcj2kT1I3Q26udPKYTCRSrVAEA2+l3EgxloQqTHCXNINfPIeS5pNOC2DCe5EwdY6nBwSGXGVruyw4Mjm5gWvhAu9CvaohjGRyzwfLGI+5I2NKAQX5SGg5b7sC+fRrdlZLs7VZvtbH6LrlE4EXY/rbQ7bfd43PVRqTTnQ06ontmgYEBIYvk1tctryxAJCNZ+QbnO5cq8iAXZb3CJZATOmCb3luc4izXzTio8mtLaSy4Ix8TFnUnXfnuYA==
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.26; Thu, 4 May 2023 13:51:15 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::ba) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26 via Frontend
 Transport; Thu, 4 May 2023 13:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 13:51:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 4 May 2023
 06:51:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 4 May 2023
 06:51:06 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Thu, 4 May 2023 06:51:03 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
CC:     Dragos Tatulea <dtatulea@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Date:   Thu, 4 May 2023 16:50:52 +0300
Message-ID: <20230504135053.2283816-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: b57c4ddd-f6a0-48ab-0982-08db4ca6a0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMNw7x55KJnDVX2cJYJM1BoX9NYG+EG7IKsVnnTsaRkw9m1GSmXt62qOypi90vkVj9+gUI3ELhjft+AJ4jbJQ4NycZ/qU4Se0L2wLb65XYy62kp/gxF92mjljzJ/SprXQ+NPBhDUjIh+UH/aBi8pvqkiIPEB3E6x/G9nePta4xmBkV2Ii8xCgDFx9q3tu8qB36VAU/1DncxVFptth40b1DwPRuB8UVnXeYm8Mk/2QxKjM5KWI0xWb+SQ0/Bw1ZcpakHzGlyIY1eASdE8y2CHA5QAVCeaCYcYS39n2LtrkQiagpR2fLusswAd9n1MAndBk5G8sBOT3Aev9O4tPgNBU2O/fTF0yzZn0vQVz3u/uXXD9nZefeu8q2Nnf6ZGlHP9zxwpvGQU6KMWFnZl2ZqKwpMO0bXv7wgbuIomOdSrIJFsQrYG80Zc3g4eG3VPPnj2mhO9LHT5SpDw2mqOTI/VeACN7EZBaybVuM+gXKIOEOoTILScj239jJuuz9+GvhaVRZOpJbqk05+rejnuqiTeaocfrYX9ValvYsz1Ly1tNR6pDJTXmvrqfSNuwsVPsv9n9iTBPU1/PD2y4/7RD6vPsERW5KLwKfl6XiAhjI0VIcysLywPDFf7ULdyYIMO7AuC9C1RsGDUgw49/4ABER64Ewb+puix3w5RJJ8yN4mYQUeT1z08CGIZhyRalJKXNswzybIXUBIRGB+EG+VWekkj+w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(1076003)(26005)(186003)(2616005)(336012)(426003)(54906003)(110136005)(83380400001)(36756003)(36860700001)(47076005)(6666004)(40460700003)(316002)(40480700001)(5660300002)(82740400003)(478600001)(2906002)(4744005)(4326008)(86362001)(41300700001)(8676002)(8936002)(356005)(7636003)(82310400005)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 13:51:15.1339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57c4ddd-f6a0-48ab-0982-08db4ca6a0fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The referenced patch calls set_vq_affinity without checking if the op is
valid. This patch adds the check.

Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/virtio/virtio_vdpa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index eb6aee8c06b2..989e2d7184ce 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			err = PTR_ERR(vqs[i]);
 			goto err_setup_vq;
 		}
-		ops->set_vq_affinity(vdpa, i, &masks[i]);
+
+		if (ops->set_vq_affinity)
+			ops->set_vq_affinity(vdpa, i, &masks[i]);
 	}
 
 	cb.callback = virtio_vdpa_config_cb;
-- 
2.40.1

