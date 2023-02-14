Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E3695F64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjBNJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjBNJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:38:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C293C27
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:38:29 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E8Nwip029770;
        Tue, 14 Feb 2023 09:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=abN3WeABrZKVtxO1m8F3An7TfDTw3na3P2oNLuQ0iD0=;
 b=bMDprgcBQxdcyi2GIA5mnSGE5QDvyaLEK5kBkClQn9Vu97DqG85NwKJ5NS5Gyu5+/oHF
 n+w8O9XuzI3JZ0uGT6XDB/yjqlWl02chc96ujYmXV3hYcNx8RC+hCS+n2CjHHmVH/IOY
 RfACQB4uP3s4ew15KfzopJGaIIYqg9i9EcF4BZaVz/j44P7R0uizLsUY1s//axcgxBPI
 R/dqZ27jYuNd+ACGpYb8PzL3yKgdr+5n5H9HhngC08OMDTzJfCMKovqrpWd4x0JyQn8z
 /wrJpJ43ZG4qS/AB+2LHh/4Q5+IfuzH7JpYSgNkmnnzzRyNmx74Cu6fOwNA9TzaHi6i4 PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtcvmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 09:38:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31E8hXUI018473;
        Tue, 14 Feb 2023 09:38:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5sdjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 09:38:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31E9YwXd016428;
        Tue, 14 Feb 2023 09:38:06 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1f5sdgy-1;
        Tue, 14 Feb 2023 09:38:06 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@gmail.com, error27@gmail.com, hch@lst.de,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next] ubi: block: Fix a possible use-after-free bug in ubiblock_create()
Date:   Tue, 14 Feb 2023 01:38:01 -0800
Message-Id: <20230214093801.1267044-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_06,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140082
X-Proofpoint-GUID: tf3NqCX4zp4U7_Z1qCxZJXI7tqDbV-L-
X-Proofpoint-ORIG-GUID: tf3NqCX4zp4U7_Z1qCxZJXI7tqDbV-L-
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

Smatch warns:
	drivers/mtd/ubi/block.c:438 ubiblock_create()
	warn: '&dev->list' not removed from list

'dev' is freed in 'out_free_dev:, but it is still on the list.

To fix this, delete the list item before freeing.

Fixes: 91cc8fbcc8c7 ("ubi: block: set BLK_MQ_F_BLOCKING")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Found by static analysis(smatch). Only Compile tested.
---
 drivers/mtd/ubi/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index f5d036203fe7..763704c8d05c 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -429,6 +429,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	return 0;
 
 out_remove_minor:
+	list_del(&dev->list);
 	idr_remove(&ubiblock_minor_idr, gd->first_minor);
 out_cleanup_disk:
 	put_disk(dev->gd);
-- 
2.38.1

