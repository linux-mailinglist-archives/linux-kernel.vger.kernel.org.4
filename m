Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D80710977
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbjEYKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjEYKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2851512F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 992036446B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B8BC433AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685009222;
        bh=x4sTQqRPVeAzca24FBkaW09WN0pYPm5pqF888Y9tJ18=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mTgHuyQCkfbgRu3asVjTK1T+ZxWFLm+ClFCLfi5jVtxdRPYfoeK78wOwvlrzWRQkC
         jx469WM3YNfMB5IlkweC0bZosufqi5OlNsXwIS8AU9Ubp8uOGTCfJXRi1fk3NAn1qk
         f8JqUjAWq8cpfo8I62HZMMverSbkCgFRA+TuNyG4cdvXQU+7bzGNeXRUtzeT60B6rc
         kC6vRV/7w9U3p9ZqBqSJsvZru4D5qOkTeYhMHB4FHfNZ1bEjSull57KR3sEDJQAVNX
         2DqxfAb8MN0ymzRGJ31/YRm/qXOU3zyTCnLjPwaUFdIPY9lgrq4dSRa2chhMql5glu
         vdd/7RMRvDVbg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1b2so3792515a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:07:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDwx8Qdkk/J3VBXjIeO9TeWgzZn1xJtzm8w6m0r3oBe1ibJofYF0
        i5k6ko9ZB3Zr+VP/PKTXs67Qp9slq5gZAzc2GG8=
X-Google-Smtp-Source: ACHHUZ4/ybMfAKzs8CYdKURb+tO/4DP9NGpZYSPuwsfXUO7KJFwHGpQ3dBfNi2iO2a0UATJi4VWr3UvodL+idvt3woY=
X-Received: by 2002:a17:907:3e29:b0:971:485:206 with SMTP id
 hp41-20020a1709073e2900b0097104850206mr1119430ejc.54.1685009220885; Thu, 25
 May 2023 03:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230419062505.257231-1-leobras@redhat.com> <CAJ6HWG6nPdUQ_2_fSj6J7ZE7FB-T+VWT-kq9oW8BLTUtuQEWxA@mail.gmail.com>
In-Reply-To: <CAJ6HWG6nPdUQ_2_fSj6J7ZE7FB-T+VWT-kq9oW8BLTUtuQEWxA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 25 May 2023 18:06:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRZO2hogUbZvj0f41JJvmqLNz-MKTHJshgdhNMpp9Bc8w@mail.gmail.com>
Message-ID: <CAJF2gTRZO2hogUbZvj0f41JJvmqLNz-MKTHJshgdhNMpp9Bc8w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] riscv/atomic.h: Deduplicate arch_atomic.*
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 5:31=E2=80=AFPM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> Friendly ping?
>
> On Wed, Apr 19, 2023 at 3:25=E2=80=AFAM Leonardo Bras <leobras@redhat.com=
> wrote:
> >
> > Some functions use mostly the same asm for 32-bit and 64-bit versions.
> >
> > Make a macro that is generic enough and avoid code duplication.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/atomic.h | 164 +++++++++++++++-----------------
> >  1 file changed, 76 insertions(+), 88 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/a=
tomic.h
> > index 0dfe9d857a762..85eb2edbc8219 100644
> > --- a/arch/riscv/include/asm/atomic.h
> > +++ b/arch/riscv/include/asm/atomic.h
> > @@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
> >  #undef ATOMIC_FETCH_OP
> >  #undef ATOMIC_OP_RETURN
> >
> > +#define _arch_atomic_fetch_add_unless(_prev, _rc, counter, _a, _u, sfx=
)        \
> > +({                                                                    =
 \
> > +       __asm__ __volatile__ (                                         =
 \
> > +               "0:     lr." sfx "     %[p],  %[c]\n"                  =
 \
> > +               "       beq            %[p],  %[u], 1f\n"              =
 \
> > +               "       add            %[rc], %[p], %[a]\n"            =
 \
> > +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"           =
 \
> > +               "       bnez           %[rc], 0b\n"                    =
 \
> > +               "       fence          rw, rw\n"                       =
 \
> > +               "1:\n"                                                 =
 \
> > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (count=
er)  \
> > +               : [a]"r" (_a), [u]"r" (_u)                             =
 \
> > +               : "memory");                                           =
 \
> > +})
> > +
> >  /* This is required to provide a full barrier on success. */
> >  static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, i=
nt a, int u)
> >  {
> >         int prev, rc;
> >
> > -       __asm__ __volatile__ (
> > -               "0:     lr.w     %[p],  %[c]\n"
> > -               "       beq      %[p],  %[u], 1f\n"
> > -               "       add      %[rc], %[p], %[a]\n"
> > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > -               "       bnez     %[rc], 0b\n"
> > -               "       fence    rw, rw\n"
> > -               "1:\n"
> > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->coun=
ter)
> > -               : [a]"r" (a), [u]"r" (u)
> > -               : "memory");
> > +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "w");
> > +
> >         return prev;
> >  }
> >  #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
> > @@ -222,17 +228,8 @@ static __always_inline s64 arch_atomic64_fetch_add=
_unless(atomic64_t *v, s64 a,
> >         s64 prev;
> >         long rc;
> >
> > -       __asm__ __volatile__ (
> > -               "0:     lr.d     %[p],  %[c]\n"
> > -               "       beq      %[p],  %[u], 1f\n"
> > -               "       add      %[rc], %[p], %[a]\n"
> > -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > -               "       bnez     %[rc], 0b\n"
> > -               "       fence    rw, rw\n"
> > -               "1:\n"
> > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->coun=
ter)
> > -               : [a]"r" (a), [u]"r" (u)
> > -               : "memory");
> > +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "d");
> > +
> >         return prev;
> >  }
> >  #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
> > @@ -310,61 +307,79 @@ ATOMIC_OPS()
> >  #undef ATOMIC_OPS
> >  #undef ATOMIC_OP
> >
> > +#define _arch_atomic_inc_unless_negative(_prev, _rc, counter, sfx)    =
 \
