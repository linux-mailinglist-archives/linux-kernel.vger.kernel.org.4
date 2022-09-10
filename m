Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F25B4A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIJW1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIJW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353D3334D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:36 -0700 (PDT)
Message-ID: <20220910222300.406755505@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=90zm53gNGsnNrRXGITrlxBi4gXs52pVv+A6dByA1a7E=;
        b=LUm4KwKOHcvSdINElyUi1bpztxeBJog1m8l1KW0VZgfQSM8hL6o/6ktMkegvRNVms9H3wB
        0cNNrVHYiAd/C/p4shxFEO+9U8JOdCtEoeMGV8iRxCFrs5tOpX5meHtl9jvn+mP5L45oGR
        aISnt3GExDGxpW2pZPYY/lJdXcezftKo49UY0+ypQXJdxzhxIXlQ+nkuEk4CRr3y9MYC7A
        W0xLoVM7gCbXiAfNhv7vKDiDHeV8fcw75O3DW181504gYFVEeBjbv73lIG5wXZqi/GFISo
        SAzfqNG1kLqdI4VB1w8PrKW9/oVgvxrCzliJVuI0NzlO6HUWqKF9Dt8MpyMHAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=90zm53gNGsnNrRXGITrlxBi4gXs52pVv+A6dByA1a7E=;
        b=zJ4Y1gLCnVFMZG4UOQ73lwl7QCHFVYxY/eM7m9SFRoZ2gIfxrrGGY3GcXpp/53LDP+sFae
        W2MwGaeIevR/GsBg==
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
Subject: [patch RFC 01/29] printk: Make pr_flush() static
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:33 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No user outside the printk code and no reason to export this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/printk.h |    7 -------
 kernel/printk/printk.c |    5 +++--
 2 files changed, 3 insertions(+), 9 deletions(-)

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
@@ -221,11 +219,6 @@ static inline void printk_deferred_exit(
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
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2296,6 +2296,7 @@ asmlinkage __visible int _printk(const c
 }
 EXPORT_SYMBOL(_printk);
 
+static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2330,6 +2331,7 @@ static void call_console_driver(struct c
 {
 }
 static bool suppress_message_printing(int level) { return false; }
+static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -3438,11 +3440,10 @@ static bool __pr_flush(struct console *c
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

