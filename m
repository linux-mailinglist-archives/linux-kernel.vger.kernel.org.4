Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869766C7477
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCXAUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjCXATu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE612D148;
        Thu, 23 Mar 2023 17:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0BA7B821CB;
        Fri, 24 Mar 2023 00:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F655C433A4;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=CyI2x+E6wMeERtsPHUF/+GOvXVfY6z2JZMMsSarhSLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkDVJd8No6s7ukbT7sfNiUaDEYE3eq3U0X7dM3eEWUKY3SmlKyafcpOQBRf665Q78
         BYL+i9XhxHCsMfQ9wtGa5mqWFz0vc57gjbHg6PimsNdHIq/DCc1KXmyZ0nD/2fOfD3
         P4q+2TFGrkDCVN2hu4kWz2K2S1icmXON9VSrVCv/W3rTrCSeVPtf0G1cfOXVV2Foia
         DP9rB+sYeqQi3+ocq8JY4EHNhXiSq43ACZRKBml1Y3GM5mcrKx5qAv2unJcuxwH/E/
         v562+4FFHgJDaIhBJpCBJdyKBfbp4GNDcBZhM+Ch/8z4/iGyDl1MQUhqb6JbovPkw1
         GjAGxcWT84DTw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A0E1615403A0; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 07/19] srcu: Move ->lock initialization after srcu_usage allocation
Date:   Thu, 23 Mar 2023 17:19:26 -0700
Message-Id: <20230324001938.3443499-7-paulmck@kernel.org>
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

Currently, both __init_srcu_struct() in CONFIG_DEBUG_LOCK_ALLOC=y kernels
and init_srcu_struct() in CONFIG_DEBUG_LOCK_ALLOC=n kernel initialize
the srcu_struct structure's ->lock before the srcu_usage structure has
been allocated.  This of course prevents the ->lock from being moved
to the srcu_usage structure, so this commit moves the initialization
into the init_srcu_struct_fields() after the srcu_usage structure has
been allocated.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6b6d92fe41cf..f6f37e34a1e0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -240,6 +240,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->srcu_sup = kzalloc(sizeof(*ssp->srcu_sup), GFP_KERNEL);
 	if (!ssp->srcu_sup)
 		return -ENOMEM;
+	if (!is_static)
+		spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
@@ -285,7 +287,6 @@ int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
 	/* Don't re-initialize a lock while it is held. */
 	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
 	lockdep_init_map(&ssp->dep_map, name, key, 0);
-	spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
 	return init_srcu_struct_fields(ssp, false);
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct);
@@ -302,7 +303,6 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct);
  */
 int init_srcu_struct(struct srcu_struct *ssp)
 {
-	spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
 	return init_srcu_struct_fields(ssp, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct);
-- 
2.40.0.rc2

