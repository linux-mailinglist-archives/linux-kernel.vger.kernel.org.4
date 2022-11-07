Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD661F558
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiKGORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiKGOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC67A1D0DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCcbZ2nZRP4FMVS4VfHiFcW5Scqwo3VptQivrT22/cY=;
        b=0d3z4xL9MeTeQrkMA1tq1zT9HmredXjKfiAbW7rrtu69ZIzka1gnMp40KPeuojsXX3Nkr9
        AZxEtIcS7R2Ezc3gu9mFGy9bLznQxPV/GWpN/5heML3RCJIhOWSZv8V9MjC7lsI0wd9e4w
        jJrKKPKFlBps/DuPHb/J6jyDYiVm/RAPKUHiuA97ydwbA48kWnvVAHxZSQJhkwrEbnwRid
        ZLi2s1anaVF8BNNITWyPc3TywgJZJ9i0QoavNfJPeAPqEd5YQiPxGJfXjBt/6dkKiPkbZQ
        GHGshCC10unhBdwLm/cN9x56+2c6GzWHyDc1YV49NuVb+3+IcBcubRxsqwUzqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCcbZ2nZRP4FMVS4VfHiFcW5Scqwo3VptQivrT22/cY=;
        b=0BuRCrFb1lOtnGXdQk8YdKfvXzno2vWMkwrUfCthAamtrK5DjD0g+Mn8fyVA3k00ypBjwd
        hS7Z8rzULOsYtMBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH printk v3 13/40] tty: tty_io: document console_lock usage
Date:   Mon,  7 Nov 2022 15:22:11 +0106
Message-Id: <20221107141638.3790965-14-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
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

show_cons_active() uses the console_lock to gather information
on registered consoles. Since the console_lock is being used for
multiple reasons, explicitly document these reasons. This will
be useful when the console_lock is split into fine-grained
locking.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/tty_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index de06c3c2ff70..ee4da2fec328 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3526,6 +3526,16 @@ static ssize_t show_cons_active(struct device *dev,
 	struct console *c;
 	ssize_t count = 0;
 
+	/*
+	 * Hold the console_lock to guarantee that no consoles are
+	 * unregistered until all console processing is complete.
+	 * This also allows safe traversal of the console list and
+	 * race-free reading of @flags.
+	 *
+	 * Take console_lock to serialize device() callback with
+	 * other console operations. For example, fg_console is
+	 * modified under console_lock when switching vt.
+	 */
 	console_lock();
 	for_each_console(c) {
 		if (!c->device)
-- 
2.30.2

