Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9235D67B60B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjAYPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjAYPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:34:51 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9AE59770
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:34:50 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so29600670lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KeeU2VaSrijXvr0YrVWMRzybr+5thHWkFZC9L5GjLSU=;
        b=TxQd6MvN6+arboJ7XR0EwlemSh977VYn5fZ22vKPElLe3DA6762UUI1fy0E9VguGgp
         5j6vBRSaBT6jIuAk6tDNR+hbxoq7F2MTsRS2FLJ5B9jQgP0RstEYuKQZZbMOporq4V0B
         Co5rXkBSoY/AsL7sMhySMF36XRH/CXszhgT6nG5eUTWL3UJ4UuVvCI6XsUkiLW1EeSJ2
         KwXq5WFQGCD3zxk+NWPAA9zWW3asIC4Jbs0BqVQ5rlmXuit0ff06uV7DltZTGYlmCtlT
         WiuvLZrPWXX+OwKd/XjDBzw0aP5O/Bpk5qjtyofIv5Pf/KBs9VSIG3x2iVL0MhYPD3/6
         TPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeeU2VaSrijXvr0YrVWMRzybr+5thHWkFZC9L5GjLSU=;
        b=WxO2gCNVUbAjpcaluotqDdgY6i1NMAyv0E9M9sbOXSvzvB89ECXmpEZnIyz37KycKG
         pyFsXZ67tLcO9NO0awaDpvK2lvX6+goGQOdqAuOgZG/Nw5+ax2ejpeo6z5+pc084rqBJ
         kUKJLBgTJxQ/aeh0cB+c6vb6nivnkr/qzaEggYUG17ZHDPdL9jJhtf2QwCcNvuMIsqsB
         Tdmw9EHXBLqZ+sdJfcJaj+o66YomKew4Qwa1xxm5C0HTZo0fE3bOL9xQfI6HJXO/13jP
         RWkzC89HUwJkp8K6isyr+10OrdkCSOa90MvmAqkmjYYz5BTE7WAXk2ND38RFL77EXeo5
         Z61w==
X-Gm-Message-State: AFqh2kpaxtGV2RlVvPx1F40rVEmKCmaGDE+Y5d3/5gSteaJwz/13Nuyk
        Uz+UOPQiFWq8tBXFOk0mQno6NDdN2PMMdCa/v71Big==
X-Google-Smtp-Source: AMrXdXsN36koYJHKm53N1n6U4NYzAfBnvye/XtH2LA6yC83q2ex+2ooAuPEA8J5bPi5UZZz0COruhDQAqeEhp6sD2kY=
X-Received: by 2002:ac2:4bd0:0:b0:4c5:32a4:6f88 with SMTP id
 o16-20020ac24bd0000000b004c532a46f88mr2351935lfq.6.1674660888142; Wed, 25 Jan
 2023 07:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20221216171807.760147-1-dvyukov@google.com> <20230112112411.813356-1-dvyukov@google.com>
 <20230125124304.GA13746@redhat.com> <20230125151717.GB13746@redhat.com>
In-Reply-To: <20230125151717.GB13746@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 25 Jan 2023 16:34:35 +0100
Message-ID: <CACT4Y+YKy_4mBLYomr49+fTm31Y6Q_kXhJz8O-_RTjMe=B-6eg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] posix-timers: Support delivery of signals to the
 current thread
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
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

 On Wed, 25 Jan 2023 at 16:17, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 01/25, Oleg Nesterov wrote:
> >
> > Other than that I see nothing wrong in this patch, but I forgot everything
> > about posix timers many years ago ;)
>
> Stupid question. Am I right that in posix_timer_event()
>
>         same_thread_group(current, pid_task(timr->it_pid, PIDTYPE_PID))
>
> is always true?
>
> If yes, perhaps we can do a much simpler change which doesn't even affect API?
> See the trivial patch below.
>
> send_sigqueue(PIDTYPE_TGID) notify any thread in thread group, so this doesn't
> really change the semantics, just complete_signal() will likely choose "current"
> as a target for signal_wake_up() and iiuc this is what we want for balancing?
>
> Oleg.
>
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 5dead89308b7..e38b53a0f814 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -336,6 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
>  int posix_timer_event(struct k_itimer *timr, int si_private)
>  {
>         enum pid_type type;
> +       struct pid *pid;
>         int ret;
>         /*
>          * FIXME: if ->sigq is queued we can race with
> @@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
>          */
>         timr->sigq->info.si_sys_private = si_private;
>
> -       type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> -       ret = send_sigqueue(timr->sigq, timr->it_pid, type);
> +       type = (timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_PID : PIDTYPE_TGID;
> +       pid = (type == PIDTYPE_PID) ? timr->it_pid : task_pid(current);
> +       ret = send_sigqueue(timr->sigq, pid, type);
>         /* If we failed to send the signal the timer stops. */
>         return ret > 0;
>  }

Hi Oleg,

This is indeed much simpler!

Do I understand correctly that:
1. I would need to use SIGEV_SIGNAL (without SIGEV_THREAD_ID)
2. The signal is still queued into process shared_pending
3. If the current task has not blocked the signal (it shouldn't), then
it won't kick any other task
4. The current task will likely deliver the signal right on the timer
interrupt return to userspace
?

This changes the existing behavior (the "average bear" may be surprised :))
https://elixir.bootlin.com/linux/v6.2-rc5/source/kernel/signal.c#L1007
But currnently it's also queued into shared_pending and any thread
could get the signal anyway. So I think this should be fine.

On the positive side: it should improve performance. Delivering to the
currently running task is better on all fronts (no kicking,
rescheduling, IPIs, better locality), right?

Let me test that it works for my use-case.
