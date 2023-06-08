Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A2727A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjFHIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFHIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:53:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8258BE61;
        Thu,  8 Jun 2023 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LxOtjsoq+mmbavOdPABARTtP3nNtxRZ1DpJ3zEKmtXY=; b=lCFjyFQmWRxX5KTgebj4oRm8ou
        bU4X60hPOBfLKHxIsD+8CmT4xLBBLmOQCLHM+jlj0NRj6w09asiHno7slIqVbYom1d59D7RUTpqnl
        UXvD/w3CRnN8suHbFjD6k29fJ+RqCvqM5wllYffMY4L/KdT7NV2x9rRbVi6nBdayGWX4dRfPhTpX+
        tMI63+RBbWCYDfbFwgXyM2lZSo/IyvMnR8nzpL+hqj3Ps17joC6COo6NNSyxgcMDvl9lTU5aau/in
        xAx1xRB70rjZoKRxp/HxDh4H0h1Ne/y6Gc4DGBlzbKRp49nCdvJy5erKTyqhc0Rs1dAisMDw3w6Wh
        2FNCnYGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7BNy-00FHgv-Pw; Thu, 08 Jun 2023 08:52:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9357300274;
        Thu,  8 Jun 2023 10:52:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7998320D7218F; Thu,  8 Jun 2023 10:52:48 +0200 (CEST)
Date:   Thu, 8 Jun 2023 10:52:48 +0200
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
Message-ID: <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607094101.GA964354@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 11:41:01AM +0200, Peter Zijlstra wrote:


> > I'm sure there's something horribly wrong in the above, but my point
> > is that I'd really like this to make naming and conceptual sense.
> 
> Right, I hear ya. So the asymmetric case (iow destructor only) could be
> seen as using the copy-constructor.
> 
> #define DEFINE_CLASS(name, type, exit, init, init_args...)		\
> typedef type class_##name##_t;						\
> static inline void class_##name##_destructor(type *this)		\
> { type THIS = *this; exit; }						\
> static inline type class_##name##_constructor(init_args)		\
> { type THIS = init; return THIS; }
> 
> #define __INSTANTIATE_VAR(name, var)					\
> 	class_##name##_t var __cleanup(class_##name##_destructor)
> 
> #define INSTANTIATE_CLASS(name, var)					\
> 	__INSTANTIATE_VAR(name, var) = class_##name##_constructor
> 
> 
> DEFINE_CLASS(fd, struct fd, fdput(THIS), f, struct fd f)
> 
> 	INSTANTIATE_CLASS(fd, f)(perf_fget_light(fd));
> 
> 
> Alternatively, you be OK with exposing INSTANTIATE_VAR() to easily
> circumvent the default constructor?

Or perhaps use the smart-pointer concept applied to our classes like:

#define smart_ptr(name, var) \
	__INSTANTIATE_VAR(name, var)

To mean a pointer that calls the destructor for class 'name'. I think
the nearest thing C++ has is std::unique_ptr<>.


Then we can write:


DEFINE_CLASS(kfree, void *, kfree(THIS), p, void *p)


	smart_ptr(kfree, mem) = kzalloc_node(...);
	if (!mem)
		return -ENOMEM;

	object = mem;

	// further initiatlize object with error cases etc..

	mem = NULL; // success, we keep it.
	return object;



