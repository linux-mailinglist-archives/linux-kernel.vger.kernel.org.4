Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4070CB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjEVUx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjEVUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:53:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0062394
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:53:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1b2so136163a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684788834; x=1687380834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjFiaAyyUPn24JpVGKlDTYxHPCznWZQYPuLLDc5JWRE=;
        b=JJHvNKYfFmOdtSSqY26MYHO4Cl/LCHNyHVaLqux9+UU9oIE3AJ13OJ8NBoel+8VH43
         wEP8LzJTekBFH7uBKQ/u5gFTyMsBHazaxxTMtKUzs4RCn6qbiowbI0DZ3lxHBWR67W+M
         Ov1kSnv67Xp7o+kgnsdPqa6g5GkwnEuGPRKVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788834; x=1687380834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjFiaAyyUPn24JpVGKlDTYxHPCznWZQYPuLLDc5JWRE=;
        b=eID1CtPsSoO+MuzceD75RndDtoZJ7ncFYBcrDFNYgVGxQ8D+R+W2jKCv3MQnppOW0y
         Y71KbfYKw8JAOdZ2rFTbtrNbO9ENsCGeF/a2iddM7If4vAW8EjLnNdNVs76fEOCCEfp6
         5B0SlUmgD2xSpQaAWR5p2tfgSs9TNN0sQeyhgvOPn88EHlle1uUrUzwGL2nKT4QHukjd
         uOo4LxCfyifR6epl53BxW0BkItOILsCeV+dfFxAJk+r22JoJ/pLowHqzxWAo5i8fbmwP
         xi930ZaV74ogeogw1ZzDsdXAnuRgiRu/UGaPKF18Qn6n9h07YaD6/dX737Kq3kxkvCXR
         sQhA==
X-Gm-Message-State: AC+VfDz3sS5c7QtxPFgtCtdfj5RfRUDvpv3PASxdMsw+OPGHiVOpoX7F
        afA6O8p+BBPqhT3WsL9fBz5RAoy0ZppE9w4GwWFoJEG2
X-Google-Smtp-Source: ACHHUZ46TUK4GfAelOUiamxA3kBYUOTo9uAreHkjZi+PWJoUWELCdkfs0xEAoSD4tU0w4WQ5NX4MkA==
X-Received: by 2002:a05:6402:164b:b0:50b:caf9:4b85 with SMTP id s11-20020a056402164b00b0050bcaf94b85mr9259022edx.18.1684788834357;
        Mon, 22 May 2023 13:53:54 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id z12-20020a50cd0c000000b00510da8aa2c6sm3495296edi.69.2023.05.22.13.53.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 13:53:53 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-510b6a24946so167456a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:53:53 -0700 (PDT)
X-Received: by 2002:a05:6402:7cf:b0:510:f462:fc47 with SMTP id
 u15-20020a05640207cf00b00510f462fc47mr7701468edy.7.1684788833330; Mon, 22 May
 2023 13:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230522171314.1953699-1-kent.overstreet@linux.dev>
 <CAHk-=wi3vkmsiEDF=kYSAV2f1e1B6J6L-oikmdik6p_kBq_dhg@mail.gmail.com> <ZGvM2nqmft0IbB2U@moria.home.lan>
In-Reply-To: <ZGvM2nqmft0IbB2U@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 13:53:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxN65O-F3R5detmma2MDjDRn4S_qkeKVCCp95c5+gYmA@mail.gmail.com>
Message-ID: <CAHk-=wgxN65O-F3R5detmma2MDjDRn4S_qkeKVCCp95c5+gYmA@mail.gmail.com>
Subject: Re: [PATCH v2] locking: SIX locks (shared/intent/exclusive)
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 1:13=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> Uh, I think you're wrong on this one - structs with designated
> initializers have unspecified fields initialized to 0

That's definitely true for unspecified fields.

But there *are* no fields. Only padding.

That said, gcc does seem to always initialize the whole thing. We even
rely on it when it comes to structures, but I'm not sure it's strictly
standardized - and I'm particularly not sure about unions.

But there are counter-examples, like this:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D104607

so maybe even structures aren't always initialized fully?

Anyway, I *really* don't want locking to have something that isn't
obviously true. And it's not obviously true what the union behavior
is.

> I would
> expect the same to hold for unions, and the language in the C standard
> isn't completely explicit but it appears to apply to both.

Only the named member (or, if no name, first) of a union is
initialized, not all members. The rest is padding that may or may not
be initialized depending on how you read the standard.

> And checking the generated assembly for a six_set_nospin() that calls a
> six_set_bitmask() with the test_bit() taken out, for simplicity

Random compiler issue, *and* you're testing on a little-endian
platform that wouldn't show the issue anyway.

> meaning the compiler properly constant-propagated and didn't read
> uninitialized memory.

Again, that only works because it's little-endian, so the low bits of
"vlong" are the same as the low bits of "v32".

Which is not true on BE.

On BE, it *might* work, because who knows what the compiler does for
the padding bytes, but again, it's broken.

It also doesn't even *matter*, because the initialization is only
*one* of the multiple problems here:

> > You *cannot* do "set_bit()" on a u32. It's that simple. Stop trying to
> > do it with these wrappers that happen to work on x86 but are
> > fundamentally broken.
>
> Because of aliasing issues? I thought it had been declared that the
> kernel would never do strict aliasing.

No, Because of *alignment* issues.

An u32 is 4-byte aligned. But "set_bit()" requires "long" alignmnent,.

Again, that doesn't happen to matter on x86, at least when the
"set_bit()" ends up being done as an "orb".

But it will basically not work on other acrchitectures.

You really can't just randomly cast pointers in locking code and think
it makes things ok just because the compiler doesn't complain.

There's a *reason* that "set_bit()" takes a "long *" value, not a
"void *" value. It's literally part of the semantics of the thing, and
a cast does not make things magically ok.

So STOP DOING THOSE UNION TRICKS.

They aren't the "cure trick" you seem to think they are.

They are only broken garbage.

                 Linus
