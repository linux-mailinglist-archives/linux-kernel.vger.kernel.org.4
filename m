Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813D06BBD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjCOTjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjCOTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:39:17 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A161EBC1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n2so1332869qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toQXaUPvgeCcBAYiqMckeG88YIHFRuFoSXsrXPxs/ek=;
        b=aabRxvDGfMHTAOu1rCeWRfKFoj8/e+eofwzwu8sq5N2xxVoIbfEUCAmOtm4OtV0cEM
         3LC2KDAp5IS7KK4K4qQLtxP+KXkQLpgZCw7uQ3zAxC4x1kEb19UNY5xIzVJMNoBQ+28S
         TFUhDoS/SN+A3vUukWz6JmpFnyeYUZO7AUhd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toQXaUPvgeCcBAYiqMckeG88YIHFRuFoSXsrXPxs/ek=;
        b=UWbwhqfU4+Zvb+R1hgERQoYiF4wdL3GB3Sfs36wdZ2BL0P/0FHCGYT2dj1DmU7mB7o
         h+UEN+O54nLVHPOFtPa9F/hicsVCvo3UeolgtV54E5fsaS50YGZMFxxqhfvHcMSKvwxP
         GHGE5N8+2g7Vj2+NW6qqsCqKmDKqWbFaYv3qrbEDV13pnzj+mP45Fi00EGk4VDqGMKfP
         pzezbWIm0zvPl0yq9uOmTOjekIenRUN3ymM2Sm6ZmraT8TDjiIGt3a1mEQqKJ0U1VWst
         XTwSldwlzRZsRf4x1b2G/jWWV1MNa9wPMvevpCYsGSaaKcDwTWAoe/gei1kBasPNF7Bt
         rmGQ==
X-Gm-Message-State: AO0yUKVUIHvfUoRHQ+tN1ULrbs/decUIgExlR5Qd7EZciqvd8SE7pvjD
        19N018hgZCmK7jvM4SSJgUkhhLkYdGFjdazIZj0=
X-Google-Smtp-Source: AK7set+O2OmB6N6d0SpCuwIUEUsFxeLjjnIp7nmGbwF1he2wDDp+9RyhFBCbjYaZ8NBaYgMgM66zVA==
X-Received: by 2002:a05:622a:1d5:b0:3b9:b761:b0a0 with SMTP id t21-20020a05622a01d500b003b9b761b0a0mr2005215qtw.12.1678909153579;
        Wed, 15 Mar 2023 12:39:13 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b00745af48838bsm4347227qko.5.2023.03.15.12.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:39:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH 3/6] srcu: Clarify comments on memory barrier "E"
Date:   Wed, 15 Mar 2023 19:38:48 +0000
Message-Id: <20230315193851.8598-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315193851.8598-1-joel@joelfernandes.org>
References: <20230315193851.8598-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an smp_mb() named "E" in srcu_flip() immediately before the
increment (flip) of the srcu_struct structure's ->srcu_idx.

The purpose of E is to order the preceding scan's read of lock counters
against the flipping of the ->srcu_idx, in order to prevent new readers
from continuing to use the old ->srcu_idx value, which might needlessly
extend the grace period.

However, this ordering is already enforced because of the control
dependency between the preceding scan and the ->srcu_idx flip.
This control dependency exists because atomic_long_read() is used
to scan the counts, because WRITE_ONCE() is used to flip ->srcu_idx,
and because ->srcu_idx is not flipped until the ->srcu_lock_count[] and
->srcu_unlock_count[] counts match.  And such a match cannot happen when
there is an in-flight reader that started before the flip (observation
courtesy Mathieu Desnoyers).

The litmus test below (courtesy of Frederic Weisbecker, with changes
for ctrldep by Boqun and Joel) shows this:

C srcu
(*
 * bad condition: P0's first scan (SCAN1) saw P1's idx=0 LOCK count inc, though P1 saw flip.
 *
 * So basically, the ->po ordering on both P0 and P1 is enforced via ->ppo
 * (control deps) on both sides, and both P0 and P1 are interconnected by ->rf
 * relations. Combining the ->ppo with ->rf, a cycle is impossible.
 *)

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
        if (lock1 == unlock1) {   // Control dep
                smp_mb(); // E    // Remove E and still passes.
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
        if (idx1 == 0) {         // Control dep
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

exists (0:lock1=1 /\ 1:idx1=1)

More complicated litmus tests with multiple SRCU readers also show that
memory barrier E is not needed.

This commit therefore clarifies the comment on memory barrier E.

Why not also remove that redundant smp_mb()?

Because control dependencies are quite fragile due to their not being
recognized by most compilers and tools.  Control dependencies therefore
exact an ongoing maintenance burden, and such a burden cannot be justified
in this slowpath.  Therefore, that smp_mb() stays until such time as
its overhead becomes a measurable problem in a real workload running on
a real production system, or until such time as compilers start paying
attention to this sort of control dependency.

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/srcutree.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ab4ee58af84b..68f89c533057 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1085,16 +1085,36 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Ensure that if this updater saw a given reader's increment
-	 * from __srcu_read_lock(), that reader was using an old value
-	 * of ->srcu_idx.  Also ensure that if a given reader sees the
-	 * new value of ->srcu_idx, this updater's earlier scans cannot
-	 * have seen that reader's increments (which is OK, because this
-	 * grace period need not wait on that reader).
+	 * Because the flip of ->srcu_idx is executed only if the
+	 * preceding call to srcu_readers_active_idx_check() found that
+	 * the ->srcu_unlock_count[] and ->srcu_lock_count[] sums matched
+	 * and because that summing uses atomic_long_read(), there is
+	 * ordering due to a control dependency between that summing and
+	 * the WRITE_ONCE() in this call to srcu_flip().  This ordering
+	 * ensures that if this updater saw a given reader's increment from
+	 * __srcu_read_lock(), that reader was using a value of ->srcu_idx
+	 * from before the previous call to srcu_flip(), which should be
+	 * quite rare.  This ordering thus helps forward progress because
+	 * the grace period could otherwise be delayed by additional
+	 * calls to __srcu_read_lock() using that old (soon to be new)
+	 * value of ->srcu_idx.
+	 *
+	 * This sum-equality check and ordering also ensures that if
+	 * a given call to __srcu_read_lock() uses the new value of
+	 * ->srcu_idx, this updater's earlier scans cannot have seen
+	 * that reader's increments, which is all to the good, because
+	 * this grace period need not wait on that reader.  After all,
+	 * if those earlier scans had seen that reader, there would have
+	 * been a sum mismatch and this code would not be reached.
+	 *
+	 * This means that the following smp_mb() is redundant, but
+	 * it stays until either (1) Compilers learn about this sort of
+	 * control dependency or (2) Some production workload running on
+	 * a production system is unduly delayed by this slowpath smp_mb().
 	 */
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
-	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
+	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
 
 	/*
 	 * Ensure that if the updater misses an __srcu_read_unlock()
-- 
2.40.0.rc1.284.g88254d51c5-goog

