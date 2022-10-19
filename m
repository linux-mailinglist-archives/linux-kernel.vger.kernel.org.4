Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8713605370
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiJSWwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJSWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ADD17C156;
        Wed, 19 Oct 2022 15:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC78E619EE;
        Wed, 19 Oct 2022 22:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E67BC43150;
        Wed, 19 Oct 2022 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219907;
        bh=MQ9LcMOdsSRTz38i4kDvf32ku4ItL7jI+4EvtYFoPC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAl/iSQsuk1+2M6aDOUrrdjnjX8vuEJOxRzokcPebrX5Up7justHJnoXtapDkXiir
         H08aHzwHoHP7hWGyOpklSAJhMwDvlPg4eJI2BtOj1fQ03u27rQVehlmN6QMsyhd27t
         F03ExYx0PhDcUp//Auh8E/Xn2//+YcgvzH5YFVrMJ5FVgdcnZ1HrECn0AX3Uw7dNdS
         uUTzQDtaldoqtV7/RUFeGOBGi4v7t4EYHeyuRAETDRrDmvp5sX1wGTG3Zxl9wMs8ZK
         8vk5sqJoRvXkOoyp7Tt6sFvwNnqMNGEuCPxtpW7TzwGXSi8pSeFv57FpHBmibahNCN
         3ZupmHrjfTdww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8D1785C0E57; Wed, 19 Oct 2022 15:51:46 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use call_rcu_flush()
Date:   Wed, 19 Oct 2022 15:51:43 -0700
Message-Id: <20221019225144.2500095-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
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

From: Uladzislau Rezki <urezki@gmail.com>

call_rcu() changes to save power will slow down RCU workqueue items
queued via queue_rcu_work(). This may not be an issue, however we cannot
assume that workqueue users are OK with long delays. Use
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1b..b4b0e828b529e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		rwork->wq = wq;
-		call_rcu(&rwork->rcu, rcu_work_rcufn);
+		call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
 		return true;
 	}
 
-- 
2.31.1.189.g2e36527f23

