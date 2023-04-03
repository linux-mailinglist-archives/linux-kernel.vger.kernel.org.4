Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94F36D4E05
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjDCQgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjDCQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:35:59 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0CA1722;
        Mon,  3 Apr 2023 09:35:57 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5491fa028adso66090837b3.10;
        Mon, 03 Apr 2023 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680539757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dArMv48Z0r8Svv1VMgzG7vSfoXEvpoovHL3ZA5F1Rw=;
        b=Gk/CsizFbvLI4ORGoNJJ7ovPQwr4iV3PWHd48GlCeZA4eeRa9oBDDOT3PidV2jcDsJ
         0YAXl4H0/oAe/uQ9eus8b0hrxOJVRGaW2ATmi4dWgMT46as8OTj1iqEHCY1shn9ew2DL
         36+47CtN8dXb/KaN5+DZrqset8QVBw5tGiWzLU/20SVFHvTUHBgaTcwrlO8VpXF9MYYp
         HgwOdjJ5nqgG332xm0ld6KUm1mDGDMfMwSMrDFvlXuYqsdID8NAAQSDr3GbvxDXUh631
         zo6ML+PKoREerwb7dp86tg9ihUuO45b78s1Yav6k0V/ZWUZHiU1swgIvhNg/Ww+VzpVd
         z0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dArMv48Z0r8Svv1VMgzG7vSfoXEvpoovHL3ZA5F1Rw=;
        b=s1vqbdL2YRXyqiu5myEHi4WUfbMMiCZPx3eyvpTiZ7mwTN1tFEZ7nPWw42JqmRIvL5
         HLPHhwRaguwkVZ4VLTS+aWMQNhIzO2i1fK6XGR7qA9u8OdA3vUh0sP7JJyWqTJBIgh+D
         snJlBC3c+0WkUEJCK3Qtxg+31l4+zUOsohEibpe9A+M5flyqUJBdloBslsbfP9CQxaum
         pY+gp/in/xTA123f9klY7uuvcq9g2GrO+jw3Y/sRhQgYtrgkSUoOBe0rd1f/Wiu+20+t
         fU7ickqRR0mn3QP12tEegyksEJ0lwpsPIIixt/Ya2m5D9nJJxi8jsVMOvUTvAySx1X6W
         J8bQ==
X-Gm-Message-State: AAQBX9cGnhKLSOVAfKQPeUXRBon2/neIf9DN3ff4kr2B+x19pk9mGvtA
        lGuF8wI/noViQlnxOVpcn7COTBrkgzXeTrQmA9M=
X-Google-Smtp-Source: AKy350aleZtSpwGhXEt7/aCxHFxm+jb9JLInxP02y7DKsDbn8FSITj4EbJK65VMViTBbz2Vu90d5UZgyDMar/StOsJ8=
X-Received: by 2002:a81:4406:0:b0:546:63a:6e23 with SMTP id
 r6-20020a814406000000b00546063a6e23mr13362258ywa.0.1680539756862; Mon, 03 Apr
 2023 09:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <CANiq72=i9je2864iTvZBFnhVLhF7Cema7EPCcdWOJ3mr62SqDg@mail.gmail.com>
 <a6220e52-9934-422b-9b05-95705b8fd684@spud> <b5fba6b3-177c-4325-905a-8f9f633a592a@spud>
In-Reply-To: <b5fba6b3-177c-4325-905a-8f9f633a592a@spud>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 3 Apr 2023 18:35:45 +0200
Message-ID: <CANiq72mip7Xs5vnS4KccxCmBmRbKGki7AYTTHxwaeyr3amvSWw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Thu, Mar 30, 2023 at 11:12=E2=80=AFAM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> I'd rather do this in the RISC-V Makefile so that it does not get
> forgotten.

Sounds good to me! We want to have the least amount of things possible
in the common pieces (e.g. for the target spec file we moved some
flags); so the more we move out to `arch/`, the better.

> If my understanding of bindgen is correct, we don't actually need to be
> honest to it about what extensions the rest of the kernel is compiled
> with, only make sure that it is not called with arguments it does not
> understand?

As long as bindgen generates things with the right ABI etc., yeah.
But, in principle, enabling one extension one side but not the other
could be wrong if it ends up in something that Rust uses, e.g. if the
C side does:

    #ifdef __ARM_ARCH_7R__
        int x;
    #else
        char x;
    #endif

and Rust attempts to use it, then particular `-march` builds could be broke=
n.

> Oh and clang-17 is going to support both of these, and Nathan and I
> already spent a bunch of time fixing the fallout from that!
> It still functions correctly without having them passed, but I have
> heard requiring these may become the default at some point too.
> What's done here may end up needing to be dynamic, but that bridge can be
> crossed if/when we come to it.
>
> What version of GCC do I need to replicate this? I can build tip-of-tree
> gcc if needs be.

Sorry, what do you want to replicate? If you mean what we had in the
old GitHub CI, I see:

    CONFIG_CC_VERSION_TEXT=3D"riscv64-linux-gnu-gcc (Ubuntu
11.3.0-1ubuntu1~22.04) 11.3.0"

which successfully boots in QEMU for the kernel config we tested.

But if you are asking what should be supported, I guess it depends on
the RISC-V maintainers. Ideally, everything that the kernel supports
(GCC >=3D 5.1), but since the GCC+Rust builds are so experimental, I
think as long as something is tested from time to time, it would be
great (to at least know not everything is completely broken).

But if you think that would be too much effort to maintain, or even
GCC builds in general, then please feel free to ignore it for the time
being, i.e. it is better to have LLVM builds rather than nothing! :)

Cheers,
Miguel
