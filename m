Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761526DAA2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjDGIcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjDGIcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D377DB469
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83066648CF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8088C433EF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680856274;
        bh=332mfN4K7dYI60z7xy9MSheDDVOf8MMJ0Rm37AsgOxo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t3xIMlBKDQ9K4ltG2Ia9lGMw15wFyD6pJ65S/Imn7tk5r3fjLYnki3IIKNQKO/IUb
         8nBhI6ObbSQSzEEKKjh9Crx1CTLSpf4GtWc5MFsuCZXnbmHDWt65C8PToTW8UqQixD
         4itHBXO07+ZAcd4gE8nFnlhwhFXDCMD19bIxQxQHTiOa35HYHwkLVwrrqz5jF9Gf+9
         DADViPhn/eQjL16qFJjcFJym3MkFLjDovRn7iJ2jzB1giuRwhH9hgXJNY67tRwGQ/P
         EhYrWLAcip1ACtgEBkM2mCfiFHamTWkUz5SemioFG9hq7lEKw16vbCndaOxKuE/U14
         KLob6epqsz8Ig==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-4fa3ca41383so1620947a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:31:13 -0700 (PDT)
X-Gm-Message-State: AAQBX9dkbRQpKXNqiAX3/FqO6aMUdQFbqN04Q+AFLfVRHqejDxv9kx9R
        31UbFIlCGZrNqsVCIfjCF6CRfmq4nOTMTCDckdE=
X-Google-Smtp-Source: AKy350b9w+y9iXVrKZvTxgr0rYpTj9cgJaiwU+3ooJMkm4jr0RVT8bmLii/2pANxWA3w9Ql1+dZA52TAR7CQFX+FTLI=
X-Received: by 2002:aa7:c393:0:b0:500:2cc6:36da with SMTP id
 k19-20020aa7c393000000b005002cc636damr1136820edq.19.1680856272178; Fri, 07
 Apr 2023 01:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230406082018.70367-1-leobras@redhat.com> <20230406082018.70367-3-leobras@redhat.com>
In-Reply-To: <20230406082018.70367-3-leobras@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 7 Apr 2023 16:31:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTmpwQBO2BLf6ZUZqL77nsc3zPLU-1hkSNqHGBvVSzprA@mail.gmail.com>
Message-ID: <CAJF2gTTmpwQBO2BLf6ZUZqL77nsc3zPLU-1hkSNqHGBvVSzprA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] riscv/cmpxchg: Deduplicate xchg() asm functions
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
> In this header every xchg define (_relaxed, _acquire, _release, vanilla)
> contain it's own asm file, both for 4-byte variables an 8-byte variables,
> on a total of 8 versions of mostly the same asm.
>
> This is usually bad, as it means any change may be done in up to 8
> different places.
>
> Unify those versions by creating a new define with enough parameters to
> generate any version of the previous 8.
>
> Then unify the result under a more general define, and simplify
> arch_xchg* generation.
>
> (This did not cause any change in generated asm)
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 135 +++++++------------------------
>  1 file changed, 31 insertions(+), 104 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index f88fae357071c..905a888d8b04d 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -11,25 +11,30 @@
>  #include <asm/barrier.h>
>  #include <asm/fence.h>
>
> -#define __xchg_relaxed(ptr, new, size)                                 \
> +#define ____xchg(sfx, prepend, append, r, p, n)                         =
       \
