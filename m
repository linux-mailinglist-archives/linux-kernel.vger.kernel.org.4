Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BCF6DE9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDLDHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLDHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:07:44 -0400
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E74225
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:07:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.SDVQYX4_1681268855;
Received: from localhost(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.SDVQYX4_1681268855)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 11:07:36 +0800
From:   "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>,
        "Tiwei Bie" <tiwei.btw@antgroup.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>
Subject: [PATCH v1 1/3] sched/debug: use int type and fix wrong print for rq->nr_uninterruptible
Date:   Wed, 12 Apr 2023 11:07:29 +0800
Message-Id: <20230412030731.24990-2-yanyan.yan@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230412030731.24990-1-yanyan.yan@antgroup.com>
References: <20230412030731.24990-1-yanyan.yan@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e6fe3f422be1 ("sched: Make multiple runqueue task counters
32-bit") changed rq->nr_uninterruptible from 'unsigned long'
to 'unsigned int', but left the wrong print to
/sys/kernel/debug/sched/debug and to the console.

For example:
Current type is 'unsigned int' and value is fffffff7, and the print
will run the sentences,
"do {                                    \
    if (sizeof(rq->x) == 4)                     \
        SEQ_printf(m, "  .%-30s: %ld\n", #x, (long)(rq->x));    \
    else                                \
        SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rq->x));\
} while (0)"

The result will be 4294967287 on 64-bit machines to print (long)(rq->x)
while old type 'unsigned long' will print -9.

And the other places that use its value will cast to int to return
expected output, so we convert its type from 'unsigned int' to int.

Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
---
 kernel/sched/loadavg.c | 2 +-
 kernel/sched/sched.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 52c8f8226b0d..b9867495fe8b 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -80,7 +80,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta = 0;
 
 	nr_active = this_rq->nr_running - adjust;
-	nr_active += (int)this_rq->nr_uninterruptible;
+	nr_active += this_rq->nr_uninterruptible;
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 060616944d7a..23c643948331 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1006,7 +1006,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned int		nr_uninterruptible;
+	int			nr_uninterruptible;
 
 	struct task_struct __rcu	*curr;
 	struct task_struct	*idle;
-- 
2.32.0.3.g01195cf9f

