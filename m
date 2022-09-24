Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3536B5E8680
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiIXAFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiIXAFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50704A00FF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFxBj/7Cwv+l8jbrElsJozenhe25KvbQeObQTTb9s44=;
        b=PtZbcifWrYlUJnCh/nYiLHegyU3pOQE2MzDRtKEPyugn+iUtdN+2p7gUFn3KBAXMnqUEcw
        DNgrwSVspJQ6PQZaIGIobyjWFoQZ/2D67xRIVYll6LrryVbWhD/L7FLz21J2NA3T2iN80F
        ADWD1shpEyJchkZX2zKKPa47vbJFVlGO4ntUvscBZc8y4QSrysIEMqwguJW72yyEkbQG9x
        ZyB6Bwtx6qmSBhFet5QMz+Wp43C2H9OW7qCsPDqnSylYuUH9AwQydTX/WJ7/JPommRXGdZ
        kjNpQ9mjgM/52KOf2hQkTF281W0uT5QcmTYHuQWyTYBpZWFlVuI0u1DFUoqX3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFxBj/7Cwv+l8jbrElsJozenhe25KvbQeObQTTb9s44=;
        b=jgRrlrJtt6YEu8bhuqsaWVwwoyDhFmY7chaNEhatxeXIUF8tw2Jxk30J0Z69TzMiDx09jO
        PC65BfeYfKkZMfCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk 13/18] printk: Move buffer size defines
Date:   Sat, 24 Sep 2022 02:10:49 +0206
Message-Id: <20220924000454.3319186-14-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
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

Move the buffer size defines to console.h in preparation of adding a buffer
structure.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 14 ++++++++++++++
 include/linux/printk.h  |  2 --
 kernel/printk/printk.c  |  8 --------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index dc0df9d9e7d9..3bb5bc62e154 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -122,6 +122,20 @@ static inline int con_debug_leave(void)
 #define CM_ERASE    (2)
 #define CM_MOVE     (3)
 
+#ifdef CONFIG_PRINTK
+/* The maximum size of a formatted record (i.e. with prefix added per line) */
+#define CONSOLE_LOG_MAX		1024
+
+/* The maximum size for a dropped text message */
+#define DROPPED_TEXT_MAX	64
+#else
+#define CONSOLE_LOG_MAX		0
+#define DROPPED_TEXT_MAX	0
+#endif
+
+/* The maximum size of an formatted extended record */
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
index 7e6d1cd34452..65e9903d066f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -433,12 +433,6 @@ static struct latched_seq clear_seq = {
 #define PREFIX_MAX		32
 #endif
 
-/* the maximum size of a formatted record (i.e. with prefix added per line) */
-#define CONSOLE_LOG_MAX		1024
-
-/* the maximum size for a dropped text message */
-#define DROPPED_TEXT_MAX	64
-
 /* the maximum size allowed to be reserved for a record */
 #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
@@ -2343,8 +2337,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 #else /* CONFIG_PRINTK */
 
-#define CONSOLE_LOG_MAX		0
-#define DROPPED_TEXT_MAX	0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
-- 
2.30.2

