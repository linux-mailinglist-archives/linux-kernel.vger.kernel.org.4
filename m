Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0D06E6CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjDRTLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjDRTLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB65C188
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681845053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbqlMINcyvGZw5EJOSgi3TNNia/Us47oV6YEr7ubIps=;
        b=b28TyK899GIVsIG5jfl+v1mkEU8QHe8LuZHsETdxhbXbiEhI4eQ8eU3W4GKyw1CtRDRMYi
        gs9Ygd2JrexWeI4snZ9oyafRStwFzvdD85V/4R0o+17nGTkfR0dlC/xMlKV6wvCIsLH+xT
        zMsdLLnkEHNDkP6jkwdZ9MX5q/G4+Qo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-bg-1EzVmOrmYMWSbgZdL6w-1; Tue, 18 Apr 2023 15:10:52 -0400
X-MC-Unique: bg-1EzVmOrmYMWSbgZdL6w-1
Received: by mail-qk1-f200.google.com with SMTP id x141-20020a376393000000b0074de91d159eso3640173qkb.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845052; x=1684437052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbqlMINcyvGZw5EJOSgi3TNNia/Us47oV6YEr7ubIps=;
        b=a50O6qB1pCitnQeseIO/GQ6fQ1r2VBD/yvdGccQLu5ZpgiPH2dJc+QHyT/VHQUG3E6
         K41bofo5ZXVtDnduo6ilQvLlTC+dTYB0gYp3nhWDwCrcGcA3Y3nxXKnDpDhWWCzIcLrl
         lxaSQyAqW9urq3YqgiaJ4/RjRne1+p2zeAyKdpis/VrFejVE94cyntDQWqWvhNJDYbg7
         mh/czNJPqDDsdKwAN06FXBWe8PfDWGuUkjdImGKLBBhx63OVElnkzLdj3FHiS8r3x1RN
         FsluMBmZtxL0vwfpQBEzbRCyIvTrayVU3qzV2UmA9CLcGlOp2hNmM999YAXu+TELZcqk
         exqA==
X-Gm-Message-State: AAQBX9fW4cI8VnR7dVTZuj20JPVyaXFPjWPosxLtA0SF9Jqr7ZG0yEN6
        cA1b2AshjdZxhAPuoSWeHMu3c4kIyCeOwsqXhIAjN8dHTZ6qr9mu1fjR/opayCbyHq8sfuyXUHS
        1g5sEBT16tTjbKVN0EFWS4yX41P99wTiNr/juZjBq
X-Received: by 2002:ac8:5a87:0:b0:3bf:db0a:c105 with SMTP id c7-20020ac85a87000000b003bfdb0ac105mr1893790qtc.6.1681845051840;
        Tue, 18 Apr 2023 12:10:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350bidAVA9Fe6BLxfh2bHDjb6RBdkJByKhXYCUVNNW4ZPxfzBKUDX+6pn2oZN5hA3pqDYvm1mnrGu+wdnsyah31M=
X-Received: by 2002:ac8:5a87:0:b0:3bf:db0a:c105 with SMTP id
 c7-20020ac85a87000000b003bfdb0ac105mr1893744qtc.6.1681845051494; Tue, 18 Apr
 2023 12:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230406082018.70367-1-leobras@redhat.com> <20230406082018.70367-2-leobras@redhat.com>
 <CAJF2gTQOs8ossWXtGMAvk1xRmUnFXub31ETBYLs5oxrdBGVL2Q@mail.gmail.com>
In-Reply-To: <CAJF2gTQOs8ossWXtGMAvk1xRmUnFXub31ETBYLs5oxrdBGVL2Q@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Tue, 18 Apr 2023 16:10:40 -0300
Message-ID: <CAJ6HWG6cjPCWQBNVSeeoC4TFKh3bJqw_B1NJnHws3gTSu+60fg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 5:29=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Apr 6, 2023 at 4:20=E2=80=AFPM Leonardo Bras <leobras@redhat.com>=
 wrote:
> >
> > In this header every cmpxchg define (_relaxed, _acquire, _release,
> > vanilla) contain it's own asm file, both for 4-byte variables an 8-byte
> > variables, on a total of 8 versions of mostly the same asm.
> >
> > This is usually bad, as it means any change may be done in up to 8
> > different places.
> >
> > Unify those versions by creating a new define with enough parameters to
> > generate any version of the previous 8.
> >
> > Then unify the result under a more general define, and simplify
> > arch_cmpxchg* generation
> >
> > (This did not cause any change in generated asm)
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 184 ++++++-------------------------
> >  1 file changed, 36 insertions(+), 148 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index 12debce235e52..f88fae357071c 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -163,51 +163,23 @@
> >   * store NEW in MEM.  Return the initial value in MEM.  Success is
> >   * indicated by comparing RETURN with OLD.
> >   */
> > -#define __cmpxchg_relaxed(ptr, old, new, size)                        =
 \
