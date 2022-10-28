Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD496116B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJ1QBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJ1P7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:59:08 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0221E127
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:58:16 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-367cd2807f2so51090967b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cCjKXOcyb+QfEnjzlc/Kq6Ie9WHUfNkR4Nmc4Tu9NGg=;
        b=sQxEF8vf9wEhNL47iGTHFGkUYbZG0nG3CjKs3iVwb8l7dM6ONtA01xgJpKSObA+PUB
         8nccovNYgn7wfzqKMK7f33/4a0/BjC2q93ZTK8RwfPyII2HRkOf9pY4/80pUvtOcvD+L
         I6Jm7hLlYI8oB1MhKoAoggrmnOeBFU/kbFFoqp1ivel2stRRkRrarskMOQuXxRod9zo0
         e5gkO5l8pfC/Wo21INsuy1Ma8Kt7eEFH/5YuylTOxLMInLucdBWgBM+CTx76jI7cXRNd
         9qV42/5UQasctFbmb5aFB8v81DSxzNq2iMasbPy7Z1WeFgHav9zYTWOYJGL70hsVd6jP
         NI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCjKXOcyb+QfEnjzlc/Kq6Ie9WHUfNkR4Nmc4Tu9NGg=;
        b=m7Kti4sJFa0B98qN4cn97ZFt+lSefWDXM1WuYyWcDsToNza+wV+WId+8NrJI5STLpC
         8GLa9QnzWC9Kb2P8O9pA9/dn8EcaUvXc+FWn3dehOc7/s69pY5vsKhpW7olhLEzvtvBo
         gdMBRG6WkemHPdzRwnuyDzEgrxOm+ScbyyupD53O9Y5TX+YVHJr7gqrxBmsltuJKeeGQ
         ITE1QfYgUI05R6pd91OxnVRdT+Yia4+tmC8BsY+M6pvnRqHAJqb4/QDlHkSuh/J0TjpQ
         WwYGJPnf68/lDvEdKeQnTMailpP6P9P7baUoOM+SDvdrdBVK0sfVqGyoxQ2UAVziOoD2
         WI9A==
X-Gm-Message-State: ACrzQf3GzsH7FHqoDXVQU4RTcjtVFD88TyHJLfG8riPMZQ45K3jluerP
        6GpXIbmxdSxsJhbpm1Xa0xu56OlI+U8pwCwu70q2ow==
X-Google-Smtp-Source: AMsMyM5vsIZKxoHongbDFxuMxaxcFkmp+JflF7xq1e6OEAIn9CL8/ZCzlrYqinTB6OypsOiq9NMLgnVr2u+oYAuCAe0=
X-Received: by 2002:a81:8606:0:b0:349:17ad:6998 with SMTP id
 w6-20020a818606000000b0034917ad6998mr77944ywf.409.1666972695278; Fri, 28 Oct
 2022 08:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
 <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2> <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com>
In-Reply-To: <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Oct 2022 08:58:03 -0700
Message-ID: <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
Subject: Re: [External] [tip: sched/core] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
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

On Thu, Oct 27, 2022 at 11:50 PM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hello,
>
> Thanks for picking this up. There is a newer version which has been acked:
> https://lore.kernel.org/all/20221014110551.22695-1-zhouchengming@bytedance.com/

Hmm. Indeed this seems to be an older version and not the one I asked
Peter to pick up in
https://lore.kernel.org/all/CAJuCfpHeJuZBbv-q+WXjgNHwt_caMomFPL3L9rxosXOrZz3fBw@mail.gmail.com/.
Not sure what went wrong. Peter, could you please replace this one
with https://lore.kernel.org/all/20221014110551.22695-1-zhouchengming@bytedance.com/?

Chengming, please do not top-post next time. Would be better if you
posted your note under the "Link:" field in this email.
Thanks!

>
> As well another PSI patch that has been acked by Johannes:
> https://lore.kernel.org/all/20220926081931.45420-1-zhouchengming@bytedance.com/
>
> Thanks!
>
>
> On 2022/10/28 14:42, tip-bot2 for Chengming Zhou wrote:
> > The following commit has been merged into the sched/core branch of tip:
> >
> > Commit-ID:     7d89d7bb921c5ae5a428df282e64ee5692e26fe0
> > Gitweb:        https://git.kernel.org/tip/7d89d7bb921c5ae5a428df282e64ee5692e26fe0
> > Author:        Chengming Zhou <zhouchengming@bytedance.com>
> > AuthorDate:    Mon, 10 Oct 2022 18:42:06 +08:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 27 Oct 2022 11:01:23 +02:00
> >
> > sched/psi: Fix avgs_work re-arm in psi_avgs_work()
> >
> > Pavan reported a problem that PSI avgs_work idle shutoff is not
> > working at all. Because PSI_NONIDLE condition would be observed in
> > psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
> > only the kworker running avgs_work on the CPU.
> >
> > Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
> > avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
> > still will always re-arm the avgs_work, so shutoff is not working.
> >
> > This patch changes to consider current CPU groupc as IDLE if the
> > kworker running avgs_work is the only task running and no IOWAIT
> > or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
> > if other CPUs' groupc are also IDLE.
> >
> > One potential problem is that the brief period of non-idle time
> > incurred between the aggregation run and the kworker's dequeue will
> > be stranded in the per-cpu buckets until avgs_work run next time.
> > The buckets can hold 4s worth of time, and future activity will wake
> > the avgs_work with a 2s delay, giving us 2s worth of data we can leave
> > behind when shut off the avgs_work. If the kworker run other works after
> > avgs_work shut off and doesn't have any scheduler activities for 2s,
> > this maybe a problem.
> >
> > Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20221010104206.12184-1-zhouchengming@bytedance.com
> > ---
> >  kernel/sched/psi.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index ee2ecc0..f4cdf6f 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >                            u32 *pchanged_states)
> >  {
> >       struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> > +     int current_cpu = raw_smp_processor_id();
> > +     bool only_avgs_work = false;
> >       u64 now, state_start;
> >       enum psi_states s;
> >       unsigned int seq;
> > @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >               memcpy(times, groupc->times, sizeof(groupc->times));
> >               state_mask = groupc->state_mask;
> >               state_start = groupc->state_start;
> > +             /*
> > +              * This CPU has only avgs_work kworker running, snapshot the
> > +              * newest times then don't need to re-arm for this groupc.
> > +              * Normally this kworker will sleep soon and won't wake
> > +              * avgs_work back up in psi_group_change().
> > +              */
> > +             if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
> > +                 !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
> > +                     only_avgs_work = true;
> >       } while (read_seqcount_retry(&groupc->seq, seq));
> >
> >       /* Calculate state time deltas against the previous snapshot */
> > @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >               if (delta)
> >                       *pchanged_states |= (1 << s);
> >       }
> > +
> > +     /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
> > +     if (only_avgs_work)
> > +             *pchanged_states &= ~(1 << PSI_NONIDLE);
> >  }
> >
> >  static void calc_avgs(unsigned long avg[3], int missed_periods,
