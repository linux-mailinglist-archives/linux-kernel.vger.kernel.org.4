Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9E6D1281
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjC3WsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjC3Wrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEA812054;
        Thu, 30 Mar 2023 15:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8405B621D7;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDA7C433A0;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=cul4jXhNAUP7VLyJNUzboJAx7iCgCVh7yP8irDHosoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8YyvD9Lhp4043m6tOQEkTkh9yt2ForFJhH8L1PmqPljd8VvZznlk4So7iB1JAm0M
         rGt1XdiGj4t0+UScvwHWifSzmgNzUR2WPAhZ1ghGQOU+5GYO4z1HcoHKncdvfKeavX
         onzMAAI9Jv6gOr7T8msVuWqfZy9dxgqYw/WCaNoB/x/sycWv2QJr9MOrmj1CP2FjXY
         RdQTXTIG2i4MYHDNknIDlcOMaRB+K9Q+j5gReRykbi7uSEcCq3kQ+57olWtHn8w8X/
         ktpMUW3rY7JFfnV7aPqp/THrXv0oIvixK8DcVrGa6PQUjEzBqfc/6mmwGb6Za2Tdo6
         exxyU/uqvNlOQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 14C701540483; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 07/20] srcu: Move ->srcu_cb_mutex from srcu_struct to srcu_usage
Date:   Thu, 30 Mar 2023 15:47:13 -0700
Message-Id: <20230330224726.662344-7-paulmck@kernel.org>
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

This commit moves the ->srcu_cb_mutex field from the srcu_struct structure
to the srcu_usage structure to reduce the size of the former in order
to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 2 +-
 kernel/rcu/srcutree.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 443d27a214ef..231de66ceb15 100644
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
index 8428a184d506..1814f3bfc219 100644
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

