Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FFF661EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjAIHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjAIHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:02:09 -0500
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E78D5FAE
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:02:07 -0800 (PST)
From:   Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1673247725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oCppCv1oBsre+FVN86oFN46fKVCfGcF37Evg0UDVbMg=;
        b=lXde/TaEiwxChv4sBX/aT/8+A5We1Huz6H/ExEvgCIS96gaNehxWUSxhbYoeFnuf5ZDWfq
        iciIAbeKcl8VwT3kJIBvZPvL59pG5dS9H5WzfbjTWD1uR0LP45A/0vV2VT7nO/IOBNLe1h
        rH6TlalMTyuBtilnFyNOF61AHaxmBW+zs2evkFWG0nmqMzyR7HeRh7xq4JlNi3FjNcfh0L
        tkCcOpiuVCRj3hti8bA/WVK8HeqxlsJhTD93CSqUBV4KF/tqZ8ctnXb0jl6uFmR1P6OPhD
        YT/zm94sVU3AUThynErZiXiPOdzNv2evc35h1P7O6QCqBBMQvJjLzjIzrrvMOA==
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] serial: atmel: fix incorrect baudrate setup
Date:   Mon,  9 Jan 2023 08:02:00 +0100
Message-Id: <20230109070200.200181-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ba47f97a18f2 ("serial: core: remove baud_rates when serial console
setup") changed uart_set_options to select the correct baudrate
configuration based on the absolute error between requested baudrate and
available standard baudrate settings.
Prior to that commit the baudrate was selected based on which predefined
standard baudrate did not exceed the requested baudrate.
This change of selection logic was never reflected in the atmel serial
driver. Thus the comment left in the atmel serial driver is no longer
accurate.
Additionally the manual rounding up described in that comment and applied
via (quot - 1) requests an incorrect baudrate. Since uart_set_options uses
tty_termios_encode_baud_rate to determine the appropriate baudrate flags
this can cause baudrate selection to fail entirely because
tty_termios_encode_baud_rate will only select a baudrate if relative error
between requested and selected baudrate does not exceed +/-2%.
Fix that by requesting actual, exact baudrate used by the serial.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/tty/serial/atmel_serial.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index f1c06e12efa0..9cd7479b03c0 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2657,13 +2657,7 @@ static void __init atmel_console_get_options(struct uart_port *port, int *baud,
 	else if (mr == ATMEL_US_PAR_ODD)
 		*parity = 'o';
 
-	/*
-	 * The serial core only rounds down when matching this to a
-	 * supported baud rate. Make sure we don't end up slightly
-	 * lower than one of those, as it would make us fall through
-	 * to a much lower baud rate than we really want.
-	 */
-	*baud = port->uartclk / (16 * (quot - 1));
+	*baud = port->uartclk / (16 * quot);
 }
 
 static int __init atmel_console_setup(struct console *co, char *options)
-- 
2.30.2

