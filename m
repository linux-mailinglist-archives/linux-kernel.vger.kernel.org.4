Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C242734941
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 01:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjFRXOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 19:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFRXOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 19:14:46 -0400
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C49E4C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 16:14:43 -0700 (PDT)
Date:   Sun, 18 Jun 2023 19:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687130080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KNV5zwl+hLzM43CrYb9nr/b3a6OyCWH6RWURaog0Xso=;
        b=n8muyYIFu4NWn2jUrxuhNWtbUM5+mIauth+1Pc71A47mzFzPENac7CXSnCthrLOM9Mp8Vp
        ZC85r5mgKM1Z6DbUVT6Cjqrw0askzvY2hRQW+Cy+BiYrMDlad4Bi9in+atwC+gux88leWU
        Lsl3kE3f4XQNXRl/yeFL9WdFeIa4tAE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 06/12] mm/execmem: introduce execmem_data_alloc()
Message-ID: <20230618231431.4aj3k5ujye22sqai@moria.home.lan>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-7-rppt@kernel.org>
 <87jzw0qu3s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzw0qu3s.ffs@tglx>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 12:32:55AM +0200, Thomas Gleixner wrote:
> Mike!
> 
> Sorry for being late on this ...
> 
> On Fri, Jun 16 2023 at 11:50, Mike Rapoport wrote:
> >  
> > +void *execmem_data_alloc(size_t size)
> > +{
> > +	unsigned long start = execmem_params.modules.data.start;
> > +	unsigned long end = execmem_params.modules.data.end;
> > +	pgprot_t pgprot = execmem_params.modules.data.pgprot;
> > +	unsigned int align = execmem_params.modules.data.alignment;
> > +	unsigned long fallback_start = execmem_params.modules.data.fallback_start;
> > +	unsigned long fallback_end = execmem_params.modules.data.fallback_end;
> > +	bool kasan = execmem_params.modules.flags & EXECMEM_KASAN_SHADOW;
> 
> While I know for sure that you read up on the discussion I had with Song
> about data structures, it seems you completely failed to understand it.
> 
> > +	return execmem_alloc(size, start, end, align, pgprot,
> > +			     fallback_start, fallback_end, kasan);
> 
> Having _seven_ intermediate variables to fill _eight_ arguments of a
> function instead of handing in @size and a proper struct pointer is
> tasteless and disgusting at best.
> 
> Six out of those seven parameters are from:
> 
>     execmem_params.module.data
> 
> while the KASAN shadow part is retrieved from
> 
>     execmem_params.module.flags
> 
> So what prevents you from having a uniform data structure, which is
> extensible and decribes _all_ types of allocations?
> 
> Absolutely nothing. The flags part can either be in the type dependend
> part or you make the type configs an array as I had suggested originally
> and then execmem_alloc() becomes:
> 
> void *execmem_alloc(type, size)
> 
> and
> 
> static inline void *execmem_data_alloc(size_t size)
> {
>         return execmem_alloc(EXECMEM_TYPE_DATA, size);
> }
> 
> which gets the type independent parts from @execmem_param.
> 
> Just read through your own series and watch the evolution of
> execmem_alloc():
> 
>   static void *execmem_alloc(size_t size)
> 
>   static void *execmem_alloc(size_t size, unsigned long start,
>                              unsigned long end, unsigned int align,
>                              pgprot_t pgprot)
> 
>   static void *execmem_alloc(size_t len, unsigned long start,
>                              unsigned long end, unsigned int align,
>                              pgprot_t pgprot,
>                              unsigned long fallback_start,
>                              unsigned long fallback_end,
>                              bool kasan)
> 
> In a month from now this function will have _ten_ parameters and tons of
> horrible wrappers which convert an already existing data structure into
> individual function arguments.
> 
> Seriously?
> 
> If you want this function to be [ab]used outside of the exec_param
> configuration space for whatever non-sensical reasons then this still
> can be either:
> 
> void *execmem_alloc(params, type, size)
> 
> static inline void *execmem_data_alloc(size_t size)
> {
>         return execmem_alloc(&exec_param, EXECMEM_TYPE_DATA, size);
> }
> 
> or
> 
> void *execmem_alloc(type_params, size);
> 
> static inline void *execmem_data_alloc(size_t size)
> {
>         return execmem_alloc(&exec_param.data, size);
> }
> 
> which both allows you to provide alternative params, right?
> 
> Coming back to my conversation with Song:
> 
>    "Bad programmers worry about the code. Good programmers worry about
>     data structures and their relationships."

Thomas, you're confusing an internal interface with external, I made the
same mistake reviewing Song's patchset...
