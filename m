Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2900C73BF04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjFWTm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:42:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BB926AD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:42:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f957a45b10so1318253e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687549374; x=1690141374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wdhEOrgOZS0VHWCXopCTQVZ8iR8/A4ovcmZxgGyQc70=;
        b=AgIGLHx0Tc8NcrX+2I5APMSkSsXEKIDDjezMUa+Y3cRz0jU6AsEi7Toys6fErxUFQO
         o8zNWFgtZm2NJ1sW8NFn6jyTE8KDNf392P0RY1BcAncBKStQlWWlwfdMbDefF66uv6FM
         Ld4EEEvrbOxR3pMUdyAYiUpjnatovRO6bbxkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687549374; x=1690141374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdhEOrgOZS0VHWCXopCTQVZ8iR8/A4ovcmZxgGyQc70=;
        b=huLbHoIiYVLkh37lUsXQfC6X3AyZ0vpTLM8WImnJK4G8U7CDKafDuNZOgKYCz5dV8L
         uOoZbOExLEb+RiqBQcjmxjaOpfeyXfaewLogXxtdB2Pi+iWsKiSprOTjhf7dsiY7b1BM
         q255n5LBEO7w8tJ65ZcGZvnXMWWtC6pBiO+94oD5sJgrIja2aM8dEwZJSV5wLfiDfzO1
         r8MpEs3SIkx0iV+Xuomp6P2UMYkS2Id2VU4Onbt5AVVCkwAnai0uhqg/s47imJrfDTb4
         GLJH5h+cCSNBnz2IdktVi0untM5hYkiuIHFBqvIFL6JCtCq6qKKO4lNqY6h6s+ExoSB2
         79dg==
X-Gm-Message-State: AC+VfDw4jw3lFn6tDDHUJ58a61QC2fudebBp82+C5QZv9kIY/N9fHHNc
        X51cS+JW8Zg3ArMSTjn4UZlbewHqwrWcf70k2j7jrmbQ
X-Google-Smtp-Source: ACHHUZ7BE02MchtvIW+OPJN4cxXWhBfD1MjORsiL2OgkZK24c0wUbIxIwa1i0cwAqZTVNse9u4z2Ww==
X-Received: by 2002:a05:6512:e95:b0:4f9:766d:f04f with SMTP id bi21-20020a0565120e9500b004f9766df04fmr359848lfb.51.1687549373933;
        Fri, 23 Jun 2023 12:42:53 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x13-20020a19f60d000000b004f14ae5ded8sm9166lfe.28.2023.06.23.12.42.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 12:42:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b479d53d48so17922301fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:42:52 -0700 (PDT)
X-Received: by 2002:a19:3844:0:b0:4f8:71bf:a25b with SMTP id
 d4-20020a193844000000b004f871bfa25bmr9757927lfj.9.1687549372011; Fri, 23 Jun
 2023 12:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <CAHk-=wg9p+oJtzC0582vke8whcWPNSC9eq0Z6kdnSqWMEpah7g@mail.gmail.com> <37e7ef6d-3a92-42ab-a949-59c18bccc510@app.fastmail.com>
In-Reply-To: <37e7ef6d-3a92-42ab-a949-59c18bccc510@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 12:42:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiUo0KOMGbrz2uOq9HzRh9HYXZrOC_CzwQRQ5AE5V7cw@mail.gmail.com>
Message-ID: <CAHk-=wiiUo0KOMGbrz2uOq9HzRh9HYXZrOC_CzwQRQ5AE5V7cw@mail.gmail.com>
Subject: Re: arm32 build warnings in workqueue.c
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dave Airlie <airlied@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 12:22, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The short explanation of the change is that with the previous
> gcc and clang behavior, the type of 'enum foo' would be determined
> separately from the type of each individual constant, while the
> new behavior in gcc-13 makes them all have the same type.

Oh, I actually thought that gcc already did the new behavior long ago.
It's the only sane one. Enums should all have the same type, that's
the whole point of it.

But it explains why the warning only showed up on 32-bit, where the
enum presumably ended up as 'long long', which is the same size as a
pointer on 64-bit (so no complaint), but not on 32-bit.

Anyway, our kernel code was disgusting, and apparently relied on that
horrendously wrong model of enum types.

              Linus
