Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13762856F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiKNQbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiKNQaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A3248DA;
        Mon, 14 Nov 2022 08:29:46 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hf4u/s4+AojpME8OJwmFCYo46PpjYxYo+DIhKotoZ0=;
        b=3A3qm8uDKxldk2T+hFZX4oojBNblkduXllzMasj4W0ht7c2/3fqnH3zNEGNyz7UDm86I4R
        t9xNaY7SebfdzeMGbytN95G8jY2ce/0FUqYYjWsk9XkYvi0nWdcZqHayxg0mH0TEdFDQM4
        wcluFDiKhfi2ejqyWTs4wTolKa2I3oGyg5K0MdUThrH4GzDkdygFjO3jy0bdDbtootI8Tp
        RraaolWi+bzN9nt6VpvWHUx+FDJczUk5x/EllO8pyEK37fhDFX8v1L3/vnC/0HqNpDH01l
        T5t20yuqcBRRSb3YbAfmH68OtB10CA4Es9BqH7O+2scnn3tvpqr8PLQ3kXlYzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hf4u/s4+AojpME8OJwmFCYo46PpjYxYo+DIhKotoZ0=;
        b=6SYcyGF1KYOUi2rQepMLbRowh0PZ02xDI4iFmHmOD+BhQAJdnS81gt5fyN4spMhZcaCS2/
        rPEVeTTT6MB5zXDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH printk v4 25/39] tty: serial: earlycon: use console_is_registered()
Date:   Mon, 14 Nov 2022 17:35:18 +0106
Message-Id: <20221114162932.141883-26-john.ogness@linutronix.de>
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
 drivers/tty/serial/earlycon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a5f380584cda..4f6e9bf57169 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -181,7 +181,7 @@ int __init setup_earlycon(char *buf)
 	if (!buf || !buf[0])
 		return -EINVAL;
 
-	if (early_con.flags & CON_ENABLED)
+	if (console_is_registered(&early_con))
 		return -EALREADY;
 
 again:
@@ -253,7 +253,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	bool big_endian;
 	u64 addr;
 
-	if (early_con.flags & CON_ENABLED)
+	if (console_is_registered(&early_con))
 		return -EALREADY;
 
 	spin_lock_init(&port->lock);
-- 
2.30.2

