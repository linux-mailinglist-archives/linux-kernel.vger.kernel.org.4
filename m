Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4876AB14A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCEPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCEPzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:55:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B914225;
        Sun,  5 Mar 2023 07:55:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u9so29094203edd.2;
        Sun, 05 Mar 2023 07:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678031751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsqhC4fOZNV/xYgcQ01M1YcWRLbPOEgnlfSmRr7BAxs=;
        b=DJ2EF2T0+pE+wlXP6xeOMbdA6F8LKU6ZzaWRdkJgJI15QmQxwLlnHVUk5D2Y76EUq9
         tZNLZqOa0iFFm9Tohtfwgs0odA+gDd+Z0soUYZZbuCjjxLEFacDLUvD5G9qvblnbS9+J
         1lfMWJJbSaHVxlAmCwSsuAXiMpNP+d/LBZZabBUEya6j76N4OzpDHUdsQI/Atj3K8HKi
         EJf8zaqCtPQiHz4vYWDZg3cjZiSEfymIgJIfvfdsCtZIS/7xs9+qqi4J/DoD3mhxNhB3
         vD6J/BgFKZWNyK+A/r1Y1miCCZrXYReXHtsDo3tVI20NujhjxnX/LDPTvCQsSL4HhVDZ
         RESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678031751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsqhC4fOZNV/xYgcQ01M1YcWRLbPOEgnlfSmRr7BAxs=;
        b=S72HG1tTYx7+Xt1DdYmMg7legXORvdhUCdgmDMd5+HBsC+leTB+2qkck6Rvbg4Y6kZ
         KpiAUkR/U4rFtkEStz1gAxu31leB4QbKgwWNEXeSZzUr8nQz2MyIUNeBvkOkQn2mNWGC
         6Q5Raezrq4O0OqCVGsFCkKrwxuMAtvxfLuI1B/l13FUsdUt0f8mpWq5upKKMfbaRtz+F
         bfKALaFx3i4yEbral+rY1Ag7AY2EKWqT6KVM6A9S1d9wNm6iPgz+R2aiNQupWQic1Y37
         dS7U4yvqiO8Tu/QjJ0tKdqbSx6d7Gk6Fxf3Fsdvnx76D5JiL2Ken0EVxdvxCnqLw8HRo
         jJgg==
X-Gm-Message-State: AO0yUKWKIj6baVEa5zUzVEQ3qJpUBTUrnkHx7i2bEfw/rUh/SKE0dshq
        U0fXIkKZhEWfpK0cKA4mHG/XFGJ+M1Sbsw==
X-Google-Smtp-Source: AK7set9qtAgFu2sM0XMPgNhHQhndpP+iP2PqCl35fksGmPCLteziJudO5oRdxKIDUkmuS1upF+zVKg==
X-Received: by 2002:a17:907:9b03:b0:8f0:9566:c1ff with SMTP id kn3-20020a1709079b0300b008f09566c1ffmr8645915ejc.69.1678031751414;
        Sun, 05 Mar 2023 07:55:51 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id pv16-20020a170907209000b009079442dd11sm3357332ejb.154.2023.03.05.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 07:55:51 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v4 2/3] ring_buffer: Change some static functions to bool
Date:   Sun,  5 Mar 2023 16:55:31 +0100
Message-Id: <20230305155532.5549-3-ubizjak@gmail.com>
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

The return values of some functions are of boolean type. Change the
type of these function to bool and adjust their return values. Also
change type of some internal varibles to bool.

No functional change intended.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
v3: Rearrange variable declarations.
v4: Change ret in rb_get_reader_page.
    Rearrange variable declarations.
---
 kernel/trace/ring_buffer.c | 47 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05fdc92554df..5235037f83d3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -163,7 +163,7 @@ enum {
 #define extended_time(event) \
 	(event->type_len >= RINGBUF_TYPE_TIME_EXTEND)
 
-static inline int rb_null_event(struct ring_buffer_event *event)
+static inline bool rb_null_event(struct ring_buffer_event *event)
 {
 	return event->type_len == RINGBUF_TYPE_PADDING && !event->time_delta;
 }
@@ -367,11 +367,9 @@ static void free_buffer_page(struct buffer_page *bpage)
 /*
  * We need to fit the time_stamp delta into 27 bits.
  */
-static inline int test_time_stamp(u64 delta)
+static inline bool test_time_stamp(u64 delta)
 {
-	if (delta & TS_DELTA_TEST)
-		return 1;
-	return 0;
+	return !!(delta & TS_DELTA_TEST);
 }
 
 #define BUF_PAGE_SIZE (PAGE_SIZE - BUF_PAGE_HDR_SIZE)
@@ -700,7 +698,7 @@ rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
 	return ret == expect;
 }
 
