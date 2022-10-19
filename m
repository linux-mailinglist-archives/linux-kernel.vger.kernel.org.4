Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A5604A68
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJSPEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiJSPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6A1911C2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:58:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP5rgFSdehBCliWVe71JQUPCb1f669tU8saiCWaIDO0=;
        b=SLqa5PhcnifAXBxPjzPq8RQ5wWHDsFsKLOjJ5Bmh9ZGDeMItqEb2c5andZCY9TcUyGDIR/
        dkOOQxmdmn7/PnLwAAjrGDp8lt9Uz8mAMEoOd7urbGXYVldEk8zYCa8/iAY1dVNRfX1p+J
        Ha+qK8DetElb0MoGktri3Xu4lx9C3kUh6AtB+1DIReSvn7JRz1gWJTFDzw08nHyTiCmChQ
        XP4mRnKpUirH0pvAQWYC+E4LgSbE3mXbcssJIvwElnPgdqtXfCvaf4dvjVy2e7JmBlnloB
        h/m+zkpsEomfdmsy9Cb/TNtCQcjleQpQn0jWgpkY1m6W6keiAq6wL/v4NRO/PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP5rgFSdehBCliWVe71JQUPCb1f669tU8saiCWaIDO0=;
        b=ozZhE1jNVxKFfb0xYXFWRlrgrguzkQU0rcQ9xxPUoqXcDFSb1uLSsqks/WR9QsIUMSaQe8
        g5NlOPi7VRafb3CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 05/38] printk: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:27 +0206
Message-Id: <20221019145600.1282823-6-john.ogness@linutronix.de>
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e8a56056cd50..7ff2fc75fc3b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2658,7 +2658,7 @@ static bool abandon_console_lock_in_panic(void)
  */
 static inline bool console_is_usable(struct console *con)
 {
-	if (!(con->flags & CON_ENABLED))
+	if (!console_is_enabled(con))
 		return false;
 
 	if (!con->write)
@@ -2944,7 +2944,7 @@ void console_unblank(void)
 	console_locked = 1;
 	console_may_schedule = 0;
 	for_each_console(c)
-		if ((c->flags & CON_ENABLED) && c->unblank)
+		if (console_is_enabled(c) && c->unblank)
 			c->unblank();
 	console_unlock();
 
@@ -3098,7 +3098,7 @@ static int try_enable_preferred_console(struct console *newcon,
 	 * without matching. Accept the pre-enabled consoles only when match()
 	 * and setup() had a chance to be called.
 	 */
-	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
+	if (console_is_enabled(newcon) && (c->user_specified == user_specified))
 		return 0;
 
 	return -ENOENT;
-- 
2.30.2

