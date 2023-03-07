Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B336AE1DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCGOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCGOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3A3867E8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00B44B81900
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D53C4339C;
        Tue,  7 Mar 2023 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198065;
        bh=L2+rgVx2iv3hRHUq+qUrb8b1wtfayhr80bZIYC3PNSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJ9rvgoQ6qhXJ4fKL6aSQ01F1mlWPTmSefIFRcnR0S2mgH6H8MNK+FpAtc5ePuJ3+
         J2QWqeGt5WfyHS9hj5PT7WM0Tl55bnifu1Xo+uBdIY3+ezR62S1Oh71BPFPbayM3yl
         mpvoQKS1QSlVN1g0JY+1Hb3j2O2NNT3AaLLU6fcnympJeMAAD/BFuuy6RQvIFvbnzd
         n3OfigaUPVNVBsKsq5iPvgKFNfyD1f4adD8RLVY50/37J5n7H0H2DZ8kfnUZUO8OPP
         wtWRkx27kpV+03nBbdhjkuV4s40ya6wfXdegS7BxmITuocuBKc+zmw4WzTSvydevsG
         TNP9VeQ3fpc6A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 28/60] arm64: head: move dynamic shadow call stack patching into early C runtime
Date:   Tue,  7 Mar 2023 15:04:50 +0100
Message-Id: <20230307140522.2311461-29-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6238; i=ardb@kernel.org; h=from:subject; bh=L2+rgVx2iv3hRHUq+qUrb8b1wtfayhr80bZIYC3PNSI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxTV+VVgVc1Z3lq6egMSRSVf/ikxRfed15eDkroZVf nlbJh3uKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZxcbI0HOl7lb6mnN5++5c i98i+G3eg5BfCuGMP6edP3NihoSCvCbDP82Y7eUOT7ZYFM7bbdu49TdPntLq/a3h8cvUQ3c4KCv P4gAA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we update the early kernel mapping code to only map the kernel once
with the right permissions, we can no longer perform code patching via
this mapping.

So move this code to an earlier stage of the boot, right after applying
the relocations.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/scs.h           |  2 +-
 arch/arm64/kernel/Makefile             |  2 --
 arch/arm64/kernel/head.S               |  8 +++---
 arch/arm64/kernel/module.c             |  2 +-
 arch/arm64/kernel/pi/Makefile          | 10 +++++---
 arch/arm64/kernel/{ => pi}/patch-scs.c | 26 ++++++++++----------
 6 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index 13df982a080805e6..bcf8ad574807b82c 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -72,7 +72,7 @@ static inline void dynamic_scs_init(void)
 static inline void dynamic_scs_init(void) {}
 #endif
 
-int scs_patch(const u8 eh_frame[], int size);
+int __pi_scs_patch(const u8 eh_frame[], int size);
 
 #endif /* __ASSEMBLY __ */
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 4f1fcaebafcfe077..bae6194df6a50479 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -72,8 +72,6 @@ obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
 obj-y					+= vdso-wrap.o
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
-obj-$(CONFIG_UNWIND_PATCH_PAC_INTO_SCS)	+= patch-scs.o
-CFLAGS_patch-scs.o			+= -mbranch-protection=none
 
 # Force dependency (vdso*-wrap.S includes vdso.so through incbin)
 $(obj)/vdso-wrap.o: $(obj)/vdso/vdso.so
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0a345898a12939af..70ad180eed364906 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -490,9 +490,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #endif
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
-#endif
-#ifdef CONFIG_UNWIND_PATCH_PAC_INTO_SCS
-	bl	scs_patch_vmlinux
 #endif
 	mov	x0, x20
 	bl	finalise_el2			// Prefer VHE if possible
@@ -792,6 +789,11 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #ifdef CONFIG_RELOCATABLE
 	mov	x0, x23
 	bl	__pi_relocate_kernel
