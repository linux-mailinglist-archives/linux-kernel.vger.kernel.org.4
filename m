Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826266DAA13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjDGI3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjDGI3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:29:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16607DBF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ED5763641
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74625C433D2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680856183;
        bh=mceKYfe3OlxIRPrWB6m+8AOI7KWE5Odi9G47oheQy3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jkw5O6xj6lKXlR6zeH0ys+o1mu9SnWfQSgudS6P9B6egH/asPZnBKgsWHBrCU4iUF
         jYW1fw0fPs4WTD0nimXrzeu8NqHHd/G2Tz4xLFr0HzbYgOqxiUptHtLs4vTm/erQQc
         3eRC5HWqDLKTRIcDeAD97aySW0RufvBV43DCG9kzgd3CMRpC0GZ3j4MrnvcCY6u3X4
         5TFwNUTr/KVAjQgIe2qi7uMlQf9z4WLFGsFIbJpLQG1ZvFnCIiaEvwtfF07Ua2Mhf0
         tQrO8M+D/EPVvfjVAoYRpiDbTajG9b/I+2MNFsSd8hzGHOYLkRPzsKCF5nnN+dYTND
         B3LMFFrF84aUg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-947cd8b2de3so207885266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:29:43 -0700 (PDT)
X-Gm-Message-State: AAQBX9elq+SJH//qExXaA/+UEra/OmRIxkVolulyO2TZ7hxC/hMjERCv
        IELCBy+Tz4i0TJMlx6DhEI9ka6s4m/2U1xBzP+A=
X-Google-Smtp-Source: AKy350ZG4EI7GkW98iu0RUZB518+GcvQXizchxGFAj132/1v6rFvLDZaZhI3mejmSsLVo5M4uwyqRpRqUw8kZRJnisk=
X-Received: by 2002:aa7:c747:0:b0:4ac:b687:f57e with SMTP id
 c7-20020aa7c747000000b004acb687f57emr1875288eds.1.1680856181705; Fri, 07 Apr
 2023 01:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230406082018.70367-1-leobras@redhat.com> <20230406082018.70367-2-leobras@redhat.com>
In-Reply-To: <20230406082018.70367-2-leobras@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 7 Apr 2023 16:29:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQOs8ossWXtGMAvk1xRmUnFXub31ETBYLs5oxrdBGVL2Q@mail.gmail.com>
Message-ID: <CAJF2gTQOs8ossWXtGMAvk1xRmUnFXub31ETBYLs5oxrdBGVL2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 4:20=E2=80=AFPM Leonardo Bras <leobras@redhat.com> w=
rote:
>
> In this header every cmpxchg define (_relaxed, _acquire, _release,
> vanilla) contain it's own asm file, both for 4-byte variables an 8-byte
> variables, on a total of 8 versions of mostly the same asm.
>
> This is usually bad, as it means any change may be done in up to 8
> different places.
>
> Unify those versions by creating a new define with enough parameters to
> generate any version of the previous 8.
>
> Then unify the result under a more general define, and simplify
> arch_cmpxchg* generation
>
> (This did not cause any change in generated asm)
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 184 ++++++-------------------------
>  1 file changed, 36 insertions(+), 148 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index 12debce235e52..f88fae357071c 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -163,51 +163,23 @@
>   * store NEW in MEM.  Return the initial value in MEM.  Success is
>   * indicated by comparing RETURN with OLD.
>   */
> -#define __cmpxchg_relaxed(ptr, old, new, size)                         \
> -({                                                                     \
> -       __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
> -       __typeof__(*(ptr)) __old =3D (old);                              =
 \
> -       __typeof__(*(ptr)) __new =3D (new);                              =
 \
> -       __typeof__(*(ptr)) __ret;                                       \
> -       register unsigned int __rc;                                     \
> -       switch (size) {                                                 \
> -       case 4:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "0:     lr.w %0, %2\n"                          \
> -                       "       bne  %0, %z3, 1f\n"                     \
> -                       "       sc.w %1, %z4, %2\n"                     \
> -                       "       bnez %1, 0b\n"                          \
> -                       "1:\n"                                          \
> -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> -                       : "rJ" ((long)__old), "rJ" (__new)              \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       case 8:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "0:     lr.d %0, %2\n"                          \
> -                       "       bne %0, %z3, 1f\n"                      \
> -                       "       sc.d %1, %z4, %2\n"                     \
> -                       "       bnez %1, 0b\n"                          \
> -                       "1:\n"                                          \
> -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> -                       : "rJ" (__old), "rJ" (__new)                    \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       default:                                                        \
> -               BUILD_BUG();                                            \
> -       }                                                               \
> -       __ret;                                                          \
> -})
>
> -#define arch_cmpxchg_relaxed(ptr, o, n)                                 =
       \
