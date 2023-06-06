Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222B37250BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbjFFXWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjFFXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:22:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D5E6C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 16:22:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso443513a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686093765; x=1688685765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztzX8Ypln5t51i1Qy2TMffxcXTDyy7zyON++QBtp5gE=;
        b=fPtn07mxHsv57xJR43SqsSti1WES7f8BoXNwFQQHq5P4e8LbI4yojVEWjz++5BvZWA
         8+jOxQvZZqnSFkH+/W0kcmmVWyuFJaOR+v0vI9ryr4BmEQ8faDS+YFDwZJND78VfzSH+
         zwue+bB7Lblwmjt+eEF+LXt99RjKS5v0IHcmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686093765; x=1688685765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztzX8Ypln5t51i1Qy2TMffxcXTDyy7zyON++QBtp5gE=;
        b=XdyU9p+SJd9l90RpRLGYKvIq8n6ZrOzP7PEsAUo+3vADuFL0Z2BSsv5+9o0xjqRxQb
         i5aOOSPWtblFgVhtyxAZP9tMXV1J5vF4q9yO+nQYJimjnasDXvL5mgQrfIywy5w+gbbv
         fvEDorGD3pVEgsiX8z+HsmvS4SgyxzOiz2XJGYGgI9Tpl6wGESrhnlbzRzD3r12/+ZG6
         W6j1x+6P6SI0xl16GmM0THSUzE4xC7ac8Iy0pGo/GY1JGbI/s/ovpSrUomFeqz3SkPqX
         RPBaQcDYARnH8T4lUSkoeGmXeWIpKao1zQEQOnv7SSx5UB1bTxngMQ1DmvJXn/YQsfT9
         VE8Q==
X-Gm-Message-State: AC+VfDyIJyC4CylZDtY/celfGIkPSimT3AbZyLr9uIC9bvfKmyzJzGSB
        M0VaZ0qXHrf7Ss3GwtDfauKSqh/TEwfq4ghlUGol59hK
X-Google-Smtp-Source: ACHHUZ5eMBAlhkMDa7RAtWfZ61KraX6kp4Lbo441zdhvFDVbJe8VMHzG4ojBU8tDYfGZCFWyxi/b9w==
X-Received: by 2002:aa7:c144:0:b0:50b:cc96:633a with SMTP id r4-20020aa7c144000000b0050bcc96633amr3191135edp.24.1686093764758;
        Tue, 06 Jun 2023 16:22:44 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id e17-20020a056402105100b00501d73cfc86sm5686394edu.9.2023.06.06.16.22.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 16:22:44 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9786c67ec32so230636366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 16:22:43 -0700 (PDT)
X-Received: by 2002:a17:907:6e89:b0:973:da59:7c91 with SMTP id
 sh9-20020a1709076e8900b00973da597c91mr4528759ejc.51.1686093763583; Tue, 06
 Jun 2023 16:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
In-Reply-To: <20230606180806.GA942082@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 16:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
Message-ID: <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
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

On Tue, Jun 6, 2023 at 11:08=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:>
> Would it all be less offensive if I did: s/guard/cleanup/ on the whole
> thing?

It's more than "guard" for me.

What is "ptr"? Why? We already know of at least one case where it's
not a pointer at all, ie 'struct fd'.

So I *really* hate the naming. Absolutely none of it makes sense to
me. One part is a nonsensical name apparently based on a special-case
operation, and the other part is a nonsensical type from just one
random - if common - implementation issue.

What you want to do is to have a way to define and name a
"constructor/desctructor" pair for an arbitrary type - *not*
necessarily a pointer - and then optionally a way to say "Oh, don't do
the destructor, because I'm actually going to use it long-term".

I said "cleanup", but that's not right either, since we always have to
have that initializer too.

Maybe just bite the bullet, and call the damn thing a "class", and
have some syntax like

     DEFINE_CLASS(name, type, exit, init, initarg...);

to create the infrastructure for some named 'class'. So you'd have

    DEFINE_CLASS(mutex, struct mutex *,
        mutex_unlock(*_P),
        ({mutex_lock(mutex); mutex;}), struct mutex *mutex)

to define the mutex "class", and do

    DEFINE_CLASS(fd, struct fd,
        fdput(*_P),
        fdget(f), int f)

for the 'struct fd' thing.

The above basically would just create the wrapper functions (and
typedefs) for the constructor and destructor.

So the 'DEFINE_CLASS(mutex ..)' thing would basically just expand to

    typedef struct mutex *class_mutex_type;
    static inline void class_mutex_destructor(class_mutex_type *_C)
    { mutex_unlock(*_C); }
    static inline class_mutex_type class_mutex_constructor(struct mutex *mu=
tex)
    { return ({mutex_lock(mutex); mutex;}); }

Then to _instantiate_ one of those, you'd do

    INSTANTIATE_CLASS(name, var)

which would expand to

    class_name_type var
        __attribute__((__cleanup__(class_name_destructor))) =3D
class_name_constructor

and the magic of that syntax is that you'd actually use that
"INSTANTIATE_CLASS()" with the argument to the init function
afterwards, so you'd actually do

    INSTANTIATE_CLASS(mutex, n)(&sched_domains_mutex);

to create a variable 'n' of class 'mutex', where the
class_mutex_constructor gets the pointer to 'sched_domain_mutex' as
the argument.

And at THAT point, you can do this:

    #define mutex_guard(m) \
        INSTANTIATE_CLASS(mutex, __UNIQUE_ID(mutex))(m)

and now you can do

       mutex_guard(&sched_domains_mutex);

to basically start a guarded section where you hold 'sched_domains_mutex'.

And in that *very* least situation, 'guard' makes sense in the name.
But no earlier. And there is absolutely no 'ptr' anywhere here.

The above should work also for the 'struct fd' case, so you can do

       INSTANTIATE(fd, f)(fd);

to create a 'struct fd' named 'f' that is initialized with
'fdget(fd)', and will DTRT when going out of scope. Modulo any stupid
errors I did.

And ok, I didn't write out the exact macro magic to *get* those
expansions above (I just tried to write out the approximate end
result), but it should be mostly fairly straightforward.

So it would be the usual token pasting tricks to get the 'class type',
the 'class destructor' and the 'class constructor' functions.

Finally, note that the "initarg" part is a macro vararg thing. The
initargs can be empty (for things like RCU), but it could also
possibly be multiple arguments (like a "size and gfp_flags" for an
allocation?).

I'm sure there's something horribly wrong in the above, but my point
is that I'd really like this to make naming and conceptual sense.

And if somebody goes "The above is basically exactly what the original
C++ compiler did back when it was really just a pre-processor for C",
then you'd be 100% right. The above is basically (a part of) what
Bjarne did, except he did it as a separate pass.

And to answer the next question: why not just give up and do C++ -
it's because of all the *other* things Bjarne did.

             Linus
