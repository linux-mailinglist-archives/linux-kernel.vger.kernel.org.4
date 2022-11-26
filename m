Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB86393CA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 05:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKZEAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 23:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZEAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 23:00:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863C2CCB7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 20:00:33 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ390WW005777;
        Sat, 26 Nov 2022 04:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=86FpH3oiEaRToGTOfAbl1a68NK0H++B6xU/ccV5PssI=;
 b=SxijZMQUN0pbxslbw01JRRVyFEhksxWOUlSz8H62yoDjPN8gGBidEwFqNSNssg98+muA
 ESVjwVx5mzPo3gXvG9eBAlNP1EXJs7TKqz8T8s6Ie+LkHT0PVTQpDB9vWSS7uLYVyQ27
 Y3bGx87XgUIR124JSiX1shSmPqkErCNiETThLaRwm7aO+E9qFI7A/JxIWdXmWPczTHjh
 n78ewfLrptFViNxAH/NkC0roECjR3rz8x8jnahkhMLOfVgS6EOvNmsyD+VpQEXvK7b8o
 NSFO6GwBNc4cflBSi4sv/tQaOj48PxrmF6jPYxcBhp1l8dHVFmWG78JWBHpQn7gS5/UC qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39dfr2d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 04:00:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1XkV4007555;
        Sat, 26 Nov 2022 04:00:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3988c6pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 04:00:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AQ40KIw039282;
        Sat, 26 Nov 2022 04:00:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3m3988c6jw-1;
        Sat, 26 Nov 2022 04:00:20 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@oracle.com, error27@gmail.com,
        harshit.m.mogalapalli@gmail.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Guanjun <guanjun@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
Date:   Fri, 25 Nov 2022 19:59:58 -0800
Message-Id: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260029
X-Proofpoint-ORIG-GUID: _Sfm4z2GCsIcp460MDMbNp7fhdcBRdKI
X-Proofpoint-GUID: _Sfm4z2GCsIcp460MDMbNp7fhdcBRdKI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 'dev->vq_num' is user-controlled data, if user tries to allocate
memory larger than(>=) MAX_ORDER, then kcalloc() will fail, it
creates a stack trace and messes up dmesg with a warning.

Call trace:
-> vduse_ioctl
--> vduse_create_dev
'config->vq_num' is user data as it comes from ioctl, which is
assigned to 'dev->vq_num'.

Add __GFP_NOWARN in order to avoid too large allocation warning.
This is detected by static analysis using smatch.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 35dceee3ed56..5e9546b16165 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1512,7 +1512,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->config_size = config->config_size;
 	dev->vq_align = config->vq_align;
 	dev->vq_num = config->vq_num;
-	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
+	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs),
+			   GFP_KERNEL | __GFP_NOWARN);
 	if (!dev->vqs)
 		goto err_vqs;
 
-- 
2.38.1

