Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF870C516
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjEVSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEVSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:23:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71869102
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:23:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f6b34d2fdcso5120721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684779795; x=1687371795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbrF66782gMp7E+VZpbT67SJHQXbUM0rgrhZdfICKUM=;
        b=qI/gatsyKpFkiHABlFgfbDuyqnn8mtPHokdRrnFUfIRRZnAuxzJyaon19+xamzDglW
         PMYVNPqzbB3IhD4oKay/cwNlIAVQ8nWD9km/S7Z1ExXJEpASuA5tqNnraYHGFZx0xwOW
         /3jqLPWh+J5vT98oUJ4Ry011ImuMpheBYHpZKPbQhPbOas5IuD/sVjjWs1DxQMN3lXkc
         +tuwttrbWLcQNJI6QXgGoCXMc9HFN1xiwBPSNtwTAtMsNpPhDbU+bZgqkdpvDcH8Coyd
         CACeSXizET2w00ifRSg3v9Pj3o2qrTe7L5I3nmIxeqyfzZadMOkFTEMYN0lKDsyAILlb
         fjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684779795; x=1687371795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbrF66782gMp7E+VZpbT67SJHQXbUM0rgrhZdfICKUM=;
        b=iz6jPjTPUKfpNutu8PE0hQSiZMu9QDA43sNjJcFqQ+f02QfwyWs7jXF7PxxYZhIF/R
         1v+rYztrrOFD5hAbHShc+G2QxPQCFPJXdy4Y5dxmNmawWqgmtUcDdw+Z27DrlSJKqpXv
         BksSl0YAWmzbL20Fjxsh8Mn/HQHOP26d7fu7MwHAy6TFEZeubK/A9OvCBrvhiboRTZRO
         lUHmjKeGskRa7MrzeC3gm2ybZMl6x+PCJChwRTrbRJVa0V9tdmomjYfnL9FXRsJySRg4
         KCuCESoyTuU3M7ZgaKSllLhq61mHgFSadBuVZBoQO5iab13kLxZdwQz5mqmkzbWDf/3E
         5NMA==
X-Gm-Message-State: AC+VfDwbDFBf832Oow0pZaEemu2vjmHWjMOViMGZsQCmicHXmfY4FUAV
        9ZUw8yC5JKu2Pc18VWlxOX6+gkP1qkoJuyagvvBe43UoJx8R2X9lbmA=
X-Google-Smtp-Source: ACHHUZ40G2TVkfoNh3ObU4yxVyOjq8n3PVyF+8FM2MY0nQuPoe8S1Azrh2BRKR8OZv8kMd2swae9mlKBNGWpVsS9JbA=
X-Received: by 2002:a05:622a:44e:b0:3ed:a2f5:f27c with SMTP id
 o14-20020a05622a044e00b003eda2f5f27cmr19173756qtx.12.1684779795122; Mon, 22
 May 2023 11:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-7-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-7-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 11:23:04 -0700
Message-ID: <CAKwvOd=rV7gR9kpS3-qCH_H30PurGhoz5OmF5R3b7KvWBpqVCg@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] modpost: unify 'sym' and 'to' in default_mismatch_handler()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> find_tosym() takes 'sym' and stores the return value to another
> variable 'to'. You can use the same variable because we want to
> replace the original one when appropriate.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 6ac0d571542c..7848bacd4b42 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1166,11 +1166,10 @@ static bool is_executable_section(struct elf_info=
 *elf, unsigned int secndx)
>
>  static void default_mismatch_handler(const char *modname, struct elf_inf=
o *elf,
>                                      const struct sectioncheck* const mis=
match,
> -                                    Elf_Rela *r, Elf_Sym *sym,
> +                                    Elf_Rela *r, Elf_Sym *tsym,
>                                      unsigned int fsecndx, const char *fr=
omsec,
>                                      const char *tosec)
>  {
> -       Elf_Sym *to;
>         Elf_Sym *from;
>         const char *tosym;
>         const char *fromsym;
> @@ -1178,8 +1177,8 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>         from =3D find_fromsym(elf, r->r_offset, fsecndx);
>         fromsym =3D sym_name(elf, from);
>
> -       to =3D find_tosym(elf, r->r_addend, sym);
> -       tosym =3D sym_name(elf, to);
> +       tsym =3D find_tosym(elf, r->r_addend, tsym);
> +       tosym =3D sym_name(elf, tsym);
>
>         /* check whitelist - we may ignore it */
>         if (!secref_whitelist(fromsec, fromsym, tosec, tosym))
> @@ -1214,7 +1213,7 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>                               "You might get more information about where=
 this is\n"
>                               "coming from by using scripts/check_extable=
.sh %s\n",
>                               fromsec, (long)r->r_offset, tosec, modname)=
;
> -               else if (is_executable_section(elf, get_secindex(elf, sym=
)))
> +               else if (is_executable_section(elf, get_secindex(elf, tsy=
m)))
>                         warn("The relocation at %s+0x%lx references\n"
>                              "section \"%s\" which is not in the list of\=
n"
>                              "authorized sections.  If you're adding a ne=
w section\n"
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
