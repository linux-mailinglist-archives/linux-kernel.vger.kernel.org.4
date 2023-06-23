Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1498273BD8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFWRMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFWRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:12:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD01993
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:12:43 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687540361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMld1PknhyoTTWqIQWTi/haDnPaStkrULY18977v1W8=;
        b=UooxLz/zkoWhq+XAmNcit5ZQDI4n/Y+KVronARo5RtTZ+Tn6qjAbf+SOx/FC241sDV8f4t
        t8HJpjsAu06tlvLNMcBnutuGtTbknm/McJdfqacY7/9mKIMPXaChuyDfV91Lysn8JRgd04
        FEajI9b521OGBvRhaLW4XirU9DI8WhB8c6njc7IoxIwm2p33Jxy1cOxv66rkXxgB5Chru+
        A/FRmn+Hy1gok2d3NWwOZ5rM/Dtjk9URSGAuXs6LWjFMo+DbMSueXkd5UnHH+D8fM0FIeG
        T9YGtSeiToHljMH9F6NvMNkhsbUtBC+W2HnzhVsbBO2nnoCWRzHlsR620hmdWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687540361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMld1PknhyoTTWqIQWTi/haDnPaStkrULY18977v1W8=;
        b=8kTgNXsUUa80s7tfPsheHF9UbSnMTZUFyjFjS52xpo0dV5r9dRvc1KbatV5CicN60n6keS
        OX2i42K9YrjV0vBg==
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.co>, Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/2] mm/page_alloc: Use write_seqlock_irqsave() instead write_seqlock() + local_irq_save().
Date:   Fri, 23 Jun 2023 19:12:32 +0200
Message-Id: <20230623171232.892937-3-bigeasy@linutronix.de>
In-Reply-To: <20230623171232.892937-1-bigeasy@linutronix.de>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__build_all_zonelists() acquires zonelist_update_seq by first disabling
interrupts via local_irq_save() and then acquiring the seqlock with
write_seqlock(). This is troublesome and leads to problems on
PREEMPT_RT. The problem is that the inner spinlock_t becomes a sleeping
lock on PREEMPT_RT and must not be acquired with disabled interrupts.

The API provides write_seqlock_irqsave() which does the right thing in
one step.
printk_deferred_enter() has to be invoked in non-migrate-able context to
ensure that deferred printing is enabled and disabled on the same CPU.
This is the case after zonelist_update_seq has been acquired.

There was discussion on the first submission that the order should be:
	local_irq_disable();
	printk_deferred_enter();
	write_seqlock();

to avoid pitfalls like having an unaccounted printk() coming from
write_seqlock_irqsave() before printk_deferred_enter() is invoked. The
only origin of such a printk() can be a lockdep splat because the
lockdep annotation happens after the sequence count is incremented.
This is exceptional and subject to change.

It was also pointed that PREEMPT_RT can be affected by the printk
problem since its write_seqlock_irqsave() does not really disable
interrupts. This isn't the case because PREEMPT_RT's printk
implementation differs from the mainline implementation in two important
aspects:
- Printing happens in a dedicated threads and not at during the
  invocation of printk().
- In emergency cases where synchronous printing is used, a different
  driver is used which does not use tty_port::lock.

Acquire zonelist_update_seq with write_seqlock_irqsave() and then defer
printk output.

Fixes: 1007843a91909 ("mm/page_alloc: fix potential deadlock on zonelist_up=
date_seq seqlock")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/page_alloc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b7..99b7e7d09c5c0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5808,11 +5808,10 @@ static void __build_all_zonelists(void *data)
 	unsigned long flags;
=20
 	/*
-	 * Explicitly disable this CPU's interrupts before taking seqlock
-	 * to prevent any IRQ handler from calling into the page allocator
-	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
+	 * The zonelist_update_seq must be acquired with irqsave because the
+	 * reader can be invoked from IRQ with GFP_ATOMIC.
 	 */
-	local_irq_save(flags);
+	write_seqlock_irqsave(&zonelist_update_seq, flags);
 	/*
 	 * Explicitly disable this CPU's synchronous printk() before taking
 	 * seqlock to prevent any printk() from trying to hold port->lock, for
@@ -5820,7 +5819,6 @@ static void __build_all_zonelists(void *data)
 	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
 	 */
 	printk_deferred_enter();
-	write_seqlock(&zonelist_update_seq);
=20
 #ifdef CONFIG_NUMA
 	memset(node_load, 0, sizeof(node_load));
@@ -5857,9 +5855,8 @@ static void __build_all_zonelists(void *data)
 #endif
 	}
=20
-	write_sequnlock(&zonelist_update_seq);
 	printk_deferred_exit();
-	local_irq_restore(flags);
+	write_sequnlock_irqrestore(&zonelist_update_seq, flags);
 }
=20
 static noinline void __init
--=20
2.40.1

