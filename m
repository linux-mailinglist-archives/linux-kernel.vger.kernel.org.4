Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2AF650B13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiLSMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiLSMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:01:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453BCEA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:00:44 -0800 (PST)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbJ841w3SzqT1r;
        Mon, 19 Dec 2022 19:56:20 +0800 (CST)
Received: from ubuntu.huawei.com (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 20:00:41 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v8 2/4] arm64: add support for machine check error safe
Date:   Mon, 19 Dec 2022 12:00:06 +0000
Message-ID: <20221219120008.3818828-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219120008.3818828-1-tongtiangen@huawei.com>
References: <20221219120008.3818828-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the processing of arm64 kernel hardware memory errors(do_sea()), if
the errors is consumed in the kernel, the current processing is panic.
However, it is not optimal.

Take uaccess for example, if the uaccess operation fails due to memory
error, only the user process will be affected, kill the user process
and isolate the user page with hardware memory errors is a better choice.

This patch only enable machine error check framework, it add exception
fixup before kernel panic in do_sea().

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/extable.h |  1 +
 arch/arm64/mm/extable.c          | 16 ++++++++++++++++
 arch/arm64/mm/fault.c            | 29 ++++++++++++++++++++++++++++-
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 03934808b2ed..cb0adee2eb8f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,6 +20,7 @@ config ARM64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index 72b0e71cc3de..f80ebd0addfd 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -46,4 +46,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 #endif /* !CONFIG_BPF_JIT */
 
 bool fixup_exception(struct pt_regs *regs);
+bool fixup_exception_mc(struct pt_regs *regs);
 #endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 228d681a8715..478e639f8680 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -76,3 +76,19 @@ bool fixup_exception(struct pt_regs *regs)
 
 	BUG();
 }
+
+bool fixup_exception_mc(struct pt_regs *regs)
+{
+	const struct exception_table_entry *ex;
+
+	ex = search_exception_tables(instruction_pointer(regs));
+	if (!ex)
+		return false;
+
+	/*
+	 * This is not complete, More Machine check safe extable type can
+	 * be processed here.
+	 */
+
+	return false;
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1d832c92cbe8..3021047873d6 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -713,6 +713,31 @@ static int do_bad(unsigned long far, unsigned long esr, struct pt_regs *regs)
 	return 1; /* "fault" */
 }
 
+static bool arm64_do_kernel_sea(unsigned long addr, unsigned int esr,
+				     struct pt_regs *regs, int sig, int code)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
+		return false;
+
+	if (user_mode(regs))
+		return false;
+
+	if (apei_claim_sea(regs) < 0)
+		return false;
+
+	if (!fixup_exception_mc(regs))
+		return false;
+
+	if (current->flags & PF_KTHREAD)
+		return true;
+
+	set_thread_esr(0, esr);
+	arm64_force_sig_fault(sig, code, addr,
+		"Uncorrected memory error on access to user memory\n");
+
+	return true;
+}
+
 static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf;
@@ -738,7 +763,9 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 		 */
 		siaddr  = untagged_addr(current->mm, far);
 	}
-	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
+
+	if (!arm64_do_kernel_sea(siaddr, esr, regs, inf->sig, inf->code))
+		arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
 }
-- 
2.25.1

