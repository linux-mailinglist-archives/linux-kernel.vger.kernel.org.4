Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F726683A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjAaXWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjAaXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:22:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7844A7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:22:30 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIi8cs006462;
        Tue, 31 Jan 2023 23:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=uNARmj9DqSK4eCVCfxVvrQGxRGB/k+87LR5p1WvHgfk=;
 b=UL8g25TuoC2eBTr3pfCVHsUNt0VrHPGkep1+dY5IjItWwzPIuKZT+TLsYs/9qd4DMqPD
 P38e1fHIIVu9D1uHBsUQcZK4MbUzrIx3cQgrMY36wn1n+fUUlpgwR1DTQxLM1P8g9GgX
 /Hoqfchf2Wf5hBUt5nP5j+iPEahgOxGvrkPF0hsGb8HMPWgl5PcH8Tajgw7euPFG+6vl
 vauLEt/BRiMJyXAkfiZKdSMP3E2DDNQqDFhXuME5kSf3VYDSGT01HVGyDsUhcIcJiQBZ
 fYOIMZvuRoB1SrysDi6rs8rcYj/nT1f9Mz1oQR+y9LG7OmFUfxaKH/8I5Rbsys12QT4P sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvp171fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:22:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VMuk9M031540;
        Tue, 31 Jan 2023 23:22:24 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nct5d8c94-3;
        Tue, 31 Jan 2023 23:22:24 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] vdpa: conditionally read STATUS in config space
Date:   Tue, 31 Jan 2023 15:22:03 -0800
Message-Id: <1675207327-22289-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
References: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310201
X-Proofpoint-GUID: ufcRi-sJNv1PtvmeD0N4mw-BtCCUGQvB
X-Proofpoint-ORIG-GUID: ufcRi-sJNv1PtvmeD0N4mw-BtCCUGQvB
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
index 5e57935..5f4883b 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -848,18 +848,25 @@ static int vdpa_dev_net_mac_config_fill(struct sk_buff *msg, u64 features,
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
@@ -872,6 +879,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
 	if (vdpa_dev_net_mac_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
 }
 
-- 
1.8.3.1

