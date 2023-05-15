Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507B9702504
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbjEOGj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjEOGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:39:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF0E54
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:39:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so18294833b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684132765; x=1686724765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFcJEKvFlaV29tECsJFbnfR2Mq9DuGUAZDWRZXZAow4=;
        b=DGach8hcIbmjALcZWCOjua9h8AAP0kcpM0lYtO03oqOMyG+KmL2Zz/Jy6cgdf/LU/h
         wVK2G45oppW+r9f1HQ8oNlr2Ny9PEGnU5uYweNqWl94msC4XgEiO+br3PjH9HeBYSXMw
         N/WcbNUyJPwG3LGxs0HznJHreo37AjGArhTpSOsqswLIgt5qqy8eQmB9ZNUgjTXjv4ES
         uRISkT1jiV91x5WdAaBRKj6T/hg963Kp3gjeF99a2AAHb21J1rABhMsfSXQRSn3M7H08
         M7mfJf9JKS7VchWwimVfx6qXqSuvRJ1AeyFVP+7mNnlMfPxkNwDVfWWE+wbbF7WcR+Oi
         bCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132765; x=1686724765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFcJEKvFlaV29tECsJFbnfR2Mq9DuGUAZDWRZXZAow4=;
        b=hCAJ5/bOIsvtGmncvQijoDreznA6ShDjIpceQwIByIavTIgG1a+o1dpzyCjGoed9cp
         az12sFvf7o0DbaUUfOQwwOYTqNWaNjDNWIId/NAs0VOn5OFYjdHJP17TAYrf+C/aJBMa
         B9pocR4F752a1EMXm8ialyF/TL6pKVQDFhjKxWblzH6PmrddkVQ6rAqbhaj4FcWJoFP/
         057mbrjKy8vjXnPPvp6vQS4gfrCpb8lD8rPFd2eFNZrKtVCyqGhdlWsx9UtRtqZ1Phu1
         6Hhxn4Xhvr8u02NmM1uTGGnFne/nK6Tbw9qVWBbA4jW6tDmRMdtQsuDfHL6ZfHmpK1OR
         l91g==
X-Gm-Message-State: AC+VfDxd0Pkp4ndXMTDts0hVX4ySgeg7Ui7SbGrPAqFwy+jao02KMTM9
        BQ/B2RFV+MBOPRA6gGPENAK7dQ==
X-Google-Smtp-Source: ACHHUZ7bK3+aIPqD+pwnS/sXL6iGBECvLrAa8msA9tt7tJKQQo9mfz6Tf7A+JJeTv+QBgaYo91K9/g==
X-Received: by 2002:a17:903:2343:b0:1ac:85b0:1bd8 with SMTP id c3-20020a170903234300b001ac85b01bd8mr26414078plh.34.1684132764854;
        Sun, 14 May 2023 23:39:24 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902a5c100b001ab01598f40sm12608543plq.173.2023.05.14.23.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 23:39:24 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 4/4] sched/core: Avoid multiple calling update_rq_clock() in unthrottle_offline_cfs_rqs()
Date:   Mon, 15 May 2023 14:38:48 +0800
Message-Id: <20230515063848.77947-5-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230515063848.77947-1-jiahao.os@bytedance.com>
References: <20230515063848.77947-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
2.37.0

