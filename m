Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475EB64CE30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiLNQiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbiLNQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:38:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB03F60C7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:38:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h11so269689wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XQ9UK+L/0iK+KFqjWQesqR3gEiIaaEkyB4WhDQSSEk=;
        b=1sRvZWk4v6BhCyZTXJ2+f46RRZoXBbAchW/Nd0IonBe71PFBY3xQlZJN78/B1C9AOX
         O6U60oJ6kHQUPkFxgtYaux8Z8Fz+bVSKvBTLykYbGs5prvLBsaqwXgWA0XV/ice73Hdf
         oyz7kh52knuU7/BrncKSqlfagE7nHPX4LaaaoYADWYkF3baBh0tDQXVbXNlj+KL6St5x
         lxvKv88iCD2u8zD/Wm89B0n6pfUBOjctLvm+HkFc/sqZG/Bx8btVe/MC/JOZN3vDCW1B
         4i7BO8w0bu5RWUH2A5OAHRRc9OupsX7aegDRYTPXh8MsbK8IJcJlCoNc6CptrKQ2pg50
         ku+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XQ9UK+L/0iK+KFqjWQesqR3gEiIaaEkyB4WhDQSSEk=;
        b=iiHJmWYbSUhpjO4GxHgLPXdWr4l9neY50bmnAmSjIfiNci262/3BTxNUKXXZi94vDd
         IfPMeHtPnLTl1ZzjE8OqKE/zkkBWzJwtfye/k1UUMYfR3MTVRdr7doPvZBxBUgRT2mWB
         a6+YPYNW5eicAlcueweeZPmeRAWdRUmor8QEORHEckNNYB2lWNCgYqCK0qqVEX3hFhBD
         2ys2LYbS8q1yKijhUUlbk+JCDe8T4we87JQXCOI05oLDghUy16PnVNkMA9SkXq/q9t88
         UcJ4goj2Tao+NHK621Yf/6gXHv4mgiEi8B2M2gNSA/Z0MAc0eydB80ycwy392C1am7nY
         P/3w==
X-Gm-Message-State: ANoB5pl1MMJxUkvXr3NYWcneG2V1tM5sEq1KvuwOetEx8eAU9qpS8qUb
        nm+DmxaDxzAu80jB102X5UIcU3eqUrB7PV8rQyNOMQ==
X-Google-Smtp-Source: AA0mqf7Vq9T9tV5/hj5nHZjSecDz/ZDSCVTGbOpMMHcUxGzyHQ6ylbSGIsEibGaAkuvj3IzOFsHOLo7QrFmxZzz/y1E=
X-Received: by 2002:a05:6000:1a4e:b0:242:71b:e3cf with SMTP id
 t14-20020a0560001a4e00b00242071be3cfmr36380152wry.144.1671035899393; Wed, 14
 Dec 2022 08:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20221214143311.960266-1-alexghiti@rivosinc.com> <87cz8m3sha.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87cz8m3sha.fsf@all.your.base.are.belong.to.us>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 14 Dec 2022 17:38:08 +0100
Message-ID: <CAHVXubidb5gQBHSFMJiY=egoi4QOiqOh884VvAhxYqADxNDB6A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Allow to downgrade paging mode from the command line
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 4:39 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
>
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index b56a0a75533f..8140fefe0e57 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -752,12 +752,35 @@ static void __init disable_pgtable_l4(void)
> >   * then read SATP to see if the configuration was taken into account
> >   * meaning sv48 is supported.
> >   */
> > -static __init void set_satp_mode(void)
> > +static __init void set_satp_mode(uintptr_t dtb_pa)
> >  {
> >       u64 identity_satp, hw_satp;
> >       uintptr_t set_satp_mode_pmd =3D ((unsigned long)set_satp_mode) & =
PMD_MASK;
> >       bool check_l4 =3D false;
> >
> > +#ifndef CONFIG_KASAN
> > +     /*
> > +      * The below fdt functions are kasan instrumented, since at this =
point
> > +      * there is no mapping for the kasan shadow memory, this can't be=
 used
> > +      * when kasan is enabled.
> > +      */
> > +     int chosen_node;
> > +
> > +     chosen_node =3D fdt_path_offset((void *)dtb_pa, "/chosen");
> > +     if (chosen_node >=3D 0) {
> > +             const char *cmdline =3D fdt_getprop((void *)dtb_pa, chose=
n_node,
> > +                                               "bootargs", NULL);
>
> The command line handling needs to honor CONFIG_CMDLINE_FORCE and
> CONFIG_CMDLINE_EXTEND (which makes it possible to use no{4,5}lvl *and*
> KASAN ;-)).
>

Indeed, I forgot that, thanks for noticing! I'll prepare the "real"
command line before matching the new parameters.

Thanks again,

Alex

>
> Bj=C3=B6rn