> > -({                                                                    =
 \
> > -       __typeof__(ptr) __ptr =3D (ptr);                               =
   \
> > -       __typeof__(*(ptr)) __old =3D (old);                            =
   \
> > -       __typeof__(*(ptr)) __new =3D (new);                            =
   \
> > -       __typeof__(*(ptr)) __ret;                                      =
 \
> > -       register unsigned int __rc;                                    =
 \
> > -       switch (size) {                                                =
 \
> > -       case 4:                                                        =
 \
> > -               __asm__ __volatile__ (                                 =
 \
> > -                       "0:     lr.w %0, %2\n"                         =
 \
> > -                       "       bne  %0, %z3, 1f\n"                    =
 \
> > -                       "       sc.w %1, %z4, %2\n"                    =
 \
> > -                       "       bnez %1, 0b\n"                         =
 \
> > -                       "1:\n"                                         =
 \
> > -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr=
)    \
> > -                       : "rJ" ((long)__old), "rJ" (__new)             =
 \
> > -                       : "memory");                                   =
 \
> > -               break;                                                 =
 \
> > -       case 8:                                                        =
 \
> > -               __asm__ __volatile__ (                                 =
 \
> > -                       "0:     lr.d %0, %2\n"                         =
 \
> > -                       "       bne %0, %z3, 1f\n"                     =
 \
> > -                       "       sc.d %1, %z4, %2\n"                    =
 \
> > -                       "       bnez %1, 0b\n"                         =
 \
> > -                       "1:\n"                                         =
 \
> > -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr=
)    \
> > -                       : "rJ" (__old), "rJ" (__new)                   =
 \
> > -                       : "memory");                                   =
 \
> > -               break;                                                 =
 \
> > -       default:                                                       =
 \
> > -               BUILD_BUG();                                           =
 \
> > -       }                                                              =
 \
> > -       __ret;                                                         =
 \
> > -})
> >
> > -#define arch_cmpxchg_relaxed(ptr, o, n)                               =
         \
> > +#define ____cmpxchg(lr_sfx, sc_sfx, prepend, append, r, rc, p, co, o, =
n)\
> >  ({                                                                    =
 \
> > -       __typeof__(*(ptr)) _o_ =3D (o);                                =
   \
> > -       __typeof__(*(ptr)) _n_ =3D (n);                                =
   \
> > -       (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                  =
 \
> > -                                       _o_, _n_, sizeof(*(ptr)));     =
 \
> > +       __asm__ __volatile__ (                                         =
 \
> > +               prepend                                                =
 \
> > +               "0:     lr" lr_sfx " %0, %2\n"                         =
 \
> > +               "       bne  %0, %z3, 1f\n"                            =
 \
> > +               "       sc" sc_sfx " %1, %z4, %2\n"                    =
 \
> > +               "       bnez %1, 0b\n"                                 =
 \
> > +               append                                                 =
 \
> > +               "1:\n"                                                 =
 \
> > +               : "=3D&r" (r), "=3D&r" (rc), "+A" (*(p))               =
     \
> > +               : "rJ" (co o), "rJ" (n)                                =
 \
> > +               : "memory");                                           =
 \
> >  })
> >
> > -#define __cmpxchg_acquire(ptr, old, new, size)                        =
 \
> > +#define ___cmpxchg(ptr, old, new, size, sc_sfx, prepend, append)      =
 \
