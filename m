Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60331622A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKILR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiKILRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:17:53 -0500
X-Greylist: delayed 1158 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 03:17:48 PST
Received: from lucky1-04.263.net (lucky1-04.263.net [211.157.147.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C1E617B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:17:48 -0800 (PST)
Received: from localhost (unknown [192.168.167.223])
        by lucky1-04.263.net (Postfix) with ESMTP id CFD14166D0F;
        Wed,  9 Nov 2022 18:58:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp.263.net (postfix) whith ESMTP id P17536T140519130769152S1667991504274586_;
        Wed, 09 Nov 2022 18:58:25 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: delisun@pateo.com.cn
X-SENDER: delisun@pateo.com.cn
X-LOGIN-NAME: delisun@pateo.com.cn
X-FST-TO: linux@armlinux.org.uk
X-RCPT-COUNT: 6
X-LOCAL-RCPT-COUNT: 1
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 119.3.119.20
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <13a35dee304f2a19198adf39974d83ee>
X-System-Flag: 0
From:   delisun <delisun@pateo.com.cn>
To:     linux@armlinux.org.uk
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        delisun <delisun@pateo.com.cn>
Subject: [PATCH] serial: pl011: Do not clear RX FIFO & RX interrupt in unthrottle.
Date:   Wed,  9 Nov 2022 18:58:22 +0800
Message-Id: <20221109105822.332011-1-delisun@pateo.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing the RX FIFO will cause data loss.
Copy the pl011_enabl_interrupts implementation, and remove the clear
interrupt and FIFO part of the code.

Signed-off-by: delisun <delisun@pateo.com.cn>
---
 drivers/tty/serial/amba-pl011.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5cdced39eafd..08034e5dcec0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1828,8 +1828,17 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 static void pl011_unthrottle_rx(struct uart_port *port)
 {
 	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
+	unsigned long flags;
 
-	pl011_enable_interrupts(uap);
+	spin_lock_irqsave(&uap->port.lock, flags);
+
+	uap->im = UART011_RTIM;
+	if (!pl011_dma_rx_running(uap))
+		uap->im |= UART011_RXIM;
+
+	pl011_write(uap->im, uap, REG_IMSC);
+
+	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
 static int pl011_startup(struct uart_port *port)
-- 
2.25.1



