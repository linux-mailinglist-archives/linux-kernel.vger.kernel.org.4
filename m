Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4D68CA45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBFXJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBFXIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8F432502
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:08:26 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KEHnU009025;
        Mon, 6 Feb 2023 23:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=d3JugFvzxOjps33xev2euAm7g4qNmWk7oY4Vz08lzVM=;
 b=ihlmU/NY9OGsyvGAYPPFILw6XvknbadZmcGNTcDaQ1Oj7hbpe8SduKV4177sTH/jxjqh
 VoejgoZLRAB1Znw38ZLL9AeTZAhK/q+nh8mEfFwfufE7ox/IGmU0VxSkLbOPn7BScCbm
 LfYQ95g5uFVR8Z0XTpLdJsxpR1Yw1UAzOmM1sNqgrQYhgNZX401yzxHdKnqTs8DH3Ymz
 JmLRFvOZWYsMs2K/JtKmQpmLRSLRQ0en2ADr/6D+KiQbuNxgnNMYfPqPlM2Ez2CZVg4o
 PSnv31PulHWL+ugQMLjyH4Jfh7/d6bwJX40MfZq8hu0ydfdWwFunpc9mRy+jSXscoJ4a ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9nc6cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 23:08:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316LbeUM040865;
        Mon, 6 Feb 2023 23:08:21 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nhdtb99m7-5;
        Mon, 06 Feb 2023 23:08:21 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] vdpa: validate device feature provisioning against supported class
Date:   Mon,  6 Feb 2023 15:07:58 -0800
Message-Id: <1675724880-7216-5-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-ORIG-GUID: iWFrxHEx4hm5fSuG5CKTktHBfuddtAVG
X-Proofpoint-GUID: iWFrxHEx4hm5fSuG5CKTktHBfuddtAVG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today when device features are explicitly provisioned, the features
user supplied may contain device class specific features that are
not supported by the parent management device. On the other hand,
when parent management device supports more than one class, the
device features to provision may be ambiguous if none of the class
specific attributes is provided at the same time. Validate these
cases and prompt appropriate user errors accordingly.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1eba978..8da5120 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -460,12 +460,28 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_buff *msg, const struct vdpa_mg
 	return 0;
 }
 
+static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
+				    unsigned int *nclasses)
+{
+	u64 supported_classes = 0;
+	unsigned int n = 0;
+
+	for (int i = 0; mdev->id_table[i].device; i++) {
+		if (mdev->id_table[i].device > 63)
+			continue;
+		supported_classes |= BIT_ULL(mdev->id_table[i].device);
+		n++;
+	}
+	if (nclasses)
+		*nclasses = n;
+
+	return supported_classes;
+}
+
 static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
 			     u32 portid, u32 seq, int flags)
 {
-	u64 supported_classes = 0;
 	void *hdr;
-	int i = 0;
 	int err;
 
 	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
@@ -475,14 +491,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
 	if (err)
 		goto msg_err;
 
-	while (mdev->id_table[i].device) {
-		if (mdev->id_table[i].device <= 63)
-			supported_classes |= BIT_ULL(mdev->id_table[i].device);
-		i++;
-	}
-
 	if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
-			      supported_classes, VDPA_ATTR_UNSPEC)) {
+			      vdpa_mgmtdev_get_classes(mdev, NULL),
+			      VDPA_ATTR_UNSPEC)) {
 		err = -EMSGSIZE;
 		goto msg_err;
 	}
@@ -566,13 +577,25 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_buff *skb, struct genl_info *i
 				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
 				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
 
+/*
+ * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
+ * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
+ * all 64bit features. If the features are extended beyond 64 bits, or new
+ * "holes" are reserved for other type of features than per-device, this
+ * macro would have to be updated.
+ */
+#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
+			      ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
+
 static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct vdpa_dev_set_config config = {};
 	struct nlattr **nl_attrs = info->attrs;
 	struct vdpa_mgmt_dev *mdev;
+	unsigned int ncls = 0;
 	const u8 *macaddr;
 	const char *name;
+	u64 classes;
 	int err = 0;
 
 	if (!info->attrs[VDPA_ATTR_DEV_NAME])
@@ -649,6 +672,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		goto err;
 	}
 
+	classes = vdpa_mgmtdev_get_classes(mdev, &ncls);
+	if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
+	    !(classes & BIT_ULL(VIRTIO_ID_NET))) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "Network class attributes provided on unsupported management device");
+		err = -EINVAL;
+		goto err;
+	}
+	if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
+	    config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
+	    classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
+	    config.device_features & VIRTIO_DEVICE_F_MASK) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "Management device supports multi-class while device features specified are ambiguous");
+		err = -EINVAL;
+		goto err;
+	}
+
 	err = mdev->ops->dev_add(mdev, name, &config);
 err:
 	up_write(&vdpa_dev_lock);
-- 
1.8.3.1

