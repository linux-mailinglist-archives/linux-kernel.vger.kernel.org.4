Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB95B4A92
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiIJW3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIJW2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423043E5D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:58 -0700 (PDT)
Message-ID: <20220910222301.253866623@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3xI7lyIQCW3w0/wiKpLxYgu3oHCXS+iYlZXHschZG0c=;
        b=sYky9NRuc6BaPd16D3VpHkXEq+HLtuTyCzTHXQ1X3nI69k4aLit51cJY8iZak4x+bR9r+f
        n5/GJg6eHCYi+NljLg4KBP8ZEuXY5wISyhsZM8HSDkyYpa6ZQYHa8fUrbk0caeFCWSp1bB
        jEe91ipWNorm1k6p49pdkpvKJAKTpUxSG4XD2PbV1G34R6+4lD9pp2vFtzA8nXZMCpLoSQ
        nG4AS+i4IAXFEERv3axXTNVpDM80DzTILAwePTDnjFCLBVEDiqZ+8x9P/anu8RqiIX308P
        tD6UNHIP4nhZ7U6bnuTySqaaobgyGej/bRd6MCwqKvBMFrtnZFN4CkI4FT5QvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3xI7lyIQCW3w0/wiKpLxYgu3oHCXS+iYlZXHschZG0c=;
        b=oYwgwlgFJkRM9mZRDrIGeoxKs0BKvIQPjFBSxnVsI6CKbrnSLZms1iG/b1MCI8yMbKKQMI
        6OhyWfhaPGyskYBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 15/29] printk: Add struct cons_text_buf
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a data structure to replace the open coded seperate buffers for
regular and extended formatting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -173,6 +173,20 @@ enum cons_flags {
 };
 
 /**
+ * struct cons_text_buf - console output text buffer
+ * @ext_text:		Buffer for extended log format text
+ * @dropped_text:	Buffer for dropped text
+ * @text:		Buffer for ringbuffer text
+ */
+struct cons_text_buf {
+	union {
+		char	ext_text[CONSOLE_EXT_LOG_MAX];
+		char	dropped_text[DROPPED_TEXT_MAX];
+	};
+	char		text[CONSOLE_LOG_MAX];
+};
+
+/**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
  * @write:		Write callback to output messages (Optional)

