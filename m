Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE7643D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiLFGwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiLFGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:52:08 -0500
Received: from mx417.baidu.com (mx411.baidu.com [124.64.200.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B20D163DE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:52:06 -0800 (PST)
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx417.baidu.com (Postfix) with ESMTP id B68D219B80406;
        Tue,  6 Dec 2022 14:43:18 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id B00A7D9932;
        Tue,  6 Dec 2022 14:43:18 +0800 (CST)
From:   lirongqing@baidu.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org,
        akpm@linux-foundation.org, tony.luck@intel.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when mwait_idle is used
Date:   Tue,  6 Dec 2022 14:43:18 +0800
Message-Id: <1670308998-12313-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

when KVM guest has mwait and mwait_idle is used as default idle function,
Loading cpuidle-haltpoll will make idle function back to default_idle which
is using HLT, As the commit aebef63cf7ff ("x86: Remove vendor checks from
prefer_mwait_c1_over_halt") explains that mwait is preferred

so disable kvm guest polling in this conditions to improve performance,
like sockperf localhost test shows that latency is reduced by about 20%

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/include/asm/processor.h   | 2 ++
 arch/x86/kernel/process.c          | 6 ++++++
 drivers/cpuidle/cpuidle-haltpoll.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73..159ef33 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -862,4 +862,6 @@ bool arch_is_platform_page(u64 paddr);
 #define arch_is_platform_page arch_is_platform_page
 #endif
 
+bool is_mwait_idle(void);
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c21b734..330972c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -896,6 +896,12 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 		x86_idle = default_idle;
 }
 
+bool is_mwait_idle(void)
+{
+	return x86_idle == mwait_idle;
+}
+EXPORT_SYMBOL_GPL(is_mwait_idle);
+
 void amd_e400_c1e_apic_setup(void)
 {
 	if (boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E)) {
diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index 3a39a7f..8cf1ddf 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -17,6 +17,7 @@
 #include <linux/sched/idle.h>
 #include <linux/kvm_para.h>
 #include <linux/cpuidle_haltpoll.h>
+#include <linux/processor.h>
 
 static bool force __read_mostly;
 module_param(force, bool, 0444);
@@ -111,6 +112,9 @@ static int __init haltpoll_init(void)
 	if (!kvm_para_available() || !haltpoll_want())
 		return -ENODEV;
 
+	if (is_mwait_idle())
+		return -ENODEV;
+
 	cpuidle_poll_state_init(drv);
 
 	ret = cpuidle_register_driver(drv);
-- 
2.9.4

