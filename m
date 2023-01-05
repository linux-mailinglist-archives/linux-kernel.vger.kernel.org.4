Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4343965E17E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbjAEAX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjAEAXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A544374;
        Wed,  4 Jan 2023 16:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CD61B81984;
        Thu,  5 Jan 2023 00:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F92C433F0;
        Thu,  5 Jan 2023 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878187;
        bh=ztl1EQiOdDcQZcotzokX82t3kWGoj7LXDHlcvmlwCU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGVTI7Qg58lsUbW1BNkoKK45kvR4sdZ/a992D/99AGedvCnCZSIqHj4dbrB7gnw2l
         wQSEtk02ZpdrfHG2cCe+xtrc2CxkeaWrNFn76ZXgMjlsjAMD7625j5J3Cs93HYMTf+
         p1fXfTSkTccAHr/SeBda7YtysoiWMzbwV24TmBbB0rS/fuZSgelcByU7IhoZwjHy4L
         aPQlcqJ/0fplKWR7RZaitdz806uNp3VcWLLkmb9S4D4xiCDY2uB8jFJAT35DJxD8TK
         taQI2dt/DzcUdVu0P47i7F2WZKu0tWegdzU3+a16S55bvhK+SipdfWVQZu23w0x+AO
         lJplReIpqI9yA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 79AB35C1456; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/10] rcu: Upgrade header comment for poll_state_synchronize_rcu()
Date:   Wed,  4 Jan 2023 16:22:59 -0800
Message-Id: <20230105002305.1768591-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
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

This commit emphasizes the possibility of concurrent calls to
synchronize_rcu() and synchronize_rcu_expedited() causing one or
the other of the two grace periods being lost from the viewpoint of
poll_state_synchronize_rcu().

If you cannot afford to lose grace periods this way, you should
instead use the _full() variants of the polled RCU API, for
example, poll_state_synchronize_rcu_full().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7d3a59d4f37ef..0147e69ea85a9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3559,7 +3559,9 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
  * If @false is returned, it is the caller's responsibility to invoke this
  * function later on until it does return @true.  Alternatively, the caller
  * can explicitly wait for a grace period, for example, by passing @oldstate
- * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
+ * to either cond_synchronize_rcu() or cond_synchronize_rcu_expedited()
+ * on the one hand or by directly invoking either synchronize_rcu() or
+ * synchronize_rcu_expedited() on the other.
  *
  * Yes, this function does not take counter wrap into account.
  * But counter wrap is harmless.  If the counter wraps, we have waited for
@@ -3570,6 +3572,12 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
  * completed.  Alternatively, they can use get_completed_synchronize_rcu()
  * to get a guaranteed-completed grace-period state.
  *
+ * In addition, because oldstate compresses the grace-period state for
+ * both normal and expedited grace periods into a single unsigned long,
+ * it can miss a grace period when synchronize_rcu() runs concurrently
+ * with synchronize_rcu_expedited().  If this is unacceptable, please
+ * instead use the _full() variant of these polling APIs.
+ *
  * This function provides the same memory-ordering guarantees that
  * would be provided by a synchronize_rcu() that was invoked at the call
  * to the function that provided @oldstate, and that returned at the end
-- 
2.31.1.189.g2e36527f23

