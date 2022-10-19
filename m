Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA55604A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiJSPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiJSPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169E0201AE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9ex8lzRPv2fLvIIrbPhNI07gh3HOaIObjp42xbSQhM=;
        b=dV8eeJVkJqnYI4Tntl1R3l7jZCsG9aTkqgpLBzaep2kY0IpfWQ7AkgrFxuD0Aa3hlViZnt
        ZZRK5iRTG84EysIrt3V4DA4GmMpvfrR4x9fqaPMgBv4GmPgnJmb14MJFSFl0uFVMr9q71p
        oSDQNSWKNoB8WJZ8deTwEu0BfGAlvwRs+SgN/tNjuqT+X5J1YgCdw6HanP40357h5g2B4A
        6YNAFBkSg15DyUCvdL3htD/Ho6Tf0MCwFafxoCOOfoRR0aeGRkfoFItU243LcFdgK+9JP1
        hERXGmQ7msAr35hPgWEk40C+RcKtWqBob98VeE5EsrIjw0MHnYs/pQEyU7BwPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9ex8lzRPv2fLvIIrbPhNI07gh3HOaIObjp42xbSQhM=;
        b=3QTHJMOIlL3X1RHmjXFjR8ZUj0J6xFSmlHeAL+ESJ8836arfruLwiyCsruxtdvCScpYlAN
        bsHq2FAjEV58YVCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 29/38] printk: console_flush_on_panic: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:51 +0206
Message-Id: <20221019145600.1282823-30-john.ogness@linutronix.de>
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

With SRCU it is now safe to traverse the console list, even if
the console_trylock() failed. However, overwriting console->seq
when console_trylock() failed is still an issue.

Switch to SRCU iteration and document remaining issue with
console->seq.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0c37ab208395..e478cb92e7ba 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2998,21 +2998,22 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
-		struct hlist_node *tmp;
 		struct console *c;
+		int cookie;
 		u64 seq;
 
 		seq = prb_first_valid_seq(prb);
-		/*
-		 * This cannot use for_each_console() because it's not established
-		 * that the current context has console locked and neither there is
-		 * a guarantee that there is no concurrency in that case.
-		 *
-		 * Open code it for documentation purposes and pretend that
-		 * it works.
-		 */
-		hlist_for_each_entry_safe(c, tmp, &console_list, node)
+
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(c) {
+			/*
+			 * If the above console_trylock() failed, this is an
+			 * unsynchronized assignment. But in that case, the
+			 * kernel is in "hope and pray" mode anyway.
+			 */
 			c->seq = seq;
+		}
+		console_srcu_read_unlock(cookie);
 	}
 	console_unlock();
 }
-- 
2.30.2

