Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CFF6C097B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCTDtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCTDtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:49:15 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9279A1998
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:48:34 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230320034831epoutp0360d8d3bbc2de6a40b516dd21968f044a~OBACrx1Ce0350803508epoutp03X
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:48:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230320034831epoutp0360d8d3bbc2de6a40b516dd21968f044a~OBACrx1Ce0350803508epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679284112;
        bh=5iuFslU5qlP81dxFLMLd6qVFWyrZFMo71VITTugPPa0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UC8F6YTXf+s6/0+D+OodavXAu5TAKjrmf3TBB5oIbI1yERRURa6Wdlc6O7gI2Wwx1
         aqLvZUPeZFvgLKCF4sW+/Tjh6XQ7/uI1Why9VQJuxkhC9I/rqCCbdUTe6Ts68tR43U
         d/+3ueHFU+OxwxCEGvlnQwCFXfEjBnbeXwg5emM0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230320034831epcas1p15f60d252a1eb1607e28ef93cbd71cd38~OBAB83ivm3164931649epcas1p14;
        Mon, 20 Mar 2023 03:48:31 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pg11B46q0z4x9QF; Mon, 20 Mar
        2023 03:48:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.92.52037.E87D7146; Mon, 20 Mar 2023 12:48:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230320034829epcas1p2a88958d53a51693906020bb5c2b8bc28~OBAAubEO02417824178epcas1p2M;
        Mon, 20 Mar 2023 03:48:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230320034829epsmtrp2aa67f56357dd00a42439d85441946122~OBAAtnuXY2734027340epsmtrp2M;
        Mon, 20 Mar 2023 03:48:29 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-d2-6417d78e4a2c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.A4.31821.D87D7146; Mon, 20 Mar 2023 12:48:29 +0900 (KST)
Received: from VDBS1328.vd.sec.samsung.net (unknown [168.219.243.40]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230320034829epsmtip283dcb5296bf568e1421996708e4ccd40~OBAAjdnRi2600426004epsmtip2Q;
        Mon, 20 Mar 2023 03:48:29 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bw365.lee@samsung.com, yw85.kim@samsung.com,
        huijin.park@samsung.com
Cc:     Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH v2] workqueue: Introduce show_freezable_workqueues
Date:   Mon, 20 Mar 2023 12:29:05 +0900
Message-Id: <1679282945-37120-1-git-send-email-js07.lee@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmrm7fdfEUg2tL5CxOrFnEZNFx0cVi
        6trdTBaPbv5mtZg1ZS+TxeVdc9gsPvceYbS4e+oom8XcL1OZLX4tP8po0fH5JpsDt8fOWXfZ
        PRbvecnksWlVJ5tH35ZVjB4rVn9n9/i8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7U
        zMBQ19DSwlxJIS8xN9VWycUnQNctMwfoPCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJq
        QUpOgVmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbDGx/YC9ZKVvzc2szWwNgv0sXIySEhYCLR
        sLGZqYuRi0NIYAejxJV7x9ggnE+MEmf/XmeFcD4zSlyfPxvI4QBr6WtRhIjvYpR43vwJqugX
        o8TUpfPZQeayCWhJ3Pi9CSwhIrCJSWLBpg1gCWYBDYnfB26ygNjCAk4SS3auA4uzCKhKTP09
        kRnE5hVwkThwqIsd4kA5iZvnOpkh7GvsEu0z8iBsF4kb199CxYUlXh3fAlUvJfH53V42CLtc
        YkPfNLDnJARaGCUWbX8LlTCWePd2LTPIO8wCmhLrd+lDhBUldv6eywhxJ5/Eu689UB/zSnS0
        CUGUKEm8edDCAmFLSFx43MsKYXtIvF+5nwnEFhKIlVjVO4lpAqPsLIQFCxgZVzGKpRYU56an
        FhsWGMNjKTk/dxMjOMlpme9gnPb2g94hRiYOxkOMEhzMSiK8fgtEU4R4UxIrq1KL8uOLSnNS
        iw8xmgLDayKzlGhyPjDN5pXEG5pYGpiYGZlYGFsamymJ84rbnkwWEkhPLEnNTk0tSC2C6WPi
        4JRqYNp5e//KpQfcVb7JXzv172FC8MJrlvM/6N1UlZnyWZDvr/iXeXmh+z2s52gqbAs9ZTjh
        7txUNodv89Z0/nHdbxomFO28edJ3oVM7+vmnfDu84eTHRexT2P7vsmn7HrB6hfkRgTUhlnsT
        GBIv5Cvt9fo7yeDhsw5r/T9r97ZMu3+sbMrW689Wzd3b4sbMaqnTfF7KoS5QzivtP4fM8q2u
        hXm/f7T1lL/SzFo6ad/cmyd1zk48eJPpftXuUHYJ/vSf4unBj980KH19EfaoyftCRCRTQPPa
        j8LV/2tlQk1nGIlWX9xXK+RoYS5hoX+Dk6cyYcXszOjKAysenNu7M/rbsd0Pkktsgp6eSD/R
        +TfCf8k5JZbijERDLeai4kQA+bAW7vsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvG7vdfEUg7kXDCxOrFnEZNFx0cVi
        6trdTBaPbv5mtZg1ZS+TxeVdc9gsPvceYbS4e+oom8XcL1OZLX4tP8po0fH5JpsDt8fOWXfZ
        PRbvecnksWlVJ5tH35ZVjB4rVn9n9/i8SS6ALYrLJiU1J7MstUjfLoEr4+GND+wFayUrfm5t
        Zmtg7BfpYuTgkBAwkehrUexi5OIQEtjBKPHj30fGLkZOoLiExKOdX1ggaoQlDh8uhqj5wShx
        pHMVG0gNm4CWxI3fm1hBEiICe5gkDvw4ywSSYBbQkPh94CYLiC0s4CSxZOc6dhCbRUBVYurv
        icwgNq+Ai8SBQ13sEMvkJG6e62SewMizgJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+
        7iZGcNBpae1g3LPqg94hRiYOxkOMEhzMSiK8fgtEU4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Xug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg0hKZWBqiWL5NQ+N33WrNe3YruOa+uFqncC3ooZPw
        bIeZbCtFvs76MOcsY6Ok8Dung416vMEVn1mfc979981A02NlCq/W3qenHTmzmo8JnJfc/tCx
        W2ZOY/GLK68jLBYu/LyMeV6inv/6/XMKbe7N2DT7b/pN/ftZMuXX9YKKhD80evAb32c6u2Gq
        0esiQ+kvv6vtvHrOq2+/5ZZ/5L/VEW33pfv/pLS/yQ0t4t3K26P/oO/gdMPLr2OnBwtLSC32
        CzD6o5bzP9taSE8ueGO06/t52q+8/vSk33ybPSu/wvPd/Uvbr36w3Gtn/iUnxuN5u+W/N1ZP
        pzOn/JCXsxCrYCvOeG3q0f2JqeLT8vZPSizFGYmGWsxFxYkAFeEsGqkCAAA=
