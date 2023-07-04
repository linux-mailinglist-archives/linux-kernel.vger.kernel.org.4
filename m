Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC74746727
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGDCJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGDCJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C162E54
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688436514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46XvS/ZkZ0FJYtl/GBx+Zabgt+PEnyCPVYQ/cTleKgo=;
        b=HY5SOzX7nHsax1cX4YzHtxXK8vU6j1l5BKlMmlAkmTJdSBHScgA7JqpGMvBmB6mxE/waoE
        yhZE8MqkI8cy0vnKlms2Xxl+Tr2c0g09heEOQygMITqIs28s/SlcKv/i8NvcrCxinJY0rm
        BAMZorjP3oXR6HhpfBFb9tvP370scns=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-QlBh21MBNFS96poHWFVGeQ-1; Mon, 03 Jul 2023 22:08:33 -0400
X-MC-Unique: QlBh21MBNFS96poHWFVGeQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e3871cf9so36919926d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 19:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688436512; x=1691028512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46XvS/ZkZ0FJYtl/GBx+Zabgt+PEnyCPVYQ/cTleKgo=;
        b=IlcSj7C0n2cc45kpspFlScEs4lzd5T03qU+K8JVRNhCTYelT2ToL7xrJp4CMVHREKb
         5j2nK1DJ/IDeBKnTOyPAW3n8VIICZG+NEauek4PCjf6G76TNriAVXeVFP25DMnz/nEpp
         nAaxwQ5K8vHGcmJWMXmos4l9fLZp6z/Rss4RIu9E4FE4quRSqbwL0QkARNfOTwFB+Nk8
         raoy9ZcWvVAZVWbcVwuoHeG+8TYSaGzZri9yqRtmVelqqex6JCm5cC9IZ6sxgdfmj4t5
         cOm2nQlDtMvUPjaq4UGY62bE9L/A2EdmdGOJPSjGm2C7/Sjh2XqC39Zsa45aQnzwao8Q
         zMeQ==
X-Gm-Message-State: ABy/qLb5u1rBsochNnZK8ZK5TPeA+2jujw7la/6uv9N8Q8C3sWN4WAvB
        ikc7AENKOTuVG5JzrL0/aWojpY1N0juYrcPumcViFU63ZHzqUglE7qjSWerdGwdBJCaP14aeXHY
        Zk5+yi9TMfUpDOwmAzdJ5+qRDIDTinoRD
X-Received: by 2002:a0c:ebc1:0:b0:635:ea31:5219 with SMTP id k1-20020a0cebc1000000b00635ea315219mr10480996qvq.51.1688436512479;
        Mon, 03 Jul 2023 19:08:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG42r0lnR4TShQx8Zb9i18v4YtybIifW85OFfwItXTBQeetBlU5ni0l6x/iS4lq1ryi269zRA==
X-Received: by 2002:a0c:ebc1:0:b0:635:ea31:5219 with SMTP id k1-20020a0cebc1000000b00635ea315219mr10480985qvq.51.1688436512203;
        Mon, 03 Jul 2023 19:08:32 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a800:faf8:1d15:affc:4ee8:6427? ([2804:1b3:a800:faf8:1d15:affc:4ee8:6427])
        by smtp.gmail.com with ESMTPSA id ec17-20020ad44e71000000b00632191a70a2sm11803036qvb.103.2023.07.03.19.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 19:08:31 -0700 (PDT)
Message-ID: <4f204c80c0a5ccb1ba88661d6f3ffea2737a2b0b.camel@redhat.com>
Subject: Re: [RFC PATCH 1/1] riscv/atomic.h: Deduplicate arch_atomic.*
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Mon, 03 Jul 2023 23:08:29 -0300
In-Reply-To: <CAJF2gTRZO2hogUbZvj0f41JJvmqLNz-MKTHJshgdhNMpp9Bc8w@mail.gmail.com>
References: <20230419062505.257231-1-leobras@redhat.com>
         <CAJ6HWG6nPdUQ_2_fSj6J7ZE7FB-T+VWT-kq9oW8BLTUtuQEWxA@mail.gmail.com>
         <CAJF2gTRZO2hogUbZvj0f41JJvmqLNz-MKTHJshgdhNMpp9Bc8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-25 at 18:06 +0800, Guo Ren wrote:
