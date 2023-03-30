Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97C6D128F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjC3WtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjC3WsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEF61166F;
        Thu, 30 Mar 2023 15:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D637621E6;
        Thu, 30 Mar 2023 22:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29920C433B3;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=QlHpKUFyFkPqa4/d+oFphqn7vcoF2BLXPAHJYhfOlxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsEjXci/7rR60/j145O3c8SvRw/52MFO1g+tk2nNqZ2BxdAczWh/QnCaXq29eZNUt
         8zJcE2qP080KGnnwLWebT4OXzQhUKeWucIjhHqZjcDGXOnVVqI4yfysOt6bQwIvgcJ
         MHDE+XqP2nsClTKCXdS0rf1slDpdknEVsyVL912teyBPJAN2mBCY/1ofMCVi1M1uQN
         rOP7r77SgZRFS2bml2I0bVCnmUaV89XgsxdMG+S5I7Cjg1dK3XiIZsXKIcBD0NFTNO
         lq9uJx6HWTz3uQSdSWkWRqCRBK5gAgXGYR5h+NIQ2AwrDHskbTmUKszqXCwMmgWAsO
         gsGIYywzdsBgQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3AA19154048E; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 18/20] srcu: Fix long lines in cleanup_srcu_struct()
Date:   Thu, 30 Mar 2023 15:47:24 -0700
Message-Id: <20230330224726.662344-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit creates an srcu_usage pointer named "sup" as a shorter
synonym for the "ssp->srcu_sup" that was bloating several lines of code.

Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9699bcab7215..11a08201ca0a 100644
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

