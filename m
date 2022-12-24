Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B4655A12
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiLXMG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 07:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLXMGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 07:06:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0D1012
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:06:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE29601C3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 12:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701E4C433EF;
        Sat, 24 Dec 2022 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671883613;
        bh=Lbw0POaZnF+kGvgdPds+fH17Q+0WMb3P+5vjsislLY4=;
        h=From:To:Cc:Subject:Date:From;
        b=rCS4ejFsUQ32fNYAwoAN9QtpY/7IeI2eDTf0t4iYOrCiGQfRQMI1eS9g8am7GiMGv
         MBhcp8TzCkv8XzNqXW3uXyrPcX4WujtBYO93189U15ryHlO53Wt9T2dG6/Y/mAk41u
         q6qtPMqkLtw0CG9A0x8ajNYIfqxn9T/VzuwERXgRmNy9xp36dFhePtUWh1w2NZBQzf
         3BMDXTXM9a12B3Q3cELlPAslbYQvCw7hhqAdi4wIRDEDRPnEeyfqd2J+FAYLgn8NPl
         LAAbABMMZ0rbK5MtnZqV/Bi75OgQJBHk0Jf5Q4K29ZQMlMW2KBaByYecpT2NRvgiwJ
         +NrQnm1GNOOfQ==
From:   guoren@kernel.org
To:     peterz@infradead.org, longman@redhat.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] locking/qspinlock: Optimize pending state waiting for unlock
Date:   Sat, 24 Dec 2022 07:05:45 -0500
Message-Id: <20221224120545.262989-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

From: Guo Ren <guoren@linux.alibaba.com>

When we're pending, we only care about lock value. The xchg_tail
wouldn't affect the pending state. That means the hardware thread
could stay in a sleep state and leaves the rest execution units'
resources of pipeline to other hardware threads. This optimization
may work only for SMT scenarios because the granularity between
cores is cache-block.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/locking/qspinlock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2b23378775fe..ebe6b8ec7cb3 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -371,7 +371,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * We're pending, wait for the owner to go away.
 	 *
-	 * 0,1,1 -> 0,1,0
+	 * 0,1,1 -> *,1,0
 	 *
 	 * this wait loop must be a load-acquire such that we match the
 	 * store-release that clears the locked bit and create lock
@@ -380,7 +380,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * barriers.
 	 */
 	if (val & _Q_LOCKED_MASK)
-		atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
+		smp_cond_load_acquire(&lock->locked, !VAL);
 
 	/*
 	 * take ownership and clear the pending bit.
-- 
2.36.1

