Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B55719EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjFANzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjFANzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:55:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E7413D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:55:29 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6af6ec3df42so906324a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685627729; x=1688219729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pdh7Re/z1EfV1vaSkYB2fIIjzv4y279IhAvtLSyRqx8=;
        b=bnJI6D/w9C7Gx94PQWhVxahagGExUxV2e9UhJPTZk4Dq5yKwnlwSPk4rAtAoMqto8/
         9UM4yA7FF3dkwKF7PN9ZcPwFPUOZyPwfc+EAAzZzjbv5xQQXXAbkfpNH28gglvMckoWF
         wOpv7ZFHIpGf2Dt/PsJ7rzIZCYTCr2S3ZGgMdhwYKfHwtwjs7L3vmjg5HRMYV3KWjFuw
         GuyXakZ4lr+YeLylqQm8i8e3d7jC6XzPZeDvTlaIZ5CnBPvYbSkBY6T58qSqYDzC9fQb
         8ZfB7A1ZQeZMsyNDbmnY51MLqo/gatgU7tHPFMxZmOi9URb8Zn2TxsUcZWlUMOdz/+dV
         wvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627729; x=1688219729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdh7Re/z1EfV1vaSkYB2fIIjzv4y279IhAvtLSyRqx8=;
        b=Auvv8ekwhOGqHiBD9ZcfB3iYcqEbbaSIbufGN1T+Da27gWZTCswH03BzECDgZDeaNL
         E8RGqysWLyk1H6wpnf031FX1QjCNYFNbPfmQDwj39oxo4j3lcSnfnVzY6zoKyevuOj/+
         yZ07EFyElraN2T+5Ep+2c5jI/cB5BQItJyWV23msCs1UJni/cMs4N21H+U7j55jslNi/
         2x+dXjjuNy3/Oy+Kvau5TZocBbAtJDT1pZFVQCtp6bfUq/yG2TFUQqM9VUPsDvn4mtFQ
         19AkXQkGBKZwBGXNoE4qmMYcHgTd9CCrQmnU/VTVvETD3s8q5h4MLKC1r8wifhJ3sySx
         cXJw==
X-Gm-Message-State: AC+VfDx82Aie99A0SOr23KkjMkXZFP7+wb2iTp8wc0dRfLCDfRTYil1Q
        R/+EWURwwTfiWtw8/yneiQro6GXMfnSI6Oj+5H6tfQ==
X-Google-Smtp-Source: ACHHUZ7hxOxuBcLWXFZwMcp4eMPYXQv2akJpff0Bu48uqPaD5zpHSDaxcY7xGSE/ZJ8pPocEocULiFxFBfA1rtLIoRs=
X-Received: by 2002:a05:6358:4315:b0:123:3ea3:2bd2 with SMTP id
 r21-20020a056358431500b001233ea32bd2mr6019614rwc.32.1685627729122; Thu, 01
 Jun 2023 06:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <20230531124604.615053451@infradead.org>
In-Reply-To: <20230531124604.615053451@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 1 Jun 2023 15:55:18 +0200
Message-ID: <CAKfTPtCTe7pc=fahynt1kTffUXk5B18usEE_Ay40vE-yjVt0=A@mail.gmail.com>
Subject: Re: [RFC][PATCH 15/15] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 at 14:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> As an alternative to the latency-nice interface; allow applications to
> directly set the request/slice using sched_attr::sched_runtime.
>
> The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
> which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.

There were some discussions about the latency interface and setting a
raw time value. The problems with using a raw time value are:
- what  does this raw time value mean ? and how it applies to the
scheduling latency of the task. Typically what does setting
sched_runtime to 1ms means ? Regarding the latency, users would expect
to be scheduled in less than 1ms but this is not what will (always)
happen with a sched_slice set to 1ms whereas we ensure that the task
will run for sched_runtime in the sched_period (and before
sched_deadline) when using it with deadline scheduler. so this will be
confusing
- more than a runtime, we want to set a scheduling latency hint which
would be more aligned with a deadline
- Then the user will complain that he set 1ms but its task is
scheduled after several (or even dozens) ms in some cases. Also, you
will probably end up with everybody setting 0.1ms and expecting 0.1ms
latency. The latency nice like the nice give an opaque weight against
others without any determinism that we can't respect
- How do you set that you don't want to preempt others ? But still
want to keep your allocated running time.

>
> Applications should strive to use their periodic runtime at a high
> confidence interval (95%+) as the target slice. Using a smaller slice
> will introduce undue preemptions, while using a larger value will
> reduce latency.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |   24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7494,10 +7494,18 @@ static void __setscheduler_params(struct
>
>         p->policy = policy;
>
> -       if (dl_policy(policy))
> +       if (dl_policy(policy)) {
>                 __setparam_dl(p, attr);
> -       else if (fair_policy(policy))
> +       } else if (fair_policy(policy)) {
>                 p->static_prio = NICE_TO_PRIO(attr->sched_nice);
> +               if (attr->sched_runtime) {
> +                       p->se.slice = clamp_t(u64, attr->sched_runtime,
> +                                             NSEC_PER_MSEC/10,   /* HZ=1000 * 10 */
> +                                             NSEC_PER_MSEC*100); /* HZ=100  / 10 */
> +               } else {
> +                       p->se.slice = sysctl_sched_base_slice;
> +               }
> +       }
>
>         /*
>          * __sched_setscheduler() ensures attr->sched_priority == 0 when
> @@ -7689,7 +7697,9 @@ static int __sched_setscheduler(struct t
>          * but store a possible modification of reset_on_fork.
>          */
>         if (unlikely(policy == p->policy)) {
> -               if (fair_policy(policy) && attr->sched_nice != task_nice(p))
> +               if (fair_policy(policy) &&
> +                   (attr->sched_nice != task_nice(p) ||
> +                    (attr->sched_runtime && attr->sched_runtime != p->se.slice)))
>                         goto change;
>                 if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
>                         goto change;
> @@ -8017,12 +8027,14 @@ static int sched_copy_attr(struct sched_
>
>  static void get_params(struct task_struct *p, struct sched_attr *attr)
>  {
> -       if (task_has_dl_policy(p))
> +       if (task_has_dl_policy(p)) {
>                 __getparam_dl(p, attr);
> -       else if (task_has_rt_policy(p))
> +       } else if (task_has_rt_policy(p)) {
>                 attr->sched_priority = p->rt_priority;
> -       else
> +       } else {
>                 attr->sched_nice = task_nice(p);
> +               attr->sched_runtime = p->se.slice;
> +       }
>  }
>
>  /**
>
>
