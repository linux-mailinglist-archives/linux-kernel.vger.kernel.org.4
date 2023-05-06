Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38F6F8F2C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjEFGbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjEFGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:31:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ACD93EA
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683354639; x=1714890639;
  h=from:to:cc:subject:date:message-id;
  bh=iyMpxKPgiMYjzyLqZMSzHcOUu2jMWbGXnRDg9G+cCnM=;
  b=Q8EbQd3RnEX3ProL3nlkJ/kb7J6vsM6oTw/EME3RM8SIfUCNDTdhXICS
   Zmk7dV3MQ8twF/cYb+qP4AxQ6c/obgq/G9wr8Q+9ddXpkzsBW3ad1xtUl
   k4Uf0RGhUVHb9g/xhgmp+bjzFAPT/NtwrkrsHynz4KqV6EnkmFMKdttT+
   9D4AbopJ+xDqcLDYe0EKjZKoZH02rvy9LQ5SiPkaIweYkpByNouBtQ767
   Dxa4qGBWBeBNfSiMV62wGwilpH+xm0atj80uyI0shJD7l5Bu7UWqAXW9Z
   m0AsvcKXt1FH3hQFSAchZ+aivagZzYllX+VVZ8t2ky/V93mWgr7tgStIq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="328975922"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="328975922"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 23:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="842068898"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="842068898"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 23:30:00 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in comments
Date:   Sat,  6 May 2023 14:29:34 +0800
Message-Id: <20230506062934.69652-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. There may be concurrent locker CPUs to set the qspinlock pending bit.

   The first CPU (called pending CPU) of these CPUs sets the pending
   bit to make the state transition (the qspinlock pending bit is set):

         0,0,* -> 0,1,*

   The rest of these CPUs are queued to the MCS queue to make the state
   transition (the qspinlock tail is updated):

         0,1,* -> *,1,*

   The pending CPU waits until the locker owner goes away to make
   the state transition (the qspinlock locked field is set to zero):

         *,1,* -> *,1,0

   The pending CPU takes the ownership and clears the pending bit
   to make the state transition:

         *,1,0 -> *,0,1

2. The header of the MCS queue takes the ownership and calls set_locked()
   to make the state transition:

         *,*,0 -> *,*,1

Fix the state-transition changes above in the code comments accordingly.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 kernel/locking/qspinlock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ebe6b8ec7cb3..efebbf19f887 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -257,7 +257,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
  * set_locked - Set the lock bit and own the lock
  * @lock: Pointer to queued spinlock structure
  *
- * *,*,0 -> *,0,1
+ * *,*,0 -> *,*,1
  */
 static __always_inline void set_locked(struct qspinlock *lock)
 {
@@ -348,7 +348,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * trylock || pending
 	 *
-	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
+	 * 0,0,* -> 0,1,* -> ... -> *,0,1 pending, trylock
 	 */
 	val = queued_fetch_set_pending_acquire(lock);
 
@@ -358,6 +358,8 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * Undo and queue; our setting of PENDING might have made the
 	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
 	 * on @next to become !NULL.
+	 *
+	 * 0,1,* -> *,1,*
 	 */
 	if (unlikely(val & ~_Q_LOCKED_MASK)) {
 
@@ -371,7 +373,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * We're pending, wait for the owner to go away.
 	 *
-	 * 0,1,1 -> *,1,0
+	 * *,1,* -> *,1,0
 	 *
 	 * this wait loop must be a load-acquire such that we match the
 	 * store-release that clears the locked bit and create lock
@@ -385,7 +387,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * take ownership and clear the pending bit.
 	 *
-	 * 0,1,0 -> 0,0,1
+	 * *,1,0 -> *,0,1
 	 */
 	clear_pending_set_locked(lock);
 	lockevent_inc(lock_pending);
-- 
2.17.1

