Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E267D6A2F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBZMBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:01:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85618D31E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XHiYYdwfQEUwu7ov9yO2jNIXsJdthPxEWLvIRT0xYZQ=; b=blMJl8O9FjN4oYYNnSSrxUhH/2
        AtW5v0vFp8qXXQLu9hFX44m7spMsfT/mmo/ATWE/3aW5CqGUlc0d5cYUqHPhvJ4QcqFR/gawEaQ5v
        CUoaNLpFvmF6O7sSYpB2t1lE43IRz0CXrq6ShKCIJpyfa/1fFp6ImdiYaCMGeqgS3a/IHwJFhnass
        dhDWbWqsFmKkcndrhD6q/l4cTP7aqWS/fr8awUtBnvtj+Pc0C+F2lkhgZBesyMCegH44T8ObfS6XN
        BEYUJlxwVJnTXS/85U1jZ3SUr1bXoWz0ZHesxkhJLfdnJQvDYsldIL+tJHzVKIJO6QFUyUpz46Smt
        6vGcIW9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWFiI-00GrZJ-Q1; Sun, 26 Feb 2023 12:01:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBC4F300612;
        Sun, 26 Feb 2023 13:01:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD0AF203E17C9; Sun, 26 Feb 2023 13:01:10 +0100 (CET)
Date:   Sun, 26 Feb 2023 13:01:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     longman@redhat.com, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] locking/rwsem: Unify wait loop
Message-ID: <Y/tKBn4arzdh8MXV@hirez.programming.kicks-ass.net>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.608133045@infradead.org>
 <Y/e/I1aqDAjoq2Rs@boqun-archlinux>
 <Y/gUAdaFf20PDUkO@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/gUAdaFf20PDUkO@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 05:33:53PM -0800, Boqun Feng wrote:
> On Thu, Feb 23, 2023 at 11:31:47AM -0800, Boqun Feng wrote:
> [..]
> > > +#define waiter_type(_waiter, _r, _w)	\
> > > +	((_waiter)->type == RWSEM_WAITING_FOR_READ ? (_r) : (_w))
> > > +
> > > +static __always_inline struct rw_semaphore *
> > > +rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter, int state)
> > > +{
> > > +	trace_contention_begin(sem, waiter_type(waiter, LCB_F_READ, LCB_F_WRITE));
> > > +
> > > +	/* wait to be given the lock */
> > > +	for (;;) {
> > > +		set_current_state(state);
> > > +		if (!smp_load_acquire(&waiter->task)) {
> > > +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> > > +			break;
> > > +		}
> > > +		if (signal_pending_state(state, current)) {
> > > +			raw_spin_lock_irq(&sem->wait_lock);
> > 
> > Move the below __set_current_state(TASK_RUNNING)s up here? I think we
> > need the preemption protection when changing the task state here.
> > 
> 
> Nevermind since we have the preemption protection for the whole
> function... but merging two __set_current_state()s into one still looks
> good.

Even if it were not; I still don't understand the concern. Preemption
ignores task state.
