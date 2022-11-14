Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABE162811E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiKNNSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiKNNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:18:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDD5E18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:18:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2942ZWVQZxkTq5+4twtblq0E+5INDorQWbGp5lkTlM4aXtim6cRy/I9M8dPz4oTlozGKcyXlCex28Y3aMLZRDpuRqG8gaYd49FxM78JTB0svf6zpPYCaRpXR2fVL9kRYoP/FBpG3uNM1khXqyeUzkgQwjguuZGBo4TC493z/vbfe8w7uqvaBKjtH8Vj9A6oF1V8UCqQxs0xbqUgcx5pHusRgJ1B6I9jhuYkjkdFeCvMhuoSq4jZlQyaT5k8t43FiAjPb47ouhLeDb5N1GWS5afZHjTGDvM1Yu5pKffjkVZsuPAEzVj6PWXI9imF5/yujpdxAq68eFdvyAqpOHLE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47KHRZUOqCD47Bd3hGZcGhnYXypbbdjn/wRrjSejX/0=;
 b=jHL/KThlZ9TNskQ2rS8UKMHEKolw7sTDD8V+E36CoKig9Rf3EZjpJ3nN4sHLU3dwbKfh0q0fwoug5CUVwbf+SjknDhN5k9l2GRa4T9TtBoxgJh2A+PwsMuBZZ9690ta7sBxasWo/kS6IuLDEgAOm5KBkxBtkfRUasyDbtrRN6gdoBspYA6LGY3dsyexRFKd7BZCuzW9ScU+ef8llOJnfMOXbnINqu4k/qH9pYIoXDA0NDq+NPRdjqUNtAc6Jhf4+ktGvYhNjvwhKupFj8YZ98OUzxqgaD8swlwl0vROref1yBbkhua6cObuDsNbqt3B7qidolrUypsuNJ5FHacVPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47KHRZUOqCD47Bd3hGZcGhnYXypbbdjn/wRrjSejX/0=;
 b=q7b0lP/vtPIVoFCz3owL708kN8POG9DSQgnFs0GhckfJTlRdUrUnc+QtNXeXpF4QwcTSopx1L8DvRoGj2VQCDS6zotW5Gr5/KmO4Ual7rE4GamjzqpkhU7aytng/woUpfnzXHTsB2vEKlmL/w7H4KFlN16Lquyf08HJjR97C04fHxuHsXVOF/+04YghMxlE6wIB4lACwHefl3pW0MhzfqNIBlfdwJjcac+9xdDcp1AhamXR7ZI08Oo9IubGV4tWjis2eZRMRKIiifZe1BGWQ1JFdQuND9Bu7ILtD0eX99okf8VWEexzBp6SoP0B/KjgtGDe/gvG+HfmlKxdKKjGlEg==
Received: from DM6PR07CA0044.namprd07.prod.outlook.com (2603:10b6:5:74::21) by
 MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 13:18:25 +0000
Received: from DS1PEPF0000E657.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::59) by DM6PR07CA0044.outlook.office365.com
 (2603:10b6:5:74::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 13:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E657.mail.protection.outlook.com (10.167.18.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Mon, 14 Nov 2022 13:18:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 05:18:15 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 05:18:15 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 05:18:12 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATH v2 4/8] vdpa/mlx5: Avoid using reslock in event_handler
Date:   Mon, 14 Nov 2022 15:17:55 +0200
Message-ID: <20221114131759.57883-5-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114131759.57883-1-elic@nvidia.com>
References: <20221114131759.57883-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E657:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe47cfe-febd-4e7e-1eac-08dac642b5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CZnoqJPvifX6f9h7rJl6p9Sk7MteqAN2SZZYcY5zYZIFQTgWa2ortD2+Yk9laEM7iZd3vcvKdX7K7cHtht5ON+60BQybu7v+a7xGXIXJaIrd7nT9UGBdYUMQ7HC7QNOV3F8Bs0NXoNfYkTBkq/+uB3LSYKgBJO8jQzt5BLqK554FoNl7R71OvwRyx21ZTX70+pJiXa4fh1SQsT+A7owrxfdmBBfjUlXI+jfnTOx1+Ff4o11sUKOgiunAWsiERGN5hs+6+my9+SrvM5w+MDgq+6vgyxj9YBTWiRoeXjfPU2UU3WBvipgwSHuIWfE+AuOFf0xutCLxmTxuprb22dxZaXgb77qKOlxj3JCVh3P6Cjp+a7Cw3lbkPoM0ZT0UnG2k5FzQUjQ7PyXogVFqDxm93iVit+jhfboEaVp9pZk9O7M5K6V46dESEavVVnnjIQzvTzW2VzFqrrWlLjMDIS1llvTqROglaY96mi79KRyantrmLsKZODd2iz7nvsXVgGrPEmOwqly2dN64Y7QtNAW5pirAUfFgvLUGWjTgGUJskJbXIBQTgoqmJiDMl9yGdnSHJQZzVM5Z33jeDRDS5f5xQ7fKAhVHzD1ZL6tOGV+ptfeAQw0NceHpnp8+nQF2kyLMEq1KCkip00GLgxKsA9LV1bnxyb3LOMqP+HG7nZQuWhTuSe/p68m77d7YWXDyw7FZnF+a6sdo68POqtALtzilJ9Zore4vGCBybF0lJPSqLHY5vclhyWNzYWUg8XKHWepzWDOgAriVK3Azj5RRoE5Bw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(86362001)(54906003)(36756003)(356005)(7636003)(82740400003)(70206006)(316002)(70586007)(8676002)(4326008)(2906002)(41300700001)(83380400001)(426003)(8936002)(5660300002)(47076005)(36860700001)(1076003)(110136005)(107886003)(6666004)(478600001)(82310400005)(2616005)(7696005)(26005)(336012)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:18:24.7231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe47cfe-febd-4e7e-1eac-08dac642b5ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E657.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b06260a37680..98dd8ce8af26 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2845,8 +2845,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 	int i;
 
 	down_write(&ndev->reslock);
-	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
 	ndev->nb_registered = false;
+	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
 	flush_workqueue(ndev->mvdev.wq);
 	for (i = 0; i < ndev->cur_num_vqs; i++) {
 		mvq = &ndev->vqs[i];
@@ -3024,7 +3024,7 @@ static void update_carrier(struct work_struct *work)
 	else
 		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
 
-	if (ndev->config_cb.callback)
+	if (ndev->nb_registered && ndev->config_cb.callback)
 		ndev->config_cb.callback(ndev->config_cb.private);
 
 	kfree(wqent);
@@ -3041,21 +3041,13 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
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
@@ -3242,8 +3234,8 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct workqueue_struct *wq;
 
 	if (ndev->nb_registered) {
-		mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
 		ndev->nb_registered = false;
+		mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
 	}
 	wq = mvdev->wq;
 	mvdev->wq = NULL;
-- 
2.38.1

