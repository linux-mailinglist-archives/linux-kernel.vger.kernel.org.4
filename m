Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A2723F17
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjFFKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjFFKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A440E47;
        Tue,  6 Jun 2023 03:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 986FB6305D;
        Tue,  6 Jun 2023 10:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CCDC433EF;
        Tue,  6 Jun 2023 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686046599;
        bh=K3mQNwoT9j+uKtNH0+N5SGAruipqVMe0nyrOVYu8zmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ex2boOSbFX9F8vILoj2ER6OMGqZieI/qXxa+Cl88F6P5WueebucHT8gXYMljU/UwF
         W4Vwtw16CB66Ckf8CUcEwiMgsp0Rl7Zp+sWmc7WhCTWF54CsHU5is7Yegd2qZ+FcpB
         7HYr90xDXGc4Q+jlXpM3iwKf1+z1TAE79jym8dBpk7/sIwryEOoaJwZE+mZ+/dgO9Q
         jbUZZ/yVspF9cToZ4ExktC3lUSHmqXSahqJcQT5b1PfE/IsSC9GrwIVg8JzQsfRBlA
         +FWytBECVY5td4H8LIUSl6ZWwnci/X0OdWg6sGet7yNw0Tt3OFZ9/6khP83arPzxeP
         mpCOpEPlPas8A==
Date:   Tue, 6 Jun 2023 13:16:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
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
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 00/13] mm: jit/text allocator
Message-ID: <20230606101608.GC52412@kernel.org>
References: <20230601101257.530867-1-rppt@kernel.org>
 <ZHjDU/mxE+cugpLj@FVFF77S0Q05N.cambridge.arm.com>
 <ZHjgIH3aX9dCvVZc@moria.home.lan>
 <ZHm3zUUbwqlsZBBF@FVFF77S0Q05N>
 <20230605092040.GB3460@kernel.org>
 <ZH20XkD74prrdN4u@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH20XkD74prrdN4u@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 11:09:34AM +0100, Mark Rutland wrote:
> On Mon, Jun 05, 2023 at 12:20:40PM +0300, Mike Rapoport wrote:
> > On Fri, Jun 02, 2023 at 10:35:09AM +0100, Mark Rutland wrote:
> >
> > It sill can be achieved with a single jit_alloc_arch_params(), just by
> > adding enum jit_type parameter to jit_text_alloc().
> 
> That feels backwards to me; it centralizes a bunch of information about
> distinct users to be able to shove that into a static array, when the callsites
> can pass that information. 

The goal was not to shove everything into an array, but centralize
architecture requirements for code allocations. The callsites don't have
that information per se, they get it from the arch code, so having this
information in a single place per arch is better than spreading
MODULE_START, KPROBES_START etc all over.

I'd agree though that having types for jit_text_alloc is ugly and this
should be handled differently.
 
> What's *actually* common after separating out the ranges? Is it just the
> permissions?

On x86 everything, on arm64 apparently just the permissions.

I've started to summarize what are the restrictions for code placement for
modules, kprobes and bpf on different architectures, that's roughly what
I've got so far:

* x86 and s390 need everything within modules address space because of
PC-relative
* arm, arm64, loongarch, sparc64, riscv64, some of mips and
powerpc32 configurations require a dedicated modules address space; the
rest just use vmalloc address space
* all architectures that support kprobes except x86 and s390 don't use
relative jumps, so they don't care where kprobes insn_page will live
* not sure yet about BPF. Looks like on arm and arm64 it does not use
relative jumps, so it can be anywhere, didn't dig enough about the others.

> If we want this to be able to share allocations and so on, why can't we do this
> like a kmem_cache, and have the callsite pass a pointer to the allocator data?
> That would make it easy for callsites to share an allocator or use a distinct
> one.

This maybe something worth exploring.
 
> Thanks,
> Mark.

-- 
Sincerely yours,
Mike.
