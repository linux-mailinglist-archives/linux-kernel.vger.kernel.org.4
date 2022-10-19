Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7482D604FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJSSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:36:42 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB3D16EA25
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:36:24 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r19so12267435qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hic1oazVXE3zC6bxc7l73SbPyyOlgvu3WnXoJo8Sr0=;
        b=V01kWhoyFvXQa88Ht6WMjphqL1lN6byPpIbIDK3W41MOcgbJDpKD3vxULheyUZmTEp
         NCBfyrQsWYEt4tLS+X7KE/eUBywCcBY3ZYljTQ1vY5HfXulKEcutsetsAU7Ix8M39MTK
         fCzZzPaGLPvKqaL5Po7CO+2Wzkt5AlEOjbhmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hic1oazVXE3zC6bxc7l73SbPyyOlgvu3WnXoJo8Sr0=;
        b=dDb106RBRNhh0Pc++9+YLk6qBilpztldQqliJxPz6lYKoorE4nuE9RvOXS2gOhlG8Z
         b6rohn5Xpm5Emp1nuRk+yXXCvNVHMbApHwmRwTRVDBj6iil/qkP3Iw8GceuiMgAa+7fj
         WvkPN9vQTgddvbIDD2DxZ7/93+ubBKlrnRzM2Yv0GuSmXUv+2NxNzCOhrOViv4Ll6pkZ
         fs8OOq2WBjFAlCVJ3pCYuMRpbYYgj3RVd0Ghz8UhOkPgp1c7CzCPA7Xzcd9R4pHgWmuw
         naJwZzHuXR0ZnlIPpyKB703fDpniRbAivwcnIfwyoU8FTouA3TTzDO4RkiGVAEhYBhal
         h95A==
X-Gm-Message-State: ACrzQf0uT8xjzDVZnUVLH/3fCn4m13Lt8UcbvelbtgillvTGJolm7ape
        5JkeOTY3Caf3mZApvb4F2M8x0NgWu+3rYQ==
X-Google-Smtp-Source: AMsMyM7MP4erBeaaD1QpxTXllUcXH1vrq9meo5q01A71x0maJ5B5lk+BekFP6tBbare0EWFiYTNNgQ==
X-Received: by 2002:a05:622a:1713:b0:39c:e41e:2b27 with SMTP id h19-20020a05622a171300b0039ce41e2b27mr7555999qtk.45.1666204568372;
        Wed, 19 Oct 2022 11:36:08 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a13e300b006ea7f9d8644sm5192406qkl.96.2022.10.19.11.36.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 11:36:07 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-367b8adf788so13274427b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:36:07 -0700 (PDT)
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr7629450ywl.67.1666204566848; Wed, 19
 Oct 2022 11:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com> <CAKwvOdmDz2VfU1JJkAEnPLTcx4PHH48KfZQfW6gvO6we_QbrRQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmDz2VfU1JJkAEnPLTcx4PHH48KfZQfW6gvO6we_QbrRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 11:35:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimUGWN6WuQ8q5Mba2jgG2FPEvp-TEoGR3k5rEekQ2wNg@mail.gmail.com>
Message-ID: <CAHk-=wimUGWN6WuQ8q5Mba2jgG2FPEvp-TEoGR3k5rEekQ2wNg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Wed, Oct 19, 2022 at 11:10 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Oct 19, 2022 at 10:26 AM Linus Torvalds
> >
> > Side note: several years ago I tried to make up some sane rules to
> > have 'sparse' actually be able to warn when a 'char' was used in a
> > context where the sign mattered.
>
> Do you have examples? Maybe we could turn this into a compiler feature
> request.  Having prior art on the problem would be a boon.

It's been over a decade since I seriously worked on sparse (Hmm.
Probably two, actually).  And I never got the 'char' logic to work
well enough for it to have ever made it into the kernel.

I'm also fairly sure I did it wrong - if I recall correctly, I did it
on the type system level, and the logic was in the tree
simplification, which was always much too weak.

Sparse does *some* expression simplification as it builds up the parse
tree and does all the type evaluations ("evaludate.c" in sparse), but
most of the real optimization work is done on the SSA format.

So what I probably *should* have done was to have a special "BEXT"
opcode (for "byte extend", the same way sparse has ZEXT and SEXT for
well-defined integer zero extend and sign extend), and linearized it
with all the simplifications that we do on the SSA level, and then if
the BEXT opcode still exists after all our optimization work, we'd
warn about it, because that means that the signedness ends up
mattering.

But sparse originally did almost everything just based on the type
system, which was the original intent of sparse (ie the whole "extend
the pointer types to have different address spaces" was really what
sparse was all about).

> Clang's -Wbitfield-constant-conversion can catch that.

Yeah, so bitfield signedness is really trivial, and works all on the
type system.

It's very easy to say: "you defined this member as an implicitly
signed bitfield, did you *really* mean to do that?" because signed
bitfields simply do not exists in the kernel.

So that warning is trivial, and the fix is basically universally
change 'int a:1' to 'unsigned a:1', because even *if* you do want
signed bitfields, it's just better to make that very very explicit,
and write it as 'signed int x:10'.

We do have a couple of signed bitfields in the kernel, but they are
unusual enough that it's actually a good thing that sparse just made
people be explicit about it.

Do

        git grep '\<signed\>.*:[1-9]'

to see the (few) examples and a few false positives that trigger in
the trace docs.

So sparse doesn't actually have to be clever about bitfield signs. It
can literally just say "did you really mean to do that", and that's
it. Very simple. Not at all the complexity that 'char' has, where
every single use technically tends to cause a sign-extension (due to
the integer conversion), but that doesn't mean that it *matters* in
the end.

            Linus
