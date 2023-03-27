Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD806CB1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjC0WZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjC0WZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:25:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912C40CF;
        Mon, 27 Mar 2023 15:25:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31BF267373; Tue, 28 Mar 2023 00:25:15 +0200 (CEST)
Date:   Tue, 28 Mar 2023 00:25:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 21/21] dma-mapping: replace custom code with generic
 implementation
Message-ID: <20230327222514.GA17904@lst.de>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-22-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327121317.4081816-22-arnd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
>  {
> +	dma_cache_wback(paddr, size);
> +}
>  
> +static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
> +{
> +	dma_cache_inv(paddr, size);
>  }

> +static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
>  {
> +	dma_cache_wback_inv(paddr, size);
> +}

There are the only calls for the three functions for each of the
involved functions.  So I'd rather rename the low-level symbols
(and drop the pointless exports for two of them) rather than adding
these wrapppers.

The same is probably true for many other architectures.

> +static inline bool arch_sync_dma_clean_before_fromdevice(void)
> +{
> +	return false;
> +}
>  
> +static inline bool arch_sync_dma_cpu_needs_post_dma_flush(void)
> +{
> +	return true;
>  }

Is there a way to cut down on this boilerplate code by just having
sane default, and Kconfig options to override them if they are not
runtime decisions?

> +#include <linux/dma-sync.h>

I can't really say I like the #include version here despite your
rationale in the commit log.  I can probably live with it if you
think it is absolutely worth it, but I'm really not in favor of it.

> +config ARCH_DMA_MARK_DCACHE_CLEAN
> +	def_bool y

What do we need this symbol for?  Unless I'm missing something it is
always enable for arm32, and only used in arm32 code.
