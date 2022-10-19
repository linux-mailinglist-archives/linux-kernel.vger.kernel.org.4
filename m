Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82749604A98
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiJSPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJSPFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCD6573
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:25 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6JL8Q05OijoTEvKKyIiYa7K6VvZeDLREPexuqG68w4=;
        b=2lE2ZSVvaLYxX/mxts/imwzBNHAp8IFSDC/ai7lkxP1zyF6vpMFV8KAaG0pwB+zKzWkutn
        BNZQsjhTA+fE9mUGf/9zLZQuPNRIBu0owJpd7GDzfuULoEKri5Ic8olH4bE1eI5Rf1CKGy
        vTs3ThAfna4xN6EPjQmcBVcPNNwb7z99UsM+MaDiSMsHRWQQdQDukhcxIu7T4tOZ2TYmxg
        Bfdt5cy+/S+IRAvC/LS6NYxQYe0e79/FQQRYb/Mcd8jS8qxWB1iuXQe85SqXEhXYqiH8j4
        +8mgUokSmCQOtAKhWeO3fUlqU5Flbi2cC2akX0Xw1B69Gv1ldKxWWm+8ITOUfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6JL8Q05OijoTEvKKyIiYa7K6VvZeDLREPexuqG68w4=;
        b=CQZkI2DXDnPwDZmhG2PVbvPciqqo6PQ6K7EPwjaFXRMKTNR/ZrE840g4rZSpD8aFVitZok
        a6Wx9DhxTm9LofBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH printk v2 26/38] kdb: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:48 +0206
Message-Id: <20221019145600.1282823-27-john.ogness@linutronix.de>
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

Guarantee safe iteration of the console list by using SRCU.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/debug/kdb/kdb_io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 550fe8b456ec..5c0bd93c3574 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -545,6 +545,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 {
 	struct console *c;
 	const char *cp;
+	int cookie;
 	int len;
 
 	if (msg_len == 0)
@@ -558,7 +559,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		cp++;
 	}
 
-	for_each_console(c) {
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
 		if (!console_is_enabled(c))
 			continue;
 		if (c == dbg_io_ops->cons)
@@ -577,6 +579,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		--oops_in_progress;
 		touch_nmi_watchdog();
 	}
+	console_srcu_read_unlock(cookie);
 }
 
 int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
-- 
2.30.2

