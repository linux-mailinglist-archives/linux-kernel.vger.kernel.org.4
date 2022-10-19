Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC25604F87
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJSSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiJSSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:21:21 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4BB59717
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:21:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y72so20217100oia.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h1RcL8BPrrn0ZTMAZgdWymleKVlN0GVlF2LLrZfELFo=;
        b=FfoVpW9MKQr/IY4n02JjJbEh3PPjuWKUkQNWyKfLWg6Mm7D6GF2jkSWT1a9oPRh51Z
         Wed2BjOT3ZUQKsXj6kOMo3sIAm9dEPTKrK7GqcT+1L5v8L+fwtRrC88unTMpHnWJr/A0
         DnTjnpp1obnUbdnNcA9UZjol2Nd6zKbe/fonWgv2E+xgM04QeT1tJZ760kicMekHqMmb
         rIpR3bgauPdOGF0rTXy41v7v/lzaGeAW9IZEBvCWUEXz9lnO9btJxS86bnUC8SnsOpN2
         7ceVlVMdz+wWOpYdiMGQCP/9n/x2hDAvyySpHDfywp0l3kJyDVYQu3ziOkro9NBFiK2W
         o3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1RcL8BPrrn0ZTMAZgdWymleKVlN0GVlF2LLrZfELFo=;
        b=kowD/eKQX6JCFdtjDYIc07OahpXUcPJARyf8/uSi7k13gwUEHzWF6QrphXqACAkrNG
         k97prGXDAeX2SSbD2sUAv8hlMYtihvJREJ4jM+9BHVjx6AcOHGntA27DudJEbnOkMKMw
         4u+RmcYeP4/Y9BF9B7Xfl7EOd064ezjawClgWazfh+2mUXkLVVIgs0Z9NaaFVDbWMoCI
         L9TLHIrrl7BjaPLnC31XijsNQ2ZcCLVSBq4QL1VLFQ8C4NvICN3BdexVgmWAOZPn0t/q
         LLQ0gn+Sn73ho5kBH5fNqfd05gqvFnu+/L168N8A2xbWRU+E9XIYnQkBMPsb1bFHSylW
         mlNA==
X-Gm-Message-State: ACrzQf2OybxkUWgHF2C8p06y6Sycj7MkQ9s8rqvZIzKnDq6usKt4ig2m
        0KLTswAJC6udwwmPE/EdtHCjF/MDhYVTxPWLph3hEVAd670=
X-Google-Smtp-Source: AMsMyM4bao8KvMe6WMKZX/dIyc/1ffRx5FeiX3pdYV7oLVE9G7Aj8q9Nqbaj7wFgzoffi2e5BwnpIBcmPSgr2GmCzn8=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr46571979pjb.102.1666203669615; Wed, 19
 Oct 2022 11:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org> <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
In-Reply-To: <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Oct 2022 11:20:58 -0700
Message-ID: <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But while sparse does a lot of basic optimizations, it still left
> enough "look, you're doing sign-extensions on a 'char'" on the table
> that it warned about perfectly valid stuff.
>
> And maybe that's fundamentally hard.
>
> The "-Wpointer-sign" thing could probably be fairly easily improved,
> by just recognizing that things like 'strlen()' and friends do not
> care about the sign of 'char', and neither does a 'strcmp()' that only
> checks for equality (but if you check the *sign* of strcmp, it does
> matter).
>
> It's been some time since I last tried it, but at least from memory,
> it really was mostly the standard C string functions that caused
> almost all problems.  Your *own* functions you can just make sure the
> signedness is right, but it's really really annoying when you try to
> be careful about the byte signs, and the compiler starts complaining
> just because you want to use the bog-standard 'strlen()' function.
>
> And no, something like 'ustrlen()' with a hidden cast is just noise
> for a warning that really shouldn't exist.
>
> So some way to say 'this function really doesn't care about the sign
> of this pointer' (and having the compiler know that for the string
> functions it already knows about anyway) would probably make almost
> all problems with -Wsign-warning go away.
>
> Put another way: 'char *' is so fundamental and inherent in C, that
> you can't just warn when people use it in contexts where sign really
> doesn't matter.

A few times in the past, we've split a warning flag into a group so
that we could be more specific about distinct cases. Perhaps if
-Wpointer-sign was a group that implied -Wpointer-char-sign, then the
kernel could use -Wpointer-sign -Wno-pointer-char-sign.

I don't know if that's the right granularity though.
-- 
Thanks,
~Nick Desaulniers
