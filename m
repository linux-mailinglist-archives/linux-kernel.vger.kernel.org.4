Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F961E691
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKFV3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiKFV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:29:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BBB1FE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:29:38 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3DADA1EC06A9;
        Sun,  6 Nov 2022 22:29:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667770177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=MvaBIEo5j4icp2jk7W9uNf4VMOnSMT/FNWVXKZ9V6ls=;
        b=bMlBL4/+TPXEll0WcznX0ASRy6IJUgIuJlyGI5rdxGkIrUPkYuMJSek/sX1UB4GOVnU8xJ
        sb6nKW/f5Kxd2uxH0/MMKuo3oCtO8qej9vogXFrpZXLyy9nsotvfQwvfARUdiF9/2l4vEQ
        Lt4ParIby8diNjYIOQdVKXjTC/u/OG4=
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/resctrl: Move MSR defines into msr-index.h
Date:   Sun,  6 Nov 2022 22:29:23 +0100
Message-Id: <20221106212923.20699-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

msr-index.h should contain all MSRs for easier grepping for MSR numbers
when dealing with unchecked MSR access warnings, for example.

Move the resctrl ones. Prefix IA32_PQR_ASSOC with "MSR_" while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/msr-index.h          | 22 ++++++++++++++++------
 arch/x86/include/asm/resctrl.h            |  8 +++-----
 arch/x86/kernel/cpu/resctrl/core.c        |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 +---------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 ++--
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a3eb4d3e70b8..c29cf6d1935b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -4,12 +4,7 @@
 
 #include <linux/bits.h>
 
-/*
- * CPU model specific register (MSR) numbers.
- *
- * Do not add new entries to this file unless the definitions are shared
- * between multiple compilation units.
- */
+/* CPU model specific register (MSR) numbers. */
 
 /* x86-64 specific MSRs */
 #define MSR_EFER		0xc0000080 /* extended feature register */
@@ -1051,6 +1046,21 @@
 #define VMX_BASIC_MEM_TYPE_WB	6LLU
 #define VMX_BASIC_INOUT		0x0040000000000000LLU
 
+/* Resctrl MSRs: */
+/* - Intel: */
+#define MSR_IA32_L3_QOS_CFG		0xc81
+#define MSR_IA32_L2_QOS_CFG		0xc82
+#define MSR_IA32_QM_EVTSEL		0xc8d
+#define MSR_IA32_QM_CTR			0xc8e
+#define MSR_IA32_PQR_ASSOC		0xc8f
+#define MSR_IA32_L3_CBM_BASE		0xc90
+#define MSR_IA32_L2_CBM_BASE		0xd10
+#define MSR_IA32_MBA_THRTL_BASE		0xd50
+
+
+/* - AMD: */
+#define MSR_IA32_MBA_BW_BASE		0xc0000200
+
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
 #define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index d24b04ebf950..52788f79786f 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -7,8 +7,6 @@
 #include <linux/sched.h>
 #include <linux/jump_label.h>
 
-#define IA32_PQR_ASSOC	0x0c8f
-
 /**
  * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
@@ -16,8 +14,8 @@
  * @default_rmid:	The user assigned Resource Monitoring ID
  * @default_closid:	The user assigned cached Class Of Service ID
  *
- * The upper 32 bits of IA32_PQR_ASSOC contain closid and the
- * lower 10 bits rmid. The update to IA32_PQR_ASSOC always
+ * The upper 32 bits of MSR_IA32_PQR_ASSOC contain closid and the
+ * lower 10 bits rmid. The update to MSR_IA32_PQR_ASSOC always
  * contains both parts, so we need to cache them. This also
  * stores the user configured per cpu CLOSID and RMID.
  *
@@ -77,7 +75,7 @@ static void __resctrl_sched_in(void)
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
 		state->cur_closid = closid;
 		state->cur_rmid = rmid;
-		wrmsr(IA32_PQR_ASSOC, rmid, closid);
+		wrmsr(MSR_IA32_PQR_ASSOC, rmid, closid);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 03cfbf0fe000..c98e52ff5f20 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -575,7 +575,7 @@ static void clear_closid_rmid(int cpu)
 	state->default_rmid = 0;
 	state->cur_closid = 0;
 	state->cur_rmid = 0;
-	wrmsr(IA32_PQR_ASSOC, 0, 0);
+	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
 }
 
 static int resctrl_online_cpu(unsigned int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5f7128686cfd..4f43da46243d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -8,15 +8,7 @@
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
 
-#define MSR_IA32_L3_QOS_CFG		0xc81
-#define MSR_IA32_L2_QOS_CFG		0xc82
-#define MSR_IA32_L3_CBM_BASE		0xc90
-#define MSR_IA32_L2_CBM_BASE		0xd10
-#define MSR_IA32_MBA_THRTL_BASE		0xd50
-#define MSR_IA32_MBA_BW_BASE		0xc0000200
-
-#define MSR_IA32_QM_CTR			0x0c8e
-#define MSR_IA32_QM_EVTSEL		0x0c8d
+
 
 #define L3_QOS_CDP_ENABLE		0x01ULL
 
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d961ae3ed96e..ba8d0763b36b 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -477,7 +477,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 * pseudo-locked followed by reading of kernel memory to load it
 	 * into the cache.
 	 */
-	__wrmsr(IA32_PQR_ASSOC, rmid_p, rdtgrp->closid);
+	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, rdtgrp->closid);
 	/*
 	 * Cache was flushed earlier. Now access kernel memory to read it
 	 * into cache region associated with just activated plr->closid.
@@ -513,7 +513,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	 * Critical section end: restore closid with capacity bitmask that
 	 * does not overlap with pseudo-locked region.
 	 */
-	__wrmsr(IA32_PQR_ASSOC, rmid_p, closid_p);
+	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, closid_p);
 
 	/* Re-enable the hardware prefetcher(s) */
 	wrmsrl(MSR_MISC_FEATURE_CONTROL, saved_msr);
-- 
2.35.1

