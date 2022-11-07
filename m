Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0161F5B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiKGOTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiKGOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738F1D0DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HrXEQGG/m3o0hMbY11og/wMwGQrEN/gibAggQL0SPtA=;
        b=ZJIABBsSof8Zufabq1/Z2hKR4mPv7ugUtGQX7+O3byXTACBdSXeY81SZe1umutmD9nPJWt
        jM1rPfi7UDHWD/dtbCdpoKuBWs2IfwbtIoEDfFHhyO2QYZYvcOCY17sYycEx/GQ3PWDI17
        GAehm9J+D2mvy90cX6OAGzIirBwlyvByKnAcFJdugWkgH4UxwjjTE3T6nhkolWCu7aYYNS
        nQPXmxzvv6/lRPxu/NvsGzZstvo17s8gIChTWNc9Yz3jMdoJYSi97QOtNk682v9hxuZDME
        uiDb2XL4XQLRbnO5PYf+lQU1O9E2z5NY472LZkYcFDA8IHv0JJdlid1UhqdCpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HrXEQGG/m3o0hMbY11og/wMwGQrEN/gibAggQL0SPtA=;
        b=YNb5nb/11Kv8fmBiMLgjRDH4ietWRBzey9gsumdX/y4uojIWEDAls7EIUZ1H+k1cNIEXEp
        90sDo/rIBeMlVSBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 20/40] printk: __pr_flush: use srcu console list iterator
Date:   Mon,  7 Nov 2022 15:22:18 +0106
Message-Id: <20221107141638.3790965-21-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ec50777d0301..d8ccb7b523e2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3480,6 +3480,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
+	int cookie;
 	u64 diff;
 	u64 seq;
 
@@ -3490,9 +3491,15 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
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
@@ -3501,6 +3508,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
 		}
+		console_srcu_read_unlock(cookie);
 
 		/*
 		 * If consoles are suspended, it cannot be expected that they
-- 
2.30.2

