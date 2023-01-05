Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E402B65E180
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjAEAXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjAEAXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06A43A2E;
        Wed,  4 Jan 2023 16:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE8036189A;
        Thu,  5 Jan 2023 00:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C74C433AA;
        Thu,  5 Jan 2023 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878188;
        bh=cQj+0MvK2dvCMDfEUq3ufEL/MhEK6ftbDWfUx6TMnEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQS48QKDf2Lpmmy3HwQPQyH0ez2nI90pzgXA2IgpC2we2flhJ64kQbkiKafaxswN6
         PK5RUgoFwh26PWhWgqg2pFpPqDrMnOse8qPffSTUox8YCJ/pPLNzu2y4iRkO7eGwAc
         APXTqmI9J3IcjmoQkN2ofiUz3bgGmFwSSGbCi+Yaa1slUFQXEtDL+GRgSwlZYwiGCA
         qXKgxhtKd4fm+MAJbZbOsQVbJJC39h2IDrVww6Hkf0ubqsAxucBhh6jLyhrdc9O9JO
         XL8SNCExQiBgCbrnqZMx6u3ZQxZreuv4K7xY1RKEkkGy2njbVC9nj6CMzQo8FmUjWt
         pQL8dnm0J8Y3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 811CF5C1C5B; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/10] rcu: Test synchronous RCU grace periods at the end of rcu_init()
Date:   Wed,  4 Jan 2023 16:23:03 -0800
Message-Id: <20230105002305.1768591-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
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

This commit tests synchronize_rcu() and synchronize_rcu_expedited()
at the end of rcu_init(), in addition to the test already at the
beginning of that function.  These tests are run only in kernels built
with CONFIG_PROVE_RCU=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c   | 2 ++
 kernel/rcu/update.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 15f9765064727..80b84ae285b41 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4849,6 +4849,8 @@ void __init rcu_init(void)
 	// Kick-start any polled grace periods that started early.
 	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
 		(void)start_poll_synchronize_rcu_expedited();
+
+	rcu_test_sync_prims();
 }
 
 #include "tree_stall.h"
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index f5e6a2f95a2a0..587b97c401914 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -220,6 +220,7 @@ void rcu_test_sync_prims(void)
 {
 	if (!IS_ENABLED(CONFIG_PROVE_RCU))
 		return;
+	pr_info("Running RCU synchronous self tests\n");
 	synchronize_rcu();
 	synchronize_rcu_expedited();
 }
-- 
2.31.1.189.g2e36527f23

