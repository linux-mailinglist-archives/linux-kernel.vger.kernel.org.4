Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C172A557
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjFIV13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIV12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:27:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAC21AE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:27:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39a97058691so953826b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686346046; x=1688938046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79ZPKjidrQgRLDsSa7QpphQvIoGIPOgBv8OBV9Mr61s=;
        b=OmL+6fhI7tyv31jaIEJF48y0gvfk2e7g/YcVV/TchHMCLdNaYV2CzWK8kQuzD/dv/9
         rTU/i+ZudaE16UswrcKoUpeeGi0HUwFPVBnaSmKQJJOgVa3Eq8V+n13qwOa752MnSl2G
         nxSEwD1NWrt7mf//t+SmSBmJgTuVeV4gMU1migsjs0jZD+MD/nkUl4208EAkmiOfnr0o
         Pdk+OX2fGo1y9OhDkE4XlcZQatI4VjvMhgKaQB1qeRRUCtJwzQdeRdjYq8AuTXidJNg7
         oCxH6RjrmVM9T2O6vCylxuSqnorPvIGwyHfKmEZm3JLiWuPEakfE+DbsSrv+OlhDMV7Z
         9diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686346046; x=1688938046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79ZPKjidrQgRLDsSa7QpphQvIoGIPOgBv8OBV9Mr61s=;
        b=b+kOhKuIYZWfWPO45a8Zb5Y1CsRvvDeG3iTKPGNBTgPW5BbGmRDb3HaY4bvWoonl9z
         4nISMd4vFrTQd2KG3zsWRcG3STjM6rvrLpb63TOhddYcLTLinHce9nPPWa3oeb5AdmIb
         uz2aR9DtEBr+XWMEARKdgqodCYVOJVXdtY6wTUvUuf71fC/BHZhLARHC4mFumtAXkgAe
         1qhf552XLvlM9da6EE1FGwpa3k6mwCINeA2XZEGbASx4t0bWHwxfyxWW44n0ub4T0pAx
         BCN9jxTsGwfGYv1FalEBon9E6P5Vm6XZnGrxeRBttDa+r64wKQAtb6/98RLl/g4ubENj
         89CA==
X-Gm-Message-State: AC+VfDx0VAQ4Lj4MfKT0bE/SWX/ZelR6psjYOcOoIki+nuxVGhmkpt1+
        Gr3RqD4JDwx+uZSf1GOdpnC8wfkNLB2ji0VIMtTCfA==
X-Google-Smtp-Source: ACHHUZ50Fx2ISvtOB/iuSEZqXAVM8l4sckFy6gt9/EnvPJel+X8zQgM7yZZYCTQwM1yl0Jrlq/5lb1VPEjdiLi0n0ec=
X-Received: by 2002:a05:6358:c519:b0:129:c7b0:27fb with SMTP id
 fb25-20020a056358c51900b00129c7b027fbmr2233226rwb.26.1686346046206; Fri, 09
 Jun 2023 14:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-11-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-11-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Jun 2023 14:26:57 -0700
Message-ID: <CAKwvOdny3yGugmEUUK_Zm7WNUeKHZrCk+9j-svGi9URHZVpDng@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] modpost: show offset from symbol for section
 mismatch warnings
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 7:24=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Currently, modpost only shows the symbol names and section names, so it
> repeats the same message if there are multiple relocations in the same
> symbol. It is common the relocation spans across multiple instructions.
>
> It is better to show the offset from the symbol.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 85df3f3ba9ee..40967ed816df 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1147,8 +1147,8 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>
>         sec_mismatch_count++;
>
> -       warn("%s: section mismatch in reference: %s (section: %s) -> %s (=
section: %s)\n",
> -            modname, fromsym, fromsec, tosym, tosec);
> +       warn("%s: section mismatch in reference: %s+0x%x (section: %s) ->=
 %s (section: %s)\n",
> +            modname, fromsym, (unsigned int)(faddr - from->st_value), fr=
omsec, tosym, tosec);
>
>         if (mismatch->mismatch =3D=3D EXTABLE_TO_NON_TEXT) {
>                 if (match(tosec, mismatch->bad_tosec))
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
