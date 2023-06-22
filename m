Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F073A325
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjFVOfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:35:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9910F6;
        Thu, 22 Jun 2023 07:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A423A6187A;
        Thu, 22 Jun 2023 14:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A81C433C0;
        Thu, 22 Jun 2023 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687444541;
        bh=+UaFplHjOb3WkG8MyLgcLtGFC7j3i0iRyQZQw2GHmY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeJ7r9xtDIPpV/mMYrOnbxqqnLoXUqlGoRGjO/ccQYMKaxbfJOjHx4N9VcKigUhP7
         KXbSYAUAxii873kAMI/XFc2dpkZN07LZes/Ouo/vxk3gHW/ZdZOG4k0QdM5DqDMRXZ
         wplT/eDl5iZlIditxaZoIY2+GfYYCTdJsOfNkMWxBNv3axh0Gow6x9rQFyfw6oq+vQ
         34NROuFZLYDffb+Xsqu5t5Cl1iutDsGfWaIztMx/BQGgT5aoSGhSBVzWWANkRwltEV
         XIjdBmqh/zJV5ss8JnWR9a5ezLdbWjOgUJGJYmk5vQ0KIS9uu3Q/9oFI6Fm0dGQac2
         9vQNTaJwxO57g==
Date:   Thu, 22 Jun 2023 14:35:38 +0000
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/decompresser: fix misaligned symbol build error
Message-ID: <20230622143538.GA1138962@dev-arch.thelio-3990X>
References: <20230622125508.1068457-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622125508.1068457-1-hca@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 02:55:08PM +0200, Heiko Carstens wrote:
> Nathan Chancellor reported a kernel build error on Fedora 39:
> 
> $ clang --version | head -1
> clang version 16.0.5 (Fedora 16.0.5-1.fc39)
> 
> $ s390x-linux-gnu-ld --version | head -1
> GNU ld version 2.40-1.fc39
> 
> $ make -skj"$(nproc)" ARCH=s390 CC=clang CROSS_COMPILE=s390x-linux-gnu- olddefconfig all
> s390x-linux-gnu-ld: arch/s390/boot/startup.o(.text+0x5b4): misaligned symbol `_decompressor_end' (0x35b0f) for relocation R_390_PC32DBL
> make[3]: *** [.../arch/s390/boot/Makefile:78: arch/s390/boot/vmlinux] Error 1
> 
> It turned out that the problem with misaligned symbols on s390 was fixed
> with commit 80ddf5ce1c92 ("s390: always build relocatable kernel") for the
> kernel image, but did not take into account that the decompressor uses its
> own set of CFLAGS, which come without -fPIE.
> 
> Add the -fPIE flag also to the decompresser CFLAGS to fix this.
> 

I think this should also have:

Reported-by: CKI <cki-project@redhat.com>
Link: https://lore.kernel.org/32935.123062114500601371@us-mta-9.us.mimecast.lan/

I technically just forwarded the report and did a little extra testing.

> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1747
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Thanks for the quick patch, this fixes the error and I did a simple boot
test in QEMU with the resulting kernel, which showed no issues.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/s390/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index ed646c583e4f..5ed242897b0d 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -27,6 +27,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbac
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
> +KBUILD_CFLAGS_DECOMPRESSOR += -fPIE
>  KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
> -- 
> 2.39.2
> 
