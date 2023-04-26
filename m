Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764896EFD28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjDZWcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:32:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFF35A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:32:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f6c285d22so1451700266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682548318; x=1685140318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVW5WV/KqwfqyBwNIu5H8m6OJfcQGZ/T7DvmWxmWHzc=;
        b=SK5WhvdhD+pFQAgeMnn+cxG4NVGIZi8UCWzoAoYEwd6MfKAHL4hGv9hryJHO6lbFKN
         3cNxiSH2NXz4vM4JDhm5QzJ8OtcUhZ8mZnUNXxzsxaOZmI40cIb6uVQ2OP4uhSsgnZ/5
         EkWDO8usQILfZAod62VsNHOEm6mbdk3qQCioM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682548318; x=1685140318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVW5WV/KqwfqyBwNIu5H8m6OJfcQGZ/T7DvmWxmWHzc=;
        b=T+MK4Mg8yrgTajUcGtg4IJ/ONwDRt9mDdjwePKkMxEI8+1GTuuIw/OUoyOlUeOptkH
         S5aBGzWumrqLEUSLfoU0M9IuqRvGllkily+R7Xv84oqfpDxuFrWeSGnQJ383WEFqqZOc
         FYJ79M2X88S4of5Y9tdf4TfYZG9FXhQiSAd+KvcW7MFiF9+ob0MIkPGxe/bbstoM1DYz
         lFn97CMcWN1KRG0oiyi5v5o+IMMJJlKj0VyZYTrqPmItyQWYAHKP7wehJ+t0g7uuggbK
         hPuxV7Tldu+NQAujVZ7MvIio3Olb0JBfU7jQASIQNitePsRTmWOl3sKqdGu50T/losiP
         1xpA==
X-Gm-Message-State: AAQBX9csuDLZKdeizbxAXuGHaAVfy4chH065kpx70HlCnaL1IvSjL+XK
        xeHTGa8bYCx8z8MgvXv2dspR+p9B5fHCPf66vFoUMA==
X-Google-Smtp-Source: AKy350YtI1ccknRKXEIA/S787KNWtmsqhsQzfNafE9Au4YXLiMGJLBx5dWHTjXNbf4vRxvCL+kRIng==
X-Received: by 2002:a17:907:c001:b0:94f:449e:75db with SMTP id ss1-20020a170907c00100b0094f449e75dbmr21288731ejc.52.1682548318645;
        Wed, 26 Apr 2023 15:31:58 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906338f00b0094c3ac3c2bbsm8783477eja.212.2023.04.26.15.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 15:31:57 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-505035e3368so13407118a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:31:57 -0700 (PDT)
X-Received: by 2002:a17:906:224d:b0:94f:3eca:ab05 with SMTP id
 13-20020a170906224d00b0094f3ecaab05mr21379641ejr.59.1682548317009; Wed, 26
 Apr 2023 15:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
 <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
 <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com> <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
In-Reply-To: <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 15:31:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_=4EXm_FMYETDo-aETdWPBvJ0_bv+GaOMz2bu8UoWxA@mail.gmail.com>
Message-ID: <CAHk-=wi_=4EXm_FMYETDo-aETdWPBvJ0_bv+GaOMz2bu8UoWxA@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Wed, Apr 26, 2023 at 3:08=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Is this what you had in mind?
> ```
> void * _Nonnull foo (void)
> ...
> void bar (void) {
>     if (foo() =3D=3D NULL) // maybe should warn that foo() returns _Nonnu=
ll?
>         bar();
> ...
> linus.c:8:15: warning: comparison of _Nonnull function call 'foo'
> equal to a null pointer is always false

Yes.

HOWEVER.

I suspect you will find that it gets complicated for more indirect
uses, and that may be why people have punted on this.

For example, let's say that you instead have

   void *bar(void) { return foo(); }

and 'bar()' gets inlined.

The obvious reaction to that is "ok, clearly the result is still
_Nonnull, and should warn if it is tested.

But that obvious reaction is actually completely wrong, because it may
be that the real code looks something like

   void *bar(void) {
#if CONFIG_XYZ
    if (somecondition) return NULL;
#endif
    return foo(); }

and the caller really *should* check for NULL - it's just that the
compiler never saw that case.

So only testing the direct return value of a function should warn.

And even that "direct return value" is not trivial. What happens if
you have something like this:

   void bar(void) { do_something(foo()); }

and "do_something()" ends up being inlined - and checks for its
argument for being NULL? Again, that "test against NULL" may well be
absolutely required in that context - because *other* call-sites will
pass in pointers that might be NULL.

Now, I don't know how clang works internally, but I suspect based just
on the size of your patch that your patch would get all of this
horribly wrong.

So doing a naked

    void *ptr =3D foo();
    if (!ptr) ...

should warn.

But doing the exact same thing, except the test for NULL came in some
other context that just got inlined, cannot warn.

I _suspect_ that the reason clang does what it does is that this is
just very complicated to do well.

It sounds easy to a human, but ...

          Linus
