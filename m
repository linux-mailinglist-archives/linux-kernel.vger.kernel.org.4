Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDBF6D8CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjDFBio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjDFBil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:38:41 -0400
Received: from mail.nfschina.com (unknown [42.101.60.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3383D6A45
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:38:38 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 16A321A00B04;
        Thu,  6 Apr 2023 09:38:51 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eVFBE7vZW73S; Thu,  6 Apr 2023 09:38:50 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 083B31A00B02;
        Thu,  6 Apr 2023 09:38:50 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH v2] sched: rt: Simplify pick_next_rt_entity()
Date:   Sat,  8 Apr 2023 02:09:52 +0800
Message-Id: <20230407180952.2757-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=2.5 required=5.0 tests=DATE_IN_FUTURE_24_48,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless intermediate variable "next" and its initialization. 
Directly return the next RT scheduling entity obtained from
list_entry().

Signed-off-by: Li zeming <zeming@nfschina.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 v2: Simplify title and descriptive information.
 
 kernel/sched/rt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a11f44adee5..e9b1c08c20a7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1769,7 +1769,6 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 {
 	struct rt_prio_array *array = &rt_rq->active;
-	struct sched_rt_entity *next = NULL;
 	struct list_head *queue;
 	int idx;
 
@@ -1779,9 +1778,8 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	queue = array->queue + idx;
 	if (SCHED_WARN_ON(list_empty(queue)))
 		return NULL;
-	next = list_entry(queue->next, struct sched_rt_entity, run_list);
 
-	return next;
+	return list_entry(queue->next, struct sched_rt_entity, run_list);
 }
 
 static struct task_struct *_pick_next_task_rt(struct rq *rq)
-- 
2.18.2

