Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E895F3804
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJCVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJCVpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:45:32 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D241DA64
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u5-20020a170902e80500b00178944c46aaso8959776plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=sJzQbAD1j79Fgzv+EsYJl3ZM82fW9e/y9W/ZIo2cgr0=;
        b=cECuW8WUVfjgImf9pVAIBJjw5obKd5ujde8lV0abrnw0zqcxL0qSiEJ5LJfFgLeDjY
         +Zoxpp6LAC3RtFqSSlodHid7ZW2nBTmKHi7o/FsytMwsX6UwbkT1Fpw1YoUUgLLE8jks
         iEmNI2Y2RGHQJ9eBvNSIjtkN6dyToUqyQJz5IC7sem7S2RyaNH8j8o56YEuJ15QCsEMP
         crp+xJEbn5h4YOfEeBmL9s4BMBTh8aQZwtP9DWl7jHeUWIDlN3WSpOxk+79DaaF0UY7u
         ZrbQGizhq7hDbUTfVrA8HIfpkoyOoSh2IfIMPStcxEX9KCcF8z1tkp+A36aUhhnuIMIJ
         QCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=sJzQbAD1j79Fgzv+EsYJl3ZM82fW9e/y9W/ZIo2cgr0=;
        b=zeZl5rjJu098hoAlJUcsKJUiQrQlMtQ3RkhdqldgNhQfBj3hhcgzOtZbtLJrKtKJYe
         AaOx8zbVpwOK9PYo6L5Ng20HhEfjj4AwhccwuEXn7/utoct5ZrDe4+K62R+mW6I4nzmM
         1gw/sasJD886OfEEF4O7IhQWuZe3K7h9/6zguuMnlJbxYv5wEFHv6iPSFtOv5Xk1ueUr
         v072WI8ToFwRa0tMZ5ogMewUTDUmYkxGCdt/oVmWw/lqVWZ03lkbTQR3R3jb0eau33KX
         wvT6AlsY1eDnu/rRPYjOoihOkh6LxwZefIkDtPngO0aAJphn7IH0enhiN23VyLlhjHLp
         Oq5g==
X-Gm-Message-State: ACrzQf3ogb/4sM4nDDSxSbmUti562STUD1q4YzLLL7c2KihSEN2cJx9G
        /XeNsZ54O4kfV/Jkcz+TCBredxY1YSZNlNOyhA4YgJN/bn8LcZ1yxV9Prlw3vF2xhZS2/06VPS4
        IpoYQkbeLFE3Juiz8oALObDh0RkJ5duo6AJlmGX4GRpnH5wQfGCg01pj1SBpi55Qun1BcSQaS
X-Google-Smtp-Source: AMsMyM4CSSYRQlJMKIr02i33uhu8tmHqGmpy/ey0IIX/ZCnRrvx7GElrMUdp3rT3ryhfCJd9xJ63KLhJVRSW
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a17:902:864c:b0:179:fe02:611e with SMTP id
 y12-20020a170902864c00b00179fe02611emr23421349plt.10.1664833517735; Mon, 03
 Oct 2022 14:45:17 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:44:58 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-9-connoro@google.com>
Subject: [RFC PATCH 08/11] sched: Fixup task CPUs for potential proxies.
From:   "Connor O'Brien" <connoro@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

When a mutex owner with potential proxies wakes up those proxies are
activated as well, on the same CPU of the owner. They might have been
sleeping on a different CPU however.

Fixup potential proxies CPU at wakeup time before activating them (or
they get woken up with a wrong CPU reference).

XXX connoro: plan is to fold this into "sched: Add proxy execution" in
future versions.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Fixed trivial rebase conflict]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix conflicts]
Signed-off-by: Connor O'Brien <connoro@google.com>
---
 kernel/sched/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 416e61182c17..ad2e7b49f98e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3733,8 +3733,15 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 			raw_spin_unlock(&pp->blocked_lock);
 			break;
 		}
+		/* XXX can't call set_task_cpu() because we are not holding
+		 * neither pp->pi_lock nor task's rq lock. This should however
+		 * be fine as this task can't be woken up as it is blocked on
+		 * this mutex atm.
+		 * A problem however might be that __set_task_cpu() calls
+		 * set_task_rq() which deals with groups and such...
+		 */
+		__set_task_cpu(pp, cpu_of(rq));
 		activate_task(rq, pp, en_flags);
-		pp->on_rq = TASK_ON_RQ_QUEUED;
 		resched_curr(rq);
 		raw_spin_unlock(&pp->blocked_lock);
 	}
@@ -7114,7 +7121,8 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * If a worker goes to sleep, notify and ask workqueue whether it
 	 * wants to wake up a task to maintain concurrency.
 	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if ((task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) &&
+	    !task_is_blocked(tsk)) {
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
 		else
-- 
2.38.0.rc1.362.ged0d419d3c-goog

