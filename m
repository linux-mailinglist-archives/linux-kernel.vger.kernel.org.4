Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201015EF6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiI2Nt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiI2NtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:49:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFB14D30A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6738360F6F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A79FC433C1;
        Thu, 29 Sep 2022 13:49:17 +0000 (UTC)
Date:   Thu, 29 Sep 2022 09:50:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] tracing: Add ioctl() to force ring buffer waiters to
 wake up
Message-ID: <20220929095029.117f913f@gandalf.local.home>
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

If a process is waiting on the ring buffer for data, there currently isn't
a clean way to force it to wake up. Add an ioctl call that will force any
tasks that are waiting on the trace_pipe_raw file to wake up.

Cc: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: e30f53aad2202 ("tracing: Do not busy wait in buffer splice")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lkml.kernel.org/r/20220927231825.685473208@goodmis.org
 - Only wake up on cmd == 0

 kernel/trace/trace.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e101b0764b39..58afc83afc9d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8349,12 +8349,34 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
+/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
+static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ftrace_buffer_info *info = file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	if (cmd)
+		return -ENOIOCTLCMD;
+
+	mutex_lock(&trace_types_lock);
+
+	iter->wait_index++;
+	/* Make sure the waiters see the new wait_index */
+	smp_wmb();
+
+	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
+
+	mutex_unlock(&trace_types_lock);
+	return 0;
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
 	.poll		= tracing_buffers_poll,
 	.release	= tracing_buffers_release,
 	.splice_read	= tracing_buffers_splice_read,
+	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
 };
 
-- 
2.35.1

