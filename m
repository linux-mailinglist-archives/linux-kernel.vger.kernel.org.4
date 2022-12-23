Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBB655497
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiLWUwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLWUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:52:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624FA1DDE6;
        Fri, 23 Dec 2022 12:52:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8F83B8213F;
        Fri, 23 Dec 2022 20:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B745C433D2;
        Fri, 23 Dec 2022 20:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671828728;
        bh=atyYE4g8m7IBiKqKXD9cr7leeGD9D/8e94O64jfsnyo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HoIyfMK2ge8/3sSwG7kdchdRa175AALOJxmQ4d4rX2gEE4nwkPfSJfJCUF6OPKBZD
         tvMDM403C9HFgTZrTi/BpftfmZLDHW0fe2FII66q+3bLPLxljVvBko4EkBkdbmaacJ
         qjjyy0Yd/jVLLnCT+1gQnKj+vPzKLs6XIEQKgVna0jXVksjALc9f34QcTG6I2UJZcw
         K2uMa48lAkpRmW3ASGnWKKeb5gCkb0pLUaT4GBipmAmki2sVmkAKfnEMoZrDeNPhTE
         SImRk8kGkXKgoNyQ9R6njpklYGwNiQOcOtCDcjPykmyIobHyMO5kkrtObWb0RuC7Cn
         /Z4XLEW0aSo2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4005A5C0865; Fri, 23 Dec 2022 12:52:08 -0800 (PST)
Date:   Fri, 23 Dec 2022 12:52:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221223205208.GB4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221222185314.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <F492F726-00AA-4FC8-A5E5-BBF006CE946C@joelfernandes.org>
 <20221222194511.GS4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YScrnuSuWx69oJK+-+9Rdncn5kOSw0-SaWwwABix-Tb+A@mail.gmail.com>
 <CAEXW_YR=sx58kKRgvypduejx8jCGyDhMRBmZQNxtH3s0PS4u2g@mail.gmail.com>
 <20221223181514.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ5ZfpFmMcsiyenK9XePz3jLiDYYUMdpuxbyNbnaH2Xhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ5ZfpFmMcsiyenK9XePz3jLiDYYUMdpuxbyNbnaH2Xhg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:10:40PM -0500, Joel Fernandes wrote:
