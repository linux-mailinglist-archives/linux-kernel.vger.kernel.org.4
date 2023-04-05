Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0736D72BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 05:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjDEDpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 23:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDEDph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 23:45:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869A1FDC;
        Tue,  4 Apr 2023 20:45:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3353J0cE011364;
        Wed, 5 Apr 2023 03:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Gwy0gUUDVIKwmdSLAshT/Nv+elDm6vPmvEHPdc9zEm4=;
 b=AgfNefaOGgeg0nC2At1FgHK2M+/CGFRrYtNGCI6JGgUVma7nRBNnaPnCTomMinBlkRKB
 Zn2pGlc0ohFCqxDgj4qknnIgd41aOF13cFGdOfJbBsa3xaEGFtPDuLVGN5761gC868u/
 +ackCmThx2QfwGCFedBgEfEn52vEiQBjhSD1RmoFtKnqF7Ijh0jj8cTT67MGhOYZBUua
 r9l3gjWnZKVSb2jIWVhQuSquHnuqzXhXsT7q1S670qP9pqrnkuyLPy1s/CEqtlaNqVhp
 6x+BQ2KXgN7j0ypdR0Lr3KexHvBJmDbnkC7MPcEMsUGAEnQFfCu3rbgV8lxJQ7YR6jhL YA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prmkmsx88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 03:45:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3353jF7D000300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 03:45:15 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 4 Apr 2023
 20:45:12 -0700
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Nikhil V <quic_nprakash@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Pavankumar Kondeti" <quic_pkondeti@quicinc.com>
Subject: [PATCH] PM: hibernate: Get test_resume hibernation mode working again
Date:   Wed, 5 Apr 2023 09:15:02 +0530
Message-ID: <20230405034502.583304-1-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hr-vqyOnHU2h3qgbrP5xyP-YbTWDT6EX
X-Proofpoint-ORIG-GUID: Hr-vqyOnHU2h3qgbrP5xyP-YbTWDT6EX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_14,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050033
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in
swsusp_check()") changed the opening mode of the block device to
(FMODE_READ | FMODE_EXCL) during resume. This breaks the test_resume
hibernation mode as the block device is not available for exclusive
open. Because the block device is configured as swap during hibernation.

Fix this issue by opening the device in FMODE_READ only in test_resume
restore path. Cache the flags used in opening the block device so that
callers of swsusp_close() does not need to worry about test_resume vs
normal restore.

Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 kernel/power/hibernate.c | 21 +++++++++++-----
 kernel/power/power.h     |  4 +--
 kernel/power/swap.c      | 53 +++++++++++++++++++++++-----------------
 3 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 793c55a2becb..d78edf32a45c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -693,12 +693,12 @@ static int load_image_and_restore(void)
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
 	if (error) {
-		swsusp_close(FMODE_READ | FMODE_EXCL);
+		swsusp_close();
 		goto Unlock;
 	}
 
 	error = swsusp_read(&flags);
-	swsusp_close(FMODE_READ | FMODE_EXCL);
+	swsusp_close();
 	if (!error)
 		error = hibernation_restore(flags & SF_PLATFORM_MODE);
 
@@ -785,7 +785,12 @@ int hibernate(void)
 	unlock_device_hotplug();
 	if (snapshot_test) {
 		pm_pr_dbg("Checking hibernation image\n");
-		error = swsusp_check();
+		/*
+		 * Block device assigned for storing hibernation image
+		 * is already configured as swap. So exclusive mode
+		 * is not needed. see comments in software_resume().
+		 */
+		error = swsusp_check(FMODE_READ);
 		if (!error)
 			error = load_image_and_restore();
 	}
@@ -983,14 +988,18 @@ static int software_resume(void)
 		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
 	pm_pr_dbg("Looking for hibernation image.\n");
-	error = swsusp_check();
+	/*
+	 * Exclusively get the block device that contains the hibernation
+	 * image so that we can bail out if the block device is mounted.
+	 */
+	error = swsusp_check(FMODE_READ | FMODE_EXCL);
 	if (error)
 		goto Unlock;
 
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
-		swsusp_close(FMODE_READ | FMODE_EXCL);
+		swsusp_close();
 		goto Unlock;
 	}
 
