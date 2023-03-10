Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9D26B451B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjCJOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjCJOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:30:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E18C11E6E3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:29:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p26so3494788wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678458576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=drju4oFbKPHB0dLpfptYEE2CtARCgsI5VNCPDcAEwmY=;
        b=Ng2ai2gUZCRrEgTJBbhYRJH5Ts1qNc08MjhPHXp83IKjDHearutRecYpUU6KbU7upV
         +3168LyYr2thoPluD9WtDSHKscx58tzU92MT8xzKFK4Ii2uZHBCL2IWm/vWea1SskL4a
         qOoec1qEPcqdKAmY5me+J7MWcQLh8QUc+mNun6pRrsqvpWeh4anuUprb8xDEqKnVigLu
         /lO9TNPglkTvTQh6kvcD8F9IeWyuZ7lj/VNbwlE0Z6z8/p7kccu5Q424nVSyGWeKcqK7
         FlNLtKnWeGUsfLq1Do7P5+sCZJUqacFqTsmPQZF8atd51MtRgsk5jYMpSio5rMhZCp6M
         LVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678458576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drju4oFbKPHB0dLpfptYEE2CtARCgsI5VNCPDcAEwmY=;
        b=imYTqF0wKLyLQxNIRuhorGTFopURZKY1F8PsweGcZWbp4nBgKsyK17NObRq5bTqlTO
         CuYhcxC8ixFM7WWUyXTK564N53kqs0kVEVYu81vX9w1SKYLj0ggQMbveVrHUpHIJTsB4
         ejGmxhGC+6LXmrswyJ2VFW7La0V54jtSU2pakiX1S6yRZSUHI5xZjQVWDoA3hlmtHOC+
         FL+h8viXXL5ZcB9RTUJDKa9m7ApvDc62xGVkfCWaYUo9uCDbRfoeMFMekyLKBqiYi0FJ
         sujC11pdIhp9Hhj2t1Xk7/7e1KMQdUHgfzYu2qP68An7vVAszuBy9CkEHq4fR+rbmZ9T
         ffCg==
X-Gm-Message-State: AO0yUKXYoNdEv5LWN40+xza4xgyhYV8u520J9yzO3tbaezDtOsd/spuG
        EApPIGT/gfanyV6PGsVAc/MAdZ9NFGDGGTrfJWA=
X-Google-Smtp-Source: AK7set++ZHqmzSiqhDUtpnPDrw1bxueBHlF/TxuftK4cJax73wU02+6RqvK1mU2rcERqQ5yTU3mPCg==
X-Received: by 2002:a05:600c:c06:b0:3e1:feb9:5a33 with SMTP id fm6-20020a05600c0c0600b003e1feb95a33mr2799650wmb.9.1678458575660;
        Fri, 10 Mar 2023 06:29:35 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:1623:815:9976:baec])
        by smtp.gmail.com with ESMTPSA id s6-20020a7bc386000000b003db06224953sm12089wmj.41.2023.03.10.06.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:29:35 -0800 (PST)
Date:   Fri, 10 Mar 2023 15:29:33 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rkagan@amazon.de
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <ZAs+zV0o9ShO7nLT@vingu-book>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net>
 <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 09 mars 2023 à 16:14:38 (+0100), Vincent Guittot a écrit :
> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
> > > On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
> > >
> > > > Then, even if we don't clear exec_start before migrating and keep
> > > > current value to be used in place_entity on the new cpu, we can't
> > > > compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAICT
> > >
> > > Blergh -- indeed, irq and steal time can skew them between CPUs :/
> > > I suppose we can fudge that... wait_start (which is basically what we're
> > > making it do) also does that IIRC.
> > >
> > > I really dislike having this placement muck spreadout like proposed.
> >
> > Also, I think we might be over-engineering this, we don't care about
> > accuracy at all, all we really care about is 'long-time'.
> 
> you mean taking the patch 1/2 that you mentioned here to add a
> migrated field:
> https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942689b1.1648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff778af8db705429d003b
> 
> And assume that the divergence between the rq_clock_task() can be ignored ?
> 
> That could probably work but we need to replace the (60LL *
> NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec divergence
> would not be unrealistic.
> and a comment to explain why it's acceptable

Zhang,

Could you try the patch below ?
This is a rebase/merge/update of:
-patch 1/2 above and 
-https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/

The proposal accepts a divergence of up to 52 days between the 2 rqs.

If this work, we will prepare a proper patch

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b1a..cb8af0a137f7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -550,6 +550,7 @@ struct sched_entity {
        struct rb_node                  run_node;
        struct list_head                group_node;
        unsigned int                    on_rq;
+       unsigned int                    migrated;

        u64                             exec_start;
        u64                             sum_exec_runtime;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a1b1f855b96..36acd9598b40 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1057,6 +1057,7 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
        /*
         * We are starting a new run period:
         */
+       se->migrated = 0;
        se->exec_start = rq_clock_task(rq_of(cfs_rq));
 }

@@ -4684,13 +4685,23 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)

        /*
         * Pull vruntime of the entity being placed to the base level of
-        * cfs_rq, to prevent boosting it if placed backwards.  If the entity
-        * slept for a long time, don't even try to compare its vruntime with
-        * the base as it may be too far off and the comparison may get
-        * inversed due to s64 overflow.
+        * cfs_rq, to prevent boosting it if placed backwards.
+        * However, min_vruntime can advance much faster than real time, with
+        * the exterme being when an entity with the minimal weight always runs
+        * on the cfs_rq. If the new entity slept for long, its vruntime
+        * difference from min_vruntime may overflow s64 and their comparison
+        * may get inversed, so ignore the entity's original vruntime in that
+        * case.
+        * The maximal vruntime speedup is given by the ratio of normal to
+        * minimal weight: NICE_0_LOAD / MIN_SHARES, so cutting off on the
+        * sleep time of 2^63 / NICE_0_LOAD should be safe.
+        * When placing a migrated waking entity, its exec_start has been set
+        * from a different rq. In order to take into account a possible
+        * divergence between new and prev rq's clocks task because of irq and
+        * stolen time, we take an additional margin.
         */
        sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
-       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+       if ((s64)sleep_time > (1ULL << 63) / NICE_0_LOAD / 2)
                se->vruntime = vruntime;
        else
                se->vruntime = max_vruntime(se->vruntime, vruntime);
@@ -7658,7 +7669,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
        se->avg.last_update_time = 0;

        /* We have migrated, no longer consider this task hot */
-       se->exec_start = 0;
+       se->migrated = 1;

        update_scan_period(p, new_cpu);
 }
@@ -8344,6 +8355,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
        if (sysctl_sched_migration_cost == 0)
                return 0;

+       if (p->se.migrated)
+               return 0;
+
        delta = rq_clock_task(env->src_rq) - p->se.exec_start;

        return delta < (s64)sysctl_sched_migration_cost;



> 
> 
> >
> >
