Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5C60816A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJUWTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJUWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:19:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04D32AAC37
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666390735; x=1697926735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gEG2tHR0mORaTs/27DrSxXAoQxHVtIw6aexh2qbShjg=;
  b=Npuu8vxVd81KanRMReIo7ATpE6Dsz/eioyFk2L+WaszaiH4hK44rmsrU
   OUdla1+jtv770qwed3gPKN5T0bpG7ezc4pEBRmiJJ3lUFEGu+RPxtdySA
   UiqfF+KMRgAAi0V1MjMgzhT3UMU7M0SKzINLLL2PPSlaitL08ueQkdpic
   /DwcJpRcu0U1+y99sNgQ8igLgbV/Y//7Q4jiWV7cSN+ktBMU7gKG1OVch
   0nIkI7RbTCLo11y3vYyCfXEiw3KxsjL9995A674kV43BEkkx6jEhh7Cz6
   6UZq57fwVM2Tpz+SPN95PbAVINdYUU7q00KMdNGG8aUs23Hp5gIdZoBH/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369181093"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369181093"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:18:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="959808503"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="959808503"
Received: from sanekar-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.5.12])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:18:36 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        keescook@chromium.org, ebiederm@xmission.com
Subject: [PATCH 1/2] x86: Separate out x86_regset for 32 and 64 bit
Date:   Fri, 21 Oct 2022 15:18:02 -0700
Message-Id: <20221021221803.10910-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021221803.10910-1-rick.p.edgecombe@intel.com>
References: <20221021221803.10910-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fill_thread_core_info() the ptrace accessible registers are collected
for a core file to be written out as notes. The note array is allocated
from a size calculated by iterating the user regset view, and counting the
regsets that have a non-zero core_note_type. However, this only allows for
there to be non-zero core_note_type at the end of the regset view. If
there are any in the middle, fill_thread_core_info() will overflow the
note allocation, as it iterates over the size of the view and the
allocation would be smaller than that.

To apparently avoid this problem, x86_32_regsets and x86_64_regsets need
to be constructed in a special way. They both draw their indices from a
shared enum x86_regset, but 32 bit and 64 bit don't all support the same
regsets and can be compiled in at the same time in the case of
IA32_EMULATION. So this enum has to be laid out in a special way such that
there are no gaps for both x86_32_regsets and x86_64_regsets. This
involves ordering them just right by creating aliases for enum’s that
are only in one view or the other, or creating multiple versions like
REGSET32_IOPERM/REGSET64_IOPERM.

So the collection of the registers tries to minimize the size of the
allocation, but it doesn’t quite work. Then the x86 ptrace side works
around it by constructing the enum just right to avoid a problem. In the
end there is no functional problem, but it is somewhat strange and
fragile.

It could also be improved like this [1], by better utilizing the smaller
array, but this still wastes space in the regset array’s if they are not
carefully crafted to avoid gaps. Instead, just fully separate out the
enums and give them separate 32 and 64 enum names. Add some bitsize-free
defines for REGSET_GENERAL and REGSET_FP since they are the only two
referred to in bitsize generic code.

While introducing a bunch of new 32/64 enums, change the pattern of the
name from REGSET_FOO32 to REGSET32_FOO to better indicate that the 32 is
in reference to the CPU mode and not the register size, as suggested by
Eric Biederman.

This should have no functional change and is only changing how constants
are generated and referred to.