> > +({                                                                    =
 \
> > +       __asm__ __volatile__ (                                         =
 \
> > +               "0:     lr." sfx "      %[p],  %[c]\n"                 =
 \
> > +               "       bltz            %[p],  1f\n"                   =
 \
> > +               "       addi            %[rc], %[p], 1\n"              =
 \
> > +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"          =
 \
> > +               "       bnez            %[rc], 0b\n"                   =
 \
> > +               "       fence           rw, rw\n"                      =
 \
> > +               "1:\n"                                                 =
 \
> > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (count=
er)  \
> > +               :                                                      =
 \
> > +               : "memory");                                           =
 \
> > +})
> > +
> >  static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *=
v)
> >  {
> >         int prev, rc;
> >
> > -       __asm__ __volatile__ (
> > -               "0:     lr.w      %[p],  %[c]\n"
> > -               "       bltz      %[p],  1f\n"
> > -               "       addi      %[rc], %[p], 1\n"
> > -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > -               "       bnez      %[rc], 0b\n"
> > -               "       fence     rw, rw\n"
> > -               "1:\n"
> > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->coun=
ter)
> > -               :
> > -               : "memory");
> > +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "w");
> > +
> >         return !(prev < 0);
> >  }
> >
> >  #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negativ=
e
> >
> > +#define _arch_atomic_dec_unless_positive(_prev, _rc, counter, sfx)    =
 \
> > +({                                                                    =
 \
> > +       __asm__ __volatile__ (                                         =
 \
> > +               "0:     lr." sfx "      %[p],  %[c]\n"                 =
 \
> > +               "       bgtz            %[p],  1f\n"                   =
 \
> > +               "       addi            %[rc], %[p], -1\n"             =
 \
> > +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"          =
 \
> > +               "       bnez            %[rc], 0b\n"                   =
 \
> > +               "       fence           rw, rw\n"                      =
 \
> > +               "1:\n"                                                 =
 \
> > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (count=
er)  \
> > +               :                                                      =
 \
> > +               : "memory");                                           =
 \
> > +})
> > +
> >  static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *=
v)
> >  {
> >         int prev, rc;
> >
> > -       __asm__ __volatile__ (
> > -               "0:     lr.w      %[p],  %[c]\n"
> > -               "       bgtz      %[p],  1f\n"
> > -               "       addi      %[rc], %[p], -1\n"
> > -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > -               "       bnez      %[rc], 0b\n"
> > -               "       fence     rw, rw\n"
> > -               "1:\n"
> > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->coun=
ter)
> > -               :
> > -               : "memory");
> > +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "w");
> > +
> >         return !(prev > 0);
> >  }
> >
> >  #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positiv=
e
> >
> > +#define _arch_atomic_dec_if_positive(_prev, _rc, counter, sfx)        =
 \
