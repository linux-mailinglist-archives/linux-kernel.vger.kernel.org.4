Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900AC5E868B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiIXAGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiIXAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16409105D5B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5h7zixATd3WpCb7P+Y08NqGrb+Fb5oQOQ9ihWYJOO5k=;
        b=H17dFKuKhT9Lp9Q4+/UbrwIXCcApT4fvLMAxpq7EnVbGkimHzqBWkAKTBRAJum7YnMSxHG
        vhyYuDgrXdAmAL6mbvbq4t+x9A5l1Rtpm/nJ8Q8DTNRzmxoBWH1HuOTHOytOLdYsv44x+Y
        a2Em3tJjbiOgpRVZUNU+R25WG2UYcLhRSNnmRVqsjU2I4ehQo307+mjJiF4utT5UZcA9sQ
        fRqapy9yhDlhvJudHV2GLqCfX8pTXOVhmBwFZ4rh08QT216Z4jvGZgbgZYD31BNCYf++na
        qQc8C+tajmDQwze4hE/17DUb/HH1utNuhjF1AmnTzIH7oCa2cGBQyaM35ILylw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5h7zixATd3WpCb7P+Y08NqGrb+Fb5oQOQ9ihWYJOO5k=;
        b=L9VjFKU9GQuqZI2R+r4dxWI8JAmys1BTBglboFPZzTbZiSK3oWd9Ex3t7rBSwM2vVenTkI
        C6Vp9viA8gKQO5DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk 15/18] printk: Add struct cons_text_buf
Date:   Sat, 24 Sep 2022 02:10:51 +0206
Message-Id: <20220924000454.3319186-16-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
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
regular and extended formatting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8ec24fe097d3..05c7325e98f9 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -173,6 +173,20 @@ enum cons_flags {
 	CON_EXTENDED		= BIT(6),
 };
 
+/**
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
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
-- 
2.30.2

