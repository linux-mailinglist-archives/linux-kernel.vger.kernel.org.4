Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984916AA747
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 02:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCDB3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 20:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCDB3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 20:29:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C56231A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 17:29:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a25so17460080edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 17:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677893390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojXXPezHnTj/nJEULaE+dKCCVgGQ8e1VodiuDXnPVj0=;
        b=gB+wzeeBpnsPVMJFZSF6NgLsvY7qw5xRPrwFqXafeHBUK2TQP0fBzq5UcfFKCIgz0r
         zGnAZTV7yRegzou4XTWSBI1oQbHPoAMbw2pzpGf0rpwSC0Vc9IXax1WQVWir6fYpJiYo
         uiKVn9LOvy+v9Tt9/fFoqOdbeJy7OmKGg6gqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677893390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojXXPezHnTj/nJEULaE+dKCCVgGQ8e1VodiuDXnPVj0=;
        b=0sIDhcLdAwuJs4j7JAFoOgdGWlTpF+0Cb1X0dFxvzCCeEo5rPBEtCIhfcThmNH7lIl
         G9q6+Yr0rLtGUBv0dlHi17cqDmA11WCQH1trMPt6oisog4PifBtyKqYXrSl5tiB7i9tJ
         YfoIfhm339tMalJ2vtB+IgV1PcGYysKGNpF0LBwfON87hFrCX63AKucjjHvPJ7mNLRGG
         hZ+PJVII2TYwI8i0DMFAeWDoLs/LcHHaRiUpOfsLPPTRIV/r1Z6+fe9wIXMofzwed58D
         ILBKRugX1GqfHGtv0idVTWS7qYGs8yvqGtLZiv0+aiA97FU8Ce0sXbNkOW3G1ojjccVa
         Ak6A==
X-Gm-Message-State: AO0yUKVM7JGP64+EV3Ue2f5J0ycHvbt5Nfc2U0eTLolKTv30wT+p6MZJ
        SFj/sBPwYXmL2uiWB+M5b+opPEGmzCkU8uDuXjjSzA==
X-Google-Smtp-Source: AK7set9Dt5fxM3wiwWAtIKE/Jp5/FFa9we+yLO4IaTNKLShXGsokvrqSe2NduXb5bi8KgHDniPsbhA==
X-Received: by 2002:a05:6402:35a:b0:4ab:4dc6:6f8c with SMTP id r26-20020a056402035a00b004ab4dc66f8cmr3811400edw.4.1677893390128;
        Fri, 03 Mar 2023 17:29:50 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id q14-20020a50cc8e000000b004c3db1f43b6sm1821061edi.38.2023.03.03.17.29.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 17:29:48 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id s11so17171980edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 17:29:48 -0800 (PST)
X-Received: by 2002:a50:bae3:0:b0:4c0:ef64:9299 with SMTP id
 x90-20020a50bae3000000b004c0ef649299mr2172186ede.5.1677893387987; Fri, 03 Mar
 2023 17:29:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com> <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
In-Reply-To: <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 17:29:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
Message-ID: <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 12:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> as an example here is a one-liner to show crappers which do 0-sized ops:
> bpftrace -e 'kprobe:memset,kprobe:memcpy /arg2 =3D=3D 0/ { @[probe,
> kstack(2)] =3D count(); }'

Looking not at 0-sized ops, but crazy small memset() ops, at least
some of these seem to have grown from the bitmap "optimizations".

In particular, 'cpumask_clear()' should just zero the cpumask, and on
the config I use, I have

    CONFIG_NR_CPUS=3D64

so it should literally just be a single "store zero to cpumask word".
And that's what it used to be.

But then we had commit aa47a7c215e7 ("lib/cpumask: deprecate
nr_cpumask_bits") and suddenly 'nr_cpumask_bits' isn't a simple
constant any more for the "small mask that fits on stack" case, and
instead you end up with code like

        movl    nr_cpu_ids(%rip), %edx
        addq    $63, %rdx
        shrq    $3, %rdx
        andl    $-8, %edx
        ..
        callq   memset@PLT

that does a 8-byte memset because I have 32 cores and 64 threads.

Now, at least some distro kernels seem to be built with CONFIG_MAXSMP,
so CONFIG_NR_CPUS is something insane (namely 8192), and then it is
indeed better to calculate some minimum size instead of doing a 1kB
memset().

But yes, it does look like we've had several regressions in various
areas, where we do insane "memset()" calls with variable size that
should never have been that. Both with kzalloc() and with cpumasks.

There are probably lots of other cases, I just happened to notice the
cpumask one when looking at "why is there a memset call in a function
that shouldn't have any at all".

I don't think this is a "rep stos" problem in general. Obviously it
might be in some cases, but I do think that the deeper problem is that
those small memset() calls generally should not have existed at all,
and were actual bugs. That cpumask_clear() should never have been a
function call in the first place for the "clear one or a couple of
words" case.

The kernel very seldom acts on byte data, so a memset() or memcpy()
that looks like individual bytes is some very odd stuff. We have lots
of often fairly small structures with fixed sizes, though. And maybe
there are other cases like that bogus "let's try to optimize the
bitmap range"...

Of course, then we *do* have distros that do actively detrimental
things. You have Ubuntu with that CONFIG_INIT_ON_ALLOC_DEFAULT_ON, and
if I didn't just rebuild my kernel with sane config options, I'd have
Fedora with CONFIG_MAXSMP that is meant to be a "check worst case"
option, not something you *use*.

Oh well.

          Linus