> On Thu, May 25, 2023 at 5:31=E2=80=AFPM Leonardo Bras Soares Passos
> <leobras@redhat.com> wrote:
> >=20
> > Friendly ping?
> >=20
> > On Wed, Apr 19, 2023 at 3:25=E2=80=AFAM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >=20
> > > Some functions use mostly the same asm for 32-bit and 64-bit versions=
.
> > >=20
> > > Make a macro that is generic enough and avoid code duplication.
> > >=20
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > ---
> > >  arch/riscv/include/asm/atomic.h | 164 +++++++++++++++---------------=
--
> > >  1 file changed, 76 insertions(+), 88 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm=
/atomic.h
> > > index 0dfe9d857a762..85eb2edbc8219 100644
> > > --- a/arch/riscv/include/asm/atomic.h
> > > +++ b/arch/riscv/include/asm/atomic.h
> > > @@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
> > >  #undef ATOMIC_FETCH_OP
> > >  #undef ATOMIC_OP_RETURN
> > >=20
> > > +#define _arch_atomic_fetch_add_unless(_prev, _rc, counter, _a, _u, s=
fx)        \
> > > +({                                                                  =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               "0:     lr." sfx "     %[p],  %[c]\n"                =
   \
> > > +               "       beq            %[p],  %[u], 1f\n"            =
   \
> > > +               "       add            %[rc], %[p], %[a]\n"          =
   \
> > > +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"         =
   \
> > > +               "       bnez           %[rc], 0b\n"                  =
   \
> > > +               "       fence          rw, rw\n"                     =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (cou=
nter)  \
> > > +               : [a]"r" (_a), [u]"r" (_u)                           =
   \
> > > +               : "memory");                                         =
   \
> > > +})
> > > +
> > >  /* This is required to provide a full barrier on success. */
> > >  static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v,=
 int a, int u)
> > >  {
> > >         int prev, rc;
> > >=20
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.w     %[p],  %[c]\n"
> > > -               "       beq      %[p],  %[u], 1f\n"
> > > -               "       add      %[rc], %[p], %[a]\n"
> > > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > -               "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               : [a]"r" (a), [u]"r" (u)
> > > -               : "memory");
> > > +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "w"=
);
> > > +
> > >         return prev;
> > >  }
> > >  #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
> > > @@ -222,17 +228,8 @@ static __always_inline s64 arch_atomic64_fetch_a=
dd_unless(atomic64_t *v, s64 a,
> > >         s64 prev;
> > >         long rc;
> > >=20
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.d     %[p],  %[c]\n"
> > > -               "       beq      %[p],  %[u], 1f\n"
> > > -               "       add      %[rc], %[p], %[a]\n"
> > > -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > > -               "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               : [a]"r" (a), [u]"r" (u)
> > > -               : "memory");
> > > +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "d"=
);
> > > +
> > >         return prev;
> > >  }
> > >  #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unles=
s
> > > @@ -310,61 +307,79 @@ ATOMIC_OPS()
> > >  #undef ATOMIC_OPS
> > >  #undef ATOMIC_OP
> > >=20
> > > +#define _arch_atomic_inc_unless_negative(_prev, _rc, counter, sfx)  =
   \
> > > +({                                                                  =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               "0:     lr." sfx "      %[p],  %[c]\n"               =
   \
> > > +               "       bltz            %[p],  1f\n"                 =
   \
> > > +               "       addi            %[rc], %[p], 1\n"            =
   \
> > > +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"        =
   \
> > > +               "       bnez            %[rc], 0b\n"                 =
   \
> > > +               "       fence           rw, rw\n"                    =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (cou=
nter)  \
> > > +               :                                                    =
   \
> > > +               : "memory");                                         =
   \
> > > +})
> > > +
> > >  static __always_inline bool arch_atomic_inc_unless_negative(atomic_t=
 *v)
> > >  {
> > >         int prev, rc;
> > >=20
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.w      %[p],  %[c]\n"
> > > -               "       bltz      %[p],  1f\n"
> > > -               "       addi      %[rc], %[p], 1\n"
> > > -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > > -               "       bnez      %[rc], 0b\n"
> > > -               "       fence     rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "w");
> > > +
> > >         return !(prev < 0);
> > >  }
> > >=20
> > >  #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negat=
ive
> > >=20
> > > +#define _arch_atomic_dec_unless_positive(_prev, _rc, counter, sfx)  =
   \
