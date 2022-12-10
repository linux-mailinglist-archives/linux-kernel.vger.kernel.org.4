Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8215B648F14
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLJN7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiLJN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E518E0A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF6D60C2B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A47C433F0;
        Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40N0-000kvr-2y;
        Sat, 10 Dec 2022 08:58:26 -0500
Message-ID: <20221210135826.783518244@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:58:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 23/25] tracing/osnoise: Add PANIC_ON_STOP option
References: <20221210135750.425719934@goodmis.org>
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

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Often the latency observed in a CPU is not caused by the work being done
in the CPU itself, but by work done on another CPU that causes the
hardware to stall all CPUs. In this case, it is interesting to know
what is happening on ALL CPUs, and the best way to do this is via
crash dump analysis.

Add the PANIC_ON_STOP option to osnoise/timerlat tracers. The default
behavior is having this option off. When enabled by the user, the system
will panic after hitting a stop tracing condition.

This option was motivated by a real scenario that Juri Lelli and I
were debugging.

Link: https://lkml.kernel.org/r/249ce4287c6725543e6db845a6e0df621dc67db5.1670623111.git.bristot@kernel.org

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 8ba82c71268f..5a7613942223 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -54,10 +54,11 @@
 enum osnoise_options_index {
 	OSN_DEFAULTS = 0,
 	OSN_WORKLOAD,
+	OSN_PANIC_ON_STOP,
 	OSN_MAX
 };
 
-static const char * const osnoise_options_str[OSN_MAX] = { "DEFAULTS", "OSNOISE_WORKLOAD" };
+static const char * const osnoise_options_str[OSN_MAX] = { "DEFAULTS", "OSNOISE_WORKLOAD", "PANIC_ON_STOP" };
 
 #define OSN_DEFAULT_OPTIONS		0x2
 static unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
@@ -1270,6 +1271,9 @@ static __always_inline void osnoise_stop_tracing(void)
 		trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
 				"stop tracing hit on cpu %d\n", smp_processor_id());
 
+		if (test_bit(OSN_PANIC_ON_STOP, &osnoise_options))
+			panic("tracer hit stop condition on CPU %d\n", smp_processor_id());
+
 		tracer_tracing_off(tr);
 	}
 	rcu_read_unlock();
-- 
2.35.1


