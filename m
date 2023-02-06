Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179F968BCB8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBFMUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFMUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:20:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E7A1CAF1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:20:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlUd8AGFGr+yn8VDTlbpFS2FFdJvw1xgSBisYLStM2udAAUw2jTAuKOcYgLidRO339H0cH35Vs3qG7ciq7MVzx118TdiH1sNoXR8LtobsePYtG2Q2gxFSfnzGP05ODQ0TFqBoCRs0nvz8nQrqz8jQgfIvTYzIlfyRf4R2KIaWnGHHM/APnjApbqLZEDYkkyPc70g5rUPvpSnRofRvjnJW1zyt1smRoku5lJxOp1OUY99sb+z230GtYbU97bQJ62BnNJ9umWkyh8hv3Dqe1Bs11s95L2fIAe4cUA3tNH+AZTpkFMoszkTd8x1USzVc+OuiiPBTAbWC9ozamBcdb0YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VTlV03hzFplTZ9YXLs83O1QyBD+mgb9BcFDFcZAQmE=;
 b=oUHooqnDs2eisCKSru1b1RB0zduISoJT4UNAWvMCG9Wns5QNDdhAIuEkqorzRdq3o+9gE6wSu1WrzAsuTMrjhNhFOZuNJM4Nojh4RhfIh+4rKF0m6fflXnPzKYN0BiXEq3mB+0ImpcZVK4kEnPT/+9UKlfPdLXX8zk6jC4cL2Yetns/wkxFDk6DTstplqetL20PgkNb2hM1q8QHXhgacVyR59Mq3Hz0wlZ3NLM7Ld/Uwj4HHfTk4c6YtyIsR4dSya6IPIcGzGQfRd8L/coRVVo0ZNri3K3fvpJvoMUvz/EC7ZES2Txy/FfYUFw3dUyQm/KxO14ECknYN/4sjhYDFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VTlV03hzFplTZ9YXLs83O1QyBD+mgb9BcFDFcZAQmE=;
 b=pv7aA67+ISsk6pqv+zIm1ieg09GdH8sKgfmvucXBZ77jeFWa9QMi4hyHgKaJ/6Vf3YKA276P8j612lT+KvRlvce/3jpF0FEdjMeZv4gWMb7mbIPloE7ZtxTerwvsTm7mK4S9lfZ701NdJUnY5x/v2FAWajw/re4RVnnJBZiyI0jXy1pPoTiebO7JBf8uVvjZaC92BNDLXNGcosmypuv6JOhJUNqRTPgA79imVX/jaNZWtsNpJNEf1/A+jDUToTz9gYBVL5pe3y0nqKxpbOfAOYkVEUh55DMql290EP4npacbGvIzZT9MdwGzy4ISmAeQrkINxfdzn2g2K2EMpjXDxw==
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Mon, 6 Feb
 2023 12:20:28 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::5b) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 12:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 12:20:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 04:20:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 04:20:20 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 04:20:19 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <si-wei.liu@oracle.com>,
        <eperezma@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Eli Cohen <elic@nvidia.com>
Subject: [PATCH 2/2] vdpa/mlx5: Initialize CVQ iotlb spinlock
Date:   Mon, 6 Feb 2023 14:20:16 +0200
Message-ID: <20230206122016.1149373-1-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|DM4PR12MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 58118883-850d-42cb-477c-08db083c8887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RioFyKBVdKsKYK9agGEsjB+yelhZemoTTBLSIdq6hnWdbpq83u40dZ5UEWX3woIuOWEKLbPGkvYwiNgdm7N/MAnOXvmH9d1DPi7GX1d1gpGSJvpVEbZfZNkT9BxS7Ff1Lr4xqkQdZ0CTz+BOeLhguH1R6y9NSXezM4bhe9PNE7c8qYU8rDh7IviNloP47u0OGr6VVGyCM26VI5/tfRpENcEto++Isl+jJUpAw1bNAiCDXjjke6v/dnDNL5yUP3hfQuekRkc6cikRc6q9JONw6qsbnb9w1A6V5qsqakEGz+pAMGPqQ3BYkZz6tcZkS/AyGZrJgRrvCPlIwvHr6BQlYkZS5p35yGRYBeOjCy9x8c58JUxPF+bxWdj0y4ZlAT5bPIHNnq7oMnGElpz8aQmy9Pdjc8KYtHNFdZMefd0/CvMbQJ+Nm1FPJI5umpfyL8HjZGv+T9gZgV5N1QAlXLrPxBG1ew3+AFTq8LNEuYg99OBs3dZHTHORBgpNw4BbsPKCDhrkXikDUxM40b5DRjPQsrdSkH/mSEeaup+BwtOxWYmCBGw0yhix3lK4b9W2tbssfpveXbafuTEKe5Vr7uMvZpsvTvfUhx8gO+y817gJsxz/xeC27pyR4PrFy1+62mvz9/xFEP08cw0BXJrwU1ObVArIe6zxsDjmK2h5BUXddjfzDMZs7Z/Nev59UuMLyBEasFUPAnksAudvacMvSXXtw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(110136005)(82740400003)(107886003)(86362001)(7636003)(1076003)(356005)(40460700003)(4744005)(186003)(26005)(2616005)(82310400005)(316002)(2906002)(6666004)(5660300002)(36756003)(40480700001)(70206006)(47076005)(426003)(7696005)(83380400001)(478600001)(336012)(8676002)(8936002)(70586007)(41300700001)(36860700001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 12:20:28.3121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58118883-850d-42cb-477c-08db083c8887
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize itolb spinlock.

Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/resources.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 45ad41287a31..d5a59c9035fb 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -233,6 +233,7 @@ static int init_ctrl_vq(struct mlx5_vdpa_dev *mvdev)
 	if (!mvdev->cvq.iotlb)
 		return -ENOMEM;
 
+	spin_lock_init(&mvdev->cvq.iommu_lock);
 	vringh_set_iotlb(&mvdev->cvq.vring, mvdev->cvq.iotlb, &mvdev->cvq.iommu_lock);
 
 	return 0;
-- 
2.38.1

