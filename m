Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0C6D5911
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDDHA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjDDHAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:00:23 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 00:00:21 PDT
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 06FC210CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:00:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [40.50.201.1])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3602D18008E786;
        Tue,  4 Apr 2023 14:57:42 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 40.50.201.1
From:   Li zeming <zeming@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] sched: rt: Optimization function 'pick_next_rt_entity'
Date:   Thu,  6 Apr 2023 07:29:00 +0800
Message-Id: <20230405232900.4019-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=2.5 required=5.0 tests=DATE_IN_FUTURE_24_48,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The moral of this function is to obtain the next RT scheduling entity
object,while 'list_entry' Implementation function of  'container_of'
returns the next RT scheduling entity object (no new code should be
added afterwards), directly returning 'list_entry' The execution result
is sufficient.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
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

