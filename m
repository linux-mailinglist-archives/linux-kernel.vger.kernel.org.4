Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920196D90C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjDFHqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjDFHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:46:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C701B0;
        Thu,  6 Apr 2023 00:46:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3366wSKC013882;
        Thu, 6 Apr 2023 07:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=IyEmgHIUX6mQHOFxo3TU81FvsDpncR3Vt/+XHIZJcc0=;
 b=jLyAe9fMXWMM45769fZXZ682Z+QRYXNNcFALPa/KaJumEYelxQ1UeoYi9NbMFhLRgHK5
 npGF+5V/FJfshS4kP40xzkE6+mWhdQ1kxQuJsDP8S40QYCazTlw7kGfRDs1tZ/6pC5CH
 SRIXV09yFfSPaudfrMWOQDpsUlrIvbmIGk6YzXEcViW0t+JRyivQUf35iV9LPTEwJBaE
 pJ2qNVYcQ4/cG8afjA/2Qg8uIW8MaFy37D14VRYCgA1lkhCbkuhehIu9cROYdhawvyLo
 rS0bMJzr8bmSwTdUdAPS+d9cgDmHvKHZXYXvQ/cD24Pnof3E6hC4B6rsmrvbHlTNaUXz Ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd428fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 07:46:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3367jFkZ037592;
        Thu, 6 Apr 2023 07:46:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjuugdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 07:46:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3367kBG6013933;
        Thu, 6 Apr 2023 07:46:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjuugd0-1;
        Thu, 06 Apr 2023 07:46:10 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, kernel-janitors@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH next] scsi: scsi_debug: Fix missing error code in scsi_debug_init()
Date:   Thu,  6 Apr 2023 00:46:07 -0700
Message-Id: <20230406074607.3637097-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060068
X-Proofpoint-ORIG-GUID: RejnskUDGrw5vYzKs-DyvavE5uh8H8w5
X-Proofpoint-GUID: RejnskUDGrw5vYzKs-DyvavE5uh8H8w5
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports: drivers/scsi/scsi_debug.c:6996
	scsi_debug_init() warn: missing error code 'ret'

Although it is unlikely that KMEM_CACHE might fail, but if
it does then ret might be zero. So to fix this explicitly
mark ret as "-ENOMEM" and then goto driver_unreg.

Fixes: 1107c7b24ee3 ("scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is from static analysis, Only compile tested.
---
 drivers/scsi/scsi_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index cf3f58e8f733..f4fa1035a191 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6992,8 +6992,10 @@ static int __init scsi_debug_init(void)
 	sdebug_add_host = 0;
 
 	queued_cmd_cache = KMEM_CACHE(sdebug_queued_cmd, SLAB_HWCACHE_ALIGN);
-	if (!queued_cmd_cache)
+	if (!queued_cmd_cache) {
+		ret = -ENOMEM;
 		goto driver_unreg;
+	}
 
 	for (k = 0; k < hosts_to_add; k++) {
 		if (want_store && k == 0) {
-- 
2.38.1

