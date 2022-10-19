Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339B603749
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJSA4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJSA4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:56:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D3CA8B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:56:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29INi02T025707;
        Wed, 19 Oct 2022 00:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=6OKBJgFbXS3OjE73iQJfSkItm6qvzXxZpGWp2/+KhZg=;
 b=2nEhbjlmXgIWhX4a9OIrCzxlfVq/emWvuMZWjo4TYevCuApKvldZ8fk+sxCtesLiErkF
 FYCecVmQqX58GFTmJ3W7ykgJOn65dfiL4gJtGRmJtTdridOH+vCGoNF2yqN5cUf0VSPD
 hX7+hg+6FBJXgcw9Emq/oN3p5lAknqZkXZ+67euo+gPIUTRM7bvpC/u2FWhNiVrNHpl0
 iAS/EFd8WRXEHkJYSbKdNkurzAKQoBNv6RLnS4aIWfVmNDXS+wixpva5aGMzu+EcOeUh
 mJL4wpIeFQ9vdRjFSPyJQyP3r02EY5a2As4McJLeuGO5PMY6dVfFOdggZ/OQb45w3gCE sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3gc6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 00:56:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ILnUhI016678;
        Wed, 19 Oct 2022 00:56:12 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8htgrhfm-3;
        Wed, 19 Oct 2022 00:56:12 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] vdpa: pass initial config to _vdpa_register_device()
Date:   Tue, 18 Oct 2022 16:50:30 -0700
Message-Id: <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_10,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190003
X-Proofpoint-ORIG-GUID: zVT2XndAdswwS49CRlU8k2umoOeBn3Wt
X-Proofpoint-GUID: zVT2XndAdswwS49CRlU8k2umoOeBn3Wt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as _vdpa_register_device taking @nvqs as the number of queues
to feed userspace inquery via vdpa_dev_fill(), we can follow the
same to stash config attributes in struct vdpa_device at the time
of vdpa registration.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
 drivers/vdpa/vdpa.c                  | 15 +++++++++++----
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 ++-
 include/linux/vdpa.h                 |  3 ++-
 8 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f9c0044..c54ab2c 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -771,7 +771,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	else
 		ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
 
-	ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
+	ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring, config);
 	if (ret) {
 		put_device(&adapter->vdpa.dev);
 		IFCVF_ERR(pdev, "Failed to register to vDPA bus");
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9091336..376082e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3206,7 +3206,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	mlx5_notifier_register(mdev, &ndev->nb);
 	ndev->nb_registered = true;
 	mvdev->vdev.mdev = &mgtdev->mgtdev;
-	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
+	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1, add_config);
 	if (err)
 		goto err_reg;
 
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index febdc99..566c1c6 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -215,11 +215,16 @@ static int vdpa_name_match(struct device *dev, const void *data)
 	return (strcmp(dev_name(&vdev->dev), data) == 0);
 }
 
-static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
+static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
+				  const struct vdpa_dev_set_config *cfg)
 {
 	struct device *dev;
 
 	vdev->nvqs = nvqs;
+	if (cfg)
+		vdev->vdev_cfg = *cfg;
+	else
+		vdev->vdev_cfg.mask = 0ULL;
 
 	lockdep_assert_held(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
@@ -237,15 +242,17 @@ static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
  * callback after setting up valid mgmtdev for this vdpa device.
  * @vdev: the vdpa device to be registered to vDPA bus
  * @nvqs: number of virtqueues supported by this device
+ * @cfg: initial config on vdpa device creation
  *
  * Return: Returns an error when fail to add device to vDPA bus
  */
-int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
+int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
+			  const struct vdpa_dev_set_config *cfg)
 {
 	if (!vdev->mdev)
 		return -EINVAL;
 
-	return __vdpa_register_device(vdev, nvqs);
+	return __vdpa_register_device(vdev, nvqs, cfg);
 }
 EXPORT_SYMBOL_GPL(_vdpa_register_device);
 
@@ -262,7 +269,7 @@ int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
 	int err;
 
 	down_write(&vdpa_dev_lock);
-	err = __vdpa_register_device(vdev, nvqs);
+	err = __vdpa_register_device(vdev, nvqs, NULL);
 	up_write(&vdpa_dev_lock);
 	return err;
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c6db1a1..5e1cebc 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -387,7 +387,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
-	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_BLK_VQ_NUM);
+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_BLK_VQ_NUM, config);
 	if (ret)
 		goto put_dev;
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c3cb225..06ef5a0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -260,7 +260,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 	vdpasim_net_setup_config(simdev, config);
 
-	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM, config);
 	if (ret)
 		goto reg_err;
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 35dceee..6530fd2 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1713,7 +1713,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret)
 		return ret;
 
-	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
+	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num, config);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
 		return ret;
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index d448db0..ffdc90e 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -538,7 +538,8 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
 
 	vp_vdpa->vdpa.mdev = &vp_vdpa_mgtdev->mgtdev;
-	ret = _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
+	ret = _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues,
+				    add_config);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
 		goto err;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index f1838f5..b9d50e8 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -381,7 +381,8 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs);
 void vdpa_unregister_device(struct vdpa_device *vdev);
 
-int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs);
+int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
+			  const struct vdpa_dev_set_config *cfg);
 void _vdpa_unregister_device(struct vdpa_device *vdev);
 
 /**
-- 
1.8.3.1

