Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84C5FD84C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJMLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJMLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:24:30 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82599127415;
        Thu, 13 Oct 2022 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665660259; x=1697196259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+EOiI+S0zJYFFWtrblP4l1n4aHRxTG4VL1X65gIW8tM=;
  b=UmITO7wMOAoaOR2Y/IWrnfc55Iy1HTTBRCKIVlUlvMxNNG3nzvcLNJuc
   i4nO7GgESfNiROQOrYemklHi4cypw2jucY5mYdCPpoAlHLzaEOVGydQ1u
   W/RO/6T51COU832YEyPkXFLEwpVFqgNwH9fIq6zUnWmxFFfgKhlGf9oqA
   wf+HII6Vztpls5cJVNuVlBhTeox/ewDSQUK1PyNHCfqJrUrgoehUZuL0k
   h+Gdn+onZRacA2qmPuIzTYW5LdYyv4U9K8w83WLJqy7ZTe7nGqbF3EbQK
   Plwjd1Tb2f7RCAK/gUlHdbPgJuZXynbTbaR4hcKz++N5n9DKmCtg5Zc2u
   A==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661810400"; 
   d="scan'208";a="26733157"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Oct 2022 13:24:15 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 13 Oct 2022 13:24:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 13 Oct 2022 13:24:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665660255; x=1697196255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+EOiI+S0zJYFFWtrblP4l1n4aHRxTG4VL1X65gIW8tM=;
  b=hgqRZ8R34wzygRlc+e+bnD0T0FRAlIJKwZibw0xdlKNunIRlZfxiG+XE
   sM7VsvHcGT9QznXJLazyG5jIwsZT36Yy3Xb/OpoqAbPD0KebIAcV5TiHE
   /bXqeMsctH7TP/H+JuS1V+wvpr1W7SZ/CnER3Gnbaao493dWoaqESi7Qa
   1xc+EvjOEqjW8gUXa0evQKWZr/belDOI+g3SKqn3O3bnYRfHmlaEZeT6J
   3IOV2TI9xKq+I/OKKU1AG40LKzcLZ0udAIRV8UEr/ey65bGJZBhIJ4oxz
   4SZUfzz34rNjrlbvCSBRmOZhApc/aj7RmTLau797Dcl9PXyDCcr7Cq4Re
   w==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661810400"; 
   d="scan'208";a="26733156"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2022 13:24:15 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 7034B280056;
        Thu, 13 Oct 2022 13:24:15 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] serial: 8250_omap: remove wait loop from Errata i202 workaround
Date:   Thu, 13 Oct 2022 13:23:39 +0200
Message-Id: <20221013112339.2540767-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were occasionally seeing the "Errata i202: timedout" on an AM335x
board when repeatedly opening and closing a UART connected to an active
sender. As new input may arrive at any time, it is possible to miss the
"RX FIFO empty" condition, forcing the loop to wait until it times out.

Nothing in the i202 Advisory states that such a wait is even necessary;
other FIFO clear functions like serial8250_clear_fifos() do not wait
either. For this reason, it seems safe to remove the wait, fixing the
mentioned issue.

Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/tty/serial/8250/8250_omap.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 41b8c6b27136..484f791617af 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -193,27 +193,10 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static void omap_8250_mdr1_errataset(struct uart_8250_port *up,
 				     struct omap8250_priv *priv)
 {
-	u8 timeout = 255;
-
 	serial_out(up, UART_OMAP_MDR1, priv->mdr1);
 	udelay(2);
 	serial_out(up, UART_FCR, up->fcr | UART_FCR_CLEAR_XMIT |
 			UART_FCR_CLEAR_RCVR);
-	/*
-	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
-	 * TX_FIFO_E bit is 1.
-	 */
-	while (UART_LSR_THRE != (serial_in(up, UART_LSR) &
-				(UART_LSR_THRE | UART_LSR_DR))) {
-		timeout--;
-		if (!timeout) {
-			/* Should *never* happen. we warn and carry on */
-			dev_crit(up->port.dev, "Errata i202: timedout %x\n",
-				 serial_in(up, UART_LSR));
-			break;
-		}
-		udelay(1);
-	}
 }
 
 static void omap_8250_get_divisor(struct uart_port *port, unsigned int baud,
-- 
2.25.1

