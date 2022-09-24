Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F095E8672
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiIXAFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiIXAFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687019E8A8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:04:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiH+o7JC41DdZ3lwu3cXiKJzKZkxqWA+Jud7hMuF9gA=;
        b=pFGs3MumAKqyjmH+l1KzRd31GIN3NwCRBmrL4IK+kkJfFIF3HGbKRcU6x17/ER90jiOvmH
        9kbSmpJWvDW6LWdcaNMJEwAd881GJuKf/kESYfjvpEv6emMTrG8bM/F0R9LYdqT10oOaX0
        a+64EYlYfeyyEM++gUgiN0xZTaSmNPeB1A4VJUuN6CWrstq1srFzFcMbWkbGuEOrxX/4AQ
        ARAh+pBSMzjD1W3Y6kW6wVZmzEnO4zHxYyWJ+l/OTu97IoTMFO7zv9JEVi4z2Qr5aXbqu3
        2Pd/N3hFPbM/L3vebmOdOmBXTQGceB6J2vUnCfzhXKk+d2fUQxZ3l1XbL9GShg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiH+o7JC41DdZ3lwu3cXiKJzKZkxqWA+Jud7hMuF9gA=;
        b=iXszll3pfPqc1GP/P+hO0F9vQwXwpSBQjOIr2P6fq43Fe4y0cIetm3OL3IIU9NvjIPXeUI
        Lhpp1/LVHRpl2uCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 01/18] printk: Make pr_flush() static
Date:   Sat, 24 Sep 2022 02:10:37 +0206
Message-Id: <20220924000454.3319186-2-john.ogness@linutronix.de>
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

No user outside the printk code and no reason to export this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/printk.h | 7 -------
 kernel/printk/printk.c | 5 +++--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf7d666ab1f8..8c81806c2e99 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -169,8 +169,6 @@ extern void __printk_safe_exit(void);
 #define printk_deferred_enter __printk_safe_enter
 #define printk_deferred_exit __printk_safe_exit
 
-extern bool pr_flush(int timeout_ms, bool reset_on_progress);
-
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
  * with all other unrelated printk_ratelimit() callsites.  Instead use
@@ -221,11 +219,6 @@ static inline void printk_deferred_exit(void)
 {
 }
 
-static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
-{
-	return true;
-}
-
 static inline int printk_ratelimit(void)
 {
 	return 0;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a1a81fd9889b..14d7d39d118d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2296,6 +2296,7 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
+static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2330,6 +2331,7 @@ static void call_console_driver(struct console *con, const char *text, size_t le
 {
 }
 static bool suppress_message_printing(int level) { return false; }
+static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -3438,11 +3440,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all enabled printers are caught up.
  */
-bool pr_flush(int timeout_ms, bool reset_on_progress)
+static bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
-EXPORT_SYMBOL(pr_flush);
 
 /*
  * Delayed printk version, for scheduler-internal messages:
-- 
2.30.2

