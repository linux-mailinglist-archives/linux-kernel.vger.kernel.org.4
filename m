Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC0713636
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 21:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjE0T0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0T0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 15:26:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D05D3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 12:25:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso2010241e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685215557; x=1687807557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiZDicadLOv4XdKaxJfdtxSHBlAKSLxuzhTSlpG/fpI=;
        b=fKwKICAtfYZL/8TOsad581R1VNscKurR6NYxtAldsFgGnGJgpGyNCC4WhbeM8tfKIX
         ha5q9nJCTbML9ElPWZpb8I5f+ZZWeUyWpk9UiQtbBKEL9VAB7mwBJ2WtNcd7EJgSjSoW
         v9xDgdXn1E9+jtsuLmK+sBBML6eKJUBuFbqyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685215557; x=1687807557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiZDicadLOv4XdKaxJfdtxSHBlAKSLxuzhTSlpG/fpI=;
        b=RnJyjhFTLTZwXUTxiMl/HNjxXY4jJbv9cDMk3EEe1C1o/2aUOdxrifdLzKuSMu9pB8
         fo4NVgTPhrCVkb6lO0g9B9WEC7NXed4ZWugEMgEibQAGWiUIu0ofUwuK5EoGEJvaDDxP
         ksJfmJ777zaHaHL3apoDk7xxrugQnzi5zB1qPRWbDZ19wweRMreMAPEI21knH0KszKmT
         wtCJ8fPgmlEt3bJ6BFTCsa8QuagJvlSqc9DT5r41zHuR0LD6L8wVhZmedSTXqpkug8vr
         6l9+R4l/sIHN9j4ZzF9MPyJ9KQpkOIF1RoEhLIUAm/rlqrb0K31h9xgyKMecQqRGpRMW
         HfUw==
X-Gm-Message-State: AC+VfDxWYKMFTYooVd8jlne2bDmkeTFbYSWyGQQ9m92XHm7z2DIEI8Xw
        hc20q4MvZtg5GF/VbaHOJ6AI/cZWC69kwQ5W3ZYvTmNJ
X-Google-Smtp-Source: ACHHUZ5ixjqtdTYuUxK9JWoA2ITHxWeAlSxTBIYVwLMXv863qZ6581Xjr2kvdmwIckUCEk2XFs8C8A==
X-Received: by 2002:a19:750c:0:b0:4eb:18d:91de with SMTP id y12-20020a19750c000000b004eb018d91demr1762925lfe.43.1685215556965;
        Sat, 27 May 2023 12:25:56 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004edc485f86bsm1244475lfl.239.2023.05.27.12.25.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 12:25:56 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2af98eb6ef0so20040731fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 12:25:56 -0700 (PDT)
X-Received: by 2002:aa7:d70d:0:b0:514:8e4a:2d72 with SMTP id
 t13-20020aa7d70d000000b005148e4a2d72mr2607269edq.22.1685215100909; Sat, 27
 May 2023 12:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org>
In-Reply-To: <20230526205204.861311518@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 May 2023 12:18:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
Message-ID: <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 2:01=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> By popular demand, a new and improved version :-)

Well, I certainly find the improved version more legible, despite my
further comment about the type macros being too complicated.

But now I've slept on it, and I think the problem goes beyond "macros
being too complicated".

I actually think that the whole "create a new scope" is just wrong. I
understand why you did it: the whole "its' going out of scope" is part
of the *idea*.

BUT.

Adding a new scope results in

 (a) pointless indentation

 (b) syntax problems with fighting the limited syntax of for loops

 (c) extra dummy variables - both for the for loop hack, but also for
the scope guard thing itself

and none of the above is an *advantage*.

So how about we take a step back, and say "what if we don't create a
new scope at all"?

I think it actually improves on everything. The macros become
*trivial*. The code becomes more legible.

And you can have multiple different scopes very naturally, or you can
just share a scope.

Let me build up my argument here. Let's start with this *trivial* helper:

    /* Trivial "generic" auto-release macro */
    #define auto_release_name(type, name, init, exit) \
        type name __attribute__((__cleanup__(exit))) =3D (init)

it's truly stupid: it creates a new variable of type 'type', with name
'name', and with the initial value 'init', and with the cleanup
function 'exit'.

It looks stupid, but it's the *good* stupid. It's really really
obvious, and there are no games here.

Let me then introduce *one* other helper, because it turns out that
much of the time, you don't really want to  pick a name. So we'll use
the above macro, but make a version of it that just automatically
picks a unique name for you:

    #define auto_release(type, init, exit) \
        auto_release_name(type, \
                __UNIQUE_ID(auto) __maybe_unused, \
                init, exit)

again, there are absolutely no games here, it's all just very very
straightforward. It's so straightforward that it all feels stupid.

