Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F33606B41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJTW0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTW0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:26:02 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B104B50B9B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:25:59 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-35befab86a4so6929297b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lYkpkk5lZ6UbU8vLJDuyL389k5VSF1GIIAgVM4h0/14=;
        b=hsBVPwbjKrKrgBfExbAGtluOzJyrkQ/uRUoJYcAxAmlpY7/TgTVoO8LTUhQjvNxr/X
         iZC0WFeSJ6xTaIL5UJ4VHjU0VWjqo9QCm3OriDAdpXSgmJL6AW5p4cQQnTA4fWXJjlIV
         5Rc86aZI+5JzaezrOssbpeVCKRCpY90awmZST1MkeLjsJgPJnqExVP/pU8tFxTcTLXTA
         IxSVjMXmVgjlPEuMDgd9XLItX+iA32e7iFW/PhylXjKj656W1OxzqmprpPNsD/QVtboU
         ikazAfJGiD+BnSowbyVqV/B0hQj7JKHGMq8+1OwqTBouCMbSEyu5OoZ7Y3ynAdFNG7pE
         gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYkpkk5lZ6UbU8vLJDuyL389k5VSF1GIIAgVM4h0/14=;
        b=XbqLNirDk9e+sWIfS6SpLddLc4woTENaSDQmyM6CvNCGSwXBLVjNAda1WA5SXM0Lfn
         tlPyxD6Pm08MAsT9GYbwAsTgQt5p75MBJBdWDzTfppm4qyI46jcVMgCOJ83AIwXIkbIF
         9d1kMkIvs5sDq1diHKvOpRtTxUEBjAMlPlj65hsd2oA8PC1eTrG+AAenfy1ZUIcXAfx6
         ez2tBqLkBP37XZ/a0NxM5m4Ot6vg/c222SQgUL6xmmN2O0oMElGNWgqaSgeVht9MMFzl
         tIpzhBt0lCctPY4bTzfdrFjcD//veym9H/x/LckrEsUPebiJRxPjFLN6NDYKrfnmR3Qf
         DlTg==
X-Gm-Message-State: ACrzQf1OW6ydrXbMhl7oCuAyVAJy/HyCl+4K1Ob27bNuh6SSvpzeBXII
        GHxhTbt3kz88ab7GZGhWHwj6jN4wuV3meVUMP6+5Og==
X-Google-Smtp-Source: AMsMyM7X2xHBM6u9FmnN0WhferDVZmSwfocFQQeDg1zsd3uR3TG4kwpr+4GGxlDww7/51V1ZfDxvBTZD8XE0/bdLaYY=
X-Received: by 2002:a0d:fe47:0:b0:361:2bf:6db4 with SMTP id
 o68-20020a0dfe47000000b0036102bf6db4mr13861718ywf.438.1666304758501; Thu, 20
 Oct 2022 15:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221010225744.101629-1-surenb@google.com>
In-Reply-To: <20221010225744.101629-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 Oct 2022 15:25:47 -0700
Message-ID: <CAJuCfpHeJuZBbv-q+WXjgNHwt_caMomFPL3L9rxosXOrZz3fBw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/1] psi: stop relying on timer_pending for
 poll_work rescheduling
To:     peterz@infradead.org
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, matthias.bgg@gmail.com, minchan@google.com,
        yt.chang@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com, show-hong.chen@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com
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