@@ -1025,7 +1034,7 @@ static int software_resume(void)
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(FMODE_READ | FMODE_EXCL);
+	swsusp_close();
 	goto Finish;
 }
 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b4f433943209..9877f33cc966 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -173,11 +173,11 @@ extern int swsusp_swap_in_use(void);
 #define SF_HW_SIG		8
 
 /* kernel/power/hibernate.c */
-extern int swsusp_check(void);
+extern int swsusp_check(fmode_t mode);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
-extern void swsusp_close(fmode_t);
+extern void swsusp_close(void);
 #ifdef CONFIG_SUSPEND
 extern int swsusp_unmark(void);
 #endif
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 277434b6c0bf..005c0cfe116a 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -338,6 +338,28 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 	return error;
 }
 
+static fmode_t hib_resume_bdev_mode;
+static int swsusp_setup_bdev(fmode_t mode)
+{
+	struct block_device *bdev;
+	void *holder;
+	int error;
+
+	bdev = blkdev_get_by_dev(swsusp_resume_device, mode, &holder);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	error = set_blocksize(bdev, PAGE_SIZE);
+	if (error) {
+		blkdev_put(bdev, mode);
+		return error;
+	}
+
+	hib_resume_bdev = bdev;
+	hib_resume_bdev_mode = mode;
+	return 0;
+}
+
 /**
  *	swsusp_swap_check - check if the resume device is a swap device
  *	and get its index (if so)
@@ -356,15 +378,7 @@ static int swsusp_swap_check(void)
 		return res;
 	root_swap = res;
 
-	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, FMODE_WRITE,
-			NULL);
-	if (IS_ERR(hib_resume_bdev))
-		return PTR_ERR(hib_resume_bdev);
-
-	res = set_blocksize(hib_resume_bdev, PAGE_SIZE);
-	if (res < 0)
-		blkdev_put(hib_resume_bdev, FMODE_WRITE);
-
+	res = swsusp_setup_bdev(FMODE_WRITE);
 	return res;
 }
 
@@ -443,7 +457,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
 err_rel:
 	release_swap_writer(handle);
 err_close:
-	swsusp_close(FMODE_WRITE);
+	swsusp_close();
 	return ret;
 }
 
@@ -508,7 +522,7 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 	if (error)
 		free_all_swap_pages(root_swap);
 	release_swap_writer(handle);
-	swsusp_close(FMODE_WRITE);
+	swsusp_close();
 
 	return error;
 }
@@ -1514,15 +1528,12 @@ int swsusp_read(unsigned int *flags_p)
  *      swsusp_check - Check for swsusp signature in the resume device
  */
 
-int swsusp_check(void)
+int swsusp_check(fmode_t mode)
 {
 	int error;
-	void *holder;
 
-	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    FMODE_READ | FMODE_EXCL, &holder);
-	if (!IS_ERR(hib_resume_bdev)) {
-		set_blocksize(hib_resume_bdev, PAGE_SIZE);
+	error = swsusp_setup_bdev(mode);
+	if (!error) {
 		clear_page(swsusp_header);
 		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
 					swsusp_header, NULL);
@@ -1547,11 +1558,9 @@ int swsusp_check(void)
 
 put:
 		if (error)
-			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
+			blkdev_put(hib_resume_bdev, mode);
 		else
 			pr_debug("Image signature found, resuming\n");
-	} else {
-		error = PTR_ERR(hib_resume_bdev);
 	}
 
 	if (error)
@@ -1564,14 +1573,14 @@ int swsusp_check(void)
  *	swsusp_close - close swap device.
  */
 
-void swsusp_close(fmode_t mode)
+void swsusp_close(void)
 {
 	if (IS_ERR(hib_resume_bdev)) {
 		pr_debug("Image device not initialised\n");
 		return;
 	}
 
-	blkdev_put(hib_resume_bdev, mode);
+	blkdev_put(hib_resume_bdev, hib_resume_bdev_mode);
 }
 
 /**
-- 
2.25.1

