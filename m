Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0526C731007
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244547AbjFOHBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbjFOHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFB1720
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686812451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZl5IePXwMxAc+yncc6R0RiTzMx0XP4ndlclonASOGI=;
        b=KozAFdaiE/+cDXu6R5WCaZ49HZmR1M8ePvTpoAPU21W9tT1ir74mlpMRYwrE+6h51yuOP/
        Ff3lyeKvFu3EY3Fsdi21BO2WtID/II9mbjfKQQnzVMdR8yFDVPWpd8FQ8EpwTpuPZ+pOv0
        Hz+k2ou7YNgUtb1+VEkKffW/llCRuX4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-_iXHRncOODeo98XF-K2tbA-1; Thu, 15 Jun 2023 03:00:49 -0400
X-MC-Unique: _iXHRncOODeo98XF-K2tbA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1a36fa3850dso4581533fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686812448; x=1689404448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZl5IePXwMxAc+yncc6R0RiTzMx0XP4ndlclonASOGI=;
        b=SUM4sfFcGvzNne13U9yzViB2bNHhAeHmmABM+p2vp2yDQzvG37ECmt0XMqqEF84r7R
         WgVRXdQAEaDRcKcO1ZqP5kZPM5gUdskZL+5dSWF8P1ynWuCtBXSkOw+ZLh0ZMosJswzn
         LGJVsWQGKZCUS75X+Oq52GgxZ0TiSOCOllIhqIZTc6UocR55nJnRhHJ/o14nk7IylYbH
         vDpWo1ZkAljeHYKDBuULvGh8ljr7S/JM2Uh68y3CzDsGTPGinhQV/Ot3wrS25QevXUt4
         fAzKx4F0Pj3Vne9TI1x/b1EISZ+21hLncPzSF4Y+oe1ZyVlroPMqEIHRxvyE7AqeunoX
         OM+A==
X-Gm-Message-State: AC+VfDyOfcNX4KnOstLBtRr9YJlfWn+VsqX5Yvxz3GcDvA8CyIkYJDWG
        1xksuUkoi49qHFFKimx37qc0ud1n3tj5KtmjsivFKZPextpn/8VDfyYBOpAX2yFu0Ey4GslGvov
        /wcORcB8Cn+pBjgLIJJqWtBhG
X-Received: by 2002:a05:6870:e896:b0:19f:6fae:d5fc with SMTP id q22-20020a056870e89600b0019f6faed5fcmr10541232oan.33.1686812448502;
        Thu, 15 Jun 2023 00:00:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RTn4EVzEzJIlR5WDuNxNcCA8RtViRGRXrf6wQXuxD0HoRgO8I/0CdFEYSCfLpGO8E99u/Bg==
X-Received: by 2002:a05:6870:e896:b0:19f:6fae:d5fc with SMTP id q22-20020a056870e89600b0019f6faed5fcmr10541218oan.33.1686812448256;
        Thu, 15 Jun 2023 00:00:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:60ac:48e:4eb0:11b4:f1e8])
        by smtp.gmail.com with ESMTPSA id d4-20020a0568301b6400b006b2b51fd2ebsm6472317ote.81.2023.06.15.00.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:00:47 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v5 2/2] trace,smp: Add tracepoints for scheduling remotelly called functions
