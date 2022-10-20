Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459FB606274
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJTOHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJTOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:07:01 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 005D017F2B6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:06:58 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:57690.1101889674
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-111.162.158.155 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 53D711001F5;
        Thu, 20 Oct 2022 22:06:55 +0800 (CST)
Received: from  ([111.162.158.155])
        by gateway-153622-dep-787c977d48-59pdt with ESMTP id ca9f54f5c31540bf998ead0613fb6c18 for rostedt@goodmis.org;
        Thu, 20 Oct 2022 22:06:56 CST
X-Transaction-ID: ca9f54f5c31540bf998ead0613fb6c18
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 111.162.158.155
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, xiehuan09@gmail.com,
        Song Chen <chensong_2000@189.cn>
Subject: [PATCH] trace/ring_buffer: remove unused arguments
Date:   Thu, 20 Oct 2022 22:06:51 +0800
Message-Id: <1666274811-24138-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a argument, event has nothing to do with either
ring_buffer_unlock_commit or rb_commit and cleaning
it up has no side effect.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 include/linux/ring_buffer.h          |  3 +--
 kernel/trace/ring_buffer.c           | 12 +++++-------
 kernel/trace/ring_buffer_benchmark.c |  2 +-
 kernel/trace/trace.c                 |  2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index dac53fd3afea..a1483e5dd846 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -113,8 +113,7 @@ void ring_buffer_change_overwrite(struct trace_buffer *buffer, int val);
 
 struct ring_buffer_event *ring_buffer_lock_reserve(struct trace_buffer *buffer,
 						   unsigned long length);
-int ring_buffer_unlock_commit(struct trace_buffer *buffer,
-			      struct ring_buffer_event *event);
+int ring_buffer_unlock_commit(struct trace_buffer *buffer);
 int ring_buffer_write(struct trace_buffer *buffer,
 		      unsigned long length, void *data);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d59b6a328b7f..fbadfeff6542 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3088,8 +3088,7 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
 		event->time_delta = 1;
 }
 
-static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
-		      struct ring_buffer_event *event)
+static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	local_inc(&cpu_buffer->entries);
 	rb_end_commit(cpu_buffer);
@@ -3298,15 +3297,14 @@ void ring_buffer_nest_end(struct trace_buffer *buffer)
  *
  * Must be paired with ring_buffer_lock_reserve.
  */
-int ring_buffer_unlock_commit(struct trace_buffer *buffer,
-			      struct ring_buffer_event *event)
+int ring_buffer_unlock_commit(struct trace_buffer *buffer)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	int cpu = raw_smp_processor_id();
 
 	cpu_buffer = buffer->buffers[cpu];
 
-	rb_commit(cpu_buffer, event);
+	rb_commit(cpu_buffer);
 
 	rb_wakeups(buffer, cpu_buffer);
 
@@ -3892,7 +3890,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
 
 	memcpy(body, data, length);
 
-	rb_commit(cpu_buffer, event);
+	rb_commit(cpu_buffer);
 
 	rb_wakeups(buffer, cpu_buffer);
 
@@ -5877,7 +5875,7 @@ static __init int rb_write_something(struct rb_test_data *data, bool nested)
 	}
 
  out:
-	ring_buffer_unlock_commit(data->buffer, event);
+	ring_buffer_unlock_commit(data->buffer);
 
 	return 0;
 }
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 78e576575b79..aef34673d79d 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -258,7 +258,7 @@ static void ring_buffer_producer(void)
 				hit++;
 				entry = ring_buffer_event_data(event);
 				*entry = smp_processor_id();
-				ring_buffer_unlock_commit(buffer, event);
+				ring_buffer_unlock_commit(buffer);
 			}
 		}
 		end_time = ktime_get();
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 31dd208a3d4e..d79d1a341f38 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -999,7 +999,7 @@ __buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *ev
 		/* ring_buffer_unlock_commit() enables preemption */
 		preempt_enable_notrace();
 	} else
-		ring_buffer_unlock_commit(buffer, event);
+		ring_buffer_unlock_commit(buffer);
 }
 
 /**
-- 
2.25.1

