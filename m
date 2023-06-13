Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33E772DC39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbjFMIUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbjFMIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:20:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6210CE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-54fb1bbc3f2so634763a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686644450; x=1689236450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmxLgmswZPkTWLyb16LsS4t5xijTdvKxqhRrgOY0CXw=;
        b=UNWb0MvVXp+6wHq3c8yC/rxzKPoWksmJfE/2gZyZScKPsCcbWFuOIYiNxPrpc237vj
         L91FaUJT+HKcOGSS7C7JDWn4sabCDVIiWMR73d/27lQYgpqlNjQ5pzuVt54HJ3jp6GdK
         EEIDhXQ1BVz7iz05mg1JNRknESZ5h8t6NjOKafgFM6ugYiIr+vG8cVpcf5SOdvBlVjDr
         cUlBRw1XS16C9c/QnZKc/QR0M7Epw6bfhGhUfzvFpmJItrOPzzo2JR0LXQohHbJNLbu/
         lKFfdMOKJucRp4X6muZjN9ZLwkeLY4VcoQsx8/msfkAJ2TgvKv0ssImyX41ndplne0sq
         F2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644450; x=1689236450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmxLgmswZPkTWLyb16LsS4t5xijTdvKxqhRrgOY0CXw=;
        b=cQkW3qcl3iRBTNUJm6JVu36F339Qi9NdyGNOY2sriQxx3034p8QfZ2jl/0mVAlJLPb
         RMU25V1m0I8FfmfzRFdvr5iyG9HLYwI1GcydW/dX+TiLxSOJ7HCIULoB29xmG7eEsLvJ
         3xCx3qcSgUqhr8xyhWZKxVb0YPpKapO8AoghPIQUO/zz/Mxtt5jOC2a5zM883lMKWQsR
         ZvgC+5DeZOdQ0o7Ewmqgk8MmGphXGgcDJ8Cun3CDT74uCI2htXMcwDMvSBW4RMbxDFuY
         PaKvabO6HSFAadj1Hg98ZmwAg351VOZGSkmSa91/qQs9tkRduy0D1gJ8mhSY0MZ7JjEf
         P74A==
X-Gm-Message-State: AC+VfDxjYmLk5fgZbVcnO4RPiUKzM8TGveG9sWTqjFsh1+yUcuyW+mmQ
        vJL6AmEVW2bAcWTU1wO2b6uAng==
X-Google-Smtp-Source: ACHHUZ6zzvRFRlr7kFUtBVDYHMAhCMzRJGbw6mkElpdClO69BfNKDFeWo6C0gRiUTWH26XPLrpTH8Q==
X-Received: by 2002:a17:90a:2905:b0:25b:f66c:35a9 with SMTP id g5-20020a17090a290500b0025bf66c35a9mr2893802pjd.48.1686644449830;
        Tue, 13 Jun 2023 01:20:49 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001b027221393sm9567834plc.43.2023.06.13.01.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:20:49 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v5 4/4] sched/core: Avoid multiple calling update_rq_clock() in unthrottle_offline_cfs_rqs()
Date:   Tue, 13 Jun 2023 16:20:12 +0800
Message-Id: <20230613082012.49615-5-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230613082012.49615-1-jiahao.os@bytedance.com>
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

The rq clock has been updated in the set_rq_offline(),
so we don't need to call update_rq_clock() in
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
index af9604f4b135..4da5f3541762 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6124,6 +6124,13 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * The rq clock has already been updated in the
+	 * set_rq_offline(), so we should skip updating
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
2.20.1

