Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91D745203
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGBUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjGBUBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A35FCD;
        Sun,  2 Jul 2023 12:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8A4D60CE8;
        Sun,  2 Jul 2023 19:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3658BC433C7;
        Sun,  2 Jul 2023 19:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327886;
        bh=Mq0xtGMxfVEcqHzBb9BECNePlXHRNFvBmtA81QNno+4=;
        h=From:To:Cc:Subject:Date:From;
        b=BhbcJt5gYRCOkCaUCAvYTOrtRXEkINdX8qoD2F8Hg/YvMvwBq+svABBnwcIJt2nHN
         td/v87wLSp9nCuLiwdrIcRnoIq0NgzyGckRrwQ5opkZwK853i0TpPa++HYYb+IaYnh
         TJW6dk3vkVsCJyqF12IoKk/fWVyO60H/9tWYfGYQnN7JssBNej4+IXFAtpGIApdugU
         H/CHo6R23sToFiaXbGV62YSPG5msYq2q/l95Mn4g2gdXxD6DQAMyYGeZwvke2BPCtv
         TNTxtK3cjmLUBPnXU5NjlTSgfusK8nNQDd95rZBUCWNaZOACil/Ua8nooj0PbV+e2J
         8BJ7VxV/SPC1w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15] rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
Date:   Sun,  2 Jul 2023 15:58:03 -0400
Message-Id: <20230702195803.1793491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.119
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
index df016f6d0662c..48f3e90c5de53 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2826,12 +2826,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
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

