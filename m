Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0462C434
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiKPQYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiKPQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E27326F5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:07 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmfyhSE4r6WUxdHMjntiag5r5BjOY39c0HqbRdrpwyk=;
        b=k/cRkSzuFCT+qLGQGkimjidC2S2ewQnumtvJw+ZaIw2kd+mtyfYy9IDf+wRPav3Z6JAB3W
        yPERjIarGDkPzFRVqTufPPgKmx4BK0i6aseuo+Yjja1rFdrV5XJ5k1WBdOguLmdv5QsyPe
        eqKAPKqI82efDymKZ0fsPD7RNWXNLJgD+noCTM8rnZDqxJzmYGbZ1OMcv23JC9HGjJGwsN
        HxoYF605s6qqpxK94MpbPyh543sKAnGUO88n/4muBc6o+CsE3JHTcKrxHVdNm/l2MncEfQ
        HlU7VMMmg6t4dEy7gqKJPyPqx/BEtOpKYzOp3OYAYVAS+eMHhFFJ9uSEvzJL6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmfyhSE4r6WUxdHMjntiag5r5BjOY39c0HqbRdrpwyk=;
        b=ZgnqSOHRDB9ITTyaqG0OzhGDy6iC+fOzqVTExO/t8Tiuha/tipl08vwtipSqjr/KO4CXCI
        YfEAjtozcg8gaaBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 20/40] printk: console_device: use srcu console list iterator
Date:   Wed, 16 Nov 2022 17:27:32 +0106
Message-Id: <20221116162152.193147-21-john.ogness@linutronix.de>
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

Use srcu console list iteration for console list traversal. It is
acceptable because the consoles might come and go at any time.
Strict synchronizing with console registration code would not bring
any advantage over srcu.

Document why the console_lock is still necessary. Note that this
is a preparatory change for when console_lock no longer provides
synchronization for the console list.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1a805ebdfe94..694c2da2919c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3076,15 +3076,25 @@ struct tty_driver *console_device(int *index)
 {
 	struct console *c;
 	struct tty_driver *driver = NULL;
+	int cookie;
 
+	/*
+	 * Take console_lock to serialize device() callback with
+	 * other console operations. For example, fg_console is
+	 * modified under console_lock when switching vt.
+	 */
 	console_lock();
-	for_each_console(c) {
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
 		if (!c->device)
 			continue;
 		driver = c->device(c, index);
 		if (driver)
 			break;
 	}
+	console_srcu_read_unlock(cookie);
+
 	console_unlock();
 	return driver;
 }
-- 
2.30.2

