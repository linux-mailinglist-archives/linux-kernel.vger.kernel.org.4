Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E62645A10
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLGMmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLGMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:42:28 -0500
Received: from bddwd-sys-mailin01.bddwd.baidu.com (mx402.baidu.com [124.64.201.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6E76391C2;
        Wed,  7 Dec 2022 04:42:27 -0800 (PST)
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by bddwd-sys-mailin01.bddwd.baidu.com (Postfix) with ESMTP id 6087A11980033;
        Wed,  7 Dec 2022 20:41:35 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 59702D9932;
        Wed,  7 Dec 2022 20:41:35 +0800 (CST)
From:   lirongqing@baidu.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org,
        akpm@linux-foundation.org, tony.luck@intel.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with arch_cpu_idle
Date:   Wed,  7 Dec 2022 20:41:34 +0800
Message-Id: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

When KVM guest has MWAIT and mwait_idle is used as default idle function,
but once cpuidle-haltpoll is loaded, default_idle in default_enter_idle is
used, which is using HLT, and cause a performance regression. As the commit
aebef63cf7ff ("x86: Remove vendor checks from prefer_mwait_c1_over_halt")
explains that mwait is preferred

so replace default_idle with arch_cpu_idle which can using MWAIT
optimization.

latency of sockperf ping-pong localhost test is reduced by more 20%
unixbench has 5% performance improvements for single core

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/process.c          | 1 +
 drivers/cpuidle/cpuidle-haltpoll.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c21b734..303afad 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -721,6 +721,7 @@ void arch_cpu_idle(void)
 {
 	x86_idle();
 }
+EXPORT_SYMBOL(arch_cpu_idle);
 
 /*
  * We use this if we don't have any better idle routine..
diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index 3a39a7f..e66df22 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -32,7 +32,7 @@ static int default_enter_idle(struct cpuidle_device *dev,
 		local_irq_enable();
 		return index;
 	}
-	default_idle();
+	arch_cpu_idle();
 	return index;
 }
 
-- 
2.9.4

