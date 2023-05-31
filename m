Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B798717D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjEaKSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjEaKSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D2A192;
        Wed, 31 May 2023 03:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9198263082;
        Wed, 31 May 2023 10:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F9C4339E;
        Wed, 31 May 2023 10:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528281;
        bh=6T9PufNrI67qOiSAF/52EuU4TI9tRCG4o5fvW1OJc0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkVWQNRtlxpcY2As9Q6qfsRTeQjdEIWbYSQED2VojPxVw3Go3BxDgEygTzHVsXAPY
         vXAHatJvEKVf3WwQP/uVflw/CEm1YR8Y44zPhSDTF1YCHNs9AEBVv9INEEGPFJ6jvL
         0lSvKiNs/LQu9yizqC2Ds7ofvQKu3LuR9qJtjjOZW+FfcXTdaCank7nF/KbcpxDpyC
         0FmT8Yxn4/SHANswoBqJt6X5uJkikVf5sS4p95CtRygTzKqwrguM55LImEEUtlDyZN
         6pSbSuzgNYerqlI9BeJNsnEik5g0ADjWEzopCq6tqJF9GaOtukav31+Fi2lmh5pfe0
         YQSpi/Aq0ayPw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 5/9] rcu: Add rcutree.lazy_enabled boot parameter
Date:   Wed, 31 May 2023 12:17:32 +0200
Message-Id: <20230531101736.12981-6-frederic@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531101736.12981-1-frederic@kernel.org>
References: <20230531101736.12981-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to overwrite the arbitrary default number of lazy callbacks
threshold that is currently set to 100. This allows for tuning between
powersaving, throughtput and memory consumption expectations. As a
bonus, setting this value to 0 disables lazy callbacks.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 kernel/rcu/tree.c                               | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 505978cfb548..dd2be4249061 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4798,6 +4798,11 @@
 			Set threshold of queued RCU callbacks beyond which
 			batch limiting is disabled.
 
+	rcutree.qhimark_lazy = [KNL]
+			Set threshold of queued lazy RCU callbacks beyond which
+			batch must be flushed to the main queue. If set to 0,
+			disable lazy queue.
+
 	rcutree.qlowmark= [KNL]
 			Set threshold of queued RCU callbacks below which
 			batch limiting is re-enabled.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9b98d87fa22e..e33c0d889216 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -390,6 +390,7 @@ static long qovld_calc = -1;	  // No pre-initialization lock acquisitions!
 
 module_param(blimit, long, 0444);
 module_param(qhimark, long, 0444);
+module_param(qhimark_lazy, long, 0444);
 module_param(qlowmark, long, 0444);
 module_param(qovld, long, 0444);
 
@@ -2655,7 +2656,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	kasan_record_aux_stack_noalloc(head);
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
-	lazy = lazy_in && !rcu_async_should_hurry();
+	lazy = lazy_in && qhimark_lazy && !rcu_async_should_hurry();
 
 	/* Add the callback to our list. */
 	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
-- 
2.40.1

