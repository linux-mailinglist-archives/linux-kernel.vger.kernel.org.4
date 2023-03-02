Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C756A89ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCBT6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCBT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A78E48E3C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:51 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pInHvcVDhlPvPce/Y/2kDlCM4xbrektXByOcawRj+0U=;
        b=h1FbnCMGHQDvQR5n7qJZizMYJFjX9il2feilw35+EzPvA/b1gvi3IxQZhoGDSqoMBfkAFC
        bcdmRZrczX/5lWhxyohoBiY5o8FEch1kiZht4hLoVSOFdv51lFEsyzcxkb4slBKtDyDtKR
        X3W8eSvKqfAFUcdpW/Labe6N7r83IPxdily+bPw7jLdYCgn6JXNaDRYyUxbS16gpd3kuPz
        OwrGiI/0vV/syNp/sQlbeWl9OU0RFDODOIPAKst6+L09Ctc5iOFCVPPcLtFeyCUIiMvXUA
        5UF6fxZILwMDXChTqqDICPzKk7wpwpcG3b8QHTDYzo3cO9lf/VPHRYot9H5QwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pInHvcVDhlPvPce/Y/2kDlCM4xbrektXByOcawRj+0U=;
        b=maOqQIw3FYXH1/cDnM8pH2rfYr5sExWFW5Ascwc4DyQUHDC3ZKkIMwpmoF5qNS7tzvuH3d
        7/dLoL+9MjTNiYCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 18/18] printk: Perform atomic flush in console_flush_on_panic()
Date:   Thu,  2 Mar 2023 21:02:18 +0106
Message-Id: <20230302195618.156940-19-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
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

Typically the panic() function will take care of atomic flushing the
non-BKL consoles on panic. However, there are several users of
console_flush_on_panic() outside of panic().

Also perform atomic flushing in console_flush_on_panic(). A new
function cons_force_seq() is implemented to support the
mode=CONSOLE_REPLAY_ALL feature.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h     |  2 ++
 kernel/printk/printk.c       | 28 ++++++++++++++++++++++------
 kernel/printk/printk_nobkl.c | 24 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a417e3992b7a..f147ca386afa 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -79,6 +79,7 @@ bool cons_nobkl_init(struct console *con);
 bool cons_alloc_percpu_data(struct console *con);
 void cons_kthread_create(struct console *con);
 void cons_wake_threads(void);
+void cons_force_seq(struct console *con, u64 seq);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -148,6 +149,7 @@ static inline void cons_kthread_create(struct console *con) { }
 static inline bool printk_percpu_data_ready(void) { return false; }
 static inline bool cons_nobkl_init(struct console *con) { return true; }
 static inline void cons_nobkl_cleanup(struct console *con) { }
+static inline void cons_force_seq(struct console *con, u64 seq) { }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 015c240f9f04..9a8ba8b3dca5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3160,6 +3160,28 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	struct console *c;
+	short flags;
+	int cookie;
+	u64 seq;
+
+	seq = prb_first_valid_seq(prb);
+
+	/*
+	 * Safely flush the atomic consoles before trying to flush any
+	 * BKL/legacy consoles.
+	 */
+	if (mode == CONSOLE_REPLAY_ALL) {
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(c) {
+			flags = console_srcu_read_flags(c);
+			if (flags & CON_NO_BKL)
+				cons_force_seq(c, seq);
+		}
+		console_srcu_read_unlock(cookie);
+	}
+	cons_atomic_flush(NULL, true);
+
 	if (!have_bkl_console)
 		return;
 
@@ -3174,12 +3196,6 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
-		struct console *c;
-		int cookie;
-		u64 seq;
-
-		seq = prb_first_valid_seq(prb);
-
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			/*
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 53989c8f1dbc..ac2ba785500e 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -233,6 +233,30 @@ static void cons_seq_init(struct console *con)
 #endif
 }
 
+/**
+ * cons_force_seq - Force a specified sequence number for a console
+ * @con:	Console to work on
+ * @seq:	Sequence number to force
+ *
+ * This function is only intended to be used in emergency situations. In
+ * particular: console_flush_on_panic(CONSOLE_REPLAY_ALL)
+ */
+void cons_force_seq(struct console *con, u64 seq)
+{
+#ifdef CONFIG_64BIT
+	struct cons_state old;
+	struct cons_state new;
+
+	do {
+		cons_state_read(con, CON_STATE_CUR, &old);
+		copy_bit_state(new, old);
+		new.seq = seq;
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new));
+#else
+	atomic_set(&ACCESS_PRIVATE(con, atomic_seq), seq);
+#endif
+}
+
 static inline u64 cons_expand_seq(u64 seq)
 {
 	u64 rbseq;
-- 
2.30.2

