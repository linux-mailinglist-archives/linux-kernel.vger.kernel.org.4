Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CE3710900
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjEYJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbjEYJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:34:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59B197;
        Thu, 25 May 2023 02:34:30 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685007269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfgGfHa1/jsadbpGlnKJSGFRiVJrywAA/VFxC+Yj2dA=;
        b=1XqeSoefdhJJALM506iJsLxxiP33wRzEY/RsMT3xMOtbbwSIZJfn7afMjs2zCnNlZFm+MY
        4C4cM0CGhUpbyB2kwn0lz5YTvF/Pt/sQyJPQpL7ICrDoCw7ifmLRZAs55sTnQ6JhTjOZvH
        P8ygMFRT+3hgG5MJYXN/psukiO3zfw/8WXpvUVy5s/XmOzO/zRZyDvBPeRwWAo7b82kTg8
        RQIPSeXcpQpG51Ta2ARcV0PQgJ0IGjyzvmZR59/tZ1sW5mPAgFgBa6+E6wzg55gRrk/i9r
        Wr2sPsBgf4RtvEO2LM/yU3WOLQ94jsK5nTTOYFi3lG4gpbvRbCWh7zCaCkGkzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685007269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfgGfHa1/jsadbpGlnKJSGFRiVJrywAA/VFxC+Yj2dA=;
        b=Fyn+5UtOwFlmls5SvZ5Pshw2Y2RG5/lrcgn39nVFzwqUwJW/1dghAip25QPfmh228+BFEH
        xBccxteWawp6g4AQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH tty v1 2/8] serial: core: lock port for stop_rx() in uart_suspend_port()
Date:   Thu, 25 May 2023 11:37:53 +0206
Message-Id: <20230525093159.223817-3-john.ogness@linutronix.de>
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

Fixes: c9d2325cdb92 ("serial: core: Do stop_rx in suspend path for console if console_suspend is disabled")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/serial_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4b98d13555c0..37ad53616372 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2333,8 +2333,11 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	 * able to Re-start_rx later.
 	 */
 	if (!console_suspend_enabled && uart_console(uport)) {
-		if (uport->ops->start_rx)
+		if (uport->ops->start_rx) {
+			spin_lock_irq(&uport->lock);
 			uport->ops->stop_rx(uport);
+			spin_unlock_irq(&uport->lock);
+		}
 		goto unlock;
 	}
 
-- 
2.30.2

