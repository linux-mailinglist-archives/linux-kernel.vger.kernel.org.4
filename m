Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D95FCF12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJLXzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLXzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:55:00 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CDA27145
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 16:54:58 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j21so155770qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 16:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTHHr/MWxMd0iit2mQfPzchuu/gnFAYaWicjCw3O9Rk=;
        b=WwKieyq6thYuR2x+u6cnHGLiFETZ8wGw39vL83H0ji9AvWeFzn8/BwVhy6WQPR/gHH
         r5VGVqR+n3eQWCnaF52CAcfUb+ET/wZrRzyn1vmtYBGuejll8QFVUgzK57orunlKsdyt
         vIHEmccnxEGj76jdRfOOWP26+ePsTNrfYhiys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTHHr/MWxMd0iit2mQfPzchuu/gnFAYaWicjCw3O9Rk=;
        b=d2nzzFakpKwLDg/tisqbQlNWi3s9rtgXc5KYYPOYdzDXunSDb4R9DcDzKQRZHMC2Na
         UtXk7uFdIBQrBdBfdl2TUPOXSqbCM+c7BCJdHqa18CxPHkhRUv2GT05EcG/amnPG2ABa
         CNHeq0pS+YhHrxhxP4yfNZyFiqZIU/CymfBcTWRHOVG8DUfoiitBx7dmAtBBbsyg/VTq
         HewvUCgDcB1lXOIa4xe53YWy37DnXa2e5+Pr7wNugrd+t0vTCwGLAEuqxnPZO8fcZvGn
         qXwNOfsij3hcrkfREeHIX3f90bNDloFNbgx/gz9DuPO9Y7URlKgjWRt1ILQXbmN8ar6P
         +5Mg==
X-Gm-Message-State: ACrzQf2A6YlNZGfRP9l/lqSCy6fTxECAfHADXIvMJBJQnv3zu3CZRR9T
        vmifd+giqU8XwP5S9IRJCauSIg==
X-Google-Smtp-Source: AMsMyM4ehnZmNiTd8M9kwI1JyvgcnqVezhHqNngddOT+3Cnvi74FuSbkfF80x+ps7n5eJkMO3Fzz3g==
X-Received: by 2002:a05:620a:2903:b0:6cf:920f:435c with SMTP id m3-20020a05620a290300b006cf920f435cmr21743122qkp.741.1665618897718;
        Wed, 12 Oct 2022 16:54:57 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a410400b006eea4b5abcesm2290428qko.89.2022.10.12.16.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 16:54:56 -0700 (PDT)
Date:   Wed, 12 Oct 2022 23:54:56 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
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
Subject: Re: [RFC PATCH 01/11] locking/ww_mutex: Remove wakeups from under
 mutex::wait_lock
Message-ID: <Y0dT0D3d/07mNHAK@google.com>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-2-connoro@google.com>
 <73859883-78c4-1080-7846-e8d644ad397a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73859883-78c4-1080-7846-e8d644ad397a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 12:01:13PM -0400, Waiman Long wrote:
> On 10/3/22 17:44, Connor O'Brien wrote:
> > diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> > index 56f139201f24..dfc174cd96c6 100644
> > --- a/kernel/locking/ww_mutex.h
> > +++ b/kernel/locking/ww_mutex.h
> > @@ -161,6 +161,11 @@ static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
> >   #endif /* WW_RT */
> > +void ww_ctx_wake(struct ww_acquire_ctx *ww_ctx)
> > +{
> > +	wake_up_q(&ww_ctx->wake_q);
> > +}
> > +
> >   /*
> >    * Wait-Die:
> >    *   The newer transactions are killed when:
> > @@ -284,7 +289,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
> >   #ifndef WW_RT
> >   		debug_mutex_wake_waiter(lock, waiter);
> >   #endif
> > -		wake_up_process(waiter->task);
> > +		wake_q_add(&ww_ctx->wake_q, waiter->task);
> >   	}
> >   	return true;
> > @@ -331,7 +336,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
> >   		 * wakeup pending to re-read the wounded state.
> >   		 */
> >   		if (owner != current)
> > -			wake_up_process(owner);
> > +			wake_q_add(&ww_ctx->wake_q, owner);
> >   		return true;
> >   	}
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ee28253c9ac0..617e737392be 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1013,6 +1013,13 @@ void wake_up_q(struct wake_q_head *head)
> >   		wake_up_process(task);
> >   		put_task_struct(task);
> >   	}
> > +	/*
> > +	 * XXX connoro: seems this is needed now that ww_ctx_wake() passes in a
> > +	 * wake_q_head that is embedded in struct ww_acquire_ctx rather than
> > +	 * declared locally.
> > +	 */
> > +	head->first = node;
> > +	head->lastp = &head->first;
> >   }
> 
> You shouldn't do wake_q_init() here in wake_up_q(). Instead, you should do
> it in ww_ctx_wake() right after the wake_up_q() call.
> :

Exactly, it is also mentioned in the wake_q.h header:

 * The DEFINE_WAKE_Q macro declares and initializes the list head.
 * wake_up_q() does NOT reinitialize the list; it's expected to be
 * called near the end of a function. Otherwise, the list can be
 * re-initialized for later re-use by wake_q_init().
 *

Thanks.

