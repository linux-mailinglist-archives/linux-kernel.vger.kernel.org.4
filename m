Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDE373B024
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFWFiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFWFh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F81A4;
        Thu, 22 Jun 2023 22:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06F0161984;
        Fri, 23 Jun 2023 05:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F94BC433C0;
        Fri, 23 Jun 2023 05:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687498677;
        bh=Lwdspte5kmMg5dEPLnvcn7KMfrhxlxBZ4Z+Dy3zqjjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zc3F01Yc3bg4EpcR3iux9ivHi4jLG9MpMuJbdM/+rjSb3OWxNDPkgKLBSEehZDnWT
         QclblmYFfIWS/RUBTh2CLvzRJqMHd1PrhNNs4/8fyu8WpPe+wtoJMqRVr2qA0hIVKm
         RyyyWfpen2NxwSS8fLdujGfAAGlF8KZsBBkjRDvwFAGCUtw4cuOv0CisHCTAihI9sS
         xph0vBKyxUAFONh+ysP7cLMWUhAhRK2sJ9/bNuuVFvwULw4hwPey/6wcEZO1v8P8zb
         7uWhKc4hwvu0Ez1DM0DDoES/m3HHdz7XYPTwA8mSk3KLEXWAgqaP4IplOTp9o0951W
         PJJQtcUsU+wqA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1a9a42edfc9so185774fac.0;
        Thu, 22 Jun 2023 22:37:57 -0700 (PDT)
X-Gm-Message-State: AC+VfDzyfs/7BBFnNrHnlGgeNbC8A7dNSSfnAG91aMpShImJL7dDGweG
        neRUZ/mG4sTfFtO6YgCyBUYKLAWaXZWgMoAqDe0=
X-Google-Smtp-Source: ACHHUZ6ncWhvrZPy43tSDmHA/gPCfjSdYrrEbpQBGr+KsSaA8U4uwdQmFRySwuKHztbRTlkohgNBciuoY1lw8qct2X8=
X-Received: by 2002:a05:6870:b285:b0:1a9:71c3:b7c2 with SMTP id
 c5-20020a056870b28500b001a971c3b7c2mr11812001oao.50.1687498676800; Thu, 22
 Jun 2023 22:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230620120521.688124-1-masahiroy@kernel.org> <CAKwvOdmSUkyb_fwDJ-_bKxo65MRWUShc25L5itWt4m4MTYi=yQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmSUkyb_fwDJ-_bKxo65MRWUShc25L5itWt4m4MTYi=yQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 23 Jun 2023 14:37:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATX+_kr+zKskV7NahpasZBV0P+Ke3g_nW=+vRwcsFL1+g@mail.gmail.com>
Message-ID: <CAK7LNATX+_kr+zKskV7NahpasZBV0P+Ke3g_nW=+vRwcsFL1+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] modpost: factor out inst location calculation to section_rel()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 3:25=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jun 20, 2023 at 5:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > All the addend_*_rel() functions calculate the instruction location in
> > the same way.
> >
> > Factor out the similar code to the caller. Squash reloc_location() too.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 28 ++++++++++++----------------
> >  1 file changed, 12 insertions(+), 16 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 6e0b8be32648..2551ac9d5bd3 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1256,16 +1256,9 @@ static void check_section_mismatch(struct module=
 *mod, struct elf_info *elf,
> >                                  tosec, taddr);
> >  }
> >
> > -static unsigned int *reloc_location(struct elf_info *elf,
> > -                                   Elf_Shdr *sechdr, Elf_Rela *r)
> > -{
> > -       return sym_get_data_by_offset(elf, sechdr->sh_info, r->r_offset=
);
> > -}
> > -
> > -static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_=
Rela *r)
> > +static int addend_386_rel(uint32_t *location, Elf_Rela *r)
> >  {
> >         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> > -       unsigned int *location =3D reloc_location(elf, sechdr, r);
> >
> >         switch (r_typ) {
> >         case R_386_32:
> > @@ -1302,11 +1295,10 @@ static int32_t sign_extend32(int32_t value, int=
 index)
> >         return (int32_t)(value << shift) >> shift;
> >  }
> >
> > -static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_=
Rela *r)
> > +static int addend_arm_rel(void *loc, struct elf_info *elf, Elf_Rela *r=
)
> >  {
> >         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> >         Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
> > -       void *loc =3D reloc_location(elf, sechdr, r);
> >         uint32_t inst, upper, lower, sign, j1, j2;
> >         int32_t offset;
> >
> > @@ -1396,11 +1388,10 @@ static int addend_arm_rel(struct elf_info *elf,=
 Elf_Shdr *sechdr, Elf_Rela *r)
> >         return 0;
> >  }
> >
> > -static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf=
_Rela *r)
> > +static int addend_mips_rel(uint32_t *location, Elf_Rela *r)
> >  {
> >         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> > -       unsigned int *location =3D reloc_location(elf, sechdr, r);
> > -       unsigned int inst;
> > +       uint32_t inst;
> >
> >         if (r_typ =3D=3D R_MIPS_HI16)
> >                 return 1;       /* skip this */
> > @@ -1502,6 +1493,8 @@ static void section_rel(struct module *mod, struc=
t elf_info *elf,
> >                 return;
> >
> >         for (rel =3D start; rel < stop; rel++) {
> > +               void *loc;
> > +
> >                 r.r_offset =3D TO_NATIVE(rel->r_offset);
> >  #if KERNEL_ELFCLASS =3D=3D ELFCLASS64
> >                 if (elf->hdr->e_machine =3D=3D EM_MIPS) {
> > @@ -1519,17 +1512,20 @@ static void section_rel(struct module *mod, str=
uct elf_info *elf,
> >                 r_sym =3D ELF_R_SYM(r.r_info);
> >  #endif
> >                 r.r_addend =3D 0;
> > +
> > +               loc =3D sym_get_data_by_offset(elf, fsecndx, r.r_offset=
);
>
> Can we compute `loc` only for the three machine types?



I believe you can compute the location in the same way for any architecture
because it is mentioned in ELF spec.

https://refspecs.linuxfoundation.org/elf/elf.pdf

Page 36.


r_offset
  This member gives the location at which to apply the relocation action. F=
or
  a relocatable file, the value is the byte offset from the beginning of th=
e
  section to the storage unit affected by the relocation.







--=20
Best Regards
Masahiro Yamada
