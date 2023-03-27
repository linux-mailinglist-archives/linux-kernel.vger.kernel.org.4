Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32566CA32E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjC0MOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjC0MOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:14:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459EF3A90;
        Mon, 27 Mar 2023 05:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA050B81151;
        Mon, 27 Mar 2023 12:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F17DC433A1;
        Mon, 27 Mar 2023 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919246;
        bh=iOskfAliyJ2EhiqigbZrQ+9sb9TAldUUyoYPaRwEDOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6MicPQL1BPAw1q2u16+yvNoyGVAcN9kWWP2q0yJFA8WaLlF3xLFP4qqYt27HzGvZ
         mYxFUqLxZu9g0vfRk0OkwpqBme7YFBXsTkGRImpamVFKboMg1ei5YSkU3H42SVCWJG
         H4nHFGqZZLZUxa/aPn/txUIU1mCwKXrPAyD3x4VQDrGJVJD55nysVZn54+BS+ffi/N
         ZJubl/TUz3/2ub3bBwZP3NXIhkqVNUL1hsEZh4C64w43FHfNUjNUNIpLrpsry8bakr
         G1L0PvdkaTbdJCAriKbg/QJs9DMAkZ6JBhr2hpVO04DL/gLRI07Z7LrzaJ0P3TgcaW
         D3F+FJCQte2dA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
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
Subject: [PATCH 01/21] openrisc: dma-mapping: flush bidirectional mappings
Date:   Mon, 27 Mar 2023 14:12:57 +0200
Message-Id: <20230327121317.4081816-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The cache management operations on DMA are different from the
other architectures:

 - on DMA_TO_DEVICE, Openrisc currently invalidates the cache
   after the writeback, where a simple writeback without
   invalidation should be sufficient.

 - on DMA_BIDIRECTIONAL, Openrisc does nothing, while most
   architectures either flush before DMA, or writeback before
   and invalidate after DMA. The separate invalidation for
   DMA_BIDIRECTIONAL/DMA_FROM_DEVICE is only required on CPUs
   that can do speculative prefetches.

Change both to have the normal set of operations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/openrisc/kernel/dma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index b3edbb33b621..91a00d09ffad 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -103,10 +103,10 @@ void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
 
 	switch (dir) {
 	case DMA_TO_DEVICE:
-		/* Flush the dcache for the requested range */
+		/* Write back the dcache for the requested range */
 		for (cl = addr; cl < addr + size;
 		     cl += cpuinfo->dcache_block_size)
-			mtspr(SPR_DCBFR, cl);
+			mtspr(SPR_DCBWR, cl);
 		break;
 	case DMA_FROM_DEVICE:
 		/* Invalidate the dcache for the requested range */
@@ -114,12 +114,13 @@ void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
 		     cl += cpuinfo->dcache_block_size)
 			mtspr(SPR_DCBIR, cl);
 		break;
+	case DMA_BIDIRECTIONAL:
+		/* Flush the dcache for the requested range */
+		for (cl = addr; cl < addr + size;
+		     cl += cpuinfo->dcache_block_size)
+			mtspr(SPR_DCBFR, cl);
+		break;
 	default:
-		/*
-		 * NOTE: If dir == DMA_BIDIRECTIONAL then there's no need to
-		 * flush nor invalidate the cache here as the area will need
-		 * to be manually synced anyway.
-		 */
 		break;
 	}
 }
-- 
2.39.2