> >  ({                                                                    =
 \
> >         __typeof__(ptr) __ptr =3D (ptr);                               =
   \
> >         __typeof__(*(ptr)) __old =3D (old);                            =
   \
> > @@ -216,28 +188,12 @@
> >         register unsigned int __rc;                                    =
 \
> >         switch (size) {                                                =
 \
> >         case 4:                                                        =
 \
> > -               __asm__ __volatile__ (                                 =
 \
> > -                       "0:     lr.w %0, %2\n"                         =
 \
> > -                       "       bne  %0, %z3, 1f\n"                    =
 \
> > -                       "       sc.w %1, %z4, %2\n"                    =
 \
> > -                       "       bnez %1, 0b\n"                         =
 \
> > -                       RISCV_ACQUIRE_BARRIER                          =
 \
> > -                       "1:\n"                                         =
 \
> > -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr=
)    \
> > -                       : "rJ" ((long)__old), "rJ" (__new)             =
 \
> > -                       : "memory");                                   =
 \
> > +               ____cmpxchg(".w", ".w" sc_sfx, prepend, append,        =
 \
> > +                           __ret, __rc, __ptr, (long), __old, __new); =
 \
> >                 break;                                                 =
 \
> >         case 8:                                                        =
 \
> > -               __asm__ __volatile__ (                                 =
 \
> > -                       "0:     lr.d %0, %2\n"                         =
 \
> > -                       "       bne %0, %z3, 1f\n"                     =
 \
> > -                       "       sc.d %1, %z4, %2\n"                    =
 \
> > -                       "       bnez %1, 0b\n"                         =
 \
> > -                       RISCV_ACQUIRE_BARRIER                          =
 \
> > -                       "1:\n"                                         =
 \
> > -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr=
)    \
> > -                       : "rJ" (__old), "rJ" (__new)                   =
 \
> > -                       : "memory");                                   =
 \
> > +               ____cmpxchg(".d", ".d" sc_sfx, prepend, append,        =
 \
> > +                           __ret, __rc, __ptr, /**/, __old, __new);   =
 \
> >                 break;                                                 =
 \
> >         default:                                                       =
 \
> >                 BUILD_BUG();                                           =
 \
> > @@ -245,105 +201,37 @@
> >         __ret;                                                         =
 \
> >  })
> >
> > -#define arch_cmpxchg_acquire(ptr, o, n)                               =
         \
> > +#define __cmpxchg_relaxed(ptr, old, new, size)                        =
 \
> > +       ___cmpxchg(ptr, old, new, size, "", "", "")
> > +
> > +#define _arch_cmpxchg(order, ptr, o, n)                               =
         \
> >  ({                                                                    =
 \
> >         __typeof__(*(ptr)) _o_ =3D (o);                                =
   \
> >         __typeof__(*(ptr)) _n_ =3D (n);                                =
   \
> > -       (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                  =
 \
> > -                                       _o_, _n_, sizeof(*(ptr)));     =
 \
> > +       (__typeof__(*(ptr))) __cmpxchg ## order((ptr), _o_, _n_,       =
 \
> > +                                               sizeof(*(ptr)));       =
 \
> >  })
> >
> > +#define arch_cmpxchg_relaxed(ptr, o, n)                               =
         \
> > +       _arch_cmpxchg(_relaxed, ptr, o, n)
> > +
> > +#define __cmpxchg_acquire(ptr, old, new, size)                        =
 \
> > +       ___cmpxchg(ptr, old, new, size, "", "", RISCV_ACQUIRE_BARRIER)
> > +
> > +#define arch_cmpxchg_acquire(ptr, o, n)                               =
         \
> > +       _arch_cmpxchg(_acquire, ptr, o, n)
> > +
> >  #define __cmpxchg_release(ptr, old, new, size)                        =
 \
> > -({                                                                    =
 \
> > -       __typeof__(ptr) __ptr =3D (ptr);                               =
   \
> > -       __typeof__(*(ptr)) __old =3D (old);                            =
   \
> > -       __typeof__(*(ptr)) __new =3D (new);                            =
   \
> > -       __typeof__(*(ptr)) __ret;                                      =
 \
> > -       register unsigned int __rc;                                    =
 \
> > -       switch (size) {                                                =
 \
> > -       case 4:                                                        =
 \
> > -               __asm__ __volatile__ (                                 =
 \
> > -                       RISCV_RELEASE_BARRIER                          =
 \
> > -                       "0:     lr.w %0, %2\n"                         =
 \
> > -                       "       bne  %0, %z3, 1f\n"                    =
 \
> > -                       "       sc.w %1, %z4, %2\n"                    =
 \
> > -                       "       bnez %1, 0b\n"                         =
 \
> > -                       "1:\n"                                         =
 \
> > -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr=
)    \
> > -                       : "rJ" ((long)__old), "rJ" (__new)             =
 \
> > -                       : "memory");                                   =
 \
> > -               break;                                                 =
 \
> > -       case 8:                                                        =
 \
> > -               __asm__ __volatile__ (                                 =
 \
> > -                       RISCV_RELEASE_BARRIER                          =
 \
> > -                       "0:     lr.d %0, %2\n"                         =
 \
> > -                       "       bne %0, %z3, 1f\n"                     =
 \
> > -                       "       sc.d %1, %z4, %2\n"                    =
 \
> > -                       "       bnez %1, 0b\n"                         =
 \
> > -                       "1:\n"                                         =
 \
> > -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr=
)    \
> > -                       : "rJ" (__old), "rJ" (__new)                   =
 \
> > -                       : "memory");                                   =
 \
> > -               break;                                                 =
 \
> > -       default:                                                       =
 \
> > -               BUILD_BUG();                                           =
 \
> > -       }                                                              =
 \
