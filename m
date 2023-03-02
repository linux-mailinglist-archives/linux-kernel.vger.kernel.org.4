Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883BD6A8708
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCBQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCBQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:41:56 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB689D312;
        Thu,  2 Mar 2023 08:41:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy23so1050393edb.12;
        Thu, 02 Mar 2023 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677775313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqjyz7XpRqD7AGnx5mr4UeTlubc91jtSFlPOIv5ZSYs=;
        b=EipIhgHyCrIdtNgB3hn14ywBakEdEil54kFMcclD3haJO0nHs9+/wxUvtLEPa6TRxu
         /n4F3obFuRvF49N2Avo7BEm44jkOx+Dyyh8b4UIMj1O82qEqL62qS9x9XQU0jJ8AVkGl
         LgtliFk6LOL6wVFwOvwSxfnYpZlr4nOgh+wS54jaG73QH6VlgRtQj8B9mq3o1bXqF8HY
         Up4luTAUpY/s51R2O7uRuiJKbgRc95an+CZNhwJN+Mc/j6NEnBWHfW/kBv6FwWVxYunq
         Lom86fAkzsSAgqp8w61QlXnrOBeAYfsV9vryJSzZoZKElkHIeZorsFzlLFszbNmGSfhg
         syig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677775313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqjyz7XpRqD7AGnx5mr4UeTlubc91jtSFlPOIv5ZSYs=;
        b=7j/ULMN6qcH4BIVVeH519ovjki8WrnKPE8bUIvRIGLNIkc3aOB6KOkZRgjtCZFbR9x
         ktI+hgmuG1S8p1VPeM/YaWNCSzbtl0f5up05roewjYZj5ZPR/XtLYoirTkb9NoZ3TBES
         CUyeKLgEhA7GyX18uVLTaSR3unQ2k675m+wik4P3jrXvMdrd/yunKtVHGuToGCfXj/xl
         QBQvHzw4O4dsVp9G6zloPK6PHku1rhi9dkGWtepLlF5Un/VOf3bSI4tQgL9AVJG1q0ky
         tQpxSXxfe6NvEQpK8O4mkmyCVRaZ27CKXOOiecaTd5p9P0lGkUATRCww8dHJL3Ba8Y4d
         0wiQ==
X-Gm-Message-State: AO0yUKWg1A2zfUcb7/WlkAgge9kXYKGDdiyWY1eTPvzcD8SYsQQXFTv6
        /3Jjt67As7P6+FLUycpN3tgfutWj3lVZfQ==
X-Google-Smtp-Source: AK7set9z4ij1ktI5b4PKsRCPbMZoORsQ0U8Gpzi0rSY4UQbb+TpmBQMvbTDVEvtYIbyGmeX3JMcAlg==
X-Received: by 2002:a17:906:a16:b0:8e0:4baf:59bb with SMTP id w22-20020a1709060a1600b008e04baf59bbmr9932381ejf.22.1677775312701;
        Thu, 02 Mar 2023 08:41:52 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a22-20020a170906191600b008c327bef167sm7230998eje.7.2023.03.02.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:41:52 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 2/3] ring_buffer: Change some static functions to bool
Date:   Thu,  2 Mar 2023 17:41:28 +0100
Message-Id: <20230302164129.4862-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302164129.4862-1-ubizjak@gmail.com>
References: <20230302164129.4862-1-ubizjak@gmail.com>
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
---
 kernel/trace/ring_buffer.c | 47 ++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05fdc92554df..4188af7d4cfe 100644
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
+	int retries;
 	unsigned long flags;
+	bool success;
 
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
@@ -5408,9 +5407,8 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
-	bool dolock;
+	bool dolock, ret;
 	int cpu;
-	int ret;
 
 	/* yes this is racy, but if you don't like the race, lock the buffer */
 	for_each_buffer_cpu(buffer, cpu) {
@@ -5438,8 +5436,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
-	bool dolock;
-	int ret;
+	bool dolock, ret;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return true;
-- 
2.39.2

