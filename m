Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF461F550
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiKGORm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiKGOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B301D30C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q25D/fbee4emclBCuLkXnvDp43ljaWTdETeJZi0ldYg=;
        b=O454Lsiiz5kJngn+Di+jISdQqtthm9fMBo/qd09UHoJIP7fLkelSV+ixhOpLNJXHV7Mttq
        4TLbFkmtL0Veo/xxWJ2Bmrg4+CnHd17YN8fNg8mNLvgdi/6EhGHArF+ZhnRQzr3fEE7Nmm
        GbTzv8SCm7paAxm0xNbxBqgHL/zrwCwfEdB1FVlcstzlumqZSXfwBX3uFiNjKqRqQDl3L2
        vzay5KqNRDePj6PPYPtFXCOQFV5nRiemPTvZQ5XQ3F/2xXpq9zrCm18mG3kr5/w8GEsPMV
        DcZoEV0ZuTMkTu2GPrrzuDLeIZNuK6d3H3h3F1LtgkaRT/U/vnGhM9IYpHGuGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q25D/fbee4emclBCuLkXnvDp43ljaWTdETeJZi0ldYg=;
        b=SK8wtl/kZYl5l8mJdOCBSFTMjd4QjXMFsXwUjuDGL17ezsD45pR6VKM5rHUjSYtgNFT7We
        be38PD4HSzVHtJDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH printk v3 15/40] kdb: use srcu console list iterator
Date:   Mon,  7 Nov 2022 15:22:13 +0106
Message-Id: <20221107141638.3790965-16-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
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
 kernel/debug/kdb/kdb_io.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 550fe8b456ec..ed8289ce4fcb 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -545,6 +545,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 {
 	struct console *c;
 	const char *cp;
+	int cookie;
 	int len;
 
 	if (msg_len == 0)
@@ -558,7 +559,15 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		cp++;
 	}
 
-	for_each_console(c) {
+	/*
+	 * The console_srcu_read_lock() only provides safe console list
+	 * traversal. The use of the ->write() callback relies on all other
+	 * CPUs being stopped at the moment and console drivers being able to
+	 * handle reentrance when @oops_in_progress is set. (Note that there
+	 * is no guarantee for either criteria.)
+	 */
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
 		if (!console_is_enabled(c))
 			continue;
 		if (c == dbg_io_ops->cons)
@@ -577,6 +586,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		--oops_in_progress;
 		touch_nmi_watchdog();
 	}
+	console_srcu_read_unlock(cookie);
 }
 
 int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
-- 
2.30.2