+#endif
+#ifdef CONFIG_UNWIND_PATCH_PAC_INTO_SCS
+	ldr	x0, =__eh_frame_start
+	ldr	x1, =__eh_frame_end
+	bl	__pi_scs_patch_vmlinux
 #endif
 	ldr	x8, =__primary_switched
 	adrp	x0, KERNEL_START		// __pa(KERNEL_START)
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 5af4975caeb58ff7..9df01fce6ed528a0 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -516,7 +516,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	if (scs_is_dynamic()) {
 		s = find_section(hdr, sechdrs, ".init.eh_frame");
 		if (s)
-			scs_patch((void *)s->sh_addr, s->sh_size);
+			__pi_scs_patch((void *)s->sh_addr, s->sh_size);
 	}
 
 	return module_init_ftrace_plt(hdr, sechdrs, me);
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index 7f6dfce893c3b88f..a8b302245f15326a 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -38,7 +38,9 @@ $(obj)/lib-%.pi.o: OBJCOPYFLAGS += --prefix-alloc-sections=.init
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-obj-y				:= idreg-override.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
-obj-$(CONFIG_RELOCATABLE)	+= relocate.pi.o
-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr_early.pi.o
-extra-y				:= $(patsubst %.pi.o,%.o,$(obj-y))
+obj-y					:= idreg-override.pi.o \
+					   lib-fdt.pi.o lib-fdt_ro.pi.o
+obj-$(CONFIG_RELOCATABLE)		+= relocate.pi.o
+obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr_early.pi.o
+obj-$(CONFIG_UNWIND_PATCH_PAC_INTO_SCS)	+= patch-scs.pi.o
+extra-y					:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/arm64/kernel/patch-scs.c b/arch/arm64/kernel/pi/patch-scs.c
similarity index 91%
rename from arch/arm64/kernel/patch-scs.c
rename to arch/arm64/kernel/pi/patch-scs.c
index a1fe4b4ff5917670..c65ef40d1e6b6b30 100644
--- a/arch/arm64/kernel/patch-scs.c
+++ b/arch/arm64/kernel/pi/patch-scs.c
@@ -4,14 +4,11 @@
  * Author: Ard Biesheuvel <ardb@google.com>
  */
 
-#include <linux/bug.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
-#include <linux/printk.h>
 #include <linux/types.h>
 
-#include <asm/cacheflush.h>
 #include <asm/scs.h>
 
 //
@@ -81,7 +78,11 @@ static void __always_inline scs_patch_loc(u64 loc)
 		 */
 		return;
 	}
-	dcache_clean_pou(loc, loc + sizeof(u32));
+	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_CLEAN_CACHE))
+		asm("dc civac, %0" :: "r"(loc));
+	else
+		asm(ALTERNATIVE("dc cvau, %0", "nop", ARM64_HAS_CACHE_IDC)
+		    :: "r"(loc));
 }
 
 /*
@@ -128,10 +129,10 @@ struct eh_frame {
 	};
 };
 
-static int noinstr scs_handle_fde_frame(const struct eh_frame *frame,
-					bool fde_has_augmentation_data,
-					int code_alignment_factor,
-					bool dry_run)
+static int scs_handle_fde_frame(const struct eh_frame *frame,
+				bool fde_has_augmentation_data,
+				int code_alignment_factor,
+				bool dry_run)
 {
 	int size = frame->size - offsetof(struct eh_frame, opcodes) + 4;
 	u64 loc = (u64)offset_to_ptr(&frame->initial_loc);
@@ -198,14 +199,13 @@ static int noinstr scs_handle_fde_frame(const struct eh_frame *frame,
 			break;
 
 		default:
-			pr_err("unhandled opcode: %02x in FDE frame %lx\n", opcode[-1], (uintptr_t)frame);
 			return -ENOEXEC;
 		}
 	}
 	return 0;
 }
 
-int noinstr scs_patch(const u8 eh_frame[], int size)
+int scs_patch(const u8 eh_frame[], int size)
 {
 	const u8 *p = eh_frame;
 
@@ -251,12 +251,12 @@ int noinstr scs_patch(const u8 eh_frame[], int size)
 	return 0;
 }
 
-asmlinkage void __init scs_patch_vmlinux(void)
+asmlinkage void __init scs_patch_vmlinux(const u8 start[], const u8 end[])
 {
 	if (!should_patch_pac_into_scs())
 		return;
 
-	WARN_ON(scs_patch(__eh_frame_start, __eh_frame_end - __eh_frame_start));
-	icache_inval_all_pou();
+	scs_patch(start, end - start);
+	asm("ic ialluis");
 	isb();
 }
-- 
2.39.2

