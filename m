Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F59737109
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjFTP5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjFTP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:57:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E54B6;
        Tue, 20 Jun 2023 08:57:08 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QlrqH4vKLz1FDds;
        Tue, 20 Jun 2023 23:56:59 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 20 Jun 2023 23:57:05 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/2] perf/core: perf_iterate_sb_cpu() supports to receive side-band events for all oneline cpus
Date:   Tue, 20 Jun 2023 15:55:14 +0000
Message-ID: <20230620155515.101222-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230620155515.101222-1-yangjihong1@huawei.com>
References: <20230620155515.101222-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bool parameter `system_wide` to perf_iterate_sb_cpu() to output
side-band events to events on all online cpus.
No functional change.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 kernel/events/core.c | 58 +++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index db016e418931..66dbca1ba577 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7886,9 +7886,9 @@ perf_iterate_ctx(struct perf_event_context *ctx,
 	}
 }
 
-static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
+static void perf_iterate_sb_pel(perf_iterate_f output, void *data,
+				 struct pmu_event_list *pel, bool system_wide)
 {
-	struct pmu_event_list *pel = this_cpu_ptr(&pmu_sb_events);
 	struct perf_event *event;
 
 	list_for_each_entry_rcu(event, &pel->list, sb_list) {
@@ -7902,12 +7902,30 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
 
 		if (event->state < PERF_EVENT_STATE_INACTIVE)
 			continue;
-		if (!event_filter_match(event))
+		if (!system_wide && !event_filter_match(event))
 			continue;
 		output(event, data);
 	}
 }
 
+static void perf_iterate_sb_cpu(perf_iterate_f output, void *data,
+				bool system_wide)
+{
+	unsigned int i;
+
+	if (system_wide) {
+		for_each_online_cpu(i) {
+			perf_iterate_sb_pel(output, data,
+					    per_cpu_ptr(&pmu_sb_events, i),
+					    system_wide);
+		}
+	} else {
+		perf_iterate_sb_pel(output, data,
+				    this_cpu_ptr(&pmu_sb_events),
+				    system_wide);
+	}
+}
+
 /*
  * Iterate all events that need to receive side-band events.
  *
@@ -7916,7 +7934,8 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
  */
 static void
 perf_iterate_sb(perf_iterate_f output, void *data,
-	       struct perf_event_context *task_ctx)
+		struct perf_event_context *task_ctx,
+		bool system_wide)
 {
 	struct perf_event_context *ctx;
 
@@ -7933,7 +7952,7 @@ perf_iterate_sb(perf_iterate_f output, void *data,
 		goto done;
 	}
 
-	perf_iterate_sb_cpu(output, data);
+	perf_iterate_sb_cpu(output, data, system_wide);
 
 	ctx = rcu_dereference(current->perf_event_ctxp);
 	if (ctx)
@@ -8174,8 +8193,9 @@ static void perf_event_task(struct task_struct *task,
 	};
 
 	perf_iterate_sb(perf_event_task_output,
-		       &task_event,
-		       task_ctx);
+			&task_event,
+			task_ctx,
+			false);
 }
 
 void perf_event_fork(struct task_struct *task)
@@ -8254,8 +8274,9 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	comm_event->event_id.header.size = sizeof(comm_event->event_id) + size;
 
 	perf_iterate_sb(perf_event_comm_output,
-		       comm_event,
-		       NULL);
+			comm_event,
+			NULL,
+			false);
 }
 
 void perf_event_comm(struct task_struct *task, bool exec)
@@ -8410,7 +8431,8 @@ void perf_event_namespaces(struct task_struct *task)
 
 	perf_iterate_sb(perf_event_namespaces_output,
 			&namespaces_event,
-			NULL);
+			NULL,
+			false);
 }
 
 /*
@@ -8505,7 +8527,8 @@ static void perf_event_cgroup(struct cgroup *cgrp)
 
 	perf_iterate_sb(perf_event_cgroup_output,
 			&cgroup_event,
-			NULL);
+			NULL,
+			false);
 
 	kfree(pathname);
 }
@@ -8730,8 +8753,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
 
 	perf_iterate_sb(perf_event_mmap_output,
-		       mmap_event,
-		       NULL);
+			mmap_event,
+			NULL,
+			false);
 
 	kfree(buf);
 }
@@ -9020,7 +9044,7 @@ static void perf_event_switch(struct task_struct *task,
 				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
 	}
 
-	perf_iterate_sb(perf_event_switch_output, &switch_event, NULL);
+	perf_iterate_sb(perf_event_switch_output, &switch_event, NULL, false);
 }
 
 /*
@@ -9149,7 +9173,7 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
 		},
 	};
 
-	perf_iterate_sb(perf_event_ksymbol_output, &ksymbol_event, NULL);
+	perf_iterate_sb(perf_event_ksymbol_output, &ksymbol_event, NULL, false);
 	return;
 err:
 	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
@@ -9261,7 +9285,7 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	BUILD_BUG_ON(BPF_TAG_SIZE % sizeof(u64));
 
 	memcpy(bpf_event.event_id.tag, prog->tag, BPF_TAG_SIZE);
-	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
+	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL, false);
 }
 
 struct perf_text_poke_event {
@@ -9345,7 +9369,7 @@ void perf_event_text_poke(const void *addr, const void *old_bytes,
 		},
 	};
 
-	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL);
+	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL, false);
 }
 
 void perf_event_itrace_started(struct perf_event *event)
-- 
2.30.GIT

