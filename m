Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F6E63DD10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiK3SV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiK3SUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:20:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0638BD06;
        Wed, 30 Nov 2022 10:19:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83F78CE1ACD;
        Wed, 30 Nov 2022 18:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EEAC43470;
        Wed, 30 Nov 2022 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832359;
        bh=UofQ2Om5TKKPZw19SG+8wKH8TntN+ojXWrOiFhpkAis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMMfsAceNIPA7SVzZd9xgHyYxzJcdYfpp9vfAK/FLUt8535HDUNnn3noVhN0M1G7D
         fOMtP0q8tDdeTome2UAGMdiwTGteRyuhJ/O2bVmzXbM0PSLpkxQi6dcyFtfbdSnAF5
         T/fSXL441rkM7QD9tGFQ0Pv/NuvtEADFGpvnH5mAXk1e/tXMvzo59uqxCdeBZiffRR
         1clWQTueMTNBqloHGE0Ccpkeb2q/I0fUXWfwE1lUrzokBPy7xzu2zPxL8i/fTaNPPl
         xDVxNl8T4GNj0smUjuAmWKwPP4nyd1S5NYxABS3Yol1YqMkbnl2MsTxbTV5b4fjkDo
         PomzbCOX1HSDQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] tracing/osnoise: Add PANIC_ON_STOP option
Date:   Wed, 30 Nov 2022 19:19:09 +0100
Message-Id: <249ce4287c6725543e6db845a6e0df621dc67db5.1669832184.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1669832184.git.bristot@kernel.org>
References: <cover.1669832184.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 3f10dd1f2f1c..801eba0b5cf8 100644
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
 
 #define OSN_DEFAULT_OPTIONS	0x2
 unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
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
2.32.0

