Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013AB66228F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjAIKJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbjAIKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC3210B7F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:46 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673258925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+UJBfU/8l7fpxJzETJJj+Hr/lkYjP0wgmBYzutEocw=;
        b=o+xsj0DTLpnugqT9ezmLgLNWgnTCNkkIYxDcBf/DHJnSdw0TmM+P1+bM69x1RHK+N0fiSP
        gQc//PgyqQWgX+dSbAad/NlcvnNw7JF8lfwvQ//eVwuY2qJLyEiGlcQpOcpnsyd6BgeAsm
        /oJOn11Z2t5RoVgfzvL921AKPbPVScZXRWrvrBX15YClQlbqWhZ0NVSb3jMeCtcLt2+ClA
        vAzxezes34pH/f74KXeE7mkEjB8HY80eIQxGrqS4Z9TGIze+lw7zoz0nQvZOJbphhaoAle
        IvHVkjvM6tWi4CUkOvaK/TfXNkSjsJTZh9CWTVAw/vazsse+u7sXuJjExyU2HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673258925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+UJBfU/8l7fpxJzETJJj+Hr/lkYjP0wgmBYzutEocw=;
        b=yEh83H4SphijnQjwG181Gkplaik4ycqGsuEg2bxBiRVNkLT6PBi+TOsYLWto9F0TmYO3U1
        8iaIRJ7+CRup0pDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 3/8] console: Document struct console
Date:   Mon,  9 Jan 2023 11:13:55 +0106
Message-Id: <20230109100800.1085541-4-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Add kerneldoc comments to struct console.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 54 ++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index ed804dd7c2e8..1e36958aa656 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -164,24 +164,44 @@ enum cons_flags {
 	CON_EXTENDED		= BIT(6),
 };
 
+/**
+ * struct console - The console descriptor structure
+ * @name:		The name of the console driver
+ * @write:		Write callback to output messages (Optional)
+ * @read:		Read callback for console input (Optional)
+ * @device:		The underlying TTY device driver (Optional)
+ * @unblank:		Callback to unblank the console (Optional)
+ * @setup:		Callback for initializing the console (Optional)
+ * @exit:		Callback for teardown of the console (Optional)
+ * @match:		Callback for matching a console (Optional)
+ * @flags:		Console flags. See enum cons_flags
+ * @index:		Console index, e.g. port number
+ * @cflag:		TTY control mode flags
+ * @ispeed:		TTY input speed
+ * @ospeed:		TTY output speed
+ * @seq:		Sequence number of the next ringbuffer record to print
+ * @dropped:		Number of unreported dropped ringbuffer records
+ * @data:		Driver private data
+ * @node:		hlist node for the console list
+ */
 struct console {
-	char	name[16];
-	void	(*write)(struct console *, const char *, unsigned);
-	int	(*read)(struct console *, char *, unsigned);
-	struct tty_driver *(*device)(struct console *, int *);
-	void	(*unblank)(void);
-	int	(*setup)(struct console *, char *);
-	int	(*exit)(struct console *);
-	int	(*match)(struct console *, char *name, int idx, char *options);
-	short	flags;
-	short	index;
-	int	cflag;
-	uint	ispeed;
-	uint	ospeed;
-	u64	seq;
-	unsigned long dropped;
-	void	*data;
-	struct hlist_node node;
+	char			name[16];
+	void			(*write)(struct console *co, const char *s, unsigned int count);
+	int			(*read)(struct console *co, char *s, unsigned int count);
+	struct tty_driver	*(*device)(struct console *co, int *index);
+	void			(*unblank)(void);
+	int			(*setup)(struct console *co, char *options);
+	int			(*exit)(struct console *co);
+	int			(*match)(struct console *co, char *name, int idx, char *options);
+	short			flags;
+	short			index;
+	int			cflag;
+	uint			ispeed;
+	uint			ospeed;
+	u64			seq;
+	unsigned long		dropped;
+	void			*data;
+	struct hlist_node	node;
 };
 
 #ifdef CONFIG_LOCKDEP
-- 
2.30.2

