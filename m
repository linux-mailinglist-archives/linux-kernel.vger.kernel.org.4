Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81FB637BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiKXOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKXOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:51:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213001369C2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AB3DB8284F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CADC433D6;
        Thu, 24 Nov 2022 14:50:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYs-001X42-0S;
        Thu, 24 Nov 2022 09:50:46 -0500
Message-ID: <20221124145046.017356789@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Chen <chensong_2000@189.cn>
Subject: [for-next][PATCH 04/11] ring_buffer: Remove unused "event" parameter
References: <20221124145019.782980678@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Chen <chensong_2000@189.cn>

After commit a389d86f7fd0 ("ring-buffer: Have nested events still record
running time stamp"), the "event" parameter is no longer used in either
ring_buffer_unlock_commit() or rb_commit(). Best to remove it.

Link: https://lkml.kernel.org/r/1666274811-24138-1-git-send-email-chensong_2000@189.cn

Signed-off-by: Song Chen <chensong_2000@189.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h          |  3 +--
 kernel/trace/ring_buffer.c           | 12 +++++-------
 kernel/trace/ring_buffer_benchmark.c |  2 +-
 kernel/trace/trace.c                 |  2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 3c7d295746f6..782e14f62201 100644
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
index b21bf14bae9b..843818ee4814 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3180,8 +3180,7 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
 		event->time_delta = 1;
 }
 
-static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
-		      struct ring_buffer_event *event)
+static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	local_inc(&cpu_buffer->entries);
 	rb_end_commit(cpu_buffer);
@@ -3383,15 +3382,14 @@ void ring_buffer_nest_end(struct trace_buffer *buffer)
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
 
@@ -3977,7 +3975,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
 
 	memcpy(body, data, length);
 
-	rb_commit(cpu_buffer, event);
+	rb_commit(cpu_buffer);
 
 	rb_wakeups(buffer, cpu_buffer);
 
@@ -5998,7 +5996,7 @@ static __init int rb_write_something(struct rb_test_data *data, bool nested)
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
index 5cfc95a52bc3..5c97dbef741b 100644
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
2.35.1


