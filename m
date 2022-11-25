Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7324663902A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKYTKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiKYTKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:10:14 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE920554E9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 11:10:12 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669403409;
        bh=Cfs+sOQDL6GBgQ3fenqAT1FujV3he1f3Lpmpy6WNGIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdjwjO5hHtwgwX90USoA3/oYV6gNtrbEg2T9br83TK4zdDJz6VEWprrsMkCEyvepp
         PUB2jhZPZu/9ERMHp8awa/NpE4O55WPPfRNpkBArX3qyjoKkMYY6qFKJ6AYFFZNbTp
         LoHFvTGLPJslEBlrSWMXLfJZLDQva+Kk9Vuypl2s=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 1/3] printk: introduce new macros pr_<level>_cont()
Date:   Fri, 25 Nov 2022 20:09:46 +0100
Message-Id: <20221125190948.2062-2-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125190948.2062-1-linux@weissschuh.net>
References: <20221125190948.2062-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669403373; l=2153; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=Cfs+sOQDL6GBgQ3fenqAT1FujV3he1f3Lpmpy6WNGIY=; b=HrAjdosSOqn753OZecTREHBNiVZHFXNRlI3g1j+9iLw4cn/f064kUy61f5eptIvvv5OiNU3b0iWm VqdxqwJmBCtf2AP3qCG9Gek6WHudS6izrr6XXVq30kQbg1PoiGz4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros emit continuation messages with explicit levels.
In case the continuation is logged separately from the original message
it will retain its level instead of falling back to KERN_DEFAULT.

This remedies the issue that logs filtered by level contain stray
continuation messages without context.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/printk.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8c81806c2e99..8f564c38f121 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -537,6 +537,8 @@ struct pi_entry {
  * This macro expands to a printk with KERN_CONT loglevel. It should only be
  * used when continuing a log message with no newline ('\n') enclosed. Otherwise
  * it defaults back to KERN_DEFAULT loglevel.
+ *
+ * Use the dedicated pr_<level>_cont() macros instead.
  */
 #define pr_cont(fmt, ...) \
 	printk(KERN_CONT fmt, ##__VA_ARGS__)
@@ -701,6 +703,27 @@ do {									\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
+/*
+ * Print a continuation message with level. In case the continuation is split
+ * from the main message it preserves the level.
+ */
+
+#define pr_emerg_cont(fmt, ...)					\
+	printk(KERN_EMERG KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_alert_cont(fmt, ...)					\
+	printk(KERN_ALERT KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_crit_cont(fmt, ...)					\
+	printk(KERN_CRIT KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_err_cont(fmt, ...)					\
+	printk(KERN_ERR KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_warn_cont(fmt, ...)					\
+	printk(KERN_WARN KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_notice_cont(fmt, ...)					\
+	printk(KERN_NOTICE KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_info_cont(fmt, ...)					\
+	printk(KERN_INFO KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+/* no pr_debug_ratelimited, it doesn't make sense with CONFIG_DYNAMIC_DEBUG. */
+
 extern const struct file_operations kmsg_fops;
 
 enum {
-- 
2.38.1

