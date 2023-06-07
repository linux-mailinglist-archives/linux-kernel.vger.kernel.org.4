Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAC2725AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbjFGJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjFGJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:41:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414131725;
        Wed,  7 Jun 2023 02:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zL2cDZtI/GqCIw+TppsnvFE7my1T9WpbwcRWd1ZjFG4=; b=tDmSegs/ZdI1YJ+9AHZSG4DMma
        REKA9sIdfScGoMIzAWKPBcB5lQHIFZqvI1a3rcgPkftEnwn1+X97jZUpFtD4Vv4TXcrRtaM/sG/60
        MUvlRRYWuMJp9/AIMdzkr0vmi0IBjw7k5agxe+dlzedv6WgT8SdWtTJiGIfQw/KnONPhkiibxUxaO
        zqAzhwocYkSzgSffwskn3jVgcnt8v7Ups2/O4xGxNOvX/YHNvKjlo8WPV/dgMNX4LdGoxRwPyonS0
        spNca+ZlblDD288I1LZ7YCtMl5vP8X2McDLNUWXSXj4ji8p8fTXbaWs/WfO+U6NL3M0p6dZDZKxyD
        WBsvtOLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6pf6-00E7oT-Mz; Wed, 07 Jun 2023 09:41:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87E28300274;
        Wed,  7 Jun 2023 11:41:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68735243C2A68; Wed,  7 Jun 2023 11:41:01 +0200 (CEST)
Date:   Wed, 7 Jun 2023 11:41:01 +0200
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
Message-ID: <20230607094101.GA964354@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:22:26PM -0700, Linus Torvalds wrote:
> On Tue, Jun 6, 2023 at 11:08 AM Peter Zijlstra <peterz@infradead.org> wrote:>
> > Would it all be less offensive if I did: s/guard/cleanup/ on the whole
> > thing?
> 
> It's more than "guard" for me.
> 
> What is "ptr"? Why? We already know of at least one case where it's
> not a pointer at all, ie 'struct fd'.

(so in my view struct fd is nothing more than a fat pointer)

> So I *really* hate the naming. Absolutely none of it makes sense to
> me. One part is a nonsensical name apparently based on a special-case
> operation, and the other part is a nonsensical type from just one
> random - if common - implementation issue.
> 
> What you want to do is to have a way to define and name a
> "constructor/desctructor" pair for an arbitrary type - *not*
> necessarily a pointer - and then optionally a way to say "Oh, don't do
> the destructor, because I'm actually going to use it long-term".

Yes, so when it's a 'pointer', that part becomes assigning it NULL (or
fdnull in the struct fd case). For example:

DEFINE_PTR_CLEANUP(kfree, void *, kfree(_C))

	ptr_cleanup(kfree, mem) = kzalloc(....);
	if (!mem)
		return -ENOMEM;

	object = mem;

	// build object with more failure cases

	mem = NULL;          // object is a success, we keep it.
	return object;

> I said "cleanup", but that's not right either, since we always have to
> have that initializer too.

I've found that for most things the initializer part isn't actually that
important. Consider that struct fd thing again; perf has a helper:

static inline struct fd perf_fget_light(int fd)
{
	struct fd f = fdget(fd);
	if (!f.file)
		return fdnull;

	if (f.file->f_op != &perf_fops) {
		fdput(f);
		return fdnull;
	}
	return f;
}

So now we have both fdget() and perf_fget_light() to obtain a struct fd,
both need fdput().

The pointer with destructor semantics works for both:

DEFINE_PTR_CLEANUP(fdput, struct fd, fdput(_C))

	ptr_cleanup(fdput, f) = perf_fget_light(fd);

or, somewhere else:

	ptr_cleanup(fdput, f) = fdget(fd);


The same is true for kfree(), we have a giant pile of allocation
functions that all are freed with kfree(): kmalloc(), kzalloc(),
kmalloc_node(), kzalloc_node(), krealloc(), kmalloc_array(),
krealloc_array(), kcalloc(), etc..

