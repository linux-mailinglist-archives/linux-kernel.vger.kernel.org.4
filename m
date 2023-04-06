Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB16D987D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjDFNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjDFNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:45:08 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FAB59CD;
        Thu,  6 Apr 2023 06:45:06 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m16so25849929ybk.0;
        Thu, 06 Apr 2023 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680788705; x=1683380705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KhgXC9DXFmj1WgtxHdsXUKjqNnttjWFACOtfeQvRuo=;
        b=NfMWpbEiHyU83kdpf1M1hzSt71X9hawep43qeU5J/cVYOw7/vCuuyx+XObPcTgqPIT
         5uslXlk4gD/VtX9nuMHfMX/CO0fMXJM7SHuZvwU60/DhqDpmxxQ1T1o5co6wj4O5YFBd
         nooF1u4x2YK/H74ICeQEta7trx9kfKAVkU0JqdZIDxNQzObKq34NPTq+bNB/i+0yE6fn
         BugseBoTV20FJUlmU7Lm65F4MAFhKseB/QQS60kL/jC/cudtqpNPQ1AcwWAlapiIrB/q
         SQBU+lqmldR1pcejXSxtAZW0DBPe/cFRJIINapf0lst3/8gHKLiKmIOxJK/iD9Zjo0v6
         WuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788705; x=1683380705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KhgXC9DXFmj1WgtxHdsXUKjqNnttjWFACOtfeQvRuo=;
        b=YXy1zPCox2NaxPzbZy3KKuC59XaxN4+E6AzcgC63cf1kRxUTrJ1GxbcqRmjv/P4fob
         TR7ha62cOWUFxira2CpthIvRBFotz5VNWMVELCJf0cHH4f/Q+H6dYOZYtOxUxCKnYQjz
         ZWbrvNClKe/vy9lH8dmtns+EL/BTd09iIezJpMdcOGeeXOCw2T8u4vCHigHIS3LLnm16
         YeR/O3X0J4nakzsY/z6JzqvN4yHZ6zvVXg50vgWWuQrO4Y+q3Y4gab7p6xIpKPYCelpn
         wpUxV6pI4UlL/YM1z1/ZGjOSbdyy8I1Gwt+hiQXSSaQa9SXNXBmQExj2Ah6N8gB5KAy1
         VI7g==
X-Gm-Message-State: AAQBX9fDePBCvSVja7snf9pbb9SEk0spjwayDKZxqCJwZFueT70xYzfE
        B2PyAzrxRfiSPq9OH0eiEFErFHoqJvcrFihpGIs=
X-Google-Smtp-Source: AKy350ZZ+8HQ7o20RvPaIt6FEcp/i3sJxj4UVr1mQ9nJOcEP2zBMvW25I7hIgyNBWYjK4sAiFSvD/BkmcywJJWKvGwg=
X-Received: by 2002:a25:d603:0:b0:b21:5fb4:c6e6 with SMTP id
 n3-20020a25d603000000b00b215fb4c6e6mr1678180ybg.11.1680788705031; Thu, 06 Apr
 2023 06:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-6-keescook@chromium.org>
In-Reply-To: <20230406000212.3442647-6-keescook@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Apr 2023 15:44:54 +0200
Message-ID: <CANiq72=Awa4B1qL+Zdkuj1-EX+Tv=fK=pRM_DMdYCDmByEVOHg@mail.gmail.com>
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string pointer
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 2:02=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> +void __fortify_report(u8 reason);
> +void __fortify_panic(u8 reason) __cold __noreturn;

(snip)

> +void __fortify_report(u8 reason)

(snip)

> +void __fortify_panic(const u8 reason)

I am curious: for some reason (no pun intended :) the `reason`s above
are not `const` except this one, but then in a later patch they become
`const` (including the declarations).

So perhaps make everything `const` when they are introduced? Or is
there some other reason? (e.g. I saw one patch that moved a function,
so there it seemed to make sense to keep things as they are to make
the copy 1:1).

Cheers,
Miguel
