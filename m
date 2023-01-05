Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7493A65E217
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjAEAzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjAEAyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:54:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356214D72F;
        Wed,  4 Jan 2023 16:51:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D996188D;
        Thu,  5 Jan 2023 00:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C6AC433AF;
        Thu,  5 Jan 2023 00:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879888;
        bh=p3/KoXMV3EksWgDrlSxHSSeH/du9IVFe1LVWFfB/aF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qp55mSALdEETA8doDowXWpt7ob8SUwAcHlAlim/KlsxOjNvGDuJNfozajdIethgyz
         2fpENCx28cQLLWyKLqHvEmQ7u3FxFz3xjs7Pqj5SUlbIatcA+ShZSHAqWEjykVexQ0
         UFtRz+/D3r456Eod/gg5JCP4ZDbmDGJCgLZ601h6kumyMS0U/vs1HMF1LB77Pf/OGr
         9AupvPDY+F8zc0R32DPMZpGk/bte7GR1PdnDoKCBn8TRvMG9IhllKEGhKx4fN2i29h
         zCHCSAHg/NhkrSXicUP42GGRpiouq8e0qbERddsKryyg3TQb1mqoLj5shg/70nBxXY
         tDoVc0Len0xxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5958C5C1AE0; Wed,  4 Jan 2023 16:51:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH rcu 6/6] rcu: Allow up to five minutes expedited RCU CPU stall-warning timeouts
Date:   Wed,  4 Jan 2023 16:51:26 -0800
Message-Id: <20230105005126.1772294-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
References: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
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

The maximum value of RCU CPU stall-warning timeouts has historically been
five minutes (300 seconds).  However, the recently introduced expedited
RCU CPU stall-warning timeout is instead limited to 21 seconds.  This
causes problems for CI/fuzzing services such as syzkaller by obscuring
the issue in question with expedited RCU CPU stall-warning timeout splats.

This commit therefore sets the RCU_EXP_CPU_STALL_TIMEOUT Kconfig options
upper bound to 300000 milliseconds, which is 300 seconds and 5 minutes.

[ paulmck: Apply feedback from Hillf Danton. ]

Reported-by: Dave Chinner <david@fromorbit.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 2 +-
 kernel/rcu/tree_stall.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 49da904df6aa6..2984de629f749 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -82,7 +82,7 @@ config RCU_CPU_STALL_TIMEOUT
 config RCU_EXP_CPU_STALL_TIMEOUT
 	int "Expedited RCU CPU stall timeout in milliseconds"
 	depends on RCU_STALL_COMMON
-	range 0 21000
+	range 0 300000
 	default 0
 	help
 	  If a given expedited RCU grace period extends more than the
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index f360894f5599d..b10b8349bb2a4 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -39,7 +39,7 @@ int rcu_exp_jiffies_till_stall_check(void)
 	// CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, so check the allowed range.
 	// The minimum clamped value is "2UL", because at least one full
 	// tick has to be guaranteed.
-	till_stall_check = clamp(msecs_to_jiffies(cpu_stall_timeout), 2UL, 21UL * HZ);
+	till_stall_check = clamp(msecs_to_jiffies(cpu_stall_timeout), 2UL, 300UL * HZ);
 
 	if (cpu_stall_timeout && jiffies_to_msecs(till_stall_check) != cpu_stall_timeout)
 		WRITE_ONCE(rcu_exp_cpu_stall_timeout, jiffies_to_msecs(till_stall_check));
-- 
2.31.1.189.g2e36527f23

