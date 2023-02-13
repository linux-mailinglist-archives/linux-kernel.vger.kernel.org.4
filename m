Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B52C695412
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjBMWsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:48:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859FA20D13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:48:37 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DMNsj6001430;
        Mon, 13 Feb 2023 22:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=vzh1vblswBntiUG827iCoSwI+1/49s7W/10M5vk2q8Y=;
 b=oZ9H3L5hRHSrMHuwdbOL6i4+kFOW4wSE9e4cGiqAO3eIZGawTrFgAPwoK8A8ZNEu3KFI
 f3JBLjOII89cHj3xcVmFrbkSfpxzeb2ueoAiGZwLfxHVZ+MhpKE0evJ+M6NVnOA8IL5b
 TajjNejn4IEU7kPnBg+3Qtzz+GIBrIuEteyfIkHQ7twkNWtnZibNVHUbKzew2r/EwK1g
 kxIdQ5e3jLB8QK4WxKSONj1ktEeX7Fgu6A8omoE3vTTNf9tEeZQobJ/5QKg+XuPLj/bz
 57Jg5B7odKU2lJjSbQLQbBUHrq8hgVvL+dYAMzROSAuzH8C8o0zJRZsB6TgylBVh08rw iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2w9v2qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 22:48:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31DMcuf5028894;
        Mon, 13 Feb 2023 22:48:32 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3np1f4g002-1;
        Mon, 13 Feb 2023 22:48:32 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Cc:     parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
Subject: [PATCH v2] vdpa/mlx5: should not activate virtq object when suspended
Date:   Mon, 13 Feb 2023 14:48:09 -0800
Message-Id: <1676328489-16842-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130199
X-Proofpoint-GUID: 0nDABNbF88bb7cuHvz8C_oHXdId5RoTr
X-Proofpoint-ORIG-GUID: 0nDABNbF88bb7cuHvz8C_oHXdId5RoTr
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

Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
Cc: Eli Cohen <elic@nvidia.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

---
v2: removed the change for improving warning message
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3a6dbbc6..d7e8ca0 100644
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
@@ -2411,7 +2412,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	if (err)
 		goto err_mr;
 
-	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
+	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || ndev->suspended)
 		goto err_mr;
 
 	restore_channels_info(ndev);
@@ -2580,6 +2581,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->cur_num_vqs = 0;
+	ndev->suspended = false;
 	ndev->mvdev.cvq.received_desc = 0;
 	ndev->mvdev.cvq.completed_desc = 0;
 	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
@@ -2815,6 +2817,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
+	mlx5_vdpa_info(mvdev, "suspending device\n");
+
 	down_write(&ndev->reslock);
 	ndev->nb_registered = false;
 	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
@@ -2824,6 +2828,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 		suspend_vq(ndev, mvq);
 	}
 	mlx5_vdpa_cvq_suspend(mvdev);
+	ndev->suspended = true;
 	up_write(&ndev->reslock);
 	return 0;
 }
-- 
1.8.3.1

