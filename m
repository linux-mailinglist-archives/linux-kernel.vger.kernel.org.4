Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFED862C433
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiKPQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiKPQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB50D56ED1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:07 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVEyyo7p00eD9RPDb2JhbrHc13EdmCMyj9VsyLQFgy8=;
        b=sTxOuw9rM214SMJzCfx+HKjrQUF/mTpRzM+B/lCLL7hyaTNlBpzwQSvIRhqwSfvgVD3Gyc
        sEApjwVJ0WqCozTqqEmj8agYVaXrcRjFI6kA07+VBbZ/tugYhMlixLEXmdtlH5RMehAbRQ
        fwdca4X+pSWesLAEXIaGDjkVvY2xCPj9KvORWxMbaQh7p1cUdEIyUcUrjugxCTM2kQPISn
        M37p6pf5xACQyEWa2nmO91fuX+/YB7y6cja8uO3qwXbk3ILTnyh/a04thRTfHdghRW/ALT
        JENYXZt4FPJebfRLVlJunL12KjZF6j2IqFPnttypTPpI6OKx2XdzoM5f2EjgGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVEyyo7p00eD9RPDb2JhbrHc13EdmCMyj9VsyLQFgy8=;
        b=PvcnYVBPLntB2fGmHVVPmL6WouNpD04Mu+Xc6JN2IjcZpqlc32gguaNIJ3bsNkK0Gb4S8x
        U9YLMPZmn0BliHBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 19/40] printk: console_flush_on_panic: use srcu console list iterator
Date:   Wed, 16 Nov 2022 17:27:31 +0106
Message-Id: <20221116162152.193147-20-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b4be3b08d909..1a805ebdfe94 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3049,21 +3049,22 @@ void console_flush_on_panic(enum con_flush_mode mode)
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

