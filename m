Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEBF6CA326
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjC0MOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjC0MOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:14:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D1A3C0A;
        Mon, 27 Mar 2023 05:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 632BAB81151;
        Mon, 27 Mar 2023 12:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F8CC433D2;
        Mon, 27 Mar 2023 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919237;
        bh=GiqSNoh/gnOD0kxoCZ+KxN9c2SO+z1nJBns1fyyi+vo=;
        h=From:To:Cc:Subject:Date:From;
        b=pq3BAphM3wHtatYjV+DfN2I8sJHS4IYBYyDE+v6/Qc8ZwCT8gpvS4DAGv7VxPzFGA
         QTONxH3L5u7xfGpaWF72Vn6IOud15UVhnlOu7Pkpc4MFJc3T+eyi/9YHM2uw4o3Q19
         hlFRkjcr9R2SPBbGCiCcG9K2ncI1oTIHchYegylFXUpPuOkFuj5EhA9x60aFehDKxy
         Qltw/cCcMI8A23tAm4waeZqorYzy7ERYFcrUh9Z5Dt10vOC7n/8mHT1x94BLc8QwMZ
         RjkfvTiQw9Na09hCmY2JMMUGUbEev+PR6WHG/lHK6hz99r9Xiisa4orl4KnTMuyptQ
         /3AEVTN69OUkQ==
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
Subject: [PATCH 00/21] dma-mapping: unify support for cache flushes
Date:   Mon, 27 Mar 2023 14:12:56 +0200
Message-Id: <20230327121317.4081816-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

After a long discussion about adding SoC specific semantics for when
to flush caches in drivers/soc/ drivers that we determined to be
fundamentally flawed[1], I volunteered to try to move that logic into
architecture-independent code and make all existing architectures do
the same thing.

As we had determined earlier, the behavior is wildly different across
architectures, but most of the differences come down to either bugs
(when required flushes are missing) or extra flushes that are harmless
but might hurt performance.

I finally found the time to come up with an implementation of this, which
starts by replacing every outlier with one of the three common options:

 1. architectures without speculative prefetching (hegagon, m68k,
    openrisc, sh, sparc, and certain armv4 and xtensa implementations)
    only flush their caches before a DMA, by cleaning write-back caches
    (if any) before a DMA to the device, and by invalidating the caches
    before a DMA from a device

 2. arc, microblaze, mips, nios2, sh and later xtensa now follow the
    normal 32-bit arm model and invalidate their writeback caches
    again after a DMA from the device, to remove stale cache lines
    that got prefetched during the DMA. arc, csky and mips used to
    invalidate buffers also before the bidirectional DMA, but this
    is now skipped whenever we know it gets invalidated again
    after the DMA.

 3. parisc, powerpc and riscv already flushed buffers before
    a DMA_FROM_DEVICE, and these get moved to the arm64 behavior
    that does the writeback before and invalidate after both
    DMA_FROM_DEVICE and DMA_BIDIRECTIONAL in order to avoid the
    problem of accidentally leaking stale data if the DMA does
    not actually happen[2].

The last patch in the series replaces the architecture specific code
with a shared version that implements all three based on architecture
specific parameters that are almost always determined at compile time.

The difference between cases 1. and 2. is hardware specific, while between
2. and 3. we need to decide which semantics we want, but I explicitly
avoid this question in my series and leave it to be decided later.

Another difference that I do not address here is what cache invalidation
does for partical cache lines. On arm32, arm64 and powerpc, a partial
cache line always gets written back before invalidation in order to
ensure that data before or after the buffer is not discarded. On all
other architectures, the assumption is cache lines are never shared
between DMA buffer and data that is accessed by the CPU. If we end up
always writing back dirty cache lines before a DMA (option 3 above),
then this point becomes moot, otherwise we should probably address this
in a follow-up series to document one behavior or the other and implement
it consistently.

Please review!

      Arnd

[1] https://lore.kernel.org/all/20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/

