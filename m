Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731967361A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjFTCzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFTCzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0575119;
        Mon, 19 Jun 2023 19:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F2B360EA2;
        Tue, 20 Jun 2023 02:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A873C433C8;
        Tue, 20 Jun 2023 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687229741;
        bh=goMMACEPH0ZJz2QpbabnDWdZ0nRzXFasbEi50zMihNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bs49SNCiowYv83UJBQHAn17oLzvn4F5W0WfltMs3EFmT7a1raVs4MzZiGaUK/PsAJ
         m/fmir9CtAxYd55ZG63d1nMOHnMKtBsO8HB11hMBJKh90hE9voicq96FLeUtZv9mOB
         z32ff6pi9yHhQwSRtYY1HUUU3KuNOoJrHfSwbA125Lw5W9PdZZcCAEOaI/Sjp9VjAJ
         hAg5tLmoE21ID1X1ithQS/3+fKVaZolPWzvbp+tmJggDyZFX4EVs+Wxic8Jq/FIE3c
         ui0gwLgltrFuq/oThhjCijY44GmFXMA5X4z2HkIf31722VIY1eCWOFxRGkG1ONbvvM
         OARAiSwv8tfKw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1a991886254so4416658fac.2;
        Mon, 19 Jun 2023 19:55:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDytpV2mAaIwJn1tOs6JVISNlU7dxRfzZLlALpm1RF2JllQS9ik7
        ogn4Bav+ihg/8NTlEfNAcrHgTUM5btxBfk2+sm8=
X-Google-Smtp-Source: ACHHUZ7jEAa+wuItwdaj1Y3yf70OhGllFEkRTx/T8Cs4ziFoRVpCRVHUOpODMUBS9V+h/JXIWW+waw4Kf7pzLi5Lc2Q=
X-Received: by 2002:a05:6870:4708:b0:19e:cc9f:8a45 with SMTP id
 b8-20020a056870470800b0019ecc9f8a45mr12367700oaq.38.1687229740848; Mon, 19
 Jun 2023 19:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230619143725.57967-1-masahiroy@kernel.org>
In-Reply-To: <20230619143725.57967-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 20 Jun 2023 11:55:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcxy63FNrGzJXC0kieWHTYhE6mVbW6JYniO8ng+xSgvQ@mail.gmail.com>
Message-ID: <CAK7LNAQcxy63FNrGzJXC0kieWHTYhE6mVbW6JYniO8ng+xSgvQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: change link order of $(mmy-y) to avoid veneers
To:     linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, Jun 19, 2023 at 11:37=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> The kernel compiled with multi_v7_defconfig + CONFIG_KASAN=3Dy +
> CONFIG_KASAN_INLINE=3Dy does not boot.
>
> I do not think KASAN is the direct reason of the boot failure.
> CONFIG_KASAN_INLINE is just one example configuration that grows the
> image size significantly and makes a big distance between function
> callers and callees.
>
> I see some veneers for __get_user_* in the bad kernel image. I am
> not perfectly clear, but __get_user_* may not work with veneers for
> some reasons.
>
> If I move the link order of arch/arm/lib/getuser.S, the veneers are
> gone, and the kernel gets working again.
>
> I do not see a good reason that $(mmu-y) must be added to lib-y because
> all the code in $(mmu-y) is mandatory. Add it to obj-y to move the code
> to lower address.
>
> [1] multi_v7_defconfig (works)
>
>  $ arm-linux-gnueabihf-nm vmlinux | grep __get_user_1
>  c072a450 T __get_user_1
>  c17ea033 r __kstrtab___get_user_1
>  c18119fe r __kstrtabns___get_user_1
>  c17c4878 r __ksymtab___get_user_1
>
> [2] multi_v7_defconfig + CONFIG_KASAN_INLINE (does not work)
>
>  $ arm-linux-gnueabihf-nm vmlinux | grep __get_user_1
>  c341ec2c T __get_user_1
>  c06e3580 t ____get_user_1_veneer
>  c0adc6c0 t ____get_user_1_veneer
>  c12cf054 t ____get_user_1_veneer
>  c43f42cc r __kstrtab___get_user_1
>  c441c128 r __kstrtabns___get_user_1
>  c43cead8 r __ksymtab___get_user_1
>
> [3] multi_v7_defconfig + CONFIG_KASAN_INLINE + this patch (works)
>
>  $ arm-linux-gnueabihf-nm vmlinux | grep __get_user_1
>  c10975b0 T __get_user_1
>  c43f42cc r __kstrtab___get_user_1
>  c441c128 r __kstrtabns___get_user_1
>  c43cead8 r __ksymtab___get_user_1
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/arm/lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 650404be6768..4d092ef87a1d 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -28,7 +28,7 @@ endif
>  # using lib_ here won't override already available weak symbols
>  obj-$(CONFIG_UACCESS_WITH_MEMCPY) +=3D uaccess_with_memcpy.o
>
> -lib-$(CONFIG_MMU) +=3D $(mmu-y)
> +obj-$(CONFIG_MMU) +=3D $(mmu-y)
>
>  ifeq ($(CONFIG_CPU_32v3),y)
>    lib-y        +=3D io-readsw-armv3.o io-writesw-armv3.o
> --
> 2.39.2
>



I also wonder why __get_user* is defined in
arch/arm/lib/ instead of arch/arm/kernel/,
but I might be a convention.

x86 puts it in the lib directory,
  arch/x86/lib/getuser.S
then other architectures copy the code structure.






--=20
Best Regards
Masahiro Yamada
