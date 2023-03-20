Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268E76C25E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCTXn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCTXnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:43:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9799CC20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:43:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so53257780ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679355730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh9V5oLNl71ZE8wLJrHU90qn5FMul3QSy4jMGg+s0h4=;
        b=N4wVROOxKzQ4OoNcx8r5uTzsGb3CGCAyBDkN21Yg7Ibmi8awtnbTHYbFslExfamja/
         XTM1YvfD/UrKoD1ItfOmSDYXiKENfbGZQ5liaJggvBqVMf0Hs+UTvdbIxy95Kszei7pp
         Wo0DXOsYVQZLQVXcTOkM9muZUJt416sTmJ7z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh9V5oLNl71ZE8wLJrHU90qn5FMul3QSy4jMGg+s0h4=;
        b=R7dndEarCA+IgJjGYJL+bWDslLMOwWFoVI8rymhHI80xSxHCgEBnnX2ZJ9SilIB9FI
         M8EU37BnSG0wSynA96IWlXz1q70vCilRQxkQQg/2j4FZObrbboAaWQ1N+iivEQfa/4vd
         wIUgKvl3iHemcLNh+13jIACQrR6YwqbpkKUIqSfVg+yWScHcyXZFX85FT4TpfLFy6zZN
         ap72aoO58ZDm1Az3yYZ7OGBcl75ctCZBen662HrTpzPczB5xCJyWMd3GHYga07Tz9nKi
         /hpc7mxdczv77M5jC2uhR6nCwlmfnN7YERy7RQKKSMmbr+3Mzc2i2hOXMs3TWCPmeXc6
         DGUg==
X-Gm-Message-State: AO0yUKVTsahmJvBjQonQADCpVVYNWEU3IGjYPAzbnUALBeCYj2ngk19c
        bsTL7bH3immgpsISIi68QT1vOD/RE4MxLJpb02HfTWuf
X-Google-Smtp-Source: AK7set/4CATuHkGltX0UpZX3i1BiXDCFaWTl/twDFoMWzuZentxOBSke+IktDz69iH+k/B6dZop8YQ==
X-Received: by 2002:a17:906:2a57:b0:930:9f89:65ef with SMTP id k23-20020a1709062a5700b009309f8965efmr767210eje.11.1679355730503;
        Mon, 20 Mar 2023 16:42:10 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id h27-20020a17090634db00b00933f31034f2sm2241594ejb.38.2023.03.20.16.42.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 16:42:10 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id eg48so53177607edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:42:09 -0700 (PDT)
X-Received: by 2002:a17:906:13d3:b0:931:2bcd:ee00 with SMTP id
 g19-20020a17090613d300b009312bcdee00mr395674ejc.15.1679355729667; Mon, 20 Mar
 2023 16:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X> <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
 <4adbed5a-6f73-42ac-b7be-e12c764ae808@roeck-us.net> <CAHk-=wgyJREUR1WgfFmie5XVJnBLr1VPVbSibh1+Cq57Bh4Tag@mail.gmail.com>
 <20230320220631.GA637514@dev-arch.thelio-3990X>
In-Reply-To: <20230320220631.GA637514@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 16:41:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf82-im76ovESE2RZBh5=Y3uR1GDbae60=TWjM7OkLdA@mail.gmail.com>
Message-ID: <CAHk-=whf82-im76ovESE2RZBh5=Y3uR1GDbae60=TWjM7OkLdA@mail.gmail.com>
Subject: Re: Linux 6.3-rc3
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-toolchains@vger.kernel.org,
        llvm@lists.linux.dev
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

On Mon, Mar 20, 2023 at 3:06=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Right, this seems like a subtle difference in semantics between
> -Wuninitialized between clang and GCC.

I guess it's a bit ambiguous whether it's

 "X may be USED uninitialized"

or whether it is

 "X may BE uninitialized"

and then depending on how you see that ambiguity, the control flow matters.

In this case, there is absolutely no question that the variable is
uninitialized (since there is no write to it at all).

So it is very clearly and unambiguously uninitialized. And I do think
that as a result, "-Wuninitialized" should warn.

But at the same time, whether it is *used* or not depends on that
conditional, so I can see how it could be confusing and not be so
clear an unambiguous.

On the whole, I do wish that the logic would be "after dead code
removal, if some pseudo has no initializer, it should always warn,
regardless of any remaining dynamic conditoinals".

That "after dead code removal" might matter, because I could see where
config things (#ifdef's etc) would just remove the initialization of
some variable, and if the use is behind some static "if (0)", then
warning about it is all kinds of silly.

                     Linus
