Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088EA604A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiJSPGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJSPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9676F1C2EB3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dEfLDywQMbLFMveMIU5ztmggdkM8VKhqRGZUba4knEA=;
        b=tvGWDuIbnMg81nElIpNQcHDQap243WbjOFmLBBssheT3WAcSo/uy+6Y/V1xLaZOuvbqvoP
        HGWUcc6muabTL3JhrtCL2O+nHHlD1uN8YVPQtxkig8QS8ESpv/V3WRMZA7Rxl4IIndi7hD
        szwUUd+8jDai9nm38yOHM416UH1skAKg+0nBI9frWXFXAUAQs4OkB5nXnBEBkEVbgTC1Rk
        qZ92WfVER0K26YNlgAgm71hLsBMCs+JmDbBTQmx0vFv52LhECZBDo3JbTp3eTUIpFu0dzy
        5cZYtV6xxBzm2eo129s+wAAZgFZr0dg9IA7FHp+XlWd3FtdHSpugj1GkLYE18g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dEfLDywQMbLFMveMIU5ztmggdkM8VKhqRGZUba4knEA=;
        b=zJjK8oc9MpyW+AN+CgjCFO34fO7H6UGzAb1JPwNkz17MJ2pO3wmfGFId0+ak7aOpZp8Q+5
        uWrTfF0L395aPXBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 32/38] printk: __pr_flush: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:54 +0206
Message-Id: <20221019145600.1282823-33-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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

Use srcu console list iteration for console list traversal.

Document why the console_lock is still necessary.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 809c43e596d8..2faa6e3e2fb8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3454,6 +3454,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
+	int cookie;
 	u64 diff;
 	u64 seq;
 
@@ -3464,9 +3465,15 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	for (;;) {
 		diff = 0;
 
+		/*
+		 * Hold the console_lock to guarantee safe access to
+		 * console->seq and to prevent changes to @console_suspended
+		 * until all consoles have been processed.
+		 */
 		console_lock();
 
-		for_each_console(c) {
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(c) {
 			if (con && con != c)
 				continue;
 			if (!console_is_usable(c))
@@ -3475,6 +3482,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
 		}
+		console_srcu_read_unlock(cookie);
 
 		/*
 		 * If consoles are suspended, it cannot be expected that they
-- 
2.30.2

