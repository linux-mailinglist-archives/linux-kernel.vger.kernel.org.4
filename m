Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B27246CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjFFOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbjFFOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:51:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47581E40
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:51:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-976a0a1a92bso703790566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686063065; x=1688655065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC8oBsqNuPxohD+DGyl4xevpH9uCNiaZarZVNVCDbPg=;
        b=fMaiVQA10s3i1QFhqZNhRfReLnFy/LaYHR6gZqEulY/1xrdMsHgrcOrXdvoReusPRN
         1fzcxfcmsPYdycWJh+Hr/ArqnHo0S7OGYh+MA3c+j5s9xyrR4e2TFK45OHEqswpPGzyX
         x/qy6zBgHJgxAMgmHIfhyAy24CWlvbo9RqbnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063065; x=1688655065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC8oBsqNuPxohD+DGyl4xevpH9uCNiaZarZVNVCDbPg=;
        b=inzDzRm8zQrExyTpgJLyNNY8Cdyr9Tl34s2UcWSTXDSkIs2mVfA9H2wYkmz86lUqcP
         2y3bvanvxRxpNqgn02NsyZC35QvaCquFBTCYrGPRO/FU4huC4TS8W0sddSaTP9+AA2Uj
         5FwTABgM4WkW52ADBGXfYpMMtU7+35FVt+NRfGPPMnUOzYkO/B6qIEox7EYMznPbc3nn
         2RnjWmzzBJK+0MKHbA0HnL//1Wv9VnfHzNS9vYACxOjU5wZEMeZ1rs8mFqmgT595um1y
         p6GfVLP9cY0AnU7n7d9pvHsuAIdezjU9zFxYrjNv5hXlcARWpmHHaQ89Zk105lcIEUZK
         Y/aw==
X-Gm-Message-State: AC+VfDypjArN1pRsCAOb7Oj1+yX0GK5L2a3XzhMtsLoZVdPq7Xh6cPN5
        M/RYy7zEgoBzgsclf0rFRFKDfici5XoTZhUrDbTD5o3O
X-Google-Smtp-Source: ACHHUZ5EAyX4YrrAEB0u0yrIJ8bKC5psKnePFR+jvlBak3GQ3WxUNPkVbiNz57QkBkHZ4JTlJ247yw==
X-Received: by 2002:a17:907:72d3:b0:961:69a2:c8d6 with SMTP id du19-20020a17090772d300b0096169a2c8d6mr3052096ejc.69.1686063065568;
        Tue, 06 Jun 2023 07:51:05 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709060a1100b009655eb8be26sm5687253ejf.73.2023.06.06.07.51.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:51:04 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so9474643a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:51:04 -0700 (PDT)
X-Received: by 2002:a05:6402:1613:b0:506:8dba:bd71 with SMTP id
 f19-20020a056402161300b005068dbabd71mr2048087edv.27.1686063064287; Tue, 06
 Jun 2023 07:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com> <20230606134005.GE905437@hirez.programming.kicks-ass.net>
In-Reply-To: <20230606134005.GE905437@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 07:50:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
Message-ID: <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
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
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 6:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> I know the name from C++ where it is std::lock_guard<> (well, back when
> I still did C++ it wasn't std, but whatever), and Rust seems to have
> std::sync::MutexGuard<>.
>
> But if that's the sole objection left, lets have a bike-shed party and
> pick a colour :-)
>
> 'shield' 'sentry' 'sentinel' 'keeper' 'custodian' 'warden' ?

I feel like you seem entirely too fixated on locking.

That's not even _remotely_ the most interesting case, I think.

For the common locking patterns , maybe "guard" makes sense as part of
the name, but it damn well shouldn't be about any "ptr_guard" or
whatever.

I think it should be some trivial

        mutex_scope(mymytex) {
                ..
        }

and yes, in that case scoping makes tons of sense and might even be
required, because you do want to visually see the scope of the
locking.

I'm not seeing the point of "guard" in that name either, but I don't
think the above is the complex case for naming, for use, or for
syntax.

In contrast, I think reference counting and allocations are the much
more interesting one, and the case where you are also more likely to
have multiple consecutive ones, and where it's likely less about "this
region is protected" and much more about the RAII patterns and
resources that you just want cleanup for.