On Mon, Oct 10, 2022 at 3:57 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Psi polling mechanism is trying to minimize the number of wakeups to
> run psi_poll_work and is currently relying on timer_pending() to detect
> when this work is already scheduled. This provides a window of opportunity
> for psi_group_change to schedule an immediate psi_poll_work after
> poll_timer_fn got called but before psi_poll_work could reschedule itself.
> Below is the depiction of this entire window:
>
> poll_timer_fn
>   wake_up_interruptible(&group->poll_wait);
>
> psi_poll_worker
>   wait_event_interruptible(group->poll_wait, ...)
>   psi_poll_work
>     psi_schedule_poll_work
>       if (timer_pending(&group->poll_timer)) return;
>       ...
>       mod_timer(&group->poll_timer, jiffies + delay);
>
> Prior to 461daba06bdc we used to rely on poll_scheduled atomic which was
> reset and set back inside psi_poll_work and therefore this race window
> was much smaller.
> The larger window causes increased number of wakeups and our partners
> report visible power regression of ~10mA after applying 461daba06bdc.
> Bring back the poll_scheduled atomic and make this race window even
> narrower by resetting poll_scheduled only when we reach polling expiration
> time. This does not completely eliminate the possibility of extra wakeups
> caused by a race with psi_group_change however it will limit it to the
> worst case scenario of one extra wakeup per every tracking window (0.5s
> in the worst case).
> This patch also ensures correct ordering between clearing poll_scheduled
> flag and obtaining changed_states using memory barrier. Correct ordering
> between updating changed_states and setting poll_scheduled is ensured by
> atomic_xchg operation.
> By tracing the number of immediate rescheduling attempts performed by
> psi_group_change and the number of these attempts being blocked due to
> psi monitor being already active, we can assess the effects of this change:
>
> Before the patch:
>                                            Run#1    Run#2      Run#3
> Immediate reschedules attempted:           684365   1385156    1261240
> Immediate reschedules blocked:             682846   1381654    1258682
> Immediate reschedules (delta):             1519     3502       2558
> Immediate reschedules (% of attempted):    0.22%    0.25%      0.20%
>
> After the patch:
>                                            Run#1    Run#2      Run#3
> Immediate reschedules attempted:           882244   770298    426218
> Immediate reschedules blocked:             881996   769796    426074
> Immediate reschedules (delta):             248      502       144
> Immediate reschedules (% of attempted):    0.03%    0.07%     0.03%
>
> The number of non-blocked immediate reschedules dropped from 0.22-0.25%
> to 0.03-0.07%. The drop is attributed to the decrease in the race window
> size and the fact that we allow this race only when psi monitors reach
> polling window expiration time.
>
> Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
> Reported-by: Kathleen Chang <yt.chang@mediatek.com>
> Reported-by: Wenju Xu <wenju.xu@mediatek.com>
> Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: SH Chen <show-hong.chen@mediatek.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
> This patch somehow slipped through the cracks after being acked by Johannes in
> [1] and I didn't notice it until now because we cherry-picked it into Android
> kernel trees due to the urgency at that time. On the bright side, this change
> has been tested for about a year in the field by millions of devices.
> Resending v4 of this patch previously posted at [2], rebased on the latest
> Linus' TOT.

Hi Peter,
We missed this Ack'ed patch last year and as I described above I
didn't notice that up until now. With rc1 released, hopefully it's a
good time to ping you to ask for inclusion of this patch in your tree.
If the timing is not good, please let me know when to remind you and
I'll send another email. Just want to make sure it does not slip
again.

Just FYI, we have two other Ack'ed PSI patches for you to consider:

https://lore.kernel.org/all/20221014110551.22695-1-zhouchengming@bytedance.com/
https://lore.kernel.org/all/20220919072356.GA29069@haolee.io/

Thanks,
Suren.



