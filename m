Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52E715A03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjE3JZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjE3JZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:25:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D346E6B;
        Tue, 30 May 2023 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U4b5u9PAXu1NjIKm4r2zkTWzhp2hnHdBIyOfGQypFgc=; b=ZtQYis2cMdpYgNMGAkXLI7zJ38
        /SGJOj4vBvf92iAsu92rSohwLQxHuGaheRlW5VTX2PIhmzVH8PqtW+hw5T9PWJXDoizE+EtTwBErs
        qurBPQfKamwt/nu590kodYNWRH2s/Dx8DKze03MrMefITBX9B8YLQ3M5fLLVhD9YLkt6h0WXcSLOW
        JwjJenCusS8HTHf7Pzoq3L7upQysjCmVDTX5aZ4zxtjkLtayPWJbOYtqEH2ygLcf4BLDtVkFHd78i
        QYMoBJP4dHoDHIyRXWkzMRHK+zNlUIR2BNuk6sS81/pd6RjqWd8N8lv2MX9bwA+zJKr89GghjZh9s
        9pBkTetA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3vZy-006ABT-Ne; Tue, 30 May 2023 09:23:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCEC43001C3;
        Tue, 30 May 2023 11:23:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC897214873C3; Tue, 30 May 2023 11:23:42 +0200 (CEST)
Date:   Tue, 30 May 2023 11:23:42 +0200
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
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 12:18:04PM -0700, Linus Torvalds wrote:

> So how about we take a step back, and say "what if we don't create a
> new scope at all"?

Note that the lock_guard() and ptr_guard() options I have don't require
the new scope thing. The scope thing is optional.

> I think it actually improves on everything. The macros become
> *trivial*. The code becomes more legible.
> 
> And you can have multiple different scopes very naturally, or you can
> just share a scope.
> 
> Let me build up my argument here. Let's start with this *trivial* helper:
> 
>     /* Trivial "generic" auto-release macro */
>     #define auto_release_name(type, name, init, exit) \
>         type name __attribute__((__cleanup__(exit))) = (init)
> 
> it's truly stupid: it creates a new variable of type 'type', with name
> 'name', and with the initial value 'init', and with the cleanup
> function 'exit'.
> 
> It looks stupid, but it's the *good* stupid. It's really really
> obvious, and there are no games here.

I really don't like the auto naming since C++/C23 use auto for type
inference.

> Let me then introduce *one* other helper, because it turns out that
> much of the time, you don't really want to  pick a name. So we'll use
> the above macro, but make a version of it that just automatically
> picks a unique name for you:
> 
>     #define auto_release(type, init, exit) \
>         auto_release_name(type, \
>                 __UNIQUE_ID(auto) __maybe_unused, \
>                 init, exit)

I like that option.

> And it turns out that the above two trivial macros are actually quite
> useful in themselves. You want to do an auto-cleanup version of
> 'struct fd'? It's trivial:
> 
>     /* Trivial "getfd()" wrapper */
>     static inline void release_fd(struct fd *fd)
>     { fdput(*fd); }
> 
>     #define auto_getfd(name, n) \
>         auto_release_name(struct fd, name, fdget(n), release_fd)
> 

>  - I think the above is simpler and objectively better in every way
> from the explicitly scoped thing

Well, I think having that as a option would still be very nice.

>  - I also suspect that to get maximum advantage of this all, we would
> have to get rid of -Wdeclaration-after-statement
> 
> That last point is something that some people will celebrate, but I do
> think it has helped keep our code base somewhat controlled, and made
> people think more about the variables they declare.
> 
> But if you start doing consecutive cleanup operations, you really end
> up wanting to do thigns like this:
> 
>     int testfd2(int fd1, int fd2)
>     {
>         auto_getfd(f1, fd1);
>         if (!f1.file)
>                 return -EBADF;
>         auto_getfd(f2, fd2);
>         if (!f2.file)
>                 return -EBADF;
>         return do_something (f1, f2);
>     }

If you extend the ptr_guard() idea you don't need to get rid of
-Wdeclaration-after-statement and we could write it like:

	int testfd2(int fd1, int fd2)
	{
		ptr_guard(fdput, f1) = fdget(fd1);
		ptr_guard(fdput, f2) = null_ptr(fdput);
		if (!f1.file)
			return -EBADF;
		f2 = fdget(f2);
		if (!f2.file)
			return -EBADF;
		return do_something(f1, f2);
	}


Yes, the macros would be a little more involved, but not horribly so I
think.

typedef struct fd guard_fdput_t;

static const struct fd guard_fdput_null = __to_fd(0);

static inline void guard_fdput_cleanup(struct fd *fd)
{
	fdput(*fd);
}

#define ptr_guard(_guard, _name) \
	guard##_guard##_t _name __cleanup(guard##_guard##_cleanup)

#define null_ptr(_guard)		guard##_guard##_null;

And for actual pointer types (as opposed to fat pointer wrappers like
struct fd) we can have a regular helper macro like earlier:

#define DEFINE_PTR_GUARD(_guard, _type, _put)		\
typdef _type *guard##_guard##_t;			\
static const _type *guard##_guard##_null = NULL;	\
static inline void guard##_guard##_cleanup(_type **ptr)	\
{ if (*ptr) _put(*ptr); }

[NOTE: value propagation gets rid of the above conditional where
appropriate]

eg.:

  DEFINE_PTR_GUARD(put_task, struct task_struct, put_task_struct);


Possibly with a helper:

#define null_guard(_guard, _name) \
	ptr_guard(_guard, _name) = null_ptr(_guard)



Now, ptr_guard() per the above, is asymmetric in that it only cares
about release, let guard() be the symmetric thing that also cares about
init like so:

#define DEFINE_GUARD(_guard, _type, _put, _get)			\
DEFINE_PTR_GUARD(_guard, _type, _put)				\
static inline void guard##_guard##_init(guard##_guard##_t arg)	\
{ _get(arg); return arg; }

#define guard(_guard, _name, _var...)	\
	ptr_guard(_guard, _name) = guard##_guard@##_init(_var)

#define anon_guard(_guard, _var..) \
	guard(_guard, __UNIQUE_ID(guard), _var)

for eg.:

  DEFINE_GUARD(mutex, struct mutex, mutex_unlock, mutex_lock);

which then lets one write:

	int testfd2(int fd1, int fd2)
	{
		anon_guard(mutex, &cgroup_mutex);
		ptr_guard(fdput, f1) = fdget(fd1);
		null_guard(fdput, f2);
		if (!f1.file)
			return -EBADF;
		f2 = fdget(fd2);
		if (!f2.file)
			return -EBADf;
		return do_something(f1,f2);
	}

The RCU thing can then either be manually done like:

struct rcu_guard;

typedef struct rcu_guard *guard_rcu_t;
static const guard_rcu_null = NULL;
static inline guard_rcu_cleanup(struct rcu_guard **ptr)
{ if (*ptr) rcu_read_unlock(); }
static inline struct rcu_guard *guard_rcu_init(void)
{ rcu_read_lock(); return (void*)1; }

(or because we'll need this pattern a few more times, with yet another
DEFINE_foo_GUARD helper)

and:

	anon_guard(rcu);

works.

And at this point the previous scope() things are just one helper macro
away:

#define scope(_guard, _var..) \
	for (guard##_guard##_t *done = NULL, scope = guard##_guard##_init(var); \
	     !done; done++)

to be used where appropriate etc..


Yes, it's a wee bit more involved, but I'm thinking it gives a fair
amount of flexibility and we don't need to ret rid of
-Wdeclaration-after-statement.

Hmm?
