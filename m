Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD415BA125
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIOTOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIOTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B338B7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B43162606
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9928AC433C1;
        Thu, 15 Sep 2022 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663269270;
        bh=WBaqoHDdcpouRpoCaSc0AG1+mQ7IZwfb6q0ZwdI4vUs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IRITagIraYaUMxE8qCEcTmpgycz6kbftTksamGg+h6luZn2z62LAGTpuoCz617P8Z
         /ahkNdbjKI8+fhh7QtWcz9EolnkrHt3E0HT4baEn/EPeEWIu9JHM+COuysdr/t3n4i
         8sJ6DscGc6CiywAtcMx+6Ujplc95CNoqx8iWbC2nQzbMfJhuyjGATT8BsRUngLWgfK
         P54mPrNVq+RqFOadhk6Pvt10F0nTi18rcmI1pzrlY80HPSezSQlXxH1sWmZgj9NMSJ
         gcSoxuX1vpCqvhHMUvVF4Jai0/NtPuW14qikO/qZkVquhpnrbZvJUtgoauLg5X5KIg
         2Mzo6cwOh+lBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DCEFC5C0514; Thu, 15 Sep 2022 12:14:27 -0700 (PDT)
Date:   Thu, 15 Sep 2022 12:14:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:50:44PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 15, 2022 at 09:06:00AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 15, 2022 at 10:39:12AM +0200, Peter Zijlstra wrote:
> > > Hi,
> > > 
> > > After watching Joel's talk about RCU and idle ticks I was wondering
> > > about why RCU doesn't have NOHZ hooks -- that is regular NOHZ, not the
> > > NOHZ_FULL stuff.
> > 
> > It actually does, but they have recently moved into the context-tracking
> > code, courtesy of Frederic's recent patch series.
> 
> afair that's idle and that is not nohz.

For nohz_full CPUs, it does both.

> > > These deep idle states are only feasible during NOHZ idle, and the NOHZ
> > > path is already relatively expensive (which is offset by then mostly
> > > staying idle for a long while).
> > > 
> > > Specifically my thinking was that when a CPU goes NOHZ it can splice
> > > it's callback list onto a global list (cmpxchg), and then the
> > > jiffy-updater CPU can look at and consume this global list (xchg).
> > > 
> > > Before you say... but globals suck (they do), NOHZ already has a fair
> > > amount of global state, and as said before, it's offset by the CPU then
> > > staying idle for a fair while. If there is heavy contention on the NOHZ
> > > data, the idle governor is doing a bad job by selecting deep idle states
> > > whilst we're not actually idle for long.
> > > 
> > > The above would remove the reason for RCU to inhibit NOHZ.
> > > 
> > > 
> > > Additionally; when the very last CPU goes idle (I think we know this
> > > somewhere, but I can't reaily remember where) we can insta-advance the
> > > QS machinery and run the callbacks before going (NOHZ) idle.
> > > 
> > > 
> > > Is there a reason this couldn't work? To me this seems like a much
> > > simpler solution than the whole rcu-cb thing.
> > 
> > To restate Joel's reply a bit...
> > 
> > Maybe.
> > 
> > Except that we need rcu_nocbs anyway for low latency and HPC applications.
> > Given that we have it, and given that it totally eliminates RCU-induced
> > idle ticks, how would it help to add cmpxchg-based global offloading?
> 
> Because that nocb stuff isn't default enabled?

Last I checked, both RHEL and Fedora were built with CONFIG_RCU_NOCB_CPU=y.
And I checked Fedora just now.

Or am I missing your point?

							Thanx, Paul
