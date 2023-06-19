Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8A7351A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjFSKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:11:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738B1BB;
        Mon, 19 Jun 2023 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687169468; x=1718705468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zcfAJFCZmlOTI97hjlrEzimQztXQaTNGYnp64cKAXto=;
  b=XmJCi7mTeZo7JjioEL8pKplg6aegcywXR1RBpP4LsdC1Af1As3L5Ls9X
   yRHcdnisRwKnefgHeLHiociRmOPVfWQ01jcynvgQJUtTNA5XBZA1jm3M3
   G8RKkeE01dO8g3kNCgeq2Jb21t7WRge0um4KmjgrxJO+YH8O8L6pf25lC
   2ou0sb98hGYJ7NmN59eBL1XbTjOhGROCCWO0wTNHtA6OaPIT0KtJvULDO
   ZVLqhqDcamsuzWQ3XICOmR3jkmkqKBek6ADP/b4e3lboihil+uDzE+C68
   eTrD1dTMM1hlQI2vNGiG48dVJU66NErbFsigWUocv9D/0xNmH88W76IrX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339934275"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339934275"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 03:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="803572727"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="803572727"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 03:11:06 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] Revert "8250: add support for ASIX devices with a FIFO bug"
Date:   Mon, 19 Jun 2023 10:08:19 +0000
Message-Id: <20230619100818.778176-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit eb26dfe8aa7e ("8250: add support for ASIX devices with a FIFO
bug") merged on Jul 13, 2012 adds a quirk for PCI_VENDOR_ID_ASIX
(0x9710). But that ID is the same as PCI_VENDOR_ID_NETMOS defined in
1f8b061050c7 ("[PATCH] Netmos parallel/serial/combo support") merged
on Mar 28, 2005. In pci_serial_quirks array, the NetMos entry always
takes precedence over the ASIX entry even since it was initially
merged, code in that commit is always unreachable.

In my tests adding the FIFO workaround to pci_netmos_init() makes no
difference, and the vendor driver also does not have such workaround.
Given that the code was never used for over a decade, it's safe to
revert it.

Also, the real PCI_VENDOR_ID_ASIX should be 0x125b, which is used on
their newer AX99100 PCIe serial controllers released on 2016. The FIFO
workaround should not be intended for these newer controllers, and it
was never implemented in vendor driver.

This reverts commit eb26dfe8aa7eeb5a5aa0b7574550125f8aa4c3b3.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2:
* Got a Reviewed-By
* Update commit message
* Renamed from "serial: 8250_pci: remove unreachable code for ASIX
  devices"

 drivers/tty/serial/8250/8250.h      |  1 -
 drivers/tty/serial/8250/8250_pci.c  | 19 -------------------
 drivers/tty/serial/8250/8250_port.c | 11 +++--------
 include/linux/serial_8250.h         |  1 -
 4 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 1e8fe44a7099..eeb7b43ebe53 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -91,7 +91,6 @@ struct serial8250_config {
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	BIT(2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	BIT(3)	/* UART has buggy THRE reassertion */
-#define UART_BUG_PARITY	BIT(4)	/* UART mishandles parity if FIFO enabled */
 #define UART_BUG_TXRACE	BIT(5)	/* UART Tx fails to set remote DR */
 
 
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e80c4f6551a1..d2d547b5da95 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1232,14 +1232,6 @@ static int pci_oxsemi_tornado_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, up, idx);
 }
 
-static int pci_asix_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	port->bugs |= UART_BUG_PARITY;
-	return pci_default_setup(priv, board, port, idx);
-}
-
 #define QPCR_TEST_FOR1		0x3F
 #define QPCR_TEST_GET1		0x00
 #define QPCR_TEST_FOR2		0x40
@@ -1955,7 +1947,6 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_VENDOR_ID_ASIX		0x9710
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
@@ -2600,16 +2591,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.exit		= pci_wch_ch38x_exit,
 		.setup          = pci_wch_ch38x_setup,
 	},
-	/*
-	 * ASIX devices with FIFO bug
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_ASIX,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_asix_setup,
-	},
 	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c153ba3a018a..053d44412e42 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2636,11 +2636,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 
 	if (c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-	if (c_cflag & PARENB) {
+	if (c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
-		if (up->bugs & UART_BUG_PARITY)
-			up->fifo_bug = true;
-	}
 	if (!(c_cflag & PARODD))
 		cval |= UART_LCR_EPAR;
 	if (c_cflag & CMSPAR)
@@ -2801,8 +2798,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->lcr = cval;					/* Save computed LCR */
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
+		if (baud < 2400 && !up->dma) {
 			up->fcr &= ~UART_FCR_TRIGGER_MASK;
 			up->fcr |= UART_FCR_TRIGGER_1;
 		}
@@ -3138,8 +3134,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	struct uart_8250_port *up = up_to_u8250p(uport);
 	int rxtrig;
 
-	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1 ||
-	    up->fifo_bug)
+	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1)
 		return -EINVAL;
 
 	rxtrig = bytes_to_fcr_rxtrig(up, bytes);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 6f78f302d272..09029cb33e74 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -98,7 +98,6 @@ struct uart_8250_port {
 	struct list_head	list;		/* ports on this IRQ */
 	u32			capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
-	bool			fifo_bug;	/* min RX trigger if enabled */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
 	unsigned char		acr;
 	unsigned char		fcr;
-- 
2.39.2

