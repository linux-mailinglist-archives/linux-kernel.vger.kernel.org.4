Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5165F519
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjAEUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjAEUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:19:04 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2BDFB2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:19:03 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id y8so2226739qvn.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 12:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mUM4M2MvjRiQSPysH3ZckVnT6GDdl+gZRZivm8ermI=;
        b=qyVNOhiXVlaouGiq6hKclBzIXX6T4t1eHtrr5dO5KtBq/yhz8eXGZtmMSj9MOEBtOO
         tWH9SRGdIIy7XVLLsnkzKw/zQ04XSB08ghLf1STvhukidwq1Vi1UXzTVecBEr8dVan20
         MLK7Wxyu/0caFxUtg+aI06cO0BZoPIeMWzBxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mUM4M2MvjRiQSPysH3ZckVnT6GDdl+gZRZivm8ermI=;
        b=KBoXv2UF8DlHWalWleqdx8q+JKAQw15nirctZzgNDut1KycgFKAj9dpUjjDSssYjr9
         MELFEAxNBE2zuokhWr+5X8FOkWTKzvtGDVgq5CLRx9RkMmq2MZIjRydVqGuy8NSclbG7
         NZEdeFfGNaj1IaO68FyWGhHrLTtlmCgo6AqMFGXtNqvM0y4rVVF80q5lTSGIaAEHDqK3
         0QfPfALZCw83Rf3qhZtG13MeGNZl78vRzWyaVq64GeVkpaieFxX9pPNsU5Sw3vGRowyy
         0mpOnlwIdNHWTT45gToW36lwgOcI0ay+awLObnVA39pGM7yhbX4rPDD1GPV4WeeMWZgM
         mueQ==
X-Gm-Message-State: AFqh2krhJIm+zGjj9N7yc0Ok248CtJsKGBmmfh4WrP4RIWkxjX8Po3aN
        AT85T5EuVkQ/h0dVgjP3xR7Dew==
X-Google-Smtp-Source: AMrXdXtDdhwVqdBeQxhq0aQN5EmKjVBS9/e8wSDm5WeDycl6e42PeM8XwrSTkPuq1AH6gl7yyRIyDg==
X-Received: by 2002:a05:6214:1543:b0:524:91d7:5729 with SMTP id t3-20020a056214154300b0052491d75729mr54979346qvw.20.1672949942178;
        Thu, 05 Jan 2023 12:19:02 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006fca1691425sm10880053qkp.63.2023.01.05.12.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 12:19:00 -0800 (PST)
Date:   Thu, 5 Jan 2023 20:19:00 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH RFC 3/3] locktorture: Make the rt_boost factor a tunable
Message-ID: <Y7cwtPBfu4o8vr3X@google.com>
References: <20221123012104.3317665-1-joel@joelfernandes.org>
 <20221123012104.3317665-4-joel@joelfernandes.org>
 <Y6KLd0X0aJxxyNLJ@chenyu5-mobl1>
 <20230105182718.GG4028633@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105182718.GG4028633@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:27:18AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 21, 2022 at 12:28:39PM +0800, Chen Yu wrote:
> > On 2022-11-23 at 01:21:04 +0000, Joel Fernandes (Google) wrote:
> > > The rt boosting in locktorture has a factor variable large enough that
> > > boosting only happens once every minute or so. Add a tunable to educe
> > > the factor so that boosting happens more often, to test paths and arrive
> > > at failure modes earlier. With this change, I can set the factor to
> > > like 50 and have the boosting happens every 10 seconds or so.
> > > 
> > > Tested with boot parameters:
> > > locktorture.torture_type=mutex_lock
> > > locktorture.onoff_interval=1
> > > locktorture.nwriters_stress=8
> > > locktorture.stutter=0
> > > locktorture.rt_boost=1
> > > locktorture.rt_boost_factor=50
> > > locktorture.nlocks=3
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/locking/locktorture.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > > index 5a388ac96a9b..e4529c2166e9 100644
> > > --- a/kernel/locking/locktorture.c
> > > +++ b/kernel/locking/locktorture.c
> > > @@ -47,6 +47,7 @@ torture_param(int, stat_interval, 60,
> > >  	     "Number of seconds between stats printk()s");
> > >  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> > >  torture_param(int, rt_boost, 0, "Perform an rt-boost from the writer, always 1 for rtmutex_lock");
> > > +torture_param(int, rt_boost_factor, 50000, "A factor determining how often rt-boost happens");
> > >  torture_param(int, verbose, 1,
> > >  	     "Enable verbose debugging printk()s");
> > >  torture_param(int, nlocks, 1,
> > > @@ -132,15 +133,15 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
> > >  
> > >  static void torture_rt_boost(struct torture_random_state *trsp)
> > >  {
> > > -	const unsigned int factor = 50000; /* yes, quite arbitrary */
> > > +	const unsigned int factor = rt_boost_factor; /* yes, quite arbitrary */
> > >  
> > >  	if (!rt_boost)
> > >  		return;
> > >  
> > >  	if (!rt_task(current)) {
> > >  		/*
> > > -		 * Boost priority once every ~50k operations. When the
> > > -		 * task tries to take the lock, the rtmutex it will account
> > > +		 * Boost priority once every rt_boost_factor operations. When
> > > +		 * the task tries to take the lock, the rtmutex it will account
> > >  		 * for the new priority, and do any corresponding pi-dance.
> > >  		 */
> > >  		if (trsp && !(torture_random(trsp) %
> > > @@ -150,8 +151,9 @@ static void torture_rt_boost(struct torture_random_state *trsp)
> > >  			return;
> > >  	} else {
> > >  		/*
> > > -		 * The task will remain boosted for another ~500k operations,
> > > -		 * then restored back to its original prio, and so forth.
> > > +		 * The task will remain boosted for another 10*rt_boost_factor
> > Maybe I understand incorrectly, the code is
> > cxt.nrealwriters_stress * factor * 2, should it be 2 rather than 10?
> 
> It looks that way to me, but I might be missing something.  Joel?
> > May I know where the 10 comes from?

The comment in existing code was 500k ops.

Yes, Chen is right, the comment can be improved to mention the actual
equation. I was just going by the initial comment of ~500K ops. Since factor
now defaults to 50k, this translates to 500k (10 times the factor) ops which
it does for a 4-5 CPU system.

But I am Ok with the comment changing to what Chen suggested though!

thanks,

 - Joel

