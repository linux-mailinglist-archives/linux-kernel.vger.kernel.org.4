Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11C8648A91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLIWHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiLIWGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:06:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80AA5DE8;
        Fri,  9 Dec 2022 14:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2024FB8293F;
        Fri,  9 Dec 2022 22:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5C5C433F0;
        Fri,  9 Dec 2022 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670623564;
        bh=UofQ2Om5TKKPZw19SG+8wKH8TntN+ojXWrOiFhpkAis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObcHETnV404P8FdK6dcZ3k8cwnJHWj53iKrb8qBFv+KV9vFx/MNCY2VlnIl83fRKX
         GkKtSBij7bMDEosyNGwu6dQD9rFbWG8/zfZ9xnYxm3uSF+DjZ1AimX5Pf1ABAConF9
         uoaqG0+vlQqK37Vmywu34eMmUPsWdgcX6EBf3ZK/DWcZu1niXdTyKMeSB6pkrCsbNj
         yC2M4FAI3ea5riv5qgcHam52q6lcjNFL0KfpZ8zTUH9mzcz5duwFKhmmkj7nIorpZL
         O/rDF/8H8ALoiCLsi17zMbOPm/R9IV5fXqIOu11020UPUk6hylNouVg7cHsdsLim3t
         0yLa1Eot8ov1w==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/3] tracing/osnoise: Add PANIC_ON_STOP option
Date:   Fri,  9 Dec 2022 23:05:52 +0100
Message-Id: <249ce4287c6725543e6db845a6e0df621dc67db5.1670623111.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1670623111.git.bristot@kernel.org>
References: <cover.1670623111.git.bristot@kernel.org>
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

