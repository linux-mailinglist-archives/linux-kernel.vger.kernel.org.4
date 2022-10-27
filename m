Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC360EC26
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiJZXS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiJZXRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:17:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAD7B6004;
        Wed, 26 Oct 2022 16:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666826259; x=1698362259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m10i/LP/gQdBoiVfzvUfJFFOpBHIWPbX2LbjlJua5J0=;
  b=Ja8F6KRH74IPkMvP+KJTZKpoaYHbM2JQSIyIspNDM1AdZR/3hxR58dqN
   IAeL1HcMmaMLZ3oh6DnNM4zh76rLop6QqeaD0IA146r6WMhwBnIDwFRxF
   z0f0y24zXaVPOLxuQjJwQqIyVmPjhDbMxOENaHHdQ3X/KNOSUnKZOoq2N
   7LR6H4GLQ+hNgh2YWaL82kSGhPzI/7kxyMibPrgpp++ixHDX6vXxTcghA
   tPVdbq95DvDz/tzAGF/3vVrLxUip/5gBVCDyeLQs+yK8gTOEnkNtoautk
   sg7iPjZP8//BpLRMS64IUYYL38HiQfMOE6RKmR6r2qbrM68bxgGlpOPsl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="295492084"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="295492084"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 16:17:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="737446306"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="737446306"
Received: from fordon1x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.24.177])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 16:17:21 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, seanjc@google.com, pbonzini@redhat.com,
        dave.hansen@intel.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, kirill.shutemov@linux.intel.com,
        reinette.chatre@intel.com, len.brown@intel.com,
        tony.luck@intel.com, peterz@infradead.org, ak@linux.intel.com,
        isaku.yamahata@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, bagasdotme@gmail.com,
        sagis@google.com, imammedo@redhat.com, kai.huang@intel.com
Subject: [PATCH v6 06/21] x86/virt/tdx: Implement functions to make SEAMCALL
Date:   Thu, 27 Oct 2022 12:16:05 +1300
Message-Id: <993bc6defcba05f34d9aeb5d18e832fad519166b.1666824663.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666824663.git.kai.huang@intel.com>
References: <cover.1666824663.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX introduces a new CPU mode: Secure Arbitration Mode (SEAM).  This
mode runs only the TDX module itself or other code to load the TDX
module.

The host kernel communicates with SEAM software via a new SEAMCALL
instruction.  This is conceptually similar to a guest->host hypercall,
except it is made from the host to SEAM software instead.

The TDX module defines a set of SEAMCALL leaf functions to allow the
host to initialize it, and to create and run protected VMs.  SEAMCALL
leaf functions use an ABI different from the x86-64 system-v ABI.
Instead, they share the same ABI with the TDCALL leaf functions.

Implement a function __seamcall() to allow the host to make SEAMCALL
to SEAM software using the TDX_MODULE_CALL macro which is the common
assembly for both SEAMCALL and TDCALL.

SEAMCALL instruction causes #GP when SEAMRR isn't enabled, and #UD when
CPU is not in VMX operation.  The current TDX_MODULE_CALL macro doesn't
handle any of them.  There's no way to check whether the CPU is in VMX
operation or not.

Initializing the TDX module is done at runtime on demand, and it depends
on the caller to ensure CPU is in VMX operation before making SEAMCALL.
To avoid getting Oops when the caller mistakenly tries to initialize the
TDX module when CPU is not in VMX operation, extend the TDX_MODULE_CALL
macro to handle #UD (and also #GP, which can theoretically still happen
when TDX isn't actually enabled by the BIOS, i.e. due to BIOS bug).

Introduce two new TDX error codes for #UD and #GP respectively so the
caller can distinguish.  Also, Opportunistically put the new TDX error
codes and the existing TDX_SEAMCALL_VMFAILINVALID into INTEL_TDX_HOST
Kconfig option as they are only used when it is on.

As __seamcall() can potentially return multiple error codes, besides the
actual SEAMCALL leaf function return code, also introduce a wrapper
function seamcall() to convert the __seamcall() error code to the kernel
error code, so the caller doesn't need to duplicate the code to check
return value of __seamcall() and return kernel error code accordingly.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v5 -> v6:
 - Added code to handle #UD and #GP (Dave).
 - Moved the seamcall() wrapper function to this patch, and used a
   temporary __always_unused to avoid compile warning (Dave).

- v3 -> v5 (no feedback on v4):
 - Explicitly tell TDX_SEAMCALL_VMFAILINVALID is returned if the
   SEAMCALL itself fails.
 - Improve the changelog.

---
 arch/x86/include/asm/tdx.h       |  9 ++++++
 arch/x86/virt/vmx/tdx/Makefile   |  2 +-
 arch/x86/virt/vmx/tdx/seamcall.S | 52 ++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c      | 42 ++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h      |  8 +++++
 arch/x86/virt/vmx/tdx/tdxcall.S  | 19 ++++++++++--
 6 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 80c76b426adf..d568f17da742 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,6 +8,10 @@
 #include <asm/ptrace.h>
 #include <asm/shared/tdx.h>
 
