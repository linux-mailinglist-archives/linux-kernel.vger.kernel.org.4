Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42DF68CA47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBFXJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBFXIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE132E6F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:08:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDoUk031601;
        Mon, 6 Feb 2023 23:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=JJWHSduRoQrbMlgcL9i/NZDlDLMD04ksn4nHHzB3RNE=;
 b=R2GTMnyQTVl4LgV4fJBaG8PBz/V9NYNP/BLeiTAmjtZxt6bZ6FPh2FZEhPUlRAzMO7SH
 rIq3z6tmR77eRB55VlI8lDqhQiWH/17MkKZr2FQFzpGX0vPpckXueSw7oKpA1F8hRNkk
 AQVwYsaTeyVsobO2YOrQ65nJZzExvqMLobFFmj5iaDn+mmr39ijD/u6CXAnYkgzWnOK/
 y8Xs2zbZ8QHVzvrSdKu+e964+0g1uIdTbV8RO5QoN8cmvTZfm7ybGjC9R0s37gtDsWw/
 StjvdfsvkOdOE5DIdFAY1OiOFIewdJY8FVbOkH72DztBNkl4YXr/yH0BMGSlFOc2ViyU 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53c8a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 23:08:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316LbeUN040865;
        Mon, 6 Feb 2023 23:08:21 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nhdtb99m7-6;
        Mon, 06 Feb 2023 23:08:21 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] vdpa/mlx5: make MTU/STATUS presence conditional on feature bits
Date:   Mon,  6 Feb 2023 15:07:59 -0800
Message-Id: <1675724880-7216-6-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675724880-7216-1-git-send-email-si-wei.liu@oracle.com>
References: <1675724880-7216-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060202
X-Proofpoint-ORIG-GUID: FSoQbLt5vBBRTi94mhaFCetKyraoJHPu
X-Proofpoint-GUID: FSoQbLt5vBBRTi94mhaFCetKyraoJHPu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spec says:
    mtu only exists if VIRTIO_NET_F_MTU is set
    status only exists if VIRTIO_NET_F_STATUS is set

We should only present MTU and STATUS conditionally depending on
the feature bits.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3a6dbbc6..867ac18 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
 	struct mlx5_vdpa_wq_ent *wqent;
 
 	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
+		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
+			return NOTIFY_DONE;
 		switch (eqe->sub_type) {
 		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
 		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
@@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 			goto err_alloc;
 	}
 
-	err = query_mtu(mdev, &mtu);
-	if (err)
-		goto err_alloc;
+	if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
+		err = query_mtu(mdev, &mtu);
+		if (err)
+			goto err_alloc;
 
-	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
+		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
+	}
 
-	if (get_link_state(mvdev))
-		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
-	else
-		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
+	if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
+		if (get_link_state(mvdev))
+			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
+		else
+			ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
+	}
 
 	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
 		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
-- 
1.8.3.1

