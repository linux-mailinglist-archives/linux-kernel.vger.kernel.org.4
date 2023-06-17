Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A3733E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjFQGPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQGPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E800119;
        Fri, 16 Jun 2023 23:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0298660F54;
        Sat, 17 Jun 2023 06:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CEDC433C8;
        Sat, 17 Jun 2023 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686982531;
        bh=FmBCPGQr9kc4FZ3SJahzQDpcowAg0zz2/CXRHAPmuKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZPxNNOZ7Pj7Xyf/2II866o9WGyGm1IrJ+s0YaBcPXU6Zpw9n8L8eiTjVcgJY+2Vs
         kld2AEWURToZP5cMWq1Ovy1Zcdh+nXcQ07YLmVsYdmCnhWaIZH4rzkh5ACAnqBAq9Q
         wzQ0gANPefS1BRw6XI2qxQxNWzMTUvfRDmLMmiCAO67igHmVxwDCWFEarRwd0xHul6
         0oDC+Um1uswFwi7/PIIIM9hS3jTKdm7q0/KfQYWawgyRH6/0DjKNXWaG0NeXVYm4Y8
         x6nV8BirqJ1tjKuPw4r0wnIidEjuy3LK+walcl5GcB9OnmJlHxiCHLuLAiHeiVPkg6
         78arIfpTAXAlw==
Date:   Sat, 17 Jun 2023 09:14:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 04/12] mm/execmem, arch: convert remaining overrides
 of module_alloc to execmem
Message-ID: <20230617061444.GP52412@kernel.org>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-5-rppt@kernel.org>
 <CAPhsuW7xE8sz8Nh2AdNb62k=8kgEPxaBCw3w50EfXraxmKca-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7xE8sz8Nh2AdNb62k=8kgEPxaBCw3w50EfXraxmKca-A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:53:54AM -0700, Song Liu wrote:
> On Fri, Jun 16, 2023 at 1:51 AM Mike Rapoport <rppt@kernel.org> wrote:
> [...]
> > diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> > index 5af4975caeb5..c3d999f3a3dd 100644
> > --- a/arch/arm64/kernel/module.c
> > +++ b/arch/arm64/kernel/module.c
> > @@ -17,56 +17,50 @@
> >  #include <linux/moduleloader.h>
> >  #include <linux/scs.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/execmem.h>
> >  #include <asm/alternative.h>
> >  #include <asm/insn.h>
> >  #include <asm/scs.h>
> >  #include <asm/sections.h>
> >
> > -void *module_alloc(unsigned long size)
> > +static struct execmem_params execmem_params = {
> > +       .modules = {
> > +               .flags = EXECMEM_KASAN_SHADOW,
> > +               .text = {
> > +                       .alignment = MODULE_ALIGN,
> > +               },
> > +       },
> > +};
> > +
> > +struct execmem_params __init *execmem_arch_params(void)
> >  {
> >         u64 module_alloc_end = module_alloc_base + MODULES_VSIZE;
> > -       gfp_t gfp_mask = GFP_KERNEL;
> > -       void *p;
> > -
> > -       /* Silence the initial allocation */
> > -       if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> > -               gfp_mask |= __GFP_NOWARN;
> >
> > -       if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > -           IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > -               /* don't exceed the static module region - see below */
> > -               module_alloc_end = MODULES_END;
> > +       execmem_params.modules.text.pgprot = PAGE_KERNEL;
> > +       execmem_params.modules.text.start = module_alloc_base;
> 
> I think I mentioned this earlier. For arm64 with CONFIG_RANDOMIZE_BASE,
> module_alloc_base is not yet set when execmem_arch_params() is
> called. So we will need some extra logic for this.

Right, this is taken care of in a later patch, but it actually belongs here.
Good catch!
 
> Thanks,
> Song
> 
> 
> > +       execmem_params.modules.text.end = module_alloc_end;
> >
> > -       p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> > -                               module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
> > -                               NUMA_NO_NODE, __builtin_return_address(0));
> > -
> > -       if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> > +       /*
> > +        * KASAN without KASAN_VMALLOC can only deal with module
> > +        * allocations being served from the reserved module region,
> > +        * since the remainder of the vmalloc region is already
> > +        * backed by zero shadow pages, and punching holes into it
> > +        * is non-trivial. Since the module region is not randomized
> > +        * when KASAN is enabled without KASAN_VMALLOC, it is even
> > +        * less likely that the module region gets exhausted, so we
> > +        * can simply omit this fallback in that case.
> > +        */
> > +       if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> >             (IS_ENABLED(CONFIG_KASAN_VMALLOC) ||
> >              (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> > -             !IS_ENABLED(CONFIG_KASAN_SW_TAGS))))
> > -               /*
> > -                * KASAN without KASAN_VMALLOC can only deal with module
> > -                * allocations being served from the reserved module region,
> > -                * since the remainder of the vmalloc region is already
> > -                * backed by zero shadow pages, and punching holes into it
> > -                * is non-trivial. Since the module region is not randomized
> > -                * when KASAN is enabled without KASAN_VMALLOC, it is even
> > -                * less likely that the module region gets exhausted, so we
> > -                * can simply omit this fallback in that case.
> > -                */
> > -               p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> > -                               module_alloc_base + SZ_2G, GFP_KERNEL,
> > -                               PAGE_KERNEL, 0, NUMA_NO_NODE,
> > -                               __builtin_return_address(0));
> > -
> > -       if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
> > -               vfree(p);
> > -               return NULL;
> > +             !IS_ENABLED(CONFIG_KASAN_SW_TAGS)))) {
> > +               unsigned long end = module_alloc_base + SZ_2G;
> > +
> > +               execmem_params.modules.text.fallback_start = module_alloc_base;
> > +               execmem_params.modules.text.fallback_end = end;
> >         }
> >
> > -       /* Memory is intended to be executable, reset the pointer tag. */
> > -       return kasan_reset_tag(p);
> > +       return &execmem_params;
> >  }
> >
> >  enum aarch64_reloc_op {

-- 
Sincerely yours,
Mike.