> Maybe just bite the bullet, and call the damn thing a "class", and
> have some syntax like
> 
>      DEFINE_CLASS(name, type, exit, init, initarg...);
> 
> to create the infrastructure for some named 'class'. So you'd have
> 
>     DEFINE_CLASS(mutex, struct mutex *,
>         mutex_unlock(*_P),
>         ({mutex_lock(mutex); mutex;}), struct mutex *mutex)
> 
> to define the mutex "class", and do
> 
>     DEFINE_CLASS(fd, struct fd,
>         fdput(*_P),
>         fdget(f), int f)
> 
> for the 'struct fd' thing.

Right; that is very close to what I have. And certainly useful --
although as per the above, perhaps not so for the struct fd case.

> Then to _instantiate_ one of those, you'd do
> 
>     INSTANTIATE_CLASS(name, var)
> 
> which would expand to
> 
>     class_name_type var
>         __attribute__((__cleanup__(class_name_destructor))) =
> class_name_constructor
> 
> and the magic of that syntax is that you'd actually use that
> "INSTANTIATE_CLASS()" with the argument to the init function
> afterwards, so you'd actually do
> 
>     INSTANTIATE_CLASS(mutex, n)(&sched_domains_mutex);
> 
> to create a variable 'n' of class 'mutex', where the
> class_mutex_constructor gets the pointer to 'sched_domain_mutex' as
> the argument.

Yes, I had actually considered this syntax, and I really like it. The
only reason I hadn't done that is because the for-loop thing, there I
couldn't make it work.

> I'm sure there's something horribly wrong in the above, but my point
> is that I'd really like this to make naming and conceptual sense.

Right, I hear ya. So the asymmetric case (iow destructor only) could be
seen as using the copy-constructor.

#define DEFINE_CLASS(name, type, exit, init, init_args...)		\
typedef type class_##name##_t;						\
static inline void class_##name##_destructor(type *this)		\
{ type THIS = *this; exit; }						\
static inline type class_##name##_constructor(init_args)		\
{ type THIS = init; return THIS; }

#define __INSTANTIATE_VAR(name, var)					\
	class_##name##_t var __cleanup(class_##name##_destructor)

#define INSTANTIATE_CLASS(name, var)					\
	__INSTANTIATE_VAR(name, var) = class_##name##_constructor


DEFINE_CLASS(fd, struct fd, fdput(THIS), f, struct fd f)

	INSTANTIATE_CLASS(fd, f)(perf_fget_light(fd));


Alternatively, you be OK with exposing INSTANTIATE_VAR() to easily
circumvent the default constructor?

And/or how about EXTEND_CLASS(), something like so?

#define EXTEND_CLASS(name, ext, init, init_args...)			\
typedef class_##name##_t class_##name##ext##_t;				\
static inline void class_##name##ext##_destructor(class_##name##_t *this) \
{ class_##name##_destructor(this); }					\
static inline type class_##name##ext##_constructor(init_args)		\
{ type THIS = init; return THIS; }


DEFINE_CLASS(fd, struct fd, fdput(THIS), fdget(fd), int fd)
EXTEND_CLASS(fd, _perf, perf_fget_light(fd), int fd)

	INSTANTIATE_CLASS(fd_perf, f)(fd);


> And at THAT point, you can do this:
> 
>     #define mutex_guard(m) \
>         INSTANTIATE_CLASS(mutex, __UNIQUE_ID(mutex))(m)
> 
> and now you can do
> 
>        mutex_guard(&sched_domains_mutex);

So the 'problem' is the amount of different guards I ended up having and
you can't have macro's define more macros :/

Which is how I ended up with the:

	guard(mutex, &sched_domains_mutex);

syntax.

This can ofcourse be achieved using the above CLASS thing like:

DEFINE_CLASS(mutex, struct mutex *, mutex_unlock(THIS),
	     ({ mutex_lock(m); m; }), struct mutex *m)

#define named_guard(name, var, args...)					\
	INSTANTIATE_CLASS(name, var)(args)

#define guard(name, args...)						\
	named_guard(name, __UNIQUE_ID(guard), args)

#define scoped_guard(name, args...)					\
	for (named_guard(name, scope, args),				\
	     *done = NULL; !done; done = (void *)1)


With the understanding they're only to be used for locks.

Also, I'm already tired of writing INSTANTIATE.. would:

	CLASS(fd, f)(fd);

	VAR(kfree, mem) = kzalloc_node(...);

be acceptable shorthand?
