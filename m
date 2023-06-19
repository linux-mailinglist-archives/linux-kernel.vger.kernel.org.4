Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9BF7355E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjFSLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:34:36 -0400
Received: from out-34.mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1483FEE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:34:34 -0700 (PDT)
Date:   Mon, 19 Jun 2023 07:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687174472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tt3RWh8BEKoqLhK86LDh7llJ14l6KCTXk/okAyPXAzA=;
        b=i+cENnWbA17Y+F/fishc8UmKkX2d11aFrfbkEA/RSeJGs8DaK+pP54Vf1C7aoZ8NsEj74R
        cXaE50KWXHIuXWZXVuGC783hgIjWLesjrEEDAYhwTaqLKdCoI85w4n4+GuOUgBvzA2QigP
        oa1A17/zsm0VN2UgH6YNfjC3Cc/g4gI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v2 02/12] mm: introduce execmem_text_alloc() and
 jit_text_alloc()
Message-ID: <20230619113426.c37bpwvdagbzyevn@moria.home.lan>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-3-rppt@kernel.org>
 <f9a7eebe-d36e-4587-b99d-35d4edefdd14@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a7eebe-d36e-4587-b99d-35d4edefdd14@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 01:38:29PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 16, 2023, at 1:50 AM, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > module_alloc() is used everywhere as a mean to allocate memory for code.
> >
> > Beside being semantically wrong, this unnecessarily ties all subsystems
> > that need to allocate code, such as ftrace, kprobes and BPF to modules
> > and puts the burden of code allocation to the modules code.
> >
> > Several architectures override module_alloc() because of various
> > constraints where the executable memory can be located and this causes
> > additional obstacles for improvements of code allocation.
> >
> > Start splitting code allocation from modules by introducing
> > execmem_text_alloc(), execmem_free(), jit_text_alloc(), jit_free() APIs.
> >
> > Initially, execmem_text_alloc() and jit_text_alloc() are wrappers for
> > module_alloc() and execmem_free() and jit_free() are replacements of
> > module_memfree() to allow updating all call sites to use the new APIs.
> >
> > The intention semantics for new allocation APIs:
> >
> > * execmem_text_alloc() should be used to allocate memory that must reside
> >   close to the kernel image, like loadable kernel modules and generated
> >   code that is restricted by relative addressing.
> >
> > * jit_text_alloc() should be used to allocate memory for generated code
> >   when there are no restrictions for the code placement. For
> >   architectures that require that any code is within certain distance
> >   from the kernel image, jit_text_alloc() will be essentially aliased to
> >   execmem_text_alloc().
> >
> 
> Is there anything in this series to help users do the appropriate synchronization when the actually populate the allocated memory with code?  See here, for example:
> 
> https://lore.kernel.org/linux-fsdevel/cb6533c6-cea0-4f04-95cf-b8240c6ab405@app.fastmail.com/T/#u

We're still in need of an arch independent text_poke() api.
