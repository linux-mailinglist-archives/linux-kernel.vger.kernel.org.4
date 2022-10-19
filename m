Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34E56050D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJSTyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJSTyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:54:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D57121
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:54:26 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso10144923otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSG5J/Jp19bLIoPO0PSW05M1FrVD5Y1lwTSpwfUz75M=;
        b=ZrWRNl/i7xLO3nCLpj86TANKjfrJc9VYQdyddvCNNDWkZjgWsynXIGYYloHFmBLkKo
         ZR9Y3xyXyLHydBorVZbvJSJonq7xYGlgjFoDKaaU/SmxYWVFgc92FuQ5ds//JqPJOM9o
         JGfjyqN/Ol18NKSuEY7LLTfvzFHs7HKX9e1iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSG5J/Jp19bLIoPO0PSW05M1FrVD5Y1lwTSpwfUz75M=;
        b=fLZwuDKgVdq3DtWRwcitjJlSRR3+iwZswF77/NUPiE4mpbwZb6gpARbquLKkV98WAW
         y5VXtRvRjIuXWj6FpeQFZ9gCRSHZYclbiyaZuPinOdK5BXrTiMLbVhvMFbg+sHcA2p7x
         qp/13bFZZYkAgbFJ457MDeAbsAdDfef7c0PZ3QCreQ1cxKqVeAYj7ylX2YnEASR5nQ2y
         rxEyOIQHazEt5KsBaPMQkFu4HyejT33gICt9JmRCs0pRyokqdvlc0h0OPoNk6UbmWUSz
         i9EtTujlKWtnfs3QQaLXYqzaGiELzq+wyx4w/dxNIKt4jueHqWyRcxjm4bfjI0uT3XBF
         eIug==
X-Gm-Message-State: ACrzQf18xIhg8Ibhc5amqE+XGOg4MDDFMiu0J9v4NCm5A0VYj94+Q+IL
        zhqlInK+OY9k3Pz4FwelANmfEzG2njVL8Q==
X-Google-Smtp-Source: AMsMyM5vcd6KDUgrhzrEFtuR0ADSnNwUt5smqFMeTSYFvQcbVIp/W0N2hJ3N9oGdHCFy/2ecRgi/6A==
X-Received: by 2002:a9d:2901:0:b0:661:c8d3:6b1e with SMTP id d1-20020a9d2901000000b00661c8d36b1emr4689331otb.229.1666209265069;
        Wed, 19 Oct 2022 12:54:25 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id r22-20020a056870581600b001324315bb6asm8187824oap.29.2022.10.19.12.54.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 12:54:23 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id r8-20020a056830120800b00661a0a236efso10140490otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:54:23 -0700 (PDT)
X-Received: by 2002:a05:6830:4408:b0:661:dfa1:f018 with SMTP id
 q8-20020a056830440800b00661dfa1f018mr4856482otv.69.1666209262824; Wed, 19 Oct
 2022 12:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com>
In-Reply-To: <20221019162648.3557490-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 12:54:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
Message-ID: <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Wed, Oct 19, 2022 at 9:27 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> So let's just eliminate this particular variety of heisensigned bugs
> entirely. Set `-fsigned-char` globally, so that gcc makes the type
> signed on all architectures.

Btw, I do wonder if we might actually be better off doing this - but
doing it the other way around.

IOW, make 'char' always UNsigned. Unlike the signed char thing, it
shouldn't generate any worse code on any common architecture.

And I do think that having odd architecture differences is generally a
bad idea, and making the language rules stricter to avoid differences
is a good thing.

Now, you did '-fsigned-char', because that's the "common default" in
an x86-centric world.

You are also right that people might think that "char" works like
"int", and that if you don't specify the sign, it's signed.

But those people are obviously wrong anyway, so it's not a very strong argu=
ment.

And from a kernel perspective, I do think that "treat char as a byte"
and making it be unsigned is in many ways the saner model. There's a
reason we use 'unsigned char' in a fair number of places.

So using '-funsigned-char' might not be a bad idea.

Hilariously (and by "hilariously", I obviously mean "NOT
hilariously"), it doesn't actually fix the warning for

   const unsigned char *c =3D "p";

which still complains about

   warning: pointer targets in initialization of =E2=80=98const unsigned ch=
ar
*=E2=80=99 from =E2=80=98char *=E2=80=99 differ in signedness

even when you've specified that 'char' should be unsigned with -funsigned-c=
har.

Because gcc actually tries to be helpful, and has (reasonably, from a
"type sanity" standpoint) decided that

   "The type char is always a distinct type from each of signed char
or unsigned char, even though its behavior is always just like one of
those two"

so using "-funsigned-char" gives us well-defined *behavior*, but
doesn't really help us with cleaning up our code.

I understand why gcc would want to make it clear that despite any
behavioral issues, "char" is *not* the same as "[un]signed char" in
general. But in this kind of use case, that warning is just pointless
and annoying.

Oh well. You *really* can't win this thing. The game is rigged like
some geeky carnival game.

              Linus
