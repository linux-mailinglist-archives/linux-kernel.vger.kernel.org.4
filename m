Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6270562C42F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiKPQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiKPQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F42226495
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:07 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0qlTUKV9y3QSw09vgZHZ2kx/Yss2JifrQdnD+gXn68=;
        b=t2HcoKXheo/9cKQLAg3L3ksvZhwzlBHB2iUjivKMmeWAOQ7QYzUhxH0EMOGkmJplEeP8ff
        QoHLhCiF1him5w0dcj2u5w5ITkU6WbgMgYFCnwAJ1gaVBXmySBijfFa785IKlScZO6tXDX
        BO64psIYULhP5UmnTGw0coO85633ZdhTBSwVCGdTVuUYZslepqLX74AFjsPLG5reOMZ3Af
        hpFQpyhG1VlwJ1qzZBxERmW/0f9SDEkLmpCIC8cHCxFwS7fGh9TAxtogF8RDu/kvUBab91
        yOHJJWCSqJ6VvXlFsMqtFhCHwH3PGzLYWoN4lI2OIba8zID69cevqUb4/kBXDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0qlTUKV9y3QSw09vgZHZ2kx/Yss2JifrQdnD+gXn68=;
        b=x9m2gRFmDedx3teMkiLLQUfM2cC+aisawOZm8nNBomlUsbehXNe4+5wP2d+xmXJ6jYL8NO
        oQ8q1WuUnKc8UiAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 18/40] printk: console_unblank: use srcu console list iterator
Date:   Wed, 16 Nov 2022 17:27:30 +0106
Message-Id: <20221116162152.193147-19-john.ogness@linutronix.de>
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

Use srcu console list iteration for console list traversal.

Document why the console_lock is still necessary. Note that this
is a preparatory change for when console_lock no longer provides
synchronization for the console list.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 75951c4bda05..b4be3b08d909 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2999,10 +2999,14 @@ EXPORT_SYMBOL(console_conditional_schedule);
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
@@ -3012,9 +3016,14 @@ void console_unblank(void)
 
 	console_locked = 1;
 	console_may_schedule = 0;
-	for_each_console(c)
-		if ((c->flags & CON_ENABLED) && c->unblank)
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
+		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank)
 			c->unblank();
+	}
+	console_srcu_read_unlock(cookie);
+
 	console_unlock();
 
 	if (!oops_in_progress)
-- 
2.30.2

