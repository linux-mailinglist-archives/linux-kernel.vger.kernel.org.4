Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE163FF45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiLBD5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiLBD5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:57:09 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 19:57:06 PST
Received: from mx417.baidu.com (mx417.baidu.com [124.64.200.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42113CFE63
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:57:06 -0800 (PST)
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx417.baidu.com (Postfix) with ESMTP id 99CED19B80054;
        Fri,  2 Dec 2022 11:37:32 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 940AED9932;
        Fri,  2 Dec 2022 11:37:32 +0800 (CST)
From:   lirongqing@baidu.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        tony.luck@intel.com, wyes.karny@amd.com,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: [PATCH][RFC] x86: override prefer_mwait_c1_over_halt to avoid loading cpuidle-haltpoll driver
Date:   Fri,  2 Dec 2022 11:37:32 +0800
Message-Id: <1669952252-32710-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

x86 KVM guests with MWAIT can load cpuidle-haltpoll driver, and will
cause performance degradation, so override prefer_mwait_c1_over_halt
to a new value, aviod loading cpuidle-haltpoll driver

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/process.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73..6bc94fd 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -658,7 +658,7 @@ extern void amd_e400_c1e_apic_setup(void);
 extern unsigned long		boot_option_idle_override;
 
 enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
-			 IDLE_POLL};
+			 IDLE_POLL, IDLE_PREF_MWAIT};
 
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c21b734..a16985c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -889,6 +889,7 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 	} else if (prefer_mwait_c1_over_halt(c)) {
 		pr_info("using mwait in idle threads\n");
 		x86_idle = mwait_idle;
+		boot_option_idle_override = IDLE_PREF_MWAIT;
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
 		x86_idle = tdx_safe_halt;
-- 
2.9.4