> > -       __ret;                                                         =
 \
> > -})
> > +       ___cmpxchg(ptr, old, new, size, "", RISCV_RELEASE_BARRIER, "")
> >
> >  #define arch_cmpxchg_release(ptr, o, n)                               =
         \
> > -({                                                                    =
 \
> > -       __typeof__(*(ptr)) _o_ =3D (o);                                =
   \
> > -       __typeof__(*(ptr)) _n_ =3D (n);                                =
   \
> > -       (__typeof__(*(ptr))) __cmpxchg_release((ptr),                  =
 \
> > -                                       _o_, _n_, sizeof(*(ptr)));     =
 \
> > -})
> > +       _arch_cmpxchg(_release, ptr, o, n)
> >
> >  #define __cmpxchg(ptr, old, new, size)                                =
 \
> > -({                                                                    =
 \
> > -       __typeof__(ptr) __ptr =3D (ptr);                               =
   \
> > -       __typeof__(*(ptr)) __old =3D (old);                            =
   \
> > -       __typeof__(*(ptr)) __new =3D (new);                            =
   \
> > -       __typeof__(*(ptr)) __ret;                                      =
 \
> > -       register unsigned int __rc;                                    =
 \
> > -       switch (size) {                                                =
 \
> > -       case 4:                                                        =
 \
> > -               __asm__ __volatile__ (                                 =
 \
> > -                       "0:     lr.w %0, %2\n"                         =
 \
> > -                       "       bne  %0, %z3, 1f\n"                    =
 \
> > -                       "       sc.w.rl %1, %z4, %2\n"                 =
 \
> > -                       "       bnez %1, 0b\n"                         =
 \
> > -                       "       fence rw, rw\n"                        =
 \
> > -                       "1:\n"                                         =
 \
> > -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr=
)    \
> > -                       : "rJ" ((long)__old), "rJ" (__new)             =
 \
> > -                       : "memory");                                   =
 \
> > -               break;                                                 =
 \
> > -       case 8:                                                        =
 \
> > -               __asm__ __volatile__ (                                 =
 \
> > -                       "0:     lr.d %0, %2\n"                         =
 \
> > -                       "       bne %0, %z3, 1f\n"                     =
 \
> > -                       "       sc.d.rl %1, %z4, %2\n"                 =
 \
> > -                       "       bnez %1, 0b\n"                         =
 \
> > -                       "       fence rw, rw\n"                        =
 \
> > -                       "1:\n"                                         =
 \
> > -                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr=
)    \
> > -                       : "rJ" (__old), "rJ" (__new)                   =
 \
> > -                       : "memory");                                   =
 \
> > -               break;                                                 =
 \
> > -       default:                                                       =
 \
> > -               BUILD_BUG();                                           =
 \
> > -       }                                                              =
 \
> > -       __ret;                                                         =
 \
> > -})
> > +       ___cmpxchg(ptr, old, new, size, ".rl", "", "    fence rw, rw\n"=
)
> >
> >  #define arch_cmpxchg(ptr, o, n)                                       =
         \
> > -({                                                                    =
 \
> > -       __typeof__(*(ptr)) _o_ =3D (o);                                =
   \
> > -       __typeof__(*(ptr)) _n_ =3D (n);                                =
   \
> > -       (__typeof__(*(ptr))) __cmpxchg((ptr),                          =
 \
> > -                                      _o_, _n_, sizeof(*(ptr)));      =
 \
> > -})
> > +       _arch_cmpxchg(, ptr, o, n)
> >
> >  #define arch_cmpxchg_local(ptr, o, n)                                 =
 \
> >         (__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
> > --
> > 2.40.0
> >
> One patch is much easier to review :)
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
>
> --
> Best Regards
>  Guo Ren
>

Thanks!

