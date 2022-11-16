Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF062CCBA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiKPVgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiKPVgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:36:07 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DECFF5B1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:36:06 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B96BA92009C; Wed, 16 Nov 2022 22:36:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B268892009B;
        Wed, 16 Nov 2022 21:36:05 +0000 (GMT)
Date:   Wed, 16 Nov 2022 21:36:05 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] parport_pc: Add a mode mask field for PCI devices
In-Reply-To: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2211160020180.54611@angie.orcam.me.uk>
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

Add a mode mask field for PCI devices and use `__parport_pc_probe_port' 
in place of `parport_pc_probe_port' to apply it.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/parport/parport_pc.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

linux-parport-pc-pci-mode-mask.diff
Index: linux-macro/drivers/parport/parport_pc.c
===================================================================
--- linux-macro.orig/drivers/parport/parport_pc.c
+++ linux-macro/drivers/parport/parport_pc.c
@@ -2659,6 +2659,9 @@ static struct parport_pc_pci {
 		/* -1 if not there, >6 for offset-method (max BAR is 6) */
 	} addr[4];
 
+	/* Bit field of parport modes to exclude. */
+	unsigned int mode_mask;
+
 	/* If set, this is called immediately after pci_enable_device.
 	 * If it returns non-zero, no probing will take place and the
 	 * ports will not be used. */
@@ -2862,9 +2865,10 @@ static int parport_pc_pci_probe(struct p
 			       id->vendor, id->device, io_lo, io_hi, irq);
 		}
 		data->ports[count] =
-			parport_pc_probe_port(io_lo, io_hi, irq,
-					       PARPORT_DMA_NONE, &dev->dev,
-					       IRQF_SHARED);
+			__parport_pc_probe_port(io_lo, io_hi, irq,
+						PARPORT_DMA_NONE, &dev->dev,
+						IRQF_SHARED,
+						cards[i].mode_mask, 0);
 		if (data->ports[count])
 			count++;
 	}
