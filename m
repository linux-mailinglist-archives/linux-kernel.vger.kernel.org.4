Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723057374F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjFTTNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjFTTNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:13:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC14170A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:13:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7623fdb3637so342873385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687288398; x=1689880398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kUloHMpKPl3I/kTERvQHtZG7RFGaCO4HmKGMBk+KKQ=;
        b=A0HYjhvugScSa3knhYTG7rhIjQObez8K1qq1G0AtXnV79V5m5IS1o76BvHfV8ZdcMw
         Oz/t8xN/A9VCSvACpWBzMKR5VB4fiSIIABKQaPCoXEUi03i1ulvCCDzNV4CVWLYvh/AF
         IUvHIxPU/tUt0uE6yX68pyoRiYT+b1CHaqnB1bsYxnTusTZWfiXQ9TH8+11uRemnLxoh
         vfuVslSJodu0SHi+IvOqMBgGYECKkS6SBc7IQQUuKQpd9cEG1p2VzKKxhRMuzz6vL5Vy
         TCvD7K1ZsP5DA9TdItw3zzyfiJTWYK+bji8NrZR6xlJafiphmEYAgf0L60mkeucaTf3I
         7ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687288398; x=1689880398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kUloHMpKPl3I/kTERvQHtZG7RFGaCO4HmKGMBk+KKQ=;
        b=EHt/igqxDy5k49+UOeBCLrMWh8OEzs7H81p6by+aDLzn6qgtBY0IgwVQkLzcRTO0dj
         ZinyXi4nfb/hUhd/35+KprB5NY5wc5kmwGj+SsO/wwGG+mDsTtNqQIxQjLh0ptBA/UKD
         7+J+BDX8056E2saMppvoEwTVQp4bNOMJPk3clPLL6KYkG4onTQZheNfTd2T+nf3YB1p3
         QEkotFvv4mg9HorzB14VmgQcCAERM4zAbGMjFotRST1lfKodiUlIjR60BPPHztgYkgOR
         ZvK/QagJ6vFQtDlS8mge6+KfjiUotB3cVp60Iky+nLN2yu63rxXQpO/GiGWiWE/iUI8r
         kCSg==
X-Gm-Message-State: AC+VfDx8JmPRPqj1ff7bzgPNpnzL7PZo9RZ5wFF1smJf5gncZocgqUOq
        lfgyjwhArec4w7T7rRkiMuik4WqQ/1JeoNTCnBU55g==
X-Google-Smtp-Source: ACHHUZ4f93lS9fAyCW0th4pVT6EEMEJoKBxqQtIQrPiuVU2P3u22aqPHDokFIKYPJ9ZclFi0j1mjAlZH66OuKr6hi50=
X-Received: by 2002:a05:6214:5098:b0:630:1faa:a404 with SMTP id
 kk24-20020a056214509800b006301faaa404mr6575734qvb.39.1687288398288; Tue, 20
 Jun 2023 12:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230619143725.57967-1-masahiroy@kernel.org>
In-Reply-To: <20230619143725.57967-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Jun 2023 15:13:06 -0400
Message-ID: <CAKwvOdkX993kCaGVj5jd9-xeUwU5w9XmP4gUoSjOndfG-DhWHg@mail.gmail.com>
Subject: Re: [PATCH] ARM: change link order of $(mmy-y) to avoid veneers
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Jun 19, 2023 at 10:37=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
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

I'm kind of curious to know more about this.  Has there been other
instances in the ARCH=3Darm port where "there must not be a veneer from
X to Y for reason Z?"

I thought the linker inserted veneers were meant to be transparent
here.  If you disassemble ____get_user_1_veneer, do they themselves
branch to different symbols, or the same symbol? (Perhaps they
trampoline to each other then the final one is the "call" to the
original symbol).  But perhaps the symbol at the end of the chain
gives us more clues. I'd bet it's the KASAN callback, though does
KASAN_INLINE inline those?  Perhaps the veneer is corrupting a
register?  Maybe inline asm in the caller is missing a clobber for
that register...

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


--=20
Thanks,
~Nick Desaulniers
