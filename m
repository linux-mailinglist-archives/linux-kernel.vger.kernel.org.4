Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2B6FB4D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjEHQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjEHQJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:09:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF924EE5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:08:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef69281e68so24136761cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1683562139; x=1686154139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJvYmXm5B2lTYrM3WjwxlAESJjR3R/vjXkyvaupYjYg=;
        b=VqEmLpcqipoMYyiBkI0enYr7peDeBizUMUi1pD3w4iOuknmRc6C9EPBpfK6tBPxy00
         9r6b21zSFToUlh3e9bVgNe04qWnqTIuj3aUPRS106v48HWAWLoz7N+IdTJeeXNIJN3Ad
         CR/i6T/6yYaFbIF2Ycx7gwH/7c4RdY9kQWh24m6ba6WWk3pq88LFKlcodx3tE6DM2jOx
         0mU6kNv3LCRNFOpJ0zjhv18qggLBDJs47BtegRrYIThIPAWtm1nuvEvUUCxS7hQoNhQN
         aHuyPRFLtxDJp/Xwfj+9qL1A3JjK9a3UmvFqz02B+o7V5C9e/33G+AH46KbIr8RRMEhA
         r7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683562139; x=1686154139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJvYmXm5B2lTYrM3WjwxlAESJjR3R/vjXkyvaupYjYg=;
        b=QMMnlhdakUtafSlTqK6T2/oUNNVQV/Eu+3Zal6BqfVKVDBzrA2jzLT0KZSVW5Wryhq
         ZKtNyxRTe48Ivqw0ngg87UKiOETSkMTQt51BXxHpvdL44uEbGKMYjYUPKI80lZqeXZys
         dAD06nOwGhcxfsxvqyVgtCp069di4GZYmCIwn3ViBJCSX0MSoFsLu0JThW50xoCMRm8T
         O+1vD2XYula4a+PwhflAJJ/aUIv3f8yo0tfBG2+Ai1ChEs4iLOl9fp1o1qKmrzzzuQlU
         hGfjmHXZllfErTlCzY2+ROElhelvqsw1HXy+43/6NzqK4+sVv8pJMLuW8x7j04ocEoiH
         oHfA==
X-Gm-Message-State: AC+VfDzz0Ifa0b7ucK1BAHgPyHDPYCEtEFnDEua3znGOpCwQdp1/slEs
        BJ++fPXWDzQ3cJt2gxXrpIPPhA==
X-Google-Smtp-Source: ACHHUZ4GzK8Hybe3uG7A1lq8w04NHUOubyE+BOunSjr6ITm3XcqKpkIiefqTJxjLzqWq9BOZOtmEkg==
X-Received: by 2002:a05:622a:189f:b0:3ef:2d2c:c584 with SMTP id v31-20020a05622a189f00b003ef2d2cc584mr16216046qtc.9.1683562138867;
        Mon, 08 May 2023 09:08:58 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.ma.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id h20-20020a05622a171400b003e4c6b2cc35sm1997025qtk.24.2023.05.08.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:08:58 -0700 (PDT)
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
Subject: [PATCH 2/2] Documentation: sched/deadline: Update GRUB description
Date:   Mon,  8 May 2023 12:08:29 -0400
Message-Id: <20230508160829.2756405-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508160829.2756405-1-vineeth@bitbyteword.org>
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
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

Update the details of GRUB to reflect the updated logic.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 Documentation/scheduler/sched-deadline.rst | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9d9be52f221a..0c73f07f712d 100644
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
 
@@ -209,12 +213,12 @@ Deadline Task Scheduling
  to
 
            dq = -max{ Ui / Umax, (1 - Uinact - Uextra) } dt
+           dq = -(Ureclaim / (Uextra + Uinact + Ureclaim)) dt
 
  where:
 
-  - Ui is the bandwidth of task Ti;
-  - Umax is the maximum reclaimable utilization (subjected to RT throttling
-    limits);
+  - Ureclaim is the (per runqueue) bandwidth of all SCHED_FLAG_RECLAIM tasks
+    in active state;
   - Uinact is the (per runqueue) inactive utilization, computed as
     (this_bq - running_bw);
   - Uextra is the (per runqueue) extra reclaimable utilization
@@ -222,7 +226,8 @@ Deadline Task Scheduling
 
 
  Let's now see a trivial example of two deadline tasks with runtime equal
- to 4 and period equal to 8 (i.e., bandwidth equal to 0.5)::
+ to 4 and period equal to 8 (i.e., bandwidth equal to 0.5). Tasks are
+ allowed to use the whole cpu(Umax = 1)::
 
          A            Task T1
          |
@@ -244,7 +249,7 @@ Deadline Task Scheduling
          0   1   2   3   4   5   6   7   8
 
 
-         A            running_bw
+         A            reclaim_bw
          |
        1 -----------------               ------
          |               |               |
@@ -272,7 +277,7 @@ Deadline Task Scheduling
 
     This is the 0-lag time for Task T1. Since it didn't woken up in the
     meantime, it enters the Inactive state. Its bandwidth is removed from
-    running_bw.
+    running_bw and reclaim_bw.
     Task T2 continues its execution. However, its runtime is now decreased as
     dq = - 0.5 dt because Uinact = 0.5.
     Task T2 therefore reclaims the bandwidth unused by Task T1.
@@ -280,7 +285,7 @@ Deadline Task Scheduling
   - Time t = 8:
 
     Task T1 wakes up. It enters the ActiveContending state again, and the
-    running_bw is incremented.
+    running_bw and reclaim_bw are incremented.
 
 
 2.3 Energy-aware scheduling
-- 
2.40.1

