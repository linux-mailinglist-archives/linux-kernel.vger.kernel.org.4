Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1967F483
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjA1D7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjA1D7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:59:07 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CA79F11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:59:06 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g16so5792323qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHcWkiK2q6vininDacdGdov5aGnkXeS+Opi5lg+y9ow=;
        b=jsRRDoAsw4PuBcuPBo5p5M/FPm5JAJJm2QpqRfc18jDxJf75DZAulZuAefJFLkAXeS
         F2tUA0mJ24KUqgpR6Olom1A3kd0ABLsiajg+d55p4204hya0BM8VXlUrYcMuFlQhUj8E
         ClPrkiLPq6gZzaCZHxJX6oK2rRK1qFz5JnXm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHcWkiK2q6vininDacdGdov5aGnkXeS+Opi5lg+y9ow=;
        b=H175ZNKJ8R1P87XliYl9DcLWv8mNUX/BgSvbnDRtWUUPOjXOvUpA7Tvo7JwYnHNakL
         81GeP5eUduUbsA5wl0yUrF8FlYqphiv0RXSBMXuJ9YUk7vXT+Z4eeWQckC39jw4NaNmT
         cpnZuVdqmGybQ9x1AzfqpHMoyt7hnwidYMChIAC0X/Ao41Rqkn6JtQoC+Vv4m3vKy/Ap
         Wg7eMH+HIikpySsmVSc212L2RBAadnzLDTf74MrbTQsM4ZGaJBNPQ0mfyTtEzP9Ce+sT
         GZyZChjOHuZKrG5hvuk7f35Qvetw9NyW9uvqLgVLslFddtKr+XrpLStHTAE0MGfVFkUD
         HN+g==
X-Gm-Message-State: AO0yUKWO+V7fF9gIwlfiJclcYjxTcUtL0MfJu/lBrIbebiZjAOnLYntV
        z7Y/VqcnIjt9rgraxEBvgLVh+5ZwV1cJl5Os
X-Google-Smtp-Source: AK7set/dqSKf0eKWCc5plFFGCR8+/pBnZav0bw1ieKJwYQ6LdYFoPp2IuWFxQIJTFt8vf54PRg5iNA==
X-Received: by 2002:a05:622a:1207:b0:3b8:2ea9:a09c with SMTP id y7-20020a05622a120700b003b82ea9a09cmr4373829qtx.1.1674878345080;
        Fri, 27 Jan 2023 19:59:05 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id r21-20020ac84255000000b003b635009149sm3865663qtm.72.2023.01.27.19.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 19:59:04 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v4] srcu: Clarify comments on memory barrier "E"
Date:   Sat, 28 Jan 2023 03:59:01 +0000
Message-Id: <20230128035902.1758726-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
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

More complicated litmus tests with multiple SRCU readers also show that memory
barrier E is not needed.

This commit therefore clarifies the comment on memory barrier E while keeping
the memory barrier anyway for extra safety (since it is on a slow path anyway).

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Update changelog, keep old comments.
v2->v3: Moar changelog updates.
v3->v4: Keep smp_mb() and just update comments

 cc_list               |  8 ++++++++
 kernel/rcu/srcutree.c | 20 ++++++++++++++------
 send.sh               |  5 +++++
 to_list               |  1 +
 4 files changed, 28 insertions(+), 6 deletions(-)
 create mode 100644 cc_list
 create mode 100755 send.sh
 create mode 100644 to_list

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..2872998edbb7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -983,12 +983,20 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Ensure that if this updater saw a given reader's increment
-	 * from __srcu_read_lock(), that reader was using an old value
-	 * of ->srcu_idx.  Also ensure that if a given reader sees the
-	 * new value of ->srcu_idx, this updater's earlier scans cannot
-	 * have seen that reader's increments (which is OK, because this
-	 * grace period need not wait on that reader).
+	 * Control dependency (causality) between the before-flip
+	 * srcu_readers_active_idx_check() and a call to srcu_flip(), ensures
+	 * that we end up here only if lock and unlock counts match.  This fact
+	 * ensures that if this updater saw a given reader's increment from
+	 * __srcu_read_lock(), that reader was using an old value of
+	 * ->srcu_idx. That is why the lock and unlock counts matched in the
+	 * first place. The causality also ensures that if a given reader sees
+	 * the new value of ->srcu_idx, this updater's earlier scans cannot
+	 * have seen that reader's increments (which is OK, because this grace
+	 * period need not wait on that reader), because again, that would
+	 * cause a lock/unlock count mismatch and we not end up here.
+	 *
+	 * So we don't really need the following smp_mb() before incrementing
+	 * srcu_idx, however we have it anyway for additional safety.
 	 */
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
-- 
2.39.1.456.gfc5497dd1b-goog
