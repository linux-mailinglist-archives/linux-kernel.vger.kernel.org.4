Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E2683A69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjAaXXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjAaXXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:23:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9463424CA1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:23:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIi4gG014086;
        Tue, 31 Jan 2023 23:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=3qVacz3Bma3en7YMTykpbmYhLaBsLJgzc5BjnHjFnJA=;
 b=k6l4wN64gFpL3lp+HcNkE3QzviBL3xh4hfQQWJFoMpa6ldVIfpvtWCvVi2eN+orAdsRX
 itic0UXoC2zovvVw7Jn7YEYsP/VdOYRBUtg6qpx1tnKi3Wzb+WhYVpu82jCc7cuuJtWm
 JaMwlj+ZiRCT2JWXugyYmvPUjPBdN7qwaFuZMJGLSkq0xIexU9xHXlqTW+r8/Xiw45TM
 fbRV6eKgUotJmJwZ+islqfBTwGppc4+dnROyy3HqXj+jtrYD3Qcb0MUhzg0vPq0Ius1N
 6zMs9k1sUGdXzy0ejBqYYWG//EdT9aWR7zC3IYTBeFgYrKU5IF7nnzbqc1pBJIbaZivT FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9y061-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:22:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VN9OVl033826;
        Tue, 31 Jan 2023 23:22:43 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct56fb9w-3;
        Tue, 31 Jan 2023 23:22:43 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] vdpa: conditionally read STATUS in config space
Date:   Tue, 31 Jan 2023 15:22:20 -0800
Message-Id: <1675207345-22328-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310201
X-Proofpoint-GUID: iRhEFxuIEPNNz8VEkJEJOpiEcLFjVI3i
X-Proofpoint-ORIG-GUID: iRhEFxuIEPNNz8VEkJEJOpiEcLFjVI3i
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
    status only exists if VIRTIO_NET_F_STATUS is set

Similar to MAC and MTU, vdpa_dev_net_config_fill() should read
STATUS conditionally depending on the feature bits.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/vdpa.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 3a82ca78..21c8aa3 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -843,18 +843,25 @@ static int vdpa_dev_net_mac_config_fill(struct sk_buff *msg, u64 features,
 			sizeof(config->mac), config->mac);
 }
 
+static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
+					   const struct virtio_net_config *config)
+{
+	u16 val_u16;
+
+	if ((features & BIT_ULL(VIRTIO_NET_F_STATUS)) == 0)
+		return 0;
+
+	val_u16 = __virtio16_to_cpu(true, config->status);
+	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
+}
+
 static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
 {
 	struct virtio_net_config config = {};
 	u64 features_device;
-	u16 val_u16;
 
 	vdev->config->get_config(vdev, 0, &config, sizeof(config));
 
-	val_u16 = __virtio16_to_cpu(true, config.status);
-	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
-		return -EMSGSIZE;
-
 	features_device = vdev->config->get_device_features(vdev);
 
 	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
@@ -867,6 +874,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
 	if (vdpa_dev_net_mac_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
 }
 
-- 
1.8.3.1

