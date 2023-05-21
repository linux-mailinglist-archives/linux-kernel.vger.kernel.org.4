Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4397670AE2C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEUNMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 09:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUNM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 09:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF43CD2;
        Sun, 21 May 2023 06:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F99061213;
        Sun, 21 May 2023 13:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F21C433EF;
        Sun, 21 May 2023 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684674745;
        bh=5osWxdwPx60PnNZ3bXxJWoLfr3s7lo3UzwnKiZV/e98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sd53AVXzPB7VRwxDZr5f/H8KpE4s9copE2WxhdfezXQl+y3MrH1VxEessQIt3wqOA
         S+eQGpBMFeiBQ7jSHxFDtf2FxXWFm0cM1kvDFjswwBNajLeOxgy/gX3GKHwPJor93B
         7joYkPl6ELb7HA3on0wwhVXBsbVIvEhkS7QNVPBOYpPu+upD+ASPJtvL48cc3CPjeh
         DA0Khf2Lm4+oyg8TTeud0bDpBpJ9re4+Xjt2ANCgMzL7F8ai7CrVn1lGIVtMwD83AP
         ISdhLIC/qrEbUbgvavEzSV7pRmrnkpycjpm5HbqRohL34LMjUekmnLNnJxibI2mVuK
         qOcmwja1KcZPA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-54fd177fbd4so2464034eaf.3;
        Sun, 21 May 2023 06:12:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDxVY3M+pWRCcGKgw19q1CNfvs9dmjXi2UmGC3jzD7d6mvJ5lP1g
        JT/nwim6w4l2lmWkhDi4XQ3enbgy3oItFBPcSqY=
X-Google-Smtp-Source: ACHHUZ5dNnhg7fL/+DFlc6lUze5i8Y14NPnnmvFWkfYxGox9e9+TCvJL88+y2ASvH89eQUEP73xDQbhF5q6WHHQyvAw=
X-Received: by 2002:a4a:9c50:0:b0:54f:b59c:256a with SMTP id
 c16-20020a4a9c50000000b0054fb59c256amr3772159ook.4.1684674744986; Sun, 21 May
 2023 06:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230511162423.1922133-1-masahiroy@kernel.org>
In-Reply-To: <20230511162423.1922133-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 21 May 2023 22:11:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNVu_HMH7MRm5t2d+uMfpsYki7FWhZeF7+nDVtPEo_Yw@mail.gmail.com>
Message-ID: <CAK7LNARNVu_HMH7MRm5t2d+uMfpsYki7FWhZeF7+nDVtPEo_Yw@mail.gmail.com>
Subject: Re: [PATCH] modpost: error out if addend_*_rel() is not implemented
 for REL arch
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Fri, May 12, 2023 at 1:25=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> The section mismatch check relies on the relocation entries.
>
> For REL, the addend value is implicit, so we need some code to compute
> it. Currently, EM_386, EM_ARM, and EM_MIPS are supported. This commit
> makes sure we covered all the cases.
>
> I believe the other architectures use RELA, where the explicit r_addend
> field exists.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Applied to linux-kbuild.



>
>  scripts/mod/modpost.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 95da374cc534..44309d463a49 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1442,6 +1442,8 @@ static void section_rel(const char *modname, struct=
 elf_info *elf,
>                         if (addend_mips_rel(elf, sechdr, &r))
>                                 continue;
>                         break;
> +               default:
> +                       fatal("Please add code to calculate addend for th=
is architecture\n");
>                 }
>                 sym =3D elf->symtab_start + r_sym;
>                 /* Skip special sections */
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
