Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6806A5E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjB1SAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjB1SAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:00:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F832E64;
        Tue, 28 Feb 2023 10:00:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ee7so43643854edb.2;
        Tue, 28 Feb 2023 10:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677607202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COtBc9Xkc2aACLUlsHVnQBPathW1aRJo9WqwByd8U1c=;
        b=jOuwXsCumiPTZ3IIvo35FGTMTd4k2DXsbWtUhBQl+3T88Cx5WwefSeP/5skgm642Iz
         eOm2g/7HO2agAVjLS6vyc0ZzCikCFFdDjqq6zL+n8AeRIpOm4BZ703QUAcG7jtTZDrKm
         NlA9Vt+11QGncoEfmH7ZlluGyj4ByHTpOd1r6Tj3gIcjoNSeiqFfcEQRwt5wUMk4CCXV
         TJlXlH5n9LB6W7vQspEvrtoHjfTV1uwI3VOtSPxcDq/9L/LaxMSBomumeCAHsw6PCKkx
         xoaEO9PnDhlg8SS41caqIv29bve0jd+BZlepuwQguADK4RtKthvSfTX6o4JZKSp3nkEI
         7HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677607202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COtBc9Xkc2aACLUlsHVnQBPathW1aRJo9WqwByd8U1c=;
        b=hJufgspkKONCunHW3LwJLQZZuxuvLJJJGLxiV0sEdO9JxMAkDQYsO/vgBsfKZRpYs0
         y3+8F//vG/3LNqvCsvwmf1ew0jY9NepljTYy6rsg1NSe07KLDic3VfeicDJoz70xgPgQ
         HaMoSJxeThZmsxuSZzBiMlUo209dmP9DLGQDlPWSUs4D/rXM5kktQiLvf8wGSO02i2Ru
         iSRGcsA01tSOyTKKV/k3b6prDVdO6Rh2rSSYFNhjYr7MqDItz840uCCw+Ff9sL59sZ/V
         8q8PBOhxrpnzpU2JpFCYf7jUvf9rJ7Q1p66eKMJiBzmBl51y8AS4j/mULe2+SFJOX40z
         lC1Q==
X-Gm-Message-State: AO0yUKXciB6LEFRhMzeevwRi3Qg1+nrNUF3zwpHzyKlky6hfQufV5wXw
        6MXr/Cbcvr0JPA5bQOzBdMv19a8aqJkBEtIa
X-Google-Smtp-Source: AK7set9S6xQl63T5aMPJSvW2ZBnEQcO5FhXa40BALHHAwy6kQuapSWld3dhIUAbRc/gfipxNwQKmQw==
X-Received: by 2002:a17:906:1843:b0:8b1:3002:bd6d with SMTP id w3-20020a170906184300b008b13002bd6dmr3582809eje.31.1677607202131;
        Tue, 28 Feb 2023 10:00:02 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id m5-20020a170906234500b008d9c518a318sm4869725eja.142.2023.02.28.10.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 10:00:01 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Date:   Tue, 28 Feb 2023 18:59:29 +0100
Message-Id: <20230228175929.7534-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228175929.7534-1-ubizjak@gmail.com>
References: <20230228175929.7534-1-ubizjak@gmail.com>
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
 kernel/trace/ring_buffer.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4188af7d4cfe..8f0ef7d12ddd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1493,14 +1493,11 @@ static bool rb_head_page_replace(struct buffer_page *old,
 {
 	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
 	unsigned long val;
-	unsigned long ret;
 
 	val = *ptr & ~RB_FLAG_MASK;
 	val |= RB_PAGE_HEAD;
 
-	ret = cmpxchg(ptr, val, (unsigned long)&new->list);
-
-	return ret == val;
+	return try_cmpxchg(ptr, &val, (unsigned long)&new->list);
 }
 
 /*
@@ -2055,7 +2052,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	retries = 10;
 	success = false;
 	while (retries--) {
-		struct list_head *head_page, *prev_page, *r;
+		struct list_head *head_page, *prev_page;
 		struct list_head *last_page, *first_page;
 		struct list_head *head_page_with_bit;
 
@@ -2073,9 +2070,8 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 		last_page->next = head_page_with_bit;
 		first_page->prev = prev_page;
 
-		r = cmpxchg(&prev_page->next, head_page_with_bit, first_page);
-
-		if (r == head_page_with_bit) {
+		if (try_cmpxchg(&prev_page->next,
+				&head_page_with_bit, first_page)) {
 			/*
 			 * yay, we replaced the page pointer to our new list,
 			 * now, we just have to update to head page's prev
@@ -4061,10 +4057,10 @@ void ring_buffer_record_off(struct trace_buffer *buffer)
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
 
@@ -4084,10 +4080,10 @@ void ring_buffer_record_on(struct trace_buffer *buffer)
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

