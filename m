Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA1727ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjFHJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFHJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE61E61;
        Thu,  8 Jun 2023 02:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BE661737;
        Thu,  8 Jun 2023 09:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEAAC433EF;
        Thu,  8 Jun 2023 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686215049;
        bh=ar2xnge7uTjidn2C7qc0VkqgJuiPo+8zNzrlooQb2Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjFY2bjerz+iWuvvKI54tr50nfB/nObVbtOpfA23SBHApaklkXGdtCDx6ZabiFO9f
         oQS/r34aSdzeIlcwS9rImx35CqwvWqUZ47DACQqVkN7XQFkv6eVVxbjlZQN2aWHbcA
         605IXA+ryjdjFcb5YdGlN/1tHtHFBf2Ah3ba6JFk=
Date:   Thu, 8 Jun 2023 11:04:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        keescook@chromium.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <2023060857-trading-albatross-f46f@gregkh>
References: <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
 <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:52:48AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 07, 2023 at 11:41:01AM +0200, Peter Zijlstra wrote:
> 
> 
> > > I'm sure there's something horribly wrong in the above, but my point
> > > is that I'd really like this to make naming and conceptual sense.
> > 
> > Right, I hear ya. So the asymmetric case (iow destructor only) could be
> > seen as using the copy-constructor.
> > 
> > #define DEFINE_CLASS(name, type, exit, init, init_args...)		\
> > typedef type class_##name##_t;						\
> > static inline void class_##name##_destructor(type *this)		\
> > { type THIS = *this; exit; }						\
> > static inline type class_##name##_constructor(init_args)		\
> > { type THIS = init; return THIS; }
> > 
> > #define __INSTANTIATE_VAR(name, var)					\
> > 	class_##name##_t var __cleanup(class_##name##_destructor)
> > 
> > #define INSTANTIATE_CLASS(name, var)					\
> > 	__INSTANTIATE_VAR(name, var) = class_##name##_constructor
> > 
> > 
> > DEFINE_CLASS(fd, struct fd, fdput(THIS), f, struct fd f)
> > 
> > 	INSTANTIATE_CLASS(fd, f)(perf_fget_light(fd));
> > 
> > 
> > Alternatively, you be OK with exposing INSTANTIATE_VAR() to easily
> > circumvent the default constructor?
> 
> Or perhaps use the smart-pointer concept applied to our classes like:
> 
> #define smart_ptr(name, var) \
> 	__INSTANTIATE_VAR(name, var)
> 
> To mean a pointer that calls the destructor for class 'name'. I think
> the nearest thing C++ has is std::unique_ptr<>.
> 
> 
> Then we can write:
> 
> 
> DEFINE_CLASS(kfree, void *, kfree(THIS), p, void *p)
> 
> 
> 	smart_ptr(kfree, mem) = kzalloc_node(...);
> 	if (!mem)
> 		return -ENOMEM;
> 
> 	object = mem;
> 
> 	// further initiatlize object with error cases etc..
> 
> 	mem = NULL; // success, we keep it.
> 	return object;

I like the idea, as we need a way to say "don't clean this up, it was
passed to somewhere else" for these types of allocations, but have it
"automatically" cleaned up on the error paths.

I have no say in the naming, though I always disliked the idea of a
pointer being "smart" as they are just a dumb memory register :)

thanks,

greg k-h
