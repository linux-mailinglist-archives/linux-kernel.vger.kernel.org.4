Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55D66615D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjAKRHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjAKRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:06:36 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30DE3D5C5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:04:32 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i65so8413609pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P78j3kGdgbF9v+wVhjVXmiioDAvHYt+bU3WJdRcxjVc=;
        b=C2UHUU75bCsITqXMa69Uq2TNgTJ3Znhtsr+7JDI2XoJ6CCtRsvdhRA9ITmF95/igPs
         kL8F+gGvg1t+nD5/mspHv+XVGXY2JRu7wpx84uZiNW+r4I0YfWmFfp+y+4WNsXsm07P2
         M45Dc/AwtLaQASmTND4j4dJnx6DPqiwAMefAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P78j3kGdgbF9v+wVhjVXmiioDAvHYt+bU3WJdRcxjVc=;
        b=Qjdezkl3FR+oGRXsT8Ae/c8IXdu7MEWs3KgX6vYVY8LOcZHxIq7B+XMiekxrsyzYIT
         FSTuAWygJKyrljSzYIo0xCpmvmxoUlveh/Onj4TmE9RvdVt7tX28hVTNorzVZ2JC7jjW
         3Cj00uad+91fBPVGqHRCID0nh4wnTw+lmPqA2IIpwBMO3cyEYuy3dUbnsKeTVaoYYFGD
         +x8X0SSn1s5VgD8K1fKrIF4B12chUZHmS+RegxkOcuCeKnDD9QFwTSeY999fOSiDcJFB
         Kt9FTd6ZWcUPzHkc3bnJZSKpTdUEMQfpCUUQi0hARhpGzp4bNlffedZiRjqjiOi1Eoi5
         Hm1A==
X-Gm-Message-State: AFqh2koR/c6+BueYj9SHuQrguVjRIyNycq5ODgABVQ9geBx0awuVjKtU
        yAkPgKlK7gB7hiUyGptgyTsviu5w8aqlzgyaUlA6TA==
X-Google-Smtp-Source: AMrXdXuWvmJNAU7a++adQ+TBpesZus/OcSWjKd5zaXgS/SxyQcz0yAMStzIxmwYW+Xwfe/cW6ws0Jfe1BEVp978x/NA=
X-Received: by 2002:aa7:9584:0:b0:582:46a4:87dc with SMTP id
 z4-20020aa79584000000b0058246a487dcmr3290795pfj.2.1673456672340; Wed, 11 Jan
 2023 09:04:32 -0800 (PST)
MIME-Version: 1.0
References: <CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com>
 <26bd2928-9d62-32b3-4f9f-9dd9293cefeb@leemhuis.info> <CAK7LNAQ5VVRdrewtxrBdw561LL=yY8fdr=i1e7pp4DRht=r_Ww@mail.gmail.com>
 <0ab93345-18e1-15c9-a4a3-066ea1cd862b@leemhuis.info> <CAMj1kXE+LBOBavOre1O8LTGPCmB8m58fbfo92Sx4WukyNAur-A@mail.gmail.com>
 <CAK7LNATQ-NjYxPvGf4o6N5mp9kS07fpphcEn4_9LOMtS2nTbmQ@mail.gmail.com>
In-Reply-To: <CAK7LNATQ-NjYxPvGf4o6N5mp9kS07fpphcEn4_9LOMtS2nTbmQ@mail.gmail.com>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 11 Jan 2023 11:04:21 -0600
Message-ID: <CAFxkdAowJuVu_XGDQsWGqm_ofA+GVjz6jNsgUnskSsAydmgLhQ@mail.gmail.com>
Subject: Re: BUG: arm64: missing build-id from vmlinux
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 8:17 PM Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
>
> On Thu, Dec 22, 2022 at 8:53 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 21 Dec 2022 at 17:29, Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> > >
> > > On 21.12.22 16:39, Masahiro Yamada wrote:
> > > > On Wed, Dec 21, 2022 at 5:23 PM Thorsten Leemhuis
> > > > <regressions@leemhuis.info> wrote:
> > > >>
> > > >> Hi, this is your Linux kernel regression tracker. CCing the regres=
sion
> > > >> mailing list, as it should be in the loop for all regressions:
> > > >> https://docs.kernel.org/admin-guide/reporting-regressions.html
> > > >>
> > > >> On 18.12.22 21:51, Dennis Gilmore wrote:
> > > >>> The changes in https://lore.kernel.org/linux-arm-kernel/166783716=
442.32724.935158280857906499.b4-ty@kernel.org/T/
> > > >>> result in vmlinux no longer having a build-id.
> > > >>
> > > >> FWIW, that's 994b7ac1697b ("arm64: remove special treatment for th=
e link
> > > >> order of head.o") from Masahiro merged through Will this cycle.
> > > >>
> > > >>> At the least, this
> > > >>> causes rpm builds to fail. Reverting the patch does bring back a
> > > >>> build-id, but there may be a different way to fix the regression
> > > >>
> > > >> Makes me wonder if other distros or CIs relying on the build-id ar=
e
> > > >> broken, too.
> > > >>
> > > >> Anyway, the holiday season is upon us, hence I also wonder if it w=
ould
> > > >> be best to revert above change quickly and leave further debugging=
 for 2023.
