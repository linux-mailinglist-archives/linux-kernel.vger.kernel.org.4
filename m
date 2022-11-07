Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9626A61F54E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiKGORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiKGOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886231D317
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:49 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+dMckPSOTswrJAevuczzlxBoDdFUTF9ehHS/Am7BVc=;
        b=p5Y/D/EInVPhXQh1fyzw62a7v7ilG2hBVvMEy5oz0pI0tKTHpq8rBapUnzJxc6CXViKuBM
        fjwYBUx8VvS36kgelTD/s5R30cFw80eGCepxLvc0xJU5zUw/pKEHUYt7Wf9Qc4lnpxgNua
        cuT4vnqNwbn21DFVQokA6zLmW5OCBYfALqXJCR9ePm0uZf9kXn8x0SZvh8c55kOMhSgsl7
        zrI9rrsv4QrCsJKK0zEIGYtxTMQLvrHFb+T8azoBLyGutNmom45RkjqxZgeUblVhLz1982
        URiRhxPP7CqjIGfTjAOCQWi+Xh5Medu17I/WeMzGxNS+IrTc+rb7Ld7diMkg/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+dMckPSOTswrJAevuczzlxBoDdFUTF9ehHS/Am7BVc=;
        b=VHoFbIAsUVtwAr5/GMK+QqboXX/RIvDR8brYVDImSGAJFJ9Lh7qHt2gyxTyFPDqAPl8eZE
        b3TUGf+2XXXNFuDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 17/40] printk: console_unblank: use srcu console list iterator
Date:   Mon,  7 Nov 2022 15:22:15 +0106
Message-Id: <20221107141638.3790965-18-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 49b9ba00eae8..c3191dc24742 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2952,10 +2952,14 @@ EXPORT_SYMBOL(console_conditional_schedule);
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
@@ -2965,9 +2969,14 @@ void console_unblank(void)
 
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

