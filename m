Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE366FE2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbjEJQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjEJQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3252E35B8;
        Wed, 10 May 2023 09:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09AA363F4F;
        Wed, 10 May 2023 16:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3822CC433A1;
        Wed, 10 May 2023 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737914;
        bh=w8hk0qAptQ2qHu/gba7mNofKjO7C3JHylCL5lamAkpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3CgNUuSMI3EHQX0bI4HWZx5/dz0TI/DUqH/nfyFIvHyEgqYjfggh2e0nUVeVKrZG
         q3NzT7ctcib7GZZs5pBWnTb7n/MTTKalvxhnQQCdz4QGmaw+ma5kqhn0k4FbKo59hc
         vzRd7CNhmDScyON9rgjzQKTR5hYHj5vLuzR6Vu4l6vhU1SKUZG9wWszVCEJL8CdHEJ
         6RPQ1Vh9T7QEdaAuUVq5U0/YTJLmyfPDrIwjy41vcO7zjuppfEZgYrAqDn0TDa9iUV
         Cku8FGnO1NFnmpCdn1yC9YyRZvavnJwvFWT+cHd7ZFnlIzLuNEp4JpiAkVsS6IcF7N
         lQILYW7YNROPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 941C0CE1348; Wed, 10 May 2023 09:58:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/8] rcu: Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work
Date:   Wed, 10 May 2023 09:58:30 -0700
Message-Id: <20230510165832.2187453-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
References: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
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

The rcu_data structure's ->rcu_cpu_has_work field can be modified by
any CPU attempting to wake up the rcuc kthread.  Therefore, this commit
marks accesses to this field from the rcu_cpu_kthread() function.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e2dbea6cee4b..faa1c01d2917 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2481,12 +2481,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
 		work = *workp;
-		*workp = 0;
+		WRITE_ONCE(*workp, 0);
 		local_irq_enable();
 		if (work)
 			rcu_core();
 		local_bh_enable();
-		if (*workp == 0) {
+		if (!READ_ONCE(*workp)) {
 			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
 			*statusp = RCU_KTHREAD_WAITING;
 			return;
-- 
2.40.1

