Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F8E7021F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjEOC5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjEOC5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:57:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1634D19B6
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f41b73104eso30437831cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684119447; x=1686711447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYmaRuKFkzMj5gjRDsV91RPkHqeO5wpmEeDsuTj5yKM=;
        b=tA+fhkPNslQmwh3JHhLY8rFF3qCZt8NNZQOF/RZUfiMV9y2ZP/tLyqzwAgaC3r4PUB
         GN2ZfPse12OOMyQEsZAM3iZso8OKdlnq+7YyeMIskfFmWJWS9K5dmj327IsLB6V5ViHX
         o9IxD3EAq7wy+/PAKZkWNwsN2h5YLfKvfs7Tzx5leIsbmjFpDRmWDUAHKDUlFxL2xizz
         INstPLtnVfCGe6lXvwe1ikyPt/ts3Cu5upyB49FajXeUF3DOCuTL/qTmkZWkivewaldr
         DdJ/5WDCSZUQOC7NZo26QNIygWAmE3j/4pOrnFJuBf8uK6r9eWtS0zWACLX5No7N5ihH
         Di6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684119447; x=1686711447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYmaRuKFkzMj5gjRDsV91RPkHqeO5wpmEeDsuTj5yKM=;
        b=MbepRu4bXnl0xTt+GF4e/IfFs7JNjzBwgKe3nAIZBHpiRVCO9htLAmxlyC+pPL/oAJ
         5fReiki2SYLNvzbswqhRGuI5j4MDwxfClVXLkhk2bDB5H3XSglPN0gm1fLQhMamdV46V
         cAYnuEkfDXztUi8oWaqM08wr0wslf4I2CKIhI5X1aq5fnf+AMoOUDEDV5Bp6dLO4sAzm
         VMpXohwfge3dCIPEmqcTCUyHtGeYIGTTcLvqYFtgsuPdSC1XmDHV6Ijyy4itSdhp9vIl
         ZEAO8DXAOo4mnusIs1ueypBuizh06UAHPNgM1nnyhGuxAgqQlIPktOsR175Ag+MvsCD8
         Iwsw==
X-Gm-Message-State: AC+VfDzXDwd6L6QkMViTZGNhLTpll67cS9qvsxN0OrKYsZBBuO4eKSlI
        nVo+jfQ9a16a1vayTX9T95pvOA==
X-Google-Smtp-Source: ACHHUZ4hOz2OdPHISWrsejcQ6hbcJ1Fco5dm89GXSD5nQJhKEVw9HRRSUwoO5imiWhUGek5jXfAkLg==
X-Received: by 2002:ac8:5ad5:0:b0:3f5:2eb1:a5d9 with SMTP id d21-20020ac85ad5000000b003f52eb1a5d9mr1820843qtd.63.1684119447185;
        Sun, 14 May 2023 19:57:27 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.ma.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a134300b007339c5114a9sm2308994qkl.103.2023.05.14.19.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 19:57:26 -0700 (PDT)
From:   Vineeth Pillai <vineeth@bitbyteword.org>
To:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Vineeth Pillai <vineeth@bitbyteword.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 4/5] sched/deadline: Account for normal deadline tasks in GRUB
Date:   Sun, 14 May 2023 22:57:15 -0400
Message-Id: <20230515025716.316888-5-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515025716.316888-1-vineeth@bitbyteword.org>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GRUB algorithm assumes that all tasks participate in the reclaim. So
when there is a mix of normal deadline and SCHED_FLAG_RECLAIM tasks,
reclaiming the unused bandwidth is not accurate.

Running two deadline tasks on a cpu where one is SCHED_FLAG_RECLAIM
and other is a normal deadline task, we can see the utilization as
follows:

Task 1(Normal DL): (5, 10), Task 2(SCHED_FLAG_RECLAIM): (1, 10)
TID[673]: RECLAIM=0, (r=5ms, d=10ms, p=10ms), Util: 50.11
TID[672]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 15.93
TID[673]: RECLAIM=0, (r=5ms, d=10ms, p=10ms), Util: 50.01
TID[672]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 15.83

GRUB rule says, runtime is dpreciated as:
 "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt"
  Where Umax is the maximum allowed bandwidth for DL tasks
        Uinact is the inactive utilization for the runqueue
        Uextra is the free bandwidth available for reclaim

To account for a mix of normal deadline and SCHED_RECLAIM_FLAG tasks
running together, we do not consider the bandwidth of normal tasks in
the equation. So the equation becomes:
 "dq = -(max{u, (Umax_reclaim - Uinact - Uextra)} / Umax_reclaim) dt"

"Umax_reclaim" is the maximum allowed bandwidth for SCHED_FLAG_RECLAIM
tasks. When only SCHED_FLAG_RECLAIM tasks are running,
 "Umax_reclaim = Umax". Otherwise:
 "Umax_reclaim = Umax - running_bw + Ureclaim"
  Where Ureclaim is the total bandwidth of SCHED_FLAG_RECLAIM tasks in
        active state for this runqueue.

With this fix, the results of above test is as follows:
Task 1(Normal DL): (5, 10), Task 2(SCHED_FLAG_RECLAIM): (1, 10)
TID[591]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 45.11
TID[592]: RECLAIM=0, (r=5ms, d=10ms, p=10ms), Util: 50.18
TID[591]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 44.99
TID[592]: RECLAIM=0, (r=5ms, d=10ms, p=10ms), Util: 49.88

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 kernel/sched/deadline.c | 53 ++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h    | 11 +++++++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 67c1138df43a..66a1b9365429 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -206,11 +206,13 @@ __dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
 }
 
 static inline
