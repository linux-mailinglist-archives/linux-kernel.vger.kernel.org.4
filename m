Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F0666BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjALHoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbjALHoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:44:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D73F45B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673509464; x=1705045464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zfPuPqY/N+g3C8lVyiqhCWzrPDWRk0al1rHlpRNy3Y0=;
  b=eA9GJvV86bAUnnRoOLoNpdGoaTHyqm3dldE9aqiaHHf+dd+Y4TxInSmU
   Yw3oFVGQQDgURbYEL4p8A4fs4mKODga28i9QxDYwuKrwk+gEMdfut2d/p
   DFaUbLxi+Tb4cp/IWuNYRkHbWzSvYzlYow/lpKbqSwwiORob87U8VzM7j
   aDFkoFDBmO/hHgkMM4BPXfxGPBH8NqgJpvgqBi1Gvl4X3BaeBd4RJ3Zx8
   5hVXxzggOIwjehL6ZZISMwPGEoVsuUqtud3pNWr8dLngWZ28zY8pxoS/F
   NOaFGDrT3K3Qto4lHsSbOlVTLvH1ZXU+eC25UyJs16FxUW8ptDc0cR2T9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321328717"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="321328717"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="635283994"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="635283994"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2023 23:44:23 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: [PATCH v6 5/5] x86/gsseg: use the LKGS instruction if available for load_gs_index()
Date:   Wed, 11 Jan 2023 23:20:32 -0800
Message-Id: <20230112072032.35626-6-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112072032.35626-1-xin3.li@intel.com>
References: <20230112072032.35626-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The LKGS instruction atomically loads a segment descriptor into the
%gs descriptor registers, *except* that %gs.base is unchanged, and the
base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
what we want this function to do.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Changes since v5:
* Remove reviewers' SOBs (Borislav Petkov).

Changes since v4:
* Clear the LKGS feature from Xen PV guests (Juergen Gross).

Changes since v3:
* We want less ASM not more, thus keep local_irq_{save,restore}() inside
  native_load_gs_index() (Thomas Gleixner).
* For paravirt enabled kernels, initialize pv_ops.cpu.load_gs_index to
  native_lkgs (Thomas Gleixner).

Changes since v2:
* Mark DI as input and output (+D) as in v1, since the exception handler
  modifies it (Brian Gerst).

Changes since v1:
* Use EX_TYPE_ZERO_REG instead of fixup code in the obsolete .fixup code
  section (Peter Zijlstra).
* Add a comment that states the LKGS_DI macro will be replaced with "lkgs %di"
  once the binutils support the LKGS instruction (Peter Zijlstra).
---
 arch/x86/include/asm/gsseg.h | 33 +++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/common.c |  1 +
 arch/x86/xen/enlighten_pv.c  |  1 +
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index d15577c39e8d..ab6a595cea70 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -14,17 +14,42 @@
 
 extern asmlinkage void asm_load_gs_index(u16 selector);
 
+/* Replace with "lkgs %di" once binutils support LKGS instruction */
+#define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
+
+static inline void native_lkgs(unsigned int selector)
+{
+	u16 sel = selector;
+	asm_inline volatile("1: " LKGS_DI
+			    _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k[sel])
+			    : [sel] "+D" (sel));
+}
+
 static inline void native_load_gs_index(unsigned int selector)
 {
-	unsigned long flags;
+	if (cpu_feature_enabled(X86_FEATURE_LKGS)) {
+		native_lkgs(selector);
+	} else {
+		unsigned long flags;
 
-	local_irq_save(flags);
-	asm_load_gs_index(selector);
-	local_irq_restore(flags);
+		local_irq_save(flags);
+		asm_load_gs_index(selector);
+		local_irq_restore(flags);
+	}
 }
 
 #endif /* CONFIG_X86_64 */
 
+static inline void __init lkgs_init(void)
+{
+#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_X86_64
+	if (cpu_feature_enabled(X86_FEATURE_LKGS))
+		pv_ops.cpu.load_gs_index = native_lkgs;
+#endif
+#endif
+}
+
 #ifndef CONFIG_PARAVIRT_XXL
 
 static inline void load_gs_index(unsigned int selector)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d7d0e2..b7ac85a1e5df 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1960,6 +1960,7 @@ void __init identify_boot_cpu(void)
 	setup_cr_pinning();
 
 	tsx_init();
+	lkgs_init();
 }
 
 void identify_secondary_cpu(struct cpuinfo_x86 *c)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5b1379662877..ce2f19ee4bfc 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -276,6 +276,7 @@ static void __init xen_init_capabilities(void)
 	setup_clear_cpu_cap(X86_FEATURE_ACC);
 	setup_clear_cpu_cap(X86_FEATURE_X2APIC);
 	setup_clear_cpu_cap(X86_FEATURE_SME);
+	setup_clear_cpu_cap(X86_FEATURE_LKGS);
 
 	/*
 	 * Xen PV would need some work to support PCID: CR3 handling as well
-- 
2.34.1