So that's why I had that "auto_release" name - to make it clear that
it's about the *cleanup*, not about some "guarded region". See my
argument?

The locking cases can probably be handled with just a couple of macros
(mutex, rcu, maybe spinlock?) and I would violently argue that the
locking cases will have to have unconditional cleanup (ie if you
*ever* have the situation where some path is supposed to be able to
return with the lock held and no cleanup, then you should simply not
use the "mutex_scope()" kind of helper AT ALL).

So locking is, I feel, almost uninteresting. There are only a few
cases, and only trivial patterns for it, because anything non-trivial
had better be done very explicitly, and very much visibly by hand.

But look at the cases where we currently use "goto exit" kind of code,
or have duplicated cleanups because we do "cleanup(x); return -ERRNO"
kinds of patterns.

Some of them are locking, yes. But a lot of them are more generic "do
this before returning" kinds of things: freeing (possibly complex)
data structures, uncharging statistcs, or even things like writing
results back to user space.

And, unlike locking, those often (but not always) end up having the
"don't do this in the single success case" situation, so that you need
to have some way to show "ok, don't release it after all". Yes, that
ends up in practice likely being setting that special pointer to NULL,
but I think we need to have a much better syntax for it to show that
"now we're *not* doing the auto-release".

So it's that more complex case that I

 (a) don't think "guard" makes any sense for at all

 (b) think it's where the bigger payoffs are

 (c) think that generally are not "nested" (you release the resources
you've allocated, but you don't "nest" the allocations - they are just
serial.

 (d) think that the syntax could be pretty nasty, because the cleanup
is not just a trivial fixed "unlock" function

Just as an example of something that has a bit of everything, look at
kernel/cpu.c and the _cpu_down() function in particular, which has
that "goto out" to do all the cleanup.

That looks like a perfect case for having some nice "associate the
cleanup with the initialization" RAII patterns, but while it does have
one lock (cpus_write_lock/unlock()), even that one is abstracted away
so that it may be a no-op, and might be a percpu rwlock, and so having
to create a special macro for that would be more work than is worth
it.

Because what I *don't* want to happen is that people create some
one-time-use "helper" macro infrastructure to use this all. Again,
that cpus_write_lock/unlock is a good example of this.

End result: to avoid having crazy indentation, and crazy one-time
helper inline functions or whatever, I think you'd really want some
fairly generic model for

  "I am doing X, and I want to to Y as a cleanup when you exit the function=
"

where both X and Y can be *fairly* complicated things. They might be
as simple (and reasonably common) as "fd =3D fdget(f)" and "fdput(fd)",
but what about the one-offs like that cpus_write_lock/unlock pattern?

That one only happens in two places (_cpu_down() and _cpu_up()), and
maybe the answer is "we can't reasonably do it for that, because the
complexity is not worth it".

But maybe we *can*.

For example, this is likely the only realistic *good* case for the
horrible "nested function" thing that gcc supports. In my "look, we
could clean up a 'struct fd' example from last week, I made it do
something like this:

    /* Trivial "getfd()" wrapper */
    static inline void release_fd(struct fd *fd)
    { fdput(*fd); }

    #define auto_getfd(name, n) \
        auto_release_name(struct fd, name, fdget(n), release_fd)

but it would possibly be much more generic, and much more useful, if
that "release_fd()" function was generated by the macro as a local
nested inline function.

End result: you could use any arbitrary local cleanup code.

So you could have something like

  #define RAII(type, var, init, exit) \
        __RAII(type, var, init, exit, __UNIQUE_ID(fn)

  #define __RAII(type, var, init, exit, exitname) \
        void exitname(type *p) { exit } \
        type var __attribute__((__cleanup__(exitname))) =3D (init)

and do all of the above with

    RAII(struct fd, fd, fdget(f), fdput(fd));

because that macro would literally expand to create a (uniquely named)
nested function that then contains that "fdput(fd)".

I dunno. The syntax looks pretty bad, and I'm not even convinced clang
supports nested functions, so the above may not be an option.

But wouldn't it be nice to just be able to declare that arbitrary
cleanup in-place?

Then the lock cases would really just be trivial helper wrappers. And
you can use "guard" there if you want, but I feel it makes absolutely
*no* sense in the generic case. There is absolutely nothng that is
being "guarded" by having an automatic cleanup of some random
variable.

              Linus
