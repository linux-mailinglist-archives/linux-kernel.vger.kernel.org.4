Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A256D1286
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjC3WsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjC3Wry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC28B12844;
        Thu, 30 Mar 2023 15:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7F66B82A68;
        Thu, 30 Mar 2023 22:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FC0C433AE;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=RWTsWggyNWMF3mrQsYn6FXy7a1TnamrnSi7nELkO3xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liqSHJog9QoVs7xd3BFMUdHHVHx8BYWVROWhnqYnaYzrJhoQYEYQe/w8XUc0xbdqz
         nskHVEeOKyVKsG4Yx7gHjUv6vnzqDkWF9RfpAuzQdo7gD1ItSnqcr3LqGeRZTjbNG9
         b9bhyIGe6ZxGbSZWHNjkpX6vBGCyYmTaQ7fP8a8ja6N8kCPHwEGohfMZ9oOpFw63JA
         WRsK1Q4mxV+ThmVG354IAj+0WmLHgc+3FpHkQlW/kuVuUgWWLfVaCokreZ8niwxj3R
         x2gRgVhiEef2SVVrOyCCX9tHRGEbKppXQSnCZvkXYqYIwOx51ouf/dSe96yedzPNq3
         Y9BgQyAxnWexg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 261AD1540488; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 12/20] srcu: Move heuristics fields from srcu_struct to srcu_usage
Date:   Thu, 30 Mar 2023 15:47:18 -0700
Message-Id: <20230330224726.662344-12-paulmck@kernel.org>
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

This commit moves the ->srcu_size_jiffies, ->srcu_n_lock_retries,
and ->srcu_n_exp_nodelay fields from the srcu_struct structure to the
srcu_usage structure to reduce the size of the former in order to improve
cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  6 +++---
 kernel/rcu/srcutree.c    | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 372e35b0e8b6..3023492d8d89 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -73,6 +73,9 @@ struct srcu_usage {
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	unsigned long srcu_gp_start;		/* Last GP start timestamp (jiffies) */
 	unsigned long srcu_last_gp_end;		/* Last GP end timestamp (ns) */
+	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
+	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
+	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
 };
 
 /*
@@ -80,9 +83,6 @@ struct srcu_usage {
  */
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
-	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
-	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
-	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 340eb685cf64..291fb520bce0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -348,11 +348,11 @@ static void spin_lock_irqsave_check_contention(struct srcu_struct *ssp)
 	if (!SRCU_SIZING_IS_CONTEND() || ssp->srcu_sup->srcu_size_state)
 		return;
 	j = jiffies;
-	if (ssp->srcu_size_jiffies != j) {
-		ssp->srcu_size_jiffies = j;
-		ssp->srcu_n_lock_retries = 0;
+	if (ssp->srcu_sup->srcu_size_jiffies != j) {
+		ssp->srcu_sup->srcu_size_jiffies = j;
+		ssp->srcu_sup->srcu_n_lock_retries = 0;
 	}
-	if (++ssp->srcu_n_lock_retries <= small_contention_lim)
+	if (++ssp->srcu_sup->srcu_n_lock_retries <= small_contention_lim)
 		return;
 	__srcu_transition_to_big(ssp);
 }
@@ -624,8 +624,8 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 		if (time_after(j, gpstart))
 			jbase += j - gpstart;
 		if (!jbase) {
-			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
-			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
+			WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay) + 1);
+			if (READ_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
 				jbase = 1;
 		}
 	}
@@ -783,7 +783,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
 	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
-	WRITE_ONCE(ssp->srcu_n_exp_nodelay, 0);
+	WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
 	rcu_seq_start(&ssp->srcu_sup->srcu_gp_seq);
 	state = rcu_seq_state(ssp->srcu_sup->srcu_gp_seq);
@@ -1625,7 +1625,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		srcu_flip(ssp);
 		spin_lock_irq_rcu_node(ssp->srcu_sup);
 		rcu_seq_set_state(&ssp->srcu_sup->srcu_gp_seq, SRCU_STATE_SCAN2);
-		ssp->srcu_n_exp_nodelay = 0;
+		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
 		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	}
 
@@ -1640,7 +1640,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
-		ssp->srcu_n_exp_nodelay = 0;
+		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
 		srcu_gp_end(ssp);  /* Releases ->srcu_gp_mutex. */
 	}
 }
-- 
2.40.0.rc2

