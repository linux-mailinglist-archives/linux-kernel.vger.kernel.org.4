Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5D6B8F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCNKCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNKCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC228907B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 680F6616E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95E3C433EF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678788154;
        bh=hy1fVJsDP8QU+RSH4/B3YXf+/OlOJnZXP6rso7FYQNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TRm74GYgV5L9zL64q1094tejQsFbP/6t5dNi3Bjq9pGCbcFr0O4CuCI29FaKQofJk
         C0NkZVTzFe7tkTgbjDddAiOGLC1rGw4JIO2mEiksAYFE8iuwcfhcHoJJHL00+pkqgT
         q/rAiGZSL1ovdokH1TkuExXWH48WOJ4Xxz5Z8N1zOGsZmRZ513Zv9i7wEBl6W//N1C
         /Uj6ayebhUJsWGGZKvL9F5UL9wAXiS2dmqbJ+Epw+ZYNvSXPLf0qYT+45XN+1eAWCT
         jSW/JTSwG5PQeks7ktn+BjetWUk0leufKuo/K8gA+uNXdPl25ScCfveCtsNaVwEONB
         go5nUflvYsdxw==
Received: by mail-ed1-f54.google.com with SMTP id eh3so3716885edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:02:34 -0700 (PDT)
X-Gm-Message-State: AO0yUKVuoOR245NmyZTfT+lv5kJpaetZ+1cV4xC3gz+gTRdj0CnEsla+
        dl0rmBRyhkYiHEG89BWabYtJyWnRUI4FJO1tc7E=
X-Google-Smtp-Source: AK7set8I70Sic6UL3a3mg0g/+mPcGyN//JyOqXau0V89oxLi3jtL7SC76TWv3uRaMsQdlvaHQrOXcHrmPXTaWgqtiuU=
X-Received: by 2002:a17:906:6d49:b0:878:6488:915f with SMTP id
 a9-20020a1709066d4900b008786488915fmr930929ejt.10.1678788153049; Tue, 14 Mar
 2023 03:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230314085433.4078119-1-chenhuacai@loongson.cn> <21f5aba50b7732b48d2610a5015186adf6bdfb38.camel@xry111.site>
In-Reply-To: <21f5aba50b7732b48d2610a5015186adf6bdfb38.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 14 Mar 2023 18:02:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4TpQuq9sE2H=zbO8cvwn3Aer_pu1a-DU9L9OSR1bQX=g@mail.gmail.com>
Message-ID: <CAAhV-H4TpQuq9sE2H=zbO8cvwn3Aer_pu1a-DU9L9OSR1bQX=g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Make WriteCombine configurable for ioremap()
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Tue, Mar 14, 2023 at 5:41=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Tue, 2023-03-14 at 16:54 +0800, Huacai Chen wrote:
> > LoongArch maintains cache coherency in hardware, but when works with
> > LS7A chipsets the WUC attribute (Weak-ordered UnCached, which is simila=
r
> > to WriteCombine) is out of the scope of cache coherency machanism for
> > PCIe devices (this is a PCIe protocol violation, may be fixed in newer
> > chipsets).
>
> IIUC all launched LS7A models (7A1000 and 7A2000) suffers this issue?
Yes, very unfortunately, but this issue is only observed in the amdgpu
driver now.

>
> > This means WUC can only used for write-only memory regions now, so this
> > option is disabled by default (means WUC falls back to SUC for ioremap)=
.
> > You can enable this option if the kernel is ensured to run on bug-free
> > hardwares.
>
> Hmm, is it possible to make a PCI quirk so SUC/WUC will be decided
> automatically from the vendor:device ID of the PCI root controller?
> Then we don't need to rely on the user or distro maintainer to select an
> option.  I see there is already many architecture-dependant #if
> directives in drivers/pci/quirks.c so I guess such a quirk is acceptable
> in PCI tree...
Not a good idea, pci quirks need too long a time to review, and we
don't know when this issue can be fixed in hardware.

>
> If a PCI quirk is not possible, then is it possible to make a kernel
> command line option, leaving this CONFIG as the default value of the
> option?  I guess in the future many LoongArch users will just install a
> binary distro, then it would be much easier to edit grub.cfg than
> rebuilding the kernel when they finally buy a compliant PCIe controller.
If we use command line parameter, we can remove this Kconfig option.

Huacai
>
> > Suggested-by: WANG Xuerui <kernel@xen0n.name>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/Kconfig          | 14 ++++++++++++++
> >  arch/loongarch/include/asm/io.h |  5 +++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 0d11738a861a..e3f5c422636f 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -446,6 +446,20 @@ config ARCH_IOREMAP
> >           protection support. However, you can enable LoongArch DMW-bas=
ed
> >           ioremap() for better performance.
> >
> > +config ARCH_WRITECOMBINE
> > +       bool "Enable WriteCombine (WUC) for ioremap()"
> > +       help
> > +         LoongArch maintains cache coherency in hardware, but with LS7=
A
> > +         chipsets the WUC attribute (Weak-ordered UnCached, which is s=
imilar
> > +         to WriteCombine) is out of the scope of cache coherency macha=
nism
> > +         for PCIe devices (this is a PCIe protocol violation, may be f=
ixed
> > +         in newer chipsets).
> > +
> > +         This means WUC can only used for write-only memory regions no=
w, so
> > +         this option is disabled by default (means WUC falls back to S=
UC for
> > +         ioremap). You can enable this option if the kernel is ensured=
 to run
> > +         on bug-free hardwares.
> > +
> >  config ARCH_STRICT_ALIGN
> >         bool "Enable -mstrict-align to prevent unaligned accesses" if E=
XPERT
> >         default y
> > diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/a=
sm/io.h
> > index 402a7d9e3a53..079ef897ed1a 100644
> > --- a/arch/loongarch/include/asm/io.h
> > +++ b/arch/loongarch/include/asm/io.h
> > @@ -54,8 +54,13 @@ static inline void __iomem *ioremap_prot(phys_addr_t=
 offset, unsigned long size,
> >   * @offset:    bus address of the memory
> >   * @size:      size of the resource to map
> >   */
> > +#ifdef CONFIG_ARCH_WRITECOMBINE
> >  #define ioremap_wc(offset, size)       \
> >         ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_WUC))
> > +#else
> > +#define ioremap_wc(offset, size)       \
> > +       ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_SUC))
> > +#endif
> >
> >  #define ioremap_cache(offset, size)    \
> >         ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
