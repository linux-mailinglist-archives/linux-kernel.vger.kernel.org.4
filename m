Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF776628552
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiKNQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbiKNQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476E1CB07
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:42 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNqL8lThA4YIywGDMJUU+3tDmR/wiL7uckrDiJUm3Yc=;
        b=4P34KEWdum5Ad8J25GcIpklGjPLZyfP61f2N+FJq/EjuBLOCGQ402uYOuCvoGbXhkJRKlw
        TAFpdgqASC2/Qdr7QkpAThBldBcPuWfFfy5BtsG45GN3AISccx9ynbRBWAGkTSTgUcFfLP
        eLu1zs+FP/0ktSIiFPbtmQnqSC3lnyfQ0HrXy03qxk0YTMMqBhSxaXLyv4uc3dWa21Ln7t
        Wz4JMJAQcWlDqGjr0NBiQWWSiGOX4WyU9l/ySqaJpdS960EPrw/MOxErMLy0Co1qG++59U
        fTuggTBbCuSKexyxD578FCD/vn9pCaF5Qttt8ZjvuQ5uKVEPwa2YZRxbVtPSbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNqL8lThA4YIywGDMJUU+3tDmR/wiL7uckrDiJUm3Yc=;
        b=NtJVSn5Mg5MJsfN6WJJF9AlssUQDo7vZxv3r93RxJ++DnBUK7rFjhIZE4JTLWwLHlvVAzC
        epjYOkxx+Piio4Bg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 15/39] printk: __pr_flush: use srcu console list iterator
Date:   Mon, 14 Nov 2022 17:35:08 +0106
Message-Id: <20221114162932.141883-16-john.ogness@linutronix.de>
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
index b37ca16abbd0..3d9e5bb1a50b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3532,6 +3532,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
+	int cookie;
 	u64 diff;
 	u64 seq;
 
@@ -3542,9 +3543,15 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
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
@@ -3553,6 +3560,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
 		}
+		console_srcu_read_unlock(cookie);
 
 		/*
 		 * If consoles are suspended, it cannot be expected that they
-- 
2.30.2

