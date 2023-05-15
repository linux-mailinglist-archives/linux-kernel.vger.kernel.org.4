Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEE17021F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjEOC5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbjEOC5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:57:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3391172D
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:25 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-61a4e03ccbcso113031416d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684119444; x=1686711444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tk/101Kg9y1VA9l8G9fZslfzv/h+WcqBxFnkUABG5A=;
        b=J6XQSlIZBd3HdoROHLTlpZLoseEwp3Cp6nHpUP4x/G2KNdfRKZAQcHI421sqYkRVjc
         oyZeT4A6AQYEO2/ZHBuUDWx+6vq9FLxIJ74hL140aLc6NZMn0qmSgwqjb8Ui/Y5ya9k1
         9SkF82ACmtn4BOqZdF3bGkuXmwuzARfzWE1CxR9TF2CEJv5dtaK4iwRd/70naUOqzS+b
         heGvSf83D4URQRYnKn4lqKi3yxDWvont4NdfnNU1lQldqScaCiAFZkUJPObuNYA7hE0Q
         r92qkfdcz3HGUedtqAoan3TZda5dfBoeoZADu9YStLxO/bwR4PcSfJxun/Qzo0ufHcpp
         j9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684119444; x=1686711444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Tk/101Kg9y1VA9l8G9fZslfzv/h+WcqBxFnkUABG5A=;
        b=XBm0zCAnY82p4rfxG8tMYgdAWIlW1JRWDQOe7VeGzemb6PQ183+hXqTM5hXJfoWE+J
         We61r14aE1WoOTEGjHhNHIYzTKioHq85F8b8GhfrZ5nGz/uLAKxUTdqk6ld/ONJAo7Jr
         dygJQNemWl96Az+bIrBp5tN1obh2DUQMIZK49fq6a0fVTEMbJDdgbgwHw6e2VnuV4wJG
         c07OEKqpNDMjR0JA0HRxirpbLX9H3Uahd12loUQNyuFO74Ot4QD5K0c8+uryqpKveWri
         G1y0ehWz4ppVsRNaZOhy4gYKQ9RYBDYRjSJXmig/WlaLTCENqAyVCy4AKT6JLKM2x07y
         9I6w==
X-Gm-Message-State: AC+VfDxdQydaBgALJXkqLYmKFoTVxHDY8fM50GufcWCKa0E135Sitjyr
        oixKIed9H3odQsmzEF8F/oUMDQ==
X-Google-Smtp-Source: ACHHUZ5+ra7w/3DJxrJFO5+p5e/ebNw1ZiKaxSnmQV2YQDTWthbHuONOXCieAMhto1TV8qnIDxFj6w==
X-Received: by 2002:a05:6214:2421:b0:5a2:abf1:7d33 with SMTP id gy1-20020a056214242100b005a2abf17d33mr54987934qvb.50.1684119444604;
        Sun, 14 May 2023 19:57:24 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.ma.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a134300b007339c5114a9sm2308994qkl.103.2023.05.14.19.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 19:57:24 -0700 (PDT)
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
Subject: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
Date:   Sun, 14 May 2023 22:57:13 -0400
Message-Id: <20230515025716.316888-3-vineeth@bitbyteword.org>
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

In a multi-processor system, bandwidth usage is divided equally to
all cpus. This causes issues with reclaiming free bandwidth on a cpu.
"Uextra" is same on all cpus in a root domain and running_bw would be
different based on the reserved bandwidth of tasks running on the cpu.
This causes disproportionate reclaiming - task with lesser bandwidth
reclaims less even if its the only task running on that cpu.

Following is a small test with three tasks with reservations (8,10)
(1,10) and (1, 100). These three tasks run on different cpus. But
since the reclamation logic calculates available bandwidth as a factor
of globally available bandwidth, tasks with lesser bandwidth reclaims
only little compared to higher bandwidth even if cpu has free and
available bandwidth to be reclaimed.

TID[730]: RECLAIM=1, (r=8ms, d=10ms, p=10ms), Util: 95.05
TID[731]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 31.34
TID[732]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 3.16

Fix: use the available bandwidth on each cpu to calculate reclaimable
bandwidth. Admission control takes care of total bandwidth and hence
using the available bandwidth on a specific cpu would not break the
deadline guarentees.

With this fix, the above test behaves as follows:
TID[586]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.24
TID[585]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 95.01
TID[584]: RECLAIM=1, (r=8ms, d=10ms, p=10ms), Util: 95.01

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 kernel/sched/deadline.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 91451c1c7e52..85902c4c484b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1272,7 +1272,7 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
  *	Umax:		Max usable bandwidth for DL. Currently
  *			= sched_rt_runtime_us / sched_rt_period_us
  *	Uextra:		Extra bandwidth not reserved:
- *			= Umax - \Sum(u_i / #cpus in the root domain)
+ *			= Umax - this_bw
  *	u_i:		Bandwidth of an admitted dl task in the
  *			root domain.
  *
@@ -1286,22 +1286,14 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
  */
 static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 {
-	u64 u_act;
-	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
-
 	/*
-	 * Instead of computing max{u, (rq->dl.max_bw - u_inact - u_extra)},
-	 * we compare u_inact + rq->dl.extra_bw with
-	 * rq->dl.max_bw - u, because u_inact + rq->dl.extra_bw can be larger
-	 * than rq->dl.max_bw (so, rq->dl.max_bw - u_inact - rq->dl.extra_bw
-	 * would be negative leading to wrong results)
+	 * max{u, Umax - Uinact - Uextra}
+	 * = max{u, max_bw - (this_bw - running_bw) + (this_bw - running_bw)}
+	 * = max{u, running_bw} = running_bw
+	 * So dq = -(max{u, Umax - Uinact - Uextra} / Umax) dt
+	 *       = -(running_bw / max_bw) dt
 	 */
-	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
-		u_act = dl_se->dl_bw;
-	else
-		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;
-
-	return div64_u64(delta * u_act, rq->dl.max_bw);
+	return div64_u64(delta * rq->dl.running_bw, rq->dl.max_bw);
 }
 
 /*
-- 
2.40.1

