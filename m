Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2366972EDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjFMVKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbjFMVJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623131BC6;
        Tue, 13 Jun 2023 14:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42CA961864;
        Tue, 13 Jun 2023 21:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CA2C433C0;
        Tue, 13 Jun 2023 21:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690580;
        bh=CnDPIeLogwBWCfXwDFCGYSnn6freMhcPiMKmnauZmK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwHrH/UtQy5gtJuV6CZdRxLuHzTaAkiUGIx/JgEU65AMLsBIKZ0sWdlw1vTEQYgdy
         gSLYt19YIoeRBe5zYzLlgTuRTMMo3kgRmlRYZUwN9+y0DX2gj67q8Dp8pJtQUo0gHp
         Oy60KuQPQMSSexOGqUQrMmT3Fgb1GBewXzaMMxDEmcoyUN9bNnKzEk/bEsVagentbs
         IrjokONRoY0TE+yzqvQqq0avTQyKOfbb7gZycLtP7znx6sVR7tnvKBFHLqFKSVwEs2
         kIA6GPsL9JTaWmKMWc1Wdyo1oerK/huG9zsVu6RfIYfLEAg8ULTJ9IL3DRtm5ddTXF
         JrMlJp241w1cA==
Date:   Wed, 14 Jun 2023 00:09:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Song Liu <song@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20230613210900.GV52412@kernel.org>
References: <20230601101257.530867-1-rppt@kernel.org>
 <ZHjDU/mxE+cugpLj@FVFF77S0Q05N.cambridge.arm.com>
 <ZHjgIH3aX9dCvVZc@moria.home.lan>
 <ZHm3zUUbwqlsZBBF@FVFF77S0Q05N>
 <20230605092040.GB3460@kernel.org>
 <ZH20XkD74prrdN4u@FVFF77S0Q05N>
 <CAPhsuW7ntn_HpVWdGK_hYVd3zsPEFToBNfmtt0m6K8SwfxJ66Q@mail.gmail.com>
 <20230608184116.GJ52412@kernel.org>
 <ZIi7zmey0w61EG25@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIi7zmey0w61EG25@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:56:14PM -0400, Kent Overstreet wrote:
> On Thu, Jun 08, 2023 at 09:41:16PM +0300, Mike Rapoport wrote:
> > On Tue, Jun 06, 2023 at 11:21:59AM -0700, Song Liu wrote:
> > > On Mon, Jun 5, 2023 at 3:09 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > [...]
> > > 
> > > > > > > Can you give more detail on what parameters you need? If the only extra
> > > > > > > parameter is just "does this allocation need to live close to kernel
> > > > > > > text", that's not that big of a deal.
> > > > > >
> > > > > > My thinking was that we at least need the start + end for each caller. That
> > > > > > might be it, tbh.
> > > > >
> > > > > Do you mean that modules will have something like
> > > > >
> > > > >       jit_text_alloc(size, MODULES_START, MODULES_END);
> > > > >
> > > > > and kprobes will have
> > > > >
> > > > >       jit_text_alloc(size, KPROBES_START, KPROBES_END);
> > > > > ?
> > > >
> > > > Yes.
> > > 
> > > How about we start with two APIs:
> > >      jit_text_alloc(size);
> > >      jit_text_alloc_range(size, start, end);
> > > 
> > > AFAICT, arm64 is the only arch that requires the latter API. And TBH, I am
> > > not quite convinced it is needed.
> >  
> > Right now arm64 and riscv override bpf and kprobes allocations to use the
> > entire vmalloc address space, but having the ability to allocate generated
> > code outside of modules area may be useful for other architectures.
> > 
> > Still the start + end for the callers feels backwards to me because the
> > callers do not define the ranges, but rather the architectures, so we still
> > need a way for architectures to define how they want allocate memory for
> > the generated code.
> 
> So, the start + end just comes from the need to keep relative pointers
> under a certain size. I think this could be just a flag, I see no reason
> to expose actual addresses here.

It's the other way around. The start + end comes from the need to restrict
allocation to certain range because of the relative addressing. I don't see
how a flag can help here.

-- 
Sincerely yours,
Mike.
