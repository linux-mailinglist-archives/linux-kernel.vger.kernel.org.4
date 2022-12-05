Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F3964256D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiLEJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLEJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:07:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8AAE4B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:06:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425DB60FD6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D44C433C1;
        Mon,  5 Dec 2022 09:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670231180;
        bh=uCqi1VQs0AX+nWokczgoH16emnztz18Am57iF1FWv8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IGZ7R4vW6fpA9iDMWwdQKQcgUvl/gl4w3GVQegnGNehm8AzdAWHt5TKxSF2xDuIkx
         +QDhVoXXpMGgDCUmsrzujM/fr4zcmhDgh4kDR1sh2S8g4hHual5qd2iYcK8FogFLgt
         r1T38Bc2mSlcisq7/DPiTHB2jzYpCWUccK4Z6BcIJ9eiPM7tBp5fNUJoYbdIes5Wi6
         scXGS7OTq9p0ywYRxtD4cFgaR8JE5ehUBrJomGbQZy7c/tNlDV5iyae2+VYfm93Vsp
         WcK8Mq+PoTGRR22St88qPm6Y8OpHz/EOtP+bqAXI+xhwnEpAqsyN8AGwMxFBH36XoE
         0lPFEj9rz7puA==
Date:   Mon, 5 Dec 2022 18:06:17 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
Message-Id: <20221205180617.9b9d3971cbe06ee536603523@kernel.org>
In-Reply-To: <276025.1670228915@warthog.procyon.org.uk>
References: <20221205123200.51539846cb9dd9dc158cc871@kernel.org>
        <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
        <276025.1670228915@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2022 08:28:35 +0000
David Howells <dhowells@redhat.com> wrote:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > +#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
> > >  static const struct file_operations tracing_max_lat_fops;
> > > +#endif
> > 
> > Oops, I missed this part. Why did you introduced this #ifdefs?
> 
> Because:
> 
>     #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>     static const struct file_operations tracing_max_lat_fops = {
> 
> in the same file.  You get something like an unused symbol warning otherwise
> if neither config option is defined.

Yeah, I got it. Without the above change, the compile error will be gone,
but this means that the declaration becomes a definition. (it uses an empty
data structure)

Could you remove that part from your printf checker macro, and
apply the below patch?
Since the printf macros are a kind of improvement but this part is an
actual bug, need to be fixed on stable kernel too.


From 2e993ec80d864677fd42d27f9d4ee01d7e63f8a4 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Mon, 5 Dec 2022 14:27:00 +0900
Subject: [PATCH] tracing: Fix complicated dependency of
 CONFIG_TRACER_MAX_TRACE

Both CONFIG_OSNOISE_TRACER and CONFIG_HWLAT_TRACER partially enables the
CONFIG_TRACER_MAX_TRACE code, but that is complicated and has
introduced a bug; It declares tracing_max_lat_fops data structure outside
of #ifdefs, but since it is defined only when CONFIG_TRACER_MAX_TRACE=y
or CONFIG_HWLAT_TRACER=y, if only CONFIG_OSNOISE_TRACER=y, that
declaration comes to a definition(!).

To fix this issue, and do not repeat the similar problem, makes
CONFIG_OSNOISE_TRACER and CONFIG_HWLAT_TRACER enables the
CONFIG_TRACER_MAX_TRACE always. It has there benefits;
- Fix the tracing_max_lat_fops bug
- Simplify the #ifdefs
- CONFIG_TRACER_MAX_TRACE code is fully enabled, or not.

Fixes: 424b650f35c7 ("tracing: Fix missing osnoise tracer on max_latency")
Cc: stable@vger.kernel.org
Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/Kconfig |  2 ++
 kernel/trace/trace.c | 15 ++++++++-------
 kernel/trace/trace.h |  8 +++-----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e9e95c790b8e..93d724996283 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -375,6 +375,7 @@ config SCHED_TRACER
 config HWLAT_TRACER
 	bool "Tracer to detect hardware latencies (like SMIs)"
 	select GENERIC_TRACER
+	select TRACER_MAX_TRACE
 	help
 	 This tracer, when enabled will create one or more kernel threads,
 	 depending on what the cpumask file is set to, which each thread
@@ -410,6 +411,7 @@ config HWLAT_TRACER
 config OSNOISE_TRACER
 	bool "OS Noise tracer"
 	select GENERIC_TRACER
+	select TRACER_MAX_TRACE
 	help
 	  In the context of high-performance computing (HPC), the Operating
 	  System Noise (osnoise) refers to the interference experienced by an
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5cfc95a52bc3..08033347df2c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1692,6 +1692,8 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 }
 
 unsigned long __read_mostly	tracing_thresh;
+
+#ifdef CONFIG_TRACER_MAX_TRACE
 static const struct file_operations tracing_max_lat_fops;
 
 #ifdef LATENCY_FS_NOTIFY
@@ -1748,18 +1750,14 @@ void latency_fsnotify(struct trace_array *tr)
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
 
-#elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)	\
-	|| defined(CONFIG_OSNOISE_TRACER)
+#else /* !LATENCY_FS_NOTIFY */
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
 			  d_tracer, &tr->max_latency, &tracing_max_lat_fops)
 
-#else
-#define trace_create_maxlat_file(tr, d_tracer)	 do { } while (0)
 #endif
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 /*
  * Copy the new maximum trace into the separate maximum-trace
  * structure. (this way the maximum trace is permanently saved,
@@ -1888,6 +1886,7 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	__update_max_tr(tr, tsk, cpu);
 	arch_spin_unlock(&tr->max_lock);
 }
+
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
@@ -6572,7 +6571,7 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
 	return ret;
 }
 
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
+#ifdef CONFIG_TRACER_MAX_TRACE
 
 static ssize_t
 tracing_max_lat_read(struct file *filp, char __user *ubuf,
@@ -7587,7 +7586,7 @@ static const struct file_operations tracing_thresh_fops = {
 	.llseek		= generic_file_llseek,
 };
 
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
+#ifdef CONFIG_TRACER_MAX_TRACE
 static const struct file_operations tracing_max_lat_fops = {
 	.open		= tracing_open_generic,
 	.read		= tracing_max_lat_read,
@@ -9601,7 +9600,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
+#ifdef CONFIG_TRACER_MAX_TRACE
 	trace_create_maxlat_file(tr, d_tracer);
+#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d42e24507152..8b69698780a1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -308,8 +308,7 @@ struct trace_array {
 	struct array_buffer	max_buffer;
 	bool			allocated_snapshot;
 #endif
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
-	|| defined(CONFIG_OSNOISE_TRACER)
+#ifdef CONFIG_TRACER_MAX_TRACE
 	unsigned long		max_latency;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
@@ -688,12 +687,11 @@ void update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 		   void *cond_data);
 void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
-#endif /* CONFIG_TRACER_MAX_TRACE */
 
-#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
-	|| defined(CONFIG_OSNOISE_TRACER)) && defined(CONFIG_FSNOTIFY)
+#ifdef CONFIG_FSNOTIFY
 #define LATENCY_FS_NOTIFY
 #endif
+#endif /* CONFIG_TRACER_MAX_TRACE */
 
 #ifdef LATENCY_FS_NOTIFY
 void latency_fsnotify(struct trace_array *tr);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
