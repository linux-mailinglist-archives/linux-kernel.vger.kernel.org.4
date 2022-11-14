Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E381B62854B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiKNQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiKNQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189BEB1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:39 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6POxijvlWYTfJk68FJg54j07I7MpPRBTNu3UsEFQG6Y=;
        b=JCoPP84GTD7S6ZKvY3Z/oW1faIG0mRb+VXwmEMq2/9maJnu2bJ4vVZwAKdnWc0JkCEwziB
        u9Z4tPX23Yk6Dq1b8w2jERlxWFg9DZ6B8ebtpQpj8Eh/HGr1vYGrbZvZRaddeJKAO3LlQx
        J1TeVrqc45Q8oimpMKSBUzA7sN8i9CC+jZFqFP8+fC6nuurYGVkEgO8NfYHmsCdyslWqR3
        r49w15/LRtFVLv5xvSxiCEuHQy5VVbMYf5zi6z8gKRt9MYYconzIJI69+2S8dLZ+WC4xuX
        LH/xD2yPO2uk1n/+PeJzAvnTu0vVvHmwItiLx5zxsIDDlP21zAWNhv2/dqOwtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6POxijvlWYTfJk68FJg54j07I7MpPRBTNu3UsEFQG6Y=;
        b=XM0sZBUTpYOnV33YxdEq1ANzbOmI/ncNQRLlKWlmnypDTlRkCpe0fo3vqHy9OFToINmwjt
        D4N0MxF5n4UhX8DA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH printk v4 08/39] tty: tty_io: document console_lock usage
Date:   Mon, 14 Nov 2022 17:35:01 +0106
Message-Id: <20221114162932.141883-9-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
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
on registered consoles. Since the console_lock is being used for
multiple reasons, explicitly document these reasons. This will
be useful when the console_lock is split into fine-grained
locking.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/tty_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index de06c3c2ff70..ee4da2fec328 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3526,6 +3526,16 @@ static ssize_t show_cons_active(struct device *dev,
 	struct console *c;
 	ssize_t count = 0;
 
+	/*
+	 * Hold the console_lock to guarantee that no consoles are
+	 * unregistered until all console processing is complete.
+	 * This also allows safe traversal of the console list and
+	 * race-free reading of @flags.
+	 *
+	 * Take console_lock to serialize device() callback with
+	 * other console operations. For example, fg_console is
+	 * modified under console_lock when switching vt.
+	 */
 	console_lock();
 	for_each_console(c) {
 		if (!c->device)
-- 
2.30.2

