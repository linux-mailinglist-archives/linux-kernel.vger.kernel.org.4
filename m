Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A63605392
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiJSW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiJSW6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:58:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D83A1CD688;
        Wed, 19 Oct 2022 15:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DB39B82624;
        Wed, 19 Oct 2022 22:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E48C4315B;
        Wed, 19 Oct 2022 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220328;
        bh=Lw7Q0GwSzhjX27kJ3r/Pu5VkOmW/ZLbkQEvvvISFP7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrgNEcCvnt9q2Ei1GCPn0fArdrA82frgyah4oWktNFVTH01HA4b2GnkskY46J8peD
         3AzWfEUiIuOHcksy1hvxYjs5auNbV0LjN2jRF7FgONsTlUYJ0yF5FPygzUThbcn/ks
         5ngY96d2lwGndXGz5zEeYU5a1RnZk3ZkR0+MiAwZpgw/duszA+iyiaiyoXcGEPyBak
         tIAES6BW4ZKPKhINAaCaSllhJBB+B2+eYyjjFda7Ubsa/haPD+unNMQQKX+QtBP7v8
         2ReYkEMsdLQBjt7RIVd9D2jqojVRVRuXEhk7qga4dvKR1vKaVdRbCs+uGCDGb9Td6p
         YUwBPwuuRZqoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BD0FC5C0D2B; Wed, 19 Oct 2022 15:58:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 10/11] srcu: Explain the reason behind the read side critical section on GP start
Date:   Wed, 19 Oct 2022 15:58:45 -0700
Message-Id: <20221019225846.2501109-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
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

From: Frederic Weisbecker <frederic@kernel.org>

Tell about the need to protect against concurrent updaters who may
overflow the GP counter behind the current update.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 18bb696cff8ca..272830a87e566 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1158,6 +1158,11 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	int ss_state;
 
 	check_init_srcu_struct(ssp);
+	/*
+	 * While starting a new grace period, make sure we are in an
+	 * SRCU read-side critical section so that the grace-period
+	 * sequence number cannot wrap around in the meantime.
+	 */
 	idx = __srcu_read_lock_nmisafe(ssp, false);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
-- 
2.31.1.189.g2e36527f23

