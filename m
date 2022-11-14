Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F27628558
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbiKNQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiKNQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1FC2252D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXMXbp7RkCm+6HR9dgXj+chNQzy16FhmR2CfzYfqcKY=;
        b=bbR2W4gqB1076ROKgh/MNgK01Tzv0Le3BX+Zotvf/ft2eI7wlxLJhjLW27gCrMzbsLG/gK
        G6r5Ad9lmV0s2P8unlytWuKvcYuADR72fClD57tKzaEOi4ndiE3ME2QYSR4JJ9wNEherg6
        7tC8+dinHlxyjiWfl9whO2u8jrBXBwL6pikjf/NN3WKm/FcyiDbUCLXKoz1CWpWWPlciex
        Fyals1BFl9+dtKFxw0Yn3wBjC1bSlRo93qnu9ieRsXPWK+JWE8S+SlJy9Iyq8NrItyqIwB
        PdLhEsG4AH8UF/7XHTyr/lxgxttkKw6egNT60YIJaHsVGkarmdfNjMo+y8sF9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXMXbp7RkCm+6HR9dgXj+chNQzy16FhmR2CfzYfqcKY=;
        b=0FQ3W38V4gG8pEPSTtVp12zhC1wqEbepo4UKy77fjui7MHnQj6A/VCbbcUMV+WhYXnre+L
        x+7lL5FXwnoLC6DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 19/39] printk: console_device: use srcu console list iterator
Date:   Mon, 14 Nov 2022 17:35:12 +0106
Message-Id: <20221114162932.141883-20-john.ogness@linutronix.de>
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
index f536233d8234..fb609a19f797 100644
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

