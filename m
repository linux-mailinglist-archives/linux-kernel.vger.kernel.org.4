Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CEE5EFE48
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiI2UEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiI2UEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:04:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346D1FCCB1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:04:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id j24so2705681lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/6bvgm/eN+tolMmlVTeeUspiQc2rWHh84+xSqtppf5g=;
        b=kTaKa1ZjJPumKFHAa8L0GA1Y/Mabx3wmbBHw00GuH5B71rStyWCRZGG2khTqoh4pNZ
         CvI8JAl1i0UCUWk+/Tdoq1gya9pn5XzAL5TISp6lUQadE3dYmCTUEzZSH37OdrikkpYF
         b8E3Ky+MIg4Uu5jhvNE89E/QvSDOCocDqPt9KTCwUQygjNP6/voTahIVNEs3qBycw2Vd
         M0JeX+3KUwPJ9BMZGS2BbxrDUyGyLUPvDMROLuUnc6U+0A8ck4o/71x4AYomrVGINEjk
         FfekUiKg7mFnhtEqs9WenTB99H3PtkAfp7g+q4yBxHTAyFSuqyln/3mOrDlrMW8Odcfl
         gTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/6bvgm/eN+tolMmlVTeeUspiQc2rWHh84+xSqtppf5g=;
        b=rDciFpHjYLWYm2FsCyxjLImxR2TYjNcghnC/r9d5PmyeF3AAGi6NZSWbkWdtTfKlbw
         hQsXfVnwY4xHP5k6XHj9Uz44igpKwwOw9opqiyq72u05Aas3mgTpahLKX279Kh7G5N/m
         gctY2LrDd1tXTlvgeiWedL1QLx2/9EmbVZqtGgfMumlGVNXhWr9YVPxYdB5q2SNb6A6D
         3Ao7Qh12H4uR+IdUeeObXZbWTi2rPf9SRLfwGnkEtgSZ0HrAKodiO++SR++5MCi8X3BR
         SjsNyyzWj2qaoX64lRun62jqgKjmQjcWrh5gaFFYT2/ghnxO80L45xnjqOJh0xVrPlTr
         L+rw==
X-Gm-Message-State: ACrzQf2BuvGygWwQfqdnN4oE9M/TgstpS828FfyDxJnQJ1YweQAu2Va+
        Bepv4SBrmx2z02j2SeLfxBRqVpcyQGBLFMdmSoAsqQ==
X-Google-Smtp-Source: AMsMyM7Rb2yYh5yeEl/AlFIp+SRs62jJEDOACz29oGXOGwNoM1zxCDThO8f05v9whizejPprd/Y2dnSn13ZE7dmb6EI=
X-Received: by 2002:a2e:2e0b:0:b0:26b:f760:1c51 with SMTP id
 u11-20020a2e2e0b000000b0026bf7601c51mr1796995lju.494.1664481849353; Thu, 29
 Sep 2022 13:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220916131538.24706-1-vincent.guittot@linaro.org>
 <YzXEZnH6CAtZ+V4R@hirez.programming.kicks-ass.net> <CAKfTPtDkQuA9ghEVJZieLfeXLMpimE-jjuLB-1wLntYSD6RoxQ@mail.gmail.com>
 <YzXvwMXpdhyt/Srm@hirez.programming.kicks-ass.net>
In-Reply-To: <YzXvwMXpdhyt/Srm@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Sep 2022 22:03:57 +0200
Message-ID: <CAKfTPtAoQh_5Jzojz6cpmV6g1ERpLbK_GxC9Nk_u6=v=719ubw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: limit sched slice duration
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 21:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 29, 2022 at 07:15:42PM +0200, Vincent Guittot wrote:
> > On Thu, 29 Sept 2022 at 18:14, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 5ffec4370602..2b218167fadf 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4575,17 +4575,33 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > >  }
> > >
> > >  /*
> > > - * Preempt the current task with a newly woken task if needed:
> > > + * Tick driven preemption; preempt the task if it has ran long enough.
> > > + * Allows other tasks to have a go.
> > >   */
> > >  static void
> > >  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > >  {
> > > -       unsigned long ideal_runtime, delta_exec;
> > >         struct sched_entity *se;
> > > -       s64 delta;
> > > +       s64 delta, delta_exec;
> > > +       u64 ideal_runtime;
> > >
> > > -       ideal_runtime = sched_slice(cfs_rq, curr);
> > > +       /* How long has this task been on the CPU for [walltime]. */
> > >         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> > > +
> > > +       /*
> > > +        * Ensure that a task that missed wakeup preemption by a
> > > +        * narrow margin doesn't have to wait for a full slice.
> > > +        * This also mitigates buddy induced latencies under load.
> > > +        */
> > > +       if (delta_exec < sysctl_sched_min_granularity)
> > > +               return;
> >
> > ideal_runtime can be lower than sysctl_sched_min_granularity. It can
> > be as low as sysctl_sched_idle_min_granularity for idle task. In this
> > case, we want to resched even if(delta_exec <
> > sysctl_sched_min_granularity). That's why the 1st test was still done
> > before
>
> Duh, indeed.
>
> > > +
> > > +       /*
> > > +        * When many tasks blow up the sched_period; it is possible that
> > > +        * sched_slice() reports unusually large results (when many tasks are
> > > +        * very light for example). Therefore impose a maximum.
> > > +        */
> > > +       ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
> >
> > I didn't cap ideal_runtime before this test because we have situations
> > where large ideal_runtime is ok: If there is only one normal thread
> > with hundreds of idle threads as an example: Is it acceptable to
> > trigger a useless resched in this case ? That's why I have computed
> > the virtual time generated by the capped version of ideal_runtime.
>
> Yeah; I think that should be fine. It's an edge case, and sched_latency
> is fairly large already.

In this case capping the ideal runtime from the beg is ok and will
ensure max duration before checking for a resched

>
> > >         se = __pick_first_entity(cfs_rq);
> > >         delta = curr->vruntime - se->vruntime;
> > > -
> > >         if (delta < 0)
> > >                 return;
> > >
> > > +       /*
> > > +        * Compare @delta [vtime] to @ideal_runtime [walltime]. This means that
> > > +        * heavy tasks (for which vtime goes slower) get relatively more time
> > > +        * before preemption, while light tasks (for which vtime goes faster)
> > > +        * get relatively less time.  IOW, heavy task get to run longer.
> > > +        */
> >
> > After your comment on v1, I looked more deeply on this and the
> > comparison of [vtime] with [walltime] can create a large unfairness.
> > vtime of nice-20 increases by ~250us for 24ms of walltime which means
> > that the nice-20 will have to run for a long time before reaching this
> > walltime delta (assuming the vruntime were similar at the beg)
>
> As I wrote, strictly speaking we should do without this. The entire
> vtime thing is a band-aid.
>
> I'm sure I've tried taking it out at least once; but sadly I seem to
> have forgotten everything relevant :-( That is, I can't tell you why
> this code exists.

This test can trigger resched before the end of the ideal_runtime. I
can only see a benefit with curr task nice prio > 0 when vruntime
increases faster than walltime and will trigger a resched before the
end of the [walltime] ideal runtime
