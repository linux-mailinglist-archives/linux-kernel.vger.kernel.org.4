Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2141866404A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbjAJMTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbjAJMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:18:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325A1007;
        Tue, 10 Jan 2023 04:17:42 -0800 (PST)
Date:   Tue, 10 Jan 2023 12:17:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673353061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qlyhtl6UCk6IJE6m2SO/XYxMAmhSLvJ2M+7gupWPffg=;
        b=VvqOVOlK/pqkl2m7a79dLahHN6Wo7M3FpaEKo/o1Tp25tjOGEWJAbzDBMYd2P9hRmOCcDT
        R35doo14foLx/ZxuGmDcDIeUXXtQ9XUIyurtFEbLZbuxUokK7UT3Wc3Sxy3Vil6Dpep/SL
        LfwJr9b+0iugN83RF8FRX8lfJt2Me7CcoxRv9GfoTF3PrdfIXYpFvUfSbHch9GlL7X0Q2D
        gIAcv3OVWJHfbLlfZvtFZcRjWTe/zMBf8Uw5sDjcAvg/fLqbXJMEULRau/e+DAfdsOCrQA
        EJ+K3ZvpC9kHvdqEsjTI3eKsrcssokH0iyu7ttr1q1p8x0mG4UmiYbhLacfRLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673353061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qlyhtl6UCk6IJE6m2SO/XYxMAmhSLvJ2M+7gupWPffg=;
        b=rVb4vCXF5hRCkwV7WMxR80HJqHeZVzvh9EJXwN8S3SnR/NbYlgCjROQAwcTV4dveVrAjl3
        CyBXpsCYJxSQNIAw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Mask out non-address bits from machine check bank
Cc:     Isaku Yamahata <isaku.yamahata@intel.com>,
        Fan Du <fan.du@intel.com>, Tony Luck <tony.luck@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230109152936.397862-1-tony.luck@intel.com>
References: <20230109152936.397862-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <167335306058.4906.5735351433477088640.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     8a01ec97dc066009dd89e43bfcf55644f2dd6d19
Gitweb:        https://git.kernel.org/tip/8a01ec97dc066009dd89e43bfcf55644f2dd6d19
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 09 Jan 2023 07:29:36 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Jan 2023 11:47:07 +01:00

x86/mce: Mask out non-address bits from machine check bank

Systems that support various memory encryption schemes (MKTME, TDX, SEV)
use high order physical address bits to indicate which key should be
used for a specific memory location.

When a memory error is reported, some systems may report those key
bits in the IA32_MCi_ADDR machine check MSR.

The Intel SDM has a footnote for the contents of the address register
that says: "Useful bits in this field depend on the address methodology
in use when the register state is saved."

AMD Processor Programming Reference has a more explicit description
of the MCA_ADDR register:

 "For physical addresses, the most significant bit is given by
  Core::X86::Cpuid::LongModeInfo[PhysAddrSize]."

Add a new #define MCI_ADDR_PHYSADDR for the mask of valid physical
address bits within the machine check bank address register. Use this
mask for recoverable machine check handling and in the EDAC driver to
ignore any key bits that may be present.

  [ Tony: Based on independent fixes proposed by Fan Du and Isaku Yamahata ]

Reported-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reported-by: Fan Du <fan.du@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20230109152936.397862-1-tony.luck@intel.com
---
 arch/x86/include/asm/mce.h     |  3 +++
 arch/x86/kernel/cpu/mce/core.c | 14 +++++++++-----
 drivers/edac/skx_common.c      |  2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6e98608..9646ed6 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -88,6 +88,9 @@
 #define  MCI_MISC_ADDR_MEM	3	/* memory address */
 #define  MCI_MISC_ADDR_GENERIC	7	/* generic */
 
+/* MCi_ADDR register defines */
+#define MCI_ADDR_PHYSADDR	GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
+
 /* CTL2 register defines */
 #define MCI_CTL2_CMCI_EN		BIT_ULL(30)
 #define MCI_CTL2_CMCI_THRESHOLD_MASK	0x7fffULL
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 626a1c6..7832a69 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -573,7 +573,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 	    mce->severity != MCE_DEFERRED_SEVERITY)
 		return NOTIFY_DONE;
 
-	pfn = mce->addr >> PAGE_SHIFT;
+	pfn = (mce->addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
 	if (!memory_failure(pfn, 0)) {
 		set_mce_nospec(pfn);
 		mce->kflags |= MCE_HANDLED_UC;
@@ -1294,6 +1294,7 @@ static void kill_me_maybe(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
+	unsigned long pfn;
 	int ret;
 
 	p->mce_count = 0;
@@ -1302,9 +1303,10 @@ static void kill_me_maybe(struct callback_head *cb)
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
+	pfn = (p->mce_addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
+	ret = memory_failure(pfn, flags);
 	if (!ret) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+		set_mce_nospec(pfn);
 		sync_core();
 		return;
 	}
@@ -1326,11 +1328,13 @@ static void kill_me_maybe(struct callback_head *cb)
 static void kill_me_never(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+	unsigned long pfn;
 
 	p->mce_count = 0;
 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+	pfn = (p->mce_addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
+	if (!memory_failure(pfn, 0))
+		set_mce_nospec(pfn);
 }
 
 static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index f0f8e98..806986f 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -657,7 +657,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 	memset(&res, 0, sizeof(res));
 	res.mce  = mce;
-	res.addr = mce->addr;
+	res.addr = mce->addr & MCI_ADDR_PHYSADDR;
 
 	/* Try driver decoder first */
 	if (!(driver_decode && driver_decode(&res))) {