>
> [1] https://lore.kernel.org/lkml/YOdwxh3487PeMHRX@cmpxchg.org/
> [2] https://lore.kernel.org/lkml/20210708203648.2399667-1-surenb@google.com/
>
>  include/linux/psi_types.h |  1 +
>  kernel/sched/psi.c        | 60 +++++++++++++++++++++++++++++++++------
>  2 files changed, 52 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index c7fe7c089718..3f78c9bf7bb1 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -170,6 +170,7 @@ struct psi_group {
>         struct timer_list poll_timer;
>         wait_queue_head_t poll_wait;
>         atomic_t poll_wakeup;
> +       atomic_t poll_scheduled;
>
>         /* Protects data used by the monitor */
>         struct mutex trigger_lock;
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7f6030091aee..2f548beeae50 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -188,6 +188,7 @@ static void group_init(struct psi_group *group)
>         INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
>         mutex_init(&group->avgs_lock);
>         /* Init trigger-related members */
> +       atomic_set(&group->poll_scheduled, 0);
>         mutex_init(&group->trigger_lock);
>         INIT_LIST_HEAD(&group->triggers);
>         group->poll_min_period = U32_MAX;
> @@ -561,18 +562,17 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>         return now + group->poll_min_period;
>  }
>
> -/* Schedule polling if it's not already scheduled. */
> -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> +/* Schedule polling if it's not already scheduled or forced. */
> +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> +                                  bool force)
>  {
>         struct task_struct *task;
>
>         /*
> -        * Do not reschedule if already scheduled.
> -        * Possible race with a timer scheduled after this check but before
> -        * mod_timer below can be tolerated because group->polling_next_update
> -        * will keep updates on schedule.
> +        * atomic_xchg should be called even when !force to provide a
> +        * full memory barrier (see the comment inside psi_poll_work).
>          */
> -       if (timer_pending(&group->poll_timer))
> +       if (atomic_xchg(&group->poll_scheduled, 1) && !force)
>                 return;
>
>         rcu_read_lock();
> @@ -584,12 +584,15 @@ static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
>          */
>         if (likely(task))
>                 mod_timer(&group->poll_timer, jiffies + delay);
> +       else
> +               atomic_set(&group->poll_scheduled, 0);
>
>         rcu_read_unlock();
>  }
>
>  static void psi_poll_work(struct psi_group *group)
>  {
> +       bool force_reschedule = false;
>         u32 changed_states;
>         u64 now;
>
> @@ -597,6 +600,43 @@ static void psi_poll_work(struct psi_group *group)
>
>         now = sched_clock();
>
> +       if (now > group->polling_until) {
> +               /*
> +                * We are either about to start or might stop polling if no
> +                * state change was recorded. Resetting poll_scheduled leaves
> +                * a small window for psi_group_change to sneak in and schedule
> +                * an immegiate poll_work before we get to rescheduling. One
> +                * potential extra wakeup at the end of the polling window
> +                * should be negligible and polling_next_update still keeps
> +                * updates correctly on schedule.
> +                */
> +               atomic_set(&group->poll_scheduled, 0);
> +               /*
> +                * A task change can race with the poll worker that is supposed to
> +                * report on it. To avoid missing events, ensure ordering between
> +                * poll_scheduled and the task state accesses, such that if the poll
> +                * worker misses the state update, the task change is guaranteed to
> +                * reschedule the poll worker:
> +                *
> +                * poll worker:
> +                *   atomic_set(poll_scheduled, 0)
> +                *   smp_mb()
> +                *   LOAD states
> +                *
> +                * task change:
> +                *   STORE states
> +                *   if atomic_xchg(poll_scheduled, 1) == 0:
> +                *     schedule poll worker
> +                *
> +                * The atomic_xchg() implies a full barrier.
> +                */
> +               smp_mb();
> +       } else {
> +               /* Polling window is not over, keep rescheduling */
> +               force_reschedule = true;
> +       }
> +
> +
>         collect_percpu_times(group, PSI_POLL, &changed_states);
>
>         if (changed_states & group->poll_states) {
> @@ -622,7 +662,8 @@ static void psi_poll_work(struct psi_group *group)
>                 group->polling_next_update = update_triggers(group, now);
>
>         psi_schedule_poll_work(group,
> -               nsecs_to_jiffies(group->polling_next_update - now) + 1);
> +               nsecs_to_jiffies(group->polling_next_update - now) + 1,
> +               force_reschedule);
>
>  out:
>         mutex_unlock(&group->trigger_lock);
> @@ -747,7 +788,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>         write_seqcount_end(&groupc->seq);
>
>         if (state_mask & group->poll_states)
> -               psi_schedule_poll_work(group, 1);
> +               psi_schedule_poll_work(group, 1, false);
>
>         if (wake_clock && !delayed_work_pending(&group->avgs_work))
>                 schedule_delayed_work(&group->avgs_work, PSI_FREQ);
> @@ -1223,6 +1264,7 @@ void psi_trigger_destroy(struct psi_trigger *t)
>                  * can no longer be found through group->poll_task.
>                  */
>                 kthread_stop(task_to_destroy);
> +               atomic_set(&group->poll_scheduled, 0);
>         }
>         kfree(t);
>  }
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
