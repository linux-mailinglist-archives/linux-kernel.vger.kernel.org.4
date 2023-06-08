Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5B72892D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjFHUG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjFHUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:06:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043752733;
        Thu,  8 Jun 2023 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aBWb6+eQE9WxD6vRX+GhZGTfIUuI+dRuiyxZYMV/GPQ=; b=h7PislLIipTcXw8+pW6DDmylyF
        kc2wuHtQDmcx1H5nVi+vDHDKy1hhMb5lXFVmdCurjG+Buu2562Z4LFsGy2WuvGpTyyCXjOLZUJpiN
        5MISDg9Jwu9E+MB8M3nwERQhlj5MY/KlTUv2eAV4eIu1pgsM2YMBj7Xg4kvQNzlJ8FRasIHTe5Jo1
        wbBhtXnTQBkaOA3zGHF6gHz20VkgF8X8msfu+S0/8dA7KafLcKCcmvr2Vm5F5r+TsNYaNPvGxSCgi
        Pn/x/Q6nv2k3jK5jaume4nu79eGBBxBiSAinVZk1YcbwnNGhx0lbSZnqus9fi7bzvoI4CV6p61ELM
        /EGI3GnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7Ltl-00Fo55-TI; Thu, 08 Jun 2023 20:06:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2A3830026A;
        Thu,  8 Jun 2023 22:06:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFC28245A9E28; Thu,  8 Jun 2023 22:06:18 +0200 (CEST)
Date:   Thu, 8 Jun 2023 22:06:18 +0200
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
Message-ID: <20230608200618.GA1020752@hirez.programming.kicks-ass.net>
References: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
 <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 08:45:53AM -0700, Linus Torvalds wrote:

> > DEFINE_CLASS(kfree, void *, kfree(THIS), p, void *p)
> >
> >         smart_ptr(kfree, mem) = kzalloc_node(...);
> >         if (!mem)
> >                 return -ENOMEM;
> 
> No, the above is broken, and would result in us using "void *" in
> situations where we really *really* don't want that.
> 
> For automatic freeing, you want something that can handle different
> types properly, and without having to constantly declare the types
> somewhere else before use.

Ah, I see what you did with the no_free_ptr(), that avoids having to
have two pointers around, nice!

> So for convenient automatic pointer freeing, you want an interface
> much more akin to
> 
>         struct whatever *ptr __automatic_kfree = kmalloc(...);
> 
> which is much more legible, doesn't have any type mis-use issues, and
> is also just trivially dealt with by a
> 
>   static inline void automatic_kfree_wrapper(void *pp)
>   { void *p = *(void **)pp; if (p) kfree(p); }
>   #define __automatic_kfree \
>         __attribute__((__cleanup__(automatic_kfree_wrapper)))
>   #define no_free_ptr(p) \
>         ({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
> 
> which I just tested generates the sane code even for the "set the ptr
> to NULL and return success" case.
> 
> The above allows you to trivially do things like
> 
>         struct whatever *p __automatic_kfree = kmalloc(..);
> 
>         if (!do_something(p))
>                 return -ENOENT;
> 
>         return no_free_ptr(p);
> 
> and it JustWorks(tm).

OK, something like so then?


#define DEFINE_FREE(name, type, free) \
	static inline __free_##name(type *p) { type _P = *p; free; }

#define __free(name)	__cleanup(__free_##name)

#define no_free_ptr(p) \
	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })


DEFINE_FREE(kfree, void *, if (_P) kfree(_P));

	struct obj *p __free(kfree) = kmalloc(...);

	if (!do_something(p))
		return -ENOENT;

	return no_free_ptr(p);




DEFINE_CLASS(find_get_context, struct perf_event_context *,
	     if (!IS_ERR_OR_NULL(_C)) put_ctx(_C),
	     find_get_context(task, event), struct task_struct *task, struct perf_event *event)

DEFINE_FREE(free_event, struct perf_event *,
	    if (!IS_ERR_OR_NULL(_P)) free_event(_P));


	struct perf_event *event __free(free_event) = perf_event_alloc(...)
	if (IS_ERR(event))
		return event;

	class(find_get_context, ctx)(task, event);
	if (IS_ERR(ctx))
		return (void*)ctx;

	if (!task && !container_of(ctx, struct perf_cpu_context, ctx)->online)
		return -ENODEV;

	...

	event->ctx = get_ctx(ctx);

	return no_free_ptr(event);



works for me, I'll go make it happen.

