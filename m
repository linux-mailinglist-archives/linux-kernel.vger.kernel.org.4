Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060705B4A88
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIJW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiIJW2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E74362D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:55 -0700 (PDT)
Message-ID: <20220910222301.141696132@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ucJCwIArz/Obdz0no/ZggjeV/meklOatxzaddZBmlzw=;
        b=Z+lN6QD2lalfKWyMMeV80c6lroOwf0YpggJVEVXBFRkop3lUHQNNQMPFQWidfh6xAdukWy
        BwW3sj9r0bPhXA095G3tuR1gKLsJWp8P3F21XmAAAdTJ+84z7C7Sc+sh313TLXDHyZfQL2
        ekpwKrHqIN8O5kgmp6Fb9a8NZ1ibwCLD2/yDO5V7WS6EBJi2/ZYko/weq1+ozgKCweXHOT
        ImX2Bp96HLxU2OvIXEJISkpJu+N2fbt+IfXOPiMEYEKfb0RSJzUvET593kZjh9GGS8vIit
        JR+rONc0gnJINRl8IvzHikMafhfqSfhtiGlj91Mf5AKce/H6hJ3V6uXxKYpxRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ucJCwIArz/Obdz0no/ZggjeV/meklOatxzaddZBmlzw=;
        b=uYSC3ZXu9l3Q0SYJXNB43seqCZIqWAwtL2eEHo4sVg9eKHX9S3rHW6oR9jb7jGloW7A3NE
        T0hbmxLva2VDv5Dg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 13/29] printk: Move buffer size defines
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:52 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the buffer size defines to console.h in preperation of adding a buffer
structure.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |   14 ++++++++++++++
 include/linux/printk.h  |    2 --
 kernel/printk/printk.c  |    8 --------
 3 files changed, 14 insertions(+), 10 deletions(-)

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
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -44,8 +44,6 @@ static inline const char *printk_skip_he
 	return buffer;
 }
 
-#define CONSOLE_EXT_LOG_MAX	8192
-
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
 
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -428,12 +428,6 @@ static struct latched_seq clear_seq = {
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
 
@@ -2338,8 +2332,6 @@ static bool __pr_flush(struct console *c
 
 #else /* CONFIG_PRINTK */
 
-#define CONSOLE_LOG_MAX		0
-#define DROPPED_TEXT_MAX	0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false

