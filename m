Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024BD62C446
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiKPQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiKPQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9596057B5D;
        Wed, 16 Nov 2022 08:22:12 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0N6+oqs8YDesp1N8syBA/TOKLtd+9UFIcKPgI5bch8=;
        b=wPgQxX1oQOVhnIHx4abeauz5e7rEg0cwq5AOSReGNyVI0GuDMJ6kOxzMqgo1hBiby93eiw
        5hBeCrKYPerk7JvYO8vosiWvKyDPP4cAvtIpw/1zVg+gGlgIShIO0DOXM0NlWFYl5WeH1w
        WA8DgdazYTIbRMqodAkgxFBB3+Mm0uDgTkJf3dn5f46ZjCd5kn97toOZnVj/equ7JrSvUO
        r/4XzPjW/bQmnrL64Or8kzA5/4EVeUCgg1O+2wDvVFNd9QBb1iSKtJUbwpkRHjvnQ/F/U4
        G0cFr/34shXiB9Hei+AMjQk4UsbqUF58IDPWuUFjW50qPwjkdAmfQ9w5cU+LXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0N6+oqs8YDesp1N8syBA/TOKLtd+9UFIcKPgI5bch8=;
        b=MyQecpelV/Y/Ej5hHdh0TQTK+n3Ui1E7BQDeR9U4wt14VpwlS8pr/VUvxnyUuEshVddrWN
        FzYp4/jEDqsa0BBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH printk v5 29/40] tty: serial: xilinx_uartps: use console_is_registered()
Date:   Wed, 16 Nov 2022 17:27:41 +0106
Message-Id: <20221116162152.193147-30-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not reliable to check for CON_ENABLED in order to identify if a
console is registered. Use console_is_registered() instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2eff7cff57c4..0cbd1892c53b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1631,7 +1631,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
 	if (console_port == port &&
-	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED)) {
+	    !console_is_registered(cdns_uart_uart_driver.cons)) {
 		console_port = NULL;
 		cdns_uart_console.index = -1;
 	}
-- 
2.30.2

