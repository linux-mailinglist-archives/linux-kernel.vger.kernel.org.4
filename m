Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446D1745207
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGBUCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjGBUCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B746193;
        Sun,  2 Jul 2023 12:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F40D60CA3;
        Sun,  2 Jul 2023 19:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC758C433CC;
        Sun,  2 Jul 2023 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327868;
        bh=xtky2eZeYE1ot9ktlv6JCxZlIIkGO633lZ/UL2RCaNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXeptoWKZBRiDGQvC6ti9PMY4I6bQrC7tHQ5/xkZSvPK2fjyaTXg9ClSYetaCCem6
         eRwia5A00O6uqmQWFoYDE0ZV2OhE+dUdNLbmYCMFyOqMrn85E7ZF4c4K+/fPym5vRY
         f/GlfEWXeCCunGrNsXvM7feaMK960F9LSRTBOQMDWNBiIoqy1BhM3Nd16hrJK/FbNO
         R5P+FVPqGAA0jTG50hAFktu6I4fyHT0jC9nGdo1ABKh5Mc5g3V6SwKR07Y3i3PTMUQ
         I9IkbLGLynaI2mDaWcmi1MnSjt+d8G4TwvkJR0IA+ohZi1aQycXjkObarxTG0ASUXo
         XExHE/bse/orQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 3/4] rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
Date:   Sun,  2 Jul 2023 15:57:41 -0400
Message-Id: <20230702195743.1793074-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195743.1793074-1-sashal@kernel.org>
References: <20230702195743.1793074-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit a24c1aab652ebacf9ea62470a166514174c96fe1 ]

The rcu_data structure's ->rcu_cpu_has_work field can be modified by
any CPU attempting to wake up the rcuc kthread.  Therefore, this commit
marks accesses to this field from the rcu_cpu_kthread() function.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f52ff72410416..fe649dd0165c3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2459,12 +2459,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
 		work = *workp;
-		*workp = 0;
+		WRITE_ONCE(*workp, 0);
 		local_irq_enable();
 		if (work)
 			rcu_core();
 		local_bh_enable();
-		if (*workp == 0) {
+		if (!READ_ONCE(*workp)) {
 			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
 			*statusp = RCU_KTHREAD_WAITING;
 			return;
-- 
2.39.2

