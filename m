Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C9267FA98
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 20:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjA1T5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 14:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjA1T5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 14:57:02 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B506922DC9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:57:00 -0800 (PST)
Received: (qmail 348420 invoked by uid 1000); 28 Jan 2023 14:56:59 -0500
Date:   Sat, 28 Jan 2023 14:56:59 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:31:25PM +0100, Jonas Oberhauser wrote:
> Here's a litmus test illustrating the difference, where P1 has a
> backwards-pointing xbstar&int. Currently there's no data race, but with the
> proposed patch there is.
> 
> P0(int *x, int *y)
> {
>     *x = 1;
>     smp_store_release(y, 1);
> }
> 
> P1(int *x, int *y, int *dx, int *dy, spinlock_t *l)
> {
>     spin_lock(l);
>     int r1 = READ_ONCE(*dy);
>     if (r1==1)
>         spin_unlock(l);
> 
>     int r0 = smp_load_acquire(y);
>     if (r0 == 1) {
>         WRITE_ONCE(*dx,1);
>     }
> }
> 
> P2(int *dx, int *dy)
> {
>     WRITE_ONCE(*dy,READ_ONCE(*dx));
> }
> 
> 
> P3(int *x, spinlock_t *l)
> {
>     spin_lock(l);
>     smp_mb__after_unlock_lock();
>     *x = 2;
> }

I don't understand why the current LKMM doesn't say there is a data 
race.  In fact, I don't understand what herd7 is doing with this litmus 
test at all.  Evidently the plain-coherence check rules out x=1 at the 
end, because when I relax that check, x=1 becomes a possible result.  
Furthermore, the graphical output confirms that this execution has a 
ww-incoh edge from Wx=2 to Wx=1.  But there is no ww-vis edge from Wx=1 
to Wx=2!  How can this be possible?  It seems like a bug in herd7.

Furthermore, the execution with x=2 at the end doesn't have either a 
ww-vis or a ww-nonrace edge betwen Wx=1 and Wx=2.  So why isn't there a 
ww-race edge?

> This actually makes me wonder. I thought the reason for the xbstar & int is
> that it ensures that the overall relation, after shuffling around a little
> bit, becomes prop&int ; hb*.

No, that is not the reason for it.  See below.

> Like in case the *x=2 is co-before the *x=1, we get
>   Wx2 ->overwrite Wx1 ->cumul-fence*;rfe  (some event on the same CPU as
> Wx2)  ->fence Wx2
> which is
>   Wx2 -> prop&int some other event ->hb Wx2
> which must be irreflexive.
> 
> However, that's not the case at all, because the fence relation currently
> doesn't actually have to relate events of the same CPU.
> So we get
>   Wx2 ->overwrite Wx1 ->cumul-fence*;rfe  (some event on some other CPU than
> Wx2's) ->(hb*&int);fence Wx2
> i.e.,
>   Wx2 ->prop&ext;hb*;strong-fence Wx2
> 
> which shouldn't provide any ordering in general.
> 
> In fact, replacing the *x=1 and *x=2 with WRITE_ONCEs, (pilot errors
> notwithstanding) both Wx1 ->co Wx2 and Wx2 ->co Wx1 become allowed in the
> current LKMM (in graphs where all other edges are equal).
> 
> Shouldn't this actually *be* a data race? And potentially the same with
> rcu-fence?

I think that herd7 _should_ say there is a data race.

On the other hand, I also think that the operational model says there 
isn't.  This is a case where the formal model fails to match the 
operational model.

The operational model says that if W is a release-store on CPU C and W' 
is another store which propagates to C before W executes, then W' 
propagates to every CPU before W does.  (In other words, releases are 
A-cumulative).  But the formal model enforces this rule only in cases 
the event reading W' on C is po-before W.

In your litmus test, the event reading y=1 on P1 is po-after the 
spin_unlock (which is a release).  Nevertheless, any feasible execution 
requires that P1 must execute Ry=1 before the unlock.  So the 
operational model says that y=1 must propagate to P3 before the unlock 
does, i.e., before P3 executes the spin_lock().  But the formal model 
doesn't require this.

Ideally we would fix this by changing the definition of po-rel to:

	[M] ; (xbstar & int) ; [Release]

(This is closely related to the use of (xbstar & int) in the definition 
of vis that you asked about.)  Unfortunately we can't do this, because 
po-rel has to be defined long before xbstar.

> The other cases of *-pre-bounded seem to work out: they all link stuff via
> xbstar to the instruction that is linked via po-unlock-lock-po ;
> [After-unlock-lock] ; po to the potentially racy access, and
> po-unlock-lock-po;po   is xbstar ; acq-po, which allows closing the gap.

I could not follow your arguments at all; the writing was too confusing.

Alan