X-CMS-MailID: 20230320034829epcas1p2a88958d53a51693906020bb5c2b8bc28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230320034829epcas1p2a88958d53a51693906020bb5c2b8bc28
References: <CGME20230320034829epcas1p2a88958d53a51693906020bb5c2b8bc28@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently show_all_workqueue is called if freeze fails at the time of
freeze the workqueues, which shows the status of all workqueues and of
all worker pools. In this cases we may only need to dump state of only
workqueues that are freezable and busy.

This patch defines show_freezable_workqueues, which uses 
show_one_workqueue, a granular function that shows the state of individual 
workqueues, so that dump only the state of freezable workqueues 
at that time.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
v2:                                                                              
 - Rename function to more appropriate name.                                     
 - Fit the comment to 80-col               
---
 include/linux/workqueue.h |  1 +
 kernel/power/process.c    |  2 +-
 kernel/workqueue.c        | 26 ++++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 0a10f8e..91d1d6e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -472,6 +472,7 @@ extern unsigned int work_busy(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
 extern void print_worker_info(const char *log_lvl, struct task_struct *task);
 extern void show_all_workqueues(void);
+extern void show_freezable_workqueues(void);
 extern void show_one_workqueue(struct workqueue_struct *wq);
 extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
 
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 6c1c7e5..cae81a8 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -93,7 +93,7 @@ static int try_to_freeze_tasks(bool user_only)
 		       todo - wq_busy, wq_busy);
 
 		if (wq_busy)
-			show_all_workqueues();
+			show_freezable_workqueues();
 
 		if (!wakeup || pm_debug_messages_on) {
 			read_lock(&tasklist_lock);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index de42827..8c5c1ec 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5043,8 +5043,7 @@ static void show_one_worker_pool(struct worker_pool *pool)
 /**
  * show_all_workqueues - dump workqueue state
  *
- * Called from a sysrq handler or try_to_freeze_tasks() and prints out
- * all busy workqueues and pools.
+ * Called from a sysrq handler and prints out all busy workqueues and pools.
  */
 void show_all_workqueues(void)
 {
@@ -5065,6 +5064,29 @@ void show_all_workqueues(void)
 	rcu_read_unlock();
 }
 
+/**
+ * show_freezable_workqueues - dump freezable workqueue state
+ *
+ * Called from try_to_freeze_tasks() and prints out all freezable workqueues
+ * still busy.
+ */
+void show_freezable_workqueues(void)
+{
+	struct workqueue_struct *wq;
+
+	rcu_read_lock();
+
+	pr_info("Showing freezable workqueues still busy:\n");
+
+	list_for_each_entry_rcu(wq, &workqueues, list) {
+		if (!(wq->flags & WQ_FREEZABLE))
+			continue;
+		show_one_workqueue(wq);
+	}
+
+	rcu_read_unlock();
+}
+
 /* used to show worker information through /proc/PID/{comm,stat,status} */
 void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 {
-- 
2.7.4

