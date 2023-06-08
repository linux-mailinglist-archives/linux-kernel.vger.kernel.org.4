Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822B9727749
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjFHGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjFHGd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:33:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650511BE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:33:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2565b864f9aso132241a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686206033; x=1688798033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YqsjZstkNId62swixNvbney3wfAymRF6traYgOxlKU=;
        b=VvAzPvj6ETKo1K1LNWU9SVbXwvfpAx1H6zx3BKkWoA7PyMTwrXW+LDqkF6ly951H/w
         rIKa0AF1kufFYHjUlDDTIr677+Twj+lu5cThh0IHA+/JDCSxq0ccn8A+ttolieNs2V7R
         wFK42BqwjHZsZyqJzb4aH/XpH6cSKIiXxGJxcOmXyD166sPLApKSuDglhUH+rEC6bY8L
         sCoYRB0tNTmEpUiSYxA9gbeEMgiiYixFpAIOvQlJoCHo3IK2aBvk0YbW5H19T/Gdfpjr
         odlKyORp3XTGOEVHGblNoI5XaJ300pMrs5CMl5i1wle6dPg2TNFlfqmK7GijpTvSolrb
         D4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206033; x=1688798033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YqsjZstkNId62swixNvbney3wfAymRF6traYgOxlKU=;
        b=byN8YlPUHHc6apevOYb1oLfeUNtgLYvcOg3vTxjDQcKyXhGxZucGJ4c/764zrA0YGV
         XM5OYLtRnQhruQwK30qQqEqDj3I8FofUpYOaqxHAhqWN0nElIS54KvfJZne8UXO0aGlL
         JB5WiFfnUkQM4qSo7n8Tm63jYTdqhMmUaZokjz7TVpRbLpRVJUygcBgiyb9SWAp8sj8x
         hodnFqSyU+SjV3Low0FkuyOeNkFSleIloZ2RyR228xGt/f/JlgjNE5Eg59x6egQmQSDo
         n9rrSkqjTZLoUdfjhDbtR7kF2QzPGnucttEueidnpsRvdSSErmk2ziT2dAtHCQ33/NEG
         Arpg==
X-Gm-Message-State: AC+VfDxbnmC1LO5SSWN+m+FBVm1SXo/6w7Tid2pnis+kXgE592mH4RKh
        SUxmQ+0Wom7KB8XhuNULokJuTg==
X-Google-Smtp-Source: ACHHUZ5ZjZyJ1ghbLTjSbNlK3NgdDJ9G7hTbFf37+0CCB+RimOwK850659eXZoG5UnoGtO+zYo7xWA==
X-Received: by 2002:a17:90a:c581:b0:256:16e:e9dd with SMTP id l1-20020a17090ac58100b00256016ee9ddmr4027769pjt.32.1686206032922;
        Wed, 07 Jun 2023 23:33:52 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c15-20020a17090abf0f00b0025645d118adsm542039pjs.14.2023.06.07.23.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:33:52 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v4 4/4] sched/core: Avoid multiple calling update_rq_clock() in unthrottle_offline_cfs_rqs()
Date:   Thu,  8 Jun 2023 14:33:12 +0800
Message-Id: <20230608063312.79440-5-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230608063312.79440-1-jiahao.os@bytedance.com>
References: <20230608063312.79440-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
------------[ cut here ]------------
rq->clock_update_flags & RQCF_UPDATED
WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
update_rq_clock+0xaf/0x180
Call Trace:
 <TASK>
 unthrottle_cfs_rq+0x4b/0x300
 rq_offline_fair+0x89/0x90
 set_rq_offline.part.118+0x28/0x60
 rq_attach_root+0xc4/0xd0
 cpu_attach_domain+0x3dc/0x7f0
 partition_sched_domains_locked+0x2a5/0x3c0
 rebuild_sched_domains_locked+0x477/0x830
 rebuild_sched_domains+0x1b/0x30
 cpuset_hotplug_workfn+0x2ca/0xc90
 ? balance_push+0x56/0xf0
 ? _raw_spin_unlock+0x15/0x30
 ? finish_task_switch+0x98/0x2f0
 ? __switch_to+0x291/0x410
 ? __schedule+0x65e/0x1310
 process_one_work+0x1bc/0x3d0
 worker_thread+0x4c/0x380
 ? preempt_count_add+0x92/0xa0
 ? rescuer_thread+0x310/0x310
 kthread+0xe6/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30

The rq clock has been updated before the set_rq_offline()
function runs, so we don't need to call update_rq_clock() in
unthrottle_offline_cfs_rqs().
We only need to call rq_clock_start_loop_update() before the
loop starts and rq_clock_stop_loop_update() after the loop
to avoid this warning.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af9604f4b135..9e961e0ec971 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6124,6 +6124,13 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * The rq clock has already been updated before the
+	 * set_rq_offline() runs, so we should skip updating
+	 * the rq clock again in unthrottle_cfs_rq().
+	 */
+	rq_clock_start_loop_update(rq);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
@@ -6146,6 +6153,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 			unthrottle_cfs_rq(cfs_rq);
 	}
 	rcu_read_unlock();
+
+	rq_clock_stop_loop_update(rq);
 }
 
 #else /* CONFIG_CFS_BANDWIDTH */
-- 
2.37.0 (Apple Git-136)