> > > >>
> > > >> Masahiro, Will, what's your option on this?
> > >
> > > Masahiro, many thx for looking into this.
> > >
> > > > I do not understand why you rush into the revert so quickly.
> > > > We are before -rc1.
> > > > We have 7 weeks before the 6.2 release
> > > > (assuming we will have up to -rc7).
> > > >
> > > > If we get -rc6 or -rc7 and we still do not
> > > > solve the issue, we should consider reverting it.
> > >
> > > Because it looked like a regression that makes it harder for people a=
nd
> > > CI systems to build and test mainline. To quote
> > > Documentation/process/handling-regressions.rst (
> > > https://docs.kernel.org/process/handling-regressions.html ):
> > >
> > > """
> > >  * Fix regressions within two or three days, if they are critical for
> > > some reason =E2=80=93 for example, if the issue is likely to affect m=
any users
> > > of the kernel series in question on all or certain architectures. Not=
e,
> > > this includes mainline, as issues like compile errors otherwise might
> > > prevent many testers or continuous integration systems from testing t=
he
> > > series.
> > > """
> > >
> > > I suspect that other distros rely on the build-id as well. Maybe I'm
> > > wrong with that, but even if only Fedora and derivatives are effected=
 it
> > > will annoy some people. Sure, each can apply the revert, but before t=
hat
> > > everyone affected will spend time debugging the issue first. A quick
> > > revert in mainline (with a reapply later together with a fix) thus IM=
HO
> > > is the most efficient approach afaics.
> > >
> >
> > Agree with Masahiro here.
> >
> > The issue seems to be caused by the fact that whichever object gets
> > linked first gets to decide the type of a section, and so the .notes
> > section will be of type NOTE if head.o gets linked first, or PROGBITS
> > otherwise. The latter PROGBITS type seems to be the result of the
> > compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.
> >
> > The hunk below fixes it for me, by avoiding notes emitted as PROGBITS.
> > I'll leave it to Masahiro to decide whether this should be fixed for
> > arm64 only or for all architectures, but I suspect the latter would be
> > most appropriate.
> >
> > Note that the kernel's rpm-pkg and binrpm-pkg targets seem to be
> > unaffected by this.
>
>
> Thanks for root-causing this.
>
>
> I like to fix this for all architectures because riscv is also broken.
>
> https://lore.kernel.org/lkml/20221224192751.810363-1-masahiroy@kernel.org=
/

Appreciate the patch, this does indeed fix the aarch64 issue as well
and has allowed me to drop the original revert from Fedora.

Jusitn

>
> > diff --git a/arch/arm64/include/asm/assembler.h
> > b/arch/arm64/include/asm/assembler.h
> > index 376a980f2bad08bb..10a172601fe7f53f 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -818,7 +818,7 @@ alternative_endif
> >
> >  #ifdef GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT
> >  .macro emit_aarch64_feature_1_and, feat=3DGNU_PROPERTY_AARCH64_FEATURE=
_1_DEFAULT
> > -       .pushsection .note.gnu.property, "a"
> > +       .pushsection .note.gnu.property, "a", %note
> >         .align  3
> >         .long   2f - 1f
> >         .long   6f - 3f
>
>
> I did not fold this hunk in my patch.
>
> I compiled with CONFIG_ARM64_BTI_KERNEL=3Dy.
>
> .note.gnu.property section in VDSO was already NOTE
> without this hunk.
>
>
>
>
>
>
>
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinu=
x.lds.S
> > index 4c13dafc98b8400f..8a8044dea71b0609 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -160,6 +160,7 @@ SECTIONS
> >         /DISCARD/ : {
> >                 *(.interp .dynamic)
> >                 *(.dynsym .dynstr .hash .gnu.hash)
> > +               *(.note.GNU-stack) # emitted as PROGBITS
> >         }
> >
> >         . =3D KIMAGE_VADDR;
>
>
>
> --
> Best Regards
> Masahiro Yamada
