Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54CD6AB14B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCEP4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCEPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:55:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D61A482;
        Sun,  5 Mar 2023 07:55:55 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ay14so25317792edb.11;
        Sun, 05 Mar 2023 07:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678031755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWpr/5GI81lO69HAXhZKZcngIwW2QBW0qpGz3J/BR7Y=;
        b=JZ7HVCm1GGd9pUjhxo3A1AY0n4FdeAbY0NWJyjiRPJo63D6DLqDHSVtscpmtLuKs5F
         WrEg5mceFjg2nC73JigTUxVJrbpcHmYSvQ3yEEZ2vD+cnvrBWtFjSBmZJquXg5ESA5Jj
         BGyCUoDifWlpElAItkad6gpPtRcd0rhHUwDEt2tYyLtiYSZuW9uvSyrlr2RWA4KkHT/g
         6JfcuJpqDmWEAridEBSynaCJOZNWLC+QMlHIY0a/Wt+rqAF2H38wynSlQe0waGTotqC5
         5con2PbutNeiS+/+/hE42OZeySH8uv67BDi0dJ9m8GyReoxFDpPLMI3Ye2Zmpjz9oUI9
         hZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678031755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWpr/5GI81lO69HAXhZKZcngIwW2QBW0qpGz3J/BR7Y=;
        b=uC/C1NyfC6vUb9SGl7uk6KOfwdq7OPcXulrd3wj7R+H8NtpOUQEJqgxSfB94dWsMCw
         UDutvgHv2WGbm/5EWz8nQrsJ+Eu9TyeKo8GGCiT+ubeqOUTeun42iNcUHn9OiaE0q1T9
         ZCBz7+AKmQK0Ct/tsXIyauS5y3rGy5fqadMWxZfE/o/wQ+bKA9ntgXYi6u2dqGgQtUL6
         xTADlDwGdXaPnRy3D+8C+rPhDxnRabvYPch6XNjWPImMcU9BG3teMvyjbCJB+WYJyOBg
         EC9o//r1LblLtYZ4jZ/YmoexoY7kLaYvjznVJy8FieAk9krwhNR4l40XSE1xjmL3RnGe
         vFPg==
X-Gm-Message-State: AO0yUKXr2SB7z9mnvxRKDmK/pjMVYppdf54AUWokyGO2XGySpqz0CIlc
        TSNw3HbFmjeD93FIOB+Kj2C8P5ax8P9Myg==
X-Google-Smtp-Source: AK7set+24pFH07hsMj0t96ebZC6goJ/4uYDKtLpVg5iPmvH8AsczfOHibVpCEbdxpliYRyB437bL5Q==
X-Received: by 2002:a17:907:c28b:b0:8e5:2b62:c3ac with SMTP id tk11-20020a170907c28b00b008e52b62c3acmr7684759ejc.77.1678031755244;
        Sun, 05 Mar 2023 07:55:55 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id pv16-20020a170907209000b009079442dd11sm3357332ejb.154.2023.03.05.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 07:55:54 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Date:   Sun,  5 Mar 2023 16:55:32 +0100
Message-Id: <20230305155532.5549-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305155532.5549-1-ubizjak@gmail.com>
References: <20230305155532.5549-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change
saves a compare after cmpxchg (and related move instruction in
front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Convert only loops with cmpxchg.
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5235037f83d3..d17345b522f4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4061,10 +4061,10 @@ void ring_buffer_record_off(struct trace_buffer *buffer)
 	unsigned int rd;
 	unsigned int new_rd;
 
+	rd = atomic_read(&buffer->record_disabled);
 	do {
-		rd = atomic_read(&buffer->record_disabled);
 		new_rd = rd | RB_BUFFER_OFF;
-	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
+	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
 }
 EXPORT_SYMBOL_GPL(ring_buffer_record_off);
 
@@ -4084,10 +4084,10 @@ void ring_buffer_record_on(struct trace_buffer *buffer)
 	unsigned int rd;
 	unsigned int new_rd;
 
+	rd = atomic_read(&buffer->record_disabled);
 	do {
-		rd = atomic_read(&buffer->record_disabled);
 		new_rd = rd & ~RB_BUFFER_OFF;
-	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
+	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
 }
 EXPORT_SYMBOL_GPL(ring_buffer_record_on);
 
-- 
2.39.2