Arnd Bergmann (21):
  openrisc: dma-mapping: flush bidirectional mappings
  xtensa: dma-mapping: use normal cache invalidation rules
  sparc32: flush caches in dma_sync_*for_device
  microblaze: dma-mapping: skip extra DMA flushes
  powerpc: dma-mapping: split out cache operation logic
  powerpc: dma-mapping: minimize for_cpu flushing
  powerpc: dma-mapping: always clean cache in _for_device() op
  riscv: dma-mapping: only invalidate after DMA, not flush
  riscv: dma-mapping: skip invalidation before bidirectional DMA
  csky: dma-mapping: skip invalidating before DMA from device
  mips: dma-mapping: skip invalidating before bidirectional DMA
  mips: dma-mapping: split out cache operation logic
  arc: dma-mapping: skip invalidating before bidirectional DMA
  parisc: dma-mapping: use regular flush/invalidate ops
  ARM: dma-mapping: always invalidate WT caches before DMA
  ARM: dma-mapping: bring back dmac_{clean,inv}_range
  ARM: dma-mapping: use arch_sync_dma_for_{device,cpu}() internally
  ARM: drop SMP support for ARM11MPCore
  ARM: dma-mapping: use generic form of arch_sync_dma_* helpers
  ARM: dma-mapping: split out arch_dma_mark_clean() helper
  dma-mapping: replace custom code with generic implementation

 arch/arc/mm/dma.c                          |  66 ++------
 arch/arm/Kconfig                           |   4 +
 arch/arm/include/asm/cacheflush.h          |  21 +++
 arch/arm/include/asm/glue-cache.h          |   4 +
 arch/arm/mach-oxnas/Kconfig                |   4 -
 arch/arm/mach-oxnas/Makefile               |   1 -
 arch/arm/mach-oxnas/headsmp.S              |  23 ---
 arch/arm/mach-oxnas/platsmp.c              |  96 -----------
 arch/arm/mach-versatile/platsmp-realview.c |   4 -
 arch/arm/mm/Kconfig                        |  19 ---
 arch/arm/mm/cache-fa.S                     |   4 +-
 arch/arm/mm/cache-nop.S                    |   6 +
 arch/arm/mm/cache-v4.S                     |  13 +-
 arch/arm/mm/cache-v4wb.S                   |   4 +-
 arch/arm/mm/cache-v4wt.S                   |  22 ++-
 arch/arm/mm/cache-v6.S                     |  35 +---
 arch/arm/mm/cache-v7.S                     |   6 +-
 arch/arm/mm/cache-v7m.S                    |   4 +-
 arch/arm/mm/dma-mapping-nommu.c            |  36 ++--
 arch/arm/mm/dma-mapping.c                  | 181 ++++++++++-----------
 arch/arm/mm/proc-arm1020.S                 |   4 +-
 arch/arm/mm/proc-arm1020e.S                |   4 +-
 arch/arm/mm/proc-arm1022.S                 |   4 +-
 arch/arm/mm/proc-arm1026.S                 |   4 +-
 arch/arm/mm/proc-arm920.S                  |   4 +-
 arch/arm/mm/proc-arm922.S                  |   4 +-
 arch/arm/mm/proc-arm925.S                  |   4 +-
 arch/arm/mm/proc-arm926.S                  |   4 +-
 arch/arm/mm/proc-arm940.S                  |   4 +-
 arch/arm/mm/proc-arm946.S                  |   4 +-
 arch/arm/mm/proc-feroceon.S                |   8 +-
 arch/arm/mm/proc-macros.S                  |   2 +
 arch/arm/mm/proc-mohawk.S                  |   4 +-
 arch/arm/mm/proc-xsc3.S                    |   4 +-
 arch/arm/mm/proc-xscale.S                  |   6 +-
 arch/arm64/mm/dma-mapping.c                |  28 ++--
 arch/csky/mm/dma-mapping.c                 |  46 +++---
 arch/hexagon/kernel/dma.c                  |  44 ++---
 arch/m68k/kernel/dma.c                     |  43 +++--
 arch/microblaze/kernel/dma.c               |  38 ++---
 arch/mips/mm/dma-noncoherent.c             |  75 +++------
 arch/nios2/mm/dma-mapping.c                |  57 +++----
 arch/openrisc/kernel/dma.c                 |  62 ++++---
 arch/parisc/include/asm/cacheflush.h       |   6 +-
 arch/parisc/kernel/pci-dma.c               |  33 +++-
 arch/powerpc/mm/dma-noncoherent.c          |  76 +++++----
 arch/riscv/mm/dma-noncoherent.c            |  51 +++---
 arch/sh/kernel/dma-coherent.c              |  43 +++--
 arch/sparc/Kconfig                         |   2 +-
 arch/sparc/kernel/ioport.c                 |  38 +++--
 arch/xtensa/Kconfig                        |   1 -
 arch/xtensa/include/asm/cacheflush.h       |   6 +-
 arch/xtensa/kernel/pci-dma.c               |  47 +++---
 include/linux/dma-sync.h                   | 107 ++++++++++++
 54 files changed, 721 insertions(+), 699 deletions(-)
 delete mode 100644 arch/arm/mach-oxnas/headsmp.S
 delete mode 100644 arch/arm/mach-oxnas/platsmp.c
 create mode 100644 include/linux/dma-sync.h

-- 
2.39.2

Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Brian Cain <bcain@quicinc.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-oxnas@groups.io
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
