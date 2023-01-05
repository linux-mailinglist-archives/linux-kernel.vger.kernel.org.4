Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12965F3A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjAES1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjAES1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:27:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C2564D0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:27:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F379461BB9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53174C433D2;
        Thu,  5 Jan 2023 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672943239;
        bh=X8zK08hDplMZOU9jNyg+F3MZ/14qYeZGvlD1yFz4DyQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ACc1Jt2dlYN3tAmOCPwR7zcsL5VWc1OECpbI+cdHkc9ERiRUdbGhoczy0WX3uLu7n
         BYazAd6MrTPDrcOwHf+QvRGOqO8nnnp4FerjYlEfaYqB4YZBzSxSdqti4ozdUHjw/M
         xX5et0ATPUyA8N8R9RnTK6FjK//nm0oP/EX4vF/Me0WfKV7g0+50DOjVOpz/UxfxUH
         yOrH6pSfP+JwZb80dDrtqsueLxJ6KOAkg56ANftyENK4dVeo7tPu83dFdA84PocTKN
         0EbD9EHxCe0dyitzZSXFeszoxi6AdYDh5hGECBpY0FJXYFAvmWmliN4o6XfaA10lMx
         9oEFr99d2AQpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E7A115C0544; Thu,  5 Jan 2023 10:27:18 -0800 (PST)
Date:   Thu, 5 Jan 2023 10:27:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
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
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH RFC 3/3] locktorture: Make the rt_boost factor a tunable
Message-ID: <20230105182718.GG4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123012104.3317665-1-joel@joelfernandes.org>
 <20221123012104.3317665-4-joel@joelfernandes.org>
 <Y6KLd0X0aJxxyNLJ@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6KLd0X0aJxxyNLJ@chenyu5-mobl1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:28:39PM +0800, Chen Yu wrote:
> On 2022-11-23 at 01:21:04 +0000, Joel Fernandes (Google) wrote:
> > The rt boosting in locktorture has a factor variable large enough that
> > boosting only happens once every minute or so. Add a tunable to educe
> > the factor so that boosting happens more often, to test paths and arrive
> > at failure modes earlier. With this change, I can set the factor to
> > like 50 and have the boosting happens every 10 seconds or so.
> > 
> > Tested with boot parameters:
> > locktorture.torture_type=mutex_lock
> > locktorture.onoff_interval=1
> > locktorture.nwriters_stress=8
> > locktorture.stutter=0
> > locktorture.rt_boost=1
> > locktorture.rt_boost_factor=50
> > locktorture.nlocks=3
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/locking/locktorture.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > index 5a388ac96a9b..e4529c2166e9 100644
> > --- a/kernel/locking/locktorture.c
> > +++ b/kernel/locking/locktorture.c
> > @@ -47,6 +47,7 @@ torture_param(int, stat_interval, 60,
> >  	     "Number of seconds between stats printk()s");
> >  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> >  torture_param(int, rt_boost, 0, "Perform an rt-boost from the writer, always 1 for rtmutex_lock");
> > +torture_param(int, rt_boost_factor, 50000, "A factor determining how often rt-boost happens");
> >  torture_param(int, verbose, 1,
> >  	     "Enable verbose debugging printk()s");
> >  torture_param(int, nlocks, 1,
> > @@ -132,15 +133,15 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
> >  
> >  static void torture_rt_boost(struct torture_random_state *trsp)
> >  {
> > -	const unsigned int factor = 50000; /* yes, quite arbitrary */
> > +	const unsigned int factor = rt_boost_factor; /* yes, quite arbitrary */
> >  
> >  	if (!rt_boost)
> >  		return;
> >  
> >  	if (!rt_task(current)) {
> >  		/*
> > -		 * Boost priority once every ~50k operations. When the
> > -		 * task tries to take the lock, the rtmutex it will account
> > +		 * Boost priority once every rt_boost_factor operations. When
> > +		 * the task tries to take the lock, the rtmutex it will account
> >  		 * for the new priority, and do any corresponding pi-dance.
> >  		 */
> >  		if (trsp && !(torture_random(trsp) %
> > @@ -150,8 +151,9 @@ static void torture_rt_boost(struct torture_random_state *trsp)
> >  			return;
> >  	} else {
> >  		/*
> > -		 * The task will remain boosted for another ~500k operations,
> > -		 * then restored back to its original prio, and so forth.
> > +		 * The task will remain boosted for another 10*rt_boost_factor
> Maybe I understand incorrectly, the code is
> cxt.nrealwriters_stress * factor * 2, should it be 2 rather than 10?

It looks that way to me, but I might be missing something.  Joel?

							Thanx, Paul

> May I know where the 10 comes from?
> 
> thanks,
> Chenyu