> +({                                                                     \
> +       __asm__ __volatile__ (                                          \
> +               prepend                                                 \
> +               "       amoswap" sfx " %0, %2, %1\n"                    \
> +               append                                                  \
> +               : "=3Dr" (r), "+A" (*(p))                                =
 \
> +               : "r" (n)                                               \
> +               : "memory");                                            \
> +})
> +
> +#define ___xchg(ptr, new, size, sfx, prepend, append)                  \
>  ({                                                                     \
>         __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
>         __typeof__(new) __new =3D (new);                                 =
 \
>         __typeof__(*(ptr)) __ret;                                       \
>         switch (size) {                                                 \
>         case 4:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "       amoswap.w %0, %2, %1\n"                 \
> -                       : "=3Dr" (__ret), "+A" (*__ptr)                  =
 \
> -                       : "r" (__new)                                   \
> -                       : "memory");                                    \
> +               ____xchg(".w" sfx, prepend, append,                     \
> +                        __ret, __ptr, __new);                          \
>                 break;                                                  \
>         case 8:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "       amoswap.d %0, %2, %1\n"                 \
> -                       : "=3Dr" (__ret), "+A" (*__ptr)                  =
 \
> -                       : "r" (__new)                                   \
> -                       : "memory");                                    \
> +               ____xchg(".d" sfx, prepend, append,                     \
> +                        __ret, __ptr, __new);                          \
>                 break;                                                  \
>         default:                                                        \
>                 BUILD_BUG();                                            \
> @@ -37,114 +42,36 @@
>         __ret;                                                          \
>  })
>
> -#define arch_xchg_relaxed(ptr, x)                                      \
> +#define __xchg_relaxed(ptr, new, size)                                 \
> +       ___xchg(ptr, new, size, "", "", "")
> +
> +#define _arch_xchg(order, ptr, x)                                      \
>  ({                                                                     \
>         __typeof__(*(ptr)) _x_ =3D (x);                                  =
 \
> -       (__typeof__(*(ptr))) __xchg_relaxed((ptr),                      \
> -                                           _x_, sizeof(*(ptr)));       \
> +       (__typeof__(*(ptr))) __xchg ## order((ptr),                     \
> +                                            _x_, sizeof(*(ptr)));      \
>  })
>
> +#define arch_xchg_relaxed(ptr, x)                                      \
> +       _arch_xchg(_relaxed, ptr, x)
> +
>  #define __xchg_acquire(ptr, new, size)                                 \
> -({                                                                     \
> -       __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
> -       __typeof__(new) __new =3D (new);                                 =
 \
> -       __typeof__(*(ptr)) __ret;                                       \
> -       switch (size) {                                                 \
> -       case 4:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "       amoswap.w %0, %2, %1\n"                 \
> -                       RISCV_ACQUIRE_BARRIER                           \
> -                       : "=3Dr" (__ret), "+A" (*__ptr)                  =
 \
> -                       : "r" (__new)                                   \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       case 8:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "       amoswap.d %0, %2, %1\n"                 \
> -                       RISCV_ACQUIRE_BARRIER                           \
> -                       : "=3Dr" (__ret), "+A" (*__ptr)                  =
 \
> -                       : "r" (__new)                                   \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       default:                                                        \
> -               BUILD_BUG();                                            \
> -       }                                                               \
> -       __ret;                                                          \
> -})
> +       ___xchg(ptr, new, size, "", "", RISCV_ACQUIRE_BARRIER)
>
>  #define arch_xchg_acquire(ptr, x)                                      \
> -({                                                                     \
> -       __typeof__(*(ptr)) _x_ =3D (x);                                  =
 \
> -       (__typeof__(*(ptr))) __xchg_acquire((ptr),                      \
> -                                           _x_, sizeof(*(ptr)));       \
> -})
> +       _arch_xchg(_acquire, ptr, x)
>
>  #define __xchg_release(ptr, new, size)                                 \
> -({                                                                     \
> -       __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
> -       __typeof__(new) __new =3D (new);                                 =
 \
> -       __typeof__(*(ptr)) __ret;                                       \
> -       switch (size) {                                                 \
> -       case 4:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       RISCV_RELEASE_BARRIER                           \
> -                       "       amoswap.w %0, %2, %1\n"                 \
> -                       : "=3Dr" (__ret), "+A" (*__ptr)                  =
 \
> -                       : "r" (__new)                                   \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       case 8:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       RISCV_RELEASE_BARRIER                           \
> -                       "       amoswap.d %0, %2, %1\n"                 \
> -                       : "=3Dr" (__ret), "+A" (*__ptr)                  =
 \
> -                       : "r" (__new)                                   \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       default:                                                        \
> -               BUILD_BUG();                                            \
> -       }                                                               \
> -       __ret;                                                          \
> -})
> +       ___xchg(ptr, new, size, "", RISCV_RELEASE_BARRIER, "")
>
>  #define arch_xchg_release(ptr, x)                                      \
> -({                                                                     \
> -       __typeof__(*(ptr)) _x_ =3D (x);                                  =
 \
> -       (__typeof__(*(ptr))) __xchg_release((ptr),                      \
> -                                           _x_, sizeof(*(ptr)));       \
> -})
> +       _arch_xchg(_release, ptr, x)
>
>  #define __xchg(ptr, new, size)                                         \
> -({                                                                     \
> -       __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
> -       __typeof__(new) __new =3D (new);                                 =
 \
> -       __typeof__(*(ptr)) __ret;                                       \
> -       switch (size) {                                                 \
> -       case 4:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "       amoswap.w.aqrl %0, %2, %1\n"            \
> -                       : "=3Dr" (__ret), "+A" (*__ptr)                  =
 \
> -                       : "r" (__new)                                   \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       case 8:                                                         \
> -               __asm__ __volatile__ (                                  \
> -                       "       amoswap.d.aqrl %0, %2, %1\n"            \
> -                       : "=3Dr" (__ret), "+A" (*__ptr)                  =
 \
> -                       : "r" (__new)                                   \
> -                       : "memory");                                    \
> -               break;                                                  \
> -       default:                                                        \
> -               BUILD_BUG();                                            \
> -       }                                                               \
> -       __ret;                                                          \
> -})
> +       ___xchg(ptr, new, size, ".aqrl", "", "")
>
>  #define arch_xchg(ptr, x)                                              \
> -({                                                                     \
> -       __typeof__(*(ptr)) _x_ =3D (x);                                  =
 \
> -       (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));        \
> -})
> +       _arch_xchg(, ptr, x)
>
>  #define xchg32(ptr, x)                                                 \
>  ({                                                                     \
> --
> 2.40.0
>

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
