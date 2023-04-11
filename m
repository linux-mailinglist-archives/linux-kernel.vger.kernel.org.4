Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67EB6DDE35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDKOjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDKOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:39:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E7A2683
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:39:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-246a1c48021so349309a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681223941; x=1683815941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3POXpBLOYkBNAqAT4V8Vzl8XKzx70OKFxmrdLGlI7U=;
        b=G1vyVng5aGWTk1Uq+ONgBFyZF/zKnJYI6UZMPEViRLwOA1kthwmJlZvq7JcygFc61l
         HlzEPjljVorrtzNSwZ3snpgIo85FrK8X3Cm5YwC1Y8D1hJ5AbaFE/jcAlhVdw6n/qj/d
         e6Ma4T/ZGuS8k5jNeuTDjeASqx/3qBEMRC8Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223941; x=1683815941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3POXpBLOYkBNAqAT4V8Vzl8XKzx70OKFxmrdLGlI7U=;
        b=sMhtvJJLrW/xNxHzWPDkXAmxxlnAKPecg6HGvRKwFQWi9ATm9TVSyZmtySD8qU7jjC
         zZfRE4tC1cdTK4Wbx1m5nuKrWLUvp7eGTeB2Muy2pIJIuVSYrIAjeGgdEaxYKDjuxJJF
         LOUGrtPhqcKpKaWIziihgR7XhsY+mb2/bAEp+kMJztRCBl0RYaQIA0R0E3ngjSTJihCE
         f2OhrIpDtS0xQaFbH8KOZW8WmgeEDYJHTkJL6+khvYKo31E2k6VDMP87p1mFCPg/3cwy
         hFLvLao026rayzE/9kB+6kssYB3ZmM/t9FPkS5pYUoOVkNCZpvogrLr6dLwHxvbhtgub
         wYlw==
X-Gm-Message-State: AAQBX9dKlNRaokpLuWQKOS1DXcC6zJNUOi1V4Sg/S6c2s9IzEntimHaS
        T1tSz+pk4uf7iB3PaushrQsCcQ==
X-Google-Smtp-Source: AKy350bMuVL92dqZWO2yg0IrJyEZRI7Oi/TOcVmN0FZHJYilmGl32j1KaRME49/fg/vxl62XwxIPTA==
X-Received: by 2002:aa7:9a41:0:b0:63a:38d2:d41f with SMTP id x1-20020aa79a41000000b0063a38d2d41fmr5346199pfj.29.1681223941186;
        Tue, 11 Apr 2023 07:39:01 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:c8e3:b775:3b12:ac9e])
        by smtp.gmail.com with ESMTPSA id k14-20020aa790ce000000b005abc0d426c4sm9897799pfk.54.2023.04.11.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:39:00 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] seq_buf: add seq_buf_do_printk() helper
Date:   Tue, 11 Apr 2023 23:38:52 +0900
Message-Id: <20230411143852.868524-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we use seq_buf to format a string buffer, which
we then pass to printk(). However, in certain situations
the seq_buf string buffer can get too big, exceeding the
PRINTKRB_RECORD_MAX bytes limit, and causing printk() to
truncate the string.

Add a new seq_buf helper. This helper prints the seq_buf
string buffer line by line, using \n as a delimiter,
rather than passing the whole string buffer to printk()
at once.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/seq_buf.h |  2 ++
 lib/seq_buf.c           | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index 0a68f7aa85d6..be7227d42b20 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -93,6 +93,40 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
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
+	int len;
+
+	if (s->size == 0 || s->len == 0)
+		return;
+
+	seq_buf_terminate(s);
+
+	start = s->buffer;
+	while ((lf = strchr(start, '\n'))) {
+		len = lf - start + 1;
+		printk("%s%.*s", lvl, len, start);
+		start = ++lf;
+	}
+
+	/* No trailing LF */
+	if (start < s->buffer + s->len) {
+		len = s->buffer + s->len - start;
+		printk("%s%.*s\n", lvl, len, start);
+	}
+}
+EXPORT_SYMBOL_GPL(seq_buf_do_printk);
+
 #ifdef CONFIG_BINARY_PRINTF
 /**
  * seq_buf_bprintf - Write the printf string from binary arguments
-- 
2.40.0.577.gac1e443424-goog

