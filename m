Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18265E2E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAECUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAECUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:20:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716394434F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 18:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0866660C66
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF737C433D2;
        Thu,  5 Jan 2023 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672885210;
        bh=/SL1cw00zjWKqQA9YmCfWS3ctN560Kt6tflCeeJfqsU=;
        h=From:To:Cc:Subject:Date:From;
        b=lG+Bni8f9lRDVoQd//3F1jqGsXEMdt+C8POcXcexP3/blv39bMQnCKYUod0/Jr08V
         6UXLD3rRZV+ECY2Gg7rwWjzBSozdkCnUXnh3eIjUqqoQi2waYIX4lRDYZS57q61qWC
         yf+HNl+DX4Qu71pysuAtyGKGcmkxNScTjhzHujmI5nzcAxDQ7Unc5kHRIEkFpKseCM
         LQxeXfx7uKjOQULDFD7cW15GoebXUkVRt6xs852V4UKGM7KysKgYqarRa4cxVKWxCA
         +cJUbmDUDagqBrQPMrp9Pv/OCYP5yVxl8otU3LL/n01gEp2p56vjAdIIfwVUNi3LZx
         /FssF5ggLNRWA==
From:   guoren@kernel.org
To:     peterz@infradead.org, longman@redhat.com, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH V2] locking/qspinlock: Optimize pending state waiting for unlock
Date:   Wed,  4 Jan 2023 21:19:52 -0500
Message-Id: <20230105021952.3090070-1-guoren@kernel.org>
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
resources of pipeline to other hardware threads. This situation is
the SMT scenarios in the same core. Not an entering low-power state
situation. Of course, the granularity between cores is "cacheline",
but the granularity between SMT hw threads of the same core could
be "byte" which internal LSU handles. For example, when a hw-thread
yields the resources of the core to other hw-threads, this patch
could help the hw-thread stay in the sleep state and prevent it
from being woken up by other hw-threads xchg_tail.

Link: https://lore.kernel.org/lkml/20221224120545.262989-1-guoren@kernel.org/
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
Changes in v2:
 - Add acked tag
 - Optimize commit log
 - Add discussion Link tag
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

