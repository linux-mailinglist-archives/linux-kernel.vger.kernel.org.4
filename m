Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1AA73C9C7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 10:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjFXI4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 04:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFXI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 04:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4A01B4;
        Sat, 24 Jun 2023 01:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAA8760C26;
        Sat, 24 Jun 2023 08:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57210C433C8;
        Sat, 24 Jun 2023 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687596988;
        bh=fkL6o9zl3IO9B+Poh7aiIAOqjv3N+PZZFjiW5ZLnhtM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ps5kDxngVdR9s+/DY7KzB2Ino2c8W6L10uc3gr+bDRH5tbAtbtqBdr4NHdVrYRj99
         tw2yHZEx7VXa/pMgEU8W+oFyKG9G40aDbPzjAQvGOsQPoihZPcVd5WyCDOsKydSJQd
         sRAMf8K+mWKMQ+u3B5FvA4GOIdaVlXuZtwHa7Z/SXaMVTsJ9ticRS20Q1nYvK4INBj
         tw9ktIJ+fGSCv/dYqr57B/TGEfDB7ULN+DqSf4n3B6vkZhFUWANNxll+HH/BZmqB2I
         hriHPrjhcAF8vr1q4+wPbym9AAN+95X9MkuQZ5PT5CkwwRNtivNlFojLRJk43eZUWv
         dXtnMa/NiKU6g==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-560b56b638eso1073976eaf.0;
        Sat, 24 Jun 2023 01:56:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDzQ121anAxmAznt36Z83DRkfcki9wt9BRtlwnceFhec7oChkMli
        XB797cAY6HTEtromoKE0KfkZAS3Gd8kxt+2OEro=
X-Google-Smtp-Source: ACHHUZ6Rxjlw09B9AfcMdOk4yVBiCEexdU6PBvftzJi50R/sPwM9QeVgj4w4x7W5kY9EweutnRdKKUI8aU9ch83mAHc=
X-Received: by 2002:a4a:b6c2:0:b0:560:cb1c:1534 with SMTP id
 w2-20020a4ab6c2000000b00560cb1c1534mr4274616ooo.2.1687596987662; Sat, 24 Jun
 2023 01:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230620120521.688124-1-masahiroy@kernel.org> <CAKwvOdmSUkyb_fwDJ-_bKxo65MRWUShc25L5itWt4m4MTYi=yQ@mail.gmail.com>
 <CAK7LNATX+_kr+zKskV7NahpasZBV0P+Ke3g_nW=+vRwcsFL1+g@mail.gmail.com> <CAKwvOdma76CqngFvrstMX0rBkS6XhHwep3V8dj6==LTGhoXxfw@mail.gmail.com>
In-Reply-To: <CAKwvOdma76CqngFvrstMX0rBkS6XhHwep3V8dj6==LTGhoXxfw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 24 Jun 2023 17:55:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAST13Ju4XNH6YDiy_QbfV_2wSGzv6-axLhTPwC54qUvfA@mail.gmail.com>
Message-ID: <CAK7LNAST13Ju4XNH6YDiy_QbfV_2wSGzv6-axLhTPwC54qUvfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] modpost: factor out inst location calculation to section_rel()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 2:01=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jun 22, 2023 at 10:38=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > On Fri, Jun 23, 2023 at 3:25=E2=80=AFAM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Jun 20, 2023 at 5:05=E2=80=AFAM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > > index 6e0b8be32648..2551ac9d5bd3 100644
> > > > --- a/scripts/mod/modpost.c
> > > > +++ b/scripts/mod/modpost.c
> > > > @@ -1519,17 +1512,20 @@ static void section_rel(struct module *mod,=
 struct elf_info *elf,
> > > >                 r_sym =3D ELF_R_SYM(r.r_info);
> > > >  #endif
> > > >                 r.r_addend =3D 0;
> > > > +
> > > > +               loc =3D sym_get_data_by_offset(elf, fsecndx, r.r_of=
fset);
> > >
> > > Can we compute `loc` only for the three machine types?
> >
> >
> >
> > I believe you can compute the location in the same way for any architec=
ture
> > because it is mentioned in ELF spec.
>
> Sure, but perhaps it's wasted work for other machine types?



I guess you missed the following code:


switch (elf->hdr->e_machine) {
case EM_386:
        ...
        break;
case EM_ARM:
        ...
        break;
case EM_MIPS:
        ...
        break;
default:
        fatal("Please add code to calculate addend for this architecture\n"=
);
}




I believe other machines never call this function.
If it occurred, fatal() would immediately errors out,
but I have not heard such a breakage for far.

I believe only i386, mips and arm use REL.
The other architectures are RELA.



--=20
Best Regards
Masahiro Yamada
