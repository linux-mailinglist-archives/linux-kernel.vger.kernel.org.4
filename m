Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD176B8A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCNF1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCNF1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:27:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5DF90084
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:27:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3iOrO009247;
        Tue, 14 Mar 2023 05:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=5SLUSnIKYxP4buvBIm9cjePOKlgWL/aRgB/uzZTFkBg=;
 b=Uiue91/Rpc4KiaVrDYL6cM6O/18andQbv5Vgw9ljjg98gm8Xl9RcFXcahEnScNrT7Xgq
 42qTiDVmdG+ICKRPJtGJjr2Cc+WXWSei4Grl6s4nswnkNgSTC9QkNcGKB6y8fyGe+U9z
 hPTdaFgaazDvKwmsEc5ly75aMBbqMHfoLvLzvz4+X3uxBcJ5m6WtfL2AkerISPlZ6bm7
 aIAqrP9YjylId7Av9/2FVn6EBusVZk8z7jnU9xNvmbILfsxO65oynqVAH4w42LEYVFGK
 oiyGmilcA2+7jFUgEjSLFKbLdb6dd9EZFDHL6A11L8U31NXaVzdqAX/ew2lY4RIfVj/+ Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hpcwfgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 05:27:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32E5I1vv002320;
        Tue, 14 Mar 2023 05:27:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3c52kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 05:27:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32E5RFIB024363;
        Tue, 14 Mar 2023 05:27:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3p8g3c52k1-1;
        Tue, 14 Mar 2023 05:27:15 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Andreas Baierl <ichgeh@imkreisrum.de>,
        Simon Shields <simon@lineageos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()
Date:   Mon, 13 Mar 2023 22:27:11 -0700
Message-Id: <20230314052711.4061652-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140048
X-Proofpoint-ORIG-GUID: f2EVr6K09Hzuaf-YCWzZPzCu47m4wKKc
X-Proofpoint-GUID: f2EVr6K09Hzuaf-YCWzZPzCu47m4wKKc
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

Smatch reports:
drivers/gpu/drm/lima/lima_drv.c:396 lima_pdev_probe() warn:
	missing unwind goto?

Store return value in err and goto 'err_out0' which has
lima_sched_slab_fini() before returning.

Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested.
---
 drivers/gpu/drm/lima/lima_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 7b8d7178d09a..39cab4a55f57 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -392,8 +392,10 @@ static int lima_pdev_probe(struct platform_device *pdev)
 
 	/* Allocate and initialize the DRM device. */
 	ddev = drm_dev_alloc(&lima_drm_driver, &pdev->dev);
-	if (IS_ERR(ddev))
-		return PTR_ERR(ddev);
+	if (IS_ERR(ddev)) {
+		err = PTR_ERR(ddev);
+		goto err_out0;
+	}
 
 	ddev->dev_private = ldev;
 	ldev->ddev = ddev;
-- 
2.38.1

