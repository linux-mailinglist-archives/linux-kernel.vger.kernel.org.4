Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23100614847
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKALO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKALOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:14:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C13FBF49
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:14:22 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N1nQR1wwGzJnMr;
        Tue,  1 Nov 2022 19:11:27 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 19:14:19 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <puwen@hygon.cn>, <TonyWWang-oc@zhaoxin.com>, <Jason@zx2c4.com>,
        <peterz@infradead.org>, <gregkh@linuxfoundation.org>,
        <cuigaosheng1@huawei.com>, <andrew.cooper3@citrix.com>,
        <tony.luck@intel.com>, <mario.limonciello@amd.com>,
        <pawan.kumar.gupta@linux.intel.com>, <chenyi.qiang@intel.com>,
        <rdunlap@infradead.org>, <jithu.joseph@intel.com>,
        <rafael.j.wysocki@intel.com>, <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86/cpu: replacing the open-coded shift with BIT(x)
Date:   Tue, 1 Nov 2022 19:14:18 +0800
Message-ID: <20221101111418.816139-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open-coded shift with BIT(x) to make the code a bit
more self-documenting, at the same time, fix some useless warnings.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2:
- Change the commit msg, remove the UBSAN warning calltrace, and
  merge patch "x86/cpu: fix undefined behavior in bit shift for
  intel_detect_tlb" with it. Thanks!
 arch/x86/kernel/cpu/amd.c     | 2 +-
 arch/x86/kernel/cpu/centaur.c | 2 +-
 arch/x86/kernel/cpu/hygon.c   | 2 +-
 arch/x86/kernel/cpu/intel.c   | 4 ++--
 arch/x86/kernel/cpu/proc.c    | 2 +-
 arch/x86/kernel/cpu/zhaoxin.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

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
x86/cpu: fix undefined behavior in bit shift for intel_detect_tlb+++ b/arch/x86/kernel/cpu/hygon.c
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
index 2d7ea5480ec3..2bdf6d601a6f 100644
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
@@ -945,7 +945,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 
 		/* If bit 31 is set, this is an unknown format */
 		for (j = 0 ; j < 3 ; j++)
-			if (regs[j] & (1 << 31))
+			if (regs[j] & BIT(31))
 				regs[j] = 0;
 
 		/* Byte 0 is level count, not a descriptor */
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

