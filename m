Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389DA6FA1FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjEHIQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjEHIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:16:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B798F3C34
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683533763; x=1715069763;
  h=from:to:cc:subject:date:message-id;
  bh=tLUH/bGNzy2lFq4ntkONNzY8WwFRfNEvq/WBkxI5uQM=;
  b=F+rDdGqKmKHDcR/TdWJdDy2QarqklSzNiSGX1WllDOEY9+KNGAfldt1A
   SkqCk5JsQHXo0tgtqY0970bLLdXff//i2Np4CdSkMcjTL5BMns3PuKFXK
   0ePWOeZh70gNc3H26WjOuvWJxjhXvXhXRQFAonMzAdLUYP8bSAlhG6Jrr
   PUgxP/xcsgw00lB8eF7zuJ3rw1HJRj5KYDQ+khAub76V6jUDdCJZ5cda3
   YaYpoLFHRoyE/4yujbDmGruaoCRs6fmXomz/Pg73wJjl3J3XqAIADLfup
   hvYBQdcDaWfIVTf6vnITMIZ1zBw6D82Kj37jelyUnTS642Q8szVc4cqPu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="334027245"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="334027245"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="1028335675"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="1028335675"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:16:00 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on locked_pending bits
Date:   Mon,  8 May 2023 16:15:32 +0800
Message-Id: <20230508081532.36379-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1st spinner (header of the MCS queue) spins on the whole qspinlock
variable to check whether the lock is released. For a contended qspinlock,
this spinning is a hotspot as each CPU queued in the MCS queue performs
the spinning when it becomes the 1st spinner (header of the MCS queue).

The granularity among SMT h/w threads in the same core could be "byte"
which the Load-Store Unit (LSU) inside the core handles. Making the 1st
spinner only spin on locked_pending bits (not the whole qspinlock) can
avoid the false dependency between the tail field and the locked_pending
field. So this micro-optimization helps the h/w thread (the 1st spinner)
stay in a low power state and prevents it from being woken up by other
h/w threads in the same core when they perform xchg_tail() to update
the tail field. Please see a similar discussion in the link [1].

[1] https://lore.kernel.org/r/20230105021952.3090070-1-guoren@kernel.org

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 kernel/locking/qspinlock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index efebbf19f887..e7b990b28610 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -513,7 +513,20 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if ((val = pv_wait_head_or_lock(lock, node)))
 		goto locked;
 
+#if _Q_PENDING_BITS == 8
+	/*
+	 * Spinning on the 2-byte locked_pending instead of the 4-byte qspinlock
+	 * variable can avoid the false dependency between the tail field and
+	 * the locked_pending field. This helps the h/w thread (the 1st spinner)
+	 * stay in a low power state and prevents it from being woken up by other
+	 * h/w threads in the same core when they perform xchg_tail() to update
+	 * the tail field only.
+	 */
+	smp_cond_load_acquire(&lock->locked_pending, !VAL);
+	val = atomic_read_acquire(&lock->val);
+#else
 	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+#endif
 
 locked:
 	/*
-- 
2.17.1

