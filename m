Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853476D128B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjC3Wsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjC3WsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20CEF98;
        Thu, 30 Mar 2023 15:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9CFE621DB;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED774C433A8;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=5eWA5TBt7nCii3UqGea8IcoYwbNXDY/A3q2oGxbuJqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiPP9szvCwqkWw6bhMpgZof5y1SPwjqtt8T8lKqr3ydXoKBaltYkBWAgutxHKRyQt
         qGRM9Vu6CQhsN1SyK7bW+cwA8t0RfGMBltDlG2dvlPAO/m7I+ye6vJH7hhlcT32ehx
         xZ6g2qINOOcY9R0n5BLhPzqiA7w6XuOvzrY31TBE6zoM0+DW2AGYU37XASHMKnXwvX
         uGCRT82FmythqecLMwg7NqlN96srrytgeb0mv0QRVxm4yEXDLfTfuWYO/1QA/Xz9QB
         fKckl5S/VjFva8tcax4usiTYQDqz3ueAhG9NJbb+fo/rFtbsK3t6ECvdnuqQUwlDYL
         u96eVqhg6cLXg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 298AF1540489; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 13/20] srcu: Move ->sda_is_static from srcu_struct to srcu_usage
Date:   Thu, 30 Mar 2023 15:47:19 -0700
Message-Id: <20230330224726.662344-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
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

This commit moves the ->sda_is_static field from the srcu_struct structure
to the srcu_usage structure to reduce the size of the former in order
to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 2 +-
 kernel/rcu/srcutree.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 3023492d8d89..d3534ecb806e 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -76,6 +76,7 @@ struct srcu_usage {
 	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
 	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
 	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
+	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 };
 
 /*
@@ -84,7 +85,6 @@ struct srcu_usage {
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
-	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
 	struct mutex srcu_barrier_mutex;	/* Serialize barrier ops. */
 	struct completion srcu_barrier_completion;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 291fb520bce0..20f2373f7e25 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -252,7 +252,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->work, process_srcu);
-	ssp->sda_is_static = is_static;
+	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda) {
@@ -265,7 +265,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
-			if (!ssp->sda_is_static) {
+			if (!ssp->srcu_sup->sda_is_static) {
 				free_percpu(ssp->sda);
 				ssp->sda = NULL;
 				kfree(ssp->srcu_sup);
@@ -667,7 +667,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	kfree(ssp->srcu_sup->node);
 	ssp->srcu_sup->node = NULL;
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
-	if (!ssp->sda_is_static) {
+	if (!ssp->srcu_sup->sda_is_static) {
 		free_percpu(ssp->sda);
 		ssp->sda = NULL;
 		kfree(ssp->srcu_sup);
@@ -1906,7 +1906,7 @@ static void srcu_module_going(struct module *mod)
 	for (i = 0; i < mod->num_srcu_structs; i++) {
 		ssp = *(sspp++);
 		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
-		    !WARN_ON_ONCE(!ssp->sda_is_static))
+		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
 			cleanup_srcu_struct(ssp);
 		free_percpu(ssp->sda);
 	}
-- 
2.40.0.rc2

