Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307216A539A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjB1HQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1HQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:16:36 -0500
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 23:16:34 PST
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E467F1E9D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:16:34 -0800 (PST)
HMM_SOURCE_IP: 172.18.0.188:47480.1506508507
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.31 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 2CF652800A8;
        Tue, 28 Feb 2023 15:08:59 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([10.133.8.31])
        by app0023 with ESMTP id 165eba95a6d24e19bd117c36a44fd9d6 for linux-kernel@vger.kernel.org;
        Tue, 28 Feb 2023 15:09:27 CST
X-Transaction-ID: 165eba95a6d24e19bd117c36a44fd9d6
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 10.133.8.31
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
From:   zhenggy <zhenggy@chinatelecom.cn>
Subject: [PATCH] sched: Fix rq nr_uninterruptible count
Message-ID: <9b271641-ea59-daa5-333c-1dd1f02cdb52@chinatelecom.cn>
Date:   Tue, 28 Feb 2023 15:08:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an uninterrptable task is queue to a differect cpu as where
it is dequeued, the rq nr_uninterruptible will be incorrent, so
fix it.

Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
---
 kernel/sched/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b..cd5ef6e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4068,6 +4068,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 {
 	unsigned long flags;
 	int cpu, success = 0;
+	struct rq *src_rq, *dst_rq;

 	preempt_disable();
 	if (p == current) {
@@ -4205,6 +4206,16 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 			atomic_dec(&task_rq(p)->nr_iowait);
 		}

+		if (p->sched_contributes_to_load) {
+			src_rq = cpu_rq(task_cpu(p));
+			dst_rq = cpu_rq(cpu);
+
+			double_rq_lock(src_rq, dst_rq);
+			src_rq->nr_uninterruptible--;
+			dst_rq->nr_uninterruptible++;
+			double_rq_unlock(src_rq, dst_rq);
+		}
+
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
-- 
1.8.3.1
