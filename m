Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A961D6798D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjAXM7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjAXM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:59:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D010245
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2hHVDuYILU91LBlODczQ+7XGtJToJZo0ZLxE3dBYL9E=; b=JeDAFovgya9Xlp3iLijb398/Hd
        QpGNNWFwXbEGd/dAJ/wBOuG3m2Y6HLnS8l2fSVPZxpDXaas8U+D8x1s8FRPwjU4DK9cckidluivBm
        1w6pjPGTFKTe/zVhjGRYWvJJn79vOJkB9xliaSFtQ9w1e29XIy2nV1tOJpoBfLDeKcpNb+PU37MXB
        4mdcdzGDzJJmv7WkN9MESoSNTUHl7H4u8/s7MkMF2o/p6MrscAhO+TRW4rfIL3kHH5dxu8YLID2Xd
        aSqDX59pVGCC+P4rkK1Crb7bJLQ/i6EqyZ7eOGr88Ozovp3U895THneHMwqASMqJkA2jv5KEvTjai
        xxX/s9CA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKIsw-0053EV-Ol; Tue, 24 Jan 2023 12:58:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF5BC300327;
        Tue, 24 Jan 2023 13:58:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95EF62B6BE287; Tue, 24 Jan 2023 13:58:44 +0100 (CET)
Date:   Tue, 24 Jan 2023 13:58:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v6 5/6] locking/rwsem: Enable direct rwsem lock handoff
Message-ID: <Y8/WBFj4uLz4N2ZH@hirez.programming.kicks-ass.net>
References: <20221118022016.462070-1-longman@redhat.com>
 <20221118022016.462070-6-longman@redhat.com>
 <Y86gzkVHlsOTY8QL@hirez.programming.kicks-ass.net>
 <9fb531a9-0951-f7c0-316d-749d2c59ade8@redhat.com>
 <284b7d75-42cd-ddab-8431-dfbde8bea2b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <284b7d75-42cd-ddab-8431-dfbde8bea2b2@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:07:08PM -0500, Waiman Long wrote:
> On 1/23/23 12:30, Waiman Long wrote:
> > I will update the patch description to highlight the points that I
> > discussed in this email.
> 
> I am planning to update the patch description to as follows:
> 
>     The lock handoff provided in rwsem isn't a true handoff like that in
>     the mutex. Instead, it is more like a quiescent state where optimistic
>     spinning and lock stealing are disabled to make it easier for the first
>     waiter to acquire the lock.
> 
>     For mutex, lock handoff is done at unlock time as the owner value and
>     the handoff bit is in the same lock word and can be updated atomically.
> 
>     That is the not case for rwsem which has a separate count value for
>     locking and an owner value. The only way to update them in a
> quasi-atomic
>     way is to use the wait_lock for synchronization as the handoff bit can
>     only be updated while holding the wait_lock. So for rwsem, the new
>     lock handoff mechanism is done mostly at rwsem_wake() time when the
>     wait_lock has to be acquired anyway to minimize additional overhead.

So for first==reader, sure, and you don't need anything special, since
rwsem_mark_wake() already does the right thing.

But for first==writer, I don't follow; *WHY* do you have to complicate
this path so. The write_slowpath already takes wait_lock for
rwsem_try_write_lock() and that already knows about handoff.

>     It is also likely that the active lock in this case may be a transient
>     RWSEM_READER_BIAS that will be removed soon. So we have a secondary
>     handoff done at reader slow path to handle this particular case.

Only because you made it so damn complicated. If instead you rely on the
wait_lock in write_slowpath you can keep it all in once place AFAICT.

>     For reader-owned rwsem, the owner value other than the
> RWSEM_READER_OWNED
>     bit is mostly for debugging purpose only. So it is not safe to use
>     the owner value to confirm a handoff to a reader has happened. On the

What ?!? Where do we care about the owner value? There's
RWSEM_FLAG_HANDOFF which lives in sem->count and there's
waiter->handoff_set. Nowhere do we care about sem->owner in this.

>     other hand, we can do that when handing off to a writer. However, it
>     is simpler to use the same mechanism to notify a handoff has happened
>     for both readers and writers. So a new HANDOFF_GRANTED state is added

I really can't follow whatever logic jump here.

>     to enum rwsem_handoff_state to signify that. This new value will be
>     written to the handoff_state value of the first waiter.
> 
>     With true lock handoff, there is no need to do a NULL owner spinning
>     anymore as wakeup will be performed if handoff is successful. So it
>     is likely that the first waiter won't actually go to sleep even when
>     schedule() is called in this case.

So this spinning, this is purely for writer->write handoff (which is
exceedingly rare since it is readers that set handoff), right?

Why is that so important?

Also, why can't we add something like

	owner = rwsem_owner_flags(sem, &flags);
	if (owner && !(flags & RWSEM_READER_OWNED))
		atomic_long_cond_read_relaxed(&sem->counter, !(VAL & RWSEM_WRITER_LOCKED))

to the start of that? If it's really needed.
