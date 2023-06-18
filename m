Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB7734935
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 01:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFRXAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 19:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRXAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 19:00:45 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB4B1BD;
        Sun, 18 Jun 2023 16:00:44 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B775F92009C; Mon, 19 Jun 2023 01:00:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A8A0892009B;
        Mon, 19 Jun 2023 00:00:40 +0100 (BST)
Date:   Mon, 19 Jun 2023 00:00:40 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "David S. Miller" <davem@davemloft.net>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SPARC: Fix parport_pc support for 32-bit platforms
Message-ID: <alpine.DEB.2.21.2306182347101.14084@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
Cc: stable@vger.kernel.org # v5.18+
---
 arch/sparc/include/asm/parport.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

linux-sparc32-parport-pc.diff
Index: linux-macro/arch/sparc/include/asm/parport.h
===================================================================
--- linux-macro.orig/arch/sparc/include/asm/parport.h
+++ linux-macro/arch/sparc/include/asm/parport.h
@@ -19,7 +19,9 @@
  * While sparc64 doesn't have an ISA DMA API, we provide something that looks
  * close enough to make parport_pc happy
  */
+#ifdef CONFIG_SPARC64
 #define HAS_DMA
+#endif
 
 #ifdef CONFIG_PARPORT_PC_FIFO
 static DEFINE_SPINLOCK(dma_spin_lock);
@@ -249,7 +251,8 @@ static struct platform_driver ecpp_drive
 
 static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
 {
-	return platform_driver_register(&ecpp_driver);
+	return (IS_ENABLED(CONFIG_SPARC64) &&
+		platform_driver_register(&ecpp_driver));
 }
 
 #endif /* !(_ASM_SPARC64_PARPORT_H */
