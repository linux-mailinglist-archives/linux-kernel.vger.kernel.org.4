Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37134604A97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiJSPGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiJSPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC729359
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:16 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4O5jxh5GAGfpdp5oJs484DSsKK6l20yyCIa5aoPwGXk=;
        b=iTFnKkvnbpZV48iaml8m+GkgSuO5UhuOPyuwAZtb2zPnRQi7Q9F4bM6+9lA4A7g8iLXRPd
        YskL9UUUkyQiWaD7JtvivltiLNH8BP8o6m91bP4hX2T8rN8aIfG2pRKSjDnwavHqzgJPPV
        nrYAxW/rTJ6goH7HYUGv9GT708RbC4YLBn8W9dJ8z3JyuVftTLtv+1ZS/5rmxKUb9ktAUm
        BgVLY8s9nkfmIpUG/QSKgxDcIcLYqhI4RlNOE8A1GA41IpZ+VNXZl9Gg4FBPnbWvrjYEqb
        U0yyXtmvo+SVOmto2TaiY3F5ePVRNqLXYpMZ3YduuR2WllgLWVcBt1SII0WNoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4O5jxh5GAGfpdp5oJs484DSsKK6l20yyCIa5aoPwGXk=;
        b=Fu+pjLGgV9HHXN5WM5d4ymQB19nzJZDTwV/1OFZhHc0jWJPZqGp6+7wJwb+s9hVvpKQ2+6
        kYID/meOJJNW9SAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH printk v2 35/38] tty: tty_io: use console_list_lock for list synchronization
Date:   Wed, 19 Oct 2022 17:01:57 +0206
Message-Id: <20221019145600.1282823-36-john.ogness@linutronix.de>
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

show_cons_active() uses the console_lock to gather information
on registered consoles. It requires that no consoles are unregistered
until it is finished. The console_list_lock should be used because
list synchronization repsponsibility will be removed from the
console_lock in a later change.

Note, the console_lock is still needed to stop console printing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/tty_io.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 333579bfa335..46a0e3c5c3a5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3527,14 +3527,12 @@ static ssize_t show_cons_active(struct device *dev,
 	ssize_t count = 0;
 
 	/*
-	 * Hold the console_lock to guarantee that no consoles are
+	 * Hold the console_list_lock to guarantee that no consoles are
 	 * unregistered until all console processing is complete.
 	 * This also allows safe traversal of the console list.
-	 *
-	 * Stop console printing because the device() callback may
-	 * assume the console is not within its write() callback.
 	 */
-	console_lock();
+	console_list_lock();
+
 	for_each_console(c) {
 		if (!c->device)
 			continue;
@@ -3546,6 +3544,12 @@ static ssize_t show_cons_active(struct device *dev,
 		if (i >= ARRAY_SIZE(cs))
 			break;
 	}
+
+	/*
+	 * Stop console printing because the device() callback may
+	 * assume the console is not within its write() callback.
+	 */
+	console_lock();
 	while (i--) {
 		int index = cs[i]->index;
 		struct tty_driver *drv = cs[i]->device(cs[i], &index);
@@ -3561,6 +3565,8 @@ static ssize_t show_cons_active(struct device *dev,
 	}
 	console_unlock();
 
+	console_list_unlock();
+
 	return count;
 }
 static DEVICE_ATTR(active, S_IRUGO, show_cons_active, NULL);
-- 
2.30.2

