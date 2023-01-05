Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94265E1FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjAEAtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjAEAtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:49:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C214A1BA;
        Wed,  4 Jan 2023 16:45:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7943F618A8;
        Thu,  5 Jan 2023 00:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE26C433A1;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879503;
        bh=7+wvkg80uwHKFycQvuCSaMt0ylXExtbV/M9gEYRenqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHJ56Hyx6z+mwKPO9NfRHlSVZzfNVeZ/r1xp004c8MB7ycsOKmhbsRAl13ci0aRHD
         gIJELgqgwo/WL0hzuMzuBx1nbPQAKwjGNnKEMY0x5ppNVZnnXEQoQxZpOGkxE4z57L
         7GChdO3O3Tac541emQDjoMbzYhxkJzsjb18Tq6UkJj0tVRpPOuwmuxZxV1vyn+UjFm
         RRt9AUvSqbrO0dgMmYnr5hvf/ucFQ9j7Fx73FgfLsUQUrSxyUjhT2N4tXIWzcy3iY+
         BdLFwHB/cze60GHBYept2Mt6UsT1n06TPGHfxTOJKfuQXHZ6zlO9LOkA6fCgBSBd+v
         vKWyV1QEYG9VA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE7A85C1C78; Wed,  4 Jan 2023 16:45:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH rcu 6/7] rcutorture: Drop sparse lock-acquisition annotations
Date:   Wed,  4 Jan 2023 16:45:00 -0800
Message-Id: <20230105004501.1771332-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
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

The sparse __acquires() and __releases() annotations provide very
little value.  The argument is ignored, so sparse cannot tell the
differences between acquiring one lock and releasing another on the one
hand and acquiring and releasing a given lock on the other.  In addition,
lockdep annotations provide much more precision, for but one example,
actually knowing which lock is held.

This commit therefore removes the __acquires() and __releases()
annotations from rcutorture.

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 634df26a2c27c..8e6c023212cb3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -399,7 +399,7 @@ static int torture_readlock_not_held(void)
 	return rcu_read_lock_bh_held() || rcu_read_lock_sched_held();
 }
 
-static int rcu_torture_read_lock(void) __acquires(RCU)
+static int rcu_torture_read_lock(void)
 {
 	rcu_read_lock();
 	return 0;
@@ -441,7 +441,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	}
 }
 
-static void rcu_torture_read_unlock(int idx) __releases(RCU)
+static void rcu_torture_read_unlock(int idx)
 {
 	rcu_read_unlock();
 }
@@ -625,7 +625,7 @@ static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
 static struct rcu_torture_ops srcud_ops;
 
-static int srcu_torture_read_lock(void) __acquires(srcu_ctlp)
+static int srcu_torture_read_lock(void)
 {
 	if (cur_ops == &srcud_ops)
 		return srcu_read_lock_nmisafe(srcu_ctlp);
@@ -652,7 +652,7 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	}
 }
 
-static void srcu_torture_read_unlock(int idx) __releases(srcu_ctlp)
+static void srcu_torture_read_unlock(int idx)
 {
 	if (cur_ops == &srcud_ops)
 		srcu_read_unlock_nmisafe(srcu_ctlp, idx);
@@ -814,13 +814,13 @@ static void synchronize_rcu_trivial(void)
 	}
 }
 
-static int rcu_torture_read_lock_trivial(void) __acquires(RCU)
+static int rcu_torture_read_lock_trivial(void)
 {
 	preempt_disable();
 	return 0;
 }
 
-static void rcu_torture_read_unlock_trivial(int idx) __releases(RCU)
+static void rcu_torture_read_unlock_trivial(int idx)
 {
 	preempt_enable();
 }
-- 
2.31.1.189.g2e36527f23

