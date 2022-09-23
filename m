Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1EF5E821B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIWSwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIWSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:52:11 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86FCF121119
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:52:09 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B959792009C; Fri, 23 Sep 2022 20:52:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B226892009B;
        Fri, 23 Sep 2022 19:52:08 +0100 (BST)
Date:   Fri, 23 Sep 2022 19:52:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] parport_pc: Avoid FIFO port location truncation
Message-ID: <alpine.DEB.2.21.2209231912550.29493@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match the data type of a temporary holding a reference to the FIFO port 
with the type of the original reference coming from `struct parport', 
avoiding data truncation with LP64 ports such as SPARC64 that refer to 
PCI port I/O locations via their corresponding MMIO addresses and will 
therefore have non-zero bits in the high 32-bit part of the reference.
And in any case it is cleaner to have the data types matching here.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/linux-pci/20220419033752.GA1101844@bhelgaas/
---
Hi,

 Found by code inspection in tracking down the cause of an oops; cf. 
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2209220223080.29493@angie.orcam.me.uk/>.  
Credit to Bjorn for the details of the SPARC64 peculiarity.

 I guess nobody has actually ever used a PCI parallel port with a SPARC64 
machine, so it's probably not worth backporting, but I have chosen to add 
a `Fixes' tag regardless for tracking, statistics, or whatever it might be 
useful for, even though the offending temporary has been added long before 
our GIT history (with or around Linux 2.3.10 AFAICT).

  Maciej
---
 drivers/parport/parport_pc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-parport-pc-fifo-unsigned-long.diff
Index: linux-macro/drivers/parport/parport_pc.c
===================================================================
--- linux-macro.orig/drivers/parport/parport_pc.c
+++ linux-macro/drivers/parport/parport_pc.c
@@ -468,7 +468,7 @@ static size_t parport_pc_fifo_write_bloc
 	const unsigned char *bufp = buf;
 	size_t left = length;
 	unsigned long expire = jiffies + port->physport->cad->timeout;
-	const int fifo = FIFO(port);
+	const unsigned long fifo = FIFO(port);
 	int poll_for = 8; /* 80 usecs */
 	const struct parport_pc_private *priv = port->physport->private_data;
 	const int fifo_depth = priv->fifo_depth;
