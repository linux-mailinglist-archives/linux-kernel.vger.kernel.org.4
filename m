Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E345FA6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJJVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJJVQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:16:42 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D427961F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:16:38 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-35befab86a4so110908197b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SIYZCOwD+eWoHEYQ3adu0QLBto7Q04UIIJ1VKUrVpng=;
        b=SbI+5adgqVsD2bYsptM3RcgOR1oWoU3KwMtCE0mphCCqEZA5MhlAm9gNjDgTvV5uF0
         b2bJ9EfcUBfguETEMCXqgD4jTFyjRfvUgCvKF8Csa8TPMgAPBIMIa4JoI3J6Upk0w2D3
         moSBfv+7cyReb4A/lDSc4jrxcK9rm0M7+fSsnkebLHjTEGFAkkbAC2/xW6ejRUWg0/mV
         aUrrUi8S1D4TfFwJI1cRJ85Wh0ON22LZtS7J2e6LP6ek83U4DP+sl6EikG1y00/vWcVP
         UvKQ4ZFna5MHwMaXA2mWIa6G7Yi7yAVK+xt/Vi6eKvvclMTxx1Bam3Pf3vpSJR8reGvX
         8ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIYZCOwD+eWoHEYQ3adu0QLBto7Q04UIIJ1VKUrVpng=;
        b=wVXDxw3+p1VqYJK7J/gs+5UAcaMFZAknzXqAUMoBC/vnI5TNCMV6OG9WC6ueSBSPWZ
         xbQXlu3ApheykbWxQLMuuKc6U00qKwb4ERyMxEFVnh7JLkf0GMdnLM4bgZnlL5yMlQkf
         sodSUu7rflyIJ/DgyNEs2W4sj/AZJJDHz7DT2i8H3VVq8NYxq/sDK+eg5rrqH4neH7W6
         yeCSAacmUAYoVtpGD6dylWzq6oOcAwrg4IeV8g5wH35usaxyVRI9OFnXW/ATPH5RXKAa
         4qIbgxjI3SPqdxReFT2OKxRVtaXl+bW/4Crq37hZwvnVhVYqUlevI9VSbq/wpJxJcfdP
         /AqA==
X-Gm-Message-State: ACrzQf3Fk2ZYhE6SvbMnfQ5d1q7QNpooQrhYYhjUlj7PkAtF0abq6fXw
        3jh1hd0LB2l7x5Wv/nyZF3K+fSaa03KSz71OCuppI8SkM+x77Q==
X-Google-Smtp-Source: AMsMyM5LzJe/o3uDADn2fYXhmMluKoAgmLD5XFwupQf5ddmTMRnJ4D6bsQ+N+YJ/Y2w613kKMWQFrOPzEahpkdvRX/4=
X-Received: by 2002:a0d:ef84:0:b0:352:9e0d:a596 with SMTP id
 y126-20020a0def84000000b003529e0da596mr18742448ywe.347.1665436597958; Mon, 10
 Oct 2022 14:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com> <20221010105710.171-1-hdanton@sina.com>
In-Reply-To: <20221010105710.171-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Oct 2022 14:16:26 -0700
Message-ID: <CAJuCfpGN4TooWJuvoh9RZM96hW4BmuKjwnuT2pM4rGPLcGEinQ@mail.gmail.com>
Subject: Re: PSI idle-shutoff
To:     Hillf Danton <hdanton@sina.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, quic_charante@quicinc.com
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

On Mon, Oct 10, 2022 at 3:57 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On 13 Sep 2022 19:38:17 +0530 Pavan Kondeti <quic_pkondeti@quicinc.com>
> > Hi
> >
> > The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> > run from a kworker thread, PSI_NONIDLE condition would be observed as
> > there is a RUNNING task. So we would always end up re-arming the work.
> >
> > If the work is re-armed from the psi_avgs_work() it self, the backing off
> > logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> > help. The work is already scheduled. so we don't do anything there.
> >
> > Probably I am missing some thing here. Can you please clarify how we
> > shut off re-arming the psi avg work?
>
> Instead of open coding schedule_delayed_work() in bid to check if timer
> hits the idle task (see delayed_work_timer_fn()), the idle task is tracked
> in psi_task_switch() and checked by kworker to see if it preempted the idle
> task.
>
> Only for thoughts now.
>
> Hillf
>
> +++ b/kernel/sched/psi.c
> @@ -412,6 +412,8 @@ static u64 update_averages(struct psi_gr
>         return avg_next_update;
>  }
>
> +static DEFINE_PER_CPU(int, prev_task_is_idle);
> +
>  static void psi_avgs_work(struct work_struct *work)
>  {
>         struct delayed_work *dwork;
> @@ -439,7 +441,7 @@ static void psi_avgs_work(struct work_st
>         if (now >= group->avg_next_update)
>                 group->avg_next_update = update_averages(group, now);
>
> -       if (nonidle) {
> +       if (nonidle && 0 == per_cpu(prev_task_is_idle, raw_smp_processor_id())) {

This condition would be incorrect if nonidle was set by a cpu other
than raw_smp_processor_id() and
prev_task_is_idle[raw_smp_processor_id()] == 0. IOW, if some activity
happens on a non-current cpu, we would fail to reschedule
psi_avgs_work for it. This can be fixed in collect_percpu_times() by
considering prev_task_is_idle for all other CPUs as well. However
Chengming's approach seems simpler to me TBH and does not require an
additional per-cpu variable.

>                 schedule_delayed_work(dwork, nsecs_to_jiffies(
>                                 group->avg_next_update - now) + 1);
>         }
> @@ -859,6 +861,7 @@ void psi_task_switch(struct task_struct
>         if (prev->pid) {
>                 int clear = TSK_ONCPU, set = 0;
>
> +               per_cpu(prev_task_is_idle, cpu) = 0;
>                 /*
>                  * When we're going to sleep, psi_dequeue() lets us
>                  * handle TSK_RUNNING, TSK_MEMSTALL_RUNNING and
> @@ -888,7 +891,8 @@ void psi_task_switch(struct task_struct
>                         for (; group; group = iterate_groups(prev, &iter))
>                                 psi_group_change(group, cpu, clear, set, now, true);
>                 }
> -       }
> +       } else
> +               per_cpu(prev_task_is_idle, cpu) = 1;
>  }
>
>  /**
>
