Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B68654127
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiLVMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiLVMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:40:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EA8E15;
        Thu, 22 Dec 2022 04:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6032BB81D11;
        Thu, 22 Dec 2022 12:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C135CC433EF;
        Thu, 22 Dec 2022 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671712813;
        bh=A8z1NSCUeJ0GDD5qSEMg8VBjXL+asOLb0k3hOA+DVns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9DdAio452LSzQ2g8EiTrC8AiQD6o74vWIlB1P/cAxLYb9BdPYcMXO31mwYcHIDuE
         4TVjl8HaK44hgK+ojucmH0VlXkPlWZ5QVRCx5sE6kOVu9eSyCIRDYgnwVL1SRMQXwK
         vU7AzH5Jlggs5JEIst3Vj0wcBNkTinhPdmeH2STzP7POf3KthXksIZtYsvN4Rv7KJm
         X/hntErPycQnSvedDI9JjWA7cbQOhbpOLAB3kqnzc825OPEEPm6eHY3ubOGDnLdyVa
         B9BvjqLObQ2Y9SkO3h10D25hAKnZHNyOSmIv2rH1x1U1ZX/vEtJ7ixR2VNl4MJcgiq
         7m1VpPi4KrQSg==
Date:   Thu, 22 Dec 2022 13:40:10 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221222124010.GC44777@lothringen>
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
 <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
 <20221220225756.GB26563@lothringen>
 <c085be21-b45f-4186-6f41-5082771c79ca@efficios.com>
 <20221221115924.GA34934@lothringen>
 <bb794e83-992e-8181-d9b9-acc68536ce5a@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb794e83-992e-8181-d9b9-acc68536ce5a@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wrote:
> On 2022-12-21 06:59, Frederic Weisbecker wrote:
> > On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
> [...]
> > > 
> > > The memory ordering constraint I am concerned about here is:
> > > 
> > >   * [...] In addition,
> > >   * each CPU having an SRCU read-side critical section that extends beyond
> > >   * the return from synchronize_srcu() is guaranteed to have executed a
> > >   * full memory barrier after the beginning of synchronize_srcu() and before
> > >   * the beginning of that SRCU read-side critical section. [...]
> > > 
> > > So if we have a SRCU read-side critical section that begins after the beginning
> > > of synchronize_srcu, but before its first memory barrier, it would miss the
> > > guarantee that the full memory barrier is issued before the beginning of that
> > > SRCU read-side critical section. IOW, that memory barrier needs to be at the
> > > very beginning of the grace period.
> > 
> > I'm confused, what's wrong with this ?
> > 
> > UPDATER                  READER
> > -------                  ------
> > STORE X = 1              STORE srcu_read_lock++
> > // rcu_seq_snap()        smp_mb()
> > smp_mb()                 READ X
> > // scans
> > READ srcu_read_lock
> 
> What you refer to here is only memory ordering of the store to X and load
> from X wrt loading/increment of srcu_read_lock, which is internal to the
> srcu implementation. If we really want to model the provided high-level
> memory ordering guarantees, we should consider a scenario where SRCU is used
> for its memory ordering properties to synchronize other variables.
> 
> I'm concerned about the following Dekker scenario, where synchronize_srcu()
> and srcu_read_lock/unlock would be used instead of memory barriers:
> 
> Initial state: X = 0, Y = 0
> 
> Thread A                   Thread B
> ---------------------------------------------
> STORE X = 1                STORE Y = 1
> synchronize_srcu()
>                            srcu_read_lock()
>                            r1 = LOAD X
>                            srcu_read_unlock()
> r0 = LOAD Y
> 
> BUG_ON(!r0 && !r1)
> 
> So in the synchronize_srcu implementation, there appears to be two
> major scenarios: either srcu_gp_start_if_needed starts a gp or expedited gp,
> or it uses an already started gp/expedited gp. When snapshotting with
> rcu_seq_snap, the fact that the memory barrier is after the ssp->srcu_gp_seq
> load means that it does not order prior memory accesses before that load.
> This sequence value is then used to identify which gp_seq to wait for when
> piggy-backing on another already-started gp. I worry about reordering
> between STORE X = 1 and load of ssp->srcu_gp_seq, which is then used to
> piggy-back on an already-started gp.
> 
> I suspect that the implicit barrier in srcu_read_lock() invoked at the
> beginning of srcu_gp_start_if_needed() is really the barrier that makes
> all this behave as expected. But without documentation it's rather hard to
> follow.

Oh ok I see now. It might be working that way by accident or on forgotten
purpose. In any case, we really want to add a comment above that
__srcu_read_lock_nmisafe() call.

