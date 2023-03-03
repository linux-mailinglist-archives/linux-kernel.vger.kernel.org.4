Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B386A9A75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCCPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCCPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:17:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E41149B2;
        Fri,  3 Mar 2023 07:17:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u9so11744989edd.2;
        Fri, 03 Mar 2023 07:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP7JkOmtAPoKEylq3aS9f49bNSoafYjJVu7dXcYE+Mk=;
        b=kypas4z1GXFmKra5JVQlleH/5cZ3Mh2A5xzCbYjsy+aO4/wFvoCtsqm+wikrhcrJDD
         TquAw8PTqLfttIBxSfalvlSLzI2KgLhRLcT1/Lzxx0xVOu9+x5ERsyLrdWHvX0m86dci
         Q2hPbcIwFSFHBHM3sKU5oWRtpQBFFpX1DusSjVzsnI8E93plw0HsgKujwwRnB3FLIm5r
         y23GNwCwA0/vL7nxyjiFv8py9AS2bMxnxXLXSVB712rJNc/7OXtufaMdTg/KaMDruPIM
         WZ2xpvEgeqvsAEVbtDLAt4b/+fQPpJUqUz/BB152t+5mA5/Xy4Z2aF+GSDul9AzjXoQC
         mm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP7JkOmtAPoKEylq3aS9f49bNSoafYjJVu7dXcYE+Mk=;
        b=MoC0C2OlTcnnZ0j31xdMASovEiMaQtaXOqnCjZlp1EJKRzigoEPpWuNEet/KEDN3bu
         83efBCTgR0zj+i/IkuosKMaXwNlvf15khPIF7cJaOlGt2YJ9jOkHCkR6yB0Y1VT8qhuh
         iGY9bnRzda48ROX9GG3XIQo9jTPk8FeIFfaCxQwh2mkhTxHkXcWnRAM4kCsR7LyuceA8
         rMKdhIJpb/e3OjYYQg9ar4c3ANQQ+b6W73lXanrcLYNWIS086L0q82UjVw8uhk1RsS0J
         k6+cqBoU2nd9BolRGV3DemKm5LbYIxcoLAWXtO9NTiWkRyJlzVpPgM2u+VNu25bSF8KI
         cWMA==
X-Gm-Message-State: AO0yUKVxU+UqgKzWsly+BnFYYRxHN+R5Eo5woHhBwGl08ioznZBizT1w
        duMX12qrOmiyQYDi/Z2Pi3//Pu1Nei5hKw==
X-Google-Smtp-Source: AK7set/68r3nqsPVT+4Y8wGluLWFM7nENyT18dqTJYMsULBuaKxax5yQEMMlv4ivVUHDAEr9dYiG1A==
X-Received: by 2002:a17:907:728c:b0:8b1:788f:2198 with SMTP id dt12-20020a170907728c00b008b1788f2198mr2415159ejc.19.1677856653846;
        Fri, 03 Mar 2023 07:17:33 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o13-20020a1709062e8d00b008e22978b98bsm1048390eji.61.2023.03.03.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:17:33 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Date:   Fri,  3 Mar 2023 16:17:06 +0100
Message-Id: <20230303151706.57851-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303151706.57851-1-ubizjak@gmail.com>
References: <20230303151706.57851-1-ubizjak@gmail.com>
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
index 71df857242b4..3bfc2e8a3da4 100644
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

