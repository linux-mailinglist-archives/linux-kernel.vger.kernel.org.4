Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ECE67C946
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjAZK6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbjAZK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:58:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BF2E0DD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:58:30 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so2488548lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vliCibrNqXv/PIuIH5pntK45iVapQivTMjCbhKKGPN8=;
        b=FN+ghFAyC2KLxfrbCAo3HfBrVQ9hvknAzghxAMh94Km5lFp7hA/+oMTD4IvwGDy3FN
         x0LyrRsVCyXce2glIutKobmwCsh5JMBgba+5nyAtAfDHX5Nt1ra/TcsWMKn9khmu0xzI
         c/Yln503y/fjdZVECWWEwDyzjB6/wfjzUL20XrqWsKxpEBjORunzK3QQooKE6TEIE6Nd
         esd1LtiZNVEdJuZecjAe5R6EVEI4jfiLWTN7xXVyIFmdxNZ/+QNet6+1z8hOeh908AOQ
         1TcRZcpZy4qVkqtrQSae9YsRbR9EVPAabifJEue3fhZHG4bhLrxWOIXeOmlKEfxDivDW
         7AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vliCibrNqXv/PIuIH5pntK45iVapQivTMjCbhKKGPN8=;
        b=mab19IzFYq0VKKKqP0VftHAOuatBBJKI6Sevm9wzWg0iW5ycGskL3vjvnKAg+aTWTb
         RWo0oqDHASw6UX4dYSdXegQR3zJw6A1Mp/Jaqt3AjLQRbXekS+AyoRv3ncOMVBtdvUCP
         vRCsXKsUXpe8Kub1VbS335u4JPMd21nUBASQ+uMmWY11SoCSgNxrRBy8Ym0lBiJu+tjD
         VH+e1IqkTlRZpcfMr9rtyRlka1GIa8BMTQPd/cas8LbZnPXZahjhflWT2ZgyGfj7hXRs
         mcLf/Op/Ci1UETQwGa8vyEUjLID6s1gbwOwbUlh16HyVWquh855OJDWNTj33fvQm7lAI
         zQvQ==
X-Gm-Message-State: AFqh2kq31QU3NPmbC6DSHYrM2Wsf1VikQl8lLV9tiHh96HiCtQFcmCzl
        jjAfECMWyED2yb63cRlaZp/oqmkLlKAU2oYehTq8OQ==
X-Google-Smtp-Source: AMrXdXtBgbTsBjGNQ7wulcHQ0err7NYcjNcADfAV5ro/lEfwlaKZI9AXHQjL8BtDrTmHeYM7RJVnO/fYK4dcUYfmkc4=
X-Received: by 2002:ac2:508f:0:b0:4cb:7c2:87ee with SMTP id
 f15-20020ac2508f000000b004cb07c287eemr3483222lfm.165.1674730708246; Thu, 26
 Jan 2023 02:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20221216171807.760147-1-dvyukov@google.com> <20230112112411.813356-1-dvyukov@google.com>
 <20230125124304.GA13746@redhat.com> <20230125151717.GB13746@redhat.com>
 <CACT4Y+YKy_4mBLYomr49+fTm31Y6Q_kXhJz8O-_RTjMe=B-6eg@mail.gmail.com>
 <20230125163137.GC13746@redhat.com> <20230125170708.GE13746@redhat.com>
In-Reply-To: <20230125170708.GE13746@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 26 Jan 2023 11:58:16 +0100
Message-ID: <CACT4Y+ZMOLw0QZ=ssmgs5oU8+jRxt0JZScQzKneG036vWZ=0wg@mail.gmail.com>
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

On Wed, 25 Jan 2023 at 18:07, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 01/25, Oleg Nesterov wrote:
> >
> > > >  int posix_timer_event(struct k_itimer *timr, int si_private)
> > > >  {
> > > >         enum pid_type type;
> > > > +       struct pid *pid;
> > > >         int ret;
> > > >         /*
> > > >          * FIXME: if ->sigq is queued we can race with
> > > > @@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
> > > >          */
> > > >         timr->sigq->info.si_sys_private = si_private;
> > > >
> > > > -       type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> > > > -       ret = send_sigqueue(timr->sigq, timr->it_pid, type);
> > > > +       type = (timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_PID : PIDTYPE_TGID;
> > > > +       pid = (type == PIDTYPE_PID) ? timr->it_pid : task_pid(current);
> > > > +       ret = send_sigqueue(timr->sigq, pid, type);
> > > >         /* If we failed to send the signal the timer stops. */
> > > >         return ret > 0;
> > > >  }
>
> ...
>
> > But! I just noticed send_sigqueue() does pid_task(pid, type), so the patch
> > above needs another change
> >
> >       --- a/kernel/signal.c
> >       +++ b/kernel/signal.c
> >       @@ -1970,7 +1970,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
> >
> >               ret = -1;
> >               rcu_read_lock();
> >       -       t = pid_task(pid, type);
> >       +       // comment to explain why don't we use "type"
> >       +       t = pid_task(pid, PIDTYPE_PID);
> >               if (!t || !likely(lock_task_sighand(t, &flags)))
> >                       goto ret;
>
> So. Unless I missed something (quite possibly) we do not even need the patch
> above. The one liner change below can work just fine.
>
> Oleg.
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1970,7 +1970,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>
>         ret = -1;
>         rcu_read_lock();
> -       t = pid_task(pid, type);
> +       /* GOOD COMMENT */
> +       t = type == PIDTYPE_PID ? pid_task(pid, type) : current;
>         if (!t || !likely(lock_task_sighand(t, &flags)))
>                 goto ret;

This works for my use-case.

However, this is a bit trickier since current may be completely
unrelated to the original timer/process (think of monotonic timers).

Please take a look at v3:
https://lore.kernel.org/lkml/20221216171807.760147-1-dvyukov@google.com/T/#me78642cc096184da681cf91c39932be2bd2b74e1
