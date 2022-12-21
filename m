Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235265348D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLURHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiLURHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:07:02 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE8A19033
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:07:00 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3b56782b3f6so219376687b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYOKcpVH/CwZxAmDD07aAMcukw6jGJ7fZk2tWZQJ5Co=;
        b=EmYCuGZi1aBhi0+7PLOQjdb/1nrr3I38sgxXNpnj2Ob5gPWVW+wHeaOB0rT2rW9ia1
         2eC+kMDfVwn1Aw6vUx9l+Y+mROuW36ElXsnZxVtkTOtX3gWfd+EaTqrQgaKdEDoFyGkW
         RPvMC8bGtPA+mM+/6Yrg5RydYu4wMK+vVcANc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYOKcpVH/CwZxAmDD07aAMcukw6jGJ7fZk2tWZQJ5Co=;
        b=VytoVCVPv3jaqLLWyZH6637dWJVm+q3Q+luuphgYdgkgdMIJZEf+UAXyduhezxa9+c
         X3ZWALo2H4O8Tb4F4hFpGZXGz95C6B/Om7w27MGphTdtysf6T3SALb6re+VoRVcEQsCD
         MSX2rBf8vRv1mRNSNk6BqQO5x7otmWXDMXyRrdHG+DjZyd1sozXQYmPpGpz40ETsxhR8
         zY9V5TYjGjMaMqULlpdKcDWVFs3X/aTUsNfq2et4UV2koLy4vOTDgxR23kFEHkAtC/rX
         hLyeSJCY4uoOdCgmuOnBqc5A8sv5OjnOQvGULa4/QbNaNWeh6+QLRkr7HWwqCT7si4U8
         2biA==
X-Gm-Message-State: AFqh2kpeqZUkw63D7rHHuYPc821uJfw01lEqmpYwf1VQh8trGInZuYca
        XPbCCle1cEDmb7CfocYbNMI2rh2le1owINRX
X-Google-Smtp-Source: AMrXdXsXH1fXd7nXzUUSEIzRNdr664Td37p45wQbAMvloDGC47cOMz0R1Ry6YcfV7aOND9jkv2/eug==
X-Received: by 2002:a05:7500:3e13:b0:ea:6f63:ae0e with SMTP id lh19-20020a0575003e1300b000ea6f63ae0emr229172gab.74.1671642419583;
        Wed, 21 Dec 2022 09:06:59 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006f87d28ea3asm11167076qkp.54.2022.12.21.09.06.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 09:06:58 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id z17so7060807qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:06:58 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr84873qkg.594.1671642417917; Wed, 21 Dec
 2022 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net> <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk> <20221221155641.GB2468105@roeck-us.net>
In-Reply-To: <20221221155641.GB2468105@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Dec 2022 09:06:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
Message-ID: <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org
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

On Wed, Dec 21, 2022 at 7:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The above assumes an unsigned char as input to strcmp(). I consider that
> a hypothetical problem because "comparing" strings with upper bits
> set doesn't really make sense in practice (How does one compare G=C3=BCnt=
er
> against Gunter ? And how about G=C7=96nter ?). On the other side, the pro=
blem
> observed here is real and immediate.

POSIX does actually specify "G=C3=BCnter" vs "Gunter".

The way strcmp is supposed to work is to return the sign of the
difference between the byte values ("unsigned char").

But that sign has to be computed in 'int', not in 'signed char'.

So yes, the m68k implementation is broken regardless, but with a
signed char it just happened to work for the US-ASCII case that the
crypto case tested.

I think the real fix is to just remove that broken implementation
entirely, and rely on the generic one.

I'll commit that, and see what happens.

               Linus
