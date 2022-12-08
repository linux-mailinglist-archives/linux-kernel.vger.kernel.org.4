Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30339646630
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLHA6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLHA6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:58:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E9B55C8A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:58:10 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B80ENuT017605;
        Thu, 8 Dec 2022 00:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=tR4J0ENApu7V6J6cHaQ+088HmoYLX3qp6nekwCS6xyI=;
 b=gD+p0BuxkVvNCy8cqCrkkuSzPrYb8850SgyRU61kv0R7QM7rkoOOJd+Ahnme1FvH7Ptm
 koC22rp7A7IOJwL8vglngib+2ty6j2gE5lUQd0nqk/ieC4VvkySV9EOzpxwxew66xTwB
 sxFOdaPqy5p2sXD1G7sZ3Mb6VXSoxi8oxwAm0QH3+cf/FVjTBBMNsOHIHczKLADsmwST
 WCLNo2d6docf/CuZbM4+lrA+rpXHXzo38C3/2xpWWj2T1HrN0PDwp8l8p1mrFhxNo6oH
 UI1VK7vp6m0bf1JU4S/NnTzV3d6QULSmltoFlujnnAniuFqEd1cyJCVnOyGQxXE3XIk+ Fg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3maww69672-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 00:58:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B80w6WJ000370
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 00:58:06 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 16:58:06 -0800
From:   John Moon <quic_johmoo@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     John Moon <quic_johmoo@quicinc.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] workqueue: Check for null pointer return from get_work_pwq()
Date:   Wed, 7 Dec 2022 16:53:44 -0800
Message-ID: <20221208005344.25195-1-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UAKEu7DJSSNipv1lyhZ0CL777UioTYIx
X-Proofpoint-ORIG-GUID: UAKEu7DJSSNipv1lyhZ0CL777UioTYIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080003
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've encountered a kernel panic with the following stack trace:

-> ret_from_fork
 -> kthread
  -> worker_thread
   -> process_one_work
    -> pwq_dec_nr_in_flight
     -> pwq_activate_inactive_work

The issue was narrowed down to a null pointer dereference within
pwq_activate_inactive_work() stemming from the return value of
get_work_pwq() which may return NULL, but was not checked for
null return prior to use.

While fixing the issue, other dereferences of get_work_pwq()'s
return value were found without a null check.

Add null pointer checks to the calling functions that need them.

Signed-off-by: John Moon <quic_johmoo@quicinc.com>
---
 kernel/workqueue.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1..5de0a2e1aeaa 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1162,6 +1162,9 @@ static void pwq_activate_inactive_work(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);

+	if (!pwq)
+		return;
+
 	trace_workqueue_activate_work(work);
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
@@ -2030,8 +2033,12 @@ static void idle_worker_timeout(struct timer_list *t)
 static void send_mayday(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
-	struct workqueue_struct *wq = pwq->wq;
+	struct workqueue_struct *wq;
+
+	if (!pwq)
+		return;

+	wq = pwq->wq;
 	lockdep_assert_held(&wq_mayday_lock);

 	if (!wq->rescuer)
@@ -2184,9 +2191,10 @@ __acquires(&pool->lock)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
 	struct worker_pool *pool = worker->pool;
-	bool cpu_intensive = pwq->wq->flags & WQ_CPU_INTENSIVE;
+	bool cpu_intensive;
 	unsigned long work_data;
 	struct worker *collision;
+
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * It is permissible to free the struct work_struct from
@@ -2199,6 +2207,11 @@ __acquires(&pool->lock)

 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	if (!pwq)
+		return;
+
+	cpu_intensive = pwq->wq->flags & WQ_CPU_INTENSIVE;
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
--
2.17.1

