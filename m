Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0686331CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiKVBEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiKVBEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:04:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D9D15804;
        Mon, 21 Nov 2022 17:04:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA1D0614C7;
        Tue, 22 Nov 2022 01:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A511C4314F;
        Tue, 22 Nov 2022 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669079063;
        bh=z9JjjzgTdogo9ezjaH1Kvhao6xVgeTuYWUcd1hbJd34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouiCNi1MquoLuOlDKxTEYf7uSk1aoeJVXXFQEgmoBoFB55aKExq8LU532Qtw1F2i9
         icTvelfXLI8qLKPC1QyophlQshZT87N4wmcllBRKX60rg+hwLyCLcItLqgFBUugFU5
         u5KJLARZ/rxaXegIpMETwQ+hG85w8RDUFy5rRn2rKJKFkzqP/ajNoG8kAnoVewObpK
         YJiwLIJMoPhBWBUAKJMkB4dmSM/m9gyGllbtvmXMHCNCnzn8tkQwWVW1fj9DSOH+II
         27lgpW4F5ldo4aH+iVHDV3JVV+45e6OMjMpbNmrODFChzoHs+we9qOt6XKP6Gu52kS
         2x+3g3Jk+ARvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F8865C13DD; Mon, 21 Nov 2022 17:04:22 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: [PATCH v2 rcu 08/16] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Mon, 21 Nov 2022 17:04:13 -0800
Message-Id: <20221122010421.3799681-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Earlier commits in this series allow battery-powered systems to build
their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
This Kconfig option causes call_rcu() to delay its callbacks in order to
batch callbacks.  This means that a given RCU grace period covers more
callbacks, thus reducing the number of grace periods, in turn reducing
the amount of energy consumed, which increases battery lifetime which
can be a very good thing.  This is not a subtle effect: In some important
use cases, the battery lifetime is increased by more than 10%.

This CONFIG_RCU_LAZY=y option is available only for CPUs that offload
callbacks, for example, CPUs mentioned in the rcu_nocbs kernel boot
parameter passed to kernels built with CONFIG_RCU_NOCB_CPU=y.

Delaying callbacks is normally not a problem because most callbacks do
nothing but free memory.  If the system is short on memory, a shrinker
will kick all currently queued lazy callbacks out of their laziness,
thus freeing their memory in short order.  Similarly, the rcu_barrier()
function, which blocks until all currently queued callbacks are invoked,
will also kick lazy callbacks, thus enabling rcu_barrier() to complete
in a timely manner.

However, there are some cases where laziness is not a good option.
For example, synchronize_rcu() invokes call_rcu(), and blocks until
the newly queued callback is invoked.  It would not be a good for
synchronize_rcu() to block for ten seconds, even on an idle system.
Therefore, synchronize_rcu() invokes call_rcu_flush() instead of
call_rcu().  The arrival of a non-lazy call_rcu_flush() callback on a
given CPU kicks any lazy callbacks that might be already queued on that
CPU.  After all, if there is going to be a grace period, all callbacks
might as well get full benefit from it.

Yes, this could be done the other way around by creating a
call_rcu_lazy(), but earlier experience with this approach and
feedback at the 2022 Linux Plumbers Conference shifted the approach
to call_rcu() being lazy with call_rcu_flush() for the few places
where laziness is inappropriate.

And another call_rcu() instance that cannot be lazy is the one on the
percpu refcounter's "per-CPU to atomic switch" code path, which
uses RCU when switching to atomic mode.  The enqueued callback
wakes up waiters waiting in the percpu_ref_switch_waitq.  Allowing
this callback to be lazy would result in unacceptable slowdowns for
users of per-CPU refcounts, such as blk_pre_runtime_suspend().

Therefore, make __percpu_ref_switch_to_atomic() use call_rcu_flush()
in order to revert to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: <linux-mm@kvack.org>
---
 lib/percpu-refcount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e5c5315da2741..65c58a029297d 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -230,7 +230,8 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu_flush(&ref->data->rcu,
+		       percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
-- 
2.31.1.189.g2e36527f23

