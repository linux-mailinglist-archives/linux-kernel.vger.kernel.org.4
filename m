Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438B661F55C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiKGORz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiKGOQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A42C1D0E8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHu0DmQ8f1rgQbiyd2Suu9x07qh6zOdBEqqZ/26ftRk=;
        b=hGwj6gizl96NQKwR498k6uAl6XSNfXs5DgtmC5L8WU7gQWVMnV7NlRaPDbm+f6yjkhmslu
        QucFR7Y2mtVq5FQDr4sTthdt7CY0EmINf9SVUOxmemZNSxstqrHpUbc6G88hCPT21Yegbw
        eqg3pL91M6+PPtd1gM+QJUhLzSCTMEpbM2aJhVq6e1aoD+8XkEN/nxIGyiR1B32A6BlAV6
        m19ypo58YK7PSvx6wjWoCQiTVJgwBKEG3xfqcKheTXfurqjSDhZxeg3XVqGOZTLfPijIy1
        IOG5h4UQmGKMeBTZ1D2406gA5WuWTokF1Wsn3rGlck+/9hA/SyrLA4qUBFxMzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHu0DmQ8f1rgQbiyd2Suu9x07qh6zOdBEqqZ/26ftRk=;
        b=P9Gxvfan7DCC1ih4Knt2kaKzs4QeQhU+whuk/d07z5yqj/O+rOCCGJvNj0Wj3ZUD3GFgTP
        nGuJe2YaCbe55ACw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH printk v3 11/40] um: kmsg_dumper: use srcu console list iterator
Date:   Mon,  7 Nov 2022 15:22:09 +0106
Message-Id: <20221107141638.3790965-12-john.ogness@linutronix.de>
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

Rather than using the console_lock to guarantee safe console list
traversal, use srcu console list iteration.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/um/kernel/kmsg_dump.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index f0233e2f8de0..b6acb3837f1d 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -16,16 +16,15 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	struct console *con;
 	unsigned long flags;
 	size_t len = 0;
+	int cookie;
 
 	/*
 	 * If no consoles are available to output crash information, dump
 	 * the kmsg buffer to stdout.
 	 */
 
-	if (!console_trylock())
-		return;
-
-	for_each_console(con) {
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
 		/*
 		 * The ttynull console and disabled consoles are ignored
 		 * since they cannot output. All other consoles are
@@ -36,9 +35,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 			break;
 		}
 	}
-
-	console_unlock();
-
+	console_srcu_read_unlock(cookie);
 	if (con)
 		return;
 
-- 
2.30.2

