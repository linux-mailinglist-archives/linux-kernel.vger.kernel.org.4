Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA376FC071
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjEIH3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjEIH3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:29:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B1210D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683617375; x=1715153375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=n3xp3Oxep/6XUd0YYFwl+lzYWyDoeEYTha+L0N5Dz7U=;
  b=RDIv5oe9Eg3/QICIbXiZY5ruLcbJTgvPv8KocUecJBOa4FtwFrPQm1cs
   RnwHEm6iDQosrJn45Z5+3z3v6Pg0umcF0bHPHMi4NkoAIwgsvemnCyFi7
   VLNH0q60EyDxQ4XlKrTyfFvl1g10K/UCcG2kjvEgGEtTw1nl+nttWQqd0
   3noLbymqgSBTDT7P480hy9+ruRG/e90Q7jh1eCcY8nF+Sdzmw32J65fKm
   iglEcKReEl3o5nQcovcj2YEi/i5Wy/HkcHMa6lgaPdG+15Fmt8GLQHFmu
   +DRtQDsE4TvIIrL94UqFyRA+9hyRyybef7DCqwiHlC5jJ5SJKh7Jyb5XC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="377926191"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="377926191"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 00:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="822963526"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="822963526"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 00:29:31 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] locking/qspinlock: Fix state-transition changes in comments
Date:   Tue,  9 May 2023 15:29:02 +0800
Message-Id: <20230509072902.66284-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <IA1PR11MB6171282A1E2CF22740398F8989769@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <IA1PR11MB6171282A1E2CF22740398F8989769@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. set_locked() only sets the locked field to 1 and doesn't touch
   the pending field. So the correct lock state transition is:

         *,*,0 -> *,*,1

2. The initial lock state when calling clear_pending_set_locked() is
   the state just after waiting for the locker goes away. So the
   state transition for clear_pending_set_locked() is:

         *,1,0 -> *,0,1

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 v1->v2:
 - Drop the state transition comments fixes (viewed from the current lock word value).
 - Update the commit message accordingly.

 kernel/locking/qspinlock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ebe6b8ec7cb3..256021c87ac1 100644
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
@@ -385,7 +385,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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

