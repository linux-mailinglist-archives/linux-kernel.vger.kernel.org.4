Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8253362579A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiKKKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiKKKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:05:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F9C1A203;
        Fri, 11 Nov 2022 02:05:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AB9jdfB026728;
        Fri, 11 Nov 2022 10:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=r9IxkJsE3GIu/PmZ1JLTRNQDdYBAZCYJzCL6kurRVTI=;
 b=hvPt/Fz93QTt8mQ+znKdaVwdZNve48del3RynzOrzTclcI5lmrA6vNqRxnRn0MHKhyMl
 So8QEplZWFWSsf67zibh3nRtSt1RQFbPnFwb4UibOu3Q9HriQPgRBURv2WQLOum4YSVK
 ptG//bDEBajVTcHzGBGrxKZ+nuxf/X+RElkT09S0p3qAJe9/CINVYT3SLuI4bULWam0F
 oAZn4LFtTbdT9fvUk8VCPV9q/Rz0HlQlxRG3m0SYV5V12D/txtCts3i15RHwRTqRjS7v
 puNHA1AoYfaVrk9VetggPKRY1aGPiMFhF7jNZt7XaVtWeB3Z6bZFw4n7Q6OhWw/dyARw Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksm1sg5f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 10:05:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABA3KL4038310;
        Fri, 11 Nov 2022 10:05:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctgdy1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 10:05:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ABA3kVb040152;
        Fri, 11 Nov 2022 10:05:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kpctgdy1b-1;
        Fri, 11 Nov 2022 10:05:35 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@oracle.com, error27@gmail.com,
        harshit.m.mogalapalli@gmail.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: scsi_debug: Fix a warning in resp_write_scat()
Date:   Fri, 11 Nov 2022 02:05:25 -0800
Message-Id: <20221111100526.1790533-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110067
X-Proofpoint-ORIG-GUID: ySnVW40xYn-1dsdHGU3cCq2rqoWCQt0m
X-Proofpoint-GUID: ySnVW40xYn-1dsdHGU3cCq2rqoWCQt0m
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

As 'lbdof_blen' is coming from user, if the size in kzalloc()
is >= MAX_ORDER then we hit a warning.

Call trace:

sg_ioctl
 sg_ioctl_common
   scsi_ioctl
    sg_scsi_ioctl
     blk_execute_rq
      blk_mq_sched_insert_request
       blk_mq_run_hw_queue
        __blk_mq_delay_run_hw_queue
         __blk_mq_run_hw_queue
          blk_mq_sched_dispatch_requests
           __blk_mq_sched_dispatch_requests
            blk_mq_dispatch_rq_list
             scsi_queue_rq
              scsi_dispatch_cmd
               scsi_debug_queuecommand
                schedule_resp
                 resp_write_scat

If you try to allocate a memory larger than(>=) MAX_ORDER, then kmalloc()
will definitely fail.  It creates a stack trace and messes up dmesg.
The user controls the size here so if they specify a too large size it
will fail.

Add __GFP_NOWARN in order to avoid too large allocation warning.
This is detected by static analysis using smatch.

Fixes: 481b5e5c7949 ("scsi: scsi_debug: add resp_write_scat function")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 697fc57bc711..273224d29ce9 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -3778,7 +3778,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 		mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_FIELD_IN_CDB, 0);
 		return illegal_condition_result;
 	}
-	lrdp = kzalloc(lbdof_blen, GFP_ATOMIC);
+	lrdp = kzalloc(lbdof_blen, GFP_ATOMIC | __GFP_NOWARN);
 	if (lrdp == NULL)
 		return SCSI_MLQUEUE_HOST_BUSY;
 	if (sdebug_verbose)
-- 
2.38.1

