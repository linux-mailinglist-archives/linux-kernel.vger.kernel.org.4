Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B4A6FE317
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjEJRNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbjEJRMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:12:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B61BFE;
        Wed, 10 May 2023 10:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3F164A31;
        Wed, 10 May 2023 17:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BB4C43443;
        Wed, 10 May 2023 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738760;
        bh=Mf57p9lptadAfKL3dhRFXC+h5FKe4rU53uP5IBmR1S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLmtVJbWAWlZzBF+yKt1RteGr77Rvk+5w0UB5Gf8f6T6n+GRid+C80Kdcn3+JlLlV
         Qz3YcVsnXDXuoVz1q+ZQyBKEdl0lMma7LV3XVtCNqX2uVvt0AkXLO4NsertlFVrC8v
         L9qXqrpuh70ftBlagA0tkVnxzqA3D9i7jwb5pIAsLeHk1Xk78rRfUKdAwy2ixgNuEm
         alDDxEdObxdNYFRemZPO2e8Vu+OX+VGuWEn63Gh5RL4VFgwbAERGZJKOjf2Zavdwiv
         WUEF/VMNknNwjPEi5dRw5Ok5kQdLMEvP8DOxlRxEK9WKtkTq3ygJhlug0eeUt56qU7
         g0CbXzjSG2rnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 60574CE127F; Wed, 10 May 2023 10:12:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/6] doc/rcutorture: Add description of rcutorture.stall_cpu_block
Date:   Wed, 10 May 2023 10:12:37 -0700
Message-Id: <20230510171238.2189921-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

If you build a kernel with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y,
then run the rcutorture tests specifying stalls as follows:

runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4" \
	bootparams="console=ttyS0 rcutorture.stall_cpu=30 \
	rcutorture.stall_no_softlockup=1 rcutorture.stall_cpu_block=1" -d

The tests will produce the following splat:

[   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
[   10.841073] rcu_torture_stall start on CPU 3.
[   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
....
[   10.841108] Call Trace:
[   10.841110]  <TASK>
[   10.841112]  dump_stack_lvl+0x64/0xb0
[   10.841118]  dump_stack+0x10/0x20
[   10.841121]  __schedule_bug+0x8b/0xb0
[   10.841126]  __schedule+0x2172/0x2940
[   10.841157]  schedule+0x9b/0x150
[   10.841160]  schedule_timeout+0x2e8/0x4f0
[   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
[   10.841195]  rcu_torture_stall+0x2e8/0x300
[   10.841199]  kthread+0x175/0x1a0
[   10.841206]  ret_from_fork+0x2c/0x50

This is because the rcutorture.stall_cpu_block=1 module parameter causes
rcu_torture_stall() to invoke schedule_timeout_uninterruptible() within
an RCU read-side critical section.  This in turn results in a quiescent
state (which prevents the stall) and a sleep in an atomic context (which
produces the above splat).

Although this code is operating as designed, the design has proven to
be counterintuitive to many.  This commit therefore updates the description
in kernel-parameters.txt accordingly.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..eaffe0f8771d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5087,8 +5087,16 @@
 
 	rcutorture.stall_cpu_block= [KNL]
 			Sleep while stalling if set.  This will result
-			in warnings from preemptible RCU in addition
-			to any other stall-related activity.
+			in warnings from preemptible RCU in addition to
+			any other stall-related activity.  Note that
+			in kernels built with CONFIG_PREEMPTION=n and
+			CONFIG_PREEMPT_COUNT=y, this parameter will
+			cause the CPU to pass through a quiescent state.
+			Any such quiescent states will suppress RCU CPU
+			stall warnings, but the time-based sleep will
+			also result in scheduling-while-atomic splats.
+			Which might or might not be what you want.
+
 
 	rcutorture.stall_cpu_holdoff= [KNL]
 			Time to wait (s) after boot before inducing stall.
-- 
2.40.1