> +#define ____cmpxchg(lr_sfx, sc_sfx, prepend, append, r, rc, p, co, o, n)=
\
>  ({                                                                     \
> -       __typeof__(*(ptr)) _o_ =3D (o);                                  =
 \
> -       __typeof__(*(ptr)) _n_ =3D (n);                                  =
 \
> -       (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
> -                                       _o_, _n_, sizeof(*(ptr)));      \
> +       __asm__ __volatile__ (                                          \
> +               prepend                                                 \
> +               "0:     lr" lr_sfx " %0, %2\n"                          \
> +               "       bne  %0, %z3, 1f\n"                             \
> +               "       sc" sc_sfx " %1, %z4, %2\n"                     \
> +               "       bnez %1, 0b\n"                                  \
> +               append                                                  \
> +               "1:\n"                                                  \
> +               : "=3D&r" (r), "=3D&r" (rc), "+A" (*(p))                 =
   \
> +               : "rJ" (co o), "rJ" (n)                                 \
> +               : "memory");                                            \
>  })
>
> -#define __cmpxchg_acquire(ptr, old, new, size)                         \
> +#define ___cmpxchg(ptr, old, new, size, sc_sfx, prepend, append)       \
>  ({                                                                     \
>         __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
>         __typeof__(*(ptr)) __old =3D (old);                              =
 \
> @@ -216,28 +188,12 @@
>         register unsigned int __rc;                                     \
>         switch (size) {                                                 \
>         case 4:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "0:     lr.w %0, %2\n"                          \
> -                       "       bne  %0, %z3, 1f\n"                     \
> -                       "       sc.w %1, %z4, %2\n"                     \
> -                       "       bnez %1, 0b\n"                          \
> -                       RISCV_ACQUIRE_BARRIER                           \
> -                       "1:\n"                                          \
> -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> -                       : "rJ" ((long)__old), "rJ" (__new)              \
> -                       : "memory");                                    \
> +               ____cmpxchg(".w", ".w" sc_sfx, prepend, append,         \
> +                           __ret, __rc, __ptr, (long), __old, __new);  \
>                 break;                                                  \
>         case 8:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "0:     lr.d %0, %2\n"                          \
> -                       "       bne %0, %z3, 1f\n"                      \
> -                       "       sc.d %1, %z4, %2\n"                     \
> -                       "       bnez %1, 0b\n"                          \
> -                       RISCV_ACQUIRE_BARRIER                           \
> -                       "1:\n"                                          \
> -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> -                       : "rJ" (__old), "rJ" (__new)                    \
> -                       : "memory");                                    \
> +               ____cmpxchg(".d", ".d" sc_sfx, prepend, append,         \
> +                           __ret, __rc, __ptr, /**/, __old, __new);    \
>                 break;                                                  \
>         default:                                                        \
>                 BUILD_BUG();                                            \
> @@ -245,105 +201,37 @@
>         __ret;                                                          \
>  })
>
> -#define arch_cmpxchg_acquire(ptr, o, n)                                 =
       \
> +#define __cmpxchg_relaxed(ptr, old, new, size)                         \
> +       ___cmpxchg(ptr, old, new, size, "", "", "")
> +
> +#define _arch_cmpxchg(order, ptr, o, n)                                 =
       \
>  ({                                                                     \
>         __typeof__(*(ptr)) _o_ =3D (o);                                  =
 \
>         __typeof__(*(ptr)) _n_ =3D (n);                                  =
 \
> -       (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                   \
> -                                       _o_, _n_, sizeof(*(ptr)));      \
> +       (__typeof__(*(ptr))) __cmpxchg ## order((ptr), _o_, _n_,        \
> +                                               sizeof(*(ptr)));        \
>  })
>
> +#define arch_cmpxchg_relaxed(ptr, o, n)                                 =
       \
> +       _arch_cmpxchg(_relaxed, ptr, o, n)
> +
> +#define __cmpxchg_acquire(ptr, old, new, size)                         \
> +       ___cmpxchg(ptr, old, new, size, "", "", RISCV_ACQUIRE_BARRIER)
> +
> +#define arch_cmpxchg_acquire(ptr, o, n)                                 =
       \
