Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206C66228D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjAIKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbjAIKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C9BDF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:49 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673258927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Be9tRmuwGMWyEdusml6s/K1qdWm2ngTw+Ga411aox2M=;
        b=pZzVouh4ELzKMgwSHhPeMKTj3YCtRyYqBKOwZJZ5FUOjcbZUjYMDCdxEjfpWTzrPxhKMrF
        mqvJDj/M21N460cwCkmHj4PAsy7Nzd4eS5PFPhk8U40nQk8I/o7afniOxL27LW1iE/r8cO
        9e3uuOln65Uf8q5bc6lSO38piC8y5tH51Cvu5bpfFHDerEJTzjUGQqeLK8F3a2wmuFC4Ud
        nImGEodfoizoL/9OOAJ2bg+CK3Srhva0onvfeg7SqoKB5oP2hehWzZkLp5dywiAa2Dzxcc
        hq0N4a083V58JUEHwgnLJ8BT+zg2EYXx7z0K+z3TkROF0J30wmYa/N53IroFSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673258927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Be9tRmuwGMWyEdusml6s/K1qdWm2ngTw+Ga411aox2M=;
        b=4E/OKkerVIvdINGIf9yPD//fehJOAQq35kb9jeQ1ftC4xVNQVRtEADdiLevYaTWMOoWXSE
        NQG+/LKc9PVRYSDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 8/8] printk: adjust string limit macros
Date:   Mon,  9 Jan 2023 11:14:00 +0106
Message-Id: <20230109100800.1085541-9-john.ogness@linutronix.de>
In-Reply-To: <20230109100800.1085541-1-john.ogness@linutronix.de>
References: <20230109100800.1085541-1-john.ogness@linutronix.de>
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

The various internal size limit macros have names and/or values that
do not fit well to their current usage.

Rename the macros so that their purpose is clear and, if needed,
provide a more appropriate value. In general, the new macros and
values will lead to less memory usage. The new macros are...

PRINTK_MESSAGE_MAX:

This is the maximum size for a formatted message on a console,
devkmsg, or syslog. It does not matter which format the message has
(normal or extended). It replaces the use of CONSOLE_EXT_LOG_MAX for
console and devkmsg. It replaces the use of CONSOLE_LOG_MAX for
syslog.

Historically, normal messages have been allowed to print up to 1kB,
whereas extended messages have been allowed to print up to 8kB.
However, the difference in lengths of these message types is not
significant and in multi-line records, normal messages are probably
larger. Also, because 1kB is only slightly above the allowed record
size, multi-line normal messages could be easily truncated during
formatting.

This new macro should be significantly larger than the allowed
record size to allow sufficient space for extended or multi-line
prefix text. A value of 2kB should be plenty of space. For normal
messages this represents a doubling of the historically allowed
amount. For extended messages it reduces the excessive 8kB size,
thus reducing memory usage needed for message formatting.

PRINTK_PREFIX_MAX:

This is the maximum size allowed for a record prefix (used by
console and syslog). It replaces PREFIX_MAX. The value is left
unchanged.

PRINTKRB_RECORD_MAX:

This is the maximum size allowed to be reserved for a record in the
ringbuffer. It is used by all readers and writers with the printk
ringbuffer. It replaces LOG_LINE_MAX.

Previously this was set to "1kB - PREFIX_MAX", which makes some
sense if 1kB is the limit for normal message output and prefixes are
enabled. However, with the allowance of larger output and the
existence of multi-line records, the value is rather bizarre.

Round the value up to 1kB.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 27 +++++++++++++--------------
 kernel/printk/printk.c   | 24 ++++++++++++------------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 72df730597f1..2a17704136f1 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -15,19 +15,19 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 #ifdef CONFIG_PRINTK
 
 #ifdef CONFIG_PRINTK_CALLER
-#define PREFIX_MAX		48
+#define PRINTK_PREFIX_MAX	48
 #else
-#define PREFIX_MAX		32
+#define PRINTK_PREFIX_MAX	32
 #endif
 
-/* the maximum size of a formatted record (i.e. with prefix added per line) */
-#define CONSOLE_LOG_MAX		1024
-
-/* the maximum size of a formatted extended record */
-#define CONSOLE_EXT_LOG_MAX	8192
+/*
+ * the maximum size of a formatted record (i.e. with prefix added
+ * per line and dropped messages or in extended message format)
+ */
+#define PRINTK_MESSAGE_MAX	2048
 
 /* the maximum size allowed to be reserved for a record */
