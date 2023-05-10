Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150716FDE78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbjEJN0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjEJNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:25:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB95BBB;
        Wed, 10 May 2023 06:25:55 -0700 (PDT)
Date:   Wed, 10 May 2023 13:25:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+50aCcQo7yk8tGTr01frSlis0+nA0wrpfvXRz/M9unE=;
        b=vliowQ8e/566MxivxMmyONSWLB8UEuf/k6awcdUjWvTT6DeIaxyajYhJo6j1Gs2lblqCtx
        TehQtO2DV35EkosFY+8xTdp9KftNiSQTuXZ8WpeRNqPViZBc2NsDmzDlAs1Si4tpoJ0eW9
        uUl4JaFxHylO1syiNvkusaTK7QZzbxNB+jZQ8Zs9IahMzn/hp0I6nLHWlOV/wpiuy4EfdH
        540SFnCx8wRcVJc11z7hM9mcSg+VS5oQW/Ro/JJErFSKuK3Jw975LIl+toMjn2JbSJGkke
        MgN3OKrV3hoau7vTgiPsJdx+pVYFivnA2W5N1wizjm1xvBS+LH1BmuWKHvmPig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+50aCcQo7yk8tGTr01frSlis0+nA0wrpfvXRz/M9unE=;
        b=D4bLYkNGhQW2Fb8yvEdE+LSAxWhUd9EsBvnUplWN6E4yiOHtNnJbwWGXGvMEskLzG9deqt
        J4xvA1pYYd64m1AA==
From:   "tip-bot2 for Yang Jihong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix perf_sample_data not properly
 initialized for different swevents in perf_tp_event()
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425103217.130600-1-yangjihong1@huawei.com>
References: <20230425103217.130600-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Message-ID: <168372515329.404.5827790675701138277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1d1bfe30dad50d4bea83cd38d73c441972ea0173
Gitweb:        https://git.kernel.org/tip/1d1bfe30dad50d4bea83cd38d73c441972ea0173
Author:        Yang Jihong <yangjihong1@huawei.com>
AuthorDate:    Tue, 25 Apr 2023 10:32:17 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:26 +02:00

perf/core: Fix perf_sample_data not properly initialized for different swevents in perf_tp_event()

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

Solution: Re-initialize perf_sample_data after each event is processed.
Note that data->raw->frag.data may be accessed in perf_tp_event_match().
Therefore, need to init sample_data and then go through swevent hlist to prevent
reference of NULL pointer, reported by [1].

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

[1] Link: https://lore.kernel.org/oe-lkp/202304250929.efef2caa-yujie.liu@intel.com

Fixes: bb447c27a467 ("perf/core: Set data->sample_flags in perf_prepare_sample()")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230425103217.130600-1-yangjihong1@huawei.com
---
 kernel/events/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 68baa81..db016e4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10150,8 +10150,20 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_tp_event_match(event, &data, regs))
+		if (perf_tp_event_match(event, &data, regs)) {
 			perf_swevent_event(event, count, &data, regs);
+
+			/*
+			 * Here use the same on-stack perf_sample_data,
+			 * some members in data are event-specific and
+			 * need to be re-computed for different sweveents.
+			 * Re-initialize data->sample_flags safely to avoid
+			 * the problem that next event skips preparing data
+			 * because data->sample_flags is set.
+			 */
+			perf_sample_data_init(&data, 0, 0);
+			perf_sample_save_raw_data(&data, &raw);
+		}
 	}
 
 	/*
