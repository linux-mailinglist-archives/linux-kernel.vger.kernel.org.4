Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FFF6FE2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjEJRDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjEJRDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127935592;
        Wed, 10 May 2023 10:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE92964A28;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027FAC4339E;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738164;
        bh=lQYiBo5yWC21n7sADnCbbnl6Y7dNLkILdUz1+j0vDYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvhINCbZ0cNh8wGTMn4LkrMuFyCbgVgrX+wEC6QQ5GeojTVMJES5uLsz9m83BYFPy
         qjdLxtc3Q03j6HB2L2V2veJcGYYsE/Ied0qS40jz+IcpgPGQol745xxul+cLranqXm
         Zg5cGuoyb1ljGqo0dUHlfPuG2EwPxd4Pn/CinnP9La3YMOdvU7nq8o++wYRNqp1BuB
         GZQYbGOGx8FWUtY+Zsh5btTKvzvNF9AES8wla0FuKeBrANCkQ3+ixm/XvMiR+Wgusd
         /RTQO1N9kU+aflLyTq6gJQXwjqhanJVmJPu87tvaVU+WPGSfEgg/dMUz5V9ljdI84B
         mXBnuew7WmoqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 58231CE12D5; Wed, 10 May 2023 10:02:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/8] rcu/kvfree: Do not run a page work if a cache is disabled
Date:   Wed, 10 May 2023 10:02:40 -0700
Message-Id: <20230510170242.2187714-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
References: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

By default the cache size is 5 pages per CPU, but it can be disabled at
boot time by setting the rcu_min_cached_objs to zero.  When that happens,
the current code will uselessly set an hrtimer to schedule refilling this
cache with zero pages.  This commit therefore streamlines this process
by simply refusing the set the hrtimer when rcu_min_cached_objs is zero.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51d84eabf645..18f592bf6dc6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3225,6 +3225,10 @@ static void fill_page_cache_func(struct work_struct *work)
 static void
 run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
+	// If cache disabled, bail out.
+	if (!rcu_min_cached_objs)
+		return;
+
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
 		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-- 
2.40.1

