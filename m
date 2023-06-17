Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E58733EDA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjFQGwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFQGv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B21BF2;
        Fri, 16 Jun 2023 23:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74ADB6108C;
        Sat, 17 Jun 2023 06:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5A2C433C0;
        Sat, 17 Jun 2023 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686984717;
        bh=/qKKDaoSMPytALuHQ04GytBWLf/bqmvRcK74ppFE2a8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0RFez1EfGYRPTyev/ddBuUzPfaI7NYAV3qwPAYDnlRPd3VlORPb9LLwAJNsB7HOD
         XaTNoL/vc3WgcVwGzmW11kDKJAUwiH+6/aq1FZDc7+GKKGRDNnH6fEazV3xviU4Xdu
         C+/q5uFaTCGSUOqz7wG3tCyqcwsxuFowQGM9EqAXvug3eByaI82gwGU/LAA7W+0x7N
         lIyzQgQ47UaYju+tMMa6eYibyB5m2xJlH6icNOvjTXhyI/Ih1KbRLoHwZvr/gyzXyu
         vOgqeIZZrqb6yw/imXyF8xZATseZuyfjlfKJVafWUrfVejHNNcMI379QODomewks5q
         shTjXZO35vEXQ==
Date:   Sat, 17 Jun 2023 09:51:11 +0300
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
Subject: Re: [PATCH v2 06/12] mm/execmem: introduce execmem_data_alloc()
Message-ID: <20230617065111.GR52412@kernel.org>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-7-rppt@kernel.org>
 <CAPhsuW4J+rFvh9WJVWLZxFHtcYxahYk=NoKYdU9FMibZU8986w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4J+rFvh9WJVWLZxFHtcYxahYk=NoKYdU9FMibZU8986w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:01:08PM -0700, Song Liu wrote:
> On Fri, Jun 16, 2023 at 1:51 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > Data related to code allocations, such as module data section, need to
> > comply with architecture constraints for its placement and its
> > allocation right now was done using execmem_text_alloc().
> >
> > Create a dedicated API for allocating data related to code allocations
> > and allow architectures to define address ranges for data allocations.
> >
> > Since currently this is only relevant for powerpc variants that use the
> > VMALLOC address space for module data allocations, automatically reuse
> > address ranges defined for text unless address range for data is
> > explicitly defined by an architecture.
> >
> > With separation of code and data allocations, data sections of the
> > modules are now mapped as PAGE_KERNEL rather than PAGE_KERNEL_EXEC which
> > was a default on many architectures.
> >
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> [...]
> >  static void free_mod_mem(struct module *mod)
> > diff --git a/mm/execmem.c b/mm/execmem.c
> > index a67acd75ffef..f7bf496ad4c3 100644
> > --- a/mm/execmem.c
> > +++ b/mm/execmem.c
> > @@ -63,6 +63,20 @@ void *execmem_text_alloc(size_t size)
> >                              fallback_start, fallback_end, kasan);
> >  }
> >
> > +void *execmem_data_alloc(size_t size)
> > +{
> > +       unsigned long start = execmem_params.modules.data.start;
> > +       unsigned long end = execmem_params.modules.data.end;
> > +       pgprot_t pgprot = execmem_params.modules.data.pgprot;
> > +       unsigned int align = execmem_params.modules.data.alignment;
> > +       unsigned long fallback_start = execmem_params.modules.data.fallback_start;
> > +       unsigned long fallback_end = execmem_params.modules.data.fallback_end;
> > +       bool kasan = execmem_params.modules.flags & EXECMEM_KASAN_SHADOW;
> > +
> > +       return execmem_alloc(size, start, end, align, pgprot,
> > +                            fallback_start, fallback_end, kasan);
> > +}
> > +
> >  void execmem_free(void *ptr)
> >  {
> >         /*
> > @@ -101,6 +115,28 @@ static bool execmem_validate_params(struct execmem_params *p)
> >         return true;
> >  }
> >
> > +static void execmem_init_missing(struct execmem_params *p)
> 
> Shall we call this execmem_default_init_data?

This also fills in jit.text (next patch), so _data doesn't work here :)
And it's not really a default, the defaults are set explicitly for arches
that don't have execmem_arch_params.
 
> > +{
> > +       struct execmem_modules_range *m = &p->modules;
> > +
> > +       if (!pgprot_val(execmem_params.modules.data.pgprot))
> > +               execmem_params.modules.data.pgprot = PAGE_KERNEL;
> 
> Do we really need to check each of these? IOW, can we do:
> 
> if (!pgprot_val(execmem_params.modules.data.pgprot)) {
>        execmem_params.modules.data.pgprot = PAGE_KERNEL;
>        execmem_params.modules.data.alignment = m->text.alignment;
>        execmem_params.modules.data.start = m->text.start;
>        execmem_params.modules.data.end = m->text.end;
>        execmem_params.modules.data.fallback_start = m->text.fallback_start;
>       execmem_params.modules.data.fallback_end = m->text.fallback_end;
> }

Yes, we can have a single check here.
 
> Thanks,
> Song
> 
> [...]

-- 
Sincerely yours,
Mike.
