Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75358647C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLIC1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIC1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:27:02 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1F67E813
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:27:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id l8so3509515ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8MOoXqUDbJlb+GBoy+k3WpGikVWg8B+EcbBrdi8ENo=;
        b=YQ8wH3AiTUIlVGtfZN2A8ucpwgUqcZS6x/T+MesrZCOJdztadQl8j4dqJ04LuhHra3
         MZrQWtg1au970Feqft5JmV00Odtwusx43Mdet4Xn+YM/FgMli9VC8sSPyS2wfze8pqjJ
         em+dS+UGk1uNJ8SQV+rdAHtSBuNAhDwX57fGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8MOoXqUDbJlb+GBoy+k3WpGikVWg8B+EcbBrdi8ENo=;
        b=3eiM2/3SPcG7K62iQFFrhzif/SCXWghvc1eLY9lYTpSU/L9rHUH/2hhBY8KFzavDmN
         3bzLV6Km4J5URGcVjlllZN+MWo60Fj79hlXPO7YKVsxMXc4y+BakKSaA8+sO2gyKhojk
         VmF5DYWTwC7xYBygarCgBqPyDq2W/zZihezuXaa7U7kSK+J9as1o5znRjBXYEMNvPRWS
         V4EyaBYrm+T+F937zSAx6ugYM4Z6x+BRQ6109WN1jRuSjcFOZdrB9muPhz8OgZejLA2w
         HWjKl/pm+mNWOuSqjgXRsX0Nd6fOchgkeprO2Th5JwnqmKAaJXY2VoNFjaxm7Qcgeeeu
         r6RA==
X-Gm-Message-State: ANoB5pm9OF5F3zhTE4NC+HpPT/uZ3NTeuYvDOPuuqm5qA8JhJ6XkswWR
        G/2m/2V5o1hO1RBwchCA4o4PANTAeexYIT0+8AFptqG6rm0LlQ==
X-Google-Smtp-Source: AA0mqf49I+hd4NrBtlIhKZM0vn2WLRcWJlhiLngo7GPuQAUvLaVEFBNb+i8bMoKa60tdWPMkFsWmIWtAuaxgu7REiNs=
X-Received: by 2002:a05:651c:124c:b0:279:f45e:ccd6 with SMTP id
 h12-20020a05651c124c00b00279f45eccd6mr6316673ljh.483.1670552818312; Thu, 08
 Dec 2022 18:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20221209022305.321149-1-joel@joelfernandes.org>
In-Reply-To: <20221209022305.321149-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 8 Dec 2022 21:26:46 -0500
Message-ID: <CAEXW_YT+Hwk1RC=QmPpUKGNa3kyPaBdZByEeAPFKD91=dm2XXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be boosted
To:     linux-kernel@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 9:23 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Currently RT boosting is only done for rtmutex_lock, however with proxy
> execution, we also have the mutex_lock participating in priorities. To
> exercise the testing better, add RT boosting to other lock testing types
> as well, using a new knob (rt_boost).
>
> Tested with boot parameters:
> locktorture.torture_type=mutex_lock
> locktorture.onoff_interval=1
> locktorture.nwriters_stress=8
> locktorture.stutter=0
> locktorture.rt_boost=1
> locktorture.rt_boost_factor=1
> locktorture.nlocks=3
>
> For the rtmutex test, rt_boost is always enabled even if disabling is
> requested.

Sorry, these 2 lines are outdated, I'll hope for you to delete the 2
lines, or I can respin and send later.

thanks,

 - Joel


