Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46206604F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiJSSLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJSSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:11:36 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00505169CDF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:11:35 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z8so12222913qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oUCCyUWxse3Ihxvp+Qy73UCcxKzJGUZipUhThJxcdKU=;
        b=WuiA/6yKGF2cchs6SyRubR0sUiAOrR7hnAR9NdZ2x0xwinAtix2ztOnRoTlNt1SXaI
         roMCjEKH9M6eg3c9U2UbtL3mBN4LsaBH4jFFCPzxkXbbkYzXm6jYktZtwMV7kprSpq30
         K1C/H0DmKvpgKPvqRJv3DcVzYXeY9oOLsD3Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUCCyUWxse3Ihxvp+Qy73UCcxKzJGUZipUhThJxcdKU=;
        b=bUEHi5Vz/UPFKJsvDMqx5H4w6KFolfAFLcofooopPs8btVOmLe1C8DeLOmZ9Byyrw5
         C87L/I/bDcQv6oJCse/UCVsgR6YUofN/QgX6j6a2DS/no+RAPktFr5TgcatHNtLcszke
         aghv3NVhwXdnW7oR+2mpTZus+q3V0Iw1JaUnk5GkANtWNLoaPiIKJtaR8Msd7Q95Psqv
         t25v6EvenEnHGuxZHteUTlMDuWWoLxr18ZYz2Zp9XDHWN2qA/M6auNMly6SPAUcV1nuR
         jCnNDnLjQ5I/eCJUB8ZxrCc2CXVDaDYfDrr9F2Lh8jzCiTfJHBu5KGyhv85oWb5bjHEh
         U/Rg==
X-Gm-Message-State: ACrzQf2S+7H3Kzuf8iom2lK9juyw76eqTQw0s2rMOWVsc2BTf9excjDF
        THk9THA+KMU8NjMQZ8OpiGgUshgwfP2BiA==
X-Google-Smtp-Source: AMsMyM7TJT++f0nI/nkx4BJIZESfI/bTmYhoFWKAaK+VIt9w/7VEbrvn9BFZE1dG4A8kGABELaEE5A==
X-Received: by 2002:ac8:7d0d:0:b0:39c:c5e0:37c0 with SMTP id g13-20020ac87d0d000000b0039cc5e037c0mr7408772qtb.537.1666203094830;
        Wed, 19 Oct 2022 11:11:34 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id r19-20020a05620a299300b006eea4b5abcesm5841432qkp.89.2022.10.19.11.11.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 11:11:34 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-360871745b0so176259237b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:11:33 -0700 (PDT)
X-Received: by 2002:a81:1007:0:b0:357:45e3:304c with SMTP id
 7-20020a811007000000b0035745e3304cmr7943725ywq.340.1666203093522; Wed, 19 Oct
 2022 11:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com> <20221019174345.GM25951@gate.crashing.org>
In-Reply-To: <20221019174345.GM25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 11:11:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
Message-ID: <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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

On Wed, Oct 19, 2022 at 10:45 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> When I did this more than a decade ago there indeed was a LOT of noise,
> mostly caused by dubious code.

It really happens with explicitly *not* dubious code.

Using 'unsigned char[]' is very common in code that actually does
anything where you care about the actual byte values. Things like
utf-8 handling, things like compression, lots and lots of cases.

But a number of those cases are still dealing with *strings*. UTF-8 is
still a perfectly valid C string format, and using 'strlen()' on a
buffer that contains UTF-8 is neither unusual nor wrong. It is still
the proper way to get the byte length of the thing. It's how UTF-8 is
literally designed.

And -Wpointer-sign will complain about that, unless you start doing
explicit casting, which is just a worse fix than the disease.

Explicit casts are bad (unless, of course, you are explicitly trying
to violate the type system, when they are both required, and a great
way to say "look, I'm doing something dangerous").

So people who say "just cast it", don't understand that casts *should*
be seen as "this code is doing something special, tread carefully". If
you just randomly add casts to shut up a warning, the casts become
normalized and don't raise the kind of warning signs that they
*should* raise.

And it's really annoying, because the code ends up using 'unsigned
char' exactly _because_ it's trying to be careful and explicit about
signs, and then the warning makes that carefully written code worse.

> Then suggest something better?  Or suggest improvements to the existing
> warning?

As I mentioned in the next email, I tried to come up with something
better in sparse, which wasn't based on the pointer type comparison,
but on the actual 'char' itself.

My (admittedly only ever half-implemented) thing actually worked fine
for the simple cases (where simplification would end up just undoing
all the "expand char to int" because the end use was just assigned to
another char, or it was masked for other reasons).

But while sparse does a lot of basic optimizations, it still left
enough "look, you're doing sign-extensions on a 'char'" on the table
that it warned about perfectly valid stuff.

And maybe that's fundamentally hard.

The "-Wpointer-sign" thing could probably be fairly easily improved,
by just recognizing that things like 'strlen()' and friends do not
care about the sign of 'char', and neither does a 'strcmp()' that only
checks for equality (but if you check the *sign* of strcmp, it does
matter).

It's been some time since I last tried it, but at least from memory,
it really was mostly the standard C string functions that caused
almost all problems.  Your *own* functions you can just make sure the
signedness is right, but it's really really annoying when you try to
be careful about the byte signs, and the compiler starts complaining
just because you want to use the bog-standard 'strlen()' function.

And no, something like 'ustrlen()' with a hidden cast is just noise
for a warning that really shouldn't exist.

So some way to say 'this function really doesn't care about the sign
of this pointer' (and having the compiler know that for the string
functions it already knows about anyway) would probably make almost
all problems with -Wsign-warning go away.

Put another way: 'char *' is so fundamental and inherent in C, that
you can't just warn when people use it in contexts where sign really
doesn't matter.

                 Linus
