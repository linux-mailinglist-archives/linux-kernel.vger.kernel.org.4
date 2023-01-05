Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716F565E1C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbjAEAlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbjAEAix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C45DE3;
        Wed,  4 Jan 2023 16:38:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0169618B9;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEC5C43339;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=9ltLnmPueyNAThHqCnMBk2/jo7HOn9NSQikvjiJ8fT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpbiHeVxHb1z++NPrcNY8YC7ux8CBWGapwm3Cdo9I1onoMWT3TpKY3DEpEl2HpuAd
         FJfasS/kV/CL3uWODdyThwoYPhsLjQX61lVXkw/MRHAKfhN9X2IV4AA4bmDh/6WbvM
         jx/ddyNNbTzlTHruR8B0oHLBdKisKaIFZ7b72LLDFKFX9l7DBuOJzuB/H1oZbgGe6l
         uKmFt5YFpA9YXrm/fBOaL1npNhxhHRgx2pFv7TtmKnnAuXple2mx1IhnMVxN5Nt08P
         6qgdu22rI828gX6qsXzNaT4gqHQ6jNG5zHqYO/OqqM5DbemEaTLjlhgVsFPgsS7UzO
         +kmZiuiIfwgWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E7F0E5C1CE5; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH rcu 27/27] rcu: Remove CONFIG_SRCU
Date:   Wed,  4 Jan 2023 16:38:13 -0800
Message-Id: <20230105003813.1770367-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all references to CONFIG_SRCU have been removed, it is time to
remove CONFIG_SRCU itself.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/rcu/Kconfig                                          | 3 ---
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index ab62074174c32..9071182b1284b 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -53,9 +53,6 @@ config RCU_EXPERT
 
 	  Say N if you are unsure.
 
-config SRCU
-	def_bool y
-
 config TINY_SRCU
 	bool
 	default y if TINY_RCU
diff --git a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
index 42acb1a64ce10..3f5fb66f16df7 100644
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -71,9 +71,5 @@ CONFIG_TASKS_RCU
 
 	These are controlled by CONFIG_PREEMPT and/or CONFIG_SMP.
 
-CONFIG_SRCU
-
-	Selected by CONFIG_RCU_TORTURE_TEST, so cannot disable.
-
 
 boot parameters ignored: TBD
-- 
2.31.1.189.g2e36527f23

