Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E856653A11
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiLVAUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLVAUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:20:17 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABE71A04B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:20:16 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id c14so300874qvq.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rCkzzTet3p1QQJ2uxuPUOA03dzYbtHafeuVIfxmyYU=;
        b=acbzfLgg/zFM7EF7+cAnjd+fYADdIeMQkUpQa66D0e581rSWrBTJya7XVdGzOxnKMe
         Xgnt204R+rlMQFKBf/aOg+n9upAbhg4TA2XwSKj2l4bbXPZXqsCswjGOQrBmdWaHsdbK
         t2XlHm6LZBUiqXa8aQ1ybYlsbJktNWbsNAC+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rCkzzTet3p1QQJ2uxuPUOA03dzYbtHafeuVIfxmyYU=;
        b=Lkuyt4/ExzeU9W1txhKY6l5XY2/cEHxFDouKqHLLoRjmXT+IqLJBKcnK1rkxNNiAbb
         HuUGX7OrhHmo5s6zg07ByXvAohsozBkHdt+Jouq+N9EzjMUtnh/iDD07dHCgF1IIi/3N
         QvFJ9CzHtSR04CLuTfhJRgyDnG6UbUUmM94CLqhwzZ4V3ACczbDYiFRy29x/xzRvqr6A
         AJv5QxMnak7CuGRaTBPXwktedmeRmZ2Ynld1cVF5aYgKzH74TBSWcIIYcn5y/TZpbDA1
         LO4lMgyBPd+A2BWRTnKMaqsi4USMQGGjzfRYeIHjp7fZqh5H9TlnTaQNs593EW7678et
         1leg==
X-Gm-Message-State: AFqh2kqwR2ktUBkG5PA8JgaTyi90YebWx+CqSbzD7WrMY/LbE6lYK9pG
        h6LB8AWD9zudlDW0GYk5t3xYe/2x62ML5FY0cLI=
X-Google-Smtp-Source: AMrXdXs1lrjVICbiUmEbJ3c8AyxTd/JR0ezG0gf/zc4VIrjCET8aP+2ev6aMPBTd+dRDIrfnMVMxVw==
X-Received: by 2002:ad4:4247:0:b0:4c7:1fa7:25e7 with SMTP id l7-20020ad44247000000b004c71fa725e7mr4533768qvq.3.1671668415286;
        Wed, 21 Dec 2022 16:20:15 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id c10-20020ae9e20a000000b006ec771d8f89sm11516515qkc.112.2022.12.21.16.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 16:20:14 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, neeraj.iitr10@gmail.com
Subject: [PATCH] srcu: Remove memory barrier "E" as it does not do anything
Date:   Thu, 22 Dec 2022 00:20:11 +0000
Message-Id: <20221222002011.1858494-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a flip, we have a full memory barrier before srcu_idx is incremented.

The idea is we intend to order the first phase scan's read of lock
counters with the flipping of the index.

However, such ordering is already enforced because of the
control-dependency between the 2 scans. We would be flipping the index
only if lock and unlock counts matched.

But such match will not happen if there was a pending reader before the flip
in the first place (observation courtesy Mathieu Desnoyers).

The litmus test below shows this:
(test courtesy Frederic Weisbecker, Changes for ctrldep by Boqun/me):

C srcu

{}

// updater
P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
        int lock1;
        int unlock1;
        int lock0;
        int unlock0;

        // SCAN1
        unlock1 = READ_ONCE(*UNLOCK1);
        smp_mb(); // A
        lock1 = READ_ONCE(*LOCK1);

        // FLIP
        if (lock1 == unlock1) {         // Control dep
                smp_mb(); // E
                WRITE_ONCE(*IDX, 1);
                smp_mb(); // D

                // SCAN2
                unlock0 = READ_ONCE(*UNLOCK0);
                smp_mb(); // A
                lock0 = READ_ONCE(*LOCK0);
        }
}

// reader
P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
        int tmp;
        int idx1;
        int idx2;

        // 1st reader
        idx1 = READ_ONCE(*IDX);
        if (idx1 == 0) {
                tmp = READ_ONCE(*LOCK0);
                WRITE_ONCE(*LOCK0, tmp + 1);
                smp_mb(); /* B and C */
                tmp = READ_ONCE(*UNLOCK0);
                WRITE_ONCE(*UNLOCK0, tmp + 1);
        } else {
                tmp = READ_ONCE(*LOCK1);
                WRITE_ONCE(*LOCK1, tmp + 1);
                smp_mb(); /* B and C */
                tmp = READ_ONCE(*UNLOCK1);
                WRITE_ONCE(*UNLOCK1, tmp + 1);
        }

        // second reader
        idx2 = READ_ONCE(*IDX);
        if (idx2 == 0) {
                tmp = READ_ONCE(*LOCK0);
                WRITE_ONCE(*LOCK0, tmp + 1);
                smp_mb(); /* B and C */
                tmp = READ_ONCE(*UNLOCK0);
                WRITE_ONCE(*UNLOCK0, tmp + 1);
        } else {
                tmp = READ_ONCE(*LOCK1);
                WRITE_ONCE(*LOCK1, tmp + 1);
                smp_mb(); /* B and C */
                tmp = READ_ONCE(*UNLOCK1);
                WRITE_ONCE(*UNLOCK1, tmp + 1);
        }
}

The following bad condition will not occur even if memory barrier E
is dropped:

(* bad condition: SCAN1 saw lock count changes though 1st reader saw flip *)
 exists (0:lock1=1 /\ 1:idx1=1 /\ 1:idx2=1)

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/srcutree.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..d1368d64fdba 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -983,15 +983,9 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Ensure that if this updater saw a given reader's increment
-	 * from __srcu_read_lock(), that reader was using an old value
-	 * of ->srcu_idx.  Also ensure that if a given reader sees the
-	 * new value of ->srcu_idx, this updater's earlier scans cannot
-	 * have seen that reader's increments (which is OK, because this
-	 * grace period need not wait on that reader).
+	 * Control dependency locks==unlocks ensures that if a reader sees the
+	 * flip, previous scan would only see before-flip reader lock counts.
 	 */
-	smp_mb(); /* E */  /* Pairs with B and C. */
-
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 
 	/*
-- 
2.39.0.314.g84b9a713c41-goog

