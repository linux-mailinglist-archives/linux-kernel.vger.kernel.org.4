Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C036B6D1288
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjC3Wsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjC3Wr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68612852;
        Thu, 30 Mar 2023 15:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D4C621D9;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9766C433AC;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=VVkUnY0uv7jk+b59+oVZrqwrjNkvSKi6rJLly8DwwsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVtFclAcBAfx2ZFcDv0cCYBZoUwHDWPGOtfetvXwDp0KpsoJXb+MF/ZdPX3J1l6h9
         oj7FXiVK0gc76XDa0MSRwoOiAV94xxsXhi2ftUOLP7x6ZFrMu/XutqJcT7/Yw2nWX9
         GbNcVAmg20z07VWuvdDpelYQjpzFVoLgKIZJiqNp4eQmavOA54g3Y10FfxzMf/HJl3
         IVuMLQ2UpMZ1xlqX9/uiN0KIFTD/KI18nOGsdhxJOaw765+D3Kosn9kMbgVnC5cFY6
         sZUJa5CDJEwyFXzmxySx4os/hqxCtMkRsLvo6AEWaNw98LMg6jfFh5E8aGNCNllw49
         Zuu83oM/iS1vw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1ED4C1540486; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 10/20] srcu: Move ->srcu_gp_mutex from srcu_struct to srcu_usage
Date:   Thu, 30 Mar 2023 15:47:16 -0700
Message-Id: <20230330224726.662344-10-paulmck@kernel.org>
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

This commit moves the ->srcu_gp_mutex field from the srcu_struct structure
to the srcu_usage structure to reduce the size of the former in order
to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  2 +-
 kernel/rcu/srcutree.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 694d87b81917..d04e3da6181c 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -67,13 +67,13 @@ struct srcu_usage {
 	int srcu_size_state;			/* Small-to-big transition state. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
 	spinlock_t __private lock;		/* Protect counters and size state. */
+	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
 };
 
 /*
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
 	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c42248cf18f6..a36066798de7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -245,7 +245,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
-	mutex_init(&ssp->srcu_gp_mutex);
+	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
 	ssp->srcu_gp_seq = 0;
 	ssp->srcu_barrier_seq = 0;
@@ -876,7 +876,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, gpseq);
 	spin_unlock_irq_rcu_node(ssp->srcu_sup);
-	mutex_unlock(&ssp->srcu_gp_mutex);
+	mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
 
 	/* Initiate callback invocation as needed. */
@@ -1585,7 +1585,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 {
 	int idx;
 
-	mutex_lock(&ssp->srcu_gp_mutex);
+	mutex_lock(&ssp->srcu_sup->srcu_gp_mutex);
 
 	/*
 	 * Because readers might be delayed for an extended period after
@@ -1603,7 +1603,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		if (ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed)) {
 			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_gp_seq));
 			spin_unlock_irq_rcu_node(ssp->srcu_sup);
-			mutex_unlock(&ssp->srcu_gp_mutex);
+			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return;
 		}
 		idx = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
@@ -1611,7 +1611,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			srcu_gp_start(ssp);
 		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 		if (idx != SRCU_STATE_IDLE) {
-			mutex_unlock(&ssp->srcu_gp_mutex);
+			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* Someone else started the grace period. */
 		}
 	}
@@ -1619,7 +1619,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
 		idx = 1 ^ (ssp->srcu_idx & 1);
 		if (!try_check_zero(ssp, idx, 1)) {
-			mutex_unlock(&ssp->srcu_gp_mutex);
+			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
 		srcu_flip(ssp);
@@ -1637,7 +1637,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		 */
 		idx = 1 ^ (ssp->srcu_idx & 1);
 		if (!try_check_zero(ssp, idx, 2)) {
-			mutex_unlock(&ssp->srcu_gp_mutex);
+			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
 		ssp->srcu_n_exp_nodelay = 0;
-- 
2.40.0.rc2

