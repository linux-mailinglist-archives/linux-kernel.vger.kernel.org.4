Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B936D90EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjDFH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjDFH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2883E1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680767858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o8Jnf1oxja9yxfnwJ3kNckwJZHzsUpda+/vzVwFHt+Q=;
        b=O72KPfvwpUc9Tm8XEVyHUbOgqwAZ4gkgKM4/uymfVInXMtaTaxUWfZSNbxHo5XYtb3NZGX
        41SVpyVfTxOU0DYhDWxCEkyibZ9xHMS81z5XUJb/qP7U9XBWMzPE4p7ee39aqBjh8KTHEb
        O/SPj9e7iGPXLxUKKKKjiHqfY3BDACY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-kEZKmAvdOb2iX2nW_NjtGQ-1; Thu, 06 Apr 2023 03:57:36 -0400
X-MC-Unique: kEZKmAvdOb2iX2nW_NjtGQ-1
Received: by mail-qv1-f69.google.com with SMTP id pe26-20020a056214495a00b005df3eac4c0bso14462812qvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8Jnf1oxja9yxfnwJ3kNckwJZHzsUpda+/vzVwFHt+Q=;
        b=wV1dENl6dyF6un5NpdKE/YZiTRYIt2SAzApEUcTfsAMSoXvNV+nkzxuAa42K3z7Dk5
         6k6FTchf0lXmP2Sf+SwMzuJRAg5+p1N/RaPl/I1WkFmWIYIdgZDr7Oq7JlbV1VdKhG1Z
         AnZH3EJ4UrnEsFvHTR94NmjorgZ0UDfsCvbdKtMmR3Ki317o8zgSBX+g9wz59WtkaCxO
         hjadeFGWstbMP6l+jmgwA1fXEqqyCG3fzXATtj+YUf3OcExI/vcRK66yVgg3+6yjodV/
         jjzZvIluwxYaDIJfB9j2t0rcgO7c+f8tT6Xg2/ZPkfsyvwnYuojGtybaKf+tZdHhDs0k
         qpYw==
X-Gm-Message-State: AAQBX9dFMehOPS8Le6uQWQZiDpRH/5Vm1p1ErOYWXpjpFTpmKvq/O474
        5YKSbVROa6Wn08oqmZJn2Vy+VRzzlP/OiBjNdLnp4KWK0KcKPO5C6A2h34rWmdliKSgWvhBVSyG
        Fex0DhW/X9WcW1de084YQBygc
X-Received: by 2002:ac8:59ca:0:b0:3db:e078:2886 with SMTP id f10-20020ac859ca000000b003dbe0782886mr9151945qtf.38.1680767855667;
        Thu, 06 Apr 2023 00:57:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350YtU54Wqkzwh65tOVrlQK9meeDaoTwSlSqIm7X76SPtVj5Y1hGi9JgQ1K+gkhZliX019qG+6w==
X-Received: by 2002:ac8:59ca:0:b0:3db:e078:2886 with SMTP id f10-20020ac859ca000000b003dbe0782886mr9151923qtf.38.1680767855405;
        Thu, 06 Apr 2023 00:57:35 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:2599:3b52:5a:179c:6ae7])
        by smtp.gmail.com with ESMTPSA id de21-20020a05620a371500b0074a5ffbecd3sm292307qkb.49.2023.04.06.00.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 00:57:34 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH 1/1] smp: Add tracepoints for functions called with smp_call_function*()
Date:   Thu,  6 Apr 2023 04:57:18 -0300
Message-Id: <20230406075718.68672-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running RT workloads in isolated CPUs, many cases of deadline misses
are caused by remote CPU requests such as smp_call_function*().

For those cases, having the names of those functions running around the
deadline miss moment could help finding a target for the next improvements.

Add tracepoints for acquiring the funtion name & argument before entry and
after exitting the called function.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/trace/events/smp.h | 56 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 11 ++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 include/trace/events/smp.h

diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
new file mode 100644
index 0000000000000..94aae8d71705d
--- /dev/null
+++ b/include/trace/events/smp.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM smp
+
+#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SMP_H
+
+#include <linux/tracepoint.h>
+#include <linux/smp.h>
+
+/*
+ * Tracepoints for a function which is called as an effect of smp_call_function.*
+ */
+TRACE_EVENT(smp_call_function_entry,
+
+	TP_PROTO(smp_call_func_t func, void *info),
+
+	TP_ARGS(func, info),
+
+	TP_STRUCT__entry(
+		__field(void *,	func)
+		__field(void *,	info)
+	),
+
+	TP_fast_assign(
+		__entry->func	= func;
+		__entry->info	= info;
+	),
+
+	TP_printk("function %ps, argument = %p", __entry->func, __entry->info)
+);
+
+
+TRACE_EVENT(smp_call_function_exit,
+
+	TP_PROTO(smp_call_func_t func, void *info),
+
+	TP_ARGS(func, info),
+
+	TP_STRUCT__entry(
+		__field(void *,	func)
+		__field(void *,	info)
+	),
+
+	TP_fast_assign(
+		__entry->func	= func;
+		__entry->info	= info;
+	),
+
+	TP_printk("function %ps with argument = %p", __entry->func, __entry->info)
+);
+
+#endif /* _TRACE_SMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/smp.c b/kernel/smp.c
index 06a413987a14a..38d8dec28c39c 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -29,6 +29,9 @@
 #include "smpboot.h"
 #include "sched/smp.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/smp.h>
+
 #define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
@@ -517,7 +520,9 @@ static int generic_exec_single(int cpu, struct __call_single_data *csd)
 		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
+		trace_smp_call_function_entry(func, info);
 		func(info);
+		trace_smp_call_function_exit(func, info);
 		csd_lock_record(NULL);
 		local_irq_restore(flags);
 		return 0;
@@ -627,7 +632,9 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 			}
 
 			csd_lock_record(csd);
+			trace_smp_call_function_entry(func, info);
 			func(info);
+			trace_smp_call_function_exit(func, info);
 			csd_unlock(csd);
 			csd_lock_record(NULL);
 		} else {
@@ -662,7 +669,9 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 
 				csd_lock_record(csd);
 				csd_unlock(csd);
+				trace_smp_call_function_entry(func, info);
 				func(info);
+				trace_smp_call_function_exit(func, info);
 				csd_lock_record(NULL);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
@@ -975,7 +984,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		unsigned long flags;
 
 		local_irq_save(flags);
+		trace_smp_call_function_entry(func, info);
 		func(info);
+		trace_smp_call_function_exit(func, info);
 		local_irq_restore(flags);
 	}
 
-- 
2.40.0

