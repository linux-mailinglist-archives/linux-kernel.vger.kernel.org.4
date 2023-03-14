Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7046B8EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjCNJlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCNJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:41:09 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB376A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1678786865;
        bh=yUNmPrhQ6SiuMNO6i2zc9N6TN7jXeXF7t1dNRXboDjM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i1eqIABfU88HuuoZDSREAEJdc3z0DDfSl6nqYI14FuWXwCPylP2k/PhZrIHX0JfIl
         nOjeyei9Jwb34zSL/hDwy0+PwYExnIhTI5Hjq819Q+tT+FcG8THxLTWeAzeesUMU48
         Kx9smfpulr5o15tvRYLa0R+cgK8j09TSKfYMZzi0=
Received: from [192.168.124.9] (unknown [113.140.29.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 5FCD565A7E;
        Tue, 14 Mar 2023 05:41:03 -0400 (EDT)
Message-ID: <21f5aba50b7732b48d2610a5015186adf6bdfb38.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Make WriteCombine configurable for ioremap()
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Tue, 14 Mar 2023 17:40:54 +0800
In-Reply-To: <20230314085433.4078119-1-chenhuacai@loongson.cn>
References: <20230314085433.4078119-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-14 at 16:54 +0800, Huacai Chen wrote:
> LoongArch maintains cache coherency in hardware, but when works with
> LS7A chipsets the WUC attribute (Weak-ordered UnCached, which is similar
> to WriteCombine) is out of the scope of cache coherency machanism for
> PCIe devices (this is a PCIe protocol violation, may be fixed in newer
> chipsets).

IIUC all launched LS7A models (7A1000 and 7A2000) suffers this issue?

> This means WUC can only used for write-only memory regions now, so this
> option is disabled by default (means WUC falls back to SUC for ioremap).
> You can enable this option if the kernel is ensured to run on bug-free
> hardwares.

Hmm, is it possible to make a PCI quirk so SUC/WUC will be decided
automatically from the vendor:device ID of the PCI root controller?=20
Then we don't need to rely on the user or distro maintainer to select an
option.  I see there is already many architecture-dependant #if
directives in drivers/pci/quirks.c so I guess such a quirk is acceptable
in PCI tree...

If a PCI quirk is not possible, then is it possible to make a kernel
command line option, leaving this CONFIG as the default value of the
option?  I guess in the future many LoongArch users will just install a
binary distro, then it would be much easier to edit grub.cfg than
rebuilding the kernel when they finally buy a compliant PCIe controller.

> Suggested-by: WANG Xuerui <kernel@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> =C2=A0arch/loongarch/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 14 ++++++++++++++
> =C2=A0arch/loongarch/include/asm/io.h |=C2=A0 5 +++++
> =C2=A02 files changed, 19 insertions(+)
>=20
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 0d11738a861a..e3f5c422636f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -446,6 +446,20 @@ config ARCH_IOREMAP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 protection support=
. However, you can enable LoongArch DMW-based
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioremap() for bett=
er performance.
> =C2=A0
> +config ARCH_WRITECOMBINE
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Enable WriteCombine (WUC=
) for ioremap()"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LoongArch maintains cac=
he coherency in hardware, but with LS7A
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chipsets the WUC attrib=
ute (Weak-ordered UnCached, which is similar
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to WriteCombine) is out=
 of the scope of cache coherency machanism
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for PCIe devices (this =
is a PCIe protocol violation, may be fixed
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in newer chipsets).
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This means WUC can only=
 used for write-only memory regions now, so
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this option is disabled=
 by default (means WUC falls back to SUC for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioremap). You can enabl=
e this option if the kernel is ensured to run
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on bug-free hardwares.
> +
> =C2=A0config ARCH_STRICT_ALIGN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Enable -mstrict-ali=
gn to prevent unaligned accesses" if EXPERT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm=
/io.h
> index 402a7d9e3a53..079ef897ed1a 100644
> --- a/arch/loongarch/include/asm/io.h
> +++ b/arch/loongarch/include/asm/io.h
> @@ -54,8 +54,13 @@ static inline void __iomem *ioremap_prot(phys_addr_t o=
ffset, unsigned long size,
> =C2=A0 * @offset:=C2=A0=C2=A0=C2=A0 bus address of the memory
> =C2=A0 * @size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size of the resource to map
> =C2=A0 */
> +#ifdef CONFIG_ARCH_WRITECOMBINE
> =C2=A0#define ioremap_wc(offset, size)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioremap_prot((offset), (s=
ize), pgprot_val(PAGE_KERNEL_WUC))
> +#else
> +#define ioremap_wc(offset, size)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0\
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioremap_prot((offset), (size),=
 pgprot_val(PAGE_KERNEL_SUC))
> +#endif
> =C2=A0
> =C2=A0#define ioremap_cache(offset, size)=C2=A0=C2=A0=C2=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioremap_prot((offset), (s=
ize), pgprot_val(PAGE_KERNEL))

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
