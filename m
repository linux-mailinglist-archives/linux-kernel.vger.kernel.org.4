Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941796554AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 22:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiLWVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 16:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 16:15:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF1B1FE;
        Fri, 23 Dec 2022 13:15:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C5961842;
        Fri, 23 Dec 2022 21:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FBAC433EF;
        Fri, 23 Dec 2022 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671830112;
        bh=hMpQQNYK95cKuQwDk/zAG80cKOmSryIgdedTMIx1SF8=;
        h=From:To:Cc:Subject:Date:From;
        b=ogqwyKefV3Obx8cU+3fu5TsIGJETglAJ6stHhNCSa7k2Ry5Ba9OB9yJgD7+sRMTcc
         apPnpnaamAHiM+C2tqxA2W05sPQ2rbUuegF7z4L0B1zmcjpvA3rQNgb/zZuPAfupHA
         h7qI3PvX2RFVdJDt9QAKZLn78C0xRh4rYSXQ09F/5GbdRFSrDNyIK3lAdvOcSOd3hm
         2TKI9JJnqMGOX5XYxrLZMwoNvsgM6L7iCDfxFilrODBFEgi+EDLtfGHGuthR5qkj6J
         CE+YJyLGYuAUtaJND85aYHT1H22Z1Hbrd+R6Qo467nOggUInxs3da7mOATmZslH8e6
         Gt8azMO2vCY2w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH] entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up
Date:   Fri, 23 Dec 2022 22:15:07 +0100
Message-Id: <20221223211507.84249-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
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

RCU sometimes needs to perform a delayed wake up for specific kthreads
handling callbacks offloading (RCU_NOCB). This is handled through timers
and upon entry to idle (also guest and user on nohz_full).

However the delayed wake-up on kernel exit is actually performed after
the thread flags are fetched towards the fast path check for work to
do on exit to user. As a result, and if there is no other pending work
to do upon that kernel exit, the current task will resume to userspace
with TIF_RESCHED set and the pending wake up ignored.

Fix this with fetching the thread flags _after_ the delayed RCU-nocb
kthread wake-up.

Fixes: 47b8ff194c1f ("entry: Explicitly flush pending rcuog wakeup before last rescheduling point")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/entry/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 846add8394c4..a134e26b58c6 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -192,13 +192,14 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_work = read_thread_flags();
+	unsigned long ti_work;
 
 	lockdep_assert_irqs_disabled();
 
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
+	ti_work = read_thread_flags();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
 
-- 
2.25.1