Date:   Thu, 15 Jun 2023 03:59:47 -0300
Message-ID: <20230615065944.188876-7-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615065944.188876-3-leobras@redhat.com>
References: <20230615065944.188876-3-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint for when a CSD is queued to a remote CPU's
call_single_queue. This allows finding exactly which CPU queued a given CSD
when looking at a csd_function_{entry,exit} event, and also enables us to
accurately measure IPI delivery time with e.g. a synthetic event:

  $ echo 'hist:keys=cpu,csd.hex:ts=common_timestamp.usecs' >\
      /sys/kernel/tracing/events/smp/csd_queue_cpu/trigger
  $ echo 'csd_latency unsigned int dst_cpu; unsigned long csd; u64 time' >\
      /sys/kernel/tracing/synthetic_events
  $ echo \
  'hist:keys=common_cpu,csd.hex:'\
  'time=common_timestamp.usecs-$ts:'\
  'onmatch(smp.csd_queue_cpu).trace(csd_latency,common_cpu,csd,$time)' >\
      /sys/kernel/tracing/events/smp/csd_function_entry/trigger

  $ trace-cmd record -e 'synthetic:csd_latency' hackbench
  $ trace-cmd report
  <...>-467   [001]    21.824263: csd_queue_cpu:        cpu=0 callsite=try_to_wake_up+0x2ea func=sched_ttwu_pending csd=0xffff8880076148b8
  <...>-467   [001]    21.824280: ipi_send_cpu:         cpu=0 callsite=try_to_wake_up+0x2ea callback=generic_smp_call_function_single_interrupt+0x0
  <...>-489   [000]    21.824299: csd_function_entry:   func=sched_ttwu_pending csd=0xffff8880076148b8
  <...>-489   [000]    21.824320: csd_latency:          dst_cpu=0, csd=18446612682193848504, time=36

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/trace/events/csd.h | 27 +++++++++++++++++++++++++++
 kernel/smp.c               | 16 +++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/csd.h b/include/trace/events/csd.h
index af1df5200ae6..67e9d01f80c2 100644
--- a/include/trace/events/csd.h
+++ b/include/trace/events/csd.h
@@ -7,6 +7,33 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(csd_queue_cpu,
+
+	TP_PROTO(const unsigned int cpu,
+		unsigned long callsite,
+		smp_call_func_t func,
+		struct __call_single_data *csd),
+
+	TP_ARGS(cpu, callsite, func, csd),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu)
+		__field(void *, callsite)
+		__field(void *, func)
+		__field(void *, csd)
+		),
+
+	    TP_fast_assign(
+		__entry->cpu = cpu;
+		__entry->callsite = (void *)callsite;
+		__entry->func = func;
+		__entry->csd  = csd;
+		),
+
+	TP_printk("cpu=%u callsite=%pS func=%ps csd=%p",
+		__entry->cpu, __entry->callsite, __entry->func, __entry->csd)
+	);
+
 /*
  * Tracepoints for a function which is called as an effect of smp_call_function.*
  */
diff --git a/kernel/smp.c b/kernel/smp.c
index 7199b5a22043..692dbb400701 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -340,7 +340,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
 	 * executes migration_cpu_stop() on the remote CPU).
 	 */
-	if (trace_ipi_send_cpu_enabled()) {
+	if (trace_csd_queue_cpu_enabled()) {
 		call_single_data_t *csd;
 		smp_call_func_t func;
 
@@ -348,7 +348,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
 			sched_ttwu_pending : csd->func;
 
-		trace_ipi_send_cpu(cpu, _RET_IP_, func);
+		trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
 	}
 
 	/*
@@ -741,7 +741,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
 	bool wait = scf_flags & SCF_WAIT;
-	int nr_cpus = 0, nr_queued = 0;
+	int nr_cpus = 0;
 	bool run_remote = false;
 	bool run_local = false;
 
@@ -799,21 +799,15 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->node.src = smp_processor_id();
 			csd->node.dst = cpu;
 #endif
+			trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
+
 			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
 				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 				nr_cpus++;
 				last_cpu = cpu;
 			}
-			nr_queued++;
 		}
 
-		/*
-		 * Trace each smp_function_call_*() as an IPI, actual IPIs
-		 * will be traced with func==generic_smp_call_function_single_ipi().
-		 */
-		if (nr_queued)
-			trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, func);
-
 		/*
 		 * Choose the most efficient way to send an IPI. Note that the
 		 * number of CPUs might be zero due to concurrent changes to the
-- 
2.41.0

