Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7B6DD7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDKKZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDKKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:25:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38F358D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PLqOn2HyQHOs+iLBUKsTfwgjognJqNpL2tZOST+MURo=; b=Ncvpfd0tUU+PoID3akHaVYyshB
        D84zQjyy0sa2DsB8+wThltqXk+WpzVzxju79viaoUZdq7GDfQ77SEvuuSNd8Qj42lH0Yksv86LxB1
        qpfAUoB4MIcQRk16gxY+cq5i6Gaxe5gVw9knmUlWAEStO7QZFqJmcZOMS0Za2Uk/+Ic+dHhziY9UD
        iOSKA5yha/zzIk/ny+zc5CR/GnB4hEoO18zI9dOwuIWa1LSvvi/qQsAI2MTBLFXN+XZS44z/ylu1u
        5SDctFpjIOLkpGiDcNhDoH5Bo3G/oZyq5dyN/m+LXWuRsc5yeCAG8ViyZz5S64sYkG6/DfbwfLdv5
        vWYnpnDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmBBu-00DJru-0P;
        Tue, 11 Apr 2023 10:25:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0B61300102;
        Tue, 11 Apr 2023 12:25:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B49C32CB52A23; Tue, 11 Apr 2023 12:25:32 +0200 (CEST)
Date:   Tue, 11 Apr 2023 12:25:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
Subject: Re: [RFC PATCH v3] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230411102532.GA580235@hirez.programming.kicks-ass.net>
References: <20230405162635.225245-1-mathieu.desnoyers@efficios.com>
 <386a6e32-a746-9eb1-d5ae-e5bedaa8fc75@efficios.com>
 <20230406095122.GF386572@hirez.programming.kicks-ass.net>
 <fdaa7242-4ddd-fbe2-bc0e-6c62054dbde8@efficios.com>
 <3b4684ea-5c0d-376b-19cf-195684ec4e0e@efficios.com>
 <20230411093705.GB578657@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411093705.GB578657@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 11:37:05AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 07, 2023 at 09:14:36PM -0400, Mathieu Desnoyers wrote:
> 
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
> 
> What about the user->user case where next->mm == prev->mm ? There
> sys_membarrier() relies on finish_task_switch()'s mmdrop(), but we
> can't.

Ah, I suppose that's either a N->N or Y->Y transition and we don't care.

Not the clearest comment though.
