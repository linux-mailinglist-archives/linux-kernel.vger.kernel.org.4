Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369287108EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbjEYJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbjEYJcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AFF191
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685007092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eI9hn14F2E3Ms7+cd+p8gHD1DA+RdZDwaz9ojtYTiFw=;
        b=Q2cBRF+z+h42h33nz9IeA7aiHfvH2O//4KK5EjuAPDU3KGuFEvF6Tesw+KSZXNs7VGOgWw
        oqZ09ftarEo38piXBnA7op0sUlCxUuOpNT+F5Vu2FHmh+Z0051BleSK0eQ8VgX0HpzB/zP
        0tHqZo9LK4BJZYMN8m4SGfcO9RFgCrU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-OKTb-0-IOpC08jzn5YIJZg-1; Thu, 25 May 2023 05:31:29 -0400
X-MC-Unique: OKTb-0-IOpC08jzn5YIJZg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-621257e86daso14110816d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685007088; x=1687599088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI9hn14F2E3Ms7+cd+p8gHD1DA+RdZDwaz9ojtYTiFw=;
        b=Ak2IHSSjaSIdo+L95OpogOIjKy3wDq0dujH0YWZd7auS9GxfdlfCNzjnlrQag2TSzV
         I6mW3U2TaVOoBnxg8sk89k1KNYUpaDvkpx86hBTiJ/WxhkjvZFTCsYneTKBU0NHG+ETP
         SiX0FFu9X6gt7FJWCWkMy9gW8kLGNjhGHcI1Rfa1BeLhZ+6OhRcMk/IMsXQTqGsBhSFd
         Ia98Z73iLhIqnKrByNY2BpMIBqMtfiEctSpF7Pu61v3qU9r+bpVIxAG6wfrviAE/tF+D
         cnuAO1oGd74kOOIwh3CVnKmVdvIfaUHudLtgUMc0Qpcw9PnsC0bFOyTF9DQNGJm+DoAH
         sobA==
X-Gm-Message-State: AC+VfDy4xoe11C1ToRWd8hax8JTBJN9iRuMQ1Dbkz+Jr7uzD/DmBiD8s
        +opPCErXEBESm1fYROtrT1h0niuVZHZplDMEM0aChMoMdm0AMtCgQliIZ7hGtHVOcPCZtTVCAyo
        +XLmr/dvyRoqzInsB9m9ieY4V3lkQf5+vOWTYwKYl
X-Received: by 2002:a05:6214:27c2:b0:5df:4d41:954d with SMTP id ge2-20020a05621427c200b005df4d41954dmr705355qvb.3.1685007088141;
        Thu, 25 May 2023 02:31:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QNfOzyAuTDSUkGS02WiXRFq6GafNNMLRGOYBrm2W15wAP32TBwDroB5EWa+TIDHfPtzdY5ABwHdiXtRO60aU=
X-Received: by 2002:a05:6214:27c2:b0:5df:4d41:954d with SMTP id
 ge2-20020a05621427c200b005df4d41954dmr705345qvb.3.1685007087859; Thu, 25 May
 2023 02:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230419062505.257231-1-leobras@redhat.com>
In-Reply-To: <20230419062505.257231-1-leobras@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Thu, 25 May 2023 06:31:16 -0300
Message-ID: <CAJ6HWG6nPdUQ_2_fSj6J7ZE7FB-T+VWT-kq9oW8BLTUtuQEWxA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] riscv/atomic.h: Deduplicate arch_atomic.*
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping?

On Wed, Apr 19, 2023 at 3:25=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> Some functions use mostly the same asm for 32-bit and 64-bit versions.
>
> Make a macro that is generic enough and avoid code duplication.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/atomic.h | 164 +++++++++++++++-----------------
>  1 file changed, 76 insertions(+), 88 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/ato=
mic.h
> index 0dfe9d857a762..85eb2edbc8219 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
>  #undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
>
> +#define _arch_atomic_fetch_add_unless(_prev, _rc, counter, _a, _u, sfx) =
       \
> +({                                                                     \
> +       __asm__ __volatile__ (                                          \
> +               "0:     lr." sfx "     %[p],  %[c]\n"                   \
> +               "       beq            %[p],  %[u], 1f\n"               \
> +               "       add            %[rc], %[p], %[a]\n"             \
> +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"            \
> +               "       bnez           %[rc], 0b\n"                     \
> +               "       fence          rw, rw\n"                        \
> +               "1:\n"                                                  \
> +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (counter=
)  \
> +               : [a]"r" (_a), [u]"r" (_u)                              \
> +               : "memory");                                            \
> +})
> +
>  /* This is required to provide a full barrier on success. */
>  static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int=
 a, int u)