+#ifdef CONFIG_INTEL_TDX_HOST
+
+#include <asm/trapnr.h>
+
 /*
  * SW-defined error codes.
  *
@@ -18,6 +22,11 @@
 #define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
 #define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
 
+#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
+#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
+
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <asm/pgtable_types.h>
diff --git a/arch/x86/virt/vmx/tdx/Makefile b/arch/x86/virt/vmx/tdx/Makefile
index 93ca8b73e1f1..38d534f2c113 100644
--- a/arch/x86/virt/vmx/tdx/Makefile
+++ b/arch/x86/virt/vmx/tdx/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += tdx.o
+obj-y += tdx.o seamcall.o
diff --git a/arch/x86/virt/vmx/tdx/seamcall.S b/arch/x86/virt/vmx/tdx/seamcall.S
new file mode 100644
index 000000000000..f81be6b9c133
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/seamcall.S
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+#include <asm/frame.h>
+
+#include "tdxcall.S"
+
+/*
+ * __seamcall() - Host-side interface functions to SEAM software module
+ *		  (the P-SEAMLDR or the TDX module).
+ *
+ * Transform function call register arguments into the SEAMCALL register
+ * ABI.  Return TDX_SEAMCALL_VMFAILINVALID if the SEAMCALL itself fails,
+ * or the completion status of the SEAMCALL leaf function.  Additional
+ * output operands are saved in @out (if it is provided by the caller).
+ *
+ *-------------------------------------------------------------------------
+ * SEAMCALL ABI:
+ *-------------------------------------------------------------------------
+ * Input Registers:
+ *
+ * RAX                 - SEAMCALL Leaf number.
+ * RCX,RDX,R8-R9       - SEAMCALL Leaf specific input registers.
+ *
+ * Output Registers:
+ *
+ * RAX                 - SEAMCALL completion status code.
+ * RCX,RDX,R8-R11      - SEAMCALL Leaf specific output registers.
+ *
+ *-------------------------------------------------------------------------
+ *
+ * __seamcall() function ABI:
+ *
+ * @fn  (RDI)          - SEAMCALL Leaf number, moved to RAX
+ * @rcx (RSI)          - Input parameter 1, moved to RCX
+ * @rdx (RDX)          - Input parameter 2, moved to RDX
+ * @r8  (RCX)          - Input parameter 3, moved to R8
+ * @r9  (R8)           - Input parameter 4, moved to R9
+ *
+ * @out (R9)           - struct tdx_module_output pointer
+ *			 stored temporarily in R12 (not
+ *			 used by the P-SEAMLDR or the TDX
+ *			 module). It can be NULL.
+ *
+ * Return (via RAX) the completion status of the SEAMCALL, or
+ * TDX_SEAMCALL_VMFAILINVALID.
+ */
+SYM_FUNC_START(__seamcall)
+	FRAME_BEGIN
+	TDX_MODULE_CALL host=1
+	FRAME_END
+	RET
+SYM_FUNC_END(__seamcall)
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a137350d5d0e..f1154ef15549 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -267,6 +267,48 @@ bool platform_tdx_enabled(void)
 	return !!tdx_keyid_num;
 }
 
+/*
+ * Wrapper of __seamcall() to convert SEAMCALL leaf function error code
+ * to kernel error code.  @seamcall_ret and @out contain the SEAMCALL
+ * leaf function return code and the additional output respectively if
+ * not NULL.
+ */
+static int __always_unused seamcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+				    u64 *seamcall_ret,
+				    struct tdx_module_output *out)
+{
+	u64 sret;
+
+	sret = __seamcall(fn, rcx, rdx, r8, r9, out);
+
+	/* Save SEAMCALL return code if caller wants it */
+	if (seamcall_ret)
+		*seamcall_ret = sret;
+
+	/* SEAMCALL was successful */
+	if (!sret)
+		return 0;
+
+	switch (sret) {
+	case TDX_SEAMCALL_GP:
+		/*
+		 * platform_tdx_enabled() is checked to be true
+		 * before making any SEAMCALL.
+		 */
+		WARN_ON_ONCE(1);
+		fallthrough;
+	case TDX_SEAMCALL_VMFAILINVALID:
+		/* Return -ENODEV if the TDX module is not loaded. */
+		return -ENODEV;
+	case TDX_SEAMCALL_UD:
+		/* Return -EINVAL if CPU isn't in VMX operation. */
+		return -EINVAL;
+	default:
+		/* Return -EIO if the actual SEAMCALL leaf failed. */
+		return -EIO;
+	}
+}
+
 /*
  * Detect and initialize the TDX module.
  *
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index d00074abcb20..92a8de957dc7 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -12,4 +12,12 @@
 /* MSR to report KeyID partitioning between MKTME and TDX */
 #define MSR_IA32_MKTME_KEYID_PARTITIONING	0x00000087
 
+/*
+ * Do not put any hardware-defined TDX structure representations below
+ * this comment!
+ */
+
+struct tdx_module_output;
+u64 __seamcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+	       struct tdx_module_output *out);
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 49a54356ae99..757b0c34be10 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/asm-offsets.h>
 #include <asm/tdx.h>
+#include <asm/asm.h>
 
 /*
  * TDCALL and SEAMCALL are supported in Binutils >= 2.36.
@@ -45,6 +46,7 @@
 	/* Leave input param 2 in RDX */
 
 	.if \host
+1:
 	seamcall
 	/*
 	 * SEAMCALL instruction is essentially a VMExit from VMX root
@@ -57,10 +59,23 @@
 	 * This value will never be used as actual SEAMCALL error code as
 	 * it is from the Reserved status code class.
 	 */
-	jnc .Lno_vmfailinvalid
+	jnc .Lseamcall_out
 	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
-.Lno_vmfailinvalid:
+	jmp .Lseamcall_out
+2:
+	/*
+	 * SEAMCALL caused #GP or #UD.  By reaching here %eax contains
+	 * the trap number.  Convert the trap number to the TDX error
+	 * code by setting TDX_SW_ERROR to the high 32-bits of %rax.
+	 *
+	 * Note cannot OR TDX_SW_ERROR directly to %rax as OR instruction
+	 * only accepts 32-bit immediate at most.
+	 */
+	mov $TDX_SW_ERROR, %r12
+	orq %r12, %rax
 
+	_ASM_EXTABLE_FAULT(1b, 2b)
+.Lseamcall_out:
 	.else
 	tdcall
 	.endif
-- 
2.37.3

