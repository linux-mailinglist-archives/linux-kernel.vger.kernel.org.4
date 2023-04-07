Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BF6DB49C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDGT72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGT70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:59:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B156DAD02
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:59:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-502739add9dso2307464a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680897563; x=1683489563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaUQBomv+m9YOS1+lTfr+NOwuLJy2GeX3csYQ/E4Tx8=;
        b=WY0PnRP5u/3kbSNQoSEZoLY0s1/2IbIfOo9zZpnHmHNYIgorJfVe4T+09VfZjKiJV4
         t+5K2+HFnTcl9WoId4lnBdKkOCz5hoL8yJeSS8d+/0v2ilqRU+7PvW77U+XmCmJaBwF+
         A+3/jnje0bq/Cj7RCwDktP4apxNSFJqvE1hnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897563; x=1683489563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaUQBomv+m9YOS1+lTfr+NOwuLJy2GeX3csYQ/E4Tx8=;
        b=oBjnrkGz8CvQp32deDNXkrwC7c1vzf5KwQjgO5WFLmgjdfjnK8BQKV4yClrKZ5kuaP
         T22PaZqCCVdf1AqFqD0ePDzYfVUHPVoxT1lw+V6+w8lMx3Etkw4DRuHB9B/NCANEW6OK
         FNhs9CQiRSGug50isvF65vuwAJscgCbu0PkywZZbwEHll7/6CvYO3FdVphaHDD+L3uVH
         7FwCktW/ZWEVwxGxaw7bPNC+5TfdY5ckCtWYEZTAS84bh8Avi94V+RqliO7YsQfzWUoS
         lZCo/mPFjezhK3bEDYR8m9WD3QHSaFz7r0c8t0g0I99CyjNkx170Iin7sapSKBmInK25
         ox4g==
X-Gm-Message-State: AAQBX9ey1PQ4hsBZ/ByOaYxZvvjeKRHLhBU4yBVAzM6AGnIwBLgToExx
        P1Pqo56B6bcXyvuEJbPcbcvBoX1YLfSEaR5CE41ncw==
X-Google-Smtp-Source: AKy350ZP4Z33lOODRl9lnkVMYePYHhERMN2YlkSDoinRPaBuMotW2hfBhUdR/b0KMhYFQqQBKBfRLQ==
X-Received: by 2002:aa7:c257:0:b0:502:3ea4:7f95 with SMTP id y23-20020aa7c257000000b005023ea47f95mr3960095edo.35.1680897562829;
        Fri, 07 Apr 2023 12:59:22 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id z95-20020a509e68000000b004c09527d62dsm2247020ede.30.2023.04.07.12.59.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:59:22 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id n21so10581638ejz.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:59:22 -0700 (PDT)
X-Received: by 2002:a17:906:380c:b0:931:2bcd:ee00 with SMTP id
 v12-20020a170906380c00b009312bcdee00mr246788ejc.15.1680897561831; Fri, 07 Apr
 2023 12:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
 <CAHk-=wgyY_FKpWk1LAHirjmWbABc78C+mgVhqaYHZts0fbkYJQ@mail.gmail.com> <bc11f501-f020-4e90-9588-5d234e96159d@app.fastmail.com>
In-Reply-To: <bc11f501-f020-4e90-9588-5d234e96159d@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Apr 2023 12:59:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wik+Sh=cV9FHxPe1Rsb+=XGNFHU1wJZ7yqtcgwYLz5Xuw@mail.gmail.com>
Message-ID: <CAHk-=wik+Sh=cV9FHxPe1Rsb+=XGNFHU1wJZ7yqtcgwYLz5Xuw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic fixes for 6.3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Matt Evans <mev@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 1:03=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> As far as I can tell, almost no users of
> {cmp,}xchg{,_local,_relaxed,acquire,release} that actually use
> 8-bit and 16-bit objects, and they are not even implemented on
> some architectures.

Yeah, I think we only have a driver or two that wants to do a 8/16-bit
cmpxchg, and many architectures don't support it at all natively (ie
it has to be implemented as a load-mask-store).

But iirc we *did* have a couple of uses, so..

> There is already a special case for the 64-bit xchg()/cmpxchg()
> variants that can get called on 32-bit architectures, so what
> I'd prefer is having each architecture implement only explicit
> fixed length cmpxchg8(), cmpxchg16(), cmpgxchg32() and optionally
> cmpxchg64() interfaces as normal inline functions that work on
> the respective integer types.

Hmm. Maybe. Except the reason we have those size-dependent macros is
that it is *really* really convenient - to the point of being very
important - when different architectures (or different kernel
configurations) end up causing the same logical thing to have
different sizes.

The whole "switch (sizeof(x))" model with complex macros is very ugly
and I'd much rather strive to implement something that is much more
geared to actual compiler issues where the compiler really explicitly
does select the right thign (rather than have the preprocessor expand
it to multiple things and then depending on the optimizer to do the
"selection").

But at the same time, aside from the macro ugliness, it really ends up
being *hugely* powerful as a concept, and avoiding a lot of
conditionals in the use cases.

Now, cmpxchg *may* be uncommon enough that the use cases are limited
enough that the "generic size" model wouldn't be worth it there, but I
was really thinking about the more generic cases.

Things like "get_user()" and "put_user()" would be *entirely* useless
without the automatic sizing.

How do I know? because we originally didn't have "get_user()". We had
"get_fs_byte()" and "get_fs_word()" etc. The "fs" part was due to the
original x86 implementation, so ignore the naming, but the issue with
"just use fixed types" really DOES NOT WORK when different
architectures have different types.

So switching over to "get_user()" that just automatically did the
right thing based on size instead of the size-specific ones really was
a huge deal. There's no way we could ever go back.

And while 'cmpxchg()' is the problem case here, I really think it
would be lovely if we had some nice *unified* way of handling these
"use size of access to determine variant" thing. Something like
_Generic, just based on size.

I guess __builtin_choose_expr() might be the right way to go there.

That's very much a "compiler statically picks one over the other"
interface. I despise the syntax, which is why it's not very commonly
used, but it might be what we should use.

Of course, another reason - other than syntax - for our "switch
(sizeof())" model is simply history. The kernel "get_user()"
interfaces go back to 1995 and Linux-1.3.0, and actually predates
__builtin_choose_expt() support in gcc by several years. Gcc only
started doing that in 2001 (gcc-3.4.5)

So we do have a few uses of __builtin_choose_expr() in the kernel, but
our really old interfaces simply didn't even have it available.

                 Linus