> > > +({                                                                  =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               "0:     lr." sfx "      %[p],  %[c]\n"               =
   \
> > > +               "       bgtz            %[p],  1f\n"                 =
   \
> > > +               "       addi            %[rc], %[p], -1\n"           =
   \
> > > +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"        =
   \
> > > +               "       bnez            %[rc], 0b\n"                 =
   \
> > > +               "       fence           rw, rw\n"                    =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (cou=
nter)  \
> > > +               :                                                    =
   \
> > > +               : "memory");                                         =
   \
> > > +})
> > > +
> > >  static __always_inline bool arch_atomic_dec_unless_positive(atomic_t=
 *v)
> > >  {
> > >         int prev, rc;
> > >=20
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.w      %[p],  %[c]\n"
> > > -               "       bgtz      %[p],  1f\n"
> > > -               "       addi      %[rc], %[p], -1\n"
> > > -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > > -               "       bnez      %[rc], 0b\n"
> > > -               "       fence     rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "w");
> > > +
> > >         return !(prev > 0);
> > >  }
> > >=20
> > >  #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_posit=
ive
> > >=20
> > > +#define _arch_atomic_dec_if_positive(_prev, _rc, counter, sfx)      =
   \
> > > +({                                                                  =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               "0:     lr." sfx "     %[p],  %[c]\n"                =
   \
> > > +               "       addi           %[rc], %[p], -1\n"            =
   \
> > > +               "       bltz           %[rc], 1f\n"                  =
   \
> > > +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"         =
   \
> > > +               "       bnez           %[rc], 0b\n"                  =
   \
> > > +               "       fence          rw, rw\n"                     =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (cou=
nter)  \
> > > +               :                                                    =
   \
> > > +               : "memory");                                         =
   \
> > > +})
> > > +
> > >  static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
> > >  {
> > >         int prev, rc;
> > >=20
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.w     %[p],  %[c]\n"
> > > -               "       addi     %[rc], %[p], -1\n"
> > > -               "       bltz     %[rc], 1f\n"
> > > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > -               "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "w");
> > > +
> > >         return prev - 1;
> > >  }
> > >=20
> > > @@ -376,17 +391,8 @@ static __always_inline bool arch_atomic64_inc_un=
less_negative(atomic64_t *v)
> > >         s64 prev;
> > >         long rc;
> > >=20
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.d      %[p],  %[c]\n"
> > > -               "       bltz      %[p],  1f\n"
> > > -               "       addi      %[rc], %[p], 1\n"
> > > -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > > -               "       bnez      %[rc], 0b\n"
> > > -               "       fence     rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "d");
> > > +
> > >         return !(prev < 0);
> > >  }
> > >=20
> > > @@ -397,17 +403,8 @@ static __always_inline bool arch_atomic64_dec_un=
less_positive(atomic64_t *v)
> > >         s64 prev;
> > >         long rc;
> > >=20
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.d      %[p],  %[c]\n"
> > > -               "       bgtz      %[p],  1f\n"
> > > -               "       addi      %[rc], %[p], -1\n"
> > > -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > > -               "       bnez      %[rc], 0b\n"
> > > -               "       fence     rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "d");
> > > +
> > >         return !(prev > 0);
> > >  }
> > >=20
> > > @@ -418,17 +415,8 @@ static __always_inline s64 arch_atomic64_dec_if_=
positive(atomic64_t *v)
> > >         s64 prev;
> > >         long rc;
> > >=20
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.d     %[p],  %[c]\n"
> > > -               "       addi      %[rc], %[p], -1\n"
> > > -               "       bltz     %[rc], 1f\n"
> > > -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > > -               "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "d");
> > > +
> > >         return prev - 1;
> > >  }
> > >=20
> > > --
> > > 2.40.0
> > >=20
> >=20
> A safe cleanup, no problem found.
>=20
> Reviewed-by: Guo Ren <guoren@kernel.org>
>=20
>=20

Hello Palmer,

Any chance this can get in 6.5?

Also, same question for this series:
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D737491

Thanks!
Leo


