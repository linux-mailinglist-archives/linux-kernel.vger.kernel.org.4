Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E077203A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjFBNpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjFBNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:45:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4FB136
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:45:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53f832298acso1225301a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685713529; x=1688305529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CM3eRbOi3TkUOXU+mIU5eWBw4sPK5X/8OHYMDjf2cns=;
        b=Bdbt5JnaM8kNcrIXCCvACs+89yLNPiwSJ+zgyIg9k/Kf0oLzHXF6gzCBj2lX5IkNbR
         Jm2NSkGu/yvyFaShHO6uq+T6QJF272ZhGxlXRPJUjocLndQRPUQQnm0WU8Lxu3iLEePM
         WluCMbkU0KlGasvIeaIlNJn52BIHPOQxvYGN8R9InVzBeAuIqBDuNymKpBZvw34RN16k
         xLMf3e57oNWfdmvTvkSYpE398KIptRvagVN0Bc2JPYqJtnOYBET6LMubLVT0v38RjY4o
         P2myeHAmvB+J95wZjI8QJKV8JLNY+5Avkn+n0tuPDfLxj5QE9cTiNpeUFecMapgs1VNs
         7cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685713529; x=1688305529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CM3eRbOi3TkUOXU+mIU5eWBw4sPK5X/8OHYMDjf2cns=;
        b=UdIQPgxGCotFBthfRq7B96ve6Muhp4zEx3Enw9I66urTvfFS9dcmDnxM2AMsvYn67f
         Lzk3m1eQL8y4QASBEAx2FZ4lPVknexinbLTENJiijGZhha/i+7Nz9E45acYIv/JyEkO4
         02KImkWfrc/Py2rX2AX+8LVDMkOWZvVJXLROS2lqWIlLkoFs2qpJElw2B87WjqtKrbPD
         MDxxtbLVspWM9o6EXcOvkbMwyDIWY4pkstgDqOuusiAEbv+B2XZm3YlaaPaO5k2zLGHb
         sAAdQ4x8zlLaJeeYLSk7KdrEK0MxX7h3+ANQUOoW2NM1T0kwIXLgMdlkV5KxNzYHGKGX
         jSMg==
X-Gm-Message-State: AC+VfDzIdZosglSrWxlPVNoEXGrt1i3PE3d0UqUY4n/TZtn65DeZT1SP
        WUTRydq8RkDKo2HzQBL4SiSGYt/agsfT4Lj+dKkpqQ==
X-Google-Smtp-Source: ACHHUZ45wyQJ425gtDHBObBv4j94oRDAUuaOOEdWF18ePLcky/nqZpvLqlx9X9vmr3177rQUeFICl32pfxZdJeK9f6M=
X-Received: by 2002:a17:90a:358:b0:255:63e0:1248 with SMTP id
 24-20020a17090a035800b0025563e01248mr83268pjf.0.1685713529220; Fri, 02 Jun
 2023 06:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <20230531124604.341527144@infradead.org>
In-Reply-To: <20230531124604.341527144@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Jun 2023 15:45:18 +0200
Message-ID: <CAKfTPtCnEdPpZSu3=t4tTEm-nWEwkyTwQuTLngcgABhcMGWvZA@mail.gmail.com>
Subject: Re: [PATCH 11/15] sched/eevdf: Better handle mixed slice length
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 at 14:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> In the case where (due to latency-nice) there are different request
> sizes in the tree, the smaller requests tend to be dominated by the
> larger. Also note how the EEVDF lag limits are based on r_max.
>
> Therefore; add a heuristic that for the mixed request size case, moves
> smaller requests to placement strategy #2 which ensures they're
> immidiately eligible and and due to their smaller (virtual) deadline
> will cause preemption.
>
> NOTE: this relies on update_entity_lag() to impose lag limits above
> a single slice.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     |   30 ++++++++++++++++++++++++++++++
>  kernel/sched/features.h |    1 +
>  kernel/sched/sched.h    |    1 +
>  3 files changed, 32 insertions(+)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -642,6 +642,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq,
>         s64 key = entity_key(cfs_rq, se);
>
>         cfs_rq->avg_vruntime += key * weight;
> +       cfs_rq->avg_slice += se->slice * weight;
>         cfs_rq->avg_load += weight;
>  }
>
> @@ -652,6 +653,7 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq,
>         s64 key = entity_key(cfs_rq, se);
>
>         cfs_rq->avg_vruntime -= key * weight;
> +       cfs_rq->avg_slice -= se->slice * weight;
>         cfs_rq->avg_load -= weight;
>  }
>
> @@ -4908,6 +4910,21 @@ static inline void update_misfit_status(
>
>  #endif /* CONFIG_SMP */
>
> +static inline bool
> +entity_has_slept(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +{
> +       u64 now;
> +
> +       if (!(flags & ENQUEUE_WAKEUP))
> +               return false;
> +
> +       if (flags & ENQUEUE_MIGRATED)
> +               return true;
> +
> +       now = rq_clock_task(rq_of(cfs_rq));
> +       return (s64)(se->exec_start - now) >= se->slice;
> +}
> +
>  static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> @@ -4930,6 +4947,19 @@ place_entity(struct cfs_rq *cfs_rq, stru
>                 lag = se->vlag;
>
>                 /*
> +                * For latency sensitive tasks; those that have a shorter than
> +                * average slice and do not fully consume the slice, transition
> +                * to EEVDF placement strategy #2.
> +                */
> +               if (sched_feat(PLACE_FUDGE) &&
> +                   (cfs_rq->avg_slice > se->slice * cfs_rq->avg_load) &&
> +                   entity_has_slept(cfs_rq, se, flags)) {
> +                       lag += vslice;
> +                       if (lag > 0)
> +                               lag = 0;

This PLACE_FUDGE looks quite not a good heuristic because it breaks
the better fair sharing of cpu bandwidth that EEVDF is supposed to
bring. Furthermore, it breaks the isolation between cpu bandwidth and
latency because playing with latency_nice will impact your cpu
bandwidth

> +               }
> +
> +               /*
>                  * If we want to place a task and preserve lag, we have to
>                  * consider the effect of the new entity on the weighted
>                  * average and compensate for this, otherwise lag can quickly
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -5,6 +5,7 @@
>   * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
>   */
>  SCHED_FEAT(PLACE_LAG, true)
> +SCHED_FEAT(PLACE_FUDGE, true)
>  SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
>
>  /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -555,6 +555,7 @@ struct cfs_rq {
>         unsigned int            idle_h_nr_running; /* SCHED_IDLE */
>
>         s64                     avg_vruntime;
> +       u64                     avg_slice;
>         u64                     avg_load;
>
>         u64                     exec_clock;
>
>
