Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2566653796
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiLUU2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiLUU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:27:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4B2528D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:27:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671654456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+UJBfU/8l7fpxJzETJJj+Hr/lkYjP0wgmBYzutEocw=;
        b=r4PbESKXOL3kCggBPqyUPhgRbSc8To8Kef7clkha0yXtBADOKJ4tD7scZbSKGVRBtaoXd4
        9iSnQ5azRTbrzoFmgK+Gpl1KSp5MAF4YilrXzOnu1+plFbp9FomLdtXta+WoGhhlIBXtUH
        MSjANCfhHNIiEskP+/QcZ/tenk4pY/Hm+MUKz4qRmiYehn5EgESjgnHmwgQqgNwNo6z2gp
        abSKVQv+mN7XIWpnM+KTZtaRXsGk60QI6CaUvNbtL/FzOm2WnYlE5AmlAWTnXS71L70UUO
        z7VmfdUJpdcYg/Zps09xusOMghL84wlg/6kCrjKjIchVfNojbgztFKAv7TBO2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671654456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+UJBfU/8l7fpxJzETJJj+Hr/lkYjP0wgmBYzutEocw=;
        b=ZkyOoCL+G6d76XUi8UG/eVSRiG7d37JqkdZbW0drIhSv/9/8dX6I9yJfQG/ybG1q9r4SPF
        gNhMhrCfU1gIi9DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 3/6] console: Document struct console
Date:   Wed, 21 Dec 2022 21:33:01 +0106
Message-Id: <20221221202704.857925-4-john.ogness@linutronix.de>
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

