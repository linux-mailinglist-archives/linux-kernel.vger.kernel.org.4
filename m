Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D565E610034
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiJ0S2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiJ0S2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:28:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58157A522
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:28:31 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l28so1848166qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEdZOEYjrllCAot2dTAA4KX0CdNoEXMJ9BmzaOuDVdI=;
        b=T/yx4PJ4RHQPFV86A2BeP473agGj/WJk6zWc5l56IseidOqLDSaXwuFZkIocHU533Q
         Yqz3muzZsTyk8+MlpD0cvUoOsFqBfxZMuROtUtg57iTtb/5PSYiTdWosU7yAfnitmzIM
         28RHz7CU3/A6B1cqE3d5MA8RJ7WNWOjaLOxLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEdZOEYjrllCAot2dTAA4KX0CdNoEXMJ9BmzaOuDVdI=;
        b=4v4nP6mVrgAe2kPhP7FHJm2x1LyO1k+nWQIf8kjvRfhkDPI2U6EZD/G/393RAmn3yd
         jvABZ3aEcgsTFurU+FJnSM9u+tlnHaIKk0HIoc7UZkVS+Kvh6rIkwisGwZvhvsXf1RzB
         lAv8kaL8MFilLgL9kdUae2U0igipfj2DoCt5dLj96TtLzeZorXsc1KgXrCo/FFNgm9sS
         +rjBcthZ3rt8TUCrT8Z5+aY3mvc66csN3XN4GSiZNrV7OpFRjx38SFLu2RtvkrJGKzD5
         mLb46RYSa65NaxIz9p18QPpqYpXvClJ6yEyX1NWvjY2MP85VpIvgnouZxl9gyNBTq7xA
         6lsw==
X-Gm-Message-State: ACrzQf3E++2U7wSZpprsSLylI/cmAWsW0Gyin98zej5ikMi15ITNaWHR
        kpaRGYrExTZO2ebUuQVCC1uV/zkTa4bjdQ==
X-Google-Smtp-Source: AMsMyM4+XEqvd9diGVGchZ+8ndfoZBTjiYGIxXppdbGMC5B3A+pEb8i7Td0XngQFC326siR8vWgdOg==
X-Received: by 2002:ac8:5706:0:b0:39d:322:7c36 with SMTP id 6-20020ac85706000000b0039d03227c36mr36921791qtw.632.1666895300491;
        Thu, 27 Oct 2022 11:28:20 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a1a8c00b003a4cda52c95sm1251080qtc.63.2022.10.27.11.28.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 11:28:18 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 63so3254243ybq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:28:18 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:6ca:9345:b2ee with SMTP id
 c4-20020a5b0984000000b006ca9345b2eemr8266384ybq.362.1666895298062; Thu, 27
 Oct 2022 11:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
 <3a2fa7c1-2e31-0479-761f-9c189f8ed8c3@rasmusvillemoes.dk> <CAHk-=wg9RNhvDyanUQnxa_xnir70TUiMgjhVhRWUuF5Ojj96Dw@mail.gmail.com>
 <915a104b-0e70-dfb8-3c85-54fd1e5e63e5@rasmusvillemoes.dk>
In-Reply-To: <915a104b-0e70-dfb8-3c85-54fd1e5e63e5@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 11:28:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgadqCK7xAOzCdDHa7CQWC1z3df6a-pHQaF73ZjSZ58wg@mail.gmail.com>
Message-ID: <CAHk-=wgadqCK7xAOzCdDHa7CQWC1z3df6a-pHQaF73ZjSZ58wg@mail.gmail.com>
Subject: Re: make ctype ascii only? (was [PATCH] kbuild: treat char as always signed)
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Thu, Oct 27, 2022 at 12:59 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> AFAICT, the differences are:
>
> - 0xaa (FEMININE ORDINAL INDICATOR), 0xb5 (MICRO SIGN), 0xba (FEMININE
> ORDINAL INDICATOR) should be lower (hence alpha and alnum), not punct.
>
> - depending a little on just exactly what one wants latin1 to mean, but
> if it does mean "first 256 codepoints of Unicode", 0x80-0x9f should be cntrl
>
> - for some reason at least glibc seems to classify 0xa0 as punctuation
> and not space (hence also as isgraph)
>
> - 0xdf and 0xff are correctly classified as lower, but since they don't
> have upper-case versions (at least not any that are representable in
> latin1), correct toupper() behaviour is to return them unchanged, but we
> just subtract 0x20, so 0xff becomes 0xdf which isn't isupper() and 0xdf
> becomes something that isn't even isalpha().

Heh.

Honestly, I don't think we should care at all.

For the byte range 128-255, anybody who uses ctype on them gets what
they get. In the kernel, the most likely use of it is for 'isprint()',
and if those care, they can (and some do) use 'isascii()' in addition.

I don't know if you realize, but the kernel already says "screw libc",
and makes all the isxyz() things just cast the argument to 'unsigned
char', and doesn't care about EOF.

And for the rest, let's just call it the "kernel locale", and just
admit that the kernel locale is entirely historical.

Boom - problem solved, and it's entirely standards conformant (apart
possibly from the EOF case, I think that is marked as a "lower case
character" right now ;)

Looking through

    https://pubs.opengroup.org/onlinepubs/9699919799/

I'm not actually seeing anything that says that we don't do *exactly*
what the standard requires.

You thinking that the kernel locale is US-ASCII is just wrong.

              Linus
