Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3942062856E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiKNQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiKNQaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478226B;
        Mon, 14 Nov 2022 08:29:46 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrnamDANz6jBB9jzBVW9G8ct2/m0qCRJ/AQBo5wVT6Y=;
        b=w5/sljKyRtYkYJ1pMsxCYitTfJqtg6hNm6DfbHlCejsKkYAZvv1BDeo2va2iPvHtHKY5GX
        0QaQavGsGMSD5blng+gKYq21uvVtKZw2zPhZvqxyxRDJR9a707NB1m2hdWm3F4USO3vC4d
        2EVxtxHwBZuHtcIbY2HbPS0vbifvVpvbFh1AVLwgxqfb+5y0jj5/1gxsCj6CdNjV49qDM4
        pVE5HnqZaeSvfbO6I5CkNrC92ArX5yHTFNPjOdbnhfKRgWRKkU3VAgDsg27qGFh5C+DJMY
        TJd+VZwciYr6yRrdjrpLXr86o8Gf9ui6s1I2FV7oIGvdPbvhA6Y1HXMS1mHGUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrnamDANz6jBB9jzBVW9G8ct2/m0qCRJ/AQBo5wVT6Y=;
        b=wrDaBfnbdboxfSNqcK6NaH0l13NpOC/oqBFbDUHa9fhFMUBr4n0tN+svo6C1O0xwng8UUc
        wRZJdRMznoJCYcBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH printk v4 26/39] tty: serial: pic32_uart: use console_is_registered()
Date:   Mon, 14 Nov 2022 17:35:19 +0106
Message-Id: <20221114162932.141883-27-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
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
 drivers/tty/serial/pic32_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 1183b2a26539..c38754d593ca 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -843,7 +843,7 @@ console_initcall(pic32_console_init);
  */
 static int __init pic32_late_console_init(void)
 {
-	if (!(pic32_console.flags & CON_ENABLED))
+	if (!console_is_registered(&pic32_console))
 		register_console(&pic32_console);
 
 	return 0;
-- 
2.30.2