>  {
>         int prev, rc;
>
> -       __asm__ __volatile__ (
> -               "0:     lr.w     %[p],  %[c]\n"
> -               "       beq      %[p],  %[u], 1f\n"
> -               "       add      %[rc], %[p], %[a]\n"
> -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> -               "       bnez     %[rc], 0b\n"
> -               "       fence    rw, rw\n"
> -               "1:\n"
> -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> -               : [a]"r" (a), [u]"r" (u)
> -               : "memory");
> +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "w");
> +
>         return prev;
>  }
>  #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
> @@ -222,17 +228,8 @@ static __always_inline s64 arch_atomic64_fetch_add_u=
nless(atomic64_t *v, s64 a,
>         s64 prev;
>         long rc;
>
> -       __asm__ __volatile__ (
> -               "0:     lr.d     %[p],  %[c]\n"
> -               "       beq      %[p],  %[u], 1f\n"
> -               "       add      %[rc], %[p], %[a]\n"
> -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> -               "       bnez     %[rc], 0b\n"
> -               "       fence    rw, rw\n"
> -               "1:\n"
> -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> -               : [a]"r" (a), [u]"r" (u)
> -               : "memory");
> +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "d");
> +
>         return prev;
>  }
>  #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
> @@ -310,61 +307,79 @@ ATOMIC_OPS()
>  #undef ATOMIC_OPS
>  #undef ATOMIC_OP
>
> +#define _arch_atomic_inc_unless_negative(_prev, _rc, counter, sfx)     \
> +({                                                                     \
> +       __asm__ __volatile__ (                                          \
> +               "0:     lr." sfx "      %[p],  %[c]\n"                  \
> +               "       bltz            %[p],  1f\n"                    \
> +               "       addi            %[rc], %[p], 1\n"               \
> +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"           \
> +               "       bnez            %[rc], 0b\n"                    \
> +               "       fence           rw, rw\n"                       \
> +               "1:\n"                                                  \
> +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (counter=
)  \
> +               :                                                       \
> +               : "memory");                                            \
> +})
> +
>  static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
>  {
>         int prev, rc;
>
> -       __asm__ __volatile__ (
> -               "0:     lr.w      %[p],  %[c]\n"
> -               "       bltz      %[p],  1f\n"
> -               "       addi      %[rc], %[p], 1\n"
> -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> -               "       bnez      %[rc], 0b\n"
> -               "       fence     rw, rw\n"
> -               "1:\n"
> -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> -               :
> -               : "memory");
> +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "w");
> +
>         return !(prev < 0);
>  }
>
>  #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
>
> +#define _arch_atomic_dec_unless_positive(_prev, _rc, counter, sfx)     \
> +({                                                                     \
> +       __asm__ __volatile__ (                                          \
> +               "0:     lr." sfx "      %[p],  %[c]\n"                  \
> +               "       bgtz            %[p],  1f\n"                    \
> +               "       addi            %[rc], %[p], -1\n"              \
> +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"           \
> +               "       bnez            %[rc], 0b\n"                    \
> +               "       fence           rw, rw\n"                       \
> +               "1:\n"                                                  \
> +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (counter=
)  \
> +               :                                                       \
> +               : "memory");                                            \
> +})
> +
>  static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
>  {
>         int prev, rc;
>
> -       __asm__ __volatile__ (
> -               "0:     lr.w      %[p],  %[c]\n"
> -               "       bgtz      %[p],  1f\n"
> -               "       addi      %[rc], %[p], -1\n"
> -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> -               "       bnez      %[rc], 0b\n"
> -               "       fence     rw, rw\n"
> -               "1:\n"
> -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> -               :
> -               : "memory");
> +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "w");
> +
>         return !(prev > 0);
>  }
>
>  #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
>
> +#define _arch_atomic_dec_if_positive(_prev, _rc, counter, sfx)         \
> +({                                                                     \
> +       __asm__ __volatile__ (                                          \
> +               "0:     lr." sfx "     %[p],  %[c]\n"                   \
> +               "       addi           %[rc], %[p], -1\n"               \
> +               "       bltz           %[rc], 1f\n"                     \
> +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"            \
> +               "       bnez           %[rc], 0b\n"                     \
> +               "       fence          rw, rw\n"                        \
> +               "1:\n"                                                  \
> +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (counter=
)  \
> +               :                                                       \
> +               : "memory");                                            \
> +})
> +
>  static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
>  {
>         int prev, rc;
>
> -       __asm__ __volatile__ (
> -               "0:     lr.w     %[p],  %[c]\n"
> -               "       addi     %[rc], %[p], -1\n"
> -               "       bltz     %[rc], 1f\n"
> -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> -               "       bnez     %[rc], 0b\n"
> -               "       fence    rw, rw\n"
> -               "1:\n"
> -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> -               :
> -               : "memory");
> +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "w");
> +
>         return prev - 1;
>  }
>
> @@ -376,17 +391,8 @@ static __always_inline bool arch_atomic64_inc_unless=
_negative(atomic64_t *v)
>         s64 prev;
>         long rc;
>
> -       __asm__ __volatile__ (
> -               "0:     lr.d      %[p],  %[c]\n"
> -               "       bltz      %[p],  1f\n"
> -               "       addi      %[rc], %[p], 1\n"
> -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> -               "       bnez      %[rc], 0b\n"
> -               "       fence     rw, rw\n"
> -               "1:\n"
> -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> -               :
> -               : "memory");
> +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "d");
> +
>         return !(prev < 0);
>  }
>
> @@ -397,17 +403,8 @@ static __always_inline bool arch_atomic64_dec_unless=
_positive(atomic64_t *v)
>         s64 prev;
>         long rc;
>
> -       __asm__ __volatile__ (
> -               "0:     lr.d      %[p],  %[c]\n"
> -               "       bgtz      %[p],  1f\n"
> -               "       addi      %[rc], %[p], -1\n"
> -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> -               "       bnez      %[rc], 0b\n"
> -               "       fence     rw, rw\n"
> -               "1:\n"
> -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> -               :
> -               : "memory");
> +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "d");
> +
>         return !(prev > 0);
>  }
>
> @@ -418,17 +415,8 @@ static __always_inline s64 arch_atomic64_dec_if_posi=
tive(atomic64_t *v)
>         s64 prev;
>         long rc;
>
> -       __asm__ __volatile__ (
> -               "0:     lr.d     %[p],  %[c]\n"
> -               "       addi      %[rc], %[p], -1\n"
> -               "       bltz     %[rc], 1f\n"
> -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> -               "       bnez     %[rc], 0b\n"
> -               "       fence    rw, rw\n"
> -               "1:\n"
> -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> -               :
> -               : "memory");
> +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "d");
> +
>         return prev - 1;
>  }
>
> --
> 2.40.0
>

