Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCCB724ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbjFFSIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbjFFSIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:08:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3B10F8;
        Tue,  6 Jun 2023 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OrkYgbRcR8dMZ/9FqFYNlN0/B5YWJQDyiL7vTaDE328=; b=vUmMuu9PmqNqTlLjlSfOr+MRnv
        YOVOro3cFUJRZZ6vxULcsPAhAG2+rD86+ar3HpA/xEz9Ldz9rA6INwGm3tWYMgXJMmVyq+iYl9mVj
        heGQCpsAk4DI2qyWcuzaw1923giSGT1p0rlwfZrPQfkWwAheXNbLsRnsnwuFHM8mt+pT8AmHBuUWL
        aWlTFxHpHoWEnbONi3+FlKC1ECUE4wkDfbGzPXRyygu2kQpbijMN2NiJAGA1aXtTxzMHUgXlaqNKc
        Bg+jAeNPHFEFZSZhnrv8eldrtJGXR33HQSBUGOc6vhTHqU2DIJkUl8JgNXPJ1Jxt6SrMapDXJbQSR
        /KLx4xAQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6b6I-00DOYP-2y; Tue, 06 Jun 2023 18:08:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B0B9300129;
        Tue,  6 Jun 2023 20:08:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A5AB2019EC9F; Tue,  6 Jun 2023 20:08:06 +0200 (CEST)
Date:   Tue, 6 Jun 2023 20:08:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <20230606180806.GA942082@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 07:50:47AM -0700, Linus Torvalds wrote:
> I feel like you seem entirely too fixated on locking.

It's what I started out with... but it's certainly not everything.

The thing I have removes pretty much all the error gotos from
sched/core.c and events/core.c and while locking is ofcourse a fair
amount of that there's significant non-locking usage.

>  (c) think that generally are not "nested" (you release the resources
> you've allocated, but you don't "nest" the allocations - they are just
> serial.
> 
>  (d) think that the syntax could be pretty nasty, because the cleanup
> is not just a trivial fixed "unlock" function

So I'm not sure you've seen the actual convertions I've done, but yes,
there's lots of those.

I've just used the guard naming because locks is what I started out
with.

+	ptr_guard(kfree, alloc) = kzalloc(event->read_size, GFP_KERNEL);
+	if (!alloc)
 		return -ENOMEM;


 	event = perf_event_alloc(&attr, cpu, task, group_leader, NULL,
 				 NULL, NULL, cgroup_fd);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
+	ptr_guard(free_event, event_guard) = event;


+	ptr_guard(put_task, p) = find_get_task(pid);
+	if (!p)
+		return -ESRCH;


So it does all that... you just hate the naming -- surely we can fix
that.


Would it all be less offensive if I did: s/guard/cleanup/ on the whole
thing? Then we'd have things like:


DEFINE_PTR_CLEANUP(put_task, struct task_struct *,
		   if (_C) put_task_struct(_C))

	ptr_cleanup(put_task, p) = find_get_task(pid);
	if (!p)
		return -ESRCH;


DEFINE_PTR_CLEANUP(free_event, struct perf_event *,
		   if (!IS_ERR_OR_NULL(_C)) free_event(_C))

	ptr_cleanup(free_event, event) = perf_event_alloc(...);
	if (IS_ERR(event))
		return PTR_ERR(event);


DEFINE_PTR_CLEANUP(kfree, void *, kfree(_C))

	ptr_cleanup(kfree, foo) = kzalloc(...);
	if (!foo)
		return -ENOMEM;


But do we then continue with:

DEFINE_CLEANUP(mutex, struct mutex *, mutex_lock(_C), mutex_unlock(_C))

	cleanup(mutex, &my_mutex);


	scoped_cleanup (mutex, &my_mutex) {
		...
	}

etc..? or do we keep guard() there, but based internally on
ptr_cleanup() with the cleanup_## naming.
