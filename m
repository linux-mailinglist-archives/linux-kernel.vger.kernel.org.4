Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC475E8686
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiIXAGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiIXAFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A97DB02B9;
        Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmQTrIsrazpPIyD8N/ImSAVVwbH1mqHErna9k27Vvaw=;
        b=e0HL7iVSFrWDEyWd93pKTysu+f2PtjV3UFX2E17ouIqnFgtgYHj2JwYv2DJpGHFeLeQ3ld
        MCM414BiK2Y3yDjf149S6h7A2iKBukElbmL8Fx+8e0sPzdpxSUabOQYTK4KjD2bSusFYnP
        //N/XuNoVWXLv6GGGBV6UOQkBD+XfX0rptum628w3mUuvC8YGt0WaymrGmYMZDiBqax5Me
        Rggwzu8njK/aSMcmvP10yWtRrHV4bUJBQdZnWnzqiXp9tAjhEgNDoHxBmN+uFi/uXa+Mos
        JdYY7EdmpHm6MrGtdgVzyLDiJyHObnss252/czGO/8zUHjIBcIgYIQW0F8EU1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmQTrIsrazpPIyD8N/ImSAVVwbH1mqHErna9k27Vvaw=;
        b=b9MI9BO/qiKg/DT4XFHp9Pb+3i4omPO4qdqEr0ElztkwrozUgg0NcEq8KTBgK/v0k0uPW1
        l2r6ueyffq6bMOAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: [PATCH printk 10/18] kgbd: Pretend that console list walk is safe
Date:   Sat, 24 Sep 2022 02:10:46 +0206
Message-Id: <20220924000454.3319186-11-john.ogness@linutronix.de>
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

Provide a special list iterator macro for KGDB to allow unprotected list
walks and add a few comments to explain the hope based approach.

Preperatory change for changing the console list to hlist and adding
lockdep asserts to regular list walks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/tty/serial/kgdboc.c |  5 ++++-
 include/linux/console.h     | 10 ++++++++++
 kernel/debug/kdb/kdb_io.c   |  7 ++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index af2aa76bae15..57a5fd27dffe 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -462,10 +462,13 @@ static void kgdboc_earlycon_pre_exp_handler(void)
 	 * we have no other choice so we keep using it.  Since not all
 	 * serial drivers might be OK with this, print a warning once per
 	 * boot if we detect this case.
+	 *
+	 * Pretend that walking the console list is safe...
 	 */
-	for_each_console(con)
+	for_each_console_kgdb(con) {
 		if (con == kgdboc_earlycon_io_ops.cons)
 			return;
+	}
 
 	already_warned = true;
 	pr_warn("kgdboc_earlycon is still using bootconsole\n");
diff --git a/include/linux/console.h b/include/linux/console.h
index 24344f9b0bc1..86a6125512b9 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -187,6 +187,16 @@ extern void console_list_unlock(void) __releases(console_mutex);
 #define for_each_console(con)						\
 	for (con = console_drivers; con != NULL; con = con->next)
 
+/**
+ * for_each_console_kgdb() - Iterator over registered consoles for KGDB
+ * @con:	struct console pointer used as loop cursor
+ *
+ * Has no serialization requirements and KGDB pretends that this is safe.
+ * Don't use outside of the KGDB fairy tale land!
+ */
+#define for_each_console_kgdb(con)					\
+	for (con = console_drivers; con != NULL; con = con->next)
+
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 67d3c48a1522..fb3775e61a3b 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -558,7 +558,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		cp++;
 	}
 
-	for_each_console(c) {
+	/*
+	 * This is a completely unprotected list walk designed by the
+	 * wishful thinking department. See the oops_in_progress comment
+	 * below - especially the encourage section...
+	 */
+	for_each_console_kgdb(c) {
 		if (!(c->flags & CON_ENABLED))
 			continue;
 		if (c == dbg_io_ops->cons)
-- 
2.30.2

