Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED46F6155F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKAXL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiKAXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C851222B8;
        Tue,  1 Nov 2022 16:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808A16177D;
        Tue,  1 Nov 2022 23:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE77C433D6;
        Tue,  1 Nov 2022 23:10:11 +0000 (UTC)
Date:   Tue, 1 Nov 2022 19:10:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Roland Ruckerbauer <roland.rucky@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, regressions@lists.linux.dev,
        Steven Noonan <steven.noonan@gmail.com>
Subject: [PATCH] ring-buffer: Check for NULL cpu_buffer in
 ring_buffer_wake_waiters()
Message-ID: <20221101191009.1e7378c8@rorschach.local.home>
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

On some machines the number of listed CPUs may be bigger than the actual
CPUs that exist. The tracing subsystem allocates a per_cpu directory with
access to the per CPU ring buffer via a cpuX file. But to save space, the
ring buffer will only allocate buffers for online CPUs, even though the
CPU array will be as big as the nr_cpu_ids.

With the addition of waking waiters on the ring buffer when closing the
file, the ring_buffer_wake_waiters() now needs to make sure that the
buffer is allocated (with the irq_work allocated with it) before trying to
wake waiters, as it will cause a NULL pointer dereference.

While debugging this, I added a NULL check for the buffer itself (which is
OK to do), and also NULL pointer checks against buffer->buffers (which is
not fine, and will WARN) as well as making sure the CPU number passed in
is within the nr_cpu_ids (which is also not fine if it isn't).

Link: https://lore.kernel.org/all/87h6zklb6n.wl-tiwai@suse.de/
Link: https://lore.kernel.org/all/CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com/

Cc: stable@vger.kernel.org
Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1204705
Reported-by: Takashi Iwai <tiwai@suse.de>
Reported-by: Roland Ruckerbauer <roland.rucky@gmail.com>
Fixes: f3ddb74ad079 ("tracing: Wake up ring buffer waiters on closing of the file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 199759c73519..9712083832f4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -937,6 +937,9 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct rb_irq_work *rbwork;
 
+	if (!buffer)
+		return;
+
 	if (cpu == RING_BUFFER_ALL_CPUS) {
 
 		/* Wake up individual ones too. One level recursion */
@@ -945,7 +948,15 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 
 		rbwork = &buffer->irq_work;
 	} else {
+		if (WARN_ON_ONCE(!buffer->buffers))
+			return;
+		if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+			return;
+
 		cpu_buffer = buffer->buffers[cpu];
+		/* The CPU buffer may not have been initialized yet */
+		if (!cpu_buffer)
+			return;
 		rbwork = &cpu_buffer->irq_work;
 	}
 
-- 
2.35.1

