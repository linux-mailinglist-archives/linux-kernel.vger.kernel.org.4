Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA02604A72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJSPFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiJSPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956EB96;
        Wed, 19 Oct 2022 07:58:37 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYLncsVrBizTn0tZlGmVU07Lo3jyJ/DS7XfMGutmnSA=;
        b=JPedjArJAuY5hRBDkNnnczWzi0rdtYdWSojm+d6XEyT740PpZPGKZQU8tT+uuaYGiVPfsv
        wihTQwPpb5Vfqyv+jnFaz5aslcibke0hRWUqpVTOTuDJ52Sk0LuaLb/GZm3txhIsikw6KC
        X9YIkrLQk7MjDOB4L+8dYq42ZQZWa0JICoBu63P2KT3BFI0l6VLvdUELcHhxm1urY9c4oO
        srY+3ajo1wLeddjhJXCk3lYKZGbHvMEMjeWmEZQ6iCGDF2dgpc5Hw+kMV7spvVFzkpsW9a
        N9oAjW1J4KS75rVtgGeiiia5qozkB4wZddYkiJVVpOYDHNoA8R8m6cygY7P6QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYLncsVrBizTn0tZlGmVU07Lo3jyJ/DS7XfMGutmnSA=;
        b=S7pfiQDwwJc4IAaG+ohuEdR5wq8i6B5ZKrnBe8A+GkV8vDCEdvI4ws2GTEvObuZQVkx4oN
        ggzfXJPGE1IMo9CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH printk v2 13/38] tty: serial: pic32_uart: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:35 +0206
Message-Id: <20221019145600.1282823-14-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/pic32_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 2beada66c824..d70344dc6e8a 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -843,7 +843,7 @@ console_initcall(pic32_console_init);
  */
 static int __init pic32_late_console_init(void)
 {
-	if (!(pic32_console.flags & CON_ENABLED))
+	if (!console_is_enabled(&pic32_console))
 		register_console(&pic32_console);
 
 	return 0;
-- 
2.30.2

