Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE51672D44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjASALy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjASALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:11:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8913E08D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:11:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7495A61ACE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AC4C433EF;
        Thu, 19 Jan 2023 00:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674087107;
        bh=+vKp94IjqzCbXRJhpm9qWbaAwtlskkDfxJvECB2O8Cg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XMPcHDafOjV3lqL10kIOWaonP8nwSJUMQSFkK1BI687PKqamkb1uzQ5HJsNQ3tUmg
         aEtZ2DaMklzQXi3WymD3740MllCOL5SrKsZ+zolOSVxzw5b1E1LjgkAQiguDWSOJGN
         NxXEz12zyqRnOS/Z4dxjDPbA/RwcpEENSRyuZK6KRMg6QmBeUyLfGUYes0+HtjKRUj
         PdlIWEi74SQJqb5PY+qJ6kONGOS+GkmQowJ2+l3Fs80oRnY49WNiBavcaS86uFutpb
         DjmKzgmDVlFsGu8zosxzwv423LFeKc21MvUm7Y02bWuzz4VQnnW6pJHyb5Yl8sS+LW
         9UZbmh8Ss6jqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 768C55C0A1A; Wed, 18 Jan 2023 16:11:47 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:11:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:24:50PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/18/2023 10:12 PM, Paul E. McKenney wrote:
> 
> > The only difference between srcu_read_lock() and srcu_read_unlock()
> > on the one hand and srcu_down_read() and srcu_up_read() on the other
> > is that a matching pair of srcu_read_lock() and srcu_read_unlock()
> > must be running on the same task.  In contrast, srcu_down_read() and
> > srcu_up_read() are not subject to this constraint.
> > 
> > > What I was suggesting below is how to redefine "match" between read_down and
> > > read_up that work more like a cross-thread semaphore.
> > Understood, but what I don't understand is why not simply this:
> > 
> > let srcu-rscs-down = ([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc
> 
> Oh, I had thought that it should be more like a semaphore rather than just a
> cross-cpu mutex.
> 
> Here's an example of how what you are describing would be used:
> 
> P0{
>    idx = srcu_down(&ss);
>    store_release(done,1);
> }
> 
> P1{
>     while (! load_acquire(done));
>     srcu_up(&ss,idx)
> }

Exactly!!!

> What I was thinking of is more something like this:
> 
> P0{
>    idx1 = srcu_down(&ss);
>    srcu_up(&ss,idx1);
> }
> 
> P1{
>     idx2 = srcu_down(&ss);
>     srcu_up(&ss,idx2)
> }

And srcu_read_lock() and srcu_read_unlock() already do this.

> where the big difference to srcu_lock/unlock would be that if P0 and P1
> happened to get the same index -- which you could very well check or
> synchronize on -- that you would be guaranteed that the grace period only
> ends once *all* threads that are using this index have called up. (note that
> I believe that your implementation has this property, and some users may
> come to rely on it if they find out!)

They are permitted and encouraged to rely on the fact that
synchronize_srcu() waits until all pre-existing SRCU read-side critical
sections have completed, which I believe is quite close to what you
are saying.  But if they want to look at the return values from either
srcu_read_lock() or srcu_down_read(), they would be better off using
either get_state_synchronize_srcu() or start_poll_synchronize_srcu().

Huh.  I need to add a NUM_ACTIVE_SRCU_POLL_OLDSTATE, don't I?  I first
need to figure out what its value would be.

> If you want this latter kind of guarantee, then you need to do so something
> along the lines of what Alan or I wrote.
> 
> If all you need is the ability to use the first scenario, without any
> guarantee that if the index happened to be the same (or providing an API
> where you can do the down with a fixed index provided by P0) the grace
> period will extend, then what you propose should be right.
> 
> But from Alan's comments I had misunderstood that that wouldn't be the case.

"What do you need?"  "Well, what can be provided?"  ;-)

							Thanx, Paul
