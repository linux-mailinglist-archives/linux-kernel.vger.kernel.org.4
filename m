Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA716667CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjALAgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjALAg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:36:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E013B62C3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:36:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72AA061E89
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B1EC433EF;
        Thu, 12 Jan 2023 00:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673483787;
        bh=IbaBrMYGLmoj1xH3uSne5D7/7LXFcR6qR4kCmMCIZrQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=YvCQnHmWShKbDCakinOSWib2Lhc6TcArDnsbF/Re2PUB4MPEeAPgt4aW5Rsyi+3zN
         X3+waHqMFZU5qRU0DdBSMacavsyBNfSXBu/IR6r2VfjyvtC92xqm/BxO8josEQiWVI
         8wfkGuOQWjmUyOzov0ENbUpnb7XPQQO71jejkvw2OjChV+WMjH2MCPsZqIZByb6SZS
         fWRnF8aRBg44QW7pGO4COXLEFcGsItuqu3d3vEC3esWOGHw6kOME1k7LjgiSGPAhDs
         tJCB7Tag3nA5wzgimhTJbt7AW4fiX44FEE4grJX+zMTxBCqOykMzqWQnOeEmXKRrSg
         MavaYbAiEvZew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 726BD5C0687; Wed, 11 Jan 2023 16:36:27 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:36:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     riel@surriel.com, davej@codemonkey.org.uk
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH diagnostic qspinlock] Diagnostics for excessive lock-drop
 wait loop time
Message-ID: <20230112003627.GA3133092@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We see systems stuck in the queued_spin_lock_slowpath() loop that waits
for the lock to become unlocked in the case where the current CPU has
set pending state.  Therefore, this not-for-mainline commit gives a warning
that includes the lock word state if the loop has been spinning for more
than 10 seconds.  It also adds a WARN_ON_ONCE() that complains if the
lock is not in pending state.

If this is to be placed in production, some reporting mechanism not
involving spinlocks is likely needed, for example, BPF, trace events,
or some combination thereof.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ac5a3e6d3b564..be1440782c4b3 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -379,8 +379,22 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * clear_pending_set_locked() implementations imply full
 	 * barriers.
 	 */
-	if (val & _Q_LOCKED_MASK)
-		atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
+	if (val & _Q_LOCKED_MASK) {
+		int cnt = _Q_PENDING_LOOPS;
+		unsigned long j = jiffies + 10 * HZ;
+		struct qspinlock qval;
+		int val;
+
+		for (;;) {
+			val = atomic_read_acquire(&lock->val);
+			atomic_set(&qval.val, val);
+			WARN_ON_ONCE(!(val & _Q_PENDING_VAL));
+			if (!(val & _Q_LOCKED_MASK))
+				break;
+			if (!--cnt && !WARN(time_after(jiffies, j), "%s: Still pending and locked: %#x (%c%c%#x)\n", __func__, val, ".L"[!!qval.locked], ".P"[!!qval.pending], qval.tail))
+				cnt = _Q_PENDING_LOOPS;
+		}
+	}
 
 	/*
 	 * take ownership and clear the pending bit.
