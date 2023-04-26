Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2A6EF923
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjDZRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjDZRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18965B7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB9A636FF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD34C433EF;
        Wed, 26 Apr 2023 17:17:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1prim6-005KZJ-02;
        Wed, 26 Apr 2023 13:17:50 -0400
Message-ID: <20230426171749.823208218@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 26 Apr 2023 13:17:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [for-next][PATCH 04/11] seq_buf: Add seq_buf_do_printk() helper
References: <20230426171703.202523909@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <senozhatsky@chromium.org>

Sometimes we use seq_buf to format a string buffer, which
we then pass to printk(). However, in certain situations
the seq_buf string buffer can get too big, exceeding the
PRINTKRB_RECORD_MAX bytes limit, and causing printk() to
truncate the string.

Add a new seq_buf helper. This helper prints the seq_buf
string buffer line by line, using \n as a delimiter,
rather than passing the whole string buffer to printk()
at once.

Link: https://lkml.kernel.org/r/20230415100110.1419872-1-senozhatsky@chromium.org

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h |  2 ++
 lib/seq_buf.c           | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 5b31c5147969..515d7fcb9634 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -159,4 +159,6 @@ extern int
 seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
 #endif
 
+void seq_buf_do_printk(struct seq_buf *s, const char *lvl);
+
 #endif /* _LINUX_SEQ_BUF_H */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 0a68f7aa85d6..45c450f423fa 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -93,6 +93,38 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(seq_buf_printf);
 
+/**
+ * seq_buf_do_printk - printk seq_buf line by line
+ * @s: seq_buf descriptor
+ * @lvl: printk level
+ *
+ * printk()-s a multi-line sequential buffer line by line. The function
+ * makes sure that the buffer in @s is nul terminated and safe to read
+ * as a string.
+ */
+void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
+{
+	const char *start, *lf;
+
+	if (s->size == 0 || s->len == 0)
+		return;
+
+	seq_buf_terminate(s);
+
+	start = s->buffer;
+	while ((lf = strchr(start, '\n'))) {
+		int len = lf - start + 1;
+
+		printk("%s%.*s", lvl, len, start);
+		start = ++lf;
+	}
+
+	/* No trailing LF */
+	if (start < s->buffer + s->len)
+		printk("%s%s\n", lvl, start);
+}
+EXPORT_SYMBOL_GPL(seq_buf_do_printk);
+
 #ifdef CONFIG_BINARY_PRINTF
 /**
  * seq_buf_bprintf - Write the printf string from binary arguments
-- 
2.39.2
