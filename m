Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3298626FD4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiKMNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiKMNpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:45:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DB413DE6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:45:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVemgTH60+kPjKTlv4EL5E234pwK/zuTgxErcsAmDKSbhICPUzPGdsPmc5YK5wtgemvaEuGQI+94mtOtmoRPG5LqWzvAGcLQUN6b76/4qeMY6awJg0JVAcdpfYtIX7YdfTxf8WslyRL+9+4gJ7Ut2u6dzrTq4w0fFx+4VXCgx1pPTdT5HE3Svfzm48yjPYweUy9UEmcIuTphdfDsWULqOCxZXhCyHSy02SBgEooZVmVDBJjAO9EqcMA+uMGxiLnJPC6ipNee8vjE6TeDEX2Ygo0+EgHW5R/QGKlUbGfbwq5XyhGxQd+jp5mYAo6LhgaWnNVEJheDZMGXtgDAhARvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKLig1GdGW7wZa1AccNKQ6khk2+JhUNRH8VhFqTMzHE=;
 b=n5tBTjIY7pmiHY1IZeRUra49DvlGjM/Qfup6Ke67fL6JuRnGdFT5EbWedrAMsC0iC78k2zTw/PRiUfM/GGgXsOJpK/sh7LYXfhDJstFxVgp/+kJ1Htt4EYOcdxjz5BWYTUw29ExlSqjgtNcO0X/Iq+a8I7YQaGfvQ1FEtcQdlGCqOwr2WTcjiHFfzLyx0wPkHyfldoakvsKqFGR5hHHHf0p5MW0UFjXaxr7003I4gu35JlkmapXMPBH95Jgw+/vAjTW1s2qfsEKUplbee2UsXySe3OcJgI5RCm3N2+0EDeBIHyGm6jcM7jb9inYxqttWcRQp6enwQ9C6JySqYH2xsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKLig1GdGW7wZa1AccNKQ6khk2+JhUNRH8VhFqTMzHE=;
 b=SGHO8C+gj1jlh/OMIUQeekE2mpH4sdxj7EUW3uDZ0E6snWVoZSHTJCy04OxXtINDn2p/CsLDy5MQkuXqb/z+CdR8XrOlE5DWkyjXEUh3iEMjRKL9AIHf9fPSwzIpu2tqOT63bSFwuojaWdPTsWSZ9HAZvJSm5CPg4O/WNXMGTDkZbaHNrW0iz9e7OTRWLVhk8PSofckld8POdULExxJFPT4VXgUPOeQ5XMWXjLzLEDl7UrhdGumPp/UGIL45/zu9zHqhzVH4KTWOWLjKd0+JcJ7zQvXorQCMlf9XoD3QjrIvo764xobKJA6oGJgqmF8gprzkRjh6euwrH+uXgRU5Ow==
Received: from BL1PR13CA0448.namprd13.prod.outlook.com (2603:10b6:208:2c3::33)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 13:45:24 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::d) by BL1PR13CA0448.outlook.office365.com
 (2603:10b6:208:2c3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Sun, 13 Nov 2022 13:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Sun, 13 Nov 2022 13:45:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 13 Nov
 2022 05:45:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 13 Nov
 2022 05:45:04 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 13 Nov
 2022 05:45:02 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
Date:   Sun, 13 Nov 2022 15:44:41 +0200
Message-ID: <20221113134442.152695-7-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c32c2a-940a-40f5-0133-08dac57d50dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVWxdmbGNucwLqZmdlEDH68cqKQVwb4xXTs8sdMwSZJ8cb2GHImiNiwhkZcbCr4UnOkZfO6OIBF67a5CWh/eE/m5CZbkemocS7GCUl8ZlaST+d97GQ+zekwAJLhLJViX8bzL35SWJzs7fZsG614f4642/AR/GXxsBGF6K319gORwP4wFF7qPxcvOzVBzsUfxKnqThc6XatCtEAEEe+dHPdlbkuswAXxORPLkrVoE8X1sb40S8/A43MMIzp34spwd2pXx9bnqLcQcheDg09Yjl8nS+cxrN1Up98mZMk3s92gisRJByDtqpiE+cc/w3IclHDCZA7Gg4VQviV5BOv4i5oNsfQsyFMYmeh5ufRWvayl7n1DhKyt3X2jbRyRqTFhzphAknB4uf73jwoqBYwW9suRYaHNIhGC84uf2an5kw1+NEnnmU8w0Ecb9meqE7iyoMTd3lzNmumjX3aQ+KwUOHP1CPMYOLrVIrevvG7ZQE4zfLLXrj2xgVvEaaUEYAbzhQFHwfFiZr6UT+TcrGBQvsrV+RyehUR6gSzTScZF2mxQaDSo17Cbir+9da2Nu9nDIEL8nTqbYMI+zXHLOj94OnhsBlb8wXrHKq/WqGyULJwNQaGJ67o1kce+lwe2wIqCU3aKf06eeU7vK/YajpegzPWJg6513TMQ+MbqIJNUN0zFaxFkD+fiBeQhgBtPBHy9FBJYI87S04GRFYFEyT/cziwkv9EqKH3+ciKWmEnXeGLiDkRepaxK0fXw6MzWRxI5OW4NvRh6NHEc6xabrZEuTSg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(54906003)(86362001)(316002)(4326008)(8676002)(8936002)(41300700001)(36756003)(5660300002)(70586007)(70206006)(2616005)(47076005)(336012)(40480700001)(186003)(82740400003)(426003)(36860700001)(83380400001)(478600001)(1076003)(110136005)(107886003)(40460700003)(6666004)(7696005)(356005)(7636003)(26005)(82310400005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 13:45:24.2403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c32c2a-940a-40f5-0133-08dac57d50dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

event_handler runs under atomic context and may not acquire reslock. We
can still guarantee that the handler won't be called after suspend by
clearing nb_registered, unregistering the handler and flushing the
workqueue.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6e6490c85be2..bebfba530247 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2872,8 +2872,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 	int i;
 
 	down_write(&ndev->reslock);
-	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
 	ndev->nb_registered = false;
+	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
 	flush_workqueue(ndev->mvdev.wq);
 	for (i = 0; i < ndev->cur_num_vqs; i++) {
 		mvq = &ndev->vqs[i];
@@ -3051,7 +3051,7 @@ static void update_carrier(struct work_struct *work)
 	else
 		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
 
-	if (ndev->config_cb.callback)
+	if (ndev->nb_registered && ndev->config_cb.callback)
 		ndev->config_cb.callback(ndev->config_cb.private);
 
 	kfree(wqent);
@@ -3068,21 +3068,13 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
 		switch (eqe->sub_type) {
 		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
 		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
-			down_read(&ndev->reslock);
-			if (!ndev->nb_registered) {
-				up_read(&ndev->reslock);
-				return NOTIFY_DONE;
-			}
 			wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
-			if (!wqent) {
-				up_read(&ndev->reslock);
+			if (!wqent)
 				return NOTIFY_DONE;
-			}
 
 			wqent->mvdev = &ndev->mvdev;
 			INIT_WORK(&wqent->work, update_carrier);
 			queue_work(ndev->mvdev.wq, &wqent->work);
-			up_read(&ndev->reslock);
 			ret = NOTIFY_OK;
 			break;
 		default:
-- 
2.38.1

