Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A1605362
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiJSWrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJSWrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:47:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E6188107;
        Wed, 19 Oct 2022 15:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8D70B8261B;
        Wed, 19 Oct 2022 22:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505A7C43148;
        Wed, 19 Oct 2022 22:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219621;
        bh=IeaAKnXCrTJxEtb/hM2Q5kn1ssJ75eQ9FsOhFMTira4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2eRhzIvlTeDSe1B8OI9k7XhSR+HrCnEujCmMR1fA0ltBZ3oeJzvsdkc2x8DaEYo6
         vip4yyk3uBScrCJ2kpln3iH9pg39A/8gA4spvtnSP5RsmBB6WdCboK04Lo+doYVmeF
         sfAVQs7GcyBG7/mXI324vwx0aN7ztx59oUdwFoYECI7und9aTWpjb+OvBu6aLg3jsE
         kbe+8LCQ6WxrFfgnMEdnfL4tH3furhSuBLAWGjrb50IEm/wOYENRcCYoJkwr+qaFYl
         0VWesc45R5xRXk47xsq/OWFN/sqiKo2xtO0cwWgpzeW77txeSnyUIr0DJZexx8qx4z
         jss+1AKGZ7jvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B11CC5C0AC5; Wed, 19 Oct 2022 15:47:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH rcu 7/8] rcu-tasks: Make grace-period-age message human-readable
Date:   Wed, 19 Oct 2022 15:46:58 -0700
Message-Id: <20221019224659.2499511-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a few words to the informative message that appears
every ten seconds in RCU Tasks and RCU Tasks Trace grace periods.
This message currently reads as follows:

rcu_tasks_wait_gp: rcu_tasks grace period 1046 is 10088 jiffies old.

After this change, it provides additional context, instead reading
as follows:

rcu_tasks_wait_gp: rcu_tasks grace period number 1046 (since boot) is 10088 jiffies old.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f5bf6fb430dab..b0b885e071fa8 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -728,7 +728,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 		if (rtsi > 0 && !reported && time_after(j, lastinfo + rtsi)) {
 			lastinfo = j;
 			rtsi = rtsi * rcu_task_stall_info_mult;
-			pr_info("%s: %s grace period %lu is %lu jiffies old.\n",
+			pr_info("%s: %s grace period number %lu (since boot) is %lu jiffies old.\n",
 				__func__, rtp->kname, rtp->tasks_gp_seq, j - rtp->gp_start);
 		}
 	}
-- 
2.31.1.189.g2e36527f23

