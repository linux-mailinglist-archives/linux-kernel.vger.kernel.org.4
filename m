Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080E1614481
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiKAGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiKAGJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:09:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500FCFD12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:09:49 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1fk11zF6zHvS1;
        Tue,  1 Nov 2022 14:09:29 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 14:09:46 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <puwen@hygon.cn>, <TonyWWang-oc@zhaoxin.com>, <Jason@zx2c4.com>,
        <peterz@infradead.org>, <hca@linux.ibm.com>,
        <mika.westerberg@linux.intel.com>, <mario.limonciello@amd.com>,
        <cuigaosheng1@huawei.com>, <tony.luck@intel.com>,
        <andrew.cooper3@citrix.com>, <pawan.kumar.gupta@linux.intel.com>,
        <rdunlap@infradead.org>, <jithu.joseph@intel.com>,
        <chenyi.qiang@intel.com>, <rafael.j.wysocki@intel.com>,
        <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpu: replacing the open-coded shift with BIT(x)
Date:   Tue, 1 Nov 2022 14:09:45 +0800
Message-ID: <20221101060945.722565-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open-coded shift with BIT(x) for x86_power to make the
code a bit more self-documenting, and we will get a UBSAN issue in
arch/x86/kernel/cpu/proc.c, fix it.

The UBSAN warning calltrace like below:

UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/proc.c:138:25
left shift of 1 by 31 places cannot be represented in type 'int'
Call Trace:
 <TASK>
 dump_stack_lvl+0x7d/0xa5
 dump_stack+0x15/0x1b
 ubsan_epilogue+0xe/0x4e
 __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
 show_cpuinfo+0x5ff/0x6d0
 seq_read_iter+0x116/0x5b0
 proc_reg_read_iter+0x45/0xc0
 vfs_read+0x2ee/0x3c0
 ksys_read+0xe1/0x130
 __x64_sys_read+0x23/0x30
 do_syscall_64+0x58/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/x86/kernel/cpu/amd.c     | 2 +-
 arch/x86/kernel/cpu/centaur.c | 2 +-
 arch/x86/kernel/cpu/hygon.c   | 2 +-
 arch/x86/kernel/cpu/intel.c   | 2 +-
 arch/x86/kernel/cpu/proc.c    | 2 +-
 arch/x86/kernel/cpu/zhaoxin.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 860b60273df3..75d82cad323a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -613,7 +613,7 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	 * c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
 	 * with P/T states and does not stop in deep C-states
 	 */
-	if (c->x86_power & (1 << 8)) {
+	if (c->x86_power & BIT(8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 345f7d905db6..9910bb1d90fd 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -105,7 +105,7 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
 #endif
-	if (c->x86_power & (1 << 8)) {
+	if (c->x86_power & BIT(8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 21fd425088fe..dc473bfbf1b5 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -251,7 +251,7 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
 	 * c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
 	 * with P/T states and does not stop in deep C-states
 	 */
-	if (c->x86_power & (1 << 8)) {
+	if (c->x86_power & BIT(8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 121c1c38162a..bbe86a2f3a43 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -286,7 +286,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 * It is also reliable across cores and sockets. (but not across
 	 * cabinets - we turn it off in that case explicitly.)
 	 */
-	if (c->x86_power & (1 << 8)) {
+	if (c->x86_power & BIT(8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..efa1d39c4f25 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -135,7 +135,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 	seq_puts(m, "power management:");
 	for (i = 0; i < 32; i++) {
-		if (c->x86_power & (1 << i)) {
+		if (c->x86_power & BIT(i)) {
 			if (i < ARRAY_SIZE(x86_power_flags) &&
 			    x86_power_flags[i])
 				seq_printf(m, "%s%s",
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 05fa4ef63490..34a8a460f8f4 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -61,7 +61,7 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
 #endif
-	if (c->x86_power & (1 << 8)) {
+	if (c->x86_power & BIT(8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
-- 
2.25.1

