Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9386C38F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCUSLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCUSLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:11:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4964D42C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:11:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e21so3857930ljn.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679422273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7SLq5regHpbyQXTIDtK1SgaDzSaRkQ8eVCIyS1gzK4=;
        b=Ir56PUvfE5P8xAmbSzdyQ++ini5dtdhU3y0B/4u/Muu1HkvECffUm7gSTsUeePAICQ
         LxUqSnsOGQ6TvAX6S0GB0CeH2vc3eCgaTpooDzUkk00Wh17ZSWEWnwELKzKrBIarmA+7
         CfgUQH/lsf3cTUzCT5RhBcmM+kD04M6qdwLX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7SLq5regHpbyQXTIDtK1SgaDzSaRkQ8eVCIyS1gzK4=;
        b=Q3s3CIaeoNjHK50wKSNx87zeU7qV91DG0q6ip/0Ld+svgvP8YWYOwSU66+fN7IufQB
         uAHgLqBYJwHR3Kq/rAff0tgFNAXcWrcq36FKk0YIqjaShShHQSztLUFBZgbpHvyrbDtL
         8ZRTdgNcVgCZh/FJ9sBSEnEBtz3oUw6N20wm4BJLVsvRs7wAEKdhHt1/YlhMFftofbws
         twCo3RHebWMCN5l91H3gHtrGmy1IQ7mRCaLki32G4SI3/GG4sQ5KLxS/lbI/hCXfr840
         brzWq/3br9Goue5GcRqVQehCxf4ABFhO2v2gj49RFU75g8Pr26hnkNhr6djzgSfrVPRf
         WOig==
X-Gm-Message-State: AO0yUKXwmOASz8T8AK/KiaOMYfhGK8WGkOijxrm66NYB5oRvzgWaHdKT
        3Z/Up3Ls81dR3J3qmBryDUYxNHXdHBSqko4wF6G9jg==
X-Google-Smtp-Source: AK7set++rBqofAzNm9tMeIuOYMSliGCANQT/AB2qL6IJJAO4gYQ1nPCcG+VuCOmXklIJuYgIU7uCEQ==
X-Received: by 2002:a2e:a16b:0:b0:295:9074:7c4c with SMTP id u11-20020a2ea16b000000b0029590747c4cmr1328411ljl.45.1679422273481;
        Tue, 21 Mar 2023 11:11:13 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9c52000000b002934b5d6a61sm2325544ljj.121.2023.03.21.11.11.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:11:13 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id t14so16442655ljd.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:11:13 -0700 (PDT)
X-Received: by 2002:a17:906:6d6:b0:933:f6e8:26d9 with SMTP id
 v22-20020a17090606d600b00933f6e826d9mr1718588ejb.15.1679421883223; Tue, 21
 Mar 2023 11:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230321122514.1743889-1-mark.rutland@arm.com> <20230321122514.1743889-2-mark.rutland@arm.com>
In-Reply-To: <20230321122514.1743889-2-mark.rutland@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 11:04:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgknoR11b+mX=AP8TcHP+gsFGdhPk7sJPROaQBBsqdubw@mail.gmail.com>
Message-ID: <CAHk-=wgknoR11b+mX=AP8TcHP+gsFGdhPk7sJPROaQBBsqdubw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] lib: test copy_{to,from}_user()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gor@linux.ibm.com, hca@linux.ibm.com, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robin.murphy@arm.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 5:25=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> * arm64's copy_to_user() under-reports the number of bytes copied in
>   some cases, e.g.

So I think this is the ok case.

> * arm's copy_to_user() under-reports the number of bytes copied in some
>   cases, and both copy_to_user() and copy_from_user() don't guarantee
>   that at least a single byte is copied when a partial copy is possible,

Again, this is ok historically.

> * i386's copy_from_user does not guarantee that at least a single byte
>   is copied when a partial copit is possible, e.g.
>
>   | too few bytes consumed (offset=3D4093, size=3D8, ret=3D8)

And here's the real example of "we've always done this optimization".
The exact details have differed, but the i386 case is the really
really traditional one: it does word-at-a-time copies, and does *not*
try to fall back to byte-wise copies. Never has.

> * riscv's copy_to_user() and copy_from_user() don't guarantee that at
>   least a single byte is copied when a partial copy is possible, e.g.
>
>   | too few bytes consumed (offset=3D4095, size=3D2, ret=3D2)

Yup. This is all the same "we've never forced byte-at-a-time copies"

> * s390 passes all tests
>
> * sparc's copy_from_user() over-reports the number of bbytes copied in
>   some caes, e.g.

So this case I think this is wrong, and an outright bug. That can
cause people to think that uninitialized data is initialized, and leak
sensitive information.

> * x86_64 passes all tests

I suspect your testing is flawed due to being too limited, and x86-64
having multiple different copying routines.

Yes, at some point we made everything be quite careful with
"handle_tail" etc, but we end up still having things that fail early,
and fail hard.

At a minimum, at least unsafe_copy_to_user() will fault and not do the
"fill to the very last byte" case. Of course, that doesn't return a
partial length (it only has a "fail" case), but it's an example of
this whole thing where we haven't really been byte-exact when doing
copies.

So again, I get the feeling that these rules may make sense from a
validation standpoint, but I'm not 100% sure we should generally have
to be this careful.

                 Linus
