Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD32736290
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFTEOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFTEOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:14:15 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506810D2;
        Mon, 19 Jun 2023 21:14:11 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 20 Jun 2023 06:14:03 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 7211380C47;
        Tue, 20 Jun 2023 06:14:03 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 5F279182086; Tue, 20 Jun 2023 06:14:03 +0200 (CEST)
Date:   Tue, 20 Jun 2023 06:14:03 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ARM: change link order of $(mmy-y) to avoid veneers
Message-ID: <ZJEni98knMMkU/cl@buildd.core.avm.de>
References: <20230619143725.57967-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230619143725.57967-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1687234443-9D4ED0AE-9095512A/0/0
X-purgate-type: clean
X-purgate-size: 2587
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] ARM: change link order of $(mmy-y) to avoid veneers

There is a typo in the subject (mmy-y -> mmu-y).

Kind regards,
Nicolas


On Mon, Jun 19, 2023 at 11:37:25PM +0900, Masahiro Yamada wrote:
> The kernel compiled with multi_v7_defconfig + CONFIG_KASAN=y +
> CONFIG_KASAN_INLINE=y does not boot.
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
>  obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
>  
> -lib-$(CONFIG_MMU) += $(mmu-y)
> +obj-$(CONFIG_MMU) += $(mmu-y)
>  
>  ifeq ($(CONFIG_CPU_32v3),y)
>    lib-y	+= io-readsw-armv3.o io-writesw-armv3.o
> -- 
> 2.39.2
> 
