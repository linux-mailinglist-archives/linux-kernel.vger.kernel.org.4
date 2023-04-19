Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6C6E7158
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjDSCul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDSCuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:50:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC6E66;
        Tue, 18 Apr 2023 19:50:33 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q1QGh6HrjzsRNd;
        Wed, 19 Apr 2023 10:49:00 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 10:50:30 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v2] perf/core: Fix perf_sample_data not properly initialized for different swevents in perf_tp_event()
Date:   Wed, 19 Apr 2023 02:48:32 +0000
Message-ID: <20230419024832.181874-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data->sample_flags may be modified in perf_prepare_sample(),
in perf_tp_event(), different swevents use the same on-stack
perf_sample_data, the previous swevent may change sample_flags in
perf_prepare_sample(), as a result, some members of perf_sample_data are
not correctly initialized when next swevent_event preparing sample
(for example data->id, the value varies according to swevent).

A simple scenario triggers this problem is as follows:

  # perf record -e sched:sched_switch --switch-output-event sched:sched_switch -a sleep 1
  [ perf record: dump data: Woken up 0 times ]
  [ perf record: Dump perf.data.2023041209014396 ]
  [ perf record: dump data: Woken up 0 times ]
  [ perf record: Dump perf.data.2023041209014662 ]
  [ perf record: dump data: Woken up 0 times ]
  [ perf record: Dump perf.data.2023041209014910 ]
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Dump perf.data.2023041209015164 ]
  [ perf record: Captured and wrote 0.069 MB perf.data.<timestamp> ]
  # ls -l
  total 860
  -rw------- 1 root root  95694 Apr 12 09:01 perf.data.2023041209014396
  -rw------- 1 root root 606430 Apr 12 09:01 perf.data.2023041209014662
  -rw------- 1 root root  82246 Apr 12 09:01 perf.data.2023041209014910
  -rw------- 1 root root  82342 Apr 12 09:01 perf.data.2023041209015164
  # perf script -i perf.data.2023041209014396
  0x11d58 [0x80]: failed to process type: 9 [Bad address]

Solution: Re-initialize perf_sample_data before processing different swevents.

After fix:

  # perf record -e sched:sched_switch --switch-output-event sched:sched_switch -a sleep 1
  [ perf record: dump data: Woken up 0 times ]
  [ perf record: Dump perf.data.2023041209442259 ]
  [ perf record: dump data: Woken up 0 times ]
  [ perf record: Dump perf.data.2023041209442514 ]
  [ perf record: dump data: Woken up 0 times ]
  [ perf record: Dump perf.data.2023041209442760 ]
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Dump perf.data.2023041209443003 ]
  [ perf record: Captured and wrote 0.069 MB perf.data.<timestamp> ]
  # ls -l
  total 864
  -rw------- 1 root root 100166 Apr 12 09:44 perf.data.2023041209442259
  -rw------- 1 root root 606438 Apr 12 09:44 perf.data.2023041209442514
  -rw------- 1 root root  82246 Apr 12 09:44 perf.data.2023041209442760
  -rw------- 1 root root  82342 Apr 12 09:44 perf.data.2023041209443003
  # perf script -i perf.data.2023041209442259 | head -n 5
              perf   232 [000]    66.846217: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=D ==> next_comm=perf next_pid=234 next_prio=120
              perf   234 [000]    66.846449: sched:sched_switch: prev_comm=perf prev_pid=234 prev_prio=120 prev_state=S ==> next_comm=perf next_pid=232 next_prio=120
              perf   232 [000]    66.846546: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=234 next_prio=120
              perf   234 [000]    66.846606: sched:sched_switch: prev_comm=perf prev_pid=234 prev_prio=120 prev_state=S ==> next_comm=perf next_pid=232 next_prio=120
              perf   232 [000]    66.846646: sched:sched_switch: prev_comm=perf prev_pid=232 prev_prio=120 prev_state=R ==> next_comm=perf next_pid=234 next_prio=120

Fixes: bb447c27a467 ("perf/core: Set data->sample_flags in perf_prepare_sample()")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 kernel/events/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 435815d3be3f..6c4356ad453f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10144,14 +10144,22 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 		},
 	};
 
-	perf_sample_data_init(&data, 0, 0);
-	perf_sample_save_raw_data(&data, &raw);
-
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_tp_event_match(event, &data, regs))
+		if (perf_tp_event_match(event, &data, regs)) {
+			/*
+			 * Here use the same on-stack perf_sample_data,
+			 * some members in data are event-specific and
+			 * need to be re-computed for different sweveents.
+			 * Re-initialize data->sample_flags each time safely
+			 * to avoid the problem that next event skips preparing
+			 * data because data->sample_flags is set.
+			 */
+			perf_sample_data_init(&data, 0, 0);
+			perf_sample_save_raw_data(&data, &raw);
 			perf_swevent_event(event, count, &data, regs);
+		}
 	}
 
 	/*
-- 
2.30.GIT

