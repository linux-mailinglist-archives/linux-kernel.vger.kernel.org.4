Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894BC628120
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiKNNTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiKNNST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:18:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B7B498
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:18:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzjc9zyspYHPU9SOzixxCkq9hRJs2ncpgHwgk/UMUNTHaILh2RkJ4SxTk2oPiSsoa9He1oKOiI+p5aHGP112TwVNbBs3FfAXNaQk+OBrEzFIWJMK37Z9ruMGvlYCzhEqtLvDbr54VEONWBxuJPDdRU4H/NUtXZiAgRCAQ/btRCCAezKBVoe4WsAzbzUlIUYxkAyGZhLr3ZlZpRS8haXgPILcqpEkVqT4wpy+wLvIt9+F54cljPmr6aRDBKTazID+C7xdu/vwyd5lHPrvxZtsjvMMBMP8CbuHnzdaRR7gdrodBcT4T1cw+/2XtedYypXsM6Dm+cYN8I3UPJnOMbexFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJlecboikd8jAUBfmPbRPzYGdu4c53JvHpM3dMgaVyk=;
 b=c3yo8wWoJb+oJgWJBsv7IPjQJap040OKgroI5aCL9VK/Kl/LaKCqvWtJgSwGOHxA88AEC2lDBM1oy8S1LGW67oJy4CfOc8704qxmc+R47ymxRw5NaLHp/JteS9SZ0Y/rcU8RtCenolDxkST90CDsZiuIxt06DmNH1gx/7FX2Sn7yEyKfXHmI01Ct5WyxxhPinz4QeE/v+qE7URHFdyk9viqceu1ZkAuped4/3P8vjot50Zhxdmw7Hf5CohwHtrdG5DLMEcJUr1fDX//Y9CchwjPxCo3mUuL0ZfrU4NZeDMdsZtsDFTKHUgFnz0vkxqiwZ2cidG81YeFMXNFV+zj5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJlecboikd8jAUBfmPbRPzYGdu4c53JvHpM3dMgaVyk=;
 b=J9cILS4IXjRDPpevQSixuntVw3SungrudPOGR6d9lzlfz1gONqYqEckM7WYp8BYUyAEQQwYH7No4lwNwQbbxjP5XGsaUgJzW3bUm29fBmynh2yQRyRq4gULaIcjPuWHZxFV+uAFJa6jvnYqva6Qevl5Jaf3/JJ7b+IFk80EXwwUkBf/ydKZFubnY1f0I9rULR9akldMWB8ZuHaQeiYO7fu7Lj6EVch1uWnvhtUoPkSQ6oT+SJOZiXZ6+SlFc0M+h9C7sRULrJuSQGQia92EX8/rqEOiolHbA6A9lREDDYrlVmY5BOGYNgfZp4pqiJk7zZOg9BpjU/C6MkouWHGbPqg==
Received: from DM5PR07CA0050.namprd07.prod.outlook.com (2603:10b6:4:ad::15) by
 BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 13:18:17 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::80) by DM5PR07CA0050.outlook.office365.com
 (2603:10b6:4:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Mon, 14 Nov 2022 13:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 13:18:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 05:18:10 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 05:18:09 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 05:18:07 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATH v2 2/8] vdpa/mlx5: Return error on vlan ctrl commands if not supported
Date:   Mon, 14 Nov 2022 15:17:53 +0200
Message-ID: <20221114131759.57883-3-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114131759.57883-1-elic@nvidia.com>
References: <20221114131759.57883-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|BY5PR12MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: b30b7798-dae3-463a-8146-08dac642b14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtd3ZWCAb5ppQ5qW2HzQdpu+6tPcnxaYquwt8C9H/nk2TCpCPInfwaooQ62TA+xVXmcybCP7ZgcPi3sfNaP7+E+4qBjM8TEWqHQGW2JS0ki60YxCX//lxNc3z6/sZmvsFYHvQbuGfc4wBGy+1zwLvXnHpulFiRehBQUPTH0nWpUDCC8xPVw49XCdnQHKkDOv55GMMdHazV6KE6OF1OypXIoONioY0VgeZ+OC686FteflKZB6I8hOqFTE25A4xm2DIrzWDJ/u26nkA7X9g+rWwZqIzVbeK2pNmEQfum3HsZwaq0Ed7v5gNGTcFbMwym/KaeYj16gw5aMeT3cWN9jweewvSNKb+eEV2VbN7p+UNbQ4vfWcpP2C5PD0xO4aE0r0pXCXzgubD7tXroHO36Op7MFlsa6FWNpJBZ0ZkN3tZ3Y/VS5NrCfE5ZfAPr+XQZ2fDP67tusReSfhoVXTGAsVWKsyVyo6lMq4yUTI7AYTry0mf5xeQ7UBeN5ilGaiTQiWv7L0VAbm9piAmKWijNdeOxi7QQLtV2dHQ7lK46dvHWXaPv3Iy7qfps9VLp6Rtwv11Z/f0FBk61uKinTrg28Y4iiQC9auIiQavVD+VvpJtX/MO3jp4G1vORRFi0BeTXzALlh2fECT3FIaYjtdUTG7vyvugm61qY4NcNqkl5KghyamIvC8ewLNsfmPYwwQ9aJ4ZJ0zJ5aD600vCyu7+EykSC/OO87UMCyItkczGXxGZUZr5fbkRamI2k0U1oRJ9YYs8GLrMWIjUYORdAOgR6YEvA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(40460700003)(54906003)(107886003)(6666004)(110136005)(7696005)(2906002)(336012)(316002)(82740400003)(36860700001)(47076005)(426003)(41300700001)(70206006)(70586007)(4326008)(8676002)(1076003)(5660300002)(86362001)(26005)(186003)(7636003)(356005)(4744005)(2616005)(82310400005)(8936002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:18:16.9531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b30b7798-dae3-463a-8146-08dac642b14a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if VIRTIO_NET_F_CTRL_VLAN is negotiated and return error if
control VQ command is received.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3fb06dcee943..01da229d22da 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1823,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 	size_t read;
 	u16 id;
 
+	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)))
+		return status;
+
 	switch (cmd) {
 	case VIRTIO_NET_CTRL_VLAN_ADD:
 		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan, sizeof(vlan));
-- 
2.38.1