But again, it's the 'S' in "KISS". Keep It Simple, Stupid.

And it turns out that the above two trivial macros are actually quite
useful in themselves. You want to do an auto-cleanup version of
'struct fd'? It's trivial:

    /* Trivial "getfd()" wrapper */
    static inline void release_fd(struct fd *fd)
    { fdput(*fd); }

    #define auto_getfd(name, n) \
        auto_release_name(struct fd, name, fdget(n), release_fd)

and now you can write code like this:

    int testfd(int fd)
    {
        auto_getfd(f, fd);
        /* Do something with f.file */
        return f.file ? 0 : -EBADF;
    }

Which is really trivial, and actually pretty legible.

Note that there is no explicit "scope" here. The scope is simply
implicit in the code. The compiler will verify that it's at the
beginning of the block, since we do that
-Wdeclaration-after-statement, so for the kernel this is always at the
beginning of a scope anyway.

And that's actually a big advantage. You want to deal with *two* file
descriptors? Sure. Just do this:

    /* Do two file descriptors point to the same file? */
    int testfd2(int fd1, int fd2)
    {
        auto_getfd(f1, fd1);
        auto_getfd(f2, fd2);
        return f1.file && f1.file =3D=3D f2.file;
    }

and it JustWorks(tm). Notice how getting rid of the explicit scoping
is actually a *feature*.

Ok, so why did I want that helper that used that auto-genmerated name?
The above didn't use it, but look here:

    /* Trivial "mutex" auto-release helpers */
    static inline struct mutex *get_mutex(struct mutex *a)
    { mutex_lock(a); return a; }

    static inline void put_mutex(struct mutex **a)
    { mutex_unlock(*a); }

    #define auto_release_mutex_lock(lock) \
        auto_release(struct mutex *, get_mutex(lock), put_mutex)

That's all you need for a nice locked region.

Or how about RCU, which doesn't have a lock type? Just do this:

    struct rcu_scope;

    static inline struct rcu_scope *get_rcu(void)
    { rcu_read_lock(); return NULL; }

    static void put_rcu(struct rcu_scope **a)
    { rcu_read_unlock(); }

    #define auto_release_rcu_lock() \
        auto_release(struct rcu_scope *, get_rcu(), put_rcu)

and you're done. And how you can *mix* all these:

    int testfd2(int fd1, int fd2)
    {
        auto_release_mutex_lock(&cgroup_mutex);
        auto_release_rcu_lock();
        auto_getfd(f1, fd1);
        auto_getfd(f2, fd2);
        return f1.file && f1.file =3D=3D f2.file;
    }

Ok. The above is insane. But it's instructive. And it's all SO VERY SIMPLE.

It's also an example of something people need to be aware of: the
auto-releasing is not ordered. That may or may not be a problem. It's
not a problem for two identical locks, but it very much *can* be a
problem if you mix different locks.

So in the crazy above, the RCU lock may be released *after* the
cgroup_mutex is released. Or before.

I'm not convinced it's ordered even if you end up using explicit
scopes, which you can obviously still do:

    int testfd2(int fd1, int fd2)
    {
        auto_release_mutex_lock(&cgroup_mutex);
        do {
                auto_release_rcu_lock();
                auto_getfd(f1, fd1);
                auto_getfd(f2, fd2);
                return f1.file && f1.file =3D=3D f2.file;
        } while (0);
    }

so I don't think the nasty "scoped()" version is any better in this regard.

And before you say "unlock order doesn't matter" - that's actually not
true. Unlock order does matter when you have things like
"spin_lock_irq()" where the irq-off region then protects other locks
too.

If you do the "unlock_irq" before you've released the other spinlocks
that needed irq protection, you're now screwed.

Final notes:

 - I think the above is simpler and objectively better in every way
from the explicitly scoped thing

 - I do think that the auto-release can be very dangerous for locking,
and people need to verify me about the ordering. Maybe the freeing
order is well-defined.

 - I also suspect that to get maximum advantage of this all, we would
have to get rid of -Wdeclaration-after-statement

That last point is something that some people will celebrate, but I do
think it has helped keep our code base somewhat controlled, and made
people think more about the variables they declare.

But if you start doing consecutive cleanup operations, you really end
up wanting to do thigns like this:

    int testfd2(int fd1, int fd2)
    {
        auto_getfd(f1, fd1);
        if (!f1.file)
                return -EBADF;
        auto_getfd(f2, fd2);
        if (!f2.file)
                return -EBADF;
        return do_something (f1, f2);
    }

and you basically *have* to allow those declarations in the middle -
because you don't want to clean up fd2 in that "f1 failed" case, since
f2 doesn't exist yet.

                  Linus
