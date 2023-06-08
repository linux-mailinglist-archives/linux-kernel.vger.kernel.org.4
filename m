Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E03728414
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbjFHPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjFHPrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:47:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19F435BC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:47:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso1404618a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686239171; x=1688831171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikLyVGzKcEMuSqUp/nI13OAR5DV5p124KJuoTG/oIAE=;
        b=GYKQIuQgjsVrmT3tlSDLb2UFU7H6aZhNmRSdQLE3cqdlTHsPgAzy0sD98ItbZQOz42
         oSThFhAsKJB6ohC03mananbZfmtFI8OpYtuzh3P4b7qS1g4INhWNz5I2zJM7RgEvTXM+
         8NE6DQBw858AqBhOQDeTtfwuWYQmum1fWawa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239171; x=1688831171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikLyVGzKcEMuSqUp/nI13OAR5DV5p124KJuoTG/oIAE=;
        b=D8priT2J02uGrvSMT4QxSkf8XFoCST8aYJkMCxgWWNYFHJN/uYKpJV39D0whHpdGdK
         RiayQe/OdIG2LHkn0U/kp+NVnUC8Z/n5Lsv4gy3PxR6l0BiVvu4+XL7/ojeyx9E4wPXD
         LRWRxDWxwq7Kt2yUlA7Dcfqj+xYSh2G7npAdDSAOYjQdQU95mMabK3hgesQ61Zwu2A3A
         ksQkRfCIXvoWupPDeJTUG3n6h4y5nY4KN29c97FnBWsjfE7tg9FiulCihqUuNkgdI5tL
         lG1C61/RYMCeGrs2pZdX3AAq4kkjU5zn2cHgGdcmJT8kQR9Z6I9mIsEWtTnk23D8A/ix
         ujfg==
X-Gm-Message-State: AC+VfDzcR2Uh2pRntBV0J5yt7LrBdi3X5+8Y5p/MebelL5BNC9tV8CTu
        ECSEMBmW04eUziHMQvVLpgKXeCA8wVVLj+OrWTV8Mw==
X-Google-Smtp-Source: ACHHUZ67D9WATe6vg/FzN2FfOw6kHxkvfxNlJl0geRhbjaBazTpSv4sDvdm+6AGi0LNklOpleK9w1Q==
X-Received: by 2002:a17:907:26cc:b0:974:1c90:b3d3 with SMTP id bp12-20020a17090726cc00b009741c90b3d3mr194169ejc.12.1686239170820;
        Thu, 08 Jun 2023 08:46:10 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id lj12-20020a170906f9cc00b009786b73974fsm843306ejb.145.2023.06.08.08.46.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 08:46:10 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-977d6aa3758so146757766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:46:10 -0700 (PDT)
X-Received: by 2002:a17:907:8a15:b0:961:2956:2ed9 with SMTP id
 sc21-20020a1709078a1500b0096129562ed9mr197548ejc.25.1686239169847; Thu, 08
 Jun 2023 08:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230526205204.861311518@infradead.org> <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net> <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
In-Reply-To: <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Jun 2023 08:45:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
Message-ID: <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 1:53=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> Or perhaps use the smart-pointer concept applied to our classes like:
>
> #define smart_ptr(name, var) \
>         __INSTANTIATE_VAR(name, var)

So this is the only situation where I think "ptr" makes sense (your
"fat pointer" argument is nonsensical - sure, you can treat anything
as a pointer if you're brave enough, but that just means that
"pointer" becomes a meaningless word).

However, I think that for "smart pointers", we don't need any of this
complexity at all, and we don't need that ugly syntax.

> Then we can write:
>
> DEFINE_CLASS(kfree, void *, kfree(THIS), p, void *p)
>
>         smart_ptr(kfree, mem) =3D kzalloc_node(...);
>         if (!mem)
>                 return -ENOMEM;

No, the above is broken, and would result in us using "void *" in
situations where we really *really* don't want that.

For automatic freeing, you want something that can handle different
types properly, and without having to constantly declare the types
somewhere else before use.

And no, you do *not* want that "kfree(THIS)" kind of interface,
because you want the compiler to inline the freeing function wrapper,
and notice _statically_ when somebody zeroed the variable and not even
call "kfree()", because otherwise you'd have a pointless call to
kfree(NULL) in the success path too.

So for convenient automatic pointer freeing, you want an interface
much more akin to

        struct whatever *ptr __automatic_kfree =3D kmalloc(...);

which is much more legible, doesn't have any type mis-use issues, and
is also just trivially dealt with by a

  static inline void automatic_kfree_wrapper(void *pp)
  { void *p =3D *(void **)pp; if (p) kfree(p); }
  #define __automatic_kfree \
        __attribute__((__cleanup__(automatic_kfree_wrapper)))
  #define no_free_ptr(p) \
        ({ __auto_type __ptr =3D (p); (p) =3D NULL; __ptr; })

which I just tested generates the sane code even for the "set the ptr
to NULL and return success" case.

The above allows you to trivially do things like

        struct whatever *p __automatic_kfree =3D kmalloc(..);

        if (!do_something(p))
                return -ENOENT;

        return no_free_ptr(p);

and it JustWorks(tm).

And yes, it needs a couple of different versions of that
"__automatic_kfree()" wrapper for the different freeing cases (kvfree,
rcu_free, whatever), but those are all trivial one-liners.

And no, I didn't think too much about those names. "__automatic_kfree"
is too damn long to type, but you hated "auto". And "no_free_ptr()" is
not wonderful name either. But I tried to make the naming at least be
obvious, if not wonderful.

               Linus
