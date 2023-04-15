Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE6C6E3059
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDOKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:01:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F53C1E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:01:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b60366047so498313b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681552877; x=1684144877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHqibnNY4gA+evDUThDgjACEqmKl0LOJc2RKlg79svA=;
        b=TGH9B4DUswCHmUGOcZZ+1lYnWG0x7dyyYJgZI+4xpwtGrfcjZCWcBnB/YyOBciGAUC
         Vo+Y0O+U3oueDwSAT1VvRQE8s15PKZaLMVaOdqhVXT8veO9CFDET0EDnJGf6FYDSRvQg
         /4wo8Wjohfpi9BswLyfCbwZ/UR0UKyX5mV5Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681552877; x=1684144877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHqibnNY4gA+evDUThDgjACEqmKl0LOJc2RKlg79svA=;
        b=OaRNIc/V8SOyhyuIfiW6dlRfhDcm6u8dUo84U0898FmnN7cJsXJB3qHLSqWiEVgewY
         bezdD3Kw+9SMlG9OgdSdPOfkomsUSIpSClqVxiMMso5FfDEcbTSdsVNgEmxYoAWCanIG
         lv3+UAc0iQ/unzezLEhHAnznmPXyrIlmI3EtrpElvsFkL+svDfg6Ue9y/qvp9LXQY+9q
         5MyDAoVMAPJD9fnk3N1QZ+OtFnit2ksznr+uWsABeL0VV9fuMM0bfkfBIvOqav+Ay4wt
         GgFqTcq9Je8EoutmzZlG42yiu1xtKpCvEF3uvlk1QJqCWAaOYiDmtg9P/SscuCA24V0j
         R/ZQ==
X-Gm-Message-State: AAQBX9d5fYpoTWqWLU4xGAD6UCq6Rd97nFPQt9yC9C4JlzRbNbh8i25j
        8CVqa2WwwLZKFgx67dw8Y2BxJg==
X-Google-Smtp-Source: AKy350YTzs0cX55VRFIMdPwWSA1UoMgHTy/om9EKcy+s3h6ZZ13HNLKax9hO0G1J1ALiI8ftnBXJrQ==
X-Received: by 2002:a05:6a00:1402:b0:62d:e966:ffcb with SMTP id l2-20020a056a00140200b0062de966ffcbmr12826079pfu.0.1681552877311;
        Sat, 15 Apr 2023 03:01:17 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:499e:18eb:4cc3:7e30])
        by smtp.gmail.com with ESMTPSA id z9-20020aa791c9000000b0062e63cdfcb2sm4492112pfa.93.2023.04.15.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:01:16 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3] seq_buf: add seq_buf_do_printk() helper
Date:   Sat, 15 Apr 2023 19:01:10 +0900
Message-ID: <20230415100110.1419872-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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
2.40.0.634.g4ca3ef3211-goog

