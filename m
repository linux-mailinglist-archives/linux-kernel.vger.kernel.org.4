Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B67265E191
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbjAEAcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjAEAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F34FD48;
        Wed,  4 Jan 2023 16:29:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C1406188D;
        Thu,  5 Jan 2023 00:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D6DC43398;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878534;
        bh=clwCQkPF4F/ngvkSd6SVUnihXMpKsLHfzXEpdQWvTm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iS7d50S2mQghaxAq24TLspOJsEYbJeunuWsteD3ipT5NcOhtdv2rVxEHbtSyQCQAx
         xGsszsTs9p2Rk0l3NBK1g7G8zz2HHQ8bVGTANND6+tDvk6gJ/KVrAie4SoscTgJs6P
         89mkFn6y/fLZKQOOYjWHXNUjiIXB0xs/Y28jFf0KJtNYDkRjx7m4hmeODHvNaUShTu
         9a+ZkLpGMADrXoY6v0cmkdtvZ7wC8lLG8fe2XkOkuaaFdBs8PpWOLSLJ1mq9LP4jXO
         4WvU9s15B1iFoQLBChKH7UELDxErkPUYhG6leSzCfV+55sutahh+z/BbFGocvlLN0c
         hOc4sEY7rgFaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 549935C1C5D; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 9/9] srcu: Update comment after the index flip
Date:   Wed,  4 Jan 2023 16:28:53 -0800
Message-Id: <20230105002853.1769401-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because there is not guaranteed to be a full memory barrier between
the ->srcu_unlock_count increment of an srcu_read_unlock() and the
->srcu_lock_count increment of the next srcu_read_lock(), this next
srcu_read_lock() is not guaranteed to see the effect of the index flip
just prior to this comment.  However, this next srcu_read_lock() will
execute a full memory barrier, so the srcu_read_lock() after that is
guaranteed to see that index flip.

This guarantee is illustrated by the following diagram of events and
the litmus test following that.

------------------------------------------------------------------------

READER                  UPDATER
-------------           ----------
                           // idx is initially 0.

                           srcu_flip() {
                              smp_mb();
// RSCS

srcu_read_unlock() {
  smp_mb();
                              idx++;    // P
                              smp_mb(); // QQ
                           }

                           srcu_readers_unlock_idx(0) {
        ,--counted------------ count all unlock[0]; // Q
        |
  unlock[0]++;  // X

}
                               smp_mb();
srcu_read_lock() {
  READ(idx) = 0;         ,---- count all lock[0]; // contributes imbalance of 1.
  lock[0]++;  ----counted              |
  smp_mb(); // PP          }           |
}                                      |
                                       |
// RSCS                             not going to effect above scan
                                       |
srcu_read_unlock() {                   |
  smp_mb();                            |
  unlock[0]++;                         |
}                                      |
                                      /
                                     /
srcu_read_lock() {                  |
  READ(idx);  // Y  -----cannot be counted because of P (has to sample idx as 1)
  lock[1]++;
  ...
}

------------------------------------------------------------------------

This makes it similar to the store buffer pattern. Using X, Y, P and Q
annotated above, we get:

------------------------------------------------------------------------

READER                    UPDATER
X (write)                 P (write)

smp_mb(); //PP            smp_mb(); //QQ

Y (read)                  Q (read)

------------------------------------------------------------------------

ASCII art courtesy of Joel Fernandes.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Frederic Weisbecker <frederic@kernel.org>
Reported-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d2d2e31c42b13..ab4ee58af84bf 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1098,10 +1098,11 @@ static void srcu_flip(struct srcu_struct *ssp)
 
 	/*
 	 * Ensure that if the updater misses an __srcu_read_unlock()
-	 * increment, that task's next __srcu_read_lock() will see the
-	 * above counter update.  Note that both this memory barrier
-	 * and the one in srcu_readers_active_idx_check() provide the
-	 * guarantee for __srcu_read_lock().
+	 * increment, that task's __srcu_read_lock() following its next
+	 * __srcu_read_lock() or __srcu_read_unlock() will see the above
+	 * counter update.  Note that both this memory barrier and the
+	 * one in srcu_readers_active_idx_check() provide the guarantee
+	 * for __srcu_read_lock().
 	 */
 	smp_mb(); /* D */  /* Pairs with C. */
 }
-- 
2.31.1.189.g2e36527f23

