Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFDA6DCFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDKC4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKC4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:56:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0A1BC9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 19:56:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ie17-20020a17090b401100b00246d4b282eeso1710375pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 19:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681181774; x=1683773774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46R98SU833t0R10XzHYlOpO895zvMtz2LA3SFulzgmE=;
        b=GEklmf0n/S5DRaQJ693SPU4U4JpMCIAD+kogYccAJWVM99dOcntryBAAlulURVMXPf
         67E6zvU1aOp86PwhjtBZv98Sd7SCmqLhlqN+DWdVOvw//Az+a7o5e8mi0vIq2/z6ANkB
         CqQgQ1d6tGvUGG9pK5xpq5iXRPMyYyafQKLT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681181774; x=1683773774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46R98SU833t0R10XzHYlOpO895zvMtz2LA3SFulzgmE=;
        b=nrfMRiN9HS8bPzrDR96DeB5aY9ogAOmr4pfxRoC7xYKmK6ARPo4GEdDCnoXkOoE72I
         XN0EGj7ZFBCMDh/DtlRfjwh4U8SC0hEGXLRPdF84PWXqOzsvHXTFKyEEg8rtn9MTj6ow
         D61yvoAGENtnNt1+egil+Q5JsCPdhKNIsbVeIJRKxhk50lXaS6JV1JVWE3JlhF0Wd0rm
         kI7nphT9lSYoRC7ApzzwK764xN3DfCSeqdjDZ4324u7r3hB3ihK8hCnuR5pu30ilPDbM
         NSxPv7H9F+ktmjdiSebc1kCchs1F2Q8Pk1vnZXxZhyVSIpxOKfpRnDZBXW4VLwvStDe9
         cMGw==
X-Gm-Message-State: AAQBX9daWMC3jMwgmqZFHQ1+e4BqDnSzJvECkHb9I4PbH+ZGFi+8n/sy
        rJS74DPRrrzAxBT56aAftL1krQ==
X-Google-Smtp-Source: AKy350b8czDvs//4crrZaUbUZPkhNDYPKeh6x3YDKO6c2ouQJ99nBKSnhnZVQswJ+3brzS0WTQqY3Q==
X-Received: by 2002:a17:90b:4a52:b0:23f:c096:7129 with SMTP id lb18-20020a17090b4a5200b0023fc0967129mr17038301pjb.26.1681181774177;
        Mon, 10 Apr 2023 19:56:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5a35:4a16:21ec:1fcc])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090ade1100b00231227781d5sm5348982pjv.2.2023.04.10.19.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 19:56:13 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] seq_buf: add seq_buf_printk() helper
Date:   Tue, 11 Apr 2023 11:55:56 +0900
Message-Id: <20230411025556.751349-1-senozhatsky@chromium.org>
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
 lib/seq_buf.c           | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 5b31c5147969..80b78df89809 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -159,4 +159,6 @@ extern int
 seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
 #endif
 
+void seq_buf_printk(struct seq_buf *s, const char *lvl);
+
 #endif /* _LINUX_SEQ_BUF_H */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 0a68f7aa85d6..9d13004c2324 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -93,6 +93,36 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(seq_buf_printf);
 
+/**
+ * seq_buf_printk - printk seq_buf line by line
+ * @s: seq_buf descriptor
+ * @lvl: printk level
+ *
+ * printk()-s a multi-line sequential buffer line by line
+ */
+void seq_buf_printk(struct seq_buf *s, const char *lvl)
+{
+	const char *start, *lf;
+	int len;
+
+	if (s->size == 0)
+		return;
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
+EXPORT_SYMBOL_GPL(seq_buf_printk);
+
 #ifdef CONFIG_BINARY_PRINTF
 /**
  * seq_buf_bprintf - Write the printf string from binary arguments
-- 
2.40.0.577.gac1e443424-goog