> +       _arch_cmpxchg(_acquire, ptr, o, n)
> +
>  #define __cmpxchg_release(ptr, old, new, size)                         \
> -({                                                                     \
> -       __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
> -       __typeof__(*(ptr)) __old =3D (old);                              =
 \
> -       __typeof__(*(ptr)) __new =3D (new);                              =
 \
> -       __typeof__(*(ptr)) __ret;                                       \
> -       register unsigned int __rc;                                     \
> -       switch (size) {                                                 \
> -       case 4:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       RISCV_RELEASE_BARRIER                           \
> -                       "0:     lr.w %0, %2\n"                          \
> -                       "       bne  %0, %z3, 1f\n"                     \
> -                       "       sc.w %1, %z4, %2\n"                     \
> -                       "       bnez %1, 0b\n"                          \
> -                       "1:\n"                                          \
> -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> -                       : "rJ" ((long)__old), "rJ" (__new)              \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       case 8:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       RISCV_RELEASE_BARRIER                           \
> -                       "0:     lr.d %0, %2\n"                          \
> -                       "       bne %0, %z3, 1f\n"                      \
> -                       "       sc.d %1, %z4, %2\n"                     \
> -                       "       bnez %1, 0b\n"                          \
> -                       "1:\n"                                          \
> -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> -                       : "rJ" (__old), "rJ" (__new)                    \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       default:                                                        \
> -               BUILD_BUG();                                            \
> -       }                                                               \
> -       __ret;                                                          \
> -})
> +       ___cmpxchg(ptr, old, new, size, "", RISCV_RELEASE_BARRIER, "")
>
>  #define arch_cmpxchg_release(ptr, o, n)                                 =
       \
> -({                                                                     \
> -       __typeof__(*(ptr)) _o_ =3D (o);                                  =
 \
> -       __typeof__(*(ptr)) _n_ =3D (n);                                  =
 \
> -       (__typeof__(*(ptr))) __cmpxchg_release((ptr),                   \
> -                                       _o_, _n_, sizeof(*(ptr)));      \
> -})
> +       _arch_cmpxchg(_release, ptr, o, n)
>
>  #define __cmpxchg(ptr, old, new, size)                                 \
> -({                                                                     \
> -       __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
> -       __typeof__(*(ptr)) __old =3D (old);                              =
 \
> -       __typeof__(*(ptr)) __new =3D (new);                              =
 \
> -       __typeof__(*(ptr)) __ret;                                       \
> -       register unsigned int __rc;                                     \
> -       switch (size) {                                                 \
> -       case 4:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "0:     lr.w %0, %2\n"                          \
> -                       "       bne  %0, %z3, 1f\n"                     \
> -                       "       sc.w.rl %1, %z4, %2\n"                  \
> -                       "       bnez %1, 0b\n"                          \
> -                       "       fence rw, rw\n"                         \
> -                       "1:\n"                                          \
> -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> -                       : "rJ" ((long)__old), "rJ" (__new)              \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       case 8:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "0:     lr.d %0, %2\n"                          \
> -                       "       bne %0, %z3, 1f\n"                      \
> -                       "       sc.d.rl %1, %z4, %2\n"                  \
> -                       "       bnez %1, 0b\n"                          \
> -                       "       fence rw, rw\n"                         \
> -                       "1:\n"                                          \
> -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> -                       : "rJ" (__old), "rJ" (__new)                    \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       default:                                                        \
> -               BUILD_BUG();                                            \
> -       }                                                               \
> -       __ret;                                                          \
> -})
> +       ___cmpxchg(ptr, old, new, size, ".rl", "", "    fence rw, rw\n")
>
>  #define arch_cmpxchg(ptr, o, n)                                         =
       \
> -({                                                                     \
> -       __typeof__(*(ptr)) _o_ =3D (o);                                  =
 \
> -       __typeof__(*(ptr)) _n_ =3D (n);                                  =
 \
> -       (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
> -                                      _o_, _n_, sizeof(*(ptr)));       \
> -})
> +       _arch_cmpxchg(, ptr, o, n)
>
>  #define arch_cmpxchg_local(ptr, o, n)                                  \
>         (__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
> --
> 2.40.0
>
One patch is much easier to review :)

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
