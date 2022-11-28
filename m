Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1698263AD12
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiK1P5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiK1P5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:57:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9432187
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:57:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASEfeVD018341;
        Mon, 28 Nov 2022 15:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=7baz+UzJOq6O95X8/mA3UQPB0CtdP1min6OyihivIO8=;
 b=JL8dyl+q9SyDdsx4+iXMhvdpLUFdScI/LgYMeJEU0NNEP3J4Kt6VyUazPYn0RbYZkZQa
 jBx+Pna4v7VBHmjeJwEmISRbJ8xr7D8+tVF/0Or1zr9O38R9CLHqpKly//QJp/Wxui/t
 r/34fBt7IJLecgzjcPayvIzFmOaYLT4mffN6VA0ssVHcNvnonnbxL/jGs4DlfqyMV9uc
 K2TFqYGIOEIThDtEVqaQFqO5D/DaghqqXBuh4BKEjmQvZCpjt1Z6jN+AHnxbEmsQBFE3
 2T1G1kbDbe44WihntGaCJGNZucT0jc3ER+exVkEnAaLNidljqbIEND9nlYK2L6gbXNh0 rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht2yj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 15:57:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ASFF0ki026827;
        Mon, 28 Nov 2022 15:57:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1thep1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 15:57:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ASFvR84011547;
        Mon, 28 Nov 2022 15:57:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3m3c1themk-1;
        Mon, 28 Nov 2022 15:57:27 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     sgarzare@redhat.com
Cc:     harshit.m.mogalapalli@oracle.com, error27@gmail.com,
        harshit.m.mogalapalli@gmail.com,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] vduse: Validate vq_num in vduse_validate_config()
Date:   Mon, 28 Nov 2022 07:57:15 -0800
Message-Id: <20221128155717.2579992-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_13,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280118
X-Proofpoint-GUID: 0O9Deg5-KTdXx-GD6rzr1sbmo-lsO3pu
X-Proofpoint-ORIG-GUID: 0O9Deg5-KTdXx-GD6rzr1sbmo-lsO3pu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a limit to 'config->vq_num' which is user controlled data which
comes from an vduse_ioctl to prevent large memory allocations.

Micheal says  - This limit is somewhat arbitrary.
However, currently virtio pci and ccw are limited to a 16 bit vq number.
While MMIO isn't it is also isn't used with lots of VQs due to
current lack of support for per-vq interrupts.
Thus, the 0xffff limit on number of VQs corresponding
to a 16-bit VQ number seems sufficient for now.

This is found using static analysis with smatch.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v1->v2: Change title of the commit and description, add a limit to
	vq_num.

v2->v3: Improve commit message to include reason for setting limit to
	0xffff

Only compile and boot tested.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 35dceee3ed56..31017ebc4d7c 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (config->config_size > PAGE_SIZE)
 		return false;
 
+	if (config->vq_num > 0xffff)
+		return false;
+
 	if (!device_is_allowed(config->device_id))
 		return false;
 
-- 
2.38.1