-void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
+void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq, bool reclaim_bw_se)
 {
 	u64 old = dl_rq->running_bw;
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
+	if (reclaim_bw_se)
+		dl_rq->reclaim_bw += dl_bw;
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
@@ -219,15 +221,19 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 }
 
 static inline
-void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
+void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq, bool reclaim_bw_se)
 {
 	u64 old = dl_rq->running_bw;
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
+	if (reclaim_bw_se)
+		dl_rq->reclaim_bw -= dl_bw;
 	dl_rq->running_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
-	if (dl_rq->running_bw > old)
+	if (dl_rq->running_bw > old) {
+		dl_rq->reclaim_bw = 0;
 		dl_rq->running_bw = 0;
+	}
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
@@ -273,14 +279,14 @@ static inline
 void add_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
 	if (!dl_entity_is_special(dl_se))
-		__add_running_bw(dl_se->dl_bw, dl_rq);
+		__add_running_bw(dl_se->dl_bw, dl_rq, dl_entity_is_reclaim(dl_se));
 }
 
 static inline
 void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
 	if (!dl_entity_is_special(dl_se))
-		__sub_running_bw(dl_se->dl_bw, dl_rq);
+		__sub_running_bw(dl_se->dl_bw, dl_rq, dl_entity_is_reclaim(dl_se));
 }
 
 static void dl_change_utilization(struct task_struct *p, u64 new_bw)
@@ -499,6 +505,7 @@ void init_dl_rq(struct dl_rq *dl_rq)
 #endif
 
 	dl_rq->running_bw = 0;
+	dl_rq->reclaim_bw = 0;
 	dl_rq->this_bw = 0;
 	init_dl_rq_bw(dl_rq);
 }
@@ -1257,20 +1264,44 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
  * but only a portion of it denoted by "Umax". So the equation becomes:
  *	"dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt",
  *
+ * To account for the fact that we have a mix of normal deadline tasks and
+ * SCHED_RECLAIM_FLAG tasks running together, we do not consider the bandwidth
+ * of normal tasks in the equation. So the equation becomes:
+ *	"dq = -(max{u, (Umax_reclaim - Uinact - Uextra)} / Umax_reclaim) dt",
+ * where
+ *	Umax_reclaim:	Maximum reclaimable bandwidth for this rq.
+ *
+ * We can calculate Umax_reclaim as:
+ *	"Umax_reclaim =	Uextra + Uinact + Ureclaim"
+ * where:
+ *	Ureclaim:	Total bandwidth of SCHED_FLAG_RECLAIM tasks in active
+ *			state for this rq.
+ *
  * Since delta is a 64 bit variable, to have an overflow its value
  * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
  * So, overflow is not an issue here.
  */
 static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 {
+	u64 u_max_reclaim;
+
+	/*
+	 * In SMP, max_bw can be less than running_bw without violating the global
+	 * bandwidth limits. If thats the case, we should not reclaim.
+	 */
+	if (rq->dl.max_bw < rq->dl.running_bw)
+		return delta;
+
+	u_max_reclaim = rq->dl.max_bw - rq->dl.running_bw + rq->dl.reclaim_bw;
+
 	/*
-	 * max{u, Umax - Uinact - Uextra}
-	 * = max{u, max_bw - (this_bw - running_bw) + (this_bw - running_bw)}
-	 * = max{u, running_bw} = running_bw
-	 * So dq = -(max{u, Umax - Uinact - Uextra} / Umax) dt
-	 *       = -(running_bw / max_bw) dt
+	 * max{u, Umax_reclaim - Uinact - Uextra}
+	 * = max{u, Uextra + Uinact + Ureclaim - Uinact - Uextra}
+	 * = max{u, Ureclaim} = Ureclaim = reclaim_bw
+	 * So dq = -(max{u, Umax_reclaim - Uinact - Uextra} / Umax_reclaim) dt
+	 *       = -(reclaim_bw / Umax_reclaim) dt
 	 */
-	return div64_u64(delta * rq->dl.running_bw, rq->dl.max_bw);
+	return div64_u64(delta * rq->dl.reclaim_bw, u_max_reclaim);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 33db99756624..a6cb891835da 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -257,6 +257,11 @@ static inline bool dl_entity_is_special(const struct sched_dl_entity *dl_se)
 #endif
 }
 
+static inline bool dl_entity_is_reclaim(const struct sched_dl_entity *dl_se)
+{
+	return dl_se->flags & SCHED_FLAG_RECLAIM;
+}
+
 /*
  * Tells if entity @a should preempt entity @b.
  */
@@ -741,6 +746,12 @@ struct dl_rq {
 	 */
 	u64			running_bw;
 
+	/*
+	 * Active bandwidth of SCHED_FLAG_RECLAIM tasks on this rq.
+	 * This will be a subset of running_bw.
+	 */
+	u64			reclaim_bw;
+
 	/*
 	 * Utilization of the tasks "assigned" to this runqueue (including
 	 * the tasks that are in runqueue and the tasks that executed on this
-- 
2.40.1

