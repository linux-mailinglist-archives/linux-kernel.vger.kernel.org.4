Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F224360535D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJSWrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJSWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE62188107;
        Wed, 19 Oct 2022 15:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88595619E5;
        Wed, 19 Oct 2022 22:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E601EC433C1;
        Wed, 19 Oct 2022 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219621;
        bh=Ygtgs0PHtrfe91imqGDUAOtSTrIZREFcGSd4BCKgdo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDQYW34tUukSZiX8K55GD3wJ5gibLdND5HFZUo8qjQ3KQ7iMdSFIbxKJopZ6jw13B
         Fe9D657uTPDoZEbvaEEiK1aNR2w5t4ORXEOpjyPcautM9bICAH7PVP7nr9GZy3zmQV
         SpbqN56G5zFTHsB/mAaZUZAbadveQ+Q9TPMlpH1AVliutFzGqxAhvMHOLNnh32uruG
         0tcL1XtCEojAV5R3jWM6dGfk5Ucjbcb+gOlsf+31yVcECbcc2wlyzpgodfvNR2FDmD
         yHt8Ru3lc593r6juGUX71bZt4y2Wo53LyHCqSOmaeslA266I7PWMG2RNeCnxC9MhCl
         CfK73ddbVu4tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A393B5C06B4; Wed, 19 Oct 2022 15:47:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/8] rcu: Remove duplicate RCU exp QS report from rcu_report_dead()
Date:   Wed, 19 Oct 2022 15:46:52 -0700
Message-Id: <20221019224659.2499511-1-paulmck@kernel.org>
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

The rcu_report_dead() function invokes rcu_report_exp_rdp() in order
to force an immediate expedited quiescent state on the outgoing
CPU, and then it invokes rcu_preempt_deferred_qs() to provide any
required deferred quiescent state of either sort.  Because the call to
rcu_preempt_deferred_qs() provides the expedited RCU quiescent state if
requested, the call to rcu_report_exp_rdp() is potentially redundant.

One possible issue is a concurrent start of a new expedited RCU
grace period, but this situation is already handled correctly
by __sync_rcu_exp_select_node_cpus().  This function will detect
that the CPU is going offline via the error return from its call
to smp_call_function_single().  In that case, it will retry, and
eventually stop retrying due to rcu_report_exp_rdp() clearing the
->qsmaskinitnext bit corresponding to the target CPU.  As a result,
__sync_rcu_exp_select_node_cpus() will report the necessary quiescent
state after dealing with any remaining CPU.

This change assumes that control does not enter rcu_report_dead() within
an RCU read-side critical section, but then again, the surviving call
to rcu_preempt_deferred_qs() has always made this assumption.

This commit therefore removes the call to rcu_report_exp_rdp(), thus
relying on rcu_preempt_deferred_qs() to handle both normal and expedited
quiescent states.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6bb8e72bc8151..0ca21ac0f0648 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4276,8 +4276,6 @@ void rcu_report_dead(unsigned int cpu)
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
 
-	/* QS for any half-done expedited grace period. */
-	rcu_report_exp_rdp(rdp);
 	rcu_preempt_deferred_qs(current);
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
-- 
2.31.1.189.g2e36527f23

