Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA657021F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEOC55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbjEOC5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:57:36 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637061FC8
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:29 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61b79b9f45bso112936946d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684119448; x=1686711448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oFCVXjeQ2GIJ5xOGeSz2EMiD7vB66GrLgt9ZF9wK0s=;
        b=qhLbjW0ZVawuhRY+HIQn9xeqEM+Nwhz5f83xoGSVPgCdqqwYib1B9HscXalx/PHVqB
         bc+wFoKd/2aIPiJOZ57PPjD43ps7ah8rHeXMhuUoBSPf/HNwiD4AmR/ryYX1GhOTl7Un
         /awsoDp1jZbMbTa8vksU90Usb3E8VYj7H0SLZnTJ5Gsoj6njR3wmLKo+RNFjhf/SBqmx
         nez7v5D9IBcrLAaTiXIrIY8l23c2g0l2SjiW1YcUvA/o2BX/G5yMYqeqIFvcA9zNmTBu
         ez0M/6ZBRAerRK1uMdhYdPiVDHY/8Y/3+1JkPhucWTGeILptA7lK21iPOsjg40/V7/7r
         lcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684119448; x=1686711448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oFCVXjeQ2GIJ5xOGeSz2EMiD7vB66GrLgt9ZF9wK0s=;
        b=eq78yhJTPtjmtkbEeZ/eMPigq9JLzidCuZT/cQdgSKFGW7Huktwjg1/Y0Kd6w14FkP
         GYSUrYHKMSGwQe5SOf1XP4+vQrJMEQJHcd4fA7SQqUZxWIKC8ZCGJj22qivgX7xWFWIP
         93UmzcKPVVPu76V1880oM3Yf+JeVgQfSgIJ1OkAQ5R8rCMrr7nkYO1WiHrLAZRvqTCUl
         p4N4j/fjuDcBLppIogqw8YGcFWS90jTdfmJi6rhZbETCEeKldnDCbfc/9A6L5VQQgG7m
         FuS9h6PH1XWCoWu5i+97JtPIId5eM9GnkUWYLHLpmmIOVBqe6hatY2kZq6SNN29dmqvT
         2CjA==
X-Gm-Message-State: AC+VfDwwJxfMdCwTRURhted6E2V7cIlx+5UBUfgJd0KVXESMHzfTbR+m
        bru+a1rD/L7xMx8QOOS/XpPWew==
X-Google-Smtp-Source: ACHHUZ4Q9Tdhe54rgSkAw/RlkBa+2YFISrSNKj8WaG7r0IV3OOMS2EDrDsXpMppUmAcbKVEQRq5Ngw==
X-Received: by 2002:a05:6214:e4c:b0:621:e17a:a676 with SMTP id o12-20020a0562140e4c00b00621e17aa676mr15883547qvc.17.1684119448427;
        Sun, 14 May 2023 19:57:28 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.ma.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a134300b007339c5114a9sm2308994qkl.103.2023.05.14.19.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 19:57:28 -0700 (PDT)
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
Subject: [PATCH v3 5/5] Documentation: sched/deadline: Update GRUB description
Date:   Sun, 14 May 2023 22:57:16 -0400
Message-Id: <20230515025716.316888-6-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515025716.316888-1-vineeth@bitbyteword.org>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the details of GRUB to reflect the updated logic.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 Documentation/scheduler/sched-deadline.rst | 28 ++++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9d9be52f221a..b45c9dde6671 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -195,11 +195,15 @@ Deadline Task Scheduling
       its utilization is added to the active utilization of the runqueue where
       it has been enqueued.
 
- For each runqueue, the algorithm GRUB keeps track of two different bandwidths:
+ For each runqueue, the algorithm GRUB keeps track of three different bandwidths:
 
   - Active bandwidth (running_bw): this is the sum of the bandwidths of all
     tasks in active state (i.e., ActiveContending or ActiveNonContending);
 
+  - Active bandwidth of SCHED_FLAG_RECLAIM tasks(reclaim_bw): this is the sum of
+    bandwidth of all tasks in active state which participates in GRUB. This is a
+    subset of running_bw and is needed for reclaimable bandwidth calculation.
+
   - Total bandwidth (this_bw): this is the sum of all tasks "belonging" to the
     runqueue, including the tasks in Inactive state.
 
@@ -208,21 +212,25 @@ Deadline Task Scheduling
  It does so by decrementing the runtime of the executing task Ti at a pace equal
  to
 
-           dq = -max{ Ui / Umax, (1 - Uinact - Uextra) } dt
+           dq = -(max{Ui, (Umax_reclaim - Uinact - Uextra)} / Umax_reclaim) dt
 
  where:
-
   - Ui is the bandwidth of task Ti;
   - Umax is the maximum reclaimable utilization (subjected to RT throttling
     limits);
+  - Umax_reclaim is the maximum allowable bandwidth for all reclaimable tasks
+    in the runqueue. If there are only SCHED_FLAG_RECLAIM tasks, then
+    Umax_reclaim = Umax;
+    Otherwise Umax_reclaim = (Umax - running_bw + reclaim_bw);
   - Uinact is the (per runqueue) inactive utilization, computed as
-    (this_bq - running_bw);
+    (this_bw - running_bw);
   - Uextra is the (per runqueue) extra reclaimable utilization
-    (subjected to RT throttling limits).
+    (subjected to RT throttling limits);
 
 
- Let's now see a trivial example of two deadline tasks with runtime equal
- to 4 and period equal to 8 (i.e., bandwidth equal to 0.5)::
+ Let's now see a trivial example of two SCHED_FLAG_RECLAIM tasks with runtime
+ equal to 4 and period equal to 8 (i.e., bandwidth equal to 0.5). Tasks are
+ allowed to use the whole cpu(Umax = Umax_reclaim = 1)::
 
          A            Task T1
          |
@@ -244,7 +252,7 @@ Deadline Task Scheduling
          0   1   2   3   4   5   6   7   8
 
 
-         A            running_bw
+         A            reclaim_bw
          |
        1 -----------------               ------
          |               |               |
@@ -272,7 +280,7 @@ Deadline Task Scheduling
 
     This is the 0-lag time for Task T1. Since it didn't woken up in the
     meantime, it enters the Inactive state. Its bandwidth is removed from
-    running_bw.
+    running_bw and reclaim_bw.
     Task T2 continues its execution. However, its runtime is now decreased as
     dq = - 0.5 dt because Uinact = 0.5.
     Task T2 therefore reclaims the bandwidth unused by Task T1.
@@ -280,7 +288,7 @@ Deadline Task Scheduling
   - Time t = 8:
 
     Task T1 wakes up. It enters the ActiveContending state again, and the
-    running_bw is incremented.
+    running_bw and reclaim_bw are incremented.
 
 
 2.3 Energy-aware scheduling
-- 
2.40.1

