Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B60D683A51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjAaXWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjAaXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:22:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6C510421
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:22:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiH7A021428;
        Tue, 31 Jan 2023 23:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=r0Xf7HwYTIa5HdBeaweSNt2PODdB5AMoLanWqL4vsmE=;
 b=BUnktRU2vwxC/uFjHpEvn6ISYNM1vWBs/qmac0ANisN6YzjgOuGQ1LvA3c/63h2fQ8l+
 HXFba+DVS68CjBHXNkqXR1tVQ4atC3AIe3dIuU3CqFRe2vxLJlJmPxP7SVWePb1RyhMQ
 P7bJtVRBQjxwAr01OY8hVDqPIPp+AwyJHr3C9hibR+3rPkndTb2qiDZpAVlX+6uJw08C
 xOz6tsFB+X0+BiN/qxX2dGax/BbJjOGdDysiBdWkDezURD2MIfWnievjhi1BK3k8lHaD
 fnFILnVqej6Ww1nEIQUd2doXiGHpYHVbtI/+i0pUfme55QzczLT3A/xhamLatR12Vg2T PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvr8q23c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:22:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VMuk9L031540;
        Tue, 31 Jan 2023 23:22:24 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nct5d8c94-2;
        Tue, 31 Jan 2023 23:22:23 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] vdpa: fix improper error message when adding vdpa dev
Date:   Tue, 31 Jan 2023 15:22:02 -0800
Message-Id: <1675207327-22289-2-git-send-email-si-wei.liu@oracle.com>
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
X-Proofpoint-GUID: L0k5arDU938cX72WhdbrMRGjMC5w9dFr
X-Proofpoint-ORIG-GUID: L0k5arDU938cX72WhdbrMRGjMC5w9dFr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In below example, before the fix, mtu attribute is supported
by the parent mgmtdev, but the error message showing "All
provided are not supported" is just misleading.

$ vdpa mgmtdev show
vdpasim_net:
  supported_classes net
  max_supported_vqs 3
  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

$ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
Error: vdpa: All provided attributes are not supported.
kernel answers: Operation not supported

After fix, the relevant error message will be like:

$ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
Error: vdpa: Some provided attributes are not supported.
kernel answers: Operation not supported

$ vdpa dev add mgmtdev vdpasim_net name vdpasim0 max_vqp 2
Error: vdpa: All provided attributes are not supported.
kernel answers: Operation not supported

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8ef7aa1..5e57935 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -622,13 +622,20 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		err = PTR_ERR(mdev);
 		goto err;
 	}
-	if ((config.mask & mdev->config_attr_mask) != config.mask) {
+	if (config.mask && (config.mask & mdev->config_attr_mask) == 0) {
 		NL_SET_ERR_MSG_MOD(info->extack,
 				   "All provided attributes are not supported");
 		err = -EOPNOTSUPP;
 		goto err;
 	}
 
+	if ((config.mask & mdev->config_attr_mask) != config.mask) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "Some provided attributes are not supported");
+		err = -EOPNOTSUPP;
+		goto err;
+	}
+
 	err = mdev->ops->dev_add(mdev, name, &config);
 err:
 	up_write(&vdpa_dev_lock);
-- 
1.8.3.1

