Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1160535E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiJSWrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJSWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820717FD5C;
        Wed, 19 Oct 2022 15:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22755619D6;
        Wed, 19 Oct 2022 22:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5060CC43149;
        Wed, 19 Oct 2022 22:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219621;
        bh=CDl8H2MGOjWvC458fdEn7dT11YxGntP9ARrgviEeMhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tuC9VoJUsxYY/4c+0Pc8LrQ1NGvAKs1dMjfH9r+iKyPsUll5AXr+M8mzGLDsSgWsc
         wNZkFN8/urxwPLqOoviVRke4/rJGfytC7VoI/4ExKL6ikIH8zSDpmSs7VGFH1rf/bT
         AE9DZl2rrmOoaHRLKi9uSR2a6dK851gFDFHp3a04uSuhov9GeK36VtvC5mCmne1dpU
         PAn+ouBxcTUFL9Civ4mINIPu8vnvSSs6P5heivUd6ApQ9BEkJmoKY9dvA6huIWeH/+
         Ew+TTrGXjp4GD/qunPYACNRTIUTSMSBEAwcN98aCDMgs1y03E41YnNyklrkA2rCEXJ
         dZAatlp2GWijA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B2E8E5C0B8F; Wed, 19 Oct 2022 15:47:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/8] rcu: Fix __this_cpu_read() lockdep warning in rcu_force_quiescent_state()
Date:   Wed, 19 Oct 2022 15:46:59 -0700
Message-Id: <20221019224659.2499511-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

Running rcutorture with non-zero fqs_duration module parameter in a
kernel built with CONFIG_PREEMPTION=y results in the following splat:

BUG: using __this_cpu_read() in preemptible [00000000]
code: rcu_torture_fqs/398
caller is __this_cpu_preempt_check+0x13/0x20
CPU: 3 PID: 398 Comm: rcu_torture_fqs Not tainted 6.0.0-rc1-yoctodev-standard+
Call Trace:
<TASK>
dump_stack_lvl+0x5b/0x86
dump_stack+0x10/0x16
check_preemption_disabled+0xe5/0xf0
__this_cpu_preempt_check+0x13/0x20
rcu_force_quiescent_state.part.0+0x1c/0x170
rcu_force_quiescent_state+0x1e/0x30
rcu_torture_fqs+0xca/0x160
? rcu_torture_boost+0x430/0x430
kthread+0x192/0x1d0
? kthread_complete_and_exit+0x30/0x30
ret_from_fork+0x22/0x30
</TASK>

The problem is that rcu_force_quiescent_state() uses __this_cpu_read()
in preemptible code instead of the proper raw_cpu_read().  This commit
therefore changes __this_cpu_read() to raw_cpu_read().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f6561aa401c04..1e1d333d07ffe 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2410,7 +2410,7 @@ void rcu_force_quiescent_state(void)
 	struct rcu_node *rnp_old = NULL;
 
 	/* Funnel through hierarchy to reduce memory contention. */
-	rnp = __this_cpu_read(rcu_data.mynode);
+	rnp = raw_cpu_read(rcu_data.mynode);
 	for (; rnp != NULL; rnp = rnp->parent) {
 		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
 		       !raw_spin_trylock(&rnp->fqslock);
-- 
2.31.1.189.g2e36527f23

