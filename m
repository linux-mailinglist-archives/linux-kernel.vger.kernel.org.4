Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4195365254B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiLTRLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiLTRK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:10:59 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E155B9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:10:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so17142412pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRFWK6w5Cy23e8XWT1rWbDLN91A4EEYHoS5gC9uHUWw=;
        b=byb0eseT4pcRW7S1BedH8qClZpIZ/t1ewezDb5xRPr2nNpYMyTy7+iiI819WXurMX9
         9xv2F5V8ypRxyfEHgBkAC5bKHMb5v7MNGLZ+0pzO8ZYD8/BnQLcypHHj9+tqdHyVUkJY
         LUkx7dQJKfaRr1cHjB9EVB5TTv2igixjA78VN7hDpweg/AeHGxEXq7XkmtT+nop/9hIN
         OFuv2GXqlGcR1/FE18gKxF12JDHQVlVT+ImihF/4a4CILJtg4Y7QaWeRb+et/42zjhus
         0HHPTXnPGVUP5/3cX5WyUiIvZX9gQd3CxEt6+tcAw9QrdoMMK6Jr7CHOeCLv7ix7UJcL
         bxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRFWK6w5Cy23e8XWT1rWbDLN91A4EEYHoS5gC9uHUWw=;
        b=sag0t8MvC+42DVkieHz5PChbJGljK8I1umjtsjjLkKSG94iuStC+zzEaozmDVo0LdI
         Loqbc7mOo1etyfyG3nI777dhpMrYhJKtP3OuuI1O1X7XkjsyreD1AMCRQdPgvoOBk5aA
         JzRL6Ns/M+OqEapUH8V0a/ggGoyWSnGUxNiPdBVfRnBp9/h1SHjKyYip7HCPReda7iuN
         Pa81Owdedlksc2SGu+ujAh+V8svhUZW9cmZR0eAUcreiu4AdvFV01ddgjnstcN2zlzFV
         KGRoKKYQx0rODQ6CsRb73t3TY84AOC8rNJ+hoNy7slLWv+EaKOrBpLLNTLDqscWlfnpI
         Q/VQ==
X-Gm-Message-State: AFqh2krAhtoO3rB6Cy4hRp7gpuDUnYYOAa1FoYJM8V28YezH7AXse1FT
        4WA69HpHekakJbeKK23Nb4rsGzbb7ePGF9xT3O18/A==
X-Google-Smtp-Source: AMrXdXsALyFNjPlFG4yf3lODzR8YQRjaaupV8Exb4GUM16lEM67mrUbJLzgTaW82cCAQqC1FoplqXzbCU+2Xwheo+Hg=
X-Received: by 2002:a17:90b:17d0:b0:219:d33d:4689 with SMTP id
 me16-20020a17090b17d000b00219d33d4689mr2035693pjb.233.1671556256903; Tue, 20
 Dec 2022 09:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20221208075604.811710-1-junxiao.chang@intel.com> <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Tue, 20 Dec 2022 09:10:45 -0800
Message-ID: <CAFzL-7t4AxR-8j6_JP-MQPOqw-tjq6Ds5MTgy4bgRUCK7Ga8bQ@mail.gmail.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
To:     "Chang, Junxiao" <junxiao.chang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>,
        Glenn Elliott <glenn@aurora.tech>,
        Rami Jaber <rjaber@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 2:44 AM Chang, Junxiao <junxiao.chang@intel.com> wr=
ote:
> Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.1=
9-rt kernel as well.

In

https://lore.kernel.org/linux-rt-users/CAFzL-7v-NSFKAsyhxReEES7bMomSTwYyrZs=
cnjbkydEP3CTXmQ@mail.gmail.com/

we reported an occasional problem with an x86 system entering a deep C
state even though timers were pending.   Perhaps your patch would
prevent this transition.

> This issue is easier to reproduced when there is heavy network workload w=
hich introduces a lot of softirq events. If hrtimer interrupt is triggered =
in softirq context, with current RT kernel, it will not wake up ktimers thr=
ead which handles hrtimer event because in function __irq_exit_rcu, "in_int=
errupt()" is true:
>
> static inline void __irq_exit_rcu(void)
> {
> ...
>         preempt_count_sub(HARDIRQ_OFFSET);
>         if (!in_interrupt()) {
>                 if (local_softirq_pending())
>                         invoke_softirq();
>
>                 if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers=
())
>                         wake_timersd();
>         }
> ...
> }
>

Isn't removing the check for IS_ENABLED(CONFIG_PREEMPT_RT) inadvisable?

> Then ktimers threads stays in sleep state, hrtimer function will not be c=
alled although hrtimer interrupt has been triggered. Ktimers thread might b=
e woken up in next timer interrupt which introduces long delay.
>
> Any comments are welcome.
>
> Regards,
> Junxiao

-- Alison Chaiken
Aurora Innovation


 -----Original Message-----
> From: Chang, Junxiao <junxiao.chang@intel.com>
> Sent: Thursday, December 8, 2022 3:56 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-rt-users@vger.kernel.org; bigeasy@linutronix.de; tglx@linutroni=
x.de; rostedt@goodmis.org; Chang, Junxiao <junxiao.chang@intel.com>; Peh, H=
ock Zhang <hock.zhang.peh@intel.com>
> Subject: [PATCH] softirq: wake up ktimer thread in softirq context
>
> Occiaionally timer interrupt might be triggered in softirq context, ktime=
r thread should be woken up with RT kernel, or else ktimer thread might sta=
y in sleep state although timer interrupt has been triggered.
>
> This change fixes a latency issue that timer handler is delayed for more =
than 4ms in network related test.
>
> Fixes: 2165d27554e8 ("softirq: Use a dedicated thread for timer wakeups."=
)
> Reported-by: Peh, Hock Zhang <hock.zhang.peh@intel.com>
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  kernel/softirq.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c index ab1fe34326bab..34a=
e39e4a3d10 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -664,13 +664,10 @@ static inline void __irq_exit_rcu(void)  #endif
>         account_hardirq_exit(current);
>         preempt_count_sub(HARDIRQ_OFFSET);
> -       if (!in_interrupt()) {
> -               if (local_softirq_pending())
> -                       invoke_softirq();
> -
> -               if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers=
())
> -                       wake_timersd();
> -       }
> +       if (!in_interrupt() && local_softirq_pending())
> +               invoke_softirq();
> +       if (!(in_nmi() || in_hardirq()) && local_pending_timers())
> +               wake_timersd();
>
>         tick_irq_exit();
>  }
> --
> 2.25.1
>
