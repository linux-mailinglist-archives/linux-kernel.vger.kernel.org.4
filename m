Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018C065C56F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbjACRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbjACRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:53:38 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE8E10B67
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:53:37 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h21so25084707qta.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 09:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3lJPOWgS9gmsVyQJhhMopaN46rhZdwXt5/TWv91+AM=;
        b=sx78T575rkzRQ1xyJ0XJDbAOm3msaUet2neJ8FxIbPzxNm+/Pj5IJHNyWd949YDqCx
         N/h11soxlNwdyogCcdguHHnd8pSD1NxwlN6iK5PStXTFe2mbAXRRhb6MNrgvs+ttR0f6
         8ldUuEl3RadmySoPBmcYvN12ot2mpRUEGC+nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3lJPOWgS9gmsVyQJhhMopaN46rhZdwXt5/TWv91+AM=;
        b=4s3k1UNs6ZzFd1zXGNj3dRX/V6Ouhh+Hdas0rafuHwsJK4uJgnFqEAFfvLDOuIHLTd
         ft0yJ1wda2t2xAYC8JxddETQ7PHf5LebA/iem1dYWDt7KulYH1HmTJtpuAfd4NJaLEYi
         mFE2SLM+oUO3M0Cu964f8D237ixoHDVAHK3Fim4PozhcJKY8exEREVb4aUEeQJVeWNhx
         RmIiClojo1McqUnuWCe9U/Usf1PFdWbM1+wY0JeGWTUD+Jtk85spkDOPazUqhlPYpLsv
         rItPdbrpt404FQVJcDKemSXblZqGRh7nzy+KbLq+LraboDZRDVXGPkeHbmaWc95UTBg4
         4qYQ==
X-Gm-Message-State: AFqh2kqaQyRnn6a1hUqOZn14EZENyHYzqwZ3grJ1GsxEQH89SAAjQs/m
        gqotFmxNL9iu8mR5T99Zbo2Wy4pEt/ic+xEW
X-Google-Smtp-Source: AMrXdXutdee2UENiJl42RFuOVUHGIRRJgHkozXbKmn9JZf/efMbI2kZ377ReUqxftt3A7Kc0UV6jkQ==
X-Received: by 2002:ac8:5481:0:b0:3a7:e2df:e868 with SMTP id h1-20020ac85481000000b003a7e2dfe868mr54522820qtq.41.1672768416180;
        Tue, 03 Jan 2023 09:53:36 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u15-20020a37ab0f000000b006fafc111b12sm22253412qke.83.2023.01.03.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:53:35 -0800 (PST)
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
Subject: [PATCH v2] srcu: Remove memory barrier "E" as it does not do anything
Date:   Tue,  3 Jan 2023 17:53:21 +0000
Message-Id: <20230103175321.1910864-1-joel@joelfernandes.org>
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

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
v1->v2: Update changelog, keep old comments.


 kernel/rcu/srcutree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..0f9ba0f9fd12 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -983,15 +983,15 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Ensure that if this updater saw a given reader's increment
-	 * from __srcu_read_lock(), that reader was using an old value
-	 * of ->srcu_idx.  Also ensure that if a given reader sees the
-	 * new value of ->srcu_idx, this updater's earlier scans cannot
-	 * have seen that reader's increments (which is OK, because this
-	 * grace period need not wait on that reader).
+	 * Control dependencies on both reader and updater side ensures that if
+	 * this updater saw a given reader's increment from __srcu_read_lock(),
+	 * that reader was using an old value of ->srcu_idx.  Also ensures that
+	 * if a given reader sees the new value of ->srcu_idx, this updater's
+	 * earlier scans cannot have seen that reader's increments (which is
+	 * OK, because this grace period need not wait on that reader).
+	 *
+	 * So no need for an smp_mb() before incrementing srcu_idx.
 	 */
-	smp_mb(); /* E */  /* Pairs with B and C. */
-
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 
 	/*
-- 
2.39.0.314.g84b9a713c41-goog
