Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707AE60685C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJTSni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:43:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E1D208817
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:43:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy4so1668355ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a4MNsuWXvt+bS3agOGU3z+N2CwGZIxCInLkhAMhqwl0=;
        b=Ug8LDle/yVBuiKK79Ei1HiwQqWtE9+BFTn8qtqeyTo+OZOZQ0/5ECS8+MR8vbahV9A
         NFiFsNGEAY4t1LXeJ0vjZ3+1vDtu2oZ1XhE0Pn53dlSSWTH3pxRK6kmJh/DtDGwoDGK8
         DsAWna/UKmgZ0UDWvzjabdTRRmwg8fu0CoGL8hJgQnDpfjLJqwEfRUNOgpUQIuKM1ziW
         Nw6oJ7VqaHAVMWfYxgMIvN3reS4aLhiBG6dPd5mxKIzYH1LIcorjvpZPoJINrtqJfdON
         gjMSUHwKl6ru6qp5XQwpDcpqbYCHKQzt9ARe3c9c+71FbP8o27B6vV3Q+pY0esxjb6fb
         ciCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4MNsuWXvt+bS3agOGU3z+N2CwGZIxCInLkhAMhqwl0=;
        b=x3QIP4MzHW9Trf8unniZ7NSnOY+SC4M3fI1ZcZN5K54IYvHBExXvaWUQKr/sFlyrMP
         ppXVjcYBrSOI04KGEH4V4GmxD34QMP/MLFrgHBPO6si1F3267T+9bieWha+KL7mrSSPC
         HGm8xG/4Ta3QpXYSPP7XWsPA9YNltaWC4JggqzbO9WwVsfl0vb5BfuxUDkjWwv9vKg/T
         mKWL3ukVIGvnO6Z5EqHxfrgnsX8yTmK7QIVJ7gSk5gP8K2XYU+uRSKDkaihomsgqEdId
         17O69hWF3z5cT3W9IWcAr/17fRVeAFS4KuseV6xrlgQeXdaWqo1gfmwy+IiDC6LyX8rd
         mnFw==
X-Gm-Message-State: ACrzQf2rNGdDIaIwtZ6zeBStrV/SAVqJTgeqp18MyxpShVZ3lyvKY9O6
        GDH0hniaMZKp88PJ0ZZWg43FRGgdZpq1GJhlkKlTiQ==
X-Google-Smtp-Source: AMsMyM5NryrBEVL92yY+4fuy+BVBZ1+RXYvsGixaWGVhnPJpn73+WzMltR4/AwjeQsfiPg1+Pmsg1dar/SGUopxBg/U=
X-Received: by 2002:a17:906:fe04:b0:777:b13d:30a6 with SMTP id
 wy4-20020a170906fe0400b00777b13d30a6mr12022670ejb.248.1666291414788; Thu, 20
 Oct 2022 11:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com> <20221003214501.2050087-2-connoro@google.com>
 <73859883-78c4-1080-7846-e8d644ad397a@redhat.com>
In-Reply-To: <73859883-78c4-1080-7846-e8d644ad397a@redhat.com>
From:   "Connor O'Brien" <connoro@google.com>
Date:   Thu, 20 Oct 2022 11:43:23 -0700
Message-ID: <CALE1s+PPhC0Eb5Eojz+H5m96OXdc5qp6eOhj16vZgsP9n_UX1A@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] locking/ww_mutex: Remove wakeups from under mutex::wait_lock
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
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

On Tue, Oct 4, 2022 at 9:01 AM Waiman Long <longman@redhat.com> wrote:
>
> On 10/3/22 17:44, Connor O'Brien wrote:
> > diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> > index 56f139201f24..dfc174cd96c6 100644
> > --- a/kernel/locking/ww_mutex.h
> > +++ b/kernel/locking/ww_mutex.h
> > @@ -161,6 +161,11 @@ static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
> >
> >   #endif /* WW_RT */
> >
> > +void ww_ctx_wake(struct ww_acquire_ctx *ww_ctx)
> > +{
> > +     wake_up_q(&ww_ctx->wake_q);
> > +}
> > +
> >   /*
> >    * Wait-Die:
> >    *   The newer transactions are killed when:
> > @@ -284,7 +289,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
> >   #ifndef WW_RT
> >               debug_mutex_wake_waiter(lock, waiter);
> >   #endif
> > -             wake_up_process(waiter->task);
> > +             wake_q_add(&ww_ctx->wake_q, waiter->task);
> >       }
> >
> >       return true;
> > @@ -331,7 +336,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
> >                * wakeup pending to re-read the wounded state.
> >                */
> >               if (owner != current)
> > -                     wake_up_process(owner);
> > +                     wake_q_add(&ww_ctx->wake_q, owner);
> >
> >               return true;
> >       }
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ee28253c9ac0..617e737392be 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1013,6 +1013,13 @@ void wake_up_q(struct wake_q_head *head)
> >               wake_up_process(task);
> >               put_task_struct(task);
> >       }
> > +     /*
> > +      * XXX connoro: seems this is needed now that ww_ctx_wake() passes in a
> > +      * wake_q_head that is embedded in struct ww_acquire_ctx rather than
> > +      * declared locally.
> > +      */
> > +     head->first = node;
> > +     head->lastp = &head->first;
> >   }
> >
>
> You shouldn't do wake_q_init() here in wake_up_q(). Instead, you should
> do it in ww_ctx_wake() right after the wake_up_q() call.

Thanks, will fix this in the next version.

>
> Cheers,
> Longman
>
