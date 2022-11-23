Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186BF636E35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKWXOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKWXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:14:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB49B3B0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:14:12 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669245250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iaK6Q3VBEVIk95GUMPiu3drrm6jETQodWaJtL9sezc=;
        b=RPvCHbzeTnVF+1dfTWNpp1u2Ja4oUusnLtx0+NH6sMCxYoOR02JlqMlu3LV9oTETqz4j9n
        t9Wc/t26f4+a2isGNtBY6ZtXYv9rwvZifPRr+uPZTZ/t7tdUF6eIBaLN6S51VLoT14la88
        0LplEnL7XKetw/yLNGMg2E5S/M+D2wzXpJucFLxf2w5ma2O2O2DcP1j+NpSWc7I4+q8TXJ
        NXs2eeNoeJnOYk23Gj56igQeMgwz4zJlv9LW5qk33hmFyG18sYzE0NYjS+/w1X13Z3SWZ4
        76uWOnvJA2OcNSdqvW1ig1eiOkLmFlIHsEm2ym5SwmtL1R9J+L5cMliwc7i19A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669245250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iaK6Q3VBEVIk95GUMPiu3drrm6jETQodWaJtL9sezc=;
        b=69B7EmoOEwgiqYg29s+3eHdc8AjiAjVWVTXwWTObH4kfEJ8gT1qdFR7VycoxkUJPky/uGu
        ADMt+2TjjCRTz7DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 1/7] printk: Move buffer size defines
Date:   Thu, 24 Nov 2022 00:19:54 +0106
Message-Id: <20221123231400.614679-2-john.ogness@linutronix.de>
In-Reply-To: <20221123231400.614679-1-john.ogness@linutronix.de>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Move the buffer size defines to console.h in preparation of adding a
buffer structure. The new buffer structure will be embedded within
struct console. Therefore console.h was chosen as the new home for
these defines.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 14 ++++++++++++++
 include/linux/printk.h  |  2 --
 kernel/printk/printk.c  |  4 ----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 9cea254b34b8..799fc3216aad 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -122,6 +122,20 @@ static inline int con_debug_leave(void)
 #define CM_ERASE    (2)
 #define CM_MOVE     (3)
 
+#ifdef CONFIG_PRINTK
+
+/* The maximum size of a formatted record (i.e. with prefix added per line) */
+#define CONSOLE_LOG_MAX		1024
+
+#else
+
+#define CONSOLE_LOG_MAX		0
+
+#endif
+
+/* The maximum size of a formatted extended record */
+#define CONSOLE_EXT_LOG_MAX	8192
+
 /*
  * The interface for a console, or any other device that wants to capture
  * console messages (printer driver?)
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8c81806c2e99..8ef499ab3c1e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -44,8 +44,6 @@ static inline const char *printk_skip_headers(const char *buffer)
 	return buffer;
 }
 
-#define CONSOLE_EXT_LOG_MAX	8192
-
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9ec101766471..a4854a60e6d8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -471,9 +471,6 @@ static struct latched_seq clear_seq = {
 #define PREFIX_MAX		32
 #endif
 
-/* the maximum size of a formatted record (i.e. with prefix added per line) */
-#define CONSOLE_LOG_MAX		1024
-
 /* the maximum size for a dropped text message */
 #define DROPPED_TEXT_MAX	64
 
@@ -2387,7 +2384,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 #else /* CONFIG_PRINTK */
 
-#define CONSOLE_LOG_MAX		0
 #define DROPPED_TEXT_MAX	0
 #define printk_time		false
 
-- 
2.30.2

