Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CDA62FDF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiKRTZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKRTZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:25:24 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D36D49A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:25:23 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a15so7980278ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VC2/Uwf7bcGONzCaNCCGkpMJN1Hm6Zjtvr4XsY8rNX0=;
        b=nxW2M6ZsZRZWjsuok2sy17oGot47gcVYymyGdFIr67Qu0r3f0JL4ilatwPKFtbMbBM
         FFnnVWAleAsMG0leMjJByHVsiNeFSRIfZjV4rjBV0Hfw+WGDQnHojlRMhIkYvLpxvz2W
         5e6gqJfIVicrd5PZWNVD3KtiPcUqR7xjiZTX8Vr9ZIvqm+WB8rDA4bwzZlDpklXBvmgy
         1NyFfbRDlEF0W1i6lQXsuK3vGolLFTAQlJOg8AVU6cLCV9gILSCiqZQz577vcPe0w04+
         xjDeDZOXnhl3d7+BIPr6yRbWcju0GlfFnF5eEFlZAPV1TSq215dLCyJYlaik3oCLLlxT
         S3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC2/Uwf7bcGONzCaNCCGkpMJN1Hm6Zjtvr4XsY8rNX0=;
        b=acuoICpFDeYJqpDifBMFPT9aH93QDQpAqM+gscegZRJy9krbij/kmktMelCFhgD7VY
         c3e5WKRJV8Qgt0+X/iXS94VLZBrnxrOMPhGdthXy4J1ozgj/O4Z+aDKIDrp7NZM2NjJu
         aOxzHHdMXOejp29pcdlXJm8CSMiw5n/CxhwY+0JRVczQ0t6NZcQZU0cLSEI05ghuMzKa
         jI6W8zH9zjOO4wJiv37mR93HzoIFXY1wSeJ+6LpFJqa/erles0ujwrmR65ouysVwVwzi
         EUx6D4LZ+B7JFZexTBXVyNSI9jfr1bie2lMvdWhlxEK7whHmkNeVNSl+J1NpcTCypSqV
         Witg==
X-Gm-Message-State: ANoB5pntfXXdpAL/o8P4pPISY1XxhfScCklJqY90J1H0CK2HdBaf9gin
        n2L3yj7XcpqEM/ieLchiJkYP/9LtSYKrPInlRYyWZA==
X-Google-Smtp-Source: AA0mqf7FSz3twXh4csfLAQBlAtRcs0xv1FngKF8KEe177z+EbxHaq5bF3dq2PmRO4GJBBs+as65sNInwmWxWM/ofsps=
X-Received: by 2002:a2e:8356:0:b0:277:6c68:12d3 with SMTP id
 l22-20020a2e8356000000b002776c6812d3mr2834566ljh.499.1668799521918; Fri, 18
 Nov 2022 11:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20221117005418.3499691-1-joshdon@google.com> <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 18 Nov 2022 11:25:09 -0800
Message-ID: <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 4:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> preempt_disable() -- through rq->lock -- also holds off rcu. Strictly
> speaking this here is superfluous. But if you want it as an annotation,
> that's fine I suppose.

Yep, I purely added this as extra annotation for future readers.

> Ideally we'd first queue all the remotes and then process local, but
> given how all this is organized that doesn't seem trivial to arrange.
>
> Maybe have this function return false when local and save that cfs_rq in
> a local var to process again later, dunno, that might turn messy.

Maybe something like this? Apologies for inline diff formatting.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 012ec9d03811..100dae6023da 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5520,12 +5520,15 @@ static bool distribute_cfs_runtime(struct
cfs_bandwidth *cfs_b)
        struct cfs_rq *cfs_rq;
        u64 runtime, remaining = 1;
        bool throttled = false;
+       int this_cpu = smp_processor_id();
+       struct cfs_rq *local_unthrottle = NULL;
+       struct rq *rq;
+       struct rq_flags rf;

        rcu_read_lock();
        list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
                                throttled_list) {
-               struct rq *rq = rq_of(cfs_rq);
-               struct rq_flags rf;
+               rq = rq_of(cfs_rq);

                if (!remaining) {
                        throttled = true;
@@ -5556,14 +5559,36 @@ static bool distribute_cfs_runtime(struct
cfs_bandwidth *cfs_b)
                cfs_rq->runtime_remaining += runtime;

                /* we check whether we're throttled above */
-               if (cfs_rq->runtime_remaining > 0)
-                       unthrottle_cfs_rq_async(cfs_rq);
+               if (cfs_rq->runtime_remaining > 0) {
+                       if (cpu_of(rq) != this_cpu ||
+                           SCHED_WARN_ON(local_unthrottle)) {
+                               unthrottle_cfs_rq_async(cfs_rq);
+                       } else {
+                               local_unthrottle = cfs_rq;
+                       }
+               } else {
+                       throttled = true;
+               }

 next:
                rq_unlock_irqrestore(rq, &rf);
        }
        rcu_read_unlock();

+       /*
+        * We prefer to stage the async unthrottles of all the remote cpus
+        * before we do the inline unthrottle locally. Note that
+        * unthrottle_cfs_rq_async() on the local cpu is actually synchronous,
+        * but it includes extra WARNs to make sure the cfs_rq really is
+        * still throttled.
+        */
+       if (local_unthrottle) {
+               rq = cpu_rq(this_cpu);
+               rq_lock_irqsave(rq, &rf);
+               unthrottle_cfs_rq_async(local_unthrottle);
+               rq_unlock_irqrestore(rq, &rf);
+       }
+
        return throttled;
 }

Note that one change we definitely want is the extra setting of
throttled = true in the case that cfs_rq->runtime_remaining <= 0, to
catch the case where we run out of runtime to distribute on the last
entity in the list.

> > +
> > +     /* Already enqueued */
> > +     if (SCHED_WARN_ON(!list_empty(&cfs_rq->throttled_csd_list)))
> > +             return;
> > +
> > +     list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
> > +
> > +     smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
>
> Hurmph.. so I was expecting something like:
>
>         first = list_empty(&rq->cfsb_csd_list);
>         list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
>         if (first)
>                 smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
>
> But I suppose I'm remembering the 'old' version. I don't think it is
> broken as written. There's a very narrow window where you'll end up
> sending a second IPI for naught, but meh.

The CSD doesn't get  unlocked until right before we call the func().
But you're right that that's a (very) narrow window for an  extra IPI.
Please feel free to modify the patch with that diff if you like.

>
> > +}
>
> Let me go queue this thing, we can always improve upon matters later.

Thanks! Please add at least the extra assignment of 'throttled = true'
from the diff above, but feel free to squash both the diffs if it
makes sense to you.
