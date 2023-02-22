Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1064969EFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjBVIDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBVIDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:03:34 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21013D50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:03:31 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 31M83Iws082845;
        Wed, 22 Feb 2023 16:03:18 +0800 (+08)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from BJ10918NBW01.spreadtrum.com (10.0.74.60) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 22 Feb 2023 16:03:17 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <vincent.guittot@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>
CC:     <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <qyousef@layalina.io>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <zhaoyang.huang@unisoc.com>
Subject: [RFC PATCH] sched/fair: update the vruntime to be max vruntime when yield
Date:   Wed, 22 Feb 2023 16:03:14 +0800
Message-ID: <20230222080314.2146-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.60]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 31M83Iws082845
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When task call the sched_yield, cfs would set the cfs's skip buddy.
If there is no other task call the sched_yield syscall, the task would
always be skiped when there are tasks in rq. As a result, the task's
vruntime would not be updated for long time, and the cfs's min_vruntime
is almost not updated.
When this scenario happens, when the yield task had wait for a long time,
and other tasks run a long time, once there is other task call the sched_yield,
the cfs's skip_buddy is covered, at this time, the first task can run normally,
but the task's vruntime is small, as a result, the task would always run,
because other task's vruntime is big. This would lead to other tasks can not
run for a long time.
In order to mitigate this, update the yield_task's vruntime to be cfs's max vruntime.
This way, the cfs's min vruntime can be updated as the process running.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff4dbbae3b10..a9ff1921fc07 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -670,7 +670,6 @@ static struct sched_entity *__pick_next_entity(struct sched_entity *se)
 	return __node_2_se(next);
 }
 
-#ifdef CONFIG_SCHED_DEBUG
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *last = rb_last(&cfs_rq->tasks_timeline.rb_root);
@@ -681,6 +680,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 	return __node_2_se(last);
 }
 
+#ifdef CONFIG_SCHED_DEBUG
 /**************************************************************
  * Scheduling class statistics methods:
  */
@@ -7751,8 +7751,18 @@ static void set_next_buddy(struct sched_entity *se)
 
 static void set_skip_buddy(struct sched_entity *se)
 {
-	for_each_sched_entity(se)
-		cfs_rq_of(se)->skip = se;
+	for_each_sched_entity(se) {
+		struct sched_entity *last;
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		last = __pick_last_entity(cfs_rq);
+		if (last) {
+			se->vruntime = last->vruntime;
+			update_min_vruntime(cfs_rq);
+		}
+
+		cfs_rq->skip = se;
+	}
 }
 
 /*
-- 
2.25.1

