Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD06A54AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjB1IsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjB1Ire (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:47:34 -0500
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 269D42CFD7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:46:31 -0800 (PST)
HMM_SOURCE_IP: 172.18.0.218:34310.1633925994
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.31 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id EBCF52800F0;
        Tue, 28 Feb 2023 16:46:06 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([10.133.8.31])
        by app0025 with ESMTP id 055752f04d6d4495920f808aaaea11ec for linux-kernel@vger.kernel.org;
        Tue, 28 Feb 2023 16:46:20 CST
X-Transaction-ID: 055752f04d6d4495920f808aaaea11ec
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 10.133.8.31
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
To:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        srw@sladewatkins.net
Cc:     linux-kernel@vger.kernel.org
From:   zhenggy <zhenggy@chinatelecom.cn>
Subject: [PATCH] sched: Fix rq nr_uninterruptible count
Message-ID: <95d8be30-986c-4a2f-6913-a7813556874a@chinatelecom.cn>
Date:   Tue, 28 Feb 2023 16:46:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
