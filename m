Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAE26C5159
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCVQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCVQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:56:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3230303C7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:56:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so75662705edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679504177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObydWNcsN+yJjQR232+qhKPgXiEW95d36vBjFwkTd3w=;
        b=IoYIuv0c74xAIGn1TWP8KV8wy2ZYjqP4mF3RLvlNIIbOTqOjdOkmYyjwsZnaGRbg4A
         m19AquLYmi1k8VkbzLpHZBZ+ljhlWVTj0tZD2HlmTsvzdLy5BM1XHLNfxXqEzmPYOrDR
         eOSJCYmb9Pun6t3MCm3bnoGxKDwy8dLuPyrOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObydWNcsN+yJjQR232+qhKPgXiEW95d36vBjFwkTd3w=;
        b=KQn8u2JSSX6uwQn1NCZ3yt/DaelZhsmtDySjZ1i1RQTJnrWfETSMIBTqajinbv4ZUm
         PVaBEfV2I2sAc+y74ICMxH6wXfnBCFo0rYunJK9aIZPLiovHM+JdPSeTLvEH7Du5SDtt
         jzDzhlng+mO5LtmuPwblvsTgLne4jERsUbG4MDQNSZLjVskY7kibAWPHkSg7U2TYCBun
         l5efXm52QsaGJJVsb18yp3F6CjhUnBMQBI9duiSEMq5NP09Jf2qoyPmZ3beVoq4C2+g5
         d+iuQGx1alNIjQ3QcZ3ba3pJn9xJodJE/LilKlzj9Sfb307AjbV8EyOpYilWUBaZWMjr
         GkKg==
X-Gm-Message-State: AO0yUKU4i5JeOmCrSayDFSQn2PhfSkx7ySdbF/og1wz4mUrcdcJkv5yY
        cXt6/yvRhZ+y4EKUQzuCf1s6cCcydRL3d4uDaDBWKNti
X-Google-Smtp-Source: AK7set/HD24z7dmR4t5g8ozDgMMBeSLNaj1wahVaqq8RZbeRZozyY4/ZJHyEpWmvg1Je8bDoQ1ifGw==
X-Received: by 2002:a17:907:2090:b0:921:7e42:2777 with SMTP id pv16-20020a170907209000b009217e422777mr9283272ejb.69.1679504177216;
        Wed, 22 Mar 2023 09:56:17 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id t25-20020a170906065900b00939a61113d3sm2701646ejb.110.2023.03.22.09.56.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:56:16 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id cn12so29998229edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:56:15 -0700 (PDT)
X-Received: by 2002:a17:906:6d6:b0:933:f6e8:26d9 with SMTP id
 v22-20020a17090606d600b00933f6e826d9mr3542731ejb.15.1679504175429; Wed, 22
 Mar 2023 09:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X> <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
 <20230320185337.GA615556@dev-arch.thelio-3990X> <87pm91uf9c.fsf@kernel.org> <CA+icZUUYyqhV2HFzVtpi_KjBoYxjk7OB0UBVd2mX6abjmYhDjg@mail.gmail.com>
In-Reply-To: <CA+icZUUYyqhV2HFzVtpi_KjBoYxjk7OB0UBVd2mX6abjmYhDjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Mar 2023 09:55:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdrvCkSWh=BRrwZwNo3=yLBXXM88NGx8VEpP1VTgmkyQ@mail.gmail.com>
Message-ID: <CAHk-=whdrvCkSWh=BRrwZwNo3=yLBXXM88NGx8VEpP1VTgmkyQ@mail.gmail.com>
Subject: Re: Linux 6.3-rc3
To:     sedat.dilek@gmail.com
Cc:     Kalle Valo <kvalo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-toolchains@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 9:40=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> You have to pass `make LLVM=3D1` in any case... to `oldconfig` or when
> adding any MAKEFLAGS like -j${number-of-available-cpus}.

I actually think we should look (again) at just making the compiler
choice (and the prefix) be a Kconfig option.

That would simplify *so* many use cases.

It used to be that gcc was "THE compiler" and anything else was just
an odd toy special case, but that's clearly not true any more.

So it would be lovely to make the kernel choice a Kconfig choice - so
you'd set it only at config time, and then after that a kernel build
wouldn't need special flags any more, and you'd never need to play
games with GNUmakefile or anything like that.

Yes, you'd still use environment variables (or make arguments) for
that initial Kconfig, but that's no different from the other
environment variables we already have, like KCONFIG_SEED that kconfig
uses internally, but also things like "$(ARCH)" that we already use
*inside* the Kconfig files themselves.

I really dislike how you have to set ARCH and CROSS_COMPILE etc
externally, and can't just have them *in* the config file.

So when you do cross-compiles, right now you have to do something like

    make ARCH=3Di386 allmodconfig

to build the .config file, but then you have to *repeat* that
ARCH=3Di386 when you actually build things:

    make ARCH=3Di386

because the ARCH choice ends up being in the .config file, but the
makefiles themselves always take it from the environment.

There are good historical reasons for our behavior (and probably a
number of extant practical reasons too), but it's a bit annoying, and
it would be lovely if we could start moving away from this model.

            Linus