-#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
+#define PRINTKRB_RECORD_MAX	1024
 
 /* Flags for a single printk record. */
 enum printk_info_flags {
@@ -63,10 +63,9 @@ u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 #else
 
-#define PREFIX_MAX		0
-#define CONSOLE_LOG_MAX		0
-#define CONSOLE_EXT_LOG_MAX	0
-#define LOG_LINE_MAX		0
+#define PRINTK_PREFIX_MAX	0
+#define PRINTK_MESSAGE_MAX	0
+#define PRINTKRB_RECORD_MAX	0
 
 /*
  * In !PRINTK builds we still export console_sem
@@ -85,8 +84,8 @@ static inline bool printk_percpu_data_ready(void) { return false; }
  * @scratchbuf:	Used as temporary ringbuffer reading and string-print space.
  */
 struct printk_buffers {
-	char	outbuf[CONSOLE_EXT_LOG_MAX];
-	char	scratchbuf[LOG_LINE_MAX];
+	char	outbuf[PRINTK_MESSAGE_MAX];
+	char	scratchbuf[PRINTKRB_RECORD_MAX];
 };
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a72904890a5f..55338bfd3b55 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -729,7 +729,7 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 	size_t len = iov_iter_count(from);
 	ssize_t ret = len;
 
-	if (!user || len > LOG_LINE_MAX)
+	if (!user || len > PRINTKRB_RECORD_MAX)
 		return -EINVAL;
 
 	/* Ignore when user logging is disabled. */
@@ -1127,7 +1127,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	return prb_record_text_space(&e);
 }
 
-static char setup_text_buf[LOG_LINE_MAX] __initdata;
+static char setup_text_buf[PRINTKRB_RECORD_MAX] __initdata;
 
 void __init setup_log_buf(int early)
 {
@@ -1393,7 +1393,7 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
 	size_t text_len = r->info->text_len;
 	size_t buf_size = r->text_buf_size;
 	char *text = r->text_buf;
-	char prefix[PREFIX_MAX];
+	char prefix[PRINTK_PREFIX_MAX];
 	bool truncated = false;
 	size_t prefix_len;
 	size_t line_len;
@@ -1492,7 +1492,7 @@ static size_t get_record_print_text_size(struct printk_info *info,
 					 unsigned int line_count,
 					 bool syslog, bool time)
 {
-	char prefix[PREFIX_MAX];
+	char prefix[PRINTK_PREFIX_MAX];
 	size_t prefix_len;
 
 	prefix_len = info_print_prefix(info, syslog, time, prefix);
@@ -1558,11 +1558,11 @@ static int syslog_print(char __user *buf, int size)
 	int len = 0;
 	u64 seq;
 
-	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
+	text = kmalloc(PRINTK_MESSAGE_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
-	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
+	prb_rec_init_rd(&r, &info, text, PRINTK_MESSAGE_MAX);
 
 	mutex_lock(&syslog_lock);
 
@@ -1663,7 +1663,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 seq;
 	bool time;
 
-	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
+	text = kmalloc(PRINTK_MESSAGE_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
@@ -1675,7 +1675,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	seq = find_first_fitting_seq(latched_seq_read_nolock(&clear_seq), -1,
 				     size, true, time);
 
-	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
+	prb_rec_init_rd(&r, &info, text, PRINTK_MESSAGE_MAX);
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
@@ -2198,8 +2198,8 @@ int vprintk_store(int facility, int level,
 	reserve_size = vsnprintf(&prefix_buf[0], sizeof(prefix_buf), fmt, args2) + 1;
 	va_end(args2);
 
-	if (reserve_size > LOG_LINE_MAX)
-		reserve_size = LOG_LINE_MAX;
+	if (reserve_size > PRINTKRB_RECORD_MAX)
+		reserve_size = PRINTKRB_RECORD_MAX;
 
 	/* Extract log level or control flags. */
 	if (facility == 0)
@@ -2213,7 +2213,7 @@ int vprintk_store(int facility, int level,
 
 	if (flags & LOG_CONT) {
 		prb_rec_init_wr(&r, reserve_size);
-		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
+		if (prb_reserve_in_last(&e, prb, &r, caller_id, PRINTKRB_RECORD_MAX)) {
 			text_len = printk_sprint(&r.text_buf[r.info->text_len], reserve_size,
 						 facility, &flags, fmt, args);
 			r.info->text_len += text_len;
@@ -2725,7 +2725,7 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
 	 * It is a rather theoretical problem when someone tries to
 	 * use a minimalist buffer.
 	 */
-	if (WARN_ON_ONCE(len + PREFIX_MAX >= outbuf_sz))
+	if (WARN_ON_ONCE(len + PRINTK_PREFIX_MAX >= outbuf_sz))
 		return;
 
 	if (pmsg->outbuf_len + len >= outbuf_sz) {
-- 
2.30.2