[1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/ptrace.c | 67 ++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 37c12fb92906..356495ab37a6 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -44,16 +44,35 @@
 
 #include "tls.h"
 
-enum x86_regset {
-	REGSET_GENERAL,
-	REGSET_FP,
-	REGSET_XFP,
-	REGSET_IOPERM64 = REGSET_XFP,
-	REGSET_XSTATE,
-	REGSET_TLS,
-	REGSET_IOPERM32,
+enum x86_regset_32 {
+	REGSET32_GENERAL,
+	REGSET32_FP,
+	REGSET32_XFP,
+	REGSET32_XSTATE,
+	REGSET32_TLS,
+	REGSET32_IOPERM,
 };
 
+enum x86_regset_64 {
+	REGSET64_GENERAL,
+	REGSET64_FP,
+	REGSET64_IOPERM,
+	REGSET64_XSTATE,
+};
+
+#define REGSET_GENERAL \
+({ \
+	BUILD_BUG_ON((int)REGSET32_GENERAL != (int)REGSET64_GENERAL); \
+	REGSET32_GENERAL; \
+})
+
+#define REGSET_FP \
+({ \
+	BUILD_BUG_ON((int)REGSET32_FP != (int)REGSET64_FP); \
+	REGSET32_FP; \
+})
+
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -788,13 +807,13 @@ long arch_ptrace(struct task_struct *child, long request,
 #ifdef CONFIG_X86_32
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP,
+					   REGSET32_XFP,
 					   0, sizeof(struct user_fxsr_struct),
 					   datap) ? -EIO : 0;
 
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP,
+					     REGSET32_XFP,
 					     0, sizeof(struct user_fxsr_struct),
 					     datap) ? -EIO : 0;
 #endif
@@ -1086,13 +1105,13 @@ static long ia32_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP, 0,
+					   REGSET32_XFP, 0,
 					   sizeof(struct user32_fxsr_struct),
 					   datap);
 
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP, 0,
+					     REGSET32_XFP, 0,
 					     sizeof(struct user32_fxsr_struct),
 					     datap);
 
@@ -1215,25 +1234,25 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 #ifdef CONFIG_X86_64
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
-	[REGSET_GENERAL] = {
+	[REGSET64_GENERAL] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
 		.regset_get = genregs_get, .set = genregs_set
 	},
-	[REGSET_FP] = {
+	[REGSET64_FP] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct fxregs_state) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
 		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
 	},
-	[REGSET_XSTATE] = {
+	[REGSET64_XSTATE] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = xstateregs_active, .regset_get = xstateregs_get,
 		.set = xstateregs_set
 	},
-	[REGSET_IOPERM64] = {
+	[REGSET64_IOPERM] = {
 		.core_note_type = NT_386_IOPERM,
 		.n = IO_BITMAP_LONGS,
 		.size = sizeof(long), .align = sizeof(long),
@@ -1256,31 +1275,31 @@ static const struct user_regset_view user_x86_64_view = {
 
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init = {
-	[REGSET_GENERAL] = {
+	[REGSET32_GENERAL] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.regset_get = genregs32_get, .set = genregs32_set
 	},
-	[REGSET_FP] = {
+	[REGSET32_FP] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
 	},
-	[REGSET_XFP] = {
+	[REGSET32_XFP] = {
 		.core_note_type = NT_PRXFPREG,
 		.n = sizeof(struct fxregs_state) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
 	},
-	[REGSET_XSTATE] = {
+	[REGSET32_XSTATE] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = xstateregs_active, .regset_get = xstateregs_get,
 		.set = xstateregs_set
 	},
-	[REGSET_TLS] = {
+	[REGSET32_TLS] = {
 		.core_note_type = NT_386_TLS,
 		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
 		.size = sizeof(struct user_desc),
@@ -1288,7 +1307,7 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.active = regset_tls_active,
 		.regset_get = regset_tls_get, .set = regset_tls_set
 	},
-	[REGSET_IOPERM32] = {
+	[REGSET32_IOPERM] = {
 		.core_note_type = NT_386_IOPERM,
 		.n = IO_BITMAP_BYTES / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
@@ -1311,10 +1330,10 @@ u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 void __init update_regset_xstate_info(unsigned int size, u64 xstate_mask)
 {
 #ifdef CONFIG_X86_64
-	x86_64_regsets[REGSET_XSTATE].n = size / sizeof(u64);
+	x86_64_regsets[REGSET64_XSTATE].n = size / sizeof(u64);
 #endif
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
-	x86_32_regsets[REGSET_XSTATE].n = size / sizeof(u64);
+	x86_32_regsets[REGSET32_XSTATE].n = size / sizeof(u64);
 #endif
 	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] = xstate_mask;
 }
-- 
2.17.1

