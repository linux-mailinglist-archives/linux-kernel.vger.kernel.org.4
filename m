Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9574C4C6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjGIOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 10:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 10:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE21AB;
        Sun,  9 Jul 2023 07:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157A060BF9;
        Sun,  9 Jul 2023 14:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813D2C433C7;
        Sun,  9 Jul 2023 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688914544;
        bh=M9NtEIl64nDsKbemZul2F308cM8vsEwL8bCzuitqG1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8vgA6+UgZdpDU91bAj3vH2KNBkf9yrmrFshaB472v7VVdnfBvRI/1T8t7ScTmO1s
         1oIQ8suwaMg+SurF9WzAnw2WioNi4snp/zKDMfhBYAS2aqKNNIKrTowjdW3yODQ3/l
         r1h+Ww8+Sz/pHCNrk/xMjPXBW3jJgSi4AWqZIdO0IgXLXLyxx7FVjBoELGEKd/lZVq
         u1/Gd0DJ/Yr65UW6fjHvW4gYeSHZOYAWVJ61nCosAX3FFodbsM5HtvdpJkC4aVRha+
         e5ffkxATciPG4pdiY0H0e6XEP09Aa4ukPb7g2acsOyafSaxWCSdIm/4O37yt7xJyoD
         CwSI+vBKQIdeg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 3/3] rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
Date:   Sun,  9 Jul 2023 10:55:38 -0400
Message-Id: <20230709145538.512238-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709145538.512238-1-sashal@kernel.org>
References: <20230709145538.512238-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

