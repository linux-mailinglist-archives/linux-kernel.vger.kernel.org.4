Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09C771090A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbjEYJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbjEYJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:34:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074271B1;
        Thu, 25 May 2023 02:34:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685007270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPDJHm4lU4uW5PYPRilpSR3PUXlYNGeyc1k5gm2WMrg=;
        b=Bn9RR6tFw4VHxMRtNu5ITPrZWhJi9VsTk3Ief2f7HcBlEtLMBnVNouWr0IM4OCsP02Dq7Q
        gdWxPPKFD6kokGHfylzCLf1elFujWvrjGvnJqujbqfHuADfuMLyd6ENik68sarNNrhQFuE
        c4RkxSMLo7Jg4Ctn+oJapV4snGobAEx0h5zm/6LKkgV48KMBlXtUQ7u4cf07BFSCaEYVjs
        CLVHT/h0C+zTSycU3IFxqCaSwRZY02Qgl4LpRpu15aLv5QBON8m6QA+BXf3T7MUmdcMh/v
        tARTQSo+S9rmvPFdJm8rCofDsynBzdEdXV+R9vlJp9w5Fe5d9Bc6DCZitRM3iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685007270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPDJHm4lU4uW5PYPRilpSR3PUXlYNGeyc1k5gm2WMrg=;
        b=D7c8sfO9B0xWafdKccZQxoeJ+NYAiCmP6zJoGfo+FNhKFSWjUhH4xcqrDjjtHasOyuCFUa
        o6+70hF7B7N+QMDA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH tty v1 6/8] serial: 8250: lock port for omap8250_restore_regs()
Date:   Thu, 25 May 2023 11:37:57 +0206
Message-Id: <20230525093159.223817-7-john.ogness@linutronix.de>
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

omap8250_restore_regs() accesses UART_IER. This register is
modified twice by each console write (serial8250_console_write())
under the port lock. However, not all calls to omap8250_restore_regs()
are under the port lock.

Add the missing port locking around omap8250_restore_regs() calls. Add
lockdep notation to the omap8250_restore_regs().

Note that this is not fixing a real problem because the serial devices
are resumed before console printing is enabled.

However, adding this locking allows for clean locking semantics
for omap8250_restore_regs() so that lockdep can be used to identify
possible problems in the future. It also simplifies synchronization
of UART_IER in general by not needing to rely on such implementation
details.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 3cb9cfa62331..34939462fd69 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -309,6 +309,9 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 	struct uart_8250_dma	*dma = up->dma;
 	u8 mcr = serial8250_in_MCR(up);
 
+	/* Port locked to synchronize UART_IER access against the console. */
+	lockdep_assert_held_once(&up->port.lock);
+
 	if (dma && dma->tx_running) {
 		/*
 		 * TCSANOW requests the change to occur immediately however if
@@ -1739,8 +1742,11 @@ static int omap8250_runtime_resume(struct device *dev)
 	if (priv->line >= 0)
 		up = serial8250_get_port(priv->line);
 
-	if (up && omap8250_lost_context(up))
+	if (up && omap8250_lost_context(up)) {
+		spin_lock_irq(&up->port.lock);
 		omap8250_restore_regs(up);
+		spin_unlock_irq(&up->port.lock);
+	}
 
 	if (up && up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2)) {
 		spin_lock_irq(&up->port.lock);
-- 
2.30.2

