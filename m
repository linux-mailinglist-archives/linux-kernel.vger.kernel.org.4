Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94540674252
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjASTKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjASTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:09:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C059CB98
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:08:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE09B61D59
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37856C433D2;
        Thu, 19 Jan 2023 19:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155273;
        bh=4K8ATPiykEqbx0orM4yhOUMVCu1RqqdR/qxce393rac=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oH8xbdszEZsfZwd0jR2XApauY4+/igyhmFqzxEpbWUskxvttGb/bxgrcksG7SGR28
         JSY1YtEap1IwEdKJ4Ud/5WmTsfWRlSD/uEunKD4mQPXwAT5A1be97Ls8G9WFKkWj3g
         nE6r4/JRWM3bx4gLPknKaqMi0PigdsQeKUhvdJLgi4cQqkXXhoeellZjJoKNSMGwyw
         9e1K9c68QY7/FWYow4jmFkx3Db3oWbfGdHt/kmRRT9KRBFyp9uKm4YVRpWrC/H0K6D
         8J4BUYXRoCXq8WofqaYDGTVMN3YCzPQ44n/50RedU5/qOcLW/b/M/1dRVy9PouIPpD
         qFDMlTeo94LsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D45C25C1A49; Thu, 19 Jan 2023 11:07:52 -0800 (PST)
Date:   Thu, 19 Jan 2023 11:07:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <20230119190752.GA932071@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8dWMyBfz1iiaF8M@rowland.harvard.edu>
 <20230118051704.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gYV81O80BtMvWm@rowland.harvard.edu>
 <20230118174138.GB2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118174138.GB2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:41:38AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 11:03:35AM -0500, Alan Stern wrote:
> > On Tue, Jan 17, 2023 at 09:17:04PM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 17, 2023 at 09:15:15PM -0500, Alan Stern wrote:
> > > > Maybe we don't.  Please test the patch below; I think it will do what 
> > > > you want -- and it doesn't rule out nesting.
> > > 
> > > It works like a champ on manual/kernel/C-srcu*.litmus in the litmus
> > > repository on github, good show and thank you!!!
> > > 
> > > I will make more tests, and am checking this against the rest of the
> > > litmus tests in the repo, but in the meantime would you be willing to
> > > have me add your Signed-off-by?
> > 
> > I'll email a real patch submission in the not-too-distant future, 
> > assuming you don't find any problems with the new code.
> 
> Sounds good!
> 
> The current state is that last night's testing found a difference only
> for C-srcu-nest-5.litmus, in which case your version gives the correct
> answer and mainline is wrong.  There were a couple of broken tests, which
> I fixed and a test involving spin_unlock_wait(), which is at this point
> perma-broken due to the Linux kernel no longer having such a thing.
> (Other than its re-introduction into i915, but they define it as a
> spin_lock_irq() followed by a spin_unlock_irq(), so why worry?)
> There were also a few timeouts.
> 
> I intend to run the longer tests overnight.

Except that I had an episode of pilot error.  :-/

But here are a couple of litmus tests illustrating how SRCU read-side
critical sections do not flatten/fuse the way that RCU read-side critical
sections do.

Why the difference?  Because such a Linux-kernel SRCU implementation
would require additional storage of the order (T * S), where T is
the number of tasks and S is the number of srcu_struct structures.
That just won't be happening.

Here they are, and both behave the way that I would expect given your
unofficial patch:

https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-7.litmus
https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-8.litmus

Whew!  ;-)

							Thanx, Paul