> On Fri, Dec 23, 2022 at 1:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Dec 23, 2022 at 11:12:06AM -0500, Joel Fernandes wrote:
> > > On Thu, Dec 22, 2022 at 11:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > [...]
> > > > > > >>>> On Dec 22, 2022, at 11:43 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > >>>
> > > > > > >>> ﻿On Thu, Dec 22, 2022 at 01:40:10PM +0100, Frederic Weisbecker wrote:
> > > > > > >>>>> On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wrote:
> > > > > > >>>>> On 2022-12-21 06:59, Frederic Weisbecker wrote:
> > > > > > >>>>>>> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
> > > > > > >>>>> [...]
> > > > > > >>>>>>>
> > > > > > >>>>>>> The memory ordering constraint I am concerned about here is:
> > > > > > >>>>>>>
> > > > > > >>>>>>> * [...] In addition,
> > > > > > >>>>>>> * each CPU having an SRCU read-side critical section that extends beyond
> > > > > > >>>>>>> * the return from synchronize_srcu() is guaranteed to have executed a
> > > > > > >>>>>>> * full memory barrier after the beginning of synchronize_srcu() and before
> > > > > > >>>>>>> * the beginning of that SRCU read-side critical section. [...]
> > > > > > >>>>>>>
> > > > > > >>>>>>> So if we have a SRCU read-side critical section that begins after the beginning
> > > > > > >>>>>>> of synchronize_srcu, but before its first memory barrier, it would miss the
> > > > > > >>>>>>> guarantee that the full memory barrier is issued before the beginning of that
> > > > > > >>>>>>> SRCU read-side critical section. IOW, that memory barrier needs to be at the
> > > > > > >>>>>>> very beginning of the grace period.
> > > > > > >>>>>>
> > > > > > >>>>>> I'm confused, what's wrong with this ?
> > > > > > >>>>>>
> > > > > > >>>>>> UPDATER                  READER
> > > > > > >>>>>> -------                  ------
> > > > > > >>>>>> STORE X = 1              STORE srcu_read_lock++
> > > > > > >>>>>> // rcu_seq_snap()        smp_mb()
> > > > > > >>>>>> smp_mb()                 READ X
> > > > > > >>>>>> // scans
> > > > > > >>>>>> READ srcu_read_lock
> > > > > > >>>>>
> > > > > > >>>>> What you refer to here is only memory ordering of the store to X and load
> > > > > > >>>>> from X wrt loading/increment of srcu_read_lock, which is internal to the
> > > > > > >>>>> srcu implementation. If we really want to model the provided high-level
> > > > > > >>>>> memory ordering guarantees, we should consider a scenario where SRCU is used
> > > > > > >>>>> for its memory ordering properties to synchronize other variables.
> > > > > > >>>>>
> > > > > > >>>>> I'm concerned about the following Dekker scenario, where synchronize_srcu()
> > > > > > >>>>> and srcu_read_lock/unlock would be used instead of memory barriers:
> > > > > > >>>>>
> > > > > > >>>>> Initial state: X = 0, Y = 0
> > > > > > >>>>>
> > > > > > >>>>> Thread A                   Thread B
> > > > > > >>>>> ---------------------------------------------
> > > > > > >>>>> STORE X = 1                STORE Y = 1
> > > > > > >>>>> synchronize_srcu()
> > > > > > >>>>>                          srcu_read_lock()
> > > > > > >>>>>                          r1 = LOAD X
> > > > > > >>>>>                          srcu_read_unlock()
> > > > > > >>>>> r0 = LOAD Y
> > > > > > >>>>>
> > > > > > >>>>> BUG_ON(!r0 && !r1)
> > > > > > >>>>>
> > > > > > >>>>> So in the synchronize_srcu implementation, there appears to be two
> > > > > > >>>>> major scenarios: either srcu_gp_start_if_needed starts a gp or expedited gp,
> > > > > > >>>>> or it uses an already started gp/expedited gp. When snapshotting with
> > > > > > >>>>> rcu_seq_snap, the fact that the memory barrier is after the ssp->srcu_gp_seq
> > > > > > >>>>> load means that it does not order prior memory accesses before that load.
> > > > > > >>>>> This sequence value is then used to identify which gp_seq to wait for when
> > > > > > >>>>> piggy-backing on another already-started gp. I worry about reordering
> > > > > > >>>>> between STORE X = 1 and load of ssp->srcu_gp_seq, which is then used to
> > > > > > >>>>> piggy-back on an already-started gp.
> > > > > > >>>>>
> > > > > > >>>>> I suspect that the implicit barrier in srcu_read_lock() invoked at the
> > > > > > >>>>> beginning of srcu_gp_start_if_needed() is really the barrier that makes
> > > > > > >>>>> all this behave as expected. But without documentation it's rather hard to
> > > > > > >>>>> follow.
> > > > > > >>>>
> > > > > > >>>> Oh ok I see now. It might be working that way by accident or on forgotten
> > > > > > >>>> purpose. In any case, we really want to add a comment above that
> > > > > > >>>> __srcu_read_lock_nmisafe() call.
> > > > > > >>>
> > > > > > >>> Another test for the safety (or not) of removing either D or E is
> > > > > > >>> to move that WRITE_ONCE() to follow (or, respectively, precede) the
> > > > > > >>> adjacent scans.
> > > > > > >>
> > > > > > >> Good idea, though I believe the MBs that the above talk about are not the flip ones. They are the ones in synchronize_srcu() beginning and end, that order with respect to grace period start and end.
> > > > > > >>
> > > > > > >> So that (flipping MBs) is unrelated, or did I miss something?
> > > > > > >
> > > > > > > The thought is to manually similate in the source code the maximum
> > > > > > > memory-reference reordering that a maximally hostile compiler and CPU
> > > > > > > would be permitted to carry out.  So yes, given that there are other
> > > > > > > memory barriers before and after, these other memory barriers limit how
> > > > > > > far the flip may be moved in the source code.
> > > > > > >
> > > > > > > Here I am talking about the memory barriers associated with the flip,
> > > > > > > but the same trick can of course be applied to other memory barriers.
> > > > > > > In general, remove a given memory barrier and (in the source code)
> > > > > > > maximally rearrange the memory references that were previously ordered
> > > > > > > by the memory barrier in question.
> > > > > > >
> > > > > > > Again, the presence of other memory barriers will limit the permitted
> > > > > > > maximal source-code rearrangement.
> > > > > >
> > > > > >
> > > > > > Makes sense if the memory barrier is explicit. In this case, the memory barriers are implicit apparently, with a srcu_read_lock() in the beginning of synchronize_rcu() having the implicit / indirect memory barrier. So I am not sure if that can be implemented without breaking SRCU readers.
> > > > >
> > > > > First, are we talking about the same barrier?  I am talking about E.
> >
> > Apologies.  I am a bit fixated on E because it is the one you guys
> > proposed eliminating.  ;-)
> 
> Ah ok, no worries. :-)
> 
> > > > No, in the last part you replied to above, Mathieu and Frederic were
> > > > talking about the need for memory barriers in synchronize_srcu(). That
> > > > has nothing to do with E:
> > > > <quote>
> > > >  I suspect that the implicit barrier in srcu_read_lock() invoked at the
> > > >  beginning of srcu_gp_start_if_needed() is really the barrier that makes
> > > >  all this behave as expected.
> > > > </quote>
> > > >
> > > > We need to order code prior to synchronize_srcu() wrt the start of the
> > > > grace period, so that readers that started after the grace period
> > > > started see those side-effects as they may not be waited on (they are
> > > > too late).
> > >
> > > My thought is this is achieved by the srcu_read_lock() before the
> > > grace period is started, and the start of the grace period (which is
> > > basically the smp_mb() in the first scan).
> > >
> > > So from memory ordering PoV, if synchronize_rcu() spans the GP, and
> > > readers don't span the GP, that means the reader does not span the
> > > synchronize_rcu() which is the GP guarantee.
> > >
> > > But I could be missing something. I will dig more on my side. Thanks.
> >
> > Could you please specifically identify that srcu_read_lock()?
> >
> > Also which version you are looking at.  ;-)
> 
> Should be this one in current -rcu:
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/kernel/rcu/srcutree.c#n1669

That gets me this line of code:

	int ss_state = READ_ONCE(ssp->srcu_size_state);

Which is in srcu_torture_stats_print(), so I am guessing that something
got lost in translation.  ;-)

							Thanx, Paul
