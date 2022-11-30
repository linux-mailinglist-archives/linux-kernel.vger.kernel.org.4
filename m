Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10E663DCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiK3SOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiK3SNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:13:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8772B609;
        Wed, 30 Nov 2022 10:13:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B3B28CE1ACE;
        Wed, 30 Nov 2022 18:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB98C4314F;
        Wed, 30 Nov 2022 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832008;
        bh=JWSyRakhy+dkVAOMqz8EUh288eeQKUxl8b8ecP4VVOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/yaPLuZPzWktPAHagD6UFkCYaDu8tya1qQO49HjS1nedSCUGvwEWFpmtPHku1wc2
         WKZPghDQCNGvnOhydYxN1R0NSOOckw+eT5aU1qcoSTT05VhnZRw3wu/E90O08NPgpU
         NX9XrGUbGKD4FzAFyCc7HuXqlG/Mi0SITZt9VByrOA+0i6cqH8+yLOjto2RyAOgS1s
         eGSk6cgv9sxqd5ksp9JSLSqbauqpUvfyqNwsOqo0Xf1gJ+kOiWGIZZacgEZB1NekX6
         stuVJWxwItCP9uutcpBfLHSIkmR6iBv9E4bASwgu7M8bj+7KpkUbx6s60il2mpyLxZ
         S1HtBhZ/Neqpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 69A615C1722; Wed, 30 Nov 2022 10:13:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/16] scsi/scsi_error: Use call_rcu_hurry() instead of call_rcu()
Date:   Wed, 30 Nov 2022 10:13:20 -0800
Message-Id: <20221130181325.1012760-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <urezki@gmail.com>

Earlier commits in this series allow battery-powered systems to build
their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
This Kconfig option causes call_rcu() to delay its callbacks in order
to batch them.  This means that a given RCU grace period covers more
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
Therefore, synchronize_rcu() invokes call_rcu_hurry() instead of
call_rcu().  The arrival of a non-lazy call_rcu_hurry() callback on a
given CPU kicks any lazy callbacks that might be already queued on that
CPU.  After all, if there is going to be a grace period, all callbacks
might as well get full benefit from it.

Yes, this could be done the other way around by creating a
call_rcu_lazy(), but earlier experience with this approach and
feedback at the 2022 Linux Plumbers Conference shifted the approach
to call_rcu() being lazy with call_rcu_hurry() for the few places
where laziness is inappropriate.

And another call_rcu() instance that cannot be lazy is the one in the
scsi_eh_scmd_add() function.  Leaving this instance lazy results in
unacceptably slow boot times.

Therefore, make scsi_eh_scmd_add() use call_rcu_hurry() in order to
revert to the old behavior.

[ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: <linux-scsi@vger.kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 6995c89792300..ac5ff0783b4f0 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 	 * Ensure that all tasks observe the host state change before the
 	 * host_failed change.
 	 */
-	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
+	call_rcu_hurry(&scmd->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
-- 
2.31.1.189.g2e36527f23

