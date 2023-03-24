Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEDE6C747C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCXAUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCXAT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6328E193F7;
        Thu, 23 Mar 2023 17:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2365262928;
        Fri, 24 Mar 2023 00:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DBDC433AE;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=T/GGGc2qd6p6ruITBApJ92taK2jjXJ9En+4S9TDTB3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlAoMMGXEqbSWbkEiGsC26LyU9nrPu82Fmqoo7F5tlti3T3uoHlLMBZ/avS4LFQ3j
         r9GfwppRqIpDJOaNLgXxO4npmKCtXq3yFxZ3Tx/2Qdl5ivBTSgFnAwqfeyPsj3dYT2
         M4fwLLmnb7eeKxue6VQ5z9wL1SLr+yd6fDdyCET/4FY5cMpTyW2SeLqrO7yaOtjYFL
         W6iKfw5DiJKacHjrGUc+yM3buLaSvkGMowADxuqnm9KqiR+MeaQc2PA+HUXDF7iI2e
         cu+2jMfbaGHOaElqsz4iqkSamKDSGN7kMzEohQww8kRmdD87pKgsqB9Ao8+tITunna
         0JhIp8Uk659Qw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C0EA915403A9; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 16/19] srcu: Fix long lines in cleanup_srcu_struct()
Date:   Thu, 23 Mar 2023 17:19:35 -0700
Message-Id: <20230324001938.3443499-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit creates an srcu_usage pointer named "sup" as a shorter
synonym for the "ssp->srcu_sup" that was bloating several lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/rcu/srcutree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f6bb9fbe1b9c..fd88a98b7254 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -644,12 +644,13 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	int cpu;
+	struct srcu_usage *sup = ssp->srcu_sup;
 
 	if (WARN_ON(!srcu_get_delay(ssp)))
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
-	flush_delayed_work(&ssp->srcu_sup->work);
+	flush_delayed_work(&sup->work);
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
@@ -658,21 +659,21 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
 			return; /* Forgot srcu_barrier(), so just leak it! */
 	}
-	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
-	    WARN_ON(rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq) != ssp->srcu_sup->srcu_gp_seq_needed) ||
+	if (WARN_ON(rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
+	    WARN_ON(rcu_seq_current(&sup->srcu_gp_seq) != sup->srcu_gp_seq_needed) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
 		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
-			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)),
-			rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq), ssp->srcu_sup->srcu_gp_seq_needed);
+			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
+			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
-	kfree(ssp->srcu_sup->node);
-	ssp->srcu_sup->node = NULL;
-	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
-	if (!ssp->srcu_sup->sda_is_static) {
+	kfree(sup->node);
+	sup->node = NULL;
+	sup->srcu_size_state = SRCU_SIZE_SMALL;
+	if (!sup->sda_is_static) {
 		free_percpu(ssp->sda);
 		ssp->sda = NULL;
-		kfree(ssp->srcu_sup);
+		kfree(sup);
 		ssp->srcu_sup = NULL;
 	}
 }
-- 
2.40.0.rc2

