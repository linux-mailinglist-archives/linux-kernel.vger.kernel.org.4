Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97B6FE30A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjEJRKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjEJRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC9461A4;
        Wed, 10 May 2023 10:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4547863F5C;
        Wed, 10 May 2023 17:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FD4C4339C;
        Wed, 10 May 2023 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738610;
        bh=2vHnCxDdEjl1hV7GlAl3zhTie+jGwjNjCH+DRd3wZeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXj8D5hA+XUKPUVg6o1HB50vuz2mgx9FQ02KKsPsK0pnIegyoXYwGc4mfFKawi6bH
         CCck9Bg1t5ksc2WX5qFrS5x2myCRvj/shZTvO50ZBlvz9AfZvUkdmPmln9K3OYd6BJ
         5uUK7m2Ov70w8BGydtboVM4THwcVzeslLXLxd1IttUNK1CQKeEqQruATKVtAFarYjr
         TLiiWgaaMMO+vlamLkEVCyqHl1nH7BEwO4vaG3NTGIa9Lp2ZcsGcPyu//Moli6+FIe
         mmOvzEm/Yl9PAnj7QWEzfQQdpH0NlYafkmDrJOvEqCfnsh2vM1phqptRDVrjEEUumr
         5aJeHxJNxz/gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A7AFCE1279; Wed, 10 May 2023 10:10:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/2] rcu-tasks: Clarify the cblist_init_generic() function's pr_info() output
Date:   Wed, 10 May 2023 10:10:09 -0700
Message-Id: <20230510171009.2189185-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <edff5c4b-e894-4146-8a1d-ae291d01c4fb@paulmck-laptop>
References: <edff5c4b-e894-4146-8a1d-ae291d01c4fb@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

This commit uses rtp->name instead of __func__ and outputs the value
of rcu_task_cb_adjust, thus reducing console-log output.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 65df1aaf0ce9..cf7b00af9474 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -272,10 +272,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 
-	if (rcu_task_cb_adjust)
-		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
-
-	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
+	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
+			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
 }
 
 // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
-- 
2.40.1

