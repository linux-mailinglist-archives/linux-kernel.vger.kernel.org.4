Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D739734996
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjFSBBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSBBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:01:12 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C679DC4;
        Sun, 18 Jun 2023 18:01:06 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CE8BD92009C; Mon, 19 Jun 2023 03:01:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id BF91792009B;
        Mon, 19 Jun 2023 02:01:05 +0100 (BST)
Date:   Mon, 19 Jun 2023 02:01:05 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "David S. Miller" <davem@davemloft.net>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] SPARC: Fix parport_pc support for 32-bit platforms
Message-ID: <alpine.DEB.2.21.2306190121540.14084@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 32-bit SPARC platforms PC-style parallel ports are only available as 
PCI options.  Adjust <asm/parport.h> accordingly, fixing build errors:

sparc-linux-gnu-ld: drivers/parport/parport_pc.o: in function `ecpp_remove':
parport_pc.c:(.text+0x8f0): undefined reference to `ebus_dma_irq_enable'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x8f8): undefined reference to `ebus_dma_unregister'
sparc-linux-gnu-ld: drivers/parport/parport_pc.o: in function `parport_pc_fifo_write_block_dma':
parport_pc.c:(.text+0x1430): undefined reference to `ebus_dma_enable'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x1444): undefined reference to `ebus_dma_prepare'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x14e4): undefined reference to `ebus_dma_enable'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x14f4): undefined reference to `ebus_dma_request'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x1584): undefined reference to `ebus_dma_enable'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x1594): undefined reference to `ebus_dma_residue'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x1608): undefined reference to `ebus_dma_enable'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x1618): undefined reference to `ebus_dma_residue'
sparc-linux-gnu-ld: drivers/parport/parport_pc.o: in function `ecpp_probe':
parport_pc.c:(.text+0x33a0): undefined reference to `ebus_dma_register'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x33b8): undefined reference to `ebus_dma_irq_enable'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x34b0): undefined reference to `ebus_dma_irq_enable'
sparc-linux-gnu-ld: parport_pc.c:(.text+0x34bc): undefined reference to `ebus_dma_unregister'

Reported-by: Randy Dunlap <rdunlap@infradead.org> 
Closes: https://lore.kernel.org/r/20230406160548.25721-1-rdunlap@infradead.org/
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
Cc: stable@vger.kernel.org # v5.18+
---
NB by enabling CONFIG_WERROR I hit:

  sparc-linux-gnu-gcc -Wp,-MMD,kernel/.workqueue.o.d  -nostdinc -I./arch/sparc/include -I./arch/sparc/include/generated  -I./include -I./arch/sparc/include/uapi -I./arch/sparc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Werror -fmacro-prefix-map=./= -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Wno-format-security -funsigned-char -std=gnu11 -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -Wa,-Av8 -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-address-of-packed-member -O2 -fno-allow-store-data-races -Wframe-larger-than=1024 -fno-stack-protector -Wno-main -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno-dangling-p
 ointer -fomit-frame-pointer -ftrivial-auto-var-init=zero -fno-stack-clash-protection -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wcast-function-type -Wno-stringop-truncation -Wno-stringop-overflow -Wno-restrict -Wno-maybe-uninitialized -Wno-array-bounds -Wno-alloc-size-larger-than -Wimplicit-fallthrough=5 -fno-strict-overflow -fno-stack-check -fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -Wno-packed-not-aligned    -DKBUILD_MODFILE='"kernel/workqueue"' -DKBUILD_BASENAME='"workqueue"' -DKBUILD_MODNAME='"workqueue"' -D__KBUILD_MODNAME=kmod_workqueue -c -o kernel/workqueue.o kernel/workqueue.c  
kernel/workqueue.c: In function 'get_work_pwq':
kernel/workqueue.c:713:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  713 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
      |                        ^
kernel/workqueue.c: In function 'get_work_pool':
kernel/workqueue.c:741:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  741 |                 return ((struct pool_workqueue *)
      |                         ^
kernel/workqueue.c: In function 'get_work_pool_id':
kernel/workqueue.c:763:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  763 |                 return ((struct pool_workqueue *)
      |                         ^
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:252: kernel/workqueue.o] Error 1
make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
make: *** [Makefile:2026: .] Error 2

with top of tree GCC 14 and even came up with a fix, but I can see the 
issue is already being handled with an identical change from Arnd here: 
<https://lore.kernel.org/r/20230117164041.1207412-1-arnd@kernel.org/>, so 
there's nothing to do about it; let's just wait for 6.5.

Changes from v1:

- Wrap `dma_spin_lock' into HAS_DMA to fix a "'dma_spin_lock' defined but 
  not used" warning.  I think it's slightly cleaner this way compared to 
  wrapping the whole part into CONFIG_SPARC64, as this better reflects the 
  structure of the dependencies here.  It also follows the structure of 
  parport_pc.c, which likewise has `parport_pc_fifo_write_block_dma' put 
  into CONFIG_PARPORT_PC_FIFO and then HAS_DMA conditionals.

- Add Reported-by tag.
---
 arch/sparc/include/asm/parport.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

linux-sparc32-parport-pc.diff
Index: linux-macro/arch/sparc/include/asm/parport.h
===================================================================
--- linux-macro.orig/arch/sparc/include/asm/parport.h
+++ linux-macro/arch/sparc/include/asm/parport.h
@@ -19,9 +19,11 @@
  * While sparc64 doesn't have an ISA DMA API, we provide something that looks
  * close enough to make parport_pc happy
  */
+#ifdef CONFIG_SPARC64
 #define HAS_DMA
+#endif
 
-#ifdef CONFIG_PARPORT_PC_FIFO
+#if defined(CONFIG_PARPORT_PC_FIFO) && defined(HAS_DMA)
 static DEFINE_SPINLOCK(dma_spin_lock);
 
 #define claim_dma_lock() \
@@ -249,7 +251,8 @@ static struct platform_driver ecpp_drive
 
 static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
 {
-	return platform_driver_register(&ecpp_driver);
+	return (IS_ENABLED(CONFIG_SPARC64) &&
+		platform_driver_register(&ecpp_driver));
 }
 
 #endif /* !(_ASM_SPARC64_PARPORT_H */
