Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB08601B54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJQVc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJQVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:32:49 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE07CB51;
        Mon, 17 Oct 2022 14:32:37 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 29HLWJfp026370;
        Tue, 18 Oct 2022 06:32:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 29HLWJfp026370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666042339;
        bh=A9DSYIu9/NXOyiS7xPZNFkoZDUyi3jGg6FffSm1+/Ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=20WBYTHRNcs08BD6VQzUo4nIz/qgYmABFyn8DzsI30UO3dtmbWuFHc2X4Ru56w5mR
         E84jos3l/7Af2bh6V7haADHjppjQ+EPJLK6I3ITvSE0TnWrg4X/bitEK3u/q4KM0pj
         Xcjtz1qChkaLL8kxh1UMmy/zozyaCqSRWIcH6gScJT/A0VC875seTWFxSA6fAusRXj
         XJmblp5+TZZRyktpqAEudZUFfnDJ7kbC9MWju9+lST7+lwa/t/xrasvqo7f9xaD0V7
         JZliRy86cUkeQRNENQjYuQEbuPJ0djKBc3Y7ai4ISM947l0eHOC3lAFziObXRJCloC
         r2mTObMbVTktQ==
X-Nifty-SrcIP: [209.85.160.50]
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1370acb6588so14760101fac.9;
        Mon, 17 Oct 2022 14:32:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf0oKKYG9HRMtl+pJmSEH2z4e1gapCuX8kjt4hEb26wsKrn5SozR
        qwhQ0zyV3grHx9Etm5br+x3RBtTIxEt47eWSw3g=
X-Google-Smtp-Source: AMsMyM4ip6TZdj6uaGNj4mpwyAgawp0QupIF2/ySfBpkjMkP/PCXVQZQSRHQsSTLo5hKxyGYMfsR4VMeGX3Evt4KqvE=
X-Received: by 2002:a05:6870:8a09:b0:132:554d:2f3d with SMTP id
 p9-20020a0568708a0900b00132554d2f3dmr16265337oaq.194.1666042338433; Mon, 17
 Oct 2022 14:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221017150113.334571-1-newbie13xd@gmail.com>
In-Reply-To: <20221017150113.334571-1-newbie13xd@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Oct 2022 06:31:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARsUE4j7LNYsushQaXFBEcnhhXoNg9THh2wLrYoi2jp9Q@mail.gmail.com>
Message-ID: <CAK7LNARsUE4j7LNYsushQaXFBEcnhhXoNg9THh2wLrYoi2jp9Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use POSIX-compatible grep option
To:     Stefan Hansson <newbie13xd@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:02 AM Stefan Hansson <newbie13xd@gmail.com> wrote:
>
> --file is a GNU extension to grep which is not available in all
> implementations (such as BusyBox). Use the -f option instead which is
> eqvuialent according to the GNU grep manpage[1] and is present in
> POSIX[2].
>
>  [1] https://www.gnu.org/software/grep/manual/grep.html
>  [2] https://pubs.opengroup.org/onlinepubs/9699919799/


This link does not show the spec of grep.


Did you mean this?

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html




Thanks.





>
> Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c690361b393f..3513a6db66a2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
>        cmd_ar_vmlinux.a = \
>         rm -f $@; \
>         $(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> -       $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
> +       $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -Ff $(srctree)/scripts/head-object-list.txt)
>
>  targets += vmlinux.a
>  vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
> --
> 2.37.3
>


-- 
Best Regards
Masahiro Yamada
