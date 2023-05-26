Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE269712F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbjEZV4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244231AbjEZVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:55:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC4E6E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso2128947a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685138099; x=1687730099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS3kqGVuLq0Clh8JmF5WGl1IDCwum22o6Kw3GqzDB2I=;
        b=JZHHa8KYTpmRT5CpvKQaNtV7fogb4aae0Sx1oCeizgQrjMMk3Nfxkfrzt5vGkPUUAH
         fywszDCXMdRCU4KntxGgHeaXxj/tCXS4J8EFuW36p8I06b4wYGMrKnxWwKOAoBBTda7X
         mR32Vqh16Gx/LtqaoBSro9aw6+jDJXx4fdyZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138099; x=1687730099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS3kqGVuLq0Clh8JmF5WGl1IDCwum22o6Kw3GqzDB2I=;
        b=in/ARtT/2nMgPXKzOOdw7RKZHw70neg5n/tIjhAGeLQanZGPN1mPIpCLvI9KV8mCqO
         eN9pHMjVw8KueuhNAykO4RJUxVtjLJwbeeQrBn8yfa8zdG2KijJ3Uk4P4drCyBG4RUVj
         m7YVW3vAavq0DlNiDVOnUrslUWO3YuWoNAsrj2pcaDhT5qsKpMzqS4MDJzV1TTRmXRCD
         2UInNjMn0lhvKXOVGJZPTBW7tcGy7CIi+4ggMTSE6o9fBeLsv01ynLyxM0l7C1zzS1+B
         OLpP3E2rf8YIXrHU5xfqpGLiSvLTJfUJ1VvCO9kljgZGQXns5VP1dby67L5CM8pNZwvB
         FW5A==
X-Gm-Message-State: AC+VfDxKTVO53I1ZB9YxXVazjoGrvt3rR+zkUj0wLJvEgxgn0asZAYpx
        gccW1buuc4JG4zP6mF9izz4BHKui3dx0CmYrlq+98iaO
X-Google-Smtp-Source: ACHHUZ6+CXvurNkF84FqpAxQqMbM7eejZ0wEfAHPu8Am3neCkauukQGQl+5aDb4Y5hLSmvdSTMD4Mw==
X-Received: by 2002:a17:907:2d9e:b0:967:e015:f542 with SMTP id gt30-20020a1709072d9e00b00967e015f542mr3939114ejc.44.1685138099344;
        Fri, 26 May 2023 14:54:59 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id v23-20020a056402185700b0050b2f588db6sm356554edy.16.2023.05.26.14.54.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 14:54:58 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso2128917a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:58 -0700 (PDT)
X-Received: by 2002:a17:907:7f0b:b0:96f:e080:4f56 with SMTP id
 qf11-20020a1709077f0b00b0096fe0804f56mr3497831ejc.31.1685138098025; Fri, 26
 May 2023 14:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <20230526205855.587341916@infradead.org>
 <20230526212454.GB4057254@hirez.programming.kicks-ass.net>
In-Reply-To: <20230526212454.GB4057254@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 14:54:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgt=cq_fU33DCv0=xD30sH8eOGHsEQRJQi=2vtrWt7oPQ@mail.gmail.com>
Message-ID: <CAHk-=wgt=cq_fU33DCv0=xD30sH8eOGHsEQRJQi=2vtrWt7oPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] locking: Introduce __cleanup__ based guards
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 2:25=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>> > +                                                                     =
        \
> > +static inline void ptr_guard_##_type##_cleanup(_Type **_ptr)          =
       \
> > +{                                                                     =
       \
> > +     _Type *_G =3D *_ptr;                                             =
         \
> > +     if (_G)                                                          =
       \
> > +             _Put(_G);                                                =
       \
> > +}
> > +
> > +#define ptr_guard(_type, _name)                                       =
               \
> > +     ptr_guard_##_type##_t _name __cleanup(ptr_guard_##_type##_cleanup=
)
> > +
>
> Ha, and then I wanted to create an fdput() guard... :/

I have to say, I'm not super-convinced about the macros to create
these guard functions and types.

I suspect that it would be better to literally just declare the guard
types directly.  For the fdget idiom, you really just want the guard
type to *be* the 'struct fd'.

And I think you made those macros just make too many assumptions.

It's not just "struct fd", for example.  If you want to do things like
wrap 'local_irq_save', again it's not a pointer, the context is just
'unsigned long irqflags'.

And I really don't think those type-creation macros buy you anything.

What's wrong with just writing it out:

    typedef struct fd guard_fdget_type_t;
    static inline struct fd guard_fdget_init(int fd)
    { return fdget(fd); }
    static inline void guard_fdget_exit(struct fd fd)
    { fdput(fd); }

and

    typedef struct mutex *guard_mutex_type_t;
    static inline struct mutex *guard_mutex_init(struct mutex *mutex)
    { mutex_lock(mutex); return mutex; }
    static inline void guard_mutex_exit(struct mutex *mutex)
    { mutex_unlock(mutex); }

I don't think the latter is in the *least* less readable than doing

    DEFINE_LOCK_GUARD_1(mutex, struct mutex,
                mutex_lock(_G->lock),
                mutex_unlock(_G->lock))

which is this magic macro that creates those, and makes them
completely ungreppable - and makes the type system very inflexible.

So I really think that it would be a lot easier to write out the
wrappers explicitly for the few types that really want this.

I dunno.

Once again, I have written example code in my MUA that I have not
tested AT ALL, and that may be fundamentally broken for some very
obvious reason, and I'm just too stupid to see it.

             Linus
