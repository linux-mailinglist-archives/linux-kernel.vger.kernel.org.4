Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBBF62C41E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiKPQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiKPQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C953EE9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:06 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtH4yW3JeyI4F3eGTioeuhi1fpVcHx73Hw0G9i8hSSU=;
        b=kayQnh7l4s1491kWSKsE/fOVnX9St78ObnsuaLA1l80ClxwMsYALUbty4DW6fqOiG5YVUa
        lg4IoP9w8yOjeLX4z39itvhtah+ckgU060CVoM7oO6lzA0XOWohgesE7+MLAwzzUJK/9JF
        McJBvjt14QhEPdiWLpuZ2QRn5X3tI4qkl6flh3vUgYemOXjw+A7Nn1pEGjBPY1b4VcBawz
        2Z5IFC9i4PVN4C+bUtIZNOF368QeWu3VNuuCp2Ld/5LafIGNTU41lOfmP3m3JDB9I1pgXb
        avVBlbxv32SlYFsQFcml1Ss+YxWCCDK3kqlG/eEGkZdBzvGBB3Vovt0cuvdKmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtH4yW3JeyI4F3eGTioeuhi1fpVcHx73Hw0G9i8hSSU=;
        b=p+tlMt2fKLrSZ7uozDnyug3YD7ymR7gPSP52ARH76IKRuFjFDWwCw/QeQIfwzypdQBhSZB
        c2vSgXnuvgiNAuDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 16/40] printk: __pr_flush: use srcu console list iterator
Date:   Wed, 16 Nov 2022 17:27:28 +0106
Message-Id: <20221116162152.193147-17-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3a7b1931b7c9..6666cc27a014 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3560,6 +3560,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
+	int cookie;
 	u64 diff;
 	u64 seq;
 
@@ -3570,9 +3571,15 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	for (;;) {
 		diff = 0;
 
+		/*
+		 * Hold the console_lock to guarantee safe access to
+		 * console->seq and to prevent changes to @console_suspended
+		 * until all consoles have been processed.
+		 */
 		console_lock();
 
-		for_each_console(c) {
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(c) {
 			if (con && con != c)
 				continue;
 			if (!console_is_usable(c))
@@ -3581,6 +3588,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
 		}
+		console_srcu_read_unlock(cookie);
 
 		/*
 		 * If consoles are suspended, it cannot be expected that they
-- 
2.30.2

