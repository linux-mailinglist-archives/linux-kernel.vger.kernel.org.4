Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA13745205
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGBUCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjGBUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:02:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842E05FDF;
        Sun,  2 Jul 2023 12:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D245160C74;
        Sun,  2 Jul 2023 19:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5442CC433C9;
        Sun,  2 Jul 2023 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327876;
        bh=M9NtEIl64nDsKbemZul2F308cM8vsEwL8bCzuitqG1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkgHcCV0YsWgTp4JHbO8RAjjX04pRnS3/p5/jbeCJA1Nu/YnrnS1qHDtQO4dYXeKm
         WUF9FyteaX03xhi3WvW88jDoH/Q+BWgdrohTw272d9BOf9+Vz6FQFqwivHmS3iBx/u
         +X7qfsmusuCYiFvfVPaz5x4+zTv/OtJmpOTxH8EJg4HAlauezAvmhTgIUVf0tdlb92
         +WjYg1gybL0Xsv0g183t2bJwTMBuQy4zNk9E+ylOvg7YZgKbGLuXKWZxjjq3lkap7N
         5ryhZ+uE0sy4ERgtmFs6EumjMTs02+K6IIcy9bLWrTigYvXC7NuEPdDvCO+3q6i3Gz
         o0yj8WW+16DAA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 3/3] rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
Date:   Sun,  2 Jul 2023 15:57:50 -0400
Message-Id: <20230702195750.1793345-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195750.1793345-1-sashal@kernel.org>
References: <20230702195750.1793345-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
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
index a565dc5c54440..fbba4161060cd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2455,12 +2455,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
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

