Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208B266977A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjAMMgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbjAMMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBC559F1;
        Fri, 13 Jan 2023 04:31:14 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ava2esDj8LX1/WtjMbsawd2SNyUiRUUILpEjt2yZw1I=;
        b=zZ/8+4cCRk8zu/wNYx1JcggGAs4LVapTBmughYm1/w5+otW4XOxQvs9x2PicR9cG3GTC8Z
        sH81ggRMfRueU7eHTOvhFWA8IgiemVs8DfACXNOjXa/spfRJBACeevoCyJa3s7N+Lo0aVD
        1e4KyluE+uApi7zoqJODHUiDqoUra72nWXyAZ2SfDP/FNjBCa0k7p81t6cUO403jakSgZ2
        262zHn0eLgQ7bfsytYNzISSnQcKibd2s2ZbXwJO9COMG80x1667DoZ3PxbLE5zJGII0gwn
        PMYLD2EiUFDErV4l5IFEFJ9NPU6pbAQWuDiFByMNz4VDoZdyNN5i1lambWO1Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ava2esDj8LX1/WtjMbsawd2SNyUiRUUILpEjt2yZw1I=;
        b=vJMWF0pDxN67x2pT4XnjFnG23wbKq5U0W12rxgDreBnc/gSOuqvkpP8AEg1Ll3alImnVFf
        LvCUGy8ByVk5z6Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: Annotate poll_idle()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.312601331@infradead.org>
References: <20230112195540.312601331@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307300.4906.5287365679453004139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     00717eb8c9557b5fcdd338db6faef532f6991d63
Gitweb:        https://git.kernel.org/tip/00717eb8c9557b5fcdd338db6faef532f6991d63
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:15 +01:00

cpuidle: Annotate poll_idle()

The __cpuidle functions will become a noinstr class, as such they need
explicit annotations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.312601331@infradead.org
---
 drivers/cpuidle/poll_state.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 1f578ed..d25ec52 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -13,7 +13,10 @@
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start = local_clock();
+	u64 time_start;
+
+	instrumentation_begin();
+	time_start = local_clock();
 
 	dev->poll_time_limit = false;
 
@@ -39,6 +42,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 	raw_local_irq_disable();
 
 	current_clr_polling();
+	instrumentation_end();
 
 	return index;
 }
