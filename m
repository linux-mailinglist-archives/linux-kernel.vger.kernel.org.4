Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DE470A852
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjETNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjETNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9EE185;
        Sat, 20 May 2023 06:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A1461202;
        Sat, 20 May 2023 13:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CC3C433EF;
        Sat, 20 May 2023 13:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684588826;
        bh=dRRmQ6Y4HWULY62shVdUhCkQLcBFMPcWXifxi8UXuKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gPWRiqmeFBMpBvHF5Oi/S0ORsVPNAgNnaS6YDMaS6HMnzhAJcMUBjEFkylhM3959+
         RQ75jj7azcw0f0gMgDTA8JWld9o743zISUnqUGN859wsklORSE/zV9xK6cy29NL1hV
         zw9LZ44z8Y7Ohdz5EDroQOIqpbtM9FFX4d78F2jIvuk12cQbi5OfO9q6K22KwD4Cym
         C72rc/dLoNnMtYB2smfEI2CJCtb8GAbhsxeuYFCTUPK1juZoaandc1uH86IKFZ/xsf
         +W13ZeqoJ/gphz7iYpd28QfHSyN/bUOs2lbJgANTNNxfWFB03n1ejMR8vqV6zwpLEh
         rNQ1pkqtYop1A==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3942cd86697so2415876b6e.0;
        Sat, 20 May 2023 06:20:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDyeaT6qDq41tV66U7Q6Wir+KWNRjr25ABS3AGiI5lKa1yoW5SRs
        oRHnCB668UEPQyq565QpyT3dRP6p2ZR1GzXRFVo=
X-Google-Smtp-Source: ACHHUZ4OIynnymrUbFwL6tNR3IEfg0Y5SqGGWfkdSe2tNrwhBkwARi2+vEnIddmQPHt/Z3Gig4XqFZHTLGfJY0zZXUk=
X-Received: by 2002:aca:1215:0:b0:38d:f794:26c with SMTP id
 21-20020aca1215000000b0038df794026cmr2992239ois.56.1684588825816; Sat, 20 May
 2023 06:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-7-masahiroy@kernel.org>
 <CAKwvOdkQex2H4iDLE-D=4_vFebhB86aya6zPEB8rhaQy-HwspQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkQex2H4iDLE-D=4_vFebhB86aya6zPEB8rhaQy-HwspQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 20 May 2023 22:19:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToX+G_9wkmSziU-YZeg9wc2mOGwD-1R-Txrinba4c8RQ@mail.gmail.com>
Message-ID: <CAK7LNAToX+G_9wkmSziU-YZeg9wc2mOGwD-1R-Txrinba4c8RQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/21] modpost: clean up is_executable_section()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 6:10=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 14, 2023 at 8:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > SHF_EXECINSTR is a bit flag (#define SHF_EXECINSTR 0x4).
> > Compare the masked flag to '!=3D 0'.
> >
> > There is no good reason to stop modpost immediately even if a special
> > section index is given. You will get a section mismatch error anyway.
> >
> > Also, change the return type to bool.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Moving the definition and renaming the parameter seems very
> unnecessary, but whatever. Thanks for the patch!


Moving the definition _is_ necessary.

See the next patch, which moves the call-site of
is_executable_section().

The definition must come before the caller.



The current code exceeds 80-cols per line.

I renamed the parameters so that the lines
fit within 80-cols without wrapping.





> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >
> >  scripts/mod/modpost.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index bb7d1d87bae7..0bda2f22c985 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1207,6 +1207,14 @@ static Elf_Sym *find_elf_symbol2(struct elf_info=
 *elf, Elf_Addr addr,
> >         return near;
> >  }
> >
> > +static bool is_executable_section(struct elf_info *elf, unsigned int s=
ecndx)
> > +{
> > +       if (secndx > elf->num_sections)
> > +               return false;
> > +
> > +       return (elf->sechdrs[secndx].sh_flags & SHF_EXECINSTR) !=3D 0;
> > +}
> > +
> >  static void default_mismatch_handler(const char *modname, struct elf_i=
nfo *elf,
> >                                      const struct sectioncheck* const m=
ismatch,
> >                                      Elf_Rela *r, Elf_Sym *sym, const c=
har *fromsec)
> > @@ -1252,14 +1260,6 @@ static void default_mismatch_handler(const char =
*modname, struct elf_info *elf,
> >         }
> >  }
> >
> > -static int is_executable_section(struct elf_info* elf, unsigned int se=
ction_index)
> > -{
> > -       if (section_index > elf->num_sections)
> > -               fatal("section_index is outside elf->num_sections!\n");
> > -
> > -       return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) =
=3D=3D SHF_EXECINSTR);
> > -}
> > -
> >  static void extable_mismatch_handler(const char* modname, struct elf_i=
nfo *elf,
> >                                      const struct sectioncheck* const m=
ismatch,
> >                                      Elf_Rela* r, Elf_Sym* sym,
> > --
> > 2.39.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Best Regards
Masahiro Yamada
