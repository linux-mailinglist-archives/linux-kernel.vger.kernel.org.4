Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7B2728320
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjFHO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbjFHO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A610FB;
        Thu,  8 Jun 2023 07:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A152464E20;
        Thu,  8 Jun 2023 14:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087F9C433A1;
        Thu,  8 Jun 2023 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686236193;
        bh=CZiUnQSwCCU7tqgCmEoGvcv16/6kTQcWTKR0ljqRc8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z8Nc9E40ALbkPxgFM+7K4XpUq4Kmj+P3FjQFcyAmG/9oyak52S0/q5NS1HWOowhph
         BCkSGRzVhSB1T87cDOK5Ev9yO1V7BJms0d45UjUvGGRmBS46p0H7gmQ08O5hJpurG1
         ViuZ2/ly25Pnh4I37yQKoNkt+tpYmvXraEdLuT9ISu5kbaf1t6Sn1UYajt/iP8MdcP
         iJrLVcR4f/1drgO/iiMGQ51Ttm361EcsQIyzViGAiYpzxDfem77viijdI28uyPGM8w
         4CMTpySPlmn+ErlmdDk2RrwPfQ9K1py2n6705nJq65NgpBa9hxbeF6rV95S6zlL21F
         KkQud8md2pDAA==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6b2b6910facso401391a34.1;
        Thu, 08 Jun 2023 07:56:32 -0700 (PDT)
X-Gm-Message-State: AC+VfDwwQMLEIEYBQXx9ggFv9yxVTdjABt3zb6ovmsExOhWfpxwOa9i8
        +Z3yONyzjmdiuRlUWZZ1hVjbTxGjI5/5ncMPAWo=
X-Google-Smtp-Source: ACHHUZ4b52LAMGrIJorPjZd8HZx5+JEzc5yIVrJ1Zf1u1Z8pwwtZAHBpxKd3KizdMa4n9bFBDXIpiXF8e0EA+zYsMOs=
X-Received: by 2002:a05:6870:2181:b0:196:7f51:1bc7 with SMTP id
 l1-20020a056870218100b001967f511bc7mr7964179oae.17.1686236192230; Thu, 08 Jun
 2023 07:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <9ef94ec4-bbb0-43e6-866f-40f68128cd78@moroto.mountain>
In-Reply-To: <9ef94ec4-bbb0-43e6-866f-40f68128cd78@moroto.mountain>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 8 Jun 2023 23:55:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWmtiQdtvGLYL5b0Pyg4Bnmj0_Hn8xtWLzMJ_1oxkThA@mail.gmail.com>
Message-ID: <CAK7LNATWmtiQdtvGLYL5b0Pyg4Bnmj0_Hn8xtWLzMJ_1oxkThA@mail.gmail.com>
Subject: Re: [PATCH] modpost: fix off by one in is_executable_section()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
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

On Thu, Jun 8, 2023 at 6:15=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The > comparison should be >=3D to prevent an out of bounds array
> access.
>
> Fixes: 52dc0595d540 ("modpost: handle relocations mismatch in __ex_table.=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---


Applied to linux-kbuild.
Thanks.



>  scripts/mod/modpost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index d10f5bdcb753..c3cb69c276ae 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1139,7 +1139,7 @@ static Elf_Sym *find_tosym(struct elf_info *elf, El=
f_Addr addr, Elf_Sym *sym)
>
>  static bool is_executable_section(struct elf_info *elf, unsigned int sec=
ndx)
>  {
> -       if (secndx > elf->num_sections)
> +       if (secndx >=3D elf->num_sections)
>                 return false;
>
>         return (elf->sechdrs[secndx].sh_flags & SHF_EXECINSTR) !=3D 0;
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
