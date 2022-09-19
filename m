Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36FF5BD856
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiISXkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiISXkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:40:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC84BA56
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:40:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kr11so2245706ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NXzXxlM9sVEFzc66soX0I+Z/mq5m2rg9T8SoVpFvUT4=;
        b=NsywTCeY9sd40b/41h2okvpTgyG2TSi3t/dg5pbH/L3beDvVkydnABPeMyhFxfDIgt
         4OZkJs8sPvCO28LEtRRl+3W+3YNo6DLVmNhyIyLg+6fJ8XdVP3Pw424Mqr/64OBW8YJx
         KH623RdzusneU5G9sBz+JF5PMau1u0ftV/Lbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NXzXxlM9sVEFzc66soX0I+Z/mq5m2rg9T8SoVpFvUT4=;
        b=IALi7SrBgWBcEv5uuW7Gc9ykhJaJNDE/EYxmyksz7WjZZ5a4z5+7g11W0R0uxh0caF
         UMW48I1ePveVoRBl6deFqG6TGr99dMiRm+snfAN8Tdw3JztBMIKT76iCFfPxCQxYwCMh
         VP5Q6c4dapyrbtrTHBx4/eDhJ8ujF6u0jIuP5TQ2iGZXFgl+p6FYNxz9MNlHJ9PzpgXs
         q7XgWHsV+F3xN7ZcOKgKZWYLdyFyjhL0bI1f1olhJRsvDiA4Nt9ljYAZk/V3skOGV0jA
         Xr2Vp2twD+HlNgZ+6NAT/juit2Iy0/DXqZVnyBqc9MpgkrWMPc7IqJyF5sqq2PzoXDdj
         daNA==
X-Gm-Message-State: ACrzQf3V63+DaECk6QTitGN4svZH1RMie7Vyr/7m3puRfHhxJhWptzS8
        6S6F2IsXDCLnkcU2C30niFMTjoXhx3hyRDbtfiw=
X-Google-Smtp-Source: AMsMyM6fxkCliXmNaqc8zciVjNQQhbvtcTPdagf9bC0/vFeEawxo/g6MhAhusLuQnypYcX2a39egWg==
X-Received: by 2002:a17:906:58c7:b0:722:f4bf:cb75 with SMTP id e7-20020a17090658c700b00722f4bfcb75mr14743827ejs.450.1663630828382;
        Mon, 19 Sep 2022 16:40:28 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906300d00b00770880dfc4fsm16217143ejz.29.2022.09.19.16.40.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 16:40:26 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id m3so1378652eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:40:24 -0700 (PDT)
X-Received: by 2002:a2e:9886:0:b0:26c:57d9:10c6 with SMTP id
 b6-20020a2e9886000000b0026c57d910c6mr778573ljj.309.1663630813877; Mon, 19 Sep
 2022 16:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-13-ojeda@kernel.org> <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org> <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
 <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
 <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
 <YyivY6WIl/ahZQqy@wedsonaf-dev> <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
 <Yyjut3MHooCwzHRc@wedsonaf-dev>
In-Reply-To: <Yyjut3MHooCwzHRc@wedsonaf-dev>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Sep 2022 16:39:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
Message-ID: <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        alex.gaynor@gmail.com, ark.email@gmail.com,
        bjorn3_gh@protonmail.com, bobo1239@web.de, bonifaido@gmail.com,
        boqun.feng@gmail.com, davidgow@google.com, dev@niklasmohrin.de,
        dsosnowski@dsosnowski.pl, foxhlchen@gmail.com, gary@garyguo.net,
        geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.falkowski@samsung.com,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, viktor@v-gar.de,
        Andreas Hindborg <andreas.hindborg@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 3:35 PM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> No one is talking about absolute safety guarantees. I am talking about
> specific ones that Rust makes: these are well-documented and formally
> defined.

If you cannot get over the fact that the kernel may have other
requirements that trump any language standards, we really can't work
together.

Those Rust rules may make sense in other environments. But the kernel
really does have hard requirements that you continue to limp along
even if some fundamental rule has been violated. Exactly because
there's often no separate environment outside the kernel that can deal
with it.

End result: a compiler - or language infrastructure - that says "my
rules are so ingrained that I cannot do that" is not one that is valid
for kernel work.

This is not really any different from the whole notion of "allocation
failures cannot panic" that Rust people seemed to readily understand
is a major kernel requirement, and that the kernel needed a graceful
failure return instead of a hard panic.

Also note that the kernel is perfectly willing to say "I will use
compiler flags that disable certain guarantees". We do it all the
time.

For example, the C standard has a lot of "the compiler is allowed to
make this assumption". And then we disagree with those, and so "kernel
C" is different.

For example, the standard says that dereferencing a NULL pointer is
undefined behavior, so a C compiler can see a dereference of a pointer
to be a guarantee that said pointer isn't NULL, and remove any
subsequent NULL pointer tests.

That turns out to be one of those "obviously true in a perfect world,
but problematic in a real world with bugs", and we tell the compiler
to not do that by passing it the '-fno-delete-null-pointer-checks'
flag, because the compiler _depending_ on undefined behavior and
changing code generation in the build ends up being a really bad idea
from a security standpoint.

Now, in C, most of these kinds of things come from the C standard
being very lax, and having much too many "this is undefined behavior"
rules. So in almost all cases we end up saying "we want the
well-defined implementation, not the 'strictly speaking, the language
specs allows the compiler to do Xyz".

Rust comes from a different direction than C, and it may well be that
we very much need some of the rules to be relaxed.

And hey, Rust people do know about "sometimes the rules have to be
relaxed". When it comes to integer overflows etc, there's a
"overflow-checks" flag, typically used for debug vs release builds.

The kernel has similar issues where sometimes you might want the
strict checking (lockdep etc), and sometimes you may end up being less
strict and miss a few rules (eg "we don't maintain a preempt count for
this config, so we can't check RCU mode violations").

> But I won't give up on Rust guarantees just yet, I'll try to find
> ergonomic ways to enforce them at compile time.

I think that compile-time static checking is wonderful, and as much as
possible should be done 100% statically so that people cannot write
incorrect programs.

But we all know that static checking is limited, and then the amount
of dynamic checking for violations is often something that will have
to depend on environment flags, because it may come with an exorbitant
price in the checking.

Exactly like integer overflow checking.

                 Linus
