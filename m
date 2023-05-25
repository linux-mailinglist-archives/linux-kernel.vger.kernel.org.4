Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBFE7108FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjEYJem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbjEYJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:34:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001519D;
        Thu, 25 May 2023 02:34:30 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685007269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ja3DzHE65weLmaEmyLLj0yo4U8LIunOOQtWnThWK8is=;
        b=uFW1cntdseBw4Nlcii3FUzxCE96sV9v1tVE5rbCJukpWARo0YvyDW7fNUPGg0FvNu6s1L4
        t6We7a+2Z00Cq4YA+JMYTYuZrCzXPGgGyJu+VA6wDf9iXY1rTSJq2gin2OAdXzi4jlhSJJ
        3e5VGO1cy8G/CiPauZwJFH61Mzyo8Z20iM27bMRS7h9OvjQ2RdwbjGLpOPPL6ZUXBR4I36
        1Ejn83BGTNE4mxbHsoFkj+NO3zwSvdZ1CAdcexT1vBAsCmHNCuGvOHisxD7cSP9Gs2xDTE
        1RW8HccAkhT8ktSDbML28YHUcHpu+Y80gH4/AE+K4LHshnnL6lSWW05OlabDBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685007269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ja3DzHE65weLmaEmyLLj0yo4U8LIunOOQtWnThWK8is=;
        b=XMnjW0U55afe9vxq3aGUAviz6nfwdyywSmRFA3DlpYPJOAS2TclvYZK+gOQ4tF0Z+gwo/b
        sCv7GuZAsSdAu5AA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH tty v1 3/8] serial: 8250: lock port for stop_rx() in omap8250_irq()
Date:   Thu, 25 May 2023 11:37:54 +0206
Message-Id: <20230525093159.223817-4-john.ogness@linutronix.de>
In-Reply-To: <20230525093159.223817-1-john.ogness@linutronix.de>
References: <20230525093159.223817-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uarts_ops stop_rx() callback expects that the port->lock is
taken and interrupts are disabled.

Fixes: 1fe0e1fa3209 ("serial: 8250_omap: Handle optional overrun-throttle-ms property")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index fbca0692aa51..c17d98161d5e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -658,7 +658,9 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 		up->ier = port->serial_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
+			spin_lock(&port->lock);
 			port->ops->stop_rx(port);
+			spin_unlock(&port->lock);
 		} else {
 			/* Keep restarting the timer until
 			 * the input overrun subsides.
-- 
2.30.2

