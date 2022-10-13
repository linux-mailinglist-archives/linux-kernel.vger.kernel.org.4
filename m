Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4F5FDEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJMRXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJMRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:22:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F49DDAC41;
        Thu, 13 Oct 2022 10:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6196B81E1C;
        Thu, 13 Oct 2022 17:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B71EC433D7;
        Thu, 13 Oct 2022 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665681774;
        bh=UnJzqfIfoF9Ec/ZKlEcwsNBnPjENbI+mlZF66EUMZjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ytd4iva9baTjO3x0ofoO0swRHdivI0QUyZZD1i4gNyInUMb3uZKfQWcreRWSIbwJx
         xXlLW1OQ5CzXXkK7PetJjo/HYxalKeJYiwBNdc6KxG0hO1crAKCE8DStcSRmBV4SZL
         gJX/s57SyMCzVOBpfwWGSBbEbQscqbdmaWR+RBbH4Bf6lFmj49ZQrmLVPrHV84hk3/
         oyVlEoTtvNdEonHt4TmS9y8rjtC5Mp0lqyd+ASaSDKzeEVuAfuouefBr4oenkkhO6N
         OJU/RBCyjR930TkoOA+bn4NKgvuKBJgdn7XXkFzEvM03Skp9LgsNS9pTjxsaF+LO1p
         2Tpi+OBqSvqkg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/3] srcu: Explain the reason behind the read side critical section on GP start
Date:   Thu, 13 Oct 2022 19:22:43 +0200
Message-Id: <20221013172244.1099010-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013172244.1099010-1-frederic@kernel.org>
References: <20221013172244.1099010-1-frederic@kernel.org>
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

Tell about the need to protect against concurrent updaters who may
overflow the GP counter behind the current update.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8b7ef1031d89..5bf67d997796 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1154,6 +1154,11 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	int ss_state;
 
 	check_init_srcu_struct(ssp);
+	/*
+	 * While starting the new gp if needed, make sure we are in an SRCU read
+	 * side critical section so that the gp sequence can't wrap around in
+	 * the middle.
+	 */
 	idx = __srcu_read_lock_nmisafe(ssp, false);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
-- 
2.25.1