-static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
+static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
 	unsigned long cnt, top, bottom, msb;
 	unsigned long cnt2, top2, bottom2, msb2;
@@ -1490,7 +1488,7 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 	return NULL;
 }
 
-static int rb_head_page_replace(struct buffer_page *old,
+static bool rb_head_page_replace(struct buffer_page *old,
 				struct buffer_page *new)
 {
 	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
@@ -1917,7 +1915,7 @@ static inline unsigned long rb_page_write(struct buffer_page *bpage)
 	return local_read(&bpage->write) & RB_WRITE_MASK;
 }
 
-static int
+static bool
 rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 {
 	struct list_head *tail_page, *to_remove, *next_page;
@@ -2030,12 +2028,13 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	return nr_removed == 0;
 }
 
-static int
+static bool
 rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *pages = &cpu_buffer->new_pages;
-	int retries, success;
 	unsigned long flags;
+	bool success;
+	int retries;
 
 	/* Can be called at early boot up, where interrupts must not been enabled */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
@@ -2054,7 +2053,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	 * spinning.
 	 */
 	retries = 10;
-	success = 0;
+	success = false;
 	while (retries--) {
 		struct list_head *head_page, *prev_page, *r;
 		struct list_head *last_page, *first_page;
@@ -2083,7 +2082,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 			 * pointer to point to end of list
 			 */
 			head_page->prev = last_page;
-			success = 1;
+			success = true;
 			break;
 		}
 	}
@@ -2111,7 +2110,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 
 static void rb_update_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	int success;
+	bool success;
 
 	if (cpu_buffer->nr_pages_to_update > 0)
 		success = rb_insert_pages(cpu_buffer);
@@ -2994,7 +2993,7 @@ static u64 rb_time_delta(struct ring_buffer_event *event)
 	}
 }
 
-static inline int
+static inline bool
 rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct ring_buffer_event *event)
 {
@@ -3015,7 +3014,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 	delta = rb_time_delta(event);
 
 	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
-		return 0;
+		return false;
 
 	/* Make sure the write stamp is read before testing the location */
 	barrier();
@@ -3028,7 +3027,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		/* Something came in, can't discard */
 		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
 				       write_stamp, write_stamp - delta))
-			return 0;
+			return false;
 
 		/*
 		 * It's possible that the event time delta is zero
@@ -3061,12 +3060,12 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		if (index == old_index) {
 			/* update counters */
 			local_sub(event_length, &cpu_buffer->entries_bytes);
-			return 1;
+			return true;
 		}
 	}
 
 	/* could not discard */
-	return 0;
+	return false;
 }
 
 static void rb_start_commit(struct ring_buffer_per_cpu *cpu_buffer)
@@ -3281,7 +3280,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
  * Note: The TRANSITION bit only handles a single transition between context.
  */
 
-static __always_inline int
+static __always_inline bool
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	unsigned int val = cpu_buffer->current_context;
@@ -3298,14 +3297,14 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 		bit = RB_CTX_TRANSITION;
 		if (val & (1 << (bit + cpu_buffer->nest))) {
 			do_ring_buffer_record_recursion();
-			return 1;
+			return true;
 		}
 	}
 
 	val |= (1 << (bit + cpu_buffer->nest));
 	cpu_buffer->current_context = val;
 
-	return 0;
+	return false;
 }
 
 static __always_inline void
@@ -4534,7 +4533,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	unsigned long overwrite;
 	unsigned long flags;
 	int nr_loops = 0;
-	int ret;
+	bool ret;
 
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
@@ -5409,8 +5408,8 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
 	bool dolock;
+	bool ret;
 	int cpu;
-	int ret;
 
 	/* yes this is racy, but if you don't like the race, lock the buffer */
 	for_each_buffer_cpu(buffer, cpu) {
@@ -5439,7 +5438,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
 	bool dolock;
-	int ret;
+	bool ret;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return true;
-- 
2.39.2

