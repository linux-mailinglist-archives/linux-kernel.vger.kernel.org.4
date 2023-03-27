Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F56CA382
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjC0MQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjC0MQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD244AC;
        Mon, 27 Mar 2023 05:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1278611F5;
        Mon, 27 Mar 2023 12:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBF0C433EF;
        Mon, 27 Mar 2023 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919333;
        bh=1A9PPhpjfn5VxBSmEZUVZ96wOnXUnzHwhEr/+6UxMII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTcyGdTSTyjUcBoLSVeACST/PtG6gZO3O0XJKQPppvSvNB4NDcy90mHMF4gJPiNS6
         dNtpCw1Tg4EZtsG9wUbybuw0872LTI9FUQllw/7Q76rCvz6Crnc81KUI9Kj4chNtUZ
         csalhGjvFzfmW3DiLJ6yzIpVXX+f5lcRxoFKXzIm876A40pKei6+o+8NXVAEYBZqzo
         s4oPjpuA8RpmeGU6lv0FlQ6gA3tl8++a/WzT9oNtEmsVj2YTsrbo7DHFpEIVM4/NkV
         v133TD824709IDedq8WaO7uGv2weYLR4T+0csPE1290Z1QSEI0fkOubzH+lLl8W9RM
         VLW1WwaNQGF9g==
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
Subject: [PATCH 11/21] mips: dma-mapping: skip invalidating before bidirectional DMA
Date:   Mon, 27 Mar 2023 14:13:07 +0200
Message-Id: <20230327121317.4081816-12-arnd@kernel.org>
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

Some architectures that need to invalidate buffers after bidirectional
DMA because of speculative prefetching only do a simpler writeback
before that DMA, while architectures that don't need to do the second
invalidate tend to have a combined writeback+invalidate before the
DMA.

The behavior on mips is slightly inconsistent, as it always
does the invalidation before bidirectional DMA and conditionally
does it a second time.

In order to make the behavior the same as the rest, change it
so that there is exactly one invalidation here, either before
or after the DMA.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/mm/dma-noncoherent.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 3c4fc97b9f39..b4350faf4f1e 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -65,7 +65,11 @@ static inline void dma_sync_virt_for_device(void *addr, size_t size,
 		dma_cache_inv((unsigned long)addr, size);
 		break;
 	case DMA_BIDIRECTIONAL:
-		dma_cache_wback_inv((unsigned long)addr, size);
+		if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
+		    cpu_needs_post_dma_flush())
+			dma_cache_wback((unsigned long)addr, size);
+		else
+			dma_cache_wback_inv((unsigned long)addr, size);
 		break;
 	default:
 		BUG();
-- 
2.39.2

