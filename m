Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D7604A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiJSPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiJSPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAA2205CC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:28 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f12nNYu1o1nheACyaBAz3IPbjPiOwdCr955JKGftNi0=;
        b=gEk/56dyVdJxDt/J7kVgFStcKjvZrGcgIOwQYk0XwQKdK8FsV0Y9dvc9y2PrxlYjtuLQT3
        fSJL3lf/BuDtIhc+l6cIXdtEsuXqSJu6EpaxJSdLt15yliOrYrRp1+h7ASkvcNnkIleiOK
        WZ+Tm++vLlUFSJX9OqsxsxRrd4s4tFKvj3VUqZdNFTfb3Xhi8xUPk8f1Hr6A5xGkJiRoR+
        A2sCQpxxeuWpEagnAVMwC/rga5HRcHoOkPCaPZzrNI1r1Nzz5TeNQX3rrKHlEpNHJHjOfV
        JKp1j4/HoOOs0hPNpCf8W0nyoa5ouc48VUQum9WrHC4viYimonEL+j+iP2L95A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f12nNYu1o1nheACyaBAz3IPbjPiOwdCr955JKGftNi0=;
        b=Hy5IF74AngV6AgkVUBSfbWawZSbLHUumgqjJi1aW8Es4tyHbxXvp1fWUJHJOyfgmdOtGqL
        +/HMreGlQbQCBDAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 31/38] printk: register_console: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:53 +0206
Message-Id: <20221019145600.1282823-32-john.ogness@linutronix.de>
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

Use srcu console list iteration for console list traversal. Now
the traversal at the beginning of register_console() is safe.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 410ad9d5649c..809c43e596d8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3188,20 +3188,23 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_enabled = false;
 	bool realcon_enabled = false;
+	int cookie;
 	int err;
 
-	for_each_console(con) {
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
 		if (WARN(con == newcon, "console '%s%d' already registered\n",
-					 con->name, con->index))
+					 con->name, con->index)) {
+			console_srcu_read_unlock(cookie);
 			return;
-	}
+		}
 
-	for_each_console(con) {
 		if (con->flags & CON_BOOT)
 			bootcon_enabled = true;
 		else
 			realcon_enabled = true;
 	}
+	console_srcu_read_unlock(cookie);
 
 	/* Do not register boot consoles when there already is a real one. */
 	if (newcon->flags & CON_BOOT && realcon_enabled) {
-- 
2.30.2

