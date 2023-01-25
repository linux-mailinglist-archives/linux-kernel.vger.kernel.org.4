Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209D367BA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbjAYTJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbjAYTJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:09:14 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 64B785CE6D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:09:00 -0800 (PST)
Received: (qmail 222384 invoked by uid 1000); 25 Jan 2023 14:08:59 -0500
Date:   Wed, 25 Jan 2023 14:08:59 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
Message-ID: <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
References: <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 09:18:32AM -0800, Paul E. McKenney wrote:
> ------------------------------------------------------------------------
> 
> C C-srcu-observed-4
> 
> (*
>  * Result: Sometimes
>  *
>  * The Linux-kernel implementation is suspected to forbid this.
>  *)
> 
> {}
> 
> P0(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
> 
> 	r1 = srcu_read_lock(s);
> 	WRITE_ONCE(*y, 2);
> 	WRITE_ONCE(*x, 1);
> 	srcu_read_unlock(s, r1);
> }
> 
> P1(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
> 
> 	WRITE_ONCE(*y, 1);
> 	synchronize_srcu(s);
> 	WRITE_ONCE(*z, 2);
> }
> 
> P2(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	WRITE_ONCE(*z, 1);
> 	smp_store_release(x, 2);
> }
> 
> exists (x=1 /\ y=1 /\ z=1)
> 
> ------------------------------------------------------------------------
> 
> We get the following from herd7:
> 
> ------------------------------------------------------------------------
> 
> $ herd7 -conf linux-kernel.cfg C-srcu-observed-4.litmus
> Test C-srcu-observed-4 Allowed
> States 8
> x=1; y=1; z=1;
> x=1; y=1; z=2;
> x=1; y=2; z=1;
> x=1; y=2; z=2;
> x=2; y=1; z=1;
> x=2; y=1; z=2;
> x=2; y=2; z=1;
> x=2; y=2; z=2;
> Ok
> Witnesses
> Positive: 1 Negative: 7
> Condition exists (x=1 /\ y=1 /\ z=1)
> Observation C-srcu-observed-4 Sometimes 1 7
> Time C-srcu-observed-4 0.02
> Hash=8b6020369b73ac19070864a9db00bbf8
> 
> ------------------------------------------------------------------------
> 
> This does not seem to me to be consistent with your "The RCU guarantee
> about writes in a read-side critical section becoming visible to all
> CPUs before a later grace period ends".

Let's see.  That guarantee requires only that x=1 and y=2 become visible 
to P1 and P2 before the grace period ends.  And since synchronize_srcu 
is a strong fence, y=1 must become visible to P0 and P2 before the grace 
period ends.  Presumably after y=2 does, because it overwrites y=2.  
Okay so far.

Now at some point P2 executes x=2.  If this were to happen after the 
grace period ended, it would overwrite x=1.  Therefore it must happen 
before the grace period ends, and therefore P2 must also write z=1 
before the grace period ends.

So we have P2 writing z=1 before P1 writes z=2.  But this doesn't mean 
z=2 has to overwrite z=1!  (You had a diagram illustrating this point in 
one of your own slides for a talk about the LKMM.)  Overwriting is 
required only when the earlier write becomes visible to the later 
write's CPU before the later write occurs, and nothing in this test 
forces z=2 to propagate to P1 before the z=1 write executes.

So the litmus test's outcome can happen without violating my guarantee.

> So what am I missing here?

Can't tell.  I'm not sure why you think the litmus test isn't consistent 
with the guarantee.

> Again, I am OK with LKMM allowing C-srcu-observed-4.litmus, as long as
> the actual Linux-kernel implementation forbids it.

Why do you want the implementation to forbid it?  The pattern of the 
litmus test resembles 3+3W, and you don't care whether the kernel allows 
that pattern.  Do you?

Alan
