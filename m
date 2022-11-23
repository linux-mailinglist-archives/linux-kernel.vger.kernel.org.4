Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FC2636E36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKWXOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKWXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:14:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7136BDEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:14:15 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669245253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHekk7rHrVj5L5T/94RT0HyGLRna0DzwZs8ha+Ccyvw=;
        b=rUgi9ajh583f3DafswGx6DnJgtX1nVcRAI0OyvdmARANW4/vl6t1tWVQkHydEMakuWWC11
        USYMG+Gs8LFd4tcL6UReH+pZX4mBlHObcxMHf+AKL9UvcdGeq2e4uRKAyK3le2jXCfAyts
        n+ppQ+9SW7jvNmqXyvoh7/2iWz/RAsfVn06Qu+ag4MlIBbVKOFMMx4XUWSPL24cMJhemaG
        KDXxrR6MbH+huS7Ii4ul3e2XVCASSvMolb6UQO103ehl3MO+mKu5qQCgzzgM2anf/BKsWW
        YlLxKESOAulXbigFgHDL6LRpLI/6nlI5QTGHxhVtPG9bqEfXBWEvBZnAfNkWtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669245253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHekk7rHrVj5L5T/94RT0HyGLRna0DzwZs8ha+Ccyvw=;
        b=2GHZKoSrpfphmj+qCrBjg2+U05bc9CFtPkG0ZSPQaa+D8zKrUOuD28SZDr66qVARIhuUIb
        dM9dzZOLn74ztsCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 4/7] printk: Add struct console_buffers
Date:   Thu, 24 Nov 2022 00:19:57 +0106
Message-Id: <20221123231400.614679-5-john.ogness@linutronix.de>
In-Reply-To: <20221123231400.614679-1-john.ogness@linutronix.de>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Create a data structure to replace the open coded separate buffers for
regular, extended, and dropped message formatting.

A separate @ext_text buffer is needed because info_print_ext_header()
and msg_print_ext_body() are not able to add the needed extra
information in-place.

@ext_text can be used for dropped text because they are never used at
the same time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index b2cf256c23b6..641c1ca7fb67 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -178,6 +178,16 @@ enum cons_flags {
 	CON_EXTENDED		= BIT(6),
 };
 
+/**
+ * struct console_buffers - console output text buffers
+ * @ext_text:		Buffer for extended log format or dropped text
+ * @text:		Buffer for ringbuffer text
+ */
+struct console_buffers {
+	char	ext_text[CONSOLE_EXT_LOG_MAX];
+	char	text[CONSOLE_LOG_MAX];
+};
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
-- 
2.30.2

