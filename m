Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2684D61F564
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiKGOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiKGOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962C1CFF6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zM6BbgfCfSCfos3tEUjJzU1n9XC3FM5vgqnoPMeSh4=;
        b=tm+UuDKtm5l/qfvFtCtQkn9+nlKUcd0FMXZwD/N0Ka1Icck0LpqfBGD9XYIber/RZs2qhm
        di7pV0GPtm9HLj2VN4zQQ2SG4AQsQ7KDTN7oTSSXMUSgMC76bCTv33CsLyPFuJKxJ/Fa+t
        HAly7gRr8pJDDNXZDcmYVA5Bvu3BgltddUkB9SaGquUj74b+E2iL9noXigLGIo4ugQpYrb
        hS11fUQ9DrkkzLMWBqNv9gMH9oHCEUQLdgimCX/zlb23mazp4o9jGoOujZ1ZwrYKmDAUR7
        xx0ohCgWc+/kEsyZAgSOGLlGLOchupmxtVFr+xNcYKWclhzqII9kmYFiwHJQIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zM6BbgfCfSCfos3tEUjJzU1n9XC3FM5vgqnoPMeSh4=;
        b=DhOptzRogvtegO49HBlRx8o5kp/lMWiItSCsCgg5oU7r5sY//CNAld05WMBSfbp9FmujYZ
        BBk/NKS2y2FRUqDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 19/40] printk: console_device: use srcu console list iterator
Date:   Mon,  7 Nov 2022 15:22:17 +0106
Message-Id: <20221107141638.3790965-20-john.ogness@linutronix.de>
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

Use srcu console list iteration for console list traversal.

Document why the console_lock is still necessary. Note that this
is a preparatory change for when console_lock no longer provides
synchronization for the console list.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index de86a502b50b..ec50777d0301 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3029,15 +3029,25 @@ struct tty_driver *console_device(int *index)
 {
 	struct console *c;
 	struct tty_driver *driver = NULL;
+	int cookie;
 
+	/*
+	 * Take console_lock to serialize device() callback with
+	 * other console operations. For example, fg_console is
+	 * modified under console_lock when switching vt.
+	 */
 	console_lock();
-	for_each_console(c) {
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
 		if (!c->device)
 			continue;
 		driver = c->device(c, index);
 		if (driver)
 			break;
 	}
+	console_srcu_read_unlock(cookie);
+
 	console_unlock();
 	return driver;
 }
-- 
2.30.2