> > +({                                                                    =
 \
> > +       __asm__ __volatile__ (                                         =
 \
> > +               "0:     lr." sfx "     %[p],  %[c]\n"                  =
 \
> > +               "       addi           %[rc], %[p], -1\n"              =
 \
> > +               "       bltz           %[rc], 1f\n"                    =
 \
> > +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"           =
 \
> > +               "       bnez           %[rc], 0b\n"                    =
 \
> > +               "       fence          rw, rw\n"                       =
 \
> > +               "1:\n"                                                 =
 \
> > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (count=
er)  \
> > +               :                                                      =
 \
> > +               : "memory");                                           =
 \
> > +})
> > +
> >  static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
> >  {
> >         int prev, rc;
> >
> > -       __asm__ __volatile__ (
> > -               "0:     lr.w     %[p],  %[c]\n"
> > -               "       addi     %[rc], %[p], -1\n"
> > -               "       bltz     %[rc], 1f\n"
> > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > -               "       bnez     %[rc], 0b\n"
> > -               "       fence    rw, rw\n"
> > -               "1:\n"
> > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->coun=
ter)
> > -               :
> > -               : "memory");
> > +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "w");
> > +
> >         return prev - 1;
> >  }
> >
> > @@ -376,17 +391,8 @@ static __always_inline bool arch_atomic64_inc_unle=
ss_negative(atomic64_t *v)
> >         s64 prev;
> >         long rc;
> >
> > -       __asm__ __volatile__ (
> > -               "0:     lr.d      %[p],  %[c]\n"
> > -               "       bltz      %[p],  1f\n"
> > -               "       addi      %[rc], %[p], 1\n"
> > -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > -               "       bnez      %[rc], 0b\n"
> > -               "       fence     rw, rw\n"
> > -               "1:\n"
> > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->coun=
ter)
> > -               :
> > -               : "memory");
> > +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "d");
> > +
> >         return !(prev < 0);
> >  }
> >
> > @@ -397,17 +403,8 @@ static __always_inline bool arch_atomic64_dec_unle=
ss_positive(atomic64_t *v)
> >         s64 prev;
> >         long rc;
> >
> > -       __asm__ __volatile__ (
> > -               "0:     lr.d      %[p],  %[c]\n"
> > -               "       bgtz      %[p],  1f\n"
> > -               "       addi      %[rc], %[p], -1\n"
> > -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > -               "       bnez      %[rc], 0b\n"
> > -               "       fence     rw, rw\n"
> > -               "1:\n"
> > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->coun=
ter)
> > -               :
> > -               : "memory");
> > +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "d");
> > +
> >         return !(prev > 0);
> >  }
> >
> > @@ -418,17 +415,8 @@ static __always_inline s64 arch_atomic64_dec_if_po=
sitive(atomic64_t *v)
> >         s64 prev;
> >         long rc;
> >
> > -       __asm__ __volatile__ (
> > -               "0:     lr.d     %[p],  %[c]\n"
> > -               "       addi      %[rc], %[p], -1\n"
> > -               "       bltz     %[rc], 1f\n"
> > -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > -               "       bnez     %[rc], 0b\n"
> > -               "       fence    rw, rw\n"
> > -               "1:\n"
> > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->coun=
ter)
> > -               :
> > -               : "memory");
> > +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "d");
> > +
> >         return prev - 1;
> >  }
> >
> > --
> > 2.40.0
> >
>
A safe cleanup, no problem found.

Reviewed-by: Guo Ren <guoren@kernel.org>


--=20
Best Regards
 Guo Ren
