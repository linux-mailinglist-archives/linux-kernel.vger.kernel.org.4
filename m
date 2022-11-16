Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11A362CCB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiKPVgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiKPVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:35:58 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC683EE1B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:35:57 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1083492009C; Wed, 16 Nov 2022 22:35:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0A81492009B;
        Wed, 16 Nov 2022 21:35:57 +0000 (GMT)
Date:   Wed, 16 Nov 2022 21:35:56 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] parport_pc: Let chipset drivers mask unsupported modes
In-Reply-To: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2211160006160.54611@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename `parport_pc_probe_port' to `__parport_pc_probe_port' and add a 
`mode_mask' parameter so that callers can specify a mask of unsupported 
modes to exclude even if mode probing seems to indicate otherwise.  Add 
a `parport_pc_probe_port' wrapper with an implicit mask of 0 for the 
current callers to use.

No functional change at this point, but the configuration of data write 
handlers is now no longer intertwined with determination and reporting 
of available modes.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/parport/parport_pc.c |   45 +++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

linux-parport-pc-mode-mask.diff
Index: linux-macro/drivers/parport/parport_pc.c
===================================================================
--- linux-macro.orig/drivers/parport/parport_pc.c
+++ linux-macro/drivers/parport/parport_pc.c
@@ -2000,11 +2000,12 @@ static int parport_dma_probe(struct parp
 static LIST_HEAD(ports_list);
 static DEFINE_SPINLOCK(ports_lock);
 
-struct parport *parport_pc_probe_port(unsigned long int base,
-				      unsigned long int base_hi,
-				      int irq, int dma,
-				      struct device *dev,
-				      int irqflags)
+static struct parport *__parport_pc_probe_port(unsigned long int base,
+					       unsigned long int base_hi,
+					       int irq, int dma,
+					       struct device *dev,
+					       int irqflags,
+					       unsigned int mode_mask)
 {
 	struct parport_pc_private *priv;
 	struct parport_operations *ops;
@@ -2116,18 +2117,28 @@ struct parport *parport_pc_probe_port(un
 	    p->dma != PARPORT_DMA_NOFIFO &&
 	    priv->fifo_depth > 0 && p->irq != PARPORT_IRQ_NONE) {
 		p->modes |= PARPORT_MODE_ECP | PARPORT_MODE_COMPAT;
+		if (p->dma != PARPORT_DMA_NONE)
+			p->modes |= PARPORT_MODE_DMA;
+	} else
+		/* We can't use the DMA channel after all. */
+		p->dma = PARPORT_DMA_NONE;
+#endif /* Allowed to use FIFO/DMA */
+
+	p->modes &= ~mode_mask;
+
+#ifdef CONFIG_PARPORT_PC_FIFO
+	if ((p->modes & PARPORT_MODE_COMPAT) != 0)
 		p->ops->compat_write_data = parport_pc_compat_write_block_pio;
 #ifdef CONFIG_PARPORT_1284
+	if ((p->modes & PARPORT_MODE_ECP) != 0)
 		p->ops->ecp_write_data = parport_pc_ecp_write_block_pio;
-#endif /* IEEE 1284 support */
-		if (p->dma != PARPORT_DMA_NONE) {
+#endif
+	if ((p->modes & (PARPORT_MODE_ECP | PARPORT_MODE_COMPAT)) != 0) {
+		if ((p->modes & PARPORT_MODE_DMA) != 0)
 			pr_cont(", dma %d", p->dma);
-			p->modes |= PARPORT_MODE_DMA;
-		} else
+		else
 			pr_cont(", using FIFO");
-	} else
-		/* We can't use the DMA channel after all. */
-		p->dma = PARPORT_DMA_NONE;
+	}
 #endif /* Allowed to use FIFO/DMA */
 
 	pr_cont(" [");
@@ -2237,6 +2248,16 @@ do {									\
 		platform_device_unregister(pdev);
 	return NULL;
 }
+
+struct parport *parport_pc_probe_port(unsigned long int base,
+				      unsigned long int base_hi,
+				      int irq, int dma,
+				      struct device *dev,
+				      int irqflags)
+{
+	return __parport_pc_probe_port(base, base_hi, irq, dma,
+				       dev, irqflags, 0);
+}
 EXPORT_SYMBOL(parport_pc_probe_port);
 
 void parport_pc_unregister_port(struct parport *p)
