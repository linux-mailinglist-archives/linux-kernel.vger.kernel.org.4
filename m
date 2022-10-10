Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6AD5FA7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJJWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJJWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4B79A6D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B953C61041
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 22:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208B9C433C1;
        Mon, 10 Oct 2022 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665441610;
        bh=H2YGNl94EtWVuEFBnke9BVCHAd1Iq68IOesSFyDAWlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKh4RZXIaZu+R1xYeRxw5KG0EqoPARcV1Z7Ul3FCtn9+fCoSsOsRPM2CienfrsSOj
         pE3yp4bxygcIkR0Choxn+edOsKx9gNiBDVidxle4LuNgwJlVjqeXZJQUhXlTj3IyMY
         AqO/v5vrTxfq/fRrD/FCH7BWYjqI/Fmi7QImwXojtFotv3IYzpi3CuTByYxiAfm0Ct
         klvlNGW2KY/FKJEIY+KkDHEIeJo0UNxiVaqhvtJ0nOS355Nv5FkqfkELIyhNCJAbWQ
         eAobLO9eE5RSjYhdEQTluxyvM9o3AGqHsW5AfAOGIa2lRkDhapuB66ayei1lhxVNHr
         ywcjA3SOa7Rgw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/2] rcu/nocb: Spare bypass locking upon normal enqueue
Date:   Tue, 11 Oct 2022 00:39:56 +0200
Message-Id: <20221010223956.1041247-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010223956.1041247-1-frederic@kernel.org>
References: <20221010223956.1041247-1-frederic@kernel.org>
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

When a callback is to be enqueued to the normal queue and not the bypass
one, a flush to the bypass queue is always tried anyway. This attempt
involves locking the bypass lock unconditionally. Although it is
guaranteed not to be contended at this point, because only call_rcu()
can lock the bypass lock without holding the nocb lock, it's still not
free and the operation can easily be spared most of the time by just
checking if the bypass list is empty. The check is safe as nobody can
queue nor flush the bypass concurrently.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 094fd454b6c3..30c3d473ffd8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -423,8 +423,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		if (*was_alldone)
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstQ"));
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
-		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+		if (rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
+			WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
+			WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+		}
 		return false; // Caller must enqueue the callback.
 	}
 
-- 
2.25.1

