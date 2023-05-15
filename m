Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27297703CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbjEOScP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbjEOScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8858418AA9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684175490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufrYLf3babsT3oqZ0wZvk4paQN3lMBWwcV5dtS3ah1Q=;
        b=ddy/GnIq+49gvOfVRiqKPgC3Oq2+TQq7/dnL+EkfzU6heihqgbvbiazs2xCV7Vp/vxEIOi
        nMr2WLdEV2L+jxr2/VK72bvNmBH3aWdOXOt2ETP9fdZlU1Vfg/M4iBgLMSbFf9LbRfcX+f
        IdCKc8jAmWgMSR9lOMIOBiHR6T4ZKG4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-Zx8KvWI3N9KGzAUh5Ize1Q-1; Mon, 15 May 2023 14:31:29 -0400
X-MC-Unique: Zx8KvWI3N9KGzAUh5Ize1Q-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1877e4dff8aso8561678fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684175488; x=1686767488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufrYLf3babsT3oqZ0wZvk4paQN3lMBWwcV5dtS3ah1Q=;
        b=Fflj8xqTKm5mbANTBZlFF54K1KlGIQ3GbdNVfuccKJoeG296gQHpJH50tNbkwu9m9b
         53injwDE5TOrhQC+s/mJV3uHCcBmHuvreqB/bdjOUznXChQxxNwK8tlPSbnO3Jb9Gdm1
         Ur9UplTda9KOZR2NskuYRvVL1XSjitBjPgT7Df6hs2tqYyVfR9iKqbYN0JIjj9qvOkWq
         9bEg700zETZBtFqqnU2fnXttwNvqo/bP8u6ZZpQnF5/rKx2krk4UIjnr0df/6FEhA8do
         wTEI+Wxj8Tqv40KiRLXwFTL7d1qaWGepeu2blqUjGQhOVvlfhhJ/oYzE5ySFHYJuQgDE
         lx4w==
X-Gm-Message-State: AC+VfDwr0lrFb03w2jZAxmKuHLA7h2Be5IR3VJMV6zgyeoriDDjw6KkD
        xe0jnExn0h8kbKgK3tUsNY8qYYurEMTuEKsaeoPWZba+kjVP/+qkEE8gjwIHgKX2ZTgOznXDY1n
        lkVt5CTiNCX4KiL2+m1lzj8ln
X-Received: by 2002:a05:6871:542:b0:17e:cb7:29a3 with SMTP id t2-20020a056871054200b0017e0cb729a3mr20218565oal.15.1684175488163;
        Mon, 15 May 2023 11:31:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Y4iVbZSf8VFwKfzpNfODiFE0E+amUJssftuTgUm2b+oSC3QPDreTO3rUAMSlBmnWwIp/nJw==
X-Received: by 2002:a05:6871:542:b0:17e:cb7:29a3 with SMTP id t2-20020a056871054200b0017e0cb729a3mr20218555oal.15.1684175487945;
        Mon, 15 May 2023 11:31:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id ea20-20020a056870071400b001964dc3dadesm6094075oab.45.2023.05.15.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:31:27 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v4 2/2] trace,smp: Add tracepoints for scheduling remotelly called functions
Date:   Mon, 15 May 2023 15:30:46 -0300
Message-Id: <20230515183045.654199-3-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515183045.654199-1-leobras@redhat.com>
References: <20230515183045.654199-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 include/trace/events/smp.h | 27 +++++++++++++++++++++++++++
 kernel/smp.c               | 16 +++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
index 547f536e7ecd..b05259284eb0 100644
--- a/include/trace/events/smp.h
+++ b/include/trace/events/smp.h
@@ -7,6 +7,33 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(csd_queue_cpu,
+
+	TP_PROTO(const unsigned int cpu,
+		unsigned long callsite,
+		smp_call_func_t func,
+		call_single_data_t *csd),
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
index eecdd452619c..e70497f1c3c6 100644
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
2.40.1

