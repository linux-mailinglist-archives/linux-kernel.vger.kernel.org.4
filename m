Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D66CA880
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjC0PCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjC0PCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:02:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC34C05;
        Mon, 27 Mar 2023 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GEE0ldPCAv+f5hC1f+jvTvP/uCZufNK448SDtGAe4Zk=; b=v1TiVcw6SlE1jYl57XDWmMLk7R
        EWSel/m8qaxtTIpi1wpcv4wbnE7RPavO3PfN2/IvOoiwi/gCP7xcE5F2askSa5L3uzpsODKQD61x8
        StfEk4v08foXfrG7VasjwmrT+4yuDajfp3NNHvjaYyh4aLuCmqN87WdluK/CgHa4tXqQusBd9TUSf
        rgoEiiSrmdHN6nfAY4zrzY2ufcDHt1crFZ4RO0F/V9Ze42PDJKXYA8Ce8yBzBCsjOpJfgasawcEnA
        +RKV1eekKL4QKumS3WLMLcQq87DVakybcmXPiUHI+Lzv6UbDhiuLRCeqCognGPTq1tbBLbTgEZBez
        GAl3pldA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58066)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pgoM7-00040C-4u; Mon, 27 Mar 2023 16:01:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pgoLv-0005Vg-EZ; Mon, 27 Mar 2023 16:01:43 +0100
Date:   Mon, 27 Mar 2023 16:01:43 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@kernel.org>,
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
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean()
 helper
Message-ID: <ZCGv18wnEtoFvtfM@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-21-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327121317.4081816-21-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 02:13:16PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The arm version of the arch_sync_dma_for_cpu() function annotates pages as
> PG_dcache_clean after a DMA, but no other architecture does this here.

... because this is an arm32 specific feature. Generically, it's
PG_arch_1, which is a page flag free for architecture use. On arm32
we decided to use this to mark whether we can skip dcache writebacks
when establishing a PTE - and thus it was decided to call it
PG_dcache_clean to reflect how arm32 decided to use that bit.

This isn't just a DMA thing, there are other places that we update
the bit, such as flush_dcache_page() and copy_user_highpage().

So thinking that the arm32 PG_dcache_clean is something for DMA is
actually wrong.

Other architectures are free to do their own other optimisations
using that bit, and their implementations may be DMA-centric.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
