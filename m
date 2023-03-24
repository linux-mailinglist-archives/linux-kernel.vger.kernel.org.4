Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67686C747A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCXAUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjCXATw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D52E0C5;
        Thu, 23 Mar 2023 17:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43C2FCE23F2;
        Fri, 24 Mar 2023 00:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587A2C433A0;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=1zZMbnj6wCHzqV26Ik2U3pZ5xQ0e/amfS4bQebuVTDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7EV7iCLpr0TJDTZJ4avWQJqOKyCa7BhzDmRu1B4UgeeQUswVdFBXUU0tYiizhpGH
         pViUmMTWcGtxz6RvMn/WIq4bQYfvwJOwOxxYl5htEUlPzWznd//kbNyjSYkEaWy0jQ
         73HeQloSXoSOcpgViMPrQRS7+QvJh6X5HtL7z69Iq6K7Xi3jyncu+KR5DiJKtSW8YB
         xVW3mQ39iPBbaeqdnF0H7TYpuUZylGnXHxwuJj0S3wYSTbthNuFhWvIQibdFcZoe1i
         Brum04832rhsxlvlwWT2YlxcadWbSL0Nqmw4HZ7R6lX0Fqj0OgPuPrtU0N/5hFWk9d
         gYMF/FQxTzUlA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9BE43154039F; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 06/19] srcu: Move ->srcu_cb_mutex from srcu_struct to srcu_usage
Date:   Thu, 23 Mar 2023 17:19:25 -0700
Message-Id: <20230324001938.3443499-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
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

This commit moves the ->srcu_cb_mutex field from the srcu_struct structure
to the srcu_usage structure to reduce the size of the former in order
to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 2 +-
 kernel/rcu/srcutree.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 72fb01fb2eb5..69d49de87b67 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -65,13 +65,13 @@ struct srcu_usage {
 	struct srcu_node *level[RCU_NUM_LVLS + 1];
 						/* First node at each level. */
 	int srcu_size_state;			/* Small-to-big transition state. */
+	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
 };
 
 /*
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
 	spinlock_t __private lock;		/* Protect counters and size state. */
 	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
 	unsigned int srcu_idx;			/* Current rdr array element. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2717217de136..6b6d92fe41cf 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -242,7 +242,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		return -ENOMEM;
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	ssp->srcu_sup->node = NULL;
-	mutex_init(&ssp->srcu_cb_mutex);
+	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
 	ssp->srcu_gp_seq = 0;
@@ -861,7 +861,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	int ss_state;
 
 	/* Prevent more than one additional grace period. */
-	mutex_lock(&ssp->srcu_cb_mutex);
+	mutex_lock(&ssp->srcu_sup->srcu_cb_mutex);
 
 	/* End the current grace period. */
 	spin_lock_irq_rcu_node(ssp);
@@ -921,7 +921,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		}
 
 	/* Callback initiation done, allow grace periods after next. */
-	mutex_unlock(&ssp->srcu_cb_mutex);
+	mutex_unlock(&ssp->srcu_sup->srcu_cb_mutex);
 
 	/* Start a new grace period if needed. */
 	spin_lock_irq_rcu_node(ssp);
-- 
2.40.0.rc2

