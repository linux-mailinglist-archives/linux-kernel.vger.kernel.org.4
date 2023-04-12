Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456086DF124
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDLJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDLJyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:54:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B39526BE;
        Wed, 12 Apr 2023 02:54:34 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PxHyp38YFz16Ny5;
        Wed, 12 Apr 2023 17:50:58 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 17:54:31 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf/core: Fix perf_sample_data not properly initialized for different swevents in perf_tp_event()
Date:   Wed, 12 Apr 2023 09:52:40 +0000
Message-ID: <20230412095240.181516-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Solution: Add perf_sample_data_flags_{save, restore} helpers to save and
restore sample_flags when processing different swevents

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
 include/linux/perf_event.h | 11 +++++++++++
 kernel/events/core.c       | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..7499bd3a2ed5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1185,6 +1185,17 @@ struct perf_sample_data {
 		    PERF_MEM_S(LOCK, NA)  |\
 		    PERF_MEM_S(TLB, NA))
 
+/* Note: caller must ensure flags is not NULL */
+static inline void perf_sample_data_flags_save(struct perf_sample_data *data, u64 *flags)
+{
+	*flags = data->sample_flags;
+}
+
+static inline void perf_sample_data_flags_restore(struct perf_sample_data *data, u64 flags)
+{
+	data->sample_flags = flags;
+}
+
 static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 435815d3be3f..ea1fb63a6037 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10136,6 +10136,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 {
 	struct perf_sample_data data;
 	struct perf_event *event;
+	u64 sample_flags;
 
 	struct perf_raw_record raw = {
 		.frag = {
@@ -10150,8 +10151,18 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_tp_event_match(event, &data, regs))
+		if (perf_tp_event_match(event, &data, regs)) {
+			/*
+			 * sample_flags may be modified in perf_event_output_*
+			 * (see perf_prepare_sample). For different swevents,
+			 * use the same on-stack perf_sample_data, therefore,
+			 * need to save samle_flags, and restore it
+			 * after perf_swevent_event.
+			 */
+			perf_sample_data_flags_save(&data, &sample_flags);
 			perf_swevent_event(event, count, &data, regs);
+			perf_sample_data_flags_restore(&data, sample_flags);
+		}
 	}
 
 	/*
-- 
2.30.GIT

