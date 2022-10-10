Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F25FA6E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJJVVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJJVVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:21:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922446B8C7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:21:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y205so14329200yby.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nag5rgT1SyO7bS/Cq33CDAgI3PT/7kZb4HJKMhW5zgA=;
        b=NM5cev8ZO7w7Cw9buCqJLgS4gcx9OjMJq17QWOeXvmsCZpZnd0KWdep/mI8b+j//DD
         3NkaXZ8gC+Ix/JNMmaKzFqmWNvqH6nK9gzHIRj2O8RxnwesTEqdC2YI+dBR1FBK7jf//
         lQ8uN/J23pZAoBMs7Aa2ApMvueho400uo0mhi7v12SvncZDvkOpAShTB2n2UIXV5LMwz
         XI0WANq6eiv5NisGbJ1PHxdv2BvCvfW2fH/uxGeEj24rgNFUfBb/oKtdegOgLNvHUlBF
         RJXDiGUi3WadFqsDpdWsTZXR/x5w9HklrZRkbt4Ckshy81ds13NZpbIo8sv6lyIzE2DJ
         /eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nag5rgT1SyO7bS/Cq33CDAgI3PT/7kZb4HJKMhW5zgA=;
        b=Vc7qwNlBdgwmVAOir8nAbl0UGvuKcOp8xiFGtiAEP7aErgFCPJiwX38yodzBiHOPNw
         XJQDHLRikdKxewWBJn0Aj1io1q0irdu9h2saaeBWqTps5lR3+K/buPa4WlKYaAo4Qt40
         lolIXx45zM+XsgCYP18Ermi0taS6mPzyRjLKgK9d0Weh/LBgfwvJJd45zApPzw4dQE1q
         fdAlL1fp96ub2HUHrrQNJ1n98/GvRMsXteBRoMzrc5QYASTIgIRvOiOnRSJFmuG1uaB6
         XwU6OQWRguohzO84Fsw9HlyY88hlAWEtrxaPLs8qjHJNSbi82vSdoYZGdDB8cIjB6WvI
         hoMg==
X-Gm-Message-State: ACrzQf3umQzsX4SwCfj0cfYuxQdrhyz7iokBUSPg9EelRgtQEO3Os1Vx
        Yfj8mDOLSogfYj1p6s3D+m8NdMVH67lCbzhLTBm2bDb8o+oGVA==
X-Google-Smtp-Source: AMsMyM6DBuyiasTa+OZ5xeuQH81jewPmMskPgJJhNUJf3yaKMgjmrvaHLt+UIKC9ESlJ17Q2283TkRJXp8Gb5b99QDg=
X-Received: by 2002:a05:6902:70a:b0:6be:e740:9c0a with SMTP id
 k10-20020a056902070a00b006bee7409c0amr20226702ybt.316.1665436889604; Mon, 10
 Oct 2022 14:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com> <20221010104206.12184-1-zhouchengming@bytedance.com>
In-Reply-To: <20221010104206.12184-1-zhouchengming@bytedance.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Oct 2022 14:21:18 -0700
Message-ID: <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     hannes@cmpxchg.org, quic_pkondeti@quicinc.com,
        peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 10, 2022 at 3:42 AM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Pavan reported a problem that PSI avgs_work idle shutoff is not
> working at all. Because PSI_NONIDLE condition would be observed in
> psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
> only the kworker running avgs_work on the CPU.
>
> Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
> avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
> still will always re-arm the avgs_work, so shutoff is not working.
>
> This patch changes to consider current CPU groupc as IDLE if the
> kworker running avgs_work is the only task running and no IOWAIT
> or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
> if other CPUs' groupc are also IDLE.
>
> One potential problem is that the brief period of non-idle time
> incurred between the aggregation run and the kworker's dequeue will
> be stranded in the per-cpu buckets until avgs_work run next time.
> The buckets can hold 4s worth of time, and future activity will wake
> the avgs_work with a 2s delay, giving us 2s worth of data we can leave
> behind when shut off the avgs_work. If the kworker run other works after
> avgs_work shut off and doesn't have any scheduler activities for 2s,
> this maybe a problem.
>
> Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Copying my comments from
https://lore.kernel.org/all/CAJuCfpHyYMak-mfVmtEN9Z-hGYQ6Wko57TLjukz9HaN26EDAuA@mail.gmail.com/
in case you want to continue the discussion here...

> ---
>  kernel/sched/psi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index ee2ecc081422..f4cdf6f184ba 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>                              u32 *pchanged_states)
>  {
>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> +       int current_cpu = raw_smp_processor_id();
> +       bool only_avgs_work = false;
>         u64 now, state_start;
>         enum psi_states s;
>         unsigned int seq;
> @@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
>                 memcpy(times, groupc->times, sizeof(groupc->times));
>                 state_mask = groupc->state_mask;
>                 state_start = groupc->state_start;
> +               /*
> +                * This CPU has only avgs_work kworker running, snapshot the
> +                * newest times then don't need to re-arm for this groupc.
> +                * Normally this kworker will sleep soon and won't wake
> +                * avgs_work back up in psi_group_change().
> +                */
> +               if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
> +                   !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
> +                       only_avgs_work = true;

Why do you determine only_avgs_work while taking a snapshot? The
read_seqcount_retry() might fail and the loop gets retried, which
might lead to a wrong only_avgs_work value if the state changes
between retries. I think it's safer to do this after the snapshot was
taken and to use tasks[NR_RUNNING] instead of  roupc->tasks.

>         } while (read_seqcount_retry(&groupc->seq, seq));
>
>         /* Calculate state time deltas against the previous snapshot */
> @@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>                 if (delta)
>                         *pchanged_states |= (1 << s);
>         }
> +
> +       /* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
> +       if (only_avgs_work)
> +               *pchanged_states &= ~(1 << PSI_NONIDLE);

This seems to be safe because changed_states&(1<< PSI_NONIDLE) is used
only for re-arming psi_avgs_work, however semantically this is
incorrect. The CPU was not idle when it was executing psi_avgs_work.
IMO a separate flag would avoid this confusion.

>  }
>
>  static void calc_avgs(unsigned long avg[3], int missed_periods,
> --
> 2.37.2
>
