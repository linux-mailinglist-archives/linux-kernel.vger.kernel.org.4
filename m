Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975C95E867D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIXAFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiIXAFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F0A00FF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:04:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANY7oAkpA4R+I+XGrqgPZ6kGY4GmDX82gw1T7525iA0=;
        b=vWpBFONAv4/pzgToS4exU/1LlRMHRX/eFC/G8EjzVbk4qt7O55zPP8Io1MlY2o43xH3R8N
        D6Z50QOWAGoucWZdPtuo8K1AMuL5sZhlQAa/VMvKwxwhhgocUt+cago7hmr4f4rmGDcfzx
        jPP22HktWEsAa7bqYF544nzTaxufQIMMtKLBwgSPJFXjaCkg5TvsmEMGzbyrxRm7ypea5k
        7FtE69OsKSIYC2Xt0s95VVphm+cTW0p88tUtctnTKQU7pTDOoiU8ZuNAKxczekEn3C6mqp
        iXrV30l/xzsujtizv+b/6PV3ysTFoHNcas32lsriZcy/yfxGMsGuOH/x9j9u9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANY7oAkpA4R+I+XGrqgPZ6kGY4GmDX82gw1T7525iA0=;
        b=8RqLTYIcL6OsOGdep88T4tVlmPLozZRv2jX5XRRZ/CVZtYb+cnuIpqv0gwK5kuXSZ9Fzde
        pQLdpmU+n6wumFAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 03/18] printk: Remove write only variable nr_ext_console_drivers
Date:   Sat, 24 Sep 2022 02:10:39 +0206
Message-Id: <20220924000454.3319186-4-john.ogness@linutronix.de>
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

Commit a699449bb13b ("printk: refactor and rework printing logic")
removed the need for @nr_ext_console_drivers. Remove the unneeded
variable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/printk/printk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 14d7d39d118d..d6bba2ea14e8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -220,9 +220,6 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
 
-/* Number of registered extended console drivers. */
-static int nr_ext_console_drivers;
-
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -3188,9 +3185,6 @@ void register_console(struct console *newcon)
 		console_drivers->next = newcon;
 	}
 
-	if (newcon->flags & CON_EXTENDED)
-		nr_ext_console_drivers++;
-
 	newcon->dropped = 0;
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/* Get a consistent copy of @syslog_seq. */
@@ -3256,9 +3250,6 @@ int unregister_console(struct console *console)
 	if (res)
 		goto out_disable_unlock;
 
-	if (console->flags & CON_EXTENDED)
-		nr_ext_console_drivers--;
-
 	/*
 	 * If this isn't the last console and it has CON_CONSDEV set, we
 	 * need to set it on the next preferred console.
-- 
2.30.2

