Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789536A9A76
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjCCPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjCCPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:17:38 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA8E12843;
        Fri,  3 Mar 2023 07:17:34 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f13so11660961edz.6;
        Fri, 03 Mar 2023 07:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dod82Ac00yzfmr49adYbT857eFos3GriXXh7hPUNHcA=;
        b=OvUr22kHGeqMI29mcUF1vALz6FRHQJjs5bG/wZL6WpQuKfWsIsgB8zpF8UXCm9JdBm
         6vYwhgrAm97zDRefgty/4iIjnOnEmTefy91Ojcf2nYjkJhGyVSc3JoKXOxZKsAUfPUpt
         hK0NGX6PBc3iTya4zOsNMMfKM/H2SEwiJhj4OtLOBcM5np9UN1YE7P1YElf9QFIfqs4A
         L/Gbdr1e72Ur0TJCls+YapltBHVhKz17BY9Fc7ENj3ARzR6yq9Q3HlOliPzhLkTMpq5T
         /xcjBH12JjL2awWB2YuQXwK4ZwZLf2uFmNl+Jj9f4DQOS2HVGeIGEyf9CtUDj9mQphjk
         eAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dod82Ac00yzfmr49adYbT857eFos3GriXXh7hPUNHcA=;
        b=bAIvT1IY27/9ldNF0w36hmGNvWR0ee/UE/indL670iDdgmWkEHdrRQKLkcyk9F3xsO
         9/a+nIAco7xKTi0dCaFQMxCrDSpDHpfQ5mBQCFgz+If/0hIV+MLMD6JigNVP0dByPldP
         1P3YM9NNGaxLtQJe02GjGzDEixEAswJRp9/uVDkWkEH39yTHG1bDdr4Bsr8Dab3oDjLZ
         kispJz1/44+mc3/5AsIfFaOZN4AdLOVbFy1FJuHoAAIJnx/7mX34gFOLmjvFgC3GatUy
         qnd64yyFPfGOhe+nWftEPbZR5f68uG+YDR4eSEfYIAuFYo2IK8VpKFOUrWatnA1W3api
         9FSw==
X-Gm-Message-State: AO0yUKU3pY0kNOUmXHq3Xid7KFOvNXqA6pTEu6w7WT5I5RhZJy//eXGg
        6benmJODBlb4gGmZrhTmKmwThvgmDbGAdA==
X-Google-Smtp-Source: AK7set9mqgdS29xJ1E2F6mHSYU9HodjW4CTmGwMKNYRb6+IdQ9Jp2ywr3i735BXvcYJLoyc+98zwJg==
X-Received: by 2002:a17:907:9c04:b0:8a5:8620:575 with SMTP id ld4-20020a1709079c0400b008a586200575mr2245327ejc.3.1677856652944;
        Fri, 03 Mar 2023 07:17:32 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o13-20020a1709062e8d00b008e22978b98bsm1048390eji.61.2023.03.03.07.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:17:32 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 2/3] ring_buffer: Change some static functions to bool
Date:   Fri,  3 Mar 2023 16:17:05 +0100
Message-Id: <20230303151706.57851-3-ubizjak@gmail.com>
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

The return values of some functions are of boolean type. Change the
type of these function to bool and adjust their return values. Also
change type of some internal varibles to bool.

No functional change intended.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v3: Rearrange variable declarations.
---
 kernel/trace/ring_buffer.c | 47 ++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05fdc92554df..71df857242b4 100644
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

