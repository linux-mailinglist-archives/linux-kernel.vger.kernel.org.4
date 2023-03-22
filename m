Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5A56C414C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCVDvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCVDvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E866D37F11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679457058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNlFWdd4gAOcCrXrNbyP6okkc3CGWc9YTMAR4mDkx6k=;
        b=HdoUyGVVogdsnLvKd6Tx0Svnx18dR4Z/tnOKtweAfPz0hmmw9mWcLoq8yn1u0JT4EZnJz/
        UKyX/hv9QLdmhCMJWZsIPMLybsaGjXM8DH1o0nrPZNukswuZHTehYl/jeUrW8kxsp2Yxwa
        +lsloCmDCoSqcZJmqdXEHpBQ11qr7mk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-S1lpa_qAMheRa4tebQ0PTg-1; Tue, 21 Mar 2023 23:50:56 -0400
X-MC-Unique: S1lpa_qAMheRa4tebQ0PTg-1
Received: by mail-qt1-f197.google.com with SMTP id l17-20020ac84cd1000000b003bfbae42753so10026507qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679457056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNlFWdd4gAOcCrXrNbyP6okkc3CGWc9YTMAR4mDkx6k=;
        b=hzcVboSNojrcFrn+pClWH2ArqYa4xSgmTaD4CF+tyOwL6/YNrGz81BwduIZu9o5nae
         lZQwyBJh0hLSYpgdNooXgOxDNY8TbjVNBmsLwBPLoyHbtgTHpaw9OwKyuxaWbq/ngkxX
         3Hv+VfVl5bvxGbo5ap0U8pmF9fMGLCqX3r1Wqk5Qm0GU4kmDJjba3slOn7o85fMAKBwd
         SxX3aGVfgqgAU2gCrtKBNZkci5qXLiv7vOt2LUzWdKLa78TexllVFzVeAVJRfyxjO8mo
         QQN/7cbrRfX+FwGtVrpu41XKI3lTM+74u6YL2CFgpa0j2qP04vTXXrOLHGRkQaVlZciV
         2eKg==
X-Gm-Message-State: AO0yUKUIDcfpYFOlW2T13wVttMBueBfUYaJrDwfvwwsoU5ds9jpp9UY8
        kgcDYfr9KlR3x+PPJjEX2okrhWfn7Tkq7v7SqD7ZMvbCo9XZEOX4raOdlrJBOgN05kI2CkPwzGy
        V/WAcUWjgtLPIrRdz/DJ5G5k7sgYyEUcTpTigAs4R
X-Received: by 2002:ad4:48c3:0:b0:56f:3e5:850e with SMTP id v3-20020ad448c3000000b0056f03e5850emr438218qvx.3.1679457056448;
        Tue, 21 Mar 2023 20:50:56 -0700 (PDT)
X-Google-Smtp-Source: AK7set+pe3ZLkMJz/5vA/iTHhmSmf1vSPqf+z6ABtE/sVNs42b8Xk1t0/1qQpY48XD2j88pMDbAjsOGyRWTtvXFyLbY=
X-Received: by 2002:ad4:48c3:0:b0:56f:3e5:850e with SMTP id
 v3-20020ad448c3000000b0056f03e5850emr438213qvx.3.1679457056230; Tue, 21 Mar
 2023 20:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230321074249.2221674-1-leobras@redhat.com> <20230321074249.2221674-2-leobras@redhat.com>
 <ZBpPms0PGv4sWR1Y@andrea>
In-Reply-To: <ZBpPms0PGv4sWR1Y@andrea>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 22 Mar 2023 00:50:45 -0300
Message-ID: <CAJ6HWG46-an3r3WH+n8mHHge8SjqgMbohjTmmk=_EXVmwKZSeA@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v2 1/6] riscv/cmpxchg: Deduplicate cmpxchg()
 asm functions
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 9:45=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> On Tue, Mar 21, 2023 at 04:42:44AM -0300, Leonardo Bras wrote:
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
> > (This did not cause any change in generated asm)
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 102 ++++++++-----------------------
> >  1 file changed, 24 insertions(+), 78 deletions(-)
>
> Diff looks nice,

Hello Andrea, thanks for reviewing!


> > +#define ___cmpxchg(lr_sfx, sc_sfx, prepend, append)                  \
> > +{                                                                    \
> > +     __asm__ __volatile__ (                                          \
> > +             prepend                                                 \
> > +             "0:     lr" lr_sfx " %0, %2\n"                          \
> > +             "       bne  %0, %z3, 1f\n"                             \
> > +             "       sc" sc_sfx " %1, %z4, %2\n"                     \
> > +             "       bnez %1, 0b\n"                                  \
> > +             append                                                  \
> > +             "1:\n"                                                  \
> > +             : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr)         =
   \
> > +             : "rJ" ((long)__old), "rJ" (__new)                      \
> > +             : "memory");                                            \
> > +}
>
> Though I'm not really a fan of macros depending on local variables with
> "magic" names, can this be avoided?

You mean __ret, __rc, __ptr, __old and __new ?
If so, yes, we could add them to the macro signature, but it would
become quite big with not much to gain. To reduce impact it could be
something like:

+#define ___cmpxchg(lr_sfx, sc_sfx, prepend, append, ret, r, p, o, n)

Is this a possible fix?
>
> Thanks,
>   Andrea
>

Thank you!
Leo

