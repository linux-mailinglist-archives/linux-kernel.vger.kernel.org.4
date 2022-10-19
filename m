Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F182605084
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJSTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJSTgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:36:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2184E1C2E8E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:36:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x13so11412573qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oJrk5u73GSSntjHDSFWZPm3W+d2NptLnsl4jnQ6aTBs=;
        b=dyDRWkQ5VqKw/n/QUOQkovOpnXZICQosgvfGHTMEB24PTjukMWkEQb6WiGZ3AaswEh
         VYAjmCHm81UDyKGwrRTK4pqVsKdfk4eywGlq59bCDPl2XFFHJiWrSIA1mEV0BH0Um7H8
         GojY9blG/jEQqPFxqq14doFT4faiTGwkuzpcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJrk5u73GSSntjHDSFWZPm3W+d2NptLnsl4jnQ6aTBs=;
        b=euwiK6yvB/0xmEm9FMzUZ62rnBK+Tl9o9m/2RtbJIj9r7A+89BARIUbdFYHZ743aY4
         XfkMIWBueVNzp+M3/87PgQ12V8YuKzY1c5IZyAKSnnWMSYcQaLUPmc/SJx2VJcO8OsNR
         FKcwVAgPzMCGAJFB5yT35bSq7suB5oR4UrNI2NwKOIOtwxYzPctYDktGwaFLMXouNcen
         NRpAQ4s01h7qavIAsginpgkdlplgixo2AZv8htQx+mXrWmr5wtvhaxgBGqEbtVGSgeRh
         qMzypk+iorWFq6vV3bbeG5YW6SQqkauOHhCr9Q7fOnQs/gxqsaAg7EK7QrKd+/0oJOa3
         5GJg==
X-Gm-Message-State: ACrzQf30Qul1nmnXEJrvHhnfToX3mQhyQwCZIWG14E+Pfr/+y+N8ZkS8
        7nq4N0DvOuKriFATWsAvBoJOj1Jn4cfBew==
X-Google-Smtp-Source: AMsMyM4A7CMO6Dxp0UFV7Sv64+mzqk4vD/ddX9tVIhyyEsP9bzVL9SSZvY+4ISk9clzofWr1nHqPQw==
X-Received: by 2002:a05:620a:2947:b0:6ee:88c9:bcdc with SMTP id n7-20020a05620a294700b006ee88c9bcdcmr6831811qkp.143.1666208180019;
        Wed, 19 Oct 2022 12:36:20 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a248800b006bb0f9b89cfsm5795724qkn.87.2022.10.19.12.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 12:36:17 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-354c7abf786so178574087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:36:17 -0700 (PDT)
X-Received: by 2002:a81:1007:0:b0:357:45e3:304c with SMTP id
 7-20020a811007000000b0035745e3304cmr8223552ywq.340.1666208177358; Wed, 19 Oct
 2022 12:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com>
 <CAKwvOdmDz2VfU1JJkAEnPLTcx4PHH48KfZQfW6gvO6we_QbrRQ@mail.gmail.com>
 <CAHk-=wimUGWN6WuQ8q5Mba2jgG2FPEvp-TEoGR3k5rEekQ2wNg@mail.gmail.com> <Y1BOtMpS5KtL4blg@smile.fi.intel.com>
In-Reply-To: <Y1BOtMpS5KtL4blg@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 12:36:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoH_rZiv84-53dGF5btC-1FPZc9nFJM=48NVAmR1p7Sw@mail.gmail.com>
Message-ID: <CAHk-=wgoH_rZiv84-53dGF5btC-1FPZc9nFJM=48NVAmR1p7Sw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Oct 19, 2022 at 12:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > We do have a couple of signed bitfields in the kernel, but they are
> > unusual enough that it's actually a good thing that sparse just made
> > people be explicit about it.
>
> At least drivers/media/usb/msi2500/msi2500.c:289 can be converted
> to use sign_extend32() I believe.

Heh. I didn't even look at that one - I did check that yeah, the MIPS
ones made sense (I say "ones", because while my grep pattern only
finds one, there are several others that have spacing that just made
my grep miss them).

You're right, that msi2500 use is a very odd use of bitfields for just
sign extension.

That's hilariously odd code, but not exactly wrong. And using "signed
int x:14" does make it very explicit that the bitfield wants that
sign.

And that code does actually have a fair number of comments to explain
each step, so I think it's all ok. Strange, but ok.

                  Linus
