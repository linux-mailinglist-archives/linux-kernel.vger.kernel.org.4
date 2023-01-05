Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD765E916
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjAEKhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjAEKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:36:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F4C37240;
        Thu,  5 Jan 2023 02:36:45 -0800 (PST)
Date:   Thu, 05 Jan 2023 10:36:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672915002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42Z11cFLGIah66u4IrHHvK0enZoFEPHbHFEuy4SF86c=;
        b=RE+Mf4VUojsfZPLKgID3IyHN8Mhl52IQmD5I3F0xbMKBONmVPiSax/i8C55WC5fxUnBLkb
        nFANMG4Ehdd2d3/bwefQh6Fel1fVp0irtdDf5PkRRoFROh+dUJIVVYGL7QIUqBSUd8n6lN
        NYISAuzJSl99G61Bf422DDKF2pGl/JA1dW44FAXa59nkpKrG3pXd+q4lr2m5sN1Zrk8ClI
        ixzOsjw9UJrWJ2nN0U2aPgPcgwUbwNX59hyLPzbpywelCU3YBRl4OoFtT4lZoF0XUKeWIZ
        7+oksfXlVFKj1aWsJyk9/StsXSDd9hr46Hz569f8QU+ZAPmQgkY2epDNxjE/yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672915002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42Z11cFLGIah66u4IrHHvK0enZoFEPHbHFEuy4SF86c=;
        b=AG52u1YHBCe1LxGig9CtlTMhYnVBWxvdW8IWRcHTG/Fcl72OZI1nYWS/qIp0Ln22jDZBoD
        Fn5TrJy9xQh2sgDg==
From:   "tip-bot2 for Guo Ren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/qspinlock: Micro-optimize pending state
 waiting for unlock
Cc:     Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230105021952.3090070-1-guoren@kernel.org>
References: <20230105021952.3090070-1-guoren@kernel.org>
MIME-Version: 1.0
Message-ID: <167291500186.4906.9745084237766663051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4282494a20cdcaf38d553f2c2ff6f252084f979c
Gitweb:        https://git.kernel.org/tip/4282494a20cdcaf38d553f2c2ff6f252084f979c
Author:        Guo Ren <guoren@linux.alibaba.com>
AuthorDate:    Wed, 04 Jan 2023 21:19:52 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Jan 2023 11:01:50 +01:00

locking/qspinlock: Micro-optimize pending state waiting for unlock

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

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20230105021952.3090070-1-guoren@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/qspinlock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2b23378..ebe6b8e 100644
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
