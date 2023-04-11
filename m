Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE26DDA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDKLxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDKLxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:53:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C33E68
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lUBqCEIfOxRVsu3MN5Mz6wJEIZM5gTn52LRqs/6YO5M=; b=AhTtQzD3DdPrtkV9sK0x3VKmU/
        8ea0YLvNDqWLrVIZmBURDUYUIBJz7Gj6Puc252kNsZhx8ML1a6zR9EQ+vKJn8VDU1XcaYnFimB9mC
        lRZiIKDyAOSD68Zps+vOK1wEEVGJuIIvnYQGo9C2A2WvCKxA5hEciAQiLVeY7tgxDQhfxFxWDSpxb
        8xlmRYh6BUsb4QkF+GpfEK9qhUO/KhkmcjZlagA7ZRQOy2/nm1mYzgRlC2NYaJMeTZbjxzFjTXy3Q
        zg+AyLJDZHOiaLDymY9RzYlf7GB5CW1dK3CsnAbwvhLCYtnTFfvtzGfU6o4GRn2TvA4ETAG4WF3P+
        raIa1Avw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmCZ2-005sBY-GV; Tue, 11 Apr 2023 11:53:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CECDA300102;
        Tue, 11 Apr 2023 13:53:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1F6720593938; Tue, 11 Apr 2023 13:53:30 +0200 (CEST)
Date:   Tue, 11 Apr 2023 13:53:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com,
        npiggin@gmail.com
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230411115330.GB580235@hirez.programming.kicks-ass.net>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
 <20230406095122.GF386572@hirez.programming.kicks-ass.net>
 <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
 <3b4684ea-5c0d-376b-19cf-195684ec4e0e@efficios.com>
 <20230411110344.GC576825@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411110344.GC576825@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 01:03:45PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 07, 2023 at 09:14:36PM -0400, Mathieu Desnoyers wrote:


> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index bc0e1cd0d6ac..f3e7dc2cd1cc 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -3354,6 +3354,37 @@ static inline int mm_cid_get(struct mm_struct *mm)
> >  static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
> >  {
> > +	/*
> > +	 * Provide a memory barrier between rq->curr store and load of
> > +	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
> > +	 *
> > +	 * Should be adapted if context_switch() is modified.
> > +	 */
> > +	if (!next->mm) {                                // to kernel
> > +		/*
> > +		 * user -> kernel transition does not guarantee a barrier, but
> > +		 * we can use the fact that it performs an atomic operation in
> > +		 * mmgrab().
> > +		 */
> > +		if (prev->mm)                           // from user
> > +			smp_mb__after_mmgrab();
> > +		/*
> > +		 * kernel -> kernel transition does not change rq->curr->mm
> > +		 * state. It stays NULL.
> > +		 */
> > +	} else {                                        // to user
> > +		/*
> > +		 * kernel -> user transition does not provide a barrier
> > +		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
> > +		 * Provide it here.
> > +		 */
> > +		if (!prev->mm)                          // from kernel
> > +			smp_mb();
> > +		/*
> > +		 * user -> user transition guarantees a memory barrier through
> > +		 * switch_mm().
> > +		 */
> > +	}

The possibly nicer way to write all this is:

	if (!prev->mm != !next->mm)
		smp_mb();

And then clean up the mm{grab,drop)_lazy_tlb() helpers. But we can
always do that later if we indeed end up with all this ...

