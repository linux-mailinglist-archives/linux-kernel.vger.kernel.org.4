Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE5604A87
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiJSPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiJSPF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98472153835
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDZ6pRjPX3M/aNWQNadxCVy2Ern3rX+BUG+UFbJRacE=;
        b=vZ++W4VE4AQQNPASVoIgQEv9QFic6MvrPxW9APkzUtJQWlJmpTRafFJlXDcuEug7iTrgAr
        Q68gq3cOHoYxad58FRzrhkyde3adxE+hwep+0uWLN2/qDedGH7Q7xx1AmRkMh/mK0VoNFv
        nMsU91BskHVFEannoZwBQZA7Z1nTnh3feCTKpKo/0ocU/OTDbu3KpsM2BSapW5B13XOBk4
        XEBAiQvwiu+9W09sKCUpa/szF8Xe08dS43bdhg5WwWcE38dtMvjprltTZX5kT84uDgwvUo
        ks5/LYqdhSVgBppHnyQB/LpicRRiUXa15t6U5CopyRfzugDG8cvli1d2t8CL9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDZ6pRjPX3M/aNWQNadxCVy2Ern3rX+BUG+UFbJRacE=;
        b=zlEFWao8VJz19cq1+qrdLmGFpWXLPFk4nyCnR24oE/kjsnhlT2viimgpJo1H5sm4DIHUYs
        PFn0fdw64FnnTOBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 30/38] printk: console_device: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:52 +0206
Message-Id: <20221019145600.1282823-31-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e478cb92e7ba..410ad9d5649c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3025,15 +3025,24 @@ struct tty_driver *console_device(int *index)
 {
 	struct console *c;
 	struct tty_driver *driver = NULL;
+	int cookie;
 
+	/*
+	 * Stop console printing because the device() callback may
+	 * assume the console is not within its write() callback.
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

