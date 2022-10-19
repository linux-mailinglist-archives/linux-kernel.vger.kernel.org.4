Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E20604A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiJSPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJSPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AED17A00F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqMbZeBSwCTLR7jNGQqhFOnz+Wzb4xZRR+OQHg2ho6o=;
        b=lobQdIkShxdMxRZEwTiKHKRdYrav0E98bLb9pr2dQOcNULPLucAZSh3RnXK47pdlrnRy7e
        rKvaMi2imL2d8ki0pJMqOXyRXTfCb+ul8uXBYGuHo7GwL49QRSx2L9VK1XBQJjs6yP2zwb
        tOnmcTHkIw9Qp1vNXr9lSiMYbFGeETSZwSlVVvooCwWgx2rrd9VrlCjUbcosHABwVQxDAH
        E71fyzXayt5EED6w2RBkiifmqE+ntg+B5mJ4fxLHsz6pTtFDVtbbKrjvpFfXmyj4++KFLZ
        y4R29TPq7RP6erhqm2MBnwMRn01T7DiJXs/bj+D5Af6g9rFIHk5t0eTS4nhrww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqMbZeBSwCTLR7jNGQqhFOnz+Wzb4xZRR+OQHg2ho6o=;
        b=hLMMc2KrQ3G15NfP/J2YPlS4qSK28nPxhtnXaVM7oNoI0MAE7GvWTiYbgzRVHjyLUFvKEt
        Lp1mlmci6t0st2CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 28/38] printk: console_unblank: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:50 +0206
Message-Id: <20221019145600.1282823-29-john.ogness@linutronix.de>
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

Use srcu console list iteration for console list traversal.

Document why the console_lock is still necessary.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c4d5d58b5977..0c37ab208395 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2948,10 +2948,14 @@ EXPORT_SYMBOL(console_conditional_schedule);
 void console_unblank(void)
 {
 	struct console *c;
+	int cookie;
 
 	/*
-	 * console_unblank can no longer be called in interrupt context unless
-	 * oops_in_progress is set to 1..
+	 * Stop console printing because the unblank() callback may
+	 * assume the console is not within its write() callback.
+	 *
+	 * If @oops_in_progress is set, this may be an atomic context.
+	 * In that case, attempt a trylock as best-effort.
 	 */
 	if (oops_in_progress) {
 		if (down_trylock_console_sem() != 0)
@@ -2961,9 +2965,14 @@ void console_unblank(void)
 
 	console_locked = 1;
 	console_may_schedule = 0;
-	for_each_console(c)
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
 		if (console_is_enabled(c) && c->unblank)
 			c->unblank();
+	}
+	console_srcu_read_unlock(cookie);
+
 	console_unlock();
 
 	if (!oops_in_progress)
-- 
2.30.2

