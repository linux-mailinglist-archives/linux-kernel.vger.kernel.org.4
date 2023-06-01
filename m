Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF5719C55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjFAMlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A3A119;
        Thu,  1 Jun 2023 05:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD7D61D6D;
        Thu,  1 Jun 2023 12:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4F6C433A0;
        Thu,  1 Jun 2023 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685623257;
        bh=LqVyTu0poYQlgNWSrPsLYLl1GkpkXrTVvv75F50j+3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SOQ6df5z5IhuqVq6GVd1JcqkDc3OGMOfQLuYY6bjn8oiJtCO8aXdov0GJkBwEZszl
         wUGeZFUh1Xh1NcONJgtjpGnv4bAPFxyhbolTTnLXUeMh3mL5ZfO0wuRT0wV+9Vh2nI
         0LEOjkoVmLpl0t94KvNUAsHWhmJiSr+aFs0GSFpqY267L6+pneKvi0TFo/E3U+mIk+
         6AThIBX9ysFnO5A7bgiVLxTURdN7ZUKBIX2t2EnHSMZhQVwI5sVoFcroD3z4pvQF+l
         Zf0MxbygpB8oAf5Oa8/W5o49Z+rXPqq5e/fWuvUekxH/mgpKN290fT78b3YN3p4xZu
         3HIH6AKVgvgpA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2af2958db45so10910021fa.1;
        Thu, 01 Jun 2023 05:40:57 -0700 (PDT)
X-Gm-Message-State: AC+VfDzrMMloEZm8yldKTA/ITpr8wIJFWSwewvotAJa/hkAAqD/8mhSW
        eVHwyEdrYRwmRZ6xpovpYU3vH3r71UDfVh0Z12Y=
X-Google-Smtp-Source: ACHHUZ662JZaFUMXMMFNhWphzQxL+WkQPuhup3iOW+5joHWyfNSRalCodqsdmrNkzdN/XrBMu17jyVVTmFfMqVqLC74=
X-Received: by 2002:a2e:a305:0:b0:2ad:99dd:de07 with SMTP id
 l5-20020a2ea305000000b002ad99ddde07mr4917213lje.16.1685623255737; Thu, 01 Jun
 2023 05:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230601121001.1071533-1-masahiroy@kernel.org> <20230601121001.1071533-8-masahiroy@kernel.org>
In-Reply-To: <20230601121001.1071533-8-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Jun 2023 14:40:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFJOHsgopUOR7+jvC8s6bvSCZ3XAkQM1FbnZ8Qj6azvQA@mail.gmail.com>
Message-ID: <CAMj1kXFJOHsgopUOR7+jvC8s6bvSCZ3XAkQM1FbnZ8Qj6azvQA@mail.gmail.com>
Subject: Re: [PATCH 7/7] modpost: detect section mismatch for R_ARM_REL32
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 14:10, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> For ARM, modpost fails to detect some types of section mismatches.
>
>   [test code]
>
>     .section .init.data,"aw"
>     bar:
>             .long 0
>
>     .section .data,"aw"
>     .globl foo
>     foo:
>             .long bar - .
>
> It is apparently a bad reference, but modpost does not report anything.
>
> The test code above produces the following relocations.
>
>   Relocation section '.rel.data' at offset 0xe8 contains 1 entry:
>    Offset     Info    Type            Sym.Value  Sym. Name
>   00000000  00000403 R_ARM_REL32       00000000   .init.data
>
> Currently, R_ARM_REL32 is just skipped.
>
> Handle it like R_ARM_ABS32.

OK, so the reason we can handle these in the same way is because we
never calculate the resulting value, right? Because that value would
be different for these cases.


>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 55d142bb000b..9f0c87064ca5 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1281,6 +1281,7 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
>
>         switch (r_typ) {
>         case R_ARM_ABS32:
> +       case R_ARM_REL32:
>                 inst = TO_NATIVE(*(uint32_t *)loc);
>                 r->r_addend = inst + sym->st_value;
>                 break;
> --
> 2.39.2
>
