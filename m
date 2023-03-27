Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255936CA35A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjC0MP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjC0MPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:15:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB23C33;
        Mon, 27 Mar 2023 05:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FCD1B81151;
        Mon, 27 Mar 2023 12:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E9EC433EF;
        Mon, 27 Mar 2023 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919289;
        bh=deueI+j9QpGrVEyOG4DDYuCvj98ECBO1BAKmt0h8mOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVuAqsjP7YxlTH/jfP4+hsuYEQziw3g24pme7hHONNL+tw53tUh634JeGsQ9qMsJb
         QiINm6FdyBSv5TDyEB7Icm81k8m52mJn/Oxz3tHbi/ytF+O96JNQpZ/Drh8XHi5GkJ
         DmnZaeE1/m3voIm0tXrGCkwwIwVqBzNYdHR+o9A0oJjYUFrIsmjSaMN81JqJ9bMdUz
         ALnkbRdTQARnjKcrPQsU1ISirc/GQsLgUD4/A9nuA1lqc+8ADpy1N7lxpgLiuI99q/
         wavZSpV769B5sIjhDLnf+Uwl5ZpVrfQbbb6B1+ZErklaPLQABWTLh2J99jHRm4BWCH
         eD4ekbguj3pOg==
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
Subject: [PATCH 06/21] powerpc: dma-mapping: minimize for_cpu flushing
Date:   Mon, 27 Mar 2023 14:13:02 +0200
Message-Id: <20230327121317.4081816-7-arnd@kernel.org>
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

The powerpc dma_sync_*_for_cpu() variants do more flushes than on other
architectures. Reduce it to what everyone else does:

 - No flush is needed after data has been sent to a device

 - When data has been received from a device, the cache only needs to
   be invalidated to clear out cache lines that were speculatively
   prefetched.

In particular, the second flushing of partial cache lines of bidirectional
buffers is actively harmful -- if a single cache line is written by both
the CPU and the device, flushing it again does not maintain coherency
but instead overwrite the data that was just received from the device.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/mm/dma-noncoherent.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index f10869d27de5..e108cacf877f 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -132,21 +132,11 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	switch (direction) {
 	case DMA_NONE:
 		BUG();
-	case DMA_FROM_DEVICE:
-		/*
-		 * invalidate only when cache-line aligned otherwise there is
-		 * the potential for discarding uncommitted data from the cache
-		 */
-		if ((start | end) & (L1_CACHE_BYTES - 1))
-			__dma_phys_op(start, end, DMA_CACHE_FLUSH);
-		else
-			__dma_phys_op(start, end, DMA_CACHE_INVAL);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		__dma_phys_op(start, end, DMA_CACHE_CLEAN);
+	case DMA_TO_DEVICE:
 		break;
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		__dma_phys_op(start, end, DMA_CACHE_FLUSH);
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		__dma_phys_op(start, end, DMA_CACHE_INVAL);
 		break;
 	}
 }
-- 
2.39.2

