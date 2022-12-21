Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74793653795
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiLUU2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiLUU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:27:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D325289
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:27:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671654455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5G3xENZmVjolt+mUZuerb1/7WYIT6u0len7EJM2bSQA=;
        b=PJDN6GMTUudEE4qCop+B0eSpJDhKhQpAwrDfuQ7CAdnJ8bRbftzotDPi1II7gSqXlkiuZI
        AyYuW1usB0J22wee3c4MIc0D7CrT1La9p8YiNY6tlXne+AAn+OHqevKOers3PbFsH0Gc4j
        FlgPgQfQ1nJcvSond6Jk17MtoUFVlDlNV86myfWgvqPVKoYjuKIyqmFVZOxjYcwFS7XDw6
        l0LCRsYQsnUQAnVn6j09Dx0r0u3u8ocYVAuMut7oC33OpJ94Nq3EkDkR74A36QBAVHCWwe
        q+QPalrXKwY9w4YVP1n29sktkfd/0WhBc7bdKPdB65plr/Ol2A1FG/XZqHsCCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671654455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5G3xENZmVjolt+mUZuerb1/7WYIT6u0len7EJM2bSQA=;
        b=IV6hMJkJVKuax53a8g6jMlIV8CTvhwCQdY1HyhB+Vdd3NKl1lTQJcwl5H/y1jYHLkvnDNE
        wTjUD44Fv2oPpRBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 1/6] printk: move size limit macros into internal.h
Date:   Wed, 21 Dec 2022 21:32:59 +0106
Message-Id: <20221221202704.857925-2-john.ogness@linutronix.de>
In-Reply-To: <20221221202704.857925-1-john.ogness@linutronix.de>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
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

The size limit macros are located further down in printk.c and
behind ifdef macros. This complicates their usage for upcoming
changes. Move the macros into internal.h so that they are still
invisible outside of printk, but easily accessible for printk.

Also, the maximum size of formatted extended messages does not
need to be known by any code outside of printk, so move it to
internal.h as well. And like CONSOLE_LOG_MAX, for !CONFIG_PRINTK
set CONSOLE_EXT_LOG_MAX to 0 to reduce the static memory
footprint.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h   |  2 --
 kernel/printk/internal.h | 23 +++++++++++++++++++++++
 kernel/printk/printk.c   | 17 -----------------
 3 files changed, 23 insertions(+), 19 deletions(-)

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
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index d947ca6c84f9..319bc7ee46f7 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -14,6 +14,24 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 
 #ifdef CONFIG_PRINTK
 
+#ifdef CONFIG_PRINTK_CALLER
+#define PREFIX_MAX		48
+#else
+#define PREFIX_MAX		32
+#endif
+
+/* the maximum size of a formatted record (i.e. with prefix added per line) */
+#define CONSOLE_LOG_MAX		1024
+
+/* the maximum size of a formatted extended record */
+#define CONSOLE_EXT_LOG_MAX	8192
+
+/* the maximum size for a dropped text message */
+#define DROPPED_TEXT_MAX	64
+
+/* the maximum size allowed to be reserved for a record */
+#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
+
 /* Flags for a single printk record. */
 enum printk_info_flags {
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
@@ -48,6 +66,11 @@ u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 #else
 
+#define CONSOLE_LOG_MAX		0
+#define CONSOLE_EXT_LOG_MAX	0
+#define DROPPED_TEXT_MAX	0
+#define LOG_LINE_MAX		0
+
 /*
  * In !PRINTK builds we still export console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7decf1e9c486..55bb065de65f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -465,21 +465,6 @@ static struct latched_seq clear_seq = {
 	.val[1]		= 0,
 };
 
-#ifdef CONFIG_PRINTK_CALLER
-#define PREFIX_MAX		48
-#else
-#define PREFIX_MAX		32
-#endif
-
-/* the maximum size of a formatted record (i.e. with prefix added per line) */
-#define CONSOLE_LOG_MAX		1024
-
-/* the maximum size for a dropped text message */
-#define DROPPED_TEXT_MAX	64
-
-/* the maximum size allowed to be reserved for a record */
-#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
-
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
 
@@ -2387,8 +2372,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 #else /* CONFIG_PRINTK */
 
-#define CONSOLE_LOG_MAX		0
-#define DROPPED_TEXT_MAX	0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
-- 
2.30.2

