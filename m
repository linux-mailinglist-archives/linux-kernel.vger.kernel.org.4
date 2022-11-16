Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083562CCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKPVgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiKPVgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:36:04 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65845FAF0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:36:02 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C1D3F92009D; Wed, 16 Nov 2022 22:36:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id BBC7D92009C;
        Wed, 16 Nov 2022 21:36:01 +0000 (GMT)
Date:   Wed, 16 Nov 2022 21:36:01 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] parport_pc: Let chipset drivers mask ECR bits on
 writes
In-Reply-To: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2211160220250.54611@angie.orcam.me.uk>
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

Provide an `ecr_writable' parameter to `__parport_pc_probe_port' so that 
callers can specify a mask of bits to modify on ECR writes.

To avoid the need for separate bit set and bit clear masks always set 
bit 0 whenever a non-zero mask has been set, as all the currently known 
cases where a mask is required, that is Oxford Semiconductor devices, do 
require this bit to be set.  If further cases are discovered where the 
bit is required to be clear, we can update code accordingly, but chances 
are very low as the bit is supposed to be read-only[1].

Skip ECR probing, which can be problematic as the Oxford Semiconductor 
OX12PCI840 part has been reported to lock up on setting bit 2, whenever 
a non-zero mask has been requested by a port subdriver, assuming that 
the ECR must be there if the subdriver has requested a specific way to 
access it.

References:

[1] "Extended Capabilities Port Protocol and ISA Interface Standard", 
    Microsoft Corporation, Revision: 1.14, July 14, 1993, Table 14 
    "Extended Control Register"

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/parport/parport_pc.c |   46 +++++++++++++++++++++++++++----------------
 include/linux/parport_pc.h   |    3 ++
 2 files changed, 32 insertions(+), 17 deletions(-)

linux-parport-pc-ecr-write.diff
Index: linux-macro/drivers/parport/parport_pc.c
===================================================================
--- linux-macro.orig/drivers/parport/parport_pc.c
+++ linux-macro/drivers/parport/parport_pc.c
@@ -106,15 +106,22 @@ static int pnp_registered_parport;
 static void frob_econtrol(struct parport *pb, unsigned char m,
 			   unsigned char v)
 {
+	const struct parport_pc_private *priv = pb->physport->private_data;
+	unsigned char ecr_writable = priv->ecr_writable;
 	unsigned char ectr = 0;
+	unsigned char new;
 
 	if (m != 0xff)
 		ectr = inb(ECONTROL(pb));
 
-	pr_debug("frob_econtrol(%02x,%02x): %02x -> %02x\n",
-		 m, v, ectr, (ectr & ~m) ^ v);
+	new = (ectr & ~m) ^ v;
+	if (ecr_writable)
+		/* All known users of the ECR mask require bit 0 to be set. */
+		new = (new & ecr_writable) | 1;
 
-	outb((ectr & ~m) ^ v, ECONTROL(pb));
+	pr_debug("frob_econtrol(%02x,%02x): %02x -> %02x\n", m, v, ectr, new);
+
+	outb(new, ECONTROL(pb));
 }
 
 static inline void frob_set_mode(struct parport *p, int mode)
@@ -1479,21 +1486,24 @@ static int parport_ECR_present(struct pa
 	struct parport_pc_private *priv = pb->private_data;
 	unsigned char r = 0xc;
 
-	outb(r, CONTROL(pb));
-	if ((inb(ECONTROL(pb)) & 0x3) == (r & 0x3)) {
-		outb(r ^ 0x2, CONTROL(pb)); /* Toggle bit 1 */
+	if (!priv->ecr_writable) {
+		outb(r, CONTROL(pb));
+		if ((inb(ECONTROL(pb)) & 0x3) == (r & 0x3)) {
+			outb(r ^ 0x2, CONTROL(pb)); /* Toggle bit 1 */
 
-		r = inb(CONTROL(pb));
-		if ((inb(ECONTROL(pb)) & 0x2) == (r & 0x2))
-			goto no_reg; /* Sure that no ECR register exists */
-	}
+			r = inb(CONTROL(pb));
+			if ((inb(ECONTROL(pb)) & 0x2) == (r & 0x2))
+				/* Sure that no ECR register exists */
+				goto no_reg;
+		}
 
-	if ((inb(ECONTROL(pb)) & 0x3) != 0x1)
-		goto no_reg;
+		if ((inb(ECONTROL(pb)) & 0x3) != 0x1)
+			goto no_reg;
 
-	ECR_WRITE(pb, 0x34);
-	if (inb(ECONTROL(pb)) != 0x35)
-		goto no_reg;
+		ECR_WRITE(pb, 0x34);
+		if (inb(ECONTROL(pb)) != 0x35)
+			goto no_reg;
+	}
 
 	priv->ecr = 1;
 	outb(0xc, CONTROL(pb));
@@ -2005,7 +2015,8 @@ static struct parport *__parport_pc_prob
 					       int irq, int dma,
 					       struct device *dev,
 					       int irqflags,
-					       unsigned int mode_mask)
+					       unsigned int mode_mask,
+					       unsigned char ecr_writable)
 {
 	struct parport_pc_private *priv;
 	struct parport_operations *ops;
@@ -2054,6 +2065,7 @@ static struct parport *__parport_pc_prob
 	priv->ctr = 0xc;
 	priv->ctr_writable = ~0x10;
 	priv->ecr = 0;
+	priv->ecr_writable = ecr_writable;
 	priv->fifo_depth = 0;
 	priv->dma_buf = NULL;
 	priv->dma_handle = 0;
@@ -2256,7 +2268,7 @@ struct parport *parport_pc_probe_port(un
 				      int irqflags)
 {
 	return __parport_pc_probe_port(base, base_hi, irq, dma,
-				       dev, irqflags, 0);
+				       dev, irqflags, 0, 0);
 }
 EXPORT_SYMBOL(parport_pc_probe_port);
 
Index: linux-macro/include/linux/parport_pc.h
===================================================================
--- linux-macro.orig/include/linux/parport_pc.h
+++ linux-macro/include/linux/parport_pc.h
@@ -26,6 +26,9 @@ struct parport_pc_private {
 	/* Whether or not there's an ECR. */
 	int ecr;
 
+	/* Bitmask of writable ECR bits. */
+	unsigned char ecr_writable;
+
 	/* Number of PWords that FIFO will hold. */
 	int fifo_depth;
 
