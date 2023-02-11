Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E4692E8E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBKGIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:08:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD645C89E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:08:49 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B5VWHk030701;
        Sat, 11 Feb 2023 06:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=MOiEKHQKDJR9QHAHdY++al+Ze5H+rKY6te5kRImaaP0=;
 b=T4Ovj5C56jgml/0MPqvz+yCZIXMVzWahzMhLB9OLtMmL/KHCmbIALlc9rYXmfFICtUpH
 h/AJ1m5dk6zOVz2F0VriuzFJhKnMyfQ17cJqEikSukMpVJ8QepXoGc2eOF5WEDUA2wXA
 X3DA+9xEgUbu0/Yh8iQhNNMxU5DQ0H4+OcnRdENRa/w6V6s0bcTMWWfk+WvB+933ItXt
 WATYMW86fpImmxVWWdEyKYUDErfFCRTJL99lW4E9uKauNyUvEsEg1a5E9IHQPGAm31fy
 rLpEiT9jBhhGJkU+06q3V8BiUg1CcrQCrB6bs6KyaoyMT3V6S1eebXEIVqG93IEnBY2W 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t383qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 06:08:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31B1XGmL018005;
        Sat, 11 Feb 2023 06:08:40 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1f2mgmw-1;
        Sat, 11 Feb 2023 06:08:40 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Cc:     parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: should not activate virtq object when suspended
Date:   Fri, 10 Feb 2023 22:08:14 -0800
Message-Id: <1676095694-15563-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302110055
X-Proofpoint-GUID: kH9EvAek0IomS8sLw0KS02YPYNNNmEjG
X-Proofpoint-ORIG-GUID: kH9EvAek0IomS8sLw0KS02YPYNNNmEjG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise the virtqueue object to instate could point to invalid address
that was unmapped from the MTT:

  mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
  CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
  bad parameter(0x3), syndrome (0x5fa1c), err(-22)

While at it, add warning message to tell apart which object is
responsible for the CREATE_GENERAL_OBJECT command failure.

Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
Cc: Eli Cohen <elic@nvidia.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3a6dbbc6..c05c7f6 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -165,6 +165,7 @@ struct mlx5_vdpa_net {
 	u32 cur_num_vqs;
 	u32 rqt_size;
 	bool nb_registered;
+	bool suspended;
 	struct notifier_block nb;
 	struct vdpa_callback config_cb;
 	struct mlx5_vdpa_wq_ent cvq_ent;
@@ -1245,12 +1246,18 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 		goto err_connect;
 
 	err = counter_set_alloc(ndev, mvq);
-	if (err)
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to alloc counter on vq idx %d(%d)\n",
+			       idx, err);
 		goto err_counter;
+	}
 
 	err = create_virtqueue(ndev, mvq);
-	if (err)
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to create virtqueue idx %d(%d)\n",
+			       idx, err);
 		goto err_connect;
+	}
 
 	if (mvq->ready) {
 		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
@@ -2411,7 +2418,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	if (err)
 		goto err_mr;
 
-	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
+	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || ndev->suspended)
 		goto err_mr;
 
 	restore_channels_info(ndev);
@@ -2580,6 +2587,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->cur_num_vqs = 0;
+	ndev->suspended = false;
 	ndev->mvdev.cvq.received_desc = 0;
 	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
@@ -2815,6 +2823,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
+	mlx5_vdpa_info(mvdev, "suspending device\n");
+
 	down_write(&ndev->reslock);
 	ndev->nb_registered = false;
 	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
@@ -2824,6 +2834,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 		suspend_vq(ndev, mvq);
 	}
 	mlx5_vdpa_cvq_suspend(mvdev);
+	ndev->suspended = true;
 	up_write(&ndev->reslock);
 	return 0;
 }
-- 
1.8.3.1