>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/locking/locktorture.c | 99 ++++++++++++++++++++----------------
>  1 file changed, 56 insertions(+), 43 deletions(-)
>
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index bc3557677eed..8968fd65a90d 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -46,6 +46,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
>  torture_param(int, stat_interval, 60,
>              "Number of seconds between stats printk()s");
>  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> +torture_param(int, rt_boost, 2,
> +               "Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
>  torture_param(int, verbose, 1,
>              "Enable verbose debugging printk()s");
>  torture_param(int, nlocks, 1,
> @@ -129,15 +131,49 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
>           /* BUGGY, do not use in real life!!! */
>  }
>
> -static void torture_boost_dummy(struct torture_random_state *trsp)
> +static void __torture_rt_boost(struct torture_random_state *trsp)
>  {
> -       /* Only rtmutexes care about priority */
> +       const unsigned int factor = 50000; /* yes, quite arbitrary */
> +
> +       if (!rt_task(current)) {
> +               /*
> +                * Boost priority once every ~50k operations. When the
> +                * task tries to take the lock, the rtmutex it will account
> +                * for the new priority, and do any corresponding pi-dance.
> +                */
> +               if (trsp && !(torture_random(trsp) %
> +                             (cxt.nrealwriters_stress * factor))) {
> +                       sched_set_fifo(current);
> +               } else /* common case, do nothing */
> +                       return;
> +       } else {
> +               /*
> +                * The task will remain boosted for another ~500k operations,
> +                * then restored back to its original prio, and so forth.
> +                *
> +                * When @trsp is nil, we want to force-reset the task for
> +                * stopping the kthread.
> +                */
> +               if (!trsp || !(torture_random(trsp) %
> +                              (cxt.nrealwriters_stress * factor * 2))) {
> +                       sched_set_normal(current, 0);
> +               } else /* common case, do nothing */
> +                       return;
> +       }
> +}
> +
> +static void torture_rt_boost(struct torture_random_state *trsp)
> +{
> +       if (rt_boost != 2)
> +               return;
> +
> +       __torture_rt_boost(trsp);
>  }
>
>  static struct lock_torture_ops lock_busted_ops = {
>         .writelock      = torture_lock_busted_write_lock,
>         .write_delay    = torture_lock_busted_write_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_lock_busted_write_unlock,
>         .readlock       = NULL,
>         .read_delay     = NULL,
> @@ -181,7 +217,7 @@ __releases(torture_spinlock)
>  static struct lock_torture_ops spin_lock_ops = {
>         .writelock      = torture_spin_lock_write_lock,
>         .write_delay    = torture_spin_lock_write_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_spin_lock_write_unlock,
>         .readlock       = NULL,
>         .read_delay     = NULL,
> @@ -208,7 +244,7 @@ __releases(torture_spinlock)
>  static struct lock_torture_ops spin_lock_irq_ops = {
>         .writelock      = torture_spin_lock_write_lock_irq,
>         .write_delay    = torture_spin_lock_write_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_lock_spin_write_unlock_irq,
>         .readlock       = NULL,
>         .read_delay     = NULL,
> @@ -277,7 +313,7 @@ __releases(torture_rwlock)
>  static struct lock_torture_ops rw_lock_ops = {
>         .writelock      = torture_rwlock_write_lock,
>         .write_delay    = torture_rwlock_write_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_rwlock_write_unlock,
>         .readlock       = torture_rwlock_read_lock,
>         .read_delay     = torture_rwlock_read_delay,
> @@ -320,7 +356,7 @@ __releases(torture_rwlock)
>  static struct lock_torture_ops rw_lock_irq_ops = {
>         .writelock      = torture_rwlock_write_lock_irq,
>         .write_delay    = torture_rwlock_write_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_rwlock_write_unlock_irq,
>         .readlock       = torture_rwlock_read_lock_irq,
>         .read_delay     = torture_rwlock_read_delay,
> @@ -362,7 +398,7 @@ __releases(torture_mutex)
>  static struct lock_torture_ops mutex_lock_ops = {
>         .writelock      = torture_mutex_lock,
>         .write_delay    = torture_mutex_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_mutex_unlock,
>         .readlock       = NULL,
>         .read_delay     = NULL,
> @@ -460,7 +496,7 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
>         .exit           = torture_ww_mutex_exit,
>         .writelock      = torture_ww_mutex_lock,
>         .write_delay    = torture_mutex_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_ww_mutex_unlock,
>         .readlock       = NULL,
>         .read_delay     = NULL,
> @@ -478,37 +514,6 @@ __acquires(torture_rtmutex)
>         return 0;
>  }
>
> -static void torture_rtmutex_boost(struct torture_random_state *trsp)
> -{
> -       const unsigned int factor = 50000; /* yes, quite arbitrary */
> -
> -       if (!rt_task(current)) {
> -               /*
> -                * Boost priority once every ~50k operations. When the
> -                * task tries to take the lock, the rtmutex it will account
> -                * for the new priority, and do any corresponding pi-dance.
> -                */
> -               if (trsp && !(torture_random(trsp) %
> -                             (cxt.nrealwriters_stress * factor))) {
> -                       sched_set_fifo(current);
> -               } else /* common case, do nothing */
> -                       return;
> -       } else {
> -               /*
> -                * The task will remain boosted for another ~500k operations,
> -                * then restored back to its original prio, and so forth.
> -                *
> -                * When @trsp is nil, we want to force-reset the task for
> -                * stopping the kthread.
> -                */
> -               if (!trsp || !(torture_random(trsp) %
> -                              (cxt.nrealwriters_stress * factor * 2))) {
> -                       sched_set_normal(current, 0);
> -               } else /* common case, do nothing */
> -                       return;
> -       }
> -}
> -
>  static void torture_rtmutex_delay(struct torture_random_state *trsp)
>  {
>         const unsigned long shortdelay_us = 2;
> @@ -534,10 +539,18 @@ __releases(torture_rtmutex)
>         rt_mutex_unlock(&torture_rtmutex);
>  }
>
> +static void torture_rt_boost_rtmutex(struct torture_random_state *trsp)
> +{
> +       if (!rt_boost)
> +               return;
> +
> +       __torture_rt_boost(trsp);
> +}
> +
>  static struct lock_torture_ops rtmutex_lock_ops = {
>         .writelock      = torture_rtmutex_lock,
>         .write_delay    = torture_rtmutex_delay,
> -       .task_boost     = torture_rtmutex_boost,
> +       .task_boost     = torture_rt_boost_rtmutex,
>         .writeunlock    = torture_rtmutex_unlock,
>         .readlock       = NULL,
>         .read_delay     = NULL,
> @@ -604,7 +617,7 @@ __releases(torture_rwsem)
>  static struct lock_torture_ops rwsem_lock_ops = {
>         .writelock      = torture_rwsem_down_write,
>         .write_delay    = torture_rwsem_write_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_rwsem_up_write,
>         .readlock       = torture_rwsem_down_read,
>         .read_delay     = torture_rwsem_read_delay,
> @@ -656,7 +669,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
>         .exit           = torture_percpu_rwsem_exit,
>         .writelock      = torture_percpu_rwsem_down_write,
>         .write_delay    = torture_rwsem_write_delay,
> -       .task_boost     = torture_boost_dummy,
> +       .task_boost     = torture_rt_boost,
>         .writeunlock    = torture_percpu_rwsem_up_write,
>         .readlock       = torture_percpu_rwsem_down_read,
>         .read_delay     = torture_rwsem_read_delay,
> --
> 2.39.0.rc1.256.g54fd8350bd-goog
>
