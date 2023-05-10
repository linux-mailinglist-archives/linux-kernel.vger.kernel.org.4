Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696176FE041
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbjEJOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjEJOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:30:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C863C3F;
        Wed, 10 May 2023 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683729006; x=1715265006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v9OiQOPeBZtIZjhKN8RGPOhJxqLBZ0UMVdfVQ4H/Sn4=;
  b=aSrSS2Di2tZJLptxSHNVz9nWrZFwnl8LtyjwMf0ALH5KkXNBC0qdo2r1
   ikxu1jNmxK50rjBj3KmnBx+DEhAM9KfYAQ6iuD9+gLaMIKEqz7aglkpN+
   w1NeVpwMdE0ctwLFSfWHdO6Fq9FTDOtay389XX2Yo+8U+mSgK6W8KIIoT
   zMP0KZTqgAiPEfovFADeh9ZzIe9RTUVuucJG6ZOqtexFinPbcBYOocB0o
   veVPd/2ni0T0rdHn/il1ZCRcRq7/G1pTXIZ0TcWZbvxF/ahrq/3xXHAkN
   MtqYFjSZOklAL9BuE3PPEJ77JMbSujhjOXSmAfkMRO5aCQe6KW500gWDD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="415802026"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="415802026"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 07:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="693408145"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="693408145"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 07:30:05 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH] serial: 8250_pci: remove unreachable code for ASIX devices
Date:   Wed, 10 May 2023 14:28:56 +0000
Message-Id: <20230510142855.256658-1-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI_VENDOR_ID_ASIX (0x9710) is the same as PCI_VENDOR_ID_NETMOS. In
pci_serial_quirks array, the NetMos entry always takes precedence over
the ASIX entry. So the code for ASIX devices is always unreachable,
even when it was initially merged. Since the NetMos vendor driver
doesn't mention such FIFO bug, it's safe to remove the code.

This reverts commit eb26dfe8aa7e ("8250: add support for ASIX devices
with a FIFO bug").

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
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
index c55be6fda0ca..5359679bc282 100644
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
@@ -1953,7 +1945,6 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_VENDOR_ID_ASIX		0x9710
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
@@ -2598,16 +2589,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
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
index fe8d79c4ae95..8b9ef175e44c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2635,11 +2635,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 
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
@@ -2800,8 +2797,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->lcr = cval;					/* Save computed LCR */
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
+		if (baud < 2400 && !up->dma) {
 			up->fcr &= ~UART_FCR_TRIGGER_MASK;
 			up->fcr |= UART_FCR_TRIGGER_1;
 		}
@@ -3137,8 +3133,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
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
2.34.1

