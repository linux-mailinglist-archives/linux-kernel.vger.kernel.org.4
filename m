Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA63E60B350
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiJXRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiJXRC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750C1A1B25;
        Mon, 24 Oct 2022 08:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA5236140F;
        Mon, 24 Oct 2022 15:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E7CC433C1;
        Mon, 24 Oct 2022 15:18:18 +0000 (UTC)
Date:   Mon, 24 Oct 2022 11:18:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2] ring-buffer: Include dropped pages in counting dirty
 patches
Message-ID: <20221024111829.26155c6d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function ring_buffer_nr_dirty_pages() was created to find out how many
pages are filled in the ring buffer. There's two running counters. One is
incremented whenever a new page is touched (pages_touched) and the other
is whenever a page is read (pages_read). The dirty count is the number
touched minus the number read. This is used to determine if a blocked task
should be woken up if the percentage of the ring buffer it is waiting for
is hit.

The problem is that it does not take into account dropped pages (when the
new writes overwrite pages that were not read). And then the dirty pages
will always be greater than the percentage.

Add a new counter to keep track of lost pages, and include that in the
accounting of dirty pages so that it is actually accurate.

Create a new helper function page_lost() that handles the accounting for
when a page is lost. As there are two locations that do this, it is best
to have a single function that handles it and avoids the duplicate code
that needs to be maintained.

Fixes: 2c2b0a78b3739 ("ring-buffer: Add percentage of ring buffer full to wake up reader")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lkml.kernel.org/r/20221021123013.55fb6055@gandalf.local.home

 - Add helper function page_lost() to remove duplicate code. (Masami Hiramatsu)

 kernel/trace/ring_buffer.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b60047de897e..445dbfd219f0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -519,6 +519,7 @@ struct ring_buffer_per_cpu {
 	local_t				committing;
 	local_t				commits;
 	local_t				pages_touched;
+	local_t				pages_lost;
 	local_t				pages_read;
 	long				last_pages_touch;
 	size_t				shortest_full;
@@ -894,10 +895,18 @@ size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu)
 {
 	size_t read;
+	size_t lost;
 	size_t cnt;
 
 	read = local_read(&buffer->buffers[cpu]->pages_read);
+	lost = local_read(&buffer->buffers[cpu]->pages_lost);
 	cnt = local_read(&buffer->buffers[cpu]->pages_touched);
+
+	if (WARN_ON_ONCE(cnt < lost))
+		return 0;
+
+	cnt -= lost;
+
 	/* The reader can read an empty page, but not more than that */
 	if (cnt < read) {
 		WARN_ON_ONCE(read > cnt + 1);
@@ -1924,6 +1933,14 @@ static inline unsigned long rb_page_write(struct buffer_page *bpage)
 	return local_read(&bpage->write) & RB_WRITE_MASK;
 }
 
+static __always_inline void
+page_lost(struct ring_buffer_per_cpu *cpu_buffer, int entries)
+{
+	local_add(entries, &cpu_buffer->overrun);
+	local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+	local_inc(&cpu_buffer->pages_lost);
+}
+
 static int
 rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 {
@@ -2018,8 +2035,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 			 * bytes consumed in ring buffer from here.
 			 * Increment overrun to account for the lost events.
 			 */
-			local_add(page_entries, &cpu_buffer->overrun);
-			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+			page_lost(cpu_buffer, page_entries);
 		}
 
 		/*
@@ -2502,8 +2518,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		 * it is our responsibility to update
 		 * the counters.
 		 */
-		local_add(entries, &cpu_buffer->overrun);
-		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+		page_lost(cpu_buffer, entries);
 
 		/*
 		 * The entries will be zeroed out when we move the
@@ -5254,6 +5269,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->committing, 0);
 	local_set(&cpu_buffer->commits, 0);
 	local_set(&cpu_buffer->pages_touched, 0);
+	local_set(&cpu_buffer->pages_lost, 0);
 	local_set(&cpu_buffer->pages_read, 0);
 	cpu_buffer->last_pages_touch = 0;
 	cpu_buffer->shortest_full = 0;
-- 
2.35.1

