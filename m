Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E007386E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjFUO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjFUOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B956199F;
        Wed, 21 Jun 2023 07:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77BC76156A;
        Wed, 21 Jun 2023 14:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC809C433C0;
        Wed, 21 Jun 2023 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687357543;
        bh=Jd9RRx6H8YaH+8Xga/Kh2G2duYrTaba3dF0LvtJouKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDXffIb7fxNTvcEg2u7fQS9WaGDExvWVJKVPlrX2l1BTWXb0BKKAUY5lKuNSS3qrN
         w5yHccmP/o9jttyxDGpvLOVvgwPI+4vnM3NklblB5arWcUhcBqoDtgy3nSypaqUtGm
         ISlgSuErG1dEkUpJHPD8U2PUqdXi6esF438NV5Wo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.35
Date:   Wed, 21 Jun 2023 16:25:33 +0200
Message-ID: <2023062133-stinky-charger-b16a@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023062133-recopy-device-74fc@gregkh>
References: <2023062133-recopy-device-74fc@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index bc7cc17b0e75..46c06af912d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 34
+SUBLEVEL = 35
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 3b88209bacea..ff1f9a1bcfcf 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -132,6 +132,7 @@ L2: cache-controller@2c0f0000 {
 		reg = <0x2c0f0000 0x1000>;
 		interrupts = <0 84 4>;
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	pmu {
diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 707bd32e5c4f..3a2edb157b65 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -271,7 +271,7 @@ static void loongarch_pmu_enable_event(struct hw_perf_event *evt, int idx)
 	WARN_ON(idx < 0 || idx >= loongarch_pmu.num_counters);
 
 	/* Make sure interrupt enabled. */
-	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base & 0xff) |
+	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base) |
 		(evt->config_base & M_PERFCTL_CONFIG_MASK) | CSR_PERFCTRL_IE;
 
 	cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
@@ -594,7 +594,7 @@ static struct pmu pmu = {
 
 static unsigned int loongarch_pmu_perf_event_encode(const struct loongarch_perf_event *pev)
 {
-	return (pev->event_id & 0xff);
+	return M_PERFCTL_EVENT(pev->event_id);
 }
 
 static const struct loongarch_perf_event *loongarch_pmu_map_general_event(int idx)
@@ -849,7 +849,7 @@ static void resume_local_counters(void)
 
 static const struct loongarch_perf_event *loongarch_pmu_map_raw_event(u64 config)
 {
-	raw_event.event_id = config & 0xff;
+	raw_event.event_id = M_PERFCTL_EVENT(config);
 
 	return &raw_event;
 }
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b26b77673c2c..2f5835e300a8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -82,6 +82,7 @@ config MIPS
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
+	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index b296e33f8e33..85d3c3b4b7bd 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -109,7 +109,7 @@ endif
 # (specifically newer than 2.24.51.20140728) we then also need to explicitly
 # set ".set hardfloat" in all files which manipulate floating point registers.
 #
-ifneq ($(call as-option,-Wa$(comma)-msoft-float,),)
+ifneq ($(call cc-option,$(cflags-y) -Wa$(comma)-msoft-float,),)
 	cflags-y		+= -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float
 endif
 
@@ -152,7 +152,7 @@ cflags-y += -fno-stack-check
 #
 # Avoid this by explicitly disabling that assembler behaviour.
 #
-cflags-y += $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+cflags-y += $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 
 #
 # CPU-dependent compiler/assembler options for optimization.
diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 5ab043000409..6a3c890f7bbf 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/dma-map-ops.h> /* for dma_default_coherent */
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -623,17 +624,18 @@ u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 		dp->dscr_cmd0 &= ~DSCR_CMD0_IE;
 
 	/*
-	 * There is an errata on the Au1200/Au1550 parts that could result
-	 * in "stale" data being DMA'ed. It has to do with the snoop logic on
-	 * the cache eviction buffer.  DMA_NONCOHERENT is on by default for
-	 * these parts. If it is fixed in the future, these dma_cache_inv will
-	 * just be nothing more than empty macros. See io.h.
+	 * There is an erratum on certain Au1200/Au1550 revisions that could
+	 * result in "stale" data being DMA'ed. It has to do with the snoop
+	 * logic on the cache eviction buffer.  dma_default_coherent is set
+	 * to false on these parts.
 	 */
-	dma_cache_wback_inv((unsigned long)buf, nbytes);
+	if (!dma_default_coherent)
+		dma_cache_wback_inv(KSEG0ADDR(buf), nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
+	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
@@ -685,17 +687,18 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 			  dp->dscr_source1, dp->dscr_dest0, dp->dscr_dest1);
 #endif
 	/*
-	 * There is an errata on the Au1200/Au1550 parts that could result in
-	 * "stale" data being DMA'ed. It has to do with the snoop logic on the
-	 * cache eviction buffer.  DMA_NONCOHERENT is on by default for these
-	 * parts. If it is fixed in the future, these dma_cache_inv will just
-	 * be nothing more than empty macros. See io.h.
+	 * There is an erratum on certain Au1200/Au1550 revisions that could
+	 * result in "stale" data being DMA'ed. It has to do with the snoop
+	 * logic on the cache eviction buffer.  dma_default_coherent is set
+	 * to false on these parts.
 	 */
-	dma_cache_inv((unsigned long)buf, nbytes);
+	if (!dma_default_coherent)
+		dma_cache_inv(KSEG0ADDR(buf), nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
+	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 7ddf07f255f3..6f5d82595877 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1502,6 +1502,10 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		}
 		break;
+	case PRID_IMP_NETLOGIC_AU13XX:
+		c->cputype = CPU_ALCHEMY;
+		__cpu_name[cpu] = "Au1300";
+		break;
 	}
 }
 
@@ -1861,6 +1865,7 @@ void cpu_probe(void)
 		cpu_probe_mips(c, cpu);
 		break;
 	case PRID_COMP_ALCHEMY:
+	case PRID_COMP_NETLOGIC:
 		cpu_probe_alchemy(c, cpu);
 		break;
 	case PRID_COMP_SIBYTE:
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f1c88f8a1dc5..81dbb4ef5231 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -158,10 +158,6 @@ static unsigned long __init init_initrd(void)
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
-	if (initrd_start < PAGE_OFFSET) {
-		pr_err("initrd start < PAGE_OFFSET\n");
-		goto disable;
-	}
 
 	/*
 	 * Sanitize initrd addresses. For example firmware
@@ -174,6 +170,11 @@ static unsigned long __init init_initrd(void)
 	initrd_end = (unsigned long)__va(end);
 	initrd_start = (unsigned long)__va(__pa(initrd_start));
 
+	if (initrd_start < PAGE_OFFSET) {
+		pr_err("initrd start < PAGE_OFFSET\n");
+		goto disable;
+	}
+
 	ROOT_DEV = Root_RAM0;
 	return PFN_UP(end);
 disable:
diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
index eebabf9df6ac..c6f7a4b95997 100644
--- a/arch/mips/loongson2ef/Platform
+++ b/arch/mips/loongson2ef/Platform
@@ -25,7 +25,7 @@ cflags-$(CONFIG_CPU_LOONGSON2F) += -march=loongson2f
 # binutils does not merge support for the flag then we can revisit & remove
 # this later - for now it ensures vendor toolchains don't cause problems.
 #
-cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
 
 # Enable the workarounds for Loongson2f
 ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
diff --git a/arch/nios2/boot/dts/10m50_devboard.dts b/arch/nios2/boot/dts/10m50_devboard.dts
index 56339bef3247..0e7e5b0dd685 100644
--- a/arch/nios2/boot/dts/10m50_devboard.dts
+++ b/arch/nios2/boot/dts/10m50_devboard.dts
@@ -97,7 +97,7 @@ rgmii_0_eth_tse_0: ethernet@400 {
 			rx-fifo-depth = <8192>;
 			tx-fifo-depth = <8192>;
 			address-bits = <48>;
-			max-frame-size = <1518>;
+			max-frame-size = <1500>;
 			local-mac-address = [00 00 00 00 00 00];
 			altr,has-supplementary-unicast;
 			altr,enable-sup-addr = <1>;
diff --git a/arch/nios2/boot/dts/3c120_devboard.dts b/arch/nios2/boot/dts/3c120_devboard.dts
index d10fb81686c7..3ee316906379 100644
--- a/arch/nios2/boot/dts/3c120_devboard.dts
+++ b/arch/nios2/boot/dts/3c120_devboard.dts
@@ -106,7 +106,7 @@ tse_mac: ethernet@4000 {
 				interrupt-names = "rx_irq", "tx_irq";
 				rx-fifo-depth = <8192>;
 				tx-fifo-depth = <8192>;
-				max-frame-size = <1518>;
+				max-frame-size = <1500>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 				phy-mode = "rgmii-id";
 				phy-handle = <&phy0>;
diff --git a/arch/parisc/include/asm/assembly.h b/arch/parisc/include/asm/assembly.h
index 0f0d4a496fef..75677b526b2b 100644
--- a/arch/parisc/include/asm/assembly.h
+++ b/arch/parisc/include/asm/assembly.h
@@ -90,10 +90,6 @@
 #include <asm/asmregs.h>
 #include <asm/psw.h>
 
-	sp	=	30
-	gp	=	27
-	ipsw	=	22
-
 	/*
 	 * We provide two versions of each macro to convert from physical
 	 * to virtual and vice versa. The "_r1" versions take one argument
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ba87f791323b..71ed5391f29d 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -446,11 +446,27 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
+	/*
+	 * fdc: The data cache line is written back to memory, if and only if
+	 * it is dirty, and then invalidated from the data cache.
+	 */
 	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
+	unsigned long addr = (unsigned long) phys_to_virt(paddr);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		flush_kernel_dcache_range(addr, size);
+		return;
+	case DMA_FROM_DEVICE:
+		purge_kernel_dcache_range_asm(addr, addr + size);
+		return;
+	default:
+		BUG();
+	}
 }
diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
index a81d155b89ae..df50b155c767 100644
--- a/arch/powerpc/purgatory/Makefile
+++ b/arch/powerpc/purgatory/Makefile
@@ -4,6 +4,11 @@ KASAN_SANITIZE := n
 
 targets += trampoline_$(BITS).o purgatory.ro
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
 
 $(obj)/purgatory.ro: $(obj)/trampoline_$(BITS).o FORCE
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 659e21862077..6574c91c99b1 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -25,6 +25,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 CFLAGS_string.o := -D__DISABLE_EXPORTS
 CFLAGS_ctype.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3a261abb6d15..15b7b403a4bd 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -50,7 +50,7 @@ KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
-KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
+KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
 # sev.c indirectly inludes inat-table.h which is generated during
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d860d437631b..998cdb112b72 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -85,6 +85,15 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	startup_64_setup_env
 	popq	%rsi
 
+	/* Now switch to __KERNEL_CS so IRET works reliably */
+	pushq	$__KERNEL_CS
+	leaq	.Lon_kernel_cs(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lon_kernel_cs:
+	UNWIND_HINT_EMPTY
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
 	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
@@ -98,15 +107,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	popq	%rsi
 #endif
 
-	/* Now switch to __KERNEL_CS so IRET works reliably */
-	pushq	$__KERNEL_CS
-	leaq	.Lon_kernel_cs(%rip), %rax
-	pushq	%rax
-	lretq
-
-.Lon_kernel_cs:
-	UNWIND_HINT_EMPTY
-
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 82fec66d46d2..42abd6af1198 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,6 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 35b9bcad9db9..5ddf393aa390 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -780,7 +780,8 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		ring_req->u.rw.handle = info->handle;
 		ring_req->operation = rq_data_dir(req) ?
 			BLKIF_OP_WRITE : BLKIF_OP_READ;
-		if (req_op(req) == REQ_OP_FLUSH || req->cmd_flags & REQ_FUA) {
+		if (req_op(req) == REQ_OP_FLUSH ||
+		    (req_op(req) == REQ_OP_WRITE && (req->cmd_flags & REQ_FUA))) {
 			/*
 			 * Ideally we can do an unordered flush-to-disk.
 			 * In case the backend onlysupports barriers, use that.
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index d68d05d5d383..514f9f287a78 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -90,6 +90,9 @@ parisc_agp_tlbflush(struct agp_memory *mem)
 {
 	struct _parisc_agp_info *info = &parisc_agp_info;
 
+	/* force fdc ops to be visible to IOMMU */
+	asm_io_sync();
+
 	writeq(info->gart_base | ilog2(info->gart_size), info->ioc_regs+IOC_PCOM);
 	readq(info->ioc_regs+IOC_PCOM);	/* flush */
 }
@@ -158,6 +161,7 @@ parisc_agp_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 			info->gatt[j] =
 				parisc_agp_mask_memory(agp_bridge,
 					paddr, type);
+			asm_io_fdc(&info->gatt[j]);
 		}
 	}
 
@@ -191,7 +195,16 @@ static unsigned long
 parisc_agp_mask_memory(struct agp_bridge_data *bridge, dma_addr_t addr,
 		       int type)
 {
-	return SBA_PDIR_VALID_BIT | addr;
+	unsigned ci;			/* coherent index */
+	dma_addr_t pa;
+
+	pa = addr & IOVP_MASK;
+	asm("lci 0(%1), %0" : "=r" (ci) : "r" (phys_to_virt(pa)));
+
+	pa |= (ci >> PAGE_SHIFT) & 0xff;/* move CI (8 bits) into lowest byte */
+	pa |= SBA_PDIR_VALID_BIT;	/* set "valid" bit */
+
+	return cpu_to_le64(pa);
 }
 
 static void
diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 42958a542662..621e298f101a 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -164,7 +164,7 @@ void pxa3xx_clk_update_accr(u32 disable, u32 enable, u32 xclkcfg, u32 mask)
 	accr &= ~disable;
 	accr |= enable;
 
-	writel(accr, ACCR);
+	writel(accr, clk_regs + ACCR);
 	if (xclkcfg)
 		__asm__("mcr p14, 0, %0, c6, c0, 0\n" : : "r"(xclkcfg));
 
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 2c91ceff8a9c..518092d7eaf7 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -21,30 +21,9 @@
 #define TRP_SYN_REG_CNT                 6
 #define DRP_SYN_REG_CNT                 8
 
-#define LLCC_COMMON_STATUS0             0x0003000c
 #define LLCC_LB_CNT_MASK                GENMASK(31, 28)
 #define LLCC_LB_CNT_SHIFT               28
 
-/* Single & double bit syndrome register offsets */
-#define TRP_ECC_SB_ERR_SYN0             0x0002304c
-#define TRP_ECC_DB_ERR_SYN0             0x00020370
-#define DRP_ECC_SB_ERR_SYN0             0x0004204c
-#define DRP_ECC_DB_ERR_SYN0             0x00042070
-
-/* Error register offsets */
-#define TRP_ECC_ERROR_STATUS1           0x00020348
-#define TRP_ECC_ERROR_STATUS0           0x00020344
-#define DRP_ECC_ERROR_STATUS1           0x00042048
-#define DRP_ECC_ERROR_STATUS0           0x00042044
-
-/* TRP, DRP interrupt register offsets */
-#define DRP_INTERRUPT_STATUS            0x00041000
-#define TRP_INTERRUPT_0_STATUS          0x00020480
-#define DRP_INTERRUPT_CLEAR             0x00041008
-#define DRP_ECC_ERROR_CNTR_CLEAR        0x00040004
-#define TRP_INTERRUPT_0_CLEAR           0x00020484
-#define TRP_ECC_ERROR_CNTR_CLEAR        0x00020440
-
 /* Mask and shift macros */
 #define ECC_DB_ERR_COUNT_MASK           GENMASK(4, 0)
 #define ECC_DB_ERR_WAYS_MASK            GENMASK(31, 16)
@@ -60,15 +39,6 @@
 #define DRP_TRP_INT_CLEAR               GENMASK(1, 0)
 #define DRP_TRP_CNT_CLEAR               GENMASK(1, 0)
 
-/* Config registers offsets*/
-#define DRP_ECC_ERROR_CFG               0x00040000
-
-/* Tag RAM, Data RAM interrupt register offsets */
-#define CMN_INTERRUPT_0_ENABLE          0x0003001c
-#define CMN_INTERRUPT_2_ENABLE          0x0003003c
-#define TRP_INTERRUPT_0_ENABLE          0x00020488
-#define DRP_INTERRUPT_ENABLE            0x0004100c
-
 #define SB_ERROR_THRESHOLD              0x1
 #define SB_ERROR_THRESHOLD_SHIFT        24
 #define SB_DB_TRP_INTERRUPT_ENABLE      0x3
@@ -88,9 +58,6 @@ enum {
 static const struct llcc_edac_reg_data edac_reg_data[] = {
 	[LLCC_DRAM_CE] = {
 		.name = "DRAM Single-bit",
-		.synd_reg = DRP_ECC_SB_ERR_SYN0,
-		.count_status_reg = DRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
 		.reg_cnt = DRP_SYN_REG_CNT,
 		.count_mask = ECC_SB_ERR_COUNT_MASK,
 		.ways_mask = ECC_SB_ERR_WAYS_MASK,
@@ -98,9 +65,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_DRAM_UE] = {
 		.name = "DRAM Double-bit",
-		.synd_reg = DRP_ECC_DB_ERR_SYN0,
-		.count_status_reg = DRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
 		.reg_cnt = DRP_SYN_REG_CNT,
 		.count_mask = ECC_DB_ERR_COUNT_MASK,
 		.ways_mask = ECC_DB_ERR_WAYS_MASK,
@@ -108,9 +72,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_TRAM_CE] = {
 		.name = "TRAM Single-bit",
-		.synd_reg = TRP_ECC_SB_ERR_SYN0,
-		.count_status_reg = TRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
 		.reg_cnt = TRP_SYN_REG_CNT,
 		.count_mask = ECC_SB_ERR_COUNT_MASK,
 		.ways_mask = ECC_SB_ERR_WAYS_MASK,
@@ -118,9 +79,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_TRAM_UE] = {
 		.name = "TRAM Double-bit",
-		.synd_reg = TRP_ECC_DB_ERR_SYN0,
-		.count_status_reg = TRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
 		.reg_cnt = TRP_SYN_REG_CNT,
 		.count_mask = ECC_DB_ERR_COUNT_MASK,
 		.ways_mask = ECC_DB_ERR_WAYS_MASK,
@@ -128,7 +86,7 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 };
 
-static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
+static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_bcast_regmap)
 {
 	u32 sb_err_threshold;
 	int ret;
@@ -137,31 +95,31 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
 	 * Configure interrupt enable registers such that Tag, Data RAM related
 	 * interrupts are propagated to interrupt controller for servicing
 	 */
-	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
 				 TRP0_INTERRUPT_ENABLE,
 				 TRP0_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, TRP_INTERRUPT_0_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->trp_interrupt_0_enable,
 				 SB_DB_TRP_INTERRUPT_ENABLE,
 				 SB_DB_TRP_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
 	sb_err_threshold = (SB_ERROR_THRESHOLD << SB_ERROR_THRESHOLD_SHIFT);
-	ret = regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
+	ret = regmap_write(llcc_bcast_regmap, drv->edac_reg_offset->drp_ecc_error_cfg,
 			   sb_err_threshold);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
 				 DRP0_INTERRUPT_ENABLE,
 				 DRP0_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
-	ret = regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
+	ret = regmap_write(llcc_bcast_regmap, drv->edac_reg_offset->drp_interrupt_enable,
 			   SB_DB_DRP_INTERRUPT_ENABLE);
 	return ret;
 }
@@ -175,24 +133,28 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 	switch (err_type) {
 	case LLCC_DRAM_CE:
 	case LLCC_DRAM_UE:
-		ret = regmap_write(drv->bcast_regmap, DRP_INTERRUPT_CLEAR,
+		ret = regmap_write(drv->bcast_regmap,
+				   drv->edac_reg_offset->drp_interrupt_clear,
 				   DRP_TRP_INT_CLEAR);
 		if (ret)
 			return ret;
 
-		ret = regmap_write(drv->bcast_regmap, DRP_ECC_ERROR_CNTR_CLEAR,
+		ret = regmap_write(drv->bcast_regmap,
+				   drv->edac_reg_offset->drp_ecc_error_cntr_clear,
 				   DRP_TRP_CNT_CLEAR);
 		if (ret)
 			return ret;
 		break;
 	case LLCC_TRAM_CE:
 	case LLCC_TRAM_UE:
-		ret = regmap_write(drv->bcast_regmap, TRP_INTERRUPT_0_CLEAR,
+		ret = regmap_write(drv->bcast_regmap,
+				   drv->edac_reg_offset->trp_interrupt_0_clear,
 				   DRP_TRP_INT_CLEAR);
 		if (ret)
 			return ret;
 
-		ret = regmap_write(drv->bcast_regmap, TRP_ECC_ERROR_CNTR_CLEAR,
+		ret = regmap_write(drv->bcast_regmap,
+				   drv->edac_reg_offset->trp_ecc_error_cntr_clear,
 				   DRP_TRP_CNT_CLEAR);
 		if (ret)
 			return ret;
@@ -205,17 +167,55 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 	return ret;
 }
 
+struct qcom_llcc_syn_regs {
+	u32 synd_reg;
+	u32 count_status_reg;
+	u32 ways_status_reg;
+};
+
+static void get_reg_offsets(struct llcc_drv_data *drv, int err_type,
+			    struct qcom_llcc_syn_regs *syn_regs)
+{
+	const struct llcc_edac_reg_offset *edac_reg_offset = drv->edac_reg_offset;
+
+	switch (err_type) {
+	case LLCC_DRAM_CE:
+		syn_regs->synd_reg = edac_reg_offset->drp_ecc_sb_err_syn0;
+		syn_regs->count_status_reg = edac_reg_offset->drp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg_offset->drp_ecc_error_status0;
+		break;
+	case LLCC_DRAM_UE:
+		syn_regs->synd_reg = edac_reg_offset->drp_ecc_db_err_syn0;
+		syn_regs->count_status_reg = edac_reg_offset->drp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg_offset->drp_ecc_error_status0;
+		break;
+	case LLCC_TRAM_CE:
+		syn_regs->synd_reg = edac_reg_offset->trp_ecc_sb_err_syn0;
+		syn_regs->count_status_reg = edac_reg_offset->trp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg_offset->trp_ecc_error_status0;
+		break;
+	case LLCC_TRAM_UE:
+		syn_regs->synd_reg = edac_reg_offset->trp_ecc_db_err_syn0;
+		syn_regs->count_status_reg = edac_reg_offset->trp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg_offset->trp_ecc_error_status0;
+		break;
+	}
+}
+
 /* Dump Syndrome registers data for Tag RAM, Data RAM bit errors*/
 static int
 dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 {
 	struct llcc_edac_reg_data reg_data = edac_reg_data[err_type];
+	struct qcom_llcc_syn_regs regs = { };
 	int err_cnt, err_ways, ret, i;
 	u32 synd_reg, synd_val;
 
+	get_reg_offsets(drv, err_type, &regs);
+
 	for (i = 0; i < reg_data.reg_cnt; i++) {
-		synd_reg = reg_data.synd_reg + (i * 4);
-		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
+		synd_reg = regs.synd_reg + (i * 4);
+		ret = regmap_read(drv->regmaps[bank], synd_reg,
 				  &synd_val);
 		if (ret)
 			goto clear;
@@ -224,8 +224,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 			    reg_data.name, i, synd_val);
 	}
 
-	ret = regmap_read(drv->regmap,
-			  drv->offsets[bank] + reg_data.count_status_reg,
+	ret = regmap_read(drv->regmaps[bank], regs.count_status_reg,
 			  &err_cnt);
 	if (ret)
 		goto clear;
@@ -235,8 +234,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: Error count: 0x%4x\n",
 		    reg_data.name, err_cnt);
 
-	ret = regmap_read(drv->regmap,
-			  drv->offsets[bank] + reg_data.ways_status_reg,
+	ret = regmap_read(drv->regmaps[bank], regs.ways_status_reg,
 			  &err_ways);
 	if (ret)
 		goto clear;
@@ -297,8 +295,7 @@ static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 
 	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
 	for (i = 0; i < drv->num_banks; i++) {
-		ret = regmap_read(drv->regmap,
-				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
+		ret = regmap_read(drv->regmaps[i], drv->edac_reg_offset->drp_interrupt_status,
 				  &drp_error);
 
 		if (!ret && (drp_error & SB_ECC_ERROR)) {
@@ -313,8 +310,7 @@ static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 		if (!ret)
 			irq_rc = IRQ_HANDLED;
 
-		ret = regmap_read(drv->regmap,
-				  drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
+		ret = regmap_read(drv->regmaps[i], drv->edac_reg_offset->trp_interrupt_0_status,
 				  &trp_error);
 
 		if (!ret && (trp_error & SB_ECC_ERROR)) {
@@ -346,7 +342,7 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	int ecc_irq;
 	int rc;
 
-	rc = qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
+	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
 	if (rc)
 		return rc;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 1a06b8d724f3..dd6f9ae6fbe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1214,7 +1214,6 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 
 const struct drm_mode_config_funcs amdgpu_mode_funcs = {
 	.fb_create = amdgpu_display_user_framebuffer_create,
-	.output_poll_changed = drm_fb_helper_output_poll_changed,
 };
 
 static const struct drm_prop_enum_list amdgpu_underscan_enum_list[] =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 88a9ece7f464..49a023f59b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1605,6 +1605,7 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
 	0x5874,
 	0x5940,
 	0x5941,
+	0x5b70,
 	0x5b72,
 	0x5b73,
 	0x5b74,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3b8825a3e233..a3cd816f98a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3550,6 +3550,9 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	void *fw_pri_cpu_addr;
 	int ret;
 
+	if (adev->psp.vbflash_image_size == 0)
+		return -EINVAL;
+
 	dev_info(adev->dev, "VBIOS flash to PSP started");
 
 	ret = amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
@@ -3601,13 +3604,13 @@ static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
 }
 
 static const struct bin_attribute psp_vbflash_bin_attr = {
-	.attr = {.name = "psp_vbflash", .mode = 0664},
+	.attr = {.name = "psp_vbflash", .mode = 0660},
 	.size = 0,
 	.write = amdgpu_psp_vbflash_write,
 	.read = amdgpu_psp_vbflash_read,
 };
 
-static DEVICE_ATTR(psp_vbflash_status, 0444, amdgpu_psp_vbflash_status, NULL);
+static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
 
 int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2127aab74a68..84a36b50ddd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6969,8 +6969,10 @@ static int gfx_v10_0_kiq_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v10_0_kiq_init_queue(ring);
 	amdgpu_bo_kunmap(ring->mqd_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1f3fdf6cb903..fe371022e510 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3650,8 +3650,10 @@ static int gfx_v9_0_kiq_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v9_0_kiq_init_queue(ring);
 	amdgpu_bo_kunmap(ring->mqd_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index dcc49b01bd59..300bb926dcba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -117,7 +117,11 @@ static int vcn_v4_0_sw_init(void *handle)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		atomic_set(&adev->vcn.inst[i].sched_score, 0);
+		/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
+		if (i == 0)
+			atomic_set(&adev->vcn.inst[i].sched_score, 1);
+		else
+			atomic_set(&adev->vcn.inst[i].sched_score, 0);
 
 		/* VCN UNIFIED TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8ab0dd799b3c..53687de6c053 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -83,7 +83,6 @@
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_vblank.h>
@@ -2875,7 +2874,6 @@ const struct amdgpu_ip_block_version dm_ip_block =
 static const struct drm_mode_config_funcs amdgpu_dm_mode_funcs = {
 	.fb_create = amdgpu_display_user_framebuffer_create,
 	.get_format_info = amd_get_format_info,
-	.output_poll_changed = drm_fb_helper_output_poll_changed,
 	.atomic_check = amdgpu_dm_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
@@ -6942,7 +6940,13 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 640, 480);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		/* most eDP supports only timings from its edid,
+		 * usually only detailed timings are available
+		 * from eDP edid. timings which are not from edid
+		 * may damage eDP
+		 */
+		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
+			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 508e392547d7..54fc42dad775 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1675,10 +1675,39 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
+		(((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xC8)) ||
+		((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xCC)))) {
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_COMPUTE_BIT,
+					   (void *)(&activity_monitor_external),
+					   false);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			return ret;
+		}
+
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_CUSTOM_BIT,
+					   (void *)(&activity_monitor_external),
+					   true);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			return ret;
+		}
+
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       PP_SMC_POWER_PROFILE_CUSTOM);
+	} else {
+		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       smu->power_profile_mode);
+	}
+
 	if (workload_type < 0)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index aeca9c066bf2..d16775c973c4 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -298,6 +298,10 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
 		if (refclk_lut[i] == refclk_rate)
 			break;
 
+	/* avoid buffer overflow and "1" is the default rate in the datasheet. */
+	if (i >= refclk_lut_size)
+		i = 1;
+
 	regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
 			   REFCLK_FREQ(i));
 
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index b1a38e6ce2f8..0cb646cb04ee 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -179,7 +179,7 @@ static const struct dmi_system_id orientation_data[] = {
 	}, {	/* AYA NEO AIR */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_MATCH(DMI_BOARD_NAME, "AIR"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYA NEO NEXT */
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 8cf096f841a9..a2ae8c21e4dc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -220,6 +220,9 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 	int optimus_funcs;
 	struct pci_dev *parent_pdev;
 
+	if (pdev->vendor != PCI_VENDOR_ID_NVIDIA)
+		return;
+
 	*has_pr3 = false;
 	parent_pdev = pci_upstream_bridge(pdev);
 	if (parent_pdev) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 1991bbb1d05c..f40310559d13 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -730,7 +730,8 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 #endif
 
 	nouveau_connector_set_edid(nv_connector, edid);
-	nouveau_connector_set_encoder(connector, nv_encoder);
+	if (nv_encoder)
+		nouveau_connector_set_encoder(connector, nv_encoder);
 	return status;
 }
 
@@ -966,7 +967,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	/* Determine display colour depth for everything except LVDS now,
 	 * DP requires this before mode_valid() is called.
 	 */
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
 		nouveau_connector_detect_depth(connector);
 
 	/* Find the native mode if this is a digital panel, if we didn't
@@ -987,7 +988,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	 * "native" mode as some VBIOS tables require us to use the
 	 * pixel clock as part of the lookup...
 	 */
-	if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)
+	if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
 		nouveau_connector_detect_depth(connector);
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_TV)
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index fd99ec0f4257..28062d682f43 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -139,10 +139,16 @@ nouveau_name(struct drm_device *dev)
 static inline bool
 nouveau_cli_work_ready(struct dma_fence *fence)
 {
-	if (!dma_fence_is_signaled(fence))
-		return false;
-	dma_fence_put(fence);
-	return true;
+	bool ret = true;
+
+	spin_lock_irq(fence->lock);
+	if (!dma_fence_is_signaled_locked(fence))
+		ret = false;
+	spin_unlock_irq(fence->lock);
+
+	if (ret == true)
+		dma_fence_put(fence);
+	return ret;
 }
 
 static void
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c6a671edba5c..4632b1833381 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3293,7 +3293,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	route->path_rec->traffic_class = tos;
 	route->path_rec->mtu = iboe_get_mtu(ndev->mtu);
 	route->path_rec->rate_selector = IB_SA_EQ;
-	route->path_rec->rate = iboe_get_rate(ndev);
+	route->path_rec->rate = IB_RATE_PORT_CURRENT;
 	dev_put(ndev);
 	route->path_rec->packet_life_time_selector = IB_SA_EQ;
 	/* In case ACK timeout is set, use this value to calculate
@@ -4955,7 +4955,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	if (!ndev)
 		return -ENODEV;
 
-	ib.rec.rate = iboe_get_rate(ndev);
+	ib.rec.rate = IB_RATE_PORT_CURRENT;
 	ib.rec.hop_limit = 1;
 	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4796f6a8828c..e836c9c477f6 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1850,8 +1850,13 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		attr->path_mtu = cmd->base.path_mtu;
 	if (cmd->base.attr_mask & IB_QP_PATH_MIG_STATE)
 		attr->path_mig_state = cmd->base.path_mig_state;
-	if (cmd->base.attr_mask & IB_QP_QKEY)
+	if (cmd->base.attr_mask & IB_QP_QKEY) {
+		if (cmd->base.qkey & IB_QP_SET_QKEY && !capable(CAP_NET_RAW)) {
+			ret = -EPERM;
+			goto release_qp;
+		}
 		attr->qkey = cmd->base.qkey;
+	}
 	if (cmd->base.attr_mask & IB_QP_RQ_PSN)
 		attr->rq_psn = cmd->base.rq_psn;
 	if (cmd->base.attr_mask & IB_QP_SQ_PSN)
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index d54434088727..fa937cd26821 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -222,8 +222,12 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 	spin_lock_irq(&ev_queue->lock);
 
 	while (list_empty(&ev_queue->event_list)) {
-		spin_unlock_irq(&ev_queue->lock);
+		if (ev_queue->is_closed) {
+			spin_unlock_irq(&ev_queue->lock);
+			return -EIO;
+		}
 
+		spin_unlock_irq(&ev_queue->lock);
 		if (filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
@@ -233,12 +237,6 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 			return -ERESTARTSYS;
 
 		spin_lock_irq(&ev_queue->lock);
-
-		/* If device was disassociated and no event exists set an error */
-		if (list_empty(&ev_queue->event_list) && ev_queue->is_closed) {
-			spin_unlock_irq(&ev_queue->lock);
-			return -EIO;
-		}
 	}
 
 	event = list_entry(ev_queue->event_list.next, struct ib_uverbs_event, list);
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 490ec308e309..5a13d902b064 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -696,8 +696,6 @@ static struct mlx5_ib_flow_prio *_get_prio(struct mlx5_ib_dev *dev,
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_table *ft;
 
-	if (mlx5_ib_shared_ft_allowed(&dev->ib_dev))
-		ft_attr.uid = MLX5_SHARED_RESOURCE_UID;
 	ft_attr.prio = priority;
 	ft_attr.max_fte = num_entries;
 	ft_attr.flags = flags;
@@ -2026,6 +2024,237 @@ static int flow_matcher_cleanup(struct ib_uobject *uobject,
 	return 0;
 }
 
+static int steering_anchor_create_ft(struct mlx5_ib_dev *dev,
+				     struct mlx5_ib_flow_prio *ft_prio,
+				     enum mlx5_flow_namespace_type ns_type)
+{
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_table *ft;
+
+	if (ft_prio->anchor.ft)
+		return 0;
+
+	ns = mlx5_get_flow_namespace(dev->mdev, ns_type);
+	if (!ns)
+		return -EOPNOTSUPP;
+
+	ft_attr.flags = MLX5_FLOW_TABLE_UNMANAGED;
+	ft_attr.uid = MLX5_SHARED_RESOURCE_UID;
+	ft_attr.prio = 0;
+	ft_attr.max_fte = 2;
+	ft_attr.level = 1;
+
+	ft = mlx5_create_flow_table(ns, &ft_attr);
+	if (IS_ERR(ft))
+		return PTR_ERR(ft);
+
+	ft_prio->anchor.ft = ft;
+
+	return 0;
+}
+
+static void steering_anchor_destroy_ft(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.ft) {
+		mlx5_destroy_flow_table(ft_prio->anchor.ft);
+		ft_prio->anchor.ft = NULL;
+	}
+}
+
+static int
+steering_anchor_create_fg_drop(struct mlx5_ib_flow_prio *ft_prio)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_group *fg;
+	void *flow_group_in;
+	int err = 0;
+
+	if (ft_prio->anchor.fg_drop)
+		return 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, 1);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, 1);
+
+	fg = mlx5_create_flow_group(ft_prio->anchor.ft, flow_group_in);
+	if (IS_ERR(fg)) {
+		err = PTR_ERR(fg);
+		goto out;
+	}
+
+	ft_prio->anchor.fg_drop = fg;
+
+out:
+	kvfree(flow_group_in);
+
+	return err;
+}
+
+static void
+steering_anchor_destroy_fg_drop(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.fg_drop) {
+		mlx5_destroy_flow_group(ft_prio->anchor.fg_drop);
+		ft_prio->anchor.fg_drop = NULL;
+	}
+}
+
+static int
+steering_anchor_create_fg_goto_table(struct mlx5_ib_flow_prio *ft_prio)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_group *fg;
+	void *flow_group_in;
+	int err = 0;
+
+	if (ft_prio->anchor.fg_goto_table)
+		return 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	fg = mlx5_create_flow_group(ft_prio->anchor.ft, flow_group_in);
+	if (IS_ERR(fg)) {
+		err = PTR_ERR(fg);
+		goto out;
+	}
+	ft_prio->anchor.fg_goto_table = fg;
+
+out:
+	kvfree(flow_group_in);
+
+	return err;
+}
+
+static void
+steering_anchor_destroy_fg_goto_table(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.fg_goto_table) {
+		mlx5_destroy_flow_group(ft_prio->anchor.fg_goto_table);
+		ft_prio->anchor.fg_goto_table = NULL;
+	}
+}
+
+static int
+steering_anchor_create_rule_drop(struct mlx5_ib_flow_prio *ft_prio)
+{
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *handle;
+
+	if (ft_prio->anchor.rule_drop)
+		return 0;
+
+	flow_act.fg = ft_prio->anchor.fg_drop;
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP;
+
+	handle = mlx5_add_flow_rules(ft_prio->anchor.ft, NULL, &flow_act,
+				     NULL, 0);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ft_prio->anchor.rule_drop = handle;
+
+	return 0;
+}
+
+static void steering_anchor_destroy_rule_drop(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.rule_drop) {
+		mlx5_del_flow_rules(ft_prio->anchor.rule_drop);
+		ft_prio->anchor.rule_drop = NULL;
+	}
+}
+
+static int
+steering_anchor_create_rule_goto_table(struct mlx5_ib_flow_prio *ft_prio)
+{
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *handle;
+
+	if (ft_prio->anchor.rule_goto_table)
+		return 0;
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	flow_act.flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
+	flow_act.fg = ft_prio->anchor.fg_goto_table;
+
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = ft_prio->flow_table;
+
+	handle = mlx5_add_flow_rules(ft_prio->anchor.ft, NULL, &flow_act,
+				     &dest, 1);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ft_prio->anchor.rule_goto_table = handle;
+
+	return 0;
+}
+
+static void
+steering_anchor_destroy_rule_goto_table(struct mlx5_ib_flow_prio *ft_prio)
+{
+	if (ft_prio->anchor.rule_goto_table) {
+		mlx5_del_flow_rules(ft_prio->anchor.rule_goto_table);
+		ft_prio->anchor.rule_goto_table = NULL;
+	}
+}
+
+static int steering_anchor_create_res(struct mlx5_ib_dev *dev,
+				      struct mlx5_ib_flow_prio *ft_prio,
+				      enum mlx5_flow_namespace_type ns_type)
+{
+	int err;
+
+	err = steering_anchor_create_ft(dev, ft_prio, ns_type);
+	if (err)
+		return err;
+
+	err = steering_anchor_create_fg_drop(ft_prio);
+	if (err)
+		goto destroy_ft;
+
+	err = steering_anchor_create_fg_goto_table(ft_prio);
+	if (err)
+		goto destroy_fg_drop;
+
+	err = steering_anchor_create_rule_drop(ft_prio);
+	if (err)
+		goto destroy_fg_goto_table;
+
+	err = steering_anchor_create_rule_goto_table(ft_prio);
+	if (err)
+		goto destroy_rule_drop;
+
+	return 0;
+
+destroy_rule_drop:
+	steering_anchor_destroy_rule_drop(ft_prio);
+destroy_fg_goto_table:
+	steering_anchor_destroy_fg_goto_table(ft_prio);
+destroy_fg_drop:
+	steering_anchor_destroy_fg_drop(ft_prio);
+destroy_ft:
+	steering_anchor_destroy_ft(ft_prio);
+
+	return err;
+}
+
+static void mlx5_steering_anchor_destroy_res(struct mlx5_ib_flow_prio *ft_prio)
+{
+	steering_anchor_destroy_rule_goto_table(ft_prio);
+	steering_anchor_destroy_rule_drop(ft_prio);
+	steering_anchor_destroy_fg_goto_table(ft_prio);
+	steering_anchor_destroy_fg_drop(ft_prio);
+	steering_anchor_destroy_ft(ft_prio);
+}
+
 static int steering_anchor_cleanup(struct ib_uobject *uobject,
 				   enum rdma_remove_reason why,
 				   struct uverbs_attr_bundle *attrs)
@@ -2036,6 +2265,9 @@ static int steering_anchor_cleanup(struct ib_uobject *uobject,
 		return -EBUSY;
 
 	mutex_lock(&obj->dev->flow_db->lock);
+	if (!--obj->ft_prio->anchor.rule_goto_table_ref)
+		steering_anchor_destroy_rule_goto_table(obj->ft_prio);
+
 	put_flow_table(obj->dev, obj->ft_prio, true);
 	mutex_unlock(&obj->dev->flow_db->lock);
 
@@ -2043,6 +2275,24 @@ static int steering_anchor_cleanup(struct ib_uobject *uobject,
 	return 0;
 }
 
+static void fs_cleanup_anchor(struct mlx5_ib_flow_prio *prio,
+			      int count)
+{
+	while (count--)
+		mlx5_steering_anchor_destroy_res(&prio[count]);
+}
+
+void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev)
+{
+	fs_cleanup_anchor(dev->flow_db->prios, MLX5_IB_NUM_FLOW_FT);
+	fs_cleanup_anchor(dev->flow_db->egress_prios, MLX5_IB_NUM_FLOW_FT);
+	fs_cleanup_anchor(dev->flow_db->sniffer, MLX5_IB_NUM_SNIFFER_FTS);
+	fs_cleanup_anchor(dev->flow_db->egress, MLX5_IB_NUM_EGRESS_FTS);
+	fs_cleanup_anchor(dev->flow_db->fdb, MLX5_IB_NUM_FDB_FTS);
+	fs_cleanup_anchor(dev->flow_db->rdma_rx, MLX5_IB_NUM_FLOW_FT);
+	fs_cleanup_anchor(dev->flow_db->rdma_tx, MLX5_IB_NUM_FLOW_FT);
+}
+
 static int mlx5_ib_matcher_ns(struct uverbs_attr_bundle *attrs,
 			      struct mlx5_ib_flow_matcher *obj)
 {
@@ -2183,21 +2433,31 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 		return -ENOMEM;
 
 	mutex_lock(&dev->flow_db->lock);
+
 	ft_prio = _get_flow_table(dev, priority, ns_type, 0);
 	if (IS_ERR(ft_prio)) {
-		mutex_unlock(&dev->flow_db->lock);
 		err = PTR_ERR(ft_prio);
 		goto free_obj;
 	}
 
 	ft_prio->refcount++;
-	ft_id = mlx5_flow_table_id(ft_prio->flow_table);
-	mutex_unlock(&dev->flow_db->lock);
+
+	if (!ft_prio->anchor.rule_goto_table_ref) {
+		err = steering_anchor_create_res(dev, ft_prio, ns_type);
+		if (err)
+			goto put_flow_table;
+	}
+
+	ft_prio->anchor.rule_goto_table_ref++;
+
+	ft_id = mlx5_flow_table_id(ft_prio->anchor.ft);
 
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_STEERING_ANCHOR_FT_ID,
 			     &ft_id, sizeof(ft_id));
 	if (err)
-		goto put_flow_table;
+		goto destroy_res;
+
+	mutex_unlock(&dev->flow_db->lock);
 
 	uobj->object = obj;
 	obj->dev = dev;
@@ -2206,8 +2466,10 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 
 	return 0;
 
+destroy_res:
+	--ft_prio->anchor.rule_goto_table_ref;
+	mlx5_steering_anchor_destroy_res(ft_prio);
 put_flow_table:
-	mutex_lock(&dev->flow_db->lock);
 	put_flow_table(dev, ft_prio, true);
 	mutex_unlock(&dev->flow_db->lock);
 free_obj:
diff --git a/drivers/infiniband/hw/mlx5/fs.h b/drivers/infiniband/hw/mlx5/fs.h
index ad320adaf321..b9734904f5f0 100644
--- a/drivers/infiniband/hw/mlx5/fs.h
+++ b/drivers/infiniband/hw/mlx5/fs.h
@@ -10,6 +10,7 @@
 
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int mlx5_ib_fs_init(struct mlx5_ib_dev *dev);
+void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev);
 #else
 static inline int mlx5_ib_fs_init(struct mlx5_ib_dev *dev)
 {
@@ -21,9 +22,24 @@ static inline int mlx5_ib_fs_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->flow_db->lock);
 	return 0;
 }
+
+inline void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev) {}
 #endif
+
 static inline void mlx5_ib_fs_cleanup(struct mlx5_ib_dev *dev)
 {
+	/* When a steering anchor is created, a special flow table is also
+	 * created for the user to reference. Since the user can reference it,
+	 * the kernel cannot trust that when the user destroys the steering
+	 * anchor, they no longer reference the flow table.
+	 *
+	 * To address this issue, when a user destroys a steering anchor, only
+	 * the flow steering rule in the table is destroyed, but the table
+	 * itself is kept to deal with the above scenario. The remaining
+	 * resources are only removed when the RDMA device is destroyed, which
+	 * is a safe assumption that all references are gone.
+	 */
+	mlx5_ib_fs_cleanup_anchor(dev);
 	kfree(dev->flow_db);
 }
 #endif /* _MLX5_IB_FS_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index eaa35e1df2a8..3178df55c4d8 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4250,6 +4250,9 @@ const struct mlx5_ib_profile raw_eth_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
 		     mlx5_ib_stage_post_ib_reg_umr_init,
 		     NULL),
+	STAGE_CREATE(MLX5_IB_STAGE_DELAY_DROP,
+		     mlx5_ib_stage_delay_drop_init,
+		     mlx5_ib_stage_delay_drop_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_RESTRACK,
 		     mlx5_ib_restrack_init,
 		     NULL),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4a7f7064bd0e..8d94e6834e01 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -233,8 +233,19 @@ enum {
 #define MLX5_IB_NUM_SNIFFER_FTS		2
 #define MLX5_IB_NUM_EGRESS_FTS		1
 #define MLX5_IB_NUM_FDB_FTS		MLX5_BY_PASS_NUM_REGULAR_PRIOS
+
+struct mlx5_ib_anchor {
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *fg_goto_table;
+	struct mlx5_flow_group *fg_drop;
+	struct mlx5_flow_handle *rule_goto_table;
+	struct mlx5_flow_handle *rule_drop;
+	unsigned int rule_goto_table_ref;
+};
+
 struct mlx5_ib_flow_prio {
 	struct mlx5_flow_table		*flow_table;
+	struct mlx5_ib_anchor		anchor;
 	unsigned int			refcount;
 };
 
@@ -1553,6 +1564,9 @@ static inline bool mlx5_ib_lag_should_assign_affinity(struct mlx5_ib_dev *dev)
 	    MLX5_CAP_PORT_SELECTION(dev->mdev, port_select_flow_table_bypass))
 		return 0;
 
+	if (mlx5_lag_is_lacp_owner(dev->mdev) && !dev->lag_active)
+		return 0;
+
 	return dev->lag_active ||
 		(MLX5_CAP_GEN(dev->mdev, num_lag_ports) > 1 &&
 		 MLX5_CAP_GEN(dev->mdev, lag_tx_port_affinity));
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index f7d3643b08f5..ac53ed79ca64 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1156,6 +1156,9 @@ static int create_raw_packet_qp_tis(struct mlx5_ib_dev *dev,
 
 	MLX5_SET(create_tis_in, in, uid, to_mpd(pd)->uid);
 	MLX5_SET(tisc, tisc, transport_domain, tdn);
+	if (!mlx5_ib_lag_should_assign_affinity(dev) &&
+	    mlx5_lag_is_lacp_owner(dev->mdev))
+		MLX5_SET(tisc, tisc, strict_lag_tx_port_affinity, 1);
 	if (qp->flags & IB_QP_CREATE_SOURCE_QPN)
 		MLX5_SET(tisc, tisc, underlay_qpn, qp->underlay_qpn);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 35f327b9d4b8..65d16024b3bf 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -156,6 +156,9 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	pkt->mask = RXE_GRH_MASK;
 	pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
 
+	/* remove udp header */
+	skb_pull(skb, sizeof(struct udphdr));
+
 	rxe_rcv(skb);
 
 	return 0;
@@ -397,6 +400,9 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 		return -EIO;
 	}
 
+	/* remove udp header */
+	skb_pull(skb, sizeof(struct udphdr));
+
 	rxe_rcv(skb);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 1f6e006c51c4..59b2024b34ef 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -180,6 +180,9 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
 
+	skb_queue_head_init(&qp->req_pkts);
+	skb_queue_head_init(&qp->resp_pkts);
+
 	atomic_set(&qp->ssn, 0);
 	atomic_set(&qp->skb_out, 0);
 }
@@ -240,12 +243,8 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
-	skb_queue_head_init(&qp->req_pkts);
-
-	rxe_init_task(&qp->req.task, qp,
-		      rxe_requester, "req");
-	rxe_init_task(&qp->comp.task, qp,
-		      rxe_completer, "comp");
+	rxe_init_task(&qp->req.task, qp, rxe_requester);
+	rxe_init_task(&qp->comp.task, qp, rxe_completer);
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
 	if (init->qp_type == IB_QPT_RC) {
@@ -290,10 +289,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	skb_queue_head_init(&qp->resp_pkts);
-
-	rxe_init_task(&qp->resp.task, qp,
-		      rxe_responder, "resp");
+	rxe_init_task(&qp->resp.task, qp, rxe_responder);
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 693081e813ec..9f65c346d843 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -466,8 +466,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		if (mw->access & IB_ZERO_BASED)
 			qp->resp.offset = mw->addr;
 
-		rxe_put(mw);
 		rxe_get(mr);
+		rxe_put(mw);
+		mw = NULL;
 	} else {
 		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index ec2b7de1c497..182d0532a8ab 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -94,12 +94,10 @@ void rxe_do_task(struct tasklet_struct *t)
 	task->ret = ret;
 }
 
-int rxe_init_task(struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name)
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
 {
 	task->arg	= arg;
 	task->func	= func;
-	snprintf(task->name, sizeof(task->name), "%s", name);
 	task->destroyed	= false;
 
 	tasklet_setup(&task->tasklet, rxe_do_task);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 7f612a1c68a7..b3dfd970d1dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -25,7 +25,6 @@ struct rxe_task {
 	void			*arg;
 	int			(*func)(void *arg);
 	int			ret;
-	char			name[16];
 	bool			destroyed;
 };
 
@@ -34,8 +33,7 @@ struct rxe_task {
  *	arg  => parameter to pass to fcn
  *	func => function to call until it returns != 0
  */
-int rxe_init_task(struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name);
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 7cca171478a2..a7fef3ea77fe 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -657,9 +657,13 @@ static int
 isert_connect_error(struct rdma_cm_id *cma_id)
 {
 	struct isert_conn *isert_conn = cma_id->qp->qp_context;
+	struct isert_np *isert_np = cma_id->context;
 
 	ib_drain_qp(isert_conn->qp);
+
+	mutex_lock(&isert_np->mutex);
 	list_del_init(&isert_conn->node);
+	mutex_unlock(&isert_np->mutex);
 	isert_conn->cm_id = NULL;
 	isert_put_conn(isert_conn);
 
@@ -2432,6 +2436,7 @@ isert_free_np(struct iscsi_np *np)
 {
 	struct isert_np *isert_np = np->np_context;
 	struct isert_conn *isert_conn, *n;
+	LIST_HEAD(drop_conn_list);
 
 	if (isert_np->cm_id)
 		rdma_destroy_id(isert_np->cm_id);
@@ -2451,7 +2456,7 @@ isert_free_np(struct iscsi_np *np)
 					 node) {
 			isert_info("cleaning isert_conn %p state (%d)\n",
 				   isert_conn, isert_conn->state);
-			isert_connect_release(isert_conn);
+			list_move_tail(&isert_conn->node, &drop_conn_list);
 		}
 	}
 
@@ -2462,11 +2467,16 @@ isert_free_np(struct iscsi_np *np)
 					 node) {
 			isert_info("cleaning isert_conn %p state (%d)\n",
 				   isert_conn, isert_conn->state);
-			isert_connect_release(isert_conn);
+			list_move_tail(&isert_conn->node, &drop_conn_list);
 		}
 	}
 	mutex_unlock(&isert_np->mutex);
 
+	list_for_each_entry_safe(isert_conn, n, &drop_conn_list, node) {
+		list_del_init(&isert_conn->node);
+		isert_connect_release(isert_conn);
+	}
+
 	np->np_context = NULL;
 	kfree(isert_np);
 }
@@ -2561,8 +2571,6 @@ static void isert_wait_conn(struct iscsit_conn *conn)
 	isert_put_unsol_pending_cmds(conn);
 	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
-
-	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
 static void isert_free_conn(struct iscsit_conn *conn)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 730f2f1e09bb..a67f58359de9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2042,6 +2042,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	return 0;
 }
 
+/* The caller should do the cleanup in case of error */
 static int create_cm(struct rtrs_clt_con *con)
 {
 	struct rtrs_path *s = con->c.path;
@@ -2064,14 +2065,14 @@ static int create_cm(struct rtrs_clt_con *con)
 	err = rdma_set_reuseaddr(cm_id, 1);
 	if (err != 0) {
 		rtrs_err(s, "Set address reuse failed, err: %d\n", err);
-		goto destroy_cm;
+		return err;
 	}
 	err = rdma_resolve_addr(cm_id, (struct sockaddr *)&clt_path->s.src_addr,
 				(struct sockaddr *)&clt_path->s.dst_addr,
 				RTRS_CONNECT_TIMEOUT_MS);
 	if (err) {
 		rtrs_err(s, "Failed to resolve address, err: %d\n", err);
-		goto destroy_cm;
+		return err;
 	}
 	/*
 	 * Combine connection status and session events. This is needed
@@ -2086,29 +2087,15 @@ static int create_cm(struct rtrs_clt_con *con)
 		if (err == 0)
 			err = -ETIMEDOUT;
 		/* Timedout or interrupted */
-		goto errr;
-	}
-	if (con->cm_err < 0) {
-		err = con->cm_err;
-		goto errr;
+		return err;
 	}
-	if (READ_ONCE(clt_path->state) != RTRS_CLT_CONNECTING) {
+	if (con->cm_err < 0)
+		return con->cm_err;
+	if (READ_ONCE(clt_path->state) != RTRS_CLT_CONNECTING)
 		/* Device removal */
-		err = -ECONNABORTED;
-		goto errr;
-	}
+		return -ECONNABORTED;
 
 	return 0;
-
-errr:
-	stop_cm(con);
-	mutex_lock(&con->con_mutex);
-	destroy_con_cq_qp(con);
-	mutex_unlock(&con->con_mutex);
-destroy_cm:
-	destroy_cm(con);
-
-	return err;
 }
 
 static void rtrs_clt_path_up(struct rtrs_clt_path *clt_path)
@@ -2336,7 +2323,7 @@ static void rtrs_clt_close_work(struct work_struct *work)
 static int init_conns(struct rtrs_clt_path *clt_path)
 {
 	unsigned int cid;
-	int err;
+	int err, i;
 
 	/*
 	 * On every new session connections increase reconnect counter
@@ -2352,10 +2339,8 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 			goto destroy;
 
 		err = create_cm(to_clt_con(clt_path->s.con[cid]));
-		if (err) {
-			destroy_con(to_clt_con(clt_path->s.con[cid]));
+		if (err)
 			goto destroy;
-		}
 	}
 	err = alloc_path_reqs(clt_path);
 	if (err)
@@ -2366,15 +2351,21 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 	return 0;
 
 destroy:
-	while (cid--) {
-		struct rtrs_clt_con *con = to_clt_con(clt_path->s.con[cid]);
+	/* Make sure we do the cleanup in the order they are created */
+	for (i = 0; i <= cid; i++) {
+		struct rtrs_clt_con *con;
 
-		stop_cm(con);
+		if (!clt_path->s.con[i])
+			break;
 
-		mutex_lock(&con->con_mutex);
-		destroy_con_cq_qp(con);
-		mutex_unlock(&con->con_mutex);
-		destroy_cm(con);
+		con = to_clt_con(clt_path->s.con[i]);
+		if (con->c.cm_id) {
+			stop_cm(con);
+			mutex_lock(&con->con_mutex);
+			destroy_con_cq_qp(con);
+			mutex_unlock(&con->con_mutex);
+			destroy_cm(con);
+		}
 		destroy_con(con);
 	}
 	/*
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index ed324b47d93a..716ec7baddef 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -37,8 +37,10 @@ struct rtrs_iu *rtrs_iu_alloc(u32 iu_num, size_t size, gfp_t gfp_mask,
 			goto err;
 
 		iu->dma_addr = ib_dma_map_single(dma_dev, iu->buf, size, dir);
-		if (ib_dma_mapping_error(dma_dev, iu->dma_addr))
+		if (ib_dma_mapping_error(dma_dev, iu->dma_addr)) {
+			kfree(iu->buf);
 			goto err;
+		}
 
 		iu->cqe.done  = done;
 		iu->size      = size;
diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index a610821c8ff2..afd6a1841715 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -16,7 +16,13 @@ void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (!of_device_is_compatible(np, quirks->compatible))
+		if (!quirks->compatible && !quirks->property)
+			continue;
+		if (quirks->compatible &&
+		    !of_device_is_compatible(np, quirks->compatible))
+			continue;
+		if (quirks->property &&
+		    !of_property_read_bool(np, quirks->property))
 			continue;
 		if (quirks->init(data))
 			pr_info("GIC: enabling workaround for %s\n",
@@ -28,7 +34,7 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (quirks->compatible)
+		if (quirks->compatible || quirks->property)
 			continue;
 		if (quirks->iidr != (quirks->mask & iidr))
 			continue;
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 27e3d4ed4f32..3db4592cda1c 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -13,6 +13,7 @@
 struct gic_quirk {
 	const char *desc;
 	const char *compatible;
+	const char *property;
 	bool (*init)(void *data);
 	u32 iidr;
 	u32 mask;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2182f87d2d12..11f7c53e4b63 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -38,6 +38,7 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -1730,6 +1731,15 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_mtk_gicr(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_MTK_GICR_SAVE;
+
+	return true;
+}
+
 static bool gic_enable_quirk_cavium_38539(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1802,6 +1812,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.compatible = "qcom,msm8996-gic-v3",
 		.init	= gic_enable_quirk_msm8996,
 	},
+	{
+		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
+		.property = "mediatek,broken-save-restore-fw",
+		.init	= gic_enable_quirk_mtk_gicr,
+	},
 	{
 		.desc	= "GICv3: HIP06 erratum 161010803",
 		.iidr	= 0x0204043b,
@@ -1844,6 +1859,11 @@ static void gic_enable_nmi_support(void)
 	if (!gic_prio_masking_enabled())
 		return;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
+		pr_warn("Skipping NMI enable due to firmware issues\n");
+		return;
+	}
+
 	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
 	if (!ppi_nmi_refs)
 		return;
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 2aaa9aad3e87..7da18ef95211 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -150,7 +150,7 @@ static const struct meson_gpio_irq_params s4_params = {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
 
-static const struct of_device_id meson_irq_gpio_matches[] = {
+static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 83aecd9250ba..6ae1c19b8243 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1151,13 +1151,10 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
-		int srcu_idx;
 
 		/* Suspend if it isn't already suspended */
-		old_map = dm_get_live_table(md, &srcu_idx);
-		if ((param->flags & DM_SKIP_LOCKFS_FLAG) || !old_map)
+		if (param->flags & DM_SKIP_LOCKFS_FLAG)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
-		dm_put_live_table(md, srcu_idx);
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 		if (!dm_suspended_md(md))
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 80545ec54121..59eb1cb7037a 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1750,13 +1750,15 @@ int dm_thin_remove_range(struct dm_thin_device *td,
 
 int dm_pool_block_is_shared(struct dm_pool_metadata *pmd, dm_block_t b, bool *result)
 {
-	int r;
+	int r = -EINVAL;
 	uint32_t ref_count;
 
 	down_read(&pmd->root_lock);
-	r = dm_sm_get_count(pmd->data_sm, b, &ref_count);
-	if (!r)
-		*result = (ref_count > 1);
+	if (!pmd->fail_io) {
+		r = dm_sm_get_count(pmd->data_sm, b, &ref_count);
+		if (!r)
+			*result = (ref_count > 1);
+	}
 	up_read(&pmd->root_lock);
 
 	return r;
@@ -1764,10 +1766,11 @@ int dm_pool_block_is_shared(struct dm_pool_metadata *pmd, dm_block_t b, bool *re
 
 int dm_pool_inc_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_t e)
 {
-	int r = 0;
+	int r = -EINVAL;
 
 	pmd_write_lock(pmd);
-	r = dm_sm_inc_blocks(pmd->data_sm, b, e);
+	if (!pmd->fail_io)
+		r = dm_sm_inc_blocks(pmd->data_sm, b, e);
 	pmd_write_unlock(pmd);
 
 	return r;
@@ -1775,10 +1778,11 @@ int dm_pool_inc_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_
 
 int dm_pool_dec_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_t e)
 {
-	int r = 0;
+	int r = -EINVAL;
 
 	pmd_write_lock(pmd);
-	r = dm_sm_dec_blocks(pmd->data_sm, b, e);
+	if (!pmd->fail_io)
+		r = dm_sm_dec_blocks(pmd->data_sm, b, e);
 	pmd_write_unlock(pmd);
 
 	return r;
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index d12aff50974a..601f9e4e6234 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -398,8 +398,7 @@ static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t da
 	sector_t s = block_to_sectors(tc->pool, data_b);
 	sector_t len = block_to_sectors(tc->pool, data_e - data_b);
 
-	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOWAIT,
-				      &op->bio);
+	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
 }
 
 static void end_discard(struct discard_op *op, int r)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 24284d22f15b..acf7e7551c94 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2801,6 +2801,10 @@ int dm_suspend(struct mapped_device *md, unsigned int suspend_flags)
 	}
 
 	map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
+	if (!map) {
+		/* avoid deadlock with fs/namespace.c:do_mount() */
+		suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+	}
 
 	r = __dm_suspend(md, map, suspend_flags, TASK_INTERRUPTIBLE, DMF_SUSPENDED);
 	if (r)
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index cc89cff029e1..5f6af0870dfd 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1253,7 +1253,7 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 	/* Consider the standard Ethernet overhead of 8 octets preamble+SFD,
 	 * 4 octets FCS, 12 octets IFG.
 	 */
-	needed_bit_time_ps = (maxlen + 24) * picos_per_byte;
+	needed_bit_time_ps = (u64)(maxlen + 24) * picos_per_byte;
 
 	dev_dbg(ocelot->dev,
 		"port %d: max frame size %d needs %llu ps at speed %d\n",
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index a8539a8554a1..762849959cc1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -189,8 +189,8 @@ int enetc_setup_tc_cbs(struct net_device *ndev, void *type_data)
 	int bw_sum = 0;
 	u8 bw;
 
-	prio_top = netdev_get_prio_tc_map(ndev, tc_nums - 1);
-	prio_next = netdev_get_prio_tc_map(ndev, tc_nums - 2);
+	prio_top = tc_nums - 1;
+	prio_next = tc_nums - 2;
 
 	/* Support highest prio and second prio tc in cbs mode */
 	if (tc != prio_top && tc != prio_next)
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 93a998f169de..6625625f91e4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -525,7 +525,7 @@ void iavf_set_ethtool_ops(struct net_device *netdev);
 void iavf_update_stats(struct iavf_adapter *adapter);
 void iavf_reset_interrupt_capability(struct iavf_adapter *adapter);
 int iavf_init_interrupt_scheme(struct iavf_adapter *adapter);
-void iavf_irq_enable_queues(struct iavf_adapter *adapter, u32 mask);
+void iavf_irq_enable_queues(struct iavf_adapter *adapter);
 void iavf_free_all_tx_resources(struct iavf_adapter *adapter);
 void iavf_free_all_rx_resources(struct iavf_adapter *adapter);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 34711a88dbaa..965d02d7ff80 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -359,21 +359,18 @@ static void iavf_irq_disable(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_irq_enable_queues - Enable interrupt for specified queues
+ * iavf_irq_enable_queues - Enable interrupt for all queues
  * @adapter: board private structure
- * @mask: bitmap of queues to enable
  **/
-void iavf_irq_enable_queues(struct iavf_adapter *adapter, u32 mask)
+void iavf_irq_enable_queues(struct iavf_adapter *adapter)
 {
 	struct iavf_hw *hw = &adapter->hw;
 	int i;
 
 	for (i = 1; i < adapter->num_msix_vectors; i++) {
-		if (mask & BIT(i - 1)) {
-			wr32(hw, IAVF_VFINT_DYN_CTLN1(i - 1),
-			     IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
-			     IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK);
-		}
+		wr32(hw, IAVF_VFINT_DYN_CTLN1(i - 1),
+		     IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
+		     IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK);
 	}
 }
 
@@ -387,7 +384,7 @@ void iavf_irq_enable(struct iavf_adapter *adapter, bool flush)
 	struct iavf_hw *hw = &adapter->hw;
 
 	iavf_misc_irq_enable(adapter);
-	iavf_irq_enable_queues(adapter, ~0);
+	iavf_irq_enable_queues(adapter);
 
 	if (flush)
 		iavf_flush(hw);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_register.h b/drivers/net/ethernet/intel/iavf/iavf_register.h
index bf793332fc9d..a19e88898a0b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_register.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_register.h
@@ -40,7 +40,7 @@
 #define IAVF_VFINT_DYN_CTL01_INTENA_MASK IAVF_MASK(0x1, IAVF_VFINT_DYN_CTL01_INTENA_SHIFT)
 #define IAVF_VFINT_DYN_CTL01_ITR_INDX_SHIFT 3
 #define IAVF_VFINT_DYN_CTL01_ITR_INDX_MASK IAVF_MASK(0x3, IAVF_VFINT_DYN_CTL01_ITR_INDX_SHIFT)
-#define IAVF_VFINT_DYN_CTLN1(_INTVF) (0x00003800 + ((_INTVF) * 4)) /* _i=0...15 */ /* Reset: VFR */
+#define IAVF_VFINT_DYN_CTLN1(_INTVF) (0x00003800 + ((_INTVF) * 4)) /* _i=0...63 */ /* Reset: VFR */
 #define IAVF_VFINT_DYN_CTLN1_INTENA_SHIFT 0
 #define IAVF_VFINT_DYN_CTLN1_INTENA_MASK IAVF_MASK(0x1, IAVF_VFINT_DYN_CTLN1_INTENA_SHIFT)
 #define IAVF_VFINT_DYN_CTLN1_SWINT_TRIG_SHIFT 2
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6a50f8ba3940..4095fe40dfc9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6784,6 +6784,10 @@ int ice_down(struct ice_vsi *vsi)
 	ice_for_each_txq(vsi, i)
 		ice_clean_tx_ring(vsi->tx_rings[i]);
 
+	if (ice_is_xdp_ena_vsi(vsi))
+		ice_for_each_xdp_txq(vsi, i)
+			ice_clean_tx_ring(vsi->xdp_rings[i]);
+
 	ice_for_each_rxq(vsi, i)
 		ice_clean_rx_ring(vsi->rx_rings[i]);
 
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index ff911af16a4b..96fa1c420f91 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -822,6 +822,8 @@ static int igb_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = hw->nvm.ops.read(hw, last_word, 1,
 				   &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 	}
 
 	/* Device's eeprom is always little-endian, word addressable */
@@ -841,6 +843,7 @@ static int igb_set_eeprom(struct net_device *netdev,
 		hw->nvm.ops.update(hw);
 
 	igb_set_fw_version(adapter);
+out:
 	kfree(eeprom_buff);
 	return ret_val;
 }
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b3aed4e2ca91..18ffbc892f86 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6893,6 +6893,7 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 	struct e1000_hw *hw = &adapter->hw;
 	struct ptp_clock_event event;
 	struct timespec64 ts;
+	unsigned long flags;
 
 	if (pin < 0 || pin >= IGB_N_SDP)
 		return;
@@ -6900,9 +6901,12 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 	if (hw->mac.type == e1000_82580 ||
 	    hw->mac.type == e1000_i354 ||
 	    hw->mac.type == e1000_i350) {
-		s64 ns = rd32(auxstmpl);
+		u64 ns = rd32(auxstmpl);
 
-		ns += ((s64)(rd32(auxstmph) & 0xFF)) << 32;
+		ns += ((u64)(rd32(auxstmph) & 0xFF)) << 32;
+		spin_lock_irqsave(&adapter->tmreg_lock, flags);
+		ns = timecounter_cyc2time(&adapter->tc, ns);
+		spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 		ts = ns_to_timespec64(ns);
 	} else {
 		ts.tv_nsec = rd32(auxstmpl);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1d9b70e0ff67..3509974c1f8e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -255,6 +255,13 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 	/* reset BQL for queue */
 	netdev_tx_reset_queue(txring_txq(tx_ring));
 
+	/* Zero out the buffer ring */
+	memset(tx_ring->tx_buffer_info, 0,
+	       sizeof(*tx_ring->tx_buffer_info) * tx_ring->count);
+
+	/* Zero out the descriptor ring */
+	memset(tx_ring->desc, 0, tx_ring->size);
+
 	/* reset next_to_use and next_to_clean */
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
@@ -268,7 +275,7 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
  */
 void igc_free_tx_resources(struct igc_ring *tx_ring)
 {
-	igc_clean_tx_ring(tx_ring);
+	igc_disable_tx_ring(tx_ring);
 
 	vfree(tx_ring->tx_buffer_info);
 	tx_ring->tx_buffer_info = NULL;
@@ -6678,6 +6685,9 @@ static void igc_remove(struct pci_dev *pdev)
 
 	igc_ptp_stop(adapter);
 
+	pci_disable_ptm(pdev);
+	pci_clear_master(pdev);
+
 	set_bit(__IGC_DOWN, &adapter->state);
 
 	del_timer_sync(&adapter->watchdog_timer);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index b45dd7f04e21..8979dd05e873 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -928,6 +928,9 @@ int octep_device_setup(struct octep_device *oct)
 		oct->mmio[i].hw_addr =
 			ioremap(pci_resource_start(oct->pdev, i * 2),
 				pci_resource_len(oct->pdev, i * 2));
+		if (!oct->mmio[i].hw_addr)
+			goto unmap_prev;
+
 		oct->mmio[i].mapped = 1;
 	}
 
@@ -966,7 +969,9 @@ int octep_device_setup(struct octep_device *oct)
 	return 0;
 
 unsupported_dev:
-	for (i = 0; i < OCTEP_MMIO_REGIONS; i++)
+	i = OCTEP_MMIO_REGIONS;
+unmap_prev:
+	while (i--)
 		iounmap(oct->mmio[i].hw_addr);
 
 	kfree(oct->conf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 84f2ba53b8b6..8cb2a0181fb9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1878,7 +1878,8 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 		free_cnt = rvu_rsrc_free_count(&txsch->schq);
 	}
 
-	if (free_cnt < req_schq || req_schq > MAX_TXSCHQ_PER_FUNC)
+	if (free_cnt < req_schq || req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
+	    req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
 		return NIX_AF_ERR_TLX_ALLOC_FAIL;
 
 	/* If contiguous queues are needed, check for availability */
@@ -4069,10 +4070,6 @@ int rvu_mbox_handler_nix_set_rx_cfg(struct rvu *rvu, struct nix_rx_cfg *req,
 
 static u64 rvu_get_lbk_link_credits(struct rvu *rvu, u16 lbk_max_frs)
 {
-	/* CN10k supports 72KB FIFO size and max packet size of 64k */
-	if (rvu->hw->lbk_bufsize == 0x12000)
-		return (rvu->hw->lbk_bufsize - lbk_max_frs) / 16;
-
 	return 1600; /* 16 * max LBK datarate = 16 * 100Gbps */
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 3182adb7b9a8..3b48b635977f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -1168,10 +1168,8 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 {
 	struct npc_exact_table *table;
 	u16 *cnt, old_cnt;
-	bool promisc;
 
 	table = rvu->hw->table;
-	promisc = table->promisc_mode[drop_mcam_idx];
 
 	cnt = &table->cnt_cmd_rules[drop_mcam_idx];
 	old_cnt = *cnt;
@@ -1183,16 +1181,13 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 
 	*enable_or_disable_cam = false;
 
-	if (promisc)
-		goto done;
-
-	/* If all rules are deleted and not already in promisc mode; disable cam */
+	/* If all rules are deleted, disable cam */
 	if (!*cnt && val < 0) {
 		*enable_or_disable_cam = true;
 		goto done;
 	}
 
-	/* If rule got added and not already in promisc mode; enable cam */
+	/* If rule got added, enable cam */
 	if (!old_cnt && val > 0) {
 		*enable_or_disable_cam = true;
 		goto done;
@@ -1447,7 +1442,6 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
 	u32 drop_mcam_idx;
 	bool *promisc;
 	bool rc;
-	u32 cnt;
 
 	table = rvu->hw->table;
 
@@ -1470,17 +1464,8 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
 		return LMAC_AF_ERR_INVALID_PARAM;
 	}
 	*promisc = false;
-	cnt = __rvu_npc_exact_cmd_rules_cnt_update(rvu, drop_mcam_idx, 0, NULL);
 	mutex_unlock(&table->lock);
 
-	/* If no dmac filter entries configured, disable drop rule */
-	if (!cnt)
-		rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, false);
-	else
-		rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, !*promisc);
-
-	dev_dbg(rvu->dev, "%s: disabled  promisc mode (cgx=%d lmac=%d, cnt=%d)\n",
-		__func__, cgx_id, lmac_id, cnt);
 	return 0;
 }
 
@@ -1498,7 +1483,6 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
 	u32 drop_mcam_idx;
 	bool *promisc;
 	bool rc;
-	u32 cnt;
 
 	table = rvu->hw->table;
 
@@ -1521,17 +1505,8 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
 		return LMAC_AF_ERR_INVALID_PARAM;
 	}
 	*promisc = true;
-	cnt = __rvu_npc_exact_cmd_rules_cnt_update(rvu, drop_mcam_idx, 0, NULL);
 	mutex_unlock(&table->lock);
 
-	/* If no dmac filter entries configured, disable drop rule */
-	if (!cnt)
-		rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, false);
-	else
-		rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, !*promisc);
-
-	dev_dbg(rvu->dev, "%s: Enabled promisc mode (cgx=%d lmac=%d cnt=%d)\n",
-		__func__, cgx_id, lmac_id, cnt);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 1a35b3c2a367..0b560e97a356 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -275,18 +275,6 @@ static inline bool mlx5_sriov_is_enabled(struct mlx5_core_dev *dev)
 	return pci_num_vf(dev->pdev) ? true : false;
 }
 
-static inline int mlx5_lag_is_lacp_owner(struct mlx5_core_dev *dev)
-{
-	/* LACP owner conditions:
-	 * 1) Function is physical.
-	 * 2) LAG is supported by FW.
-	 * 3) LAG is managed by driver (currently the only option).
-	 */
-	return  MLX5_CAP_GEN(dev, vport_group_manager) &&
-		   (MLX5_CAP_GEN(dev, num_lag_ports) > 1) &&
-		    MLX5_CAP_GEN(dev, lag_master);
-}
-
 int mlx5_rescan_drivers_locked(struct mlx5_core_dev *dev);
 static inline int mlx5_rescan_drivers(struct mlx5_core_dev *dev)
 {
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index aaa381743bca..27d00ffac68f 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -301,6 +301,7 @@ int efx_probe_interrupts(struct efx_nic *efx)
 		efx->tx_channel_offset = 0;
 		efx->n_xdp_channels = 0;
 		efx->xdp_channel_offset = efx->n_channels;
+		efx->xdp_txq_queues_mode = EFX_XDP_TX_QUEUES_BORROWED;
 		rc = pci_enable_msi(efx->pci_dev);
 		if (rc == 0) {
 			efx_get_channel(efx, 0)->irq = efx->pci_dev->irq;
@@ -322,6 +323,7 @@ int efx_probe_interrupts(struct efx_nic *efx)
 		efx->tx_channel_offset = efx_separate_tx_channels ? 1 : 0;
 		efx->n_xdp_channels = 0;
 		efx->xdp_channel_offset = efx->n_channels;
+		efx->xdp_txq_queues_mode = EFX_XDP_TX_QUEUES_BORROWED;
 		efx->legacy_irq = efx->pci_dev->irq;
 	}
 
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 06ed74994e36..1776f7f8a7a9 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -302,6 +302,7 @@ int efx_siena_probe_interrupts(struct efx_nic *efx)
 		efx->tx_channel_offset = 0;
 		efx->n_xdp_channels = 0;
 		efx->xdp_channel_offset = efx->n_channels;
+		efx->xdp_txq_queues_mode = EFX_XDP_TX_QUEUES_BORROWED;
 		rc = pci_enable_msi(efx->pci_dev);
 		if (rc == 0) {
 			efx_get_channel(efx, 0)->irq = efx->pci_dev->irq;
@@ -323,6 +324,7 @@ int efx_siena_probe_interrupts(struct efx_nic *efx)
 		efx->tx_channel_offset = efx_siena_separate_tx_channels ? 1 : 0;
 		efx->n_xdp_channels = 0;
 		efx->xdp_channel_offset = efx->n_channels;
+		efx->xdp_txq_queues_mode = EFX_XDP_TX_QUEUES_BORROWED;
 		efx->legacy_irq = efx->pci_dev->irq;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 490315723062..30ce07305578 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3865,7 +3865,6 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_hw_teardown(dev);
 init_error:
-	free_dma_desc_resources(priv, &priv->dma_conf);
 	phylink_disconnect_phy(priv->phylink);
 init_phy_error:
 	pm_runtime_put(priv->device);
@@ -3883,6 +3882,9 @@ static int stmmac_open(struct net_device *dev)
 		return PTR_ERR(dma_conf);
 
 	ret = __stmmac_open(dev, dma_conf);
+	if (ret)
+		free_dma_desc_resources(priv, dma_conf);
+
 	kfree(dma_conf);
 	return ret;
 }
@@ -5607,12 +5609,15 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 		stmmac_release(dev);
 
 		ret = __stmmac_open(dev, dma_conf);
-		kfree(dma_conf);
 		if (ret) {
+			free_dma_desc_resources(priv, dma_conf);
+			kfree(dma_conf);
 			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
 			return ret;
 		}
 
+		kfree(dma_conf);
+
 		stmmac_set_rx_mode(dev);
 	}
 
diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index 71712ea25403..d5b05e803219 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -102,6 +102,10 @@ static unsigned int ipvlan_nf_input(void *priv, struct sk_buff *skb,
 
 	skb->dev = addr->master->dev;
 	skb->skb_iif = skb->dev->ifindex;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (addr->atype == IPVL_IPV6)
+		IP6CB(skb)->iif = skb->dev->ifindex;
+#endif
 	len = skb->len + ETH_HLEN;
 	ipvlan_count_rx(addr->master, len, true, false);
 out:
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 038a78794392..983cabf9a0f6 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3981,17 +3981,15 @@ static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
 		return -ENOMEM;
 
 	secy->tx_sc.stats = netdev_alloc_pcpu_stats(struct pcpu_tx_sc_stats);
-	if (!secy->tx_sc.stats) {
-		free_percpu(macsec->stats);
+	if (!secy->tx_sc.stats)
 		return -ENOMEM;
-	}
 
 	secy->tx_sc.md_dst = metadata_dst_alloc(0, METADATA_MACSEC, GFP_KERNEL);
-	if (!secy->tx_sc.md_dst) {
-		free_percpu(secy->tx_sc.stats);
-		free_percpu(macsec->stats);
+	if (!secy->tx_sc.md_dst)
+		/* macsec and secy percpu stats will be freed when unregistering
+		 * net_device in macsec_free_netdev()
+		 */
 		return -ENOMEM;
-	}
 
 	if (sci == MACSEC_UNDEF_SCI)
 		sci = dev_to_sci(dev, MACSEC_PORT_ES);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4073e8243df3..5b064a1de92f 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -188,6 +188,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_GMII:
 		return SPEED_1000;
@@ -204,7 +205,6 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_10GBASER:
 	case PHY_INTERFACE_MODE_10GKR:
 	case PHY_INTERFACE_MODE_USXGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
 		return SPEED_10000;
 
 	case PHY_INTERFACE_MODE_25GBASER:
@@ -3263,6 +3263,41 @@ void phylink_decode_usxgmii_word(struct phylink_link_state *state,
 }
 EXPORT_SYMBOL_GPL(phylink_decode_usxgmii_word);
 
+/**
+ * phylink_decode_usgmii_word() - decode the USGMII word from a MAC PCS
+ * @state: a pointer to a struct phylink_link_state.
+ * @lpa: a 16 bit value which stores the USGMII auto-negotiation word
+ *
+ * Helper for MAC PCS supporting the USGMII protocol and the auto-negotiation
+ * code word.  Decode the USGMII code word and populate the corresponding fields
+ * (speed, duplex) into the phylink_link_state structure. The structure for this
+ * word is the same as the USXGMII word, except it only supports speeds up to
+ * 1Gbps.
+ */
+static void phylink_decode_usgmii_word(struct phylink_link_state *state,
+				       uint16_t lpa)
+{
+	switch (lpa & MDIO_USXGMII_SPD_MASK) {
+	case MDIO_USXGMII_10:
+		state->speed = SPEED_10;
+		break;
+	case MDIO_USXGMII_100:
+		state->speed = SPEED_100;
+		break;
+	case MDIO_USXGMII_1000:
+		state->speed = SPEED_1000;
+		break;
+	default:
+		state->link = false;
+		return;
+	}
+
+	if (lpa & MDIO_USXGMII_FULL_DUPLEX)
+		state->duplex = DUPLEX_FULL;
+	else
+		state->duplex = DUPLEX_HALF;
+}
+
 /**
  * phylink_mii_c22_pcs_decode_state() - Decode MAC PCS state from MII registers
  * @state: a pointer to a &struct phylink_link_state.
@@ -3299,9 +3334,11 @@ void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
 
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
 		phylink_decode_sgmii_word(state, lpa);
 		break;
+	case PHY_INTERFACE_MODE_QUSGMII:
+		phylink_decode_usgmii_word(state, lpa);
+		break;
 
 	default:
 		state->link = false;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 45c258501135..68829a5a93d3 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1219,7 +1219,9 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_QUIRK_SET_DTR(0x05c6, 0x9091, 2)},	/* Compal RXM-G1 */
 	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
+	{QMI_QUIRK_SET_DTR(0x05c6, 0x90db, 2)},	/* Compal RXM-G1 */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index d62a904d2e42..56326f38fe8a 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -384,6 +384,9 @@ static int lapbeth_new_device(struct net_device *dev)
 
 	ASSERT_RTNL();
 
+	if (dev->type != ARPHRD_ETHER)
+		return -EINVAL;
+
 	ndev = alloc_netdev(sizeof(*lapbeth), "lapb%d", NET_NAME_UNKNOWN,
 			    lapbeth_setup);
 	if (!ndev)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba4903c86f7f..145fa7ef3f74 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3537,6 +3537,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index ed4e6c144a68..5289975bad70 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -811,6 +811,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs)
 		if (!fragment->target) {
 			pr_err("symbols in overlay, but not in live tree\n");
 			ret = -EINVAL;
+			of_node_put(node);
 			goto err_out;
 		}
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8d32a3834688..ccc90656130a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5995,8 +5995,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency
 
 #ifdef CONFIG_PCIE_DPC
 /*
- * Intel Tiger Lake and Alder Lake BIOS has a bug that clears the DPC
- * RP PIO Log Size of the integrated Thunderbolt PCIe Root Ports.
+ * Intel Ice Lake, Tiger Lake and Alder Lake BIOS has a bug that clears
+ * the DPC RP PIO Log Size of the integrated Thunderbolt PCIe Root
+ * Ports.
  */
 static void dpc_log_size(struct pci_dev *dev)
 {
@@ -6019,6 +6020,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x462f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x463f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x466e, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1d, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a21, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a23, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a23, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a25, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a27, dpc_log_size);
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index e2c9a68d12df..fdf7da06af30 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -555,6 +555,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
 	{ KE_IGNORE, 0x79, },  /* Charger type dectection notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
+	{ KE_IGNORE, 0x7B, }, /* Charger connect/disconnect notification */
 	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
@@ -584,6 +585,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xAE, { KEY_FN_F5 } }, /* Fn+F5 fan mode on 2020+ */
 	{ KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
+	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notification */
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 307ee6f71042..6f83e99d2eb7 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -624,10 +624,8 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_btemp *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->btemp_psy, ab8500_btemp_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c6c9804280db..71ce28eed463 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2407,10 +2407,8 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->fg_psy, ab8500_fg_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_fg_get_ext_psy_data);
 }
 
 /**
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 17a09d103a59..4a5371a3a531 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1083,10 +1083,8 @@ static int poll_interval_param_set(const char *val, const struct kernel_param *k
 		return ret;
 
 	mutex_lock(&bq27xxx_list_lock);
-	list_for_each_entry(di, &bq27xxx_battery_devices, list) {
-		cancel_delayed_work_sync(&di->work);
-		schedule_delayed_work(&di->work, 0);
-	}
+	list_for_each_entry(di, &bq27xxx_battery_devices, list)
+		mod_delayed_work(system_wq, &di->work, 0);
 	mutex_unlock(&bq27xxx_list_lock);
 
 	return ret;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8382be867d27..7871ab5e979c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -348,6 +348,10 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
 	struct power_supply *psy = dev_get_drvdata(dev);
 	unsigned int *count = data;
 
+	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
+		if (ret.intval == POWER_SUPPLY_SCOPE_DEVICE)
+			return 0;
+
 	(*count)++;
 	if (psy->desc->type != POWER_SUPPLY_TYPE_BATTERY)
 		if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE,
@@ -366,8 +370,8 @@ int power_supply_is_system_supplied(void)
 				      __power_supply_is_system_supplied);
 
 	/*
-	 * If no power class device was found at all, most probably we are
-	 * running on a desktop system, so assume we are on mains power.
+	 * If no system scope power class device was found at all, most probably we
+	 * are running on a desktop system, so assume we are on mains power.
 	 */
 	if (count == 0)
 		return 1;
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5369abaceb5c..7abd916d005a 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -285,7 +285,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 
 		if (ret < 0) {
 			if (ret == -ENODATA)
-				dev_dbg(dev, "driver has no data for `%s' property\n",
+				dev_dbg_ratelimited(dev,
+					"driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
 				dev_err_ratelimited(dev,
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 632977f84b95..bd23c4d9fed4 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -733,13 +733,6 @@ static int sc27xx_fgu_set_property(struct power_supply *psy,
 	return ret;
 }
 
-static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
-{
-	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
-
-	power_supply_changed(data->battery);
-}
-
 static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 					    enum power_supply_property psp)
 {
@@ -774,7 +767,7 @@ static const struct power_supply_desc sc27xx_fgu_desc = {
 	.num_properties		= ARRAY_SIZE(sc27xx_fgu_props),
 	.get_property		= sc27xx_fgu_get_property,
 	.set_property		= sc27xx_fgu_set_property,
-	.external_power_changed	= sc27xx_fgu_external_power_changed,
+	.external_power_changed	= power_supply_changed,
 	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
 	.no_thermal		= true,
 };
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c417eae887b2..e01cade8be0c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5257,7 +5257,7 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (!rdev->debugfs) {
+	if (IS_ERR(rdev->debugfs)) {
 		rdev_warn(rdev, "Failed to create debugfs directory\n");
 		return;
 	}
@@ -6179,7 +6179,7 @@ static int __init regulator_init(void)
 	ret = class_register(&regulator_class);
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
-	if (!debugfs_root)
+	if (IS_ERR(debugfs_root))
 		pr_warn("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index d4cba3b3c56c..85219b5e1f41 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -50,8 +50,6 @@
 #define LLCC_TRP_WRSC_EN              0x21f20
 #define LLCC_TRP_WRSC_CACHEABLE_EN    0x21f2c
 
-#define BANK_OFFSET_STRIDE	      0x80000
-
 #define LLCC_VERSION_2_0_0_0          0x02000000
 #define LLCC_VERSION_2_1_0_0          0x02010000
 
@@ -749,8 +747,8 @@ static int qcom_llcc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
-		const char *name)
+static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev, u8 index,
+					  const char *name)
 {
 	void __iomem *base;
 	struct regmap_config llcc_regmap_config = {
@@ -760,7 +758,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
 		.fast_io = true,
 	};
 
-	base = devm_platform_ioremap_resource_byname(pdev, name);
+	base = devm_platform_ioremap_resource(pdev, index);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 
@@ -778,6 +776,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	const struct llcc_slice_config *llcc_cfg;
 	u32 sz;
 	u32 version;
+	struct regmap *regmap;
 
 	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data) {
@@ -785,21 +784,51 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	drv_data->regmap = qcom_llcc_init_mmio(pdev, "llcc_base");
-	if (IS_ERR(drv_data->regmap)) {
-		ret = PTR_ERR(drv_data->regmap);
+	/* Initialize the first LLCC bank regmap */
+	regmap = qcom_llcc_init_mmio(pdev, 0, "llcc0_base");
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
 		goto err;
 	}
 
-	drv_data->bcast_regmap =
-		qcom_llcc_init_mmio(pdev, "llcc_broadcast_base");
+	cfg = of_device_get_match_data(&pdev->dev);
+
+	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
+	if (ret)
+		goto err;
+
+	num_banks &= LLCC_LB_CNT_MASK;
+	num_banks >>= LLCC_LB_CNT_SHIFT;
+	drv_data->num_banks = num_banks;
+
+	drv_data->regmaps = devm_kcalloc(dev, num_banks, sizeof(*drv_data->regmaps), GFP_KERNEL);
+	if (!drv_data->regmaps) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	drv_data->regmaps[0] = regmap;
+
+	/* Initialize rest of LLCC bank regmaps */
+	for (i = 1; i < num_banks; i++) {
+		char *base = kasprintf(GFP_KERNEL, "llcc%d_base", i);
+
+		drv_data->regmaps[i] = qcom_llcc_init_mmio(pdev, i, base);
+		if (IS_ERR(drv_data->regmaps[i])) {
+			ret = PTR_ERR(drv_data->regmaps[i]);
+			kfree(base);
+			goto err;
+		}
+
+		kfree(base);
+	}
+
+	drv_data->bcast_regmap = qcom_llcc_init_mmio(pdev, i, "llcc_broadcast_base");
 	if (IS_ERR(drv_data->bcast_regmap)) {
 		ret = PTR_ERR(drv_data->bcast_regmap);
 		goto err;
 	}
 
-	cfg = of_device_get_match_data(&pdev->dev);
-
 	/* Extract version of the IP */
 	ret = regmap_read(drv_data->bcast_regmap, cfg->reg_offset[LLCC_COMMON_HW_INFO],
 			  &version);
@@ -808,15 +837,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->version = version;
 
-	ret = regmap_read(drv_data->regmap, cfg->reg_offset[LLCC_COMMON_STATUS0],
-			  &num_banks);
-	if (ret)
-		goto err;
-
-	num_banks &= LLCC_LB_CNT_MASK;
-	num_banks >>= LLCC_LB_CNT_SHIFT;
-	drv_data->num_banks = num_banks;
-
 	llcc_cfg = cfg->sct_data;
 	sz = cfg->size;
 
@@ -824,16 +844,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		if (llcc_cfg[i].slice_id > drv_data->max_slices)
 			drv_data->max_slices = llcc_cfg[i].slice_id;
 
-	drv_data->offsets = devm_kcalloc(dev, num_banks, sizeof(u32),
-							GFP_KERNEL);
-	if (!drv_data->offsets) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < num_banks; i++)
-		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
-
 	drv_data->bitmap = devm_bitmap_zalloc(dev, drv_data->max_slices,
 					      GFP_KERNEL);
 	if (!drv_data->bitmap) {
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 30fd4bc90580..b371e4eb41ec 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1697,8 +1697,11 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->slow_sram = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
-					    "xlnx,versal-ospi-1.0"))
-			dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+					    "xlnx,versal-ospi-1.0")) {
+			ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+			if (ret)
+				goto probe_reset_failed;
+		}
 	}
 
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a33e547b7d39..01930b52c4fb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -975,7 +975,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 static int dspi_setup(struct spi_device *spi)
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
+	u32 period_ns = DIV_ROUND_UP(NSEC_PER_SEC, spi->max_speed_hz);
 	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
+	u32 quarter_period_ns = DIV_ROUND_UP(period_ns, 4);
 	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	struct fsl_dspi_platform_data *pdata;
 	unsigned char pasc = 0, asc = 0;
@@ -1003,6 +1005,19 @@ static int dspi_setup(struct spi_device *spi)
 		sck_cs_delay = pdata->sck_cs_delay;
 	}
 
+	/* Since tCSC and tASC apply to continuous transfers too, avoid SCK
+	 * glitches of half a cycle by never allowing tCSC + tASC to go below
+	 * half a SCK period.
+	 */
+	if (cs_sck_delay < quarter_period_ns)
+		cs_sck_delay = quarter_period_ns;
+	if (sck_cs_delay < quarter_period_ns)
+		sck_cs_delay = quarter_period_ns;
+
+	dev_dbg(&spi->dev,
+		"DSPI controller timing params: CS-to-SCK delay %u ns, SCK-to-CS delay %u ns\n",
+		cs_sck_delay, sck_cs_delay);
+
 	clkrate = clk_get_rate(dspi->clk);
 	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate);
 
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 86adff2a86ed..687adc9e086c 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -504,6 +504,8 @@ target_setup_session(struct se_portal_group *tpg,
 
 free_sess:
 	transport_free_session(sess);
+	return ERR_PTR(rc);
+
 free_cnt:
 	target_free_cmd_counter(cmd_cnt);
 	return ERR_PTR(rc);
diff --git a/drivers/thunderbolt/dma_test.c b/drivers/thunderbolt/dma_test.c
index 3bedecb236e0..14bb6dec6c4b 100644
--- a/drivers/thunderbolt/dma_test.c
+++ b/drivers/thunderbolt/dma_test.c
@@ -192,9 +192,9 @@ static int dma_test_start_rings(struct dma_test *dt)
 	}
 
 	ret = tb_xdomain_enable_paths(dt->xd, dt->tx_hopid,
-				      dt->tx_ring ? dt->tx_ring->hop : 0,
+				      dt->tx_ring ? dt->tx_ring->hop : -1,
 				      dt->rx_hopid,
-				      dt->rx_ring ? dt->rx_ring->hop : 0);
+				      dt->rx_ring ? dt->rx_ring->hop : -1);
 	if (ret) {
 		dma_test_free_rings(dt);
 		return ret;
@@ -218,9 +218,9 @@ static void dma_test_stop_rings(struct dma_test *dt)
 		tb_ring_stop(dt->tx_ring);
 
 	ret = tb_xdomain_disable_paths(dt->xd, dt->tx_hopid,
-				       dt->tx_ring ? dt->tx_ring->hop : 0,
+				       dt->tx_ring ? dt->tx_ring->hop : -1,
 				       dt->rx_hopid,
-				       dt->rx_ring ? dt->rx_ring->hop : 0);
+				       dt->rx_ring ? dt->rx_ring->hop : -1);
 	if (ret)
 		dev_warn(&dt->svc->dev, "failed to disable DMA paths\n");
 
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 0a525f44ea31..4a6a3802d7e5 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -56,9 +56,14 @@ static int ring_interrupt_index(const struct tb_ring *ring)
 
 static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
 {
-	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
-		return;
-	iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT) {
+		u32 val;
+
+		val = ioread32(nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
+		iowrite32(val & ~mask, nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
+	} else {
+		iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+	}
 }
 
 static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 3f1ab30c4fb1..e1eb092ad1d6 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -607,6 +607,7 @@ static void tb_scan_port(struct tb_port *port)
 {
 	struct tb_cm *tcm = tb_priv(port->sw->tb);
 	struct tb_port *upstream_port;
+	bool discovery = false;
 	struct tb_switch *sw;
 	int ret;
 
@@ -674,8 +675,10 @@ static void tb_scan_port(struct tb_port *port)
 	 * tunnels and know which switches were authorized already by
 	 * the boot firmware.
 	 */
-	if (!tcm->hotplug_active)
+	if (!tcm->hotplug_active) {
 		dev_set_uevent_suppress(&sw->dev, true);
+		discovery = true;
+	}
 
 	/*
 	 * At the moment Thunderbolt 2 and beyond (devices with LC) we
@@ -705,10 +708,14 @@ static void tb_scan_port(struct tb_port *port)
 	 * CL0s and CL1 are enabled and supported together.
 	 * Silently ignore CLx enabling in case CLx is not supported.
 	 */
-	ret = tb_switch_enable_clx(sw, TB_CL1);
-	if (ret && ret != -EOPNOTSUPP)
-		tb_sw_warn(sw, "failed to enable %s on upstream port\n",
-			   tb_switch_clx_name(TB_CL1));
+	if (discovery) {
+		tb_sw_dbg(sw, "discovery, not touching CL states\n");
+	} else {
+		ret = tb_switch_enable_clx(sw, TB_CL1);
+		if (ret && ret != -EOPNOTSUPP)
+			tb_sw_warn(sw, "failed to enable %s on upstream port\n",
+				   tb_switch_clx_name(TB_CL1));
+	}
 
 	if (tb_switch_is_clx_enabled(sw, TB_CL1))
 		/*
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index c892f3c7d1ab..112a2f5f6ac3 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -278,6 +278,7 @@ lqasc_err_int(int irq, void *_port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
+	__raw_writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9f8c988c25cb..e999e6079ae0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1982,6 +1982,11 @@ static int dwc3_remove(struct platform_device *pdev)
 	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	/*
+	 * HACK: Clear the driver data, which is currently accessed by parent
+	 * glue drivers, before allowing the parent to suspend.
+	 */
+	platform_set_drvdata(pdev, NULL);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	dwc3_free_event_buffers(dwc);
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 959fc925ca7c..79b22abf9727 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -308,7 +308,16 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
 /* Only usable in contexts where the role can not change. */
 static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 {
-	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
+	struct dwc3 *dwc;
+
+	/*
+	 * FIXME: Fix this layering violation.
+	 */
+	dwc = platform_get_drvdata(qcom->dwc3);
+
+	/* Core driver may not have probed yet. */
+	if (!dwc)
+		return false;
 
 	return dwc->xhci;
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8cd0d919ef63..7e94d31687e9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -180,6 +180,7 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 	list_del(&req->list);
 	req->remaining = 0;
 	req->needs_extra_trb = false;
+	req->num_trbs = 0;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index bf9878e1a72a..99f40611f459 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -37,6 +37,14 @@ static struct bus_type gadget_bus_type;
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
  * @started: the UDC's started state. True if the UDC had started.
+ * @allow_connect: Indicates whether UDC is allowed to be pulled up.
+ * Set/cleared by gadget_(un)bind_driver() after gadget driver is bound or
+ * unbound.
+ * @connect_lock: protects udc->started, gadget->connect,
+ * gadget->allow_connect and gadget->deactivate. The routines
+ * usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
+ * usb_udc_connect_control_locked(), usb_gadget_udc_start_locked() and
+ * usb_gadget_udc_stop_locked() are called with this lock held.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -48,6 +56,9 @@ struct usb_udc {
 	struct list_head		list;
 	bool				vbus;
 	bool				started;
+	bool				allow_connect;
+	struct work_struct		vbus_work;
+	struct mutex			connect_lock;
 };
 
 static struct class *udc_class;
@@ -660,17 +671,8 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
 
-/**
- * usb_gadget_connect - software-controlled connect to USB host
- * @gadget:the peripheral being connected
- *
- * Enables the D+ (or potentially D-) pullup.  The host will start
- * enumerating this gadget when the pullup is active and a VBUS session
- * is active (the link is powered).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_connect(struct usb_gadget *gadget)
+static int usb_gadget_connect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
 
@@ -679,10 +681,12 @@ int usb_gadget_connect(struct usb_gadget *gadget)
 		goto out;
 	}
 
-	if (gadget->deactivated) {
+	if (gadget->deactivated || !gadget->udc->allow_connect || !gadget->udc->started) {
 		/*
-		 * If gadget is deactivated we only save new state.
-		 * Gadget will be connected automatically after activation.
+		 * If the gadget isn't usable (because it is deactivated,
+		 * unbound, or not yet started), we only save the new state.
+		 * The gadget will be connected automatically when it is
+		 * activated/bound/started.
 		 */
 		gadget->connected = true;
 		goto out;
@@ -697,22 +701,31 @@ int usb_gadget_connect(struct usb_gadget *gadget)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_connect);
 
 /**
- * usb_gadget_disconnect - software-controlled disconnect from USB host
- * @gadget:the peripheral being disconnected
- *
- * Disables the D+ (or potentially D-) pullup, which the host may see
- * as a disconnect (when a VBUS session is active).  Not all systems
- * support software pullup controls.
+ * usb_gadget_connect - software-controlled connect to USB host
+ * @gadget:the peripheral being connected
  *
- * Following a successful disconnect, invoke the ->disconnect() callback
- * for the current gadget driver so that UDC drivers don't need to.
+ * Enables the D+ (or potentially D-) pullup.  The host will start
+ * enumerating this gadget when the pullup is active and a VBUS session
+ * is active (the link is powered).
  *
  * Returns zero on success, else negative errno.
  */
-int usb_gadget_disconnect(struct usb_gadget *gadget)
+int usb_gadget_connect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	ret = usb_gadget_connect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_connect);
+
+static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
 
@@ -724,7 +737,7 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
 	if (!gadget->connected)
 		goto out;
 
-	if (gadget->deactivated) {
+	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will stay disconnected after activation.
@@ -747,6 +760,30 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
 
 	return ret;
 }
+
+/**
+ * usb_gadget_disconnect - software-controlled disconnect from USB host
+ * @gadget:the peripheral being disconnected
+ *
+ * Disables the D+ (or potentially D-) pullup, which the host may see
+ * as a disconnect (when a VBUS session is active).  Not all systems
+ * support software pullup controls.
+ *
+ * Following a successful disconnect, invoke the ->disconnect() callback
+ * for the current gadget driver so that UDC drivers don't need to.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_disconnect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	ret = usb_gadget_disconnect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
 /**
@@ -764,13 +801,14 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
+	mutex_lock(&gadget->udc->connect_lock);
 	if (gadget->deactivated)
-		goto out;
+		goto unlock;
 
 	if (gadget->connected) {
-		ret = usb_gadget_disconnect(gadget);
+		ret = usb_gadget_disconnect_locked(gadget);
 		if (ret)
-			goto out;
+			goto unlock;
 
 		/*
 		 * If gadget was being connected before deactivation, we want
@@ -780,7 +818,8 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 	}
 	gadget->deactivated = true;
 
-out:
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
 	trace_usb_gadget_deactivate(gadget, ret);
 
 	return ret;
@@ -800,8 +839,9 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
+	mutex_lock(&gadget->udc->connect_lock);
 	if (!gadget->deactivated)
-		goto out;
+		goto unlock;
 
 	gadget->deactivated = false;
 
@@ -810,9 +850,11 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	 * while it was being deactivated, we call usb_gadget_connect().
 	 */
 	if (gadget->connected)
-		ret = usb_gadget_connect(gadget);
+		ret = usb_gadget_connect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
 
-out:
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
 	trace_usb_gadget_activate(gadget, ret);
 
 	return ret;
@@ -1051,12 +1093,22 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
-static void usb_udc_connect_control(struct usb_udc *udc)
+/* Acquire connect_lock before calling this function. */
+static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
 {
 	if (udc->vbus)
-		usb_gadget_connect(udc->gadget);
+		usb_gadget_connect_locked(udc->gadget);
 	else
-		usb_gadget_disconnect(udc->gadget);
+		usb_gadget_disconnect_locked(udc->gadget);
+}
+
+static void vbus_event_work(struct work_struct *work)
+{
+	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
+
+	mutex_lock(&udc->connect_lock);
+	usb_udc_connect_control_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 }
 
 /**
@@ -1067,6 +1119,14 @@ static void usb_udc_connect_control(struct usb_udc *udc)
  *
  * The udc driver calls it when it wants to connect or disconnect gadget
  * according to vbus status.
+ *
+ * This function can be invoked from interrupt context by irq handlers of
+ * the gadget drivers, however, usb_udc_connect_control() has to run in
+ * non-atomic context due to the following:
+ * a. Some of the gadget driver implementations expect the ->pullup
+ * callback to be invoked in non-atomic context.
+ * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
+ * Hence offload invocation of usb_udc_connect_control() to workqueue.
  */
 void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 {
@@ -1074,7 +1134,7 @@ void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 
 	if (udc) {
 		udc->vbus = status;
-		usb_udc_connect_control(udc);
+		schedule_work(&udc->vbus_work);
 	}
 }
 EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
@@ -1097,7 +1157,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadget,
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
 
 /**
- * usb_gadget_udc_start - tells usb device controller to start up
+ * usb_gadget_udc_start_locked - tells usb device controller to start up
  * @udc: The UDC to be started
  *
  * This call is issued by the UDC Class driver when it's about
@@ -1108,8 +1168,11 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  * necessary to have it powered on.
  *
  * Returns zero on success, else negative errno.
+ *
+ * Caller should acquire connect_lock before invoking this function.
  */
-static inline int usb_gadget_udc_start(struct usb_udc *udc)
+static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
+	__must_hold(&udc->connect_lock)
 {
 	int ret;
 
@@ -1126,7 +1189,7 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
 }
 
 /**
- * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
+ * usb_gadget_udc_stop_locked - tells usb device controller we don't need it anymore
  * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
@@ -1135,8 +1198,11 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
  * The details are implementation specific, but it can go as
  * far as powering off UDC completely and disable its data
  * line pullups.
+ *
+ * Caller should acquire connect lock before invoking this function.
  */
-static inline void usb_gadget_udc_stop(struct usb_udc *udc)
+static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
+	__must_hold(&udc->connect_lock)
 {
 	if (!udc->started) {
 		dev_err(&udc->dev, "UDC had already stopped\n");
@@ -1295,12 +1361,14 @@ int usb_add_gadget(struct usb_gadget *gadget)
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
+	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
 
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
 	mutex_unlock(&udc_lock);
+	INIT_WORK(&udc->vbus_work, vbus_event_work);
 
 	ret = device_add(&udc->dev);
 	if (ret)
@@ -1432,6 +1500,7 @@ void usb_del_gadget(struct usb_gadget *gadget)
 	flush_work(&gadget->work);
 	device_del(&gadget->dev);
 	ida_free(&gadget_id_numbers, gadget->id_number);
+	cancel_work_sync(&udc->vbus_work);
 	device_unregister(&udc->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget);
@@ -1496,11 +1565,16 @@ static int gadget_bind_driver(struct device *dev)
 	if (ret)
 		goto err_bind;
 
-	ret = usb_gadget_udc_start(udc);
-	if (ret)
+	mutex_lock(&udc->connect_lock);
+	ret = usb_gadget_udc_start_locked(udc);
+	if (ret) {
+		mutex_unlock(&udc->connect_lock);
 		goto err_start;
+	}
 	usb_gadget_enable_async_callbacks(udc);
-	usb_udc_connect_control(udc);
+	udc->allow_connect = true;
+	usb_udc_connect_control_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -1531,12 +1605,16 @@ static void gadget_unbind_driver(struct device *dev)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
-	usb_gadget_disconnect(gadget);
+	udc->allow_connect = false;
+	cancel_work_sync(&udc->vbus_work);
+	mutex_lock(&udc->connect_lock);
+	usb_gadget_disconnect_locked(gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)
 		synchronize_irq(gadget->irq);
 	udc->driver->unbind(gadget);
-	usb_gadget_udc_stop(udc);
+	usb_gadget_udc_stop_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 
 	mutex_lock(&udc_lock);
 	driver->is_bound = false;
@@ -1622,11 +1700,15 @@ static ssize_t soft_connect_store(struct device *dev,
 	}
 
 	if (sysfs_streq(buf, "connect")) {
-		usb_gadget_udc_start(udc);
-		usb_gadget_connect(udc->gadget);
+		mutex_lock(&udc->connect_lock);
+		usb_gadget_udc_start_locked(udc);
+		usb_gadget_connect_locked(udc->gadget);
+		mutex_unlock(&udc->connect_lock);
 	} else if (sysfs_streq(buf, "disconnect")) {
-		usb_gadget_disconnect(udc->gadget);
-		usb_gadget_udc_stop(udc);
+		mutex_lock(&udc->connect_lock);
+		usb_gadget_disconnect_locked(udc->gadget);
+		usb_gadget_udc_stop_locked(udc);
+		mutex_unlock(&udc->connect_lock);
 	} else {
 		dev_err(dev, "unsupported command '%s'\n", buf);
 		ret = -EINVAL;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index f05aea57e2d8..e12fec4c2e2f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -248,6 +248,8 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_VENDOR_ID			0x2c7c
 /* These Quectel products use Quectel's vendor ID */
 #define QUECTEL_PRODUCT_EC21			0x0121
+#define QUECTEL_PRODUCT_EM061K_LTA		0x0123
+#define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
@@ -266,6 +268,8 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EM061K_LWW		0x6008
+#define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
 #define QUECTEL_PRODUCT_RM500K			0x7001
 
@@ -1189,6 +1193,18 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LMS, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LMS, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LMS, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LTA, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LTA, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LTA, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LWW, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LWW, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LWW, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0, 0) },
diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
index b5ab26422c34..fd2477161e45 100644
--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -89,7 +89,7 @@ peak_current_show(struct device *dev, struct device_attribute *attr, char *buf)
 static ssize_t
 fast_role_swap_current_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%u\n", to_pdo(dev)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3;
+	return sysfs_emit(buf, "%u\n", (to_pdo(dev)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3);
 }
 static DEVICE_ATTR_RO(fast_role_swap_current);
 
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 086b50968983..47a2c73df342 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -132,10 +132,8 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	if (ret)
 		return ret;
 
-	if (cci & UCSI_CCI_BUSY) {
-		ucsi->ops->async_write(ucsi, UCSI_CANCEL, NULL, 0);
-		return -EBUSY;
-	}
+	if (cmd != UCSI_CANCEL && cci & UCSI_CCI_BUSY)
+		return ucsi_exec_command(ucsi, UCSI_CANCEL);
 
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
@@ -149,6 +147,11 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 		return ucsi_read_error(ucsi);
 	}
 
+	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
+		ret = ucsi_acknowledge_command(ucsi);
+		return ret ? ret : -EBUSY;
+	}
+
 	return UCSI_CCI_LENGTH(cci);
 }
 
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index d1c7068b4346..58452b86e672 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -115,8 +115,8 @@ void afs_vlserver_probe_result(struct afs_call *call)
 		}
 	}
 
-	if (rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us) &&
-	    rtt_us < server->probe.rtt) {
+	rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us);
+	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		server->rtt = rtt_us;
 		alist->preferred = index;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f33ddd5922b8..74a5c94898b0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2621,10 +2621,20 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	}
 
 	ret = inc_block_group_ro(cache, 0);
-	if (!do_chunk_alloc || ret == -ETXTBSY)
-		goto unlock_out;
 	if (!ret)
 		goto out;
+	if (ret == -ETXTBSY)
+		goto unlock_out;
+
+	/*
+	 * Skip chunk alloction if the bg is SYSTEM, this is to avoid system
+	 * chunk allocation storm to exhaust the system chunk array.  Otherwise
+	 * we still want to try our best to mark the block group read-only.
+	 */
+	if (!do_chunk_alloc && ret == -ENOSPC &&
+	    (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM))
+		goto unlock_out;
+
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ca69a46f1006..f22e00dfec6c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1098,13 +1098,18 @@ int btrfs_global_root_insert(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *tmp;
+	int ret = 0;
 
 	write_lock(&fs_info->global_root_lock);
 	tmp = rb_find_add(&root->rb_node, &fs_info->global_root_tree, global_root_cmp);
 	write_unlock(&fs_info->global_root_lock);
-	ASSERT(!tmp);
 
-	return tmp ? -EEXIST : 0;
+	if (tmp) {
+		ret = -EEXIST;
+		btrfs_warn(fs_info, "global root %llu %llu already exists",
+				root->root_key.objectid, root->root_key.offset);
+	}
+	return ret;
 }
 
 void btrfs_global_root_delete(struct btrfs_root *root)
@@ -2934,6 +2939,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 			/* We can't trust the free space cache either */
 			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
 
+			btrfs_warn(fs_info, "try to load backup roots slot %d", i);
 			ret = read_backup_root(fs_info, i);
 			backup_index = ret;
 			if (ret < 0)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 4fab7da63259..b14d2da9b26d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -717,7 +717,9 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 				sums = kvzalloc(btrfs_ordered_sum_size(fs_info,
 						      bytes_left), GFP_KERNEL);
 				memalloc_nofs_restore(nofs_flag);
-				BUG_ON(!sums); /* -ENOMEM */
+				if (!sums)
+					return BLK_STS_RESOURCE;
+
 				sums->len = bytes_left;
 				ordered = btrfs_lookup_ordered_extent(inode,
 								offset);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 56e9efbffd58..c5583fc2a585 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1849,7 +1849,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 
 	ret = btrfs_cross_ref_exist(root, btrfs_ino(inode),
 				    key->offset - args->extent_offset,
-				    args->disk_bytenr, false, path);
+				    args->disk_bytenr, args->strict, path);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
 		goto out;
@@ -7387,7 +7387,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 struct inode *inode,
 					 struct btrfs_dio_data *dio_data,
-					 u64 start, u64 len,
+					 u64 start, u64 *lenp,
 					 unsigned int iomap_flags)
 {
 	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
@@ -7398,6 +7398,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct btrfs_block_group *bg;
 	bool can_nocow = false;
 	bool space_reserved = false;
+	u64 len = *lenp;
 	u64 prev_len;
 	int ret = 0;
 
@@ -7468,15 +7469,19 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		free_extent_map(em);
 		*map = NULL;
 
-		if (nowait)
-			return -EAGAIN;
+		if (nowait) {
+			ret = -EAGAIN;
+			goto out;
+		}
 
 		/*
 		 * If we could not allocate data space before locking the file
 		 * range and we can't do a NOCOW write, then we have to fail.
 		 */
-		if (!dio_data->data_space_reserved)
-			return -ENOSPC;
+		if (!dio_data->data_space_reserved) {
+			ret = -ENOSPC;
+			goto out;
+		}
 
 		/*
 		 * We have to COW and we have already reserved data space before,
@@ -7517,6 +7522,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
 		btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
 	}
+	*lenp = len;
 	return ret;
 }
 
@@ -7693,7 +7699,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 
 	if (write) {
 		ret = btrfs_get_blocks_direct_write(&em, inode, dio_data,
-						    start, len, flags);
+						    start, &len, flags);
 		if (ret < 0)
 			goto unlock_err;
 		unlock_extents = true;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c5d8dc112fd5..1672d4846baa 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4017,13 +4017,20 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		if (ret == 0) {
 			ro_set = 1;
-		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
+		} else if (ret == -ENOSPC && !sctx->is_dev_replace &&
+			   !(cache->flags & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
 			/*
 			 * btrfs_inc_block_group_ro return -ENOSPC when it
 			 * failed in creating new chunk for metadata.
 			 * It is not a problem for scrub, because
 			 * metadata are always cowed, and our scrub paused
 			 * commit_transactions.
+			 *
+			 * For RAID56 chunks, we have to mark them read-only
+			 * for scrub, as later we would use our own cache
+			 * out of RAID56 realm.
+			 * Thus we want the RAID56 bg to be marked RO to
+			 * prevent RMW from screwing up out cache.
 			 */
 			ro_set = 0;
 		} else if (ret == -ETXTBSY) {
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 9a4c33ffb75f..87dcffece762 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -5146,9 +5146,13 @@ void cifs_oplock_break(struct work_struct *work)
 	 * disconnected since oplock already released by the server
 	 */
 	if (!oplock_break_cancelled) {
-		rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
+		/* check for server null since can race with kill_sb calling tree disconnect */
+		if (tcon->ses && tcon->ses->server) {
+			rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
 				volatile_fid, net_fid, cinode);
-		cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
+			cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
+		} else
+			pr_warn_once("lease break not sent for unmounted share\n");
 	}
 
 	cifs_done_oplock_break(cinode);
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 64659b110973..eccecd3fac90 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1760,7 +1760,11 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
-	list_del_init(&wq_entry->entry);
+	/*
+	 * Pairs with list_empty_careful in ep_poll, and ensures future loop
+	 * iterations see the cause of this wakeup.
+	 */
+	list_del_init_careful(&wq_entry->entry);
 	return ret;
 }
 
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index a38aa33af08e..8e83b51e3c68 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -322,17 +322,15 @@ static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
 struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
 					    ext4_group_t group)
 {
-	 struct ext4_group_info **grp_info;
-	 long indexv, indexh;
-
-	 if (unlikely(group >= EXT4_SB(sb)->s_groups_count)) {
-		 ext4_error(sb, "invalid group %u", group);
-		 return NULL;
-	 }
-	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
-	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
-	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
-	 return grp_info[indexh];
+	struct ext4_group_info **grp_info;
+	long indexv, indexh;
+
+	if (unlikely(group >= EXT4_SB(sb)->s_groups_count))
+		return NULL;
+	indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
+	indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
+	grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
+	return grp_info[indexh];
 }
 
 /*
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index bf8531b80a18..e1d2be19cddf 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -366,8 +366,6 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
-		if (!ksmbd_smb_request(conn))
-			break;
 
 		/*
 		 * We already read 4 bytes to find out PDU size, now
@@ -385,6 +383,9 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (!ksmbd_smb_request(conn))
+			break;
+
 		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
 			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 95afb6b23a91..05d7f3e910bf 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -158,7 +158,19 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
  */
 bool ksmbd_smb_request(struct ksmbd_conn *conn)
 {
-	return conn->request_buf[0] == 0;
+	__le32 *proto = (__le32 *)smb2_get_msg(conn->request_buf);
+
+	if (*proto == SMB2_COMPRESSION_TRANSFORM_ID) {
+		pr_err_ratelimited("smb2 compression not support yet");
+		return false;
+	}
+
+	if (*proto != SMB1_PROTO_NUMBER &&
+	    *proto != SMB2_PROTO_NUMBER &&
+	    *proto != SMB2_TRANSFORM_PROTO_NUM)
+		return false;
+
+	return true;
 }
 
 static bool supported_protocol(int idx)
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index e74fda212620..ee2cde07264b 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -285,6 +285,14 @@ void nilfs_btnode_abort_change_key(struct address_space *btnc,
 	if (nbh == NULL) {	/* blocksize == pagesize */
 		xa_erase_irq(&btnc->i_pages, newkey);
 		unlock_page(ctxt->bh->b_page);
-	} else
-		brelse(nbh);
+	} else {
+		/*
+		 * When canceling a buffer that a prepare operation has
+		 * allocated to copy a node block to another location, use
+		 * nilfs_btnode_delete() to initialize and release the buffer
+		 * so that the buffer flags will not be in an inconsistent
+		 * state when it is reallocated.
+		 */
+		nilfs_btnode_delete(nbh);
+	}
 }
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index dc359b56fdfa..2c6078a6b8ec 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -779,6 +779,15 @@ int nilfs_sufile_resize(struct inode *sufile, __u64 newnsegs)
 			goto out_header;
 
 		sui->ncleansegs -= nsegs - newnsegs;
+
+		/*
+		 * If the sufile is successfully truncated, immediately adjust
+		 * the segment allocation space while locking the semaphore
+		 * "mi_sem" so that nilfs_sufile_alloc() never allocates
+		 * segments in the truncated space.
+		 */
+		sui->allocmax = newnsegs - 1;
+		sui->allocmin = 0;
 	}
 
 	kaddr = kmap_atomic(header_bh->b_page);
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 2894152a6b25..0f0667957c81 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -405,6 +405,18 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 				  100));
 }
 
+/**
+ * nilfs_max_segment_count - calculate the maximum number of segments
+ * @nilfs: nilfs object
+ */
+static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
+{
+	u64 max_count = U64_MAX;
+
+	do_div(max_count, nilfs->ns_blocks_per_segment);
+	return min_t(u64, max_count, ULONG_MAX);
+}
+
 void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 {
 	nilfs->ns_nsegments = nsegs;
@@ -414,6 +426,8 @@ void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_err(nilfs->ns_sb,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -457,7 +471,34 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		return -EINVAL;
 	}
 
-	nilfs_set_nsegments(nilfs, le64_to_cpu(sbp->s_nsegments));
+	nsegments = le64_to_cpu(sbp->s_nsegments);
+	if (nsegments > nilfs_max_segment_count(nilfs)) {
+		nilfs_err(nilfs->ns_sb,
+			  "segment count %llu exceeds upper limit (%llu segments)",
+			  (unsigned long long)nsegments,
+			  (unsigned long long)nilfs_max_segment_count(nilfs));
+		return -EINVAL;
+	}
+
+	nblocks = sb_bdev_nr_blocks(nilfs->ns_sb);
+	if (nblocks) {
+		u64 min_block_count = nsegments * nilfs->ns_blocks_per_segment;
+		/*
+		 * To avoid failing to mount early device images without a
+		 * second superblock, exclude that block count from the
+		 * "min_block_count" calculation.
+		 */
+
+		if (nblocks < min_block_count) {
+			nilfs_err(nilfs->ns_sb,
+				  "total number of segment blocks %llu exceeds device size (%llu blocks)",
+				  (unsigned long long)min_block_count,
+				  (unsigned long long)nblocks);
+			return -EINVAL;
+		}
+	}
+
+	nilfs_set_nsegments(nilfs, nsegments);
 	nilfs->ns_crc_seed = le32_to_cpu(sbp->s_crc_seed);
 	return 0;
 }
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 4d78e0979517..cae410568bb2 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2100,14 +2100,20 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
 	struct ocfs2_space_resv sr;
 	int change_size = 1;
 	int cmd = OCFS2_IOC_RESVSP64;
+	int ret = 0;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 	if (!ocfs2_writes_unwritten_extents(osb))
 		return -EOPNOTSUPP;
 
-	if (mode & FALLOC_FL_KEEP_SIZE)
+	if (mode & FALLOC_FL_KEEP_SIZE) {
 		change_size = 0;
+	} else {
+		ret = inode_newsize_ok(inode, offset + len);
+		if (ret)
+			return ret;
+	}
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		cmd = OCFS2_IOC_UNRESVSP64;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 0b0e6a132101..988d1c076861 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -952,8 +952,10 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
 	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
 		if (!sb_has_quota_loaded(sb, type))
 			continue;
-		oinfo = sb_dqinfo(sb, type)->dqi_priv;
-		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+		if (!sb_has_quota_suspended(sb, type)) {
+			oinfo = sb_dqinfo(sb, type)->dqi_priv;
+			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+		}
 		inode = igrab(sb->s_dquot.files[type]);
 		/* Turn off quotas. This will remove all dquot structures from
 		 * memory and so they will be automatically synced to global
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index fff61e6d6d4d..3660ce6a9349 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1230,6 +1230,18 @@ static inline u16 mlx5_core_max_vfs(const struct mlx5_core_dev *dev)
 	return dev->priv.sriov.max_vfs;
 }
 
+static inline int mlx5_lag_is_lacp_owner(struct mlx5_core_dev *dev)
+{
+	/* LACP owner conditions:
+	 * 1) Function is physical.
+	 * 2) LAG is supported by FW.
+	 * 3) LAG is managed by driver (currently the only option).
+	 */
+	return  MLX5_CAP_GEN(dev, vport_group_manager) &&
+		   (MLX5_CAP_GEN(dev, num_lag_ports) > 1) &&
+		    MLX5_CAP_GEN(dev, lag_master);
+}
+
 static inline int mlx5_get_gid_table_len(u16 param)
 {
 	if (param > 4) {
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index bc2fb8343a94..af093281e335 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -57,9 +57,6 @@ struct llcc_slice_desc {
 /**
  * struct llcc_edac_reg_data - llcc edac registers data for each error type
  * @name: Name of the error
- * @synd_reg: Syndrome register address
- * @count_status_reg: Status register address to read the error count
- * @ways_status_reg: Status register address to read the error ways
  * @reg_cnt: Number of registers
  * @count_mask: Mask value to get the error count
  * @ways_mask: Mask value to get the error ways
@@ -68,9 +65,6 @@ struct llcc_slice_desc {
  */
 struct llcc_edac_reg_data {
 	char *name;
-	u64 synd_reg;
-	u64 count_status_reg;
-	u64 ways_status_reg;
 	u32 reg_cnt;
 	u32 count_mask;
 	u32 ways_mask;
@@ -108,7 +102,7 @@ struct llcc_edac_reg_offset {
 
 /**
  * struct llcc_drv_data - Data associated with the llcc driver
- * @regmap: regmap associated with the llcc device
+ * @regmaps: regmaps associated with the llcc device
  * @bcast_regmap: regmap associated with llcc broadcast offset
  * @cfg: pointer to the data structure for slice configuration
  * @edac_reg_offset: Offset of the LLCC EDAC registers
@@ -117,12 +111,11 @@ struct llcc_edac_reg_offset {
  * @max_slices: max slices as read from device tree
  * @num_banks: Number of llcc banks
  * @bitmap: Bit map to track the active slice ids
- * @offsets: Pointer to the bank offsets array
  * @ecc_irq: interrupt for llcc cache error detection and reporting
  * @version: Indicates the LLCC version
  */
 struct llcc_drv_data {
-	struct regmap *regmap;
+	struct regmap **regmaps;
 	struct regmap *bcast_regmap;
 	const struct llcc_slice_config *cfg;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
@@ -131,7 +124,6 @@ struct llcc_drv_data {
 	u32 max_slices;
 	u32 num_banks;
 	unsigned long *bitmap;
-	u32 *offsets;
 	int ecc_irq;
 	u32 version;
 };
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 94a1599824d8..794e45981891 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -336,8 +336,6 @@ void neigh_table_init(int index, struct neigh_table *tbl);
 int neigh_table_clear(int index, struct neigh_table *tbl);
 struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 			       struct net_device *dev);
-struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
-				     const void *pkey);
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
 				 struct net_device *dev, bool want_ref);
 static inline struct neighbour *neigh_create(struct neigh_table *tbl,
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index a1ccf1276f3e..22e96b7e1b44 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -457,7 +457,8 @@ struct nft_set_ops {
 					       const struct nft_set *set,
 					       const struct nft_set_elem *elem,
 					       unsigned int flags);
-
+	void				(*commit)(const struct nft_set *set);
+	void				(*abort)(const struct nft_set *set);
 	u64				(*privsize)(const struct nlattr * const nla[],
 						    const struct nft_set_desc *desc);
 	bool				(*estimate)(const struct nft_set_desc *desc,
@@ -552,6 +553,7 @@ struct nft_set {
 	u16				policy;
 	u16				udlen;
 	unsigned char			*udata;
+	struct list_head		pending_update;
 	/* runtime data below here */
 	const struct nft_set_ops	*ops ____cacheline_aligned;
 	u16				flags:14,
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 989eb972fcae..b3e312840296 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -137,6 +137,13 @@ static inline void qdisc_refcount_inc(struct Qdisc *qdisc)
 	refcount_inc(&qdisc->refcnt);
 }
 
+static inline bool qdisc_refcount_dec_if_one(struct Qdisc *qdisc)
+{
+	if (qdisc->flags & TCQ_F_BUILTIN)
+		return true;
+	return refcount_dec_if_one(&qdisc->refcnt);
+}
+
 /* Intended to be used by unlocked users, when concurrent qdisc release is
  * possible.
  */
@@ -650,6 +657,7 @@ void dev_deactivate_many(struct list_head *head);
 struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 			      struct Qdisc *qdisc);
 void qdisc_reset(struct Qdisc *qdisc);
+void qdisc_destroy(struct Qdisc *qdisc);
 void qdisc_put(struct Qdisc *qdisc);
 void qdisc_put_unlocked(struct Qdisc *qdisc);
 void qdisc_tree_reduce_backlog(struct Qdisc *qdisc, int n, int len);
diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index d808dc3d239e..811a0f11d0db 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -194,29 +194,6 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 		return 0;
 }
 
-static inline int iboe_get_rate(struct net_device *dev)
-{
-	struct ethtool_link_ksettings cmd;
-	int err;
-
-	rtnl_lock();
-	err = __ethtool_get_link_ksettings(dev, &cmd);
-	rtnl_unlock();
-	if (err)
-		return IB_RATE_PORT_CURRENT;
-
-	if (cmd.base.speed >= 40000)
-		return IB_RATE_40_GBPS;
-	else if (cmd.base.speed >= 30000)
-		return IB_RATE_30_GBPS;
-	else if (cmd.base.speed >= 20000)
-		return IB_RATE_20_GBPS;
-	else if (cmd.base.speed >= 10000)
-		return IB_RATE_10_GBPS;
-	else
-		return IB_RATE_PORT_CURRENT;
-}
-
 static inline int rdma_link_local_addr(struct in6_addr *addr)
 {
 	if (addr->s6_addr32[0] == htonl(0xfe800000) &&
diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index b38fd25c5729..528279056b3a 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -170,6 +170,7 @@ struct snd_soc_acpi_link_adr {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	u8 id[ACPI_ID_LEN];
+	const char *uid;
 	const struct snd_soc_acpi_codecs *comp_ids;
 	const u32 link_mask;
 	const struct snd_soc_acpi_link_adr *links;
diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 5b689c663290..27a5642f07cd 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -125,6 +125,10 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream);
 
+/* can this BE perform prepare */
+int snd_soc_dpcm_can_be_prepared(struct snd_soc_pcm_runtime *fe,
+				 struct snd_soc_pcm_runtime *be, int stream);
+
 /* is the current PCM operation for this FE ? */
 int snd_soc_dpcm_fe_can_update(struct snd_soc_pcm_runtime *fe, int stream);
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index bb57084ac524..69f5bec347c2 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -761,7 +761,7 @@ enum {
 
 	/* add new constants above here */
 	__ETHTOOL_A_STATS_GRP_CNT,
-	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_CNT - 1)
+	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_GRP_CNT - 1)
 };
 
 enum {
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index eb2747d58a81..51c13cf9c5ae 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -635,6 +635,7 @@ enum {
 	TCA_INGRESS_BLOCK,
 	TCA_EGRESS_BLOCK,
 	TCA_DUMP_FLAGS,
+	TCA_EXT_WARN_MSG,
 	__TCA_MAX
 };
 
@@ -788,6 +789,7 @@ enum {
 	TCA_ROOT_FLAGS,
 	TCA_ROOT_COUNT,
 	TCA_ROOT_TIME_DELTA, /* in msecs */
+	TCA_ROOT_EXT_WARN_MSG,
 	__TCA_ROOT_MAX,
 #define	TCA_ROOT_MAX (__TCA_ROOT_MAX - 1)
 };
diff --git a/io_uring/net.c b/io_uring/net.c
index f6d8b02387a9..05792a689994 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -65,6 +65,7 @@ struct io_sr_msg {
 	u16				addr_len;
 	u16				buf_group;
 	void __user			*addr;
+	void __user			*msg_control;
 	/* used only for send zerocopy */
 	struct io_kiocb 		*notif;
 };
@@ -182,11 +183,15 @@ static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 			       struct io_async_msghdr *iomsg)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+	int ret;
 
 	iomsg->msg.msg_name = &iomsg->addr;
 	iomsg->free_iov = iomsg->fast_iov;
-	return sendmsg_copy_msghdr(&iomsg->msg, sr->umsg, sr->msg_flags,
+	ret = sendmsg_copy_msghdr(&iomsg->msg, sr->umsg, sr->msg_flags,
 					&iomsg->free_iov);
+	/* save msg_control as sys_sendmsg() overwrites it */
+	sr->msg_control = iomsg->msg.msg_control;
+	return ret;
 }
 
 int io_send_prep_async(struct io_kiocb *req)
@@ -284,6 +289,7 @@ int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (req_has_async_data(req)) {
 		kmsg = req->async_data;
+		kmsg->msg.msg_control = sr->msg_control;
 	} else {
 		ret = io_sendmsg_copy_hdr(req, &iomsg);
 		if (ret)
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 559652380672..6ffa5cf1bbb8 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -256,9 +256,13 @@ static int io_sq_thread(void *data)
 			sqt_spin = true;
 
 		if (sqt_spin || !time_after(jiffies, timeout)) {
-			cond_resched();
 			if (sqt_spin)
 				timeout = jiffies + sqd->sq_thread_idle;
+			if (unlikely(need_resched())) {
+				mutex_unlock(&sqd->lock);
+				cond_resched();
+				mutex_lock(&sqd->lock);
+			}
 			continue;
 		}
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 819f011f0a9c..b86b907e566c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -173,11 +173,11 @@ void bpf_cgroup_atype_put(int cgroup_atype)
 {
 	int i = cgroup_atype - CGROUP_LSM_START;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (--cgroup_lsm_atype[i].refcnt <= 0)
 		cgroup_lsm_atype[i].attach_btf_id = 0;
 	WARN_ON_ONCE(cgroup_lsm_atype[i].refcnt < 0);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 #else
 static enum cgroup_bpf_attach_type
@@ -282,7 +282,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 
 	unsigned int atype;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
 		struct hlist_head *progs = &cgrp->bpf.progs[atype];
@@ -315,7 +315,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		bpf_cgroup_storage_free(storage);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -729,9 +729,9 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -831,7 +831,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 
 	cg_link = container_of(link, struct bpf_cgroup_link, link);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	/* link might have been auto-released by dying cgroup, so fail */
 	if (!cg_link->cgroup) {
 		ret = -ENOLINK;
@@ -843,7 +843,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 	}
 	ret = __cgroup_bpf_replace(cg_link->cgroup, cg_link, new_prog);
 out_unlock:
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1009,9 +1009,9 @@ static int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_detach(cgrp, prog, NULL, type);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1120,9 +1120,9 @@ static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_query(cgrp, attr, uattr);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1189,11 +1189,11 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	if (!cg_link->cgroup)
 		return;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/* re-check cgroup under lock again */
 	if (!cg_link->cgroup) {
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 		return;
 	}
 
@@ -1205,7 +1205,7 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	cg = cg_link->cgroup;
 	cg_link->cgroup = NULL;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	cgroup_put(cg);
 }
@@ -1232,10 +1232,10 @@ static void bpf_cgroup_link_show_fdinfo(const struct bpf_link *link,
 		container_of(link, struct bpf_cgroup_link, link);
 	u64 cg_id = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (cg_link->cgroup)
 		cg_id = cgroup_id(cg_link->cgroup);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	seq_printf(seq,
 		   "cgroup_id:\t%llu\n"
@@ -1251,10 +1251,10 @@ static int bpf_cgroup_link_fill_link_info(const struct bpf_link *link,
 		container_of(link, struct bpf_cgroup_link, link);
 	u64 cg_id = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (cg_link->cgroup)
 		cg_id = cgroup_id(cg_link->cgroup);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	info->cgroup.cgroup_id = cg_id;
 	info->cgroup.attach_type = cg_link->type;
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index c187a9e62bdb..d57ccb02477f 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -58,7 +58,7 @@ static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct cgroup_iter_priv *p = seq->private;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/* cgroup_iter doesn't support read across multiple sessions. */
 	if (*pos > 0) {
@@ -89,7 +89,7 @@ static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
 {
 	struct cgroup_iter_priv *p = seq->private;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	/* pass NULL to the prog for post-processing */
 	if (!v) {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 098cf336fae6..f01ca6f1ee03 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -333,14 +333,14 @@ static void cgroup_storage_map_free(struct bpf_map *_map)
 	struct list_head *storages = &map->list;
 	struct bpf_cgroup_storage *storage, *stmp;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	list_for_each_entry_safe(storage, stmp, storages, list_map) {
 		bpf_cgroup_storage_unlink(storage);
 		bpf_cgroup_storage_free(storage);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	WARN_ON(!RB_EMPTY_ROOT(&map->root));
 	WARN_ON(!list_empty(&map->list));
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 52bb5a74a23b..5407241dbb45 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -58,7 +58,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	struct cgroup_root *root;
 	int retval = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	cgroup_attach_lock(true);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
@@ -72,7 +72,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 			break;
 	}
 	cgroup_attach_unlock(true);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	return retval;
 }
@@ -106,9 +106,9 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	if (ret)
 		return ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	cgroup_attach_lock(true);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -144,8 +144,8 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	percpu_up_write(&cgroup_threadgroup_rwsem);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_attach_unlock(true);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -847,13 +847,13 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 	kernfs_break_active_protection(new_parent);
 	kernfs_break_active_protection(kn);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	ret = kernfs_rename(kn, new_parent, new_name_str);
 	if (!ret)
 		TRACE_CGROUP_PATH(rename, cgrp);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	kernfs_unbreak_active_protection(kn);
 	kernfs_unbreak_active_protection(new_parent);
@@ -1119,7 +1119,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	trace_cgroup_remount(root);
 
  out_unlock:
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1246,7 +1246,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	if (!ret && !percpu_ref_tryget_live(&ctx->root->cgrp.self.refcnt))
 		ret = 1;	/* restart */
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	if (!ret)
 		ret = cgroup_do_get_tree(fc);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2319946715e0..36c95626afec 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1385,7 +1385,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	cgroup_favor_dynmods(root, false);
 	cgroup_exit_root_id(root);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	cgroup_rstat_exit(cgrp);
 	kernfs_destroy_root(root->kf_root);
@@ -1619,7 +1619,7 @@ void cgroup_kn_unlock(struct kernfs_node *kn)
 	else
 		cgrp = kn->parent->priv;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	kernfs_unbreak_active_protection(kn);
 	cgroup_put(cgrp);
@@ -1664,7 +1664,7 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 	if (drain_offline)
 		cgroup_lock_and_drain_offline(cgrp);
 	else
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 
 	if (!cgroup_is_dead(cgrp))
 		return cgrp;
@@ -2161,13 +2161,13 @@ int cgroup_do_get_tree(struct fs_context *fc)
 		struct super_block *sb = fc->root->d_sb;
 		struct cgroup *cgrp;
 
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 		spin_lock_irq(&css_set_lock);
 
 		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
 
 		spin_unlock_irq(&css_set_lock);
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 
 		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
 		dput(fc->root);
@@ -2350,13 +2350,13 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
 
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	return ret;
 }
@@ -2382,7 +2382,7 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 	int hierarchy_id = 1;
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	root = idr_get_next(&cgroup_hierarchy_idr, &hierarchy_id);
@@ -2396,7 +2396,7 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 	}
 
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(task_cgroup_path);
@@ -3107,7 +3107,7 @@ void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
 	int ssid;
 
 restart:
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	cgroup_for_each_live_descendant_post(dsct, d_css, cgrp) {
 		for_each_subsys(ss, ssid) {
@@ -3121,7 +3121,7 @@ void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
 			prepare_to_wait(&dsct->offline_waitq, &wait,
 					TASK_UNINTERRUPTIBLE);
 
-			mutex_unlock(&cgroup_mutex);
+			cgroup_unlock();
 			schedule();
 			finish_wait(&dsct->offline_waitq, &wait);
 
@@ -4370,9 +4370,9 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 	if (!(cfts[0].flags & __CFTYPE_ADDED))
 		return -ENOENT;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = cgroup_rm_cftypes_locked(cfts);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -4404,14 +4404,14 @@ static int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 	if (ret)
 		return ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	list_add_tail(&cfts->node, &ss->cfts);
 	ret = cgroup_apply_cftypes(cfts, true);
 	if (ret)
 		cgroup_rm_cftypes_locked(cfts);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -5380,7 +5380,7 @@ static void css_release_work_fn(struct work_struct *work)
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	css->flags |= CSS_RELEASED;
 	list_del_rcu(&css->sibling);
@@ -5421,7 +5421,7 @@ static void css_release_work_fn(struct work_struct *work)
 					 NULL);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
@@ -5769,7 +5769,7 @@ static void css_killed_work_fn(struct work_struct *work)
 	struct cgroup_subsys_state *css =
 		container_of(work, struct cgroup_subsys_state, destroy_work);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	do {
 		offline_css(css);
@@ -5778,7 +5778,7 @@ static void css_killed_work_fn(struct work_struct *work)
 		css = css->parent;
 	} while (css && atomic_dec_and_test(&css->online_cnt));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 
 /* css kill confirmation processing requires process context, bounce */
@@ -5962,7 +5962,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	pr_debug("Initializing cgroup subsys %s\n", ss->name);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	idr_init(&ss->css_idr);
 	INIT_LIST_HEAD(&ss->cfts);
@@ -6006,7 +6006,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	BUG_ON(online_css(css));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 
 /**
@@ -6066,7 +6066,7 @@ int __init cgroup_init(void)
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/*
 	 * Add init_css_set to the hash table so that dfl_root can link to
@@ -6077,7 +6077,7 @@ int __init cgroup_init(void)
 
 	BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	for_each_subsys(ss, ssid) {
 		if (ss->early_init) {
@@ -6129,9 +6129,9 @@ int __init cgroup_init(void)
 		if (ss->bind)
 			ss->bind(init_css_set.subsys[ssid]);
 
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 		css_populate_dir(init_css_set.subsys[ssid]);
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 	}
 
 	/* init_css_set.subsys[] has been updated, re-hash */
@@ -6236,7 +6236,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	for_each_root(root) {
@@ -6291,7 +6291,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	retval = 0;
 out_unlock:
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	kfree(buf);
 out:
 	return retval;
@@ -6375,7 +6375,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	struct file *f;
 
 	if (kargs->flags & CLONE_INTO_CGROUP)
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 
 	cgroup_threadgroup_change_begin(current);
 
@@ -6450,7 +6450,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 
 err:
 	cgroup_threadgroup_change_end(current);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	if (f)
 		fput(f);
 	if (dst_cgrp)
@@ -6471,19 +6471,18 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
-	cgroup_threadgroup_change_end(current);
-
-	if (kargs->flags & CLONE_INTO_CGROUP) {
-		struct cgroup *cgrp = kargs->cgrp;
-		struct css_set *cset = kargs->cset;
+	struct cgroup *cgrp = kargs->cgrp;
+	struct css_set *cset = kargs->cset;
 
-		mutex_unlock(&cgroup_mutex);
+	cgroup_threadgroup_change_end(current);
 
-		if (cset) {
-			put_css_set(cset);
-			kargs->cset = NULL;
-		}
+	if (cset) {
+		put_css_set(cset);
+		kargs->cset = NULL;
+	}
 
+	if (kargs->flags & CLONE_INTO_CGROUP) {
+		cgroup_unlock();
 		if (cgrp) {
 			cgroup_put(cgrp);
 			kargs->cgrp = NULL;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..6d787ae9deca 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -898,10 +898,22 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		}
 
 		offset = ALIGN(offset, align);
+
+		/*
+		 * Check if the segment contains the entry point, if so,
+		 * calculate the value of image->start based on it.
+		 * If the compiler has produced more than one .text section
+		 * (Eg: .text.hot), they are generally after the main .text
+		 * section, and they shall not be used to calculate
+		 * image->start. So do not re-calculate image->start if it
+		 * is not set to the initial value, and warn the user so they
+		 * have a chance to fix their purgatory's linker script.
+		 */
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size)) {
+					 + sechdrs[i].sh_size) &&
+		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
 		}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ce34ca0b5b98..d03122f90cc4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3099,6 +3099,18 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!krcp->head;
 }
 
+static bool
+need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krwp->bkvhead_free[i])
+			return true;
+
+	return !!krwp->head_free;
+}
+
 static void
 schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 {
@@ -3130,14 +3142,13 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
 		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
 
-		// Try to detach bkvhead or head and attach it over any
-		// available corresponding free channel. It can be that
-		// a previous RCU batch is in progress, it means that
-		// immediately to queue another one is not possible so
-		// in that case the monitor work is rearmed.
-		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
-			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
-				(krcp->head && !krwp->head_free)) {
+		// Try to detach bulk_head or head and attach it, only when
+		// all channels are free.  Any channel is not free means at krwp
+		// there is on-going rcu work to handle krwp's free business.
+		if (need_wait_for_krwp_work(krwp))
+			continue;
+
+		if (need_offload_krc(krcp)) {
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 7f165c517338..13d3fa6aa972 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
+#include <linux/kstrtox.h>
 #include <linux/kthread.h>
 #include <linux/vmalloc.h>
 #include <linux/efi_embedded_fw.h>
@@ -359,16 +360,26 @@ static ssize_t config_test_show_str(char *dst,
 	return len;
 }
 
-static int test_dev_config_update_bool(const char *buf, size_t size,
+static inline int __test_dev_config_update_bool(const char *buf, size_t size,
 				       bool *cfg)
 {
 	int ret;
 
-	mutex_lock(&test_fw_mutex);
-	if (strtobool(buf, cfg) < 0)
+	if (kstrtobool(buf, cfg) < 0)
 		ret = -EINVAL;
 	else
 		ret = size;
+
+	return ret;
+}
+
+static int test_dev_config_update_bool(const char *buf, size_t size,
+				       bool *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_bool(buf, size, cfg);
 	mutex_unlock(&test_fw_mutex);
 
 	return ret;
@@ -379,7 +390,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_size_t(const char *buf,
+static int __test_dev_config_update_size_t(
+					 const char *buf,
 					 size_t size,
 					 size_t *cfg)
 {
@@ -390,9 +402,7 @@ static int test_dev_config_update_size_t(const char *buf,
 	if (ret)
 		return ret;
 
-	mutex_lock(&test_fw_mutex);
 	*(size_t *)cfg = new;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
@@ -408,7 +418,7 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
 	u8 val;
 	int ret;
@@ -417,14 +427,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 	if (ret)
 		return ret;
 
-	mutex_lock(&test_fw_mutex);
 	*(u8 *)cfg = val;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
 }
 
+static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_u8(buf, size, cfg);
+	mutex_unlock(&test_fw_mutex);
+
+	return ret;
+}
+
 static ssize_t test_dev_config_show_u8(char *buf, u8 val)
 {
 	return snprintf(buf, PAGE_SIZE, "%u\n", val);
@@ -477,10 +496,10 @@ static ssize_t config_num_requests_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_u8(buf, count,
-				       &test_fw_config->num_requests);
+	rc = __test_dev_config_update_u8(buf, count,
+					 &test_fw_config->num_requests);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -524,10 +543,10 @@ static ssize_t config_buf_size_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->buf_size);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->buf_size);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -554,10 +573,10 @@ static ssize_t config_file_offset_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->file_offset);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->file_offset);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
diff --git a/mm/zswap.c b/mm/zswap.c
index 708b82dbe8a4..b3829ada4a41 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1138,9 +1138,16 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		goto reject;
 	}
 
+	/*
+	 * XXX: zswap reclaim does not work with cgroups yet. Without a
+	 * cgroup-aware entry LRU, we will push out entries system-wide based on
+	 * local cgroup limits.
+	 */
 	objcg = get_obj_cgroup_from_page(page);
-	if (objcg && !obj_cgroup_may_zswap(objcg))
-		goto shrink;
+	if (objcg && !obj_cgroup_may_zswap(objcg)) {
+		ret = -ENOMEM;
+		goto reject;
+	}
 
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index bf081f62ae58..6c0f2149f2c7 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -627,37 +627,6 @@ struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 }
 EXPORT_SYMBOL(neigh_lookup);
 
-struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
-				     const void *pkey)
-{
-	struct neighbour *n;
-	unsigned int key_len = tbl->key_len;
-	u32 hash_val;
-	struct neigh_hash_table *nht;
-
-	NEIGH_CACHE_STAT_INC(tbl, lookups);
-
-	rcu_read_lock_bh();
-	nht = rcu_dereference_bh(tbl->nht);
-	hash_val = tbl->hash(pkey, NULL, nht->hash_rnd) >> (32 - nht->hash_shift);
-
-	for (n = rcu_dereference_bh(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference_bh(n->next)) {
-		if (!memcmp(n->primary_key, pkey, key_len) &&
-		    net_eq(dev_net(n->dev), net)) {
-			if (!refcount_inc_not_zero(&n->refcnt))
-				n = NULL;
-			NEIGH_CACHE_STAT_INC(tbl, hits);
-			break;
-		}
-	}
-
-	rcu_read_unlock_bh();
-	return n;
-}
-EXPORT_SYMBOL(neigh_lookup_nodev);
-
 static struct neighbour *
 ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		struct net_device *dev, u32 flags,
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 808983bc2ec9..4651aaf70db4 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -114,7 +114,8 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	addr_type = ipv6_addr_type(daddr);
 	if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
 	    (addr_type & IPV6_ADDR_MAPPED) ||
-	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if))
+	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
+	     l3mdev_master_ifindex_by_index(sock_net(sk), oif) != sk->sk_bound_dev_if))
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, np);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 06b9df2fbcd7..23a44edcb11f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4732,11 +4732,16 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
 				   unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	int res;
 
 	if (wdev->use_4addr)
 		return -EOPNOTSUPP;
 
-	return ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_lock(&sdata->local->mtx);
+	res = ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_unlock(&sdata->local->mtx);
+
+	return res;
 }
 
 static void ieee80211_del_intf_link(struct wiphy *wiphy,
@@ -4745,7 +4750,9 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
+	mutex_lock(&sdata->local->mtx);
 	ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_unlock(&sdata->local->mtx);
 }
 
 static int sta_add_link_station(struct ieee80211_local *local,
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index a1b3031fefce..a85b44c1bc99 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -2,7 +2,7 @@
 /*
  * MLO link handling
  *
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -387,6 +387,7 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 						 IEEE80211_CHANCTX_SHARED);
 		WARN_ON_ONCE(ret);
 
+		ieee80211_mgd_set_link_qos_params(link);
 		ieee80211_link_info_change_notify(sdata, link,
 						  BSS_CHANGED_ERP_CTS_PROT |
 						  BSS_CHANGED_ERP_PREAMBLE |
@@ -401,7 +402,6 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 						  BSS_CHANGED_TWT |
 						  BSS_CHANGED_HE_OBSS_PD |
 						  BSS_CHANGED_HE_BSS_COLOR);
-		ieee80211_mgd_set_link_qos_params(link);
 	}
 
 	old_active = sdata->vif.active_links;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 437891cb8c41..13d4913266b4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3669,7 +3669,8 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	if (flow)
 		nft_flow_rule_destroy(flow);
 err_release_rule:
-	nf_tables_rule_release(&ctx, rule);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE);
+	nf_tables_rule_destroy(&ctx, rule);
 err_release_expr:
 	for (i = 0; i < n; i++) {
 		if (expr_info[i].ops) {
@@ -4730,6 +4731,7 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 
 	set->num_exprs = num_exprs;
 	set->handle = nf_tables_alloc_handle(table);
+	INIT_LIST_HEAD(&set->pending_update);
 
 	err = nft_trans_set_add(&ctx, NFT_MSG_NEWSET, set);
 	if (err < 0)
@@ -8992,10 +8994,25 @@ static void nf_tables_commit_audit_log(struct list_head *adl, u32 generation)
 	}
 }
 
+static void nft_set_commit_update(struct list_head *set_update_list)
+{
+	struct nft_set *set, *next;
+
+	list_for_each_entry_safe(set, next, set_update_list, pending_update) {
+		list_del_init(&set->pending_update);
+
+		if (!set->ops->commit)
+			continue;
+
+		set->ops->commit(set);
+	}
+}
+
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct nft_trans *trans, *next;
+	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
@@ -9154,6 +9171,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nf_tables_setelem_notify(&trans->ctx, te->set,
 						 &te->elem,
 						 NFT_MSG_NEWSETELEM);
+			if (te->set->ops->commit &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELSETELEM:
@@ -9167,6 +9189,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 				atomic_dec(&te->set->nelems);
 				te->set->ndeact--;
 			}
+			if (te->set->ops->commit &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			break;
 		case NFT_MSG_NEWOBJ:
 			if (nft_trans_obj_update(trans)) {
@@ -9227,6 +9254,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		}
 	}
 
+	nft_set_commit_update(&set_update_list);
+
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
 	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
@@ -9283,10 +9312,25 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 	kfree(trans);
 }
 
+static void nft_set_abort_update(struct list_head *set_update_list)
+{
+	struct nft_set *set, *next;
+
+	list_for_each_entry_safe(set, next, set_update_list, pending_update) {
+		list_del_init(&set->pending_update);
+
+		if (!set->ops->abort)
+			continue;
+
+		set->ops->abort(set);
+	}
+}
+
 static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct nft_trans *trans, *next;
+	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
 
 	if (action == NFNL_ABORT_VALIDATE &&
@@ -9384,6 +9428,12 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			nft_setelem_remove(net, te->set, &te->elem);
 			if (!nft_setelem_is_catchall(te->set, &te->elem))
 				atomic_dec(&te->set->nelems);
+
+			if (te->set->ops->abort &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			break;
 		case NFT_MSG_DELSETELEM:
 			te = (struct nft_trans_elem *)trans->data;
@@ -9393,6 +9443,11 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			if (!nft_setelem_is_catchall(te->set, &te->elem))
 				te->set->ndeact--;
 
+			if (te->set->ops->abort &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWOBJ:
@@ -9433,6 +9488,8 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		}
 	}
 
+	nft_set_abort_update(&set_update_list);
+
 	synchronize_rcu();
 
 	list_for_each_entry_safe_reverse(trans, next,
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index ae7146475d17..c9fbe0f707b5 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -533,7 +533,8 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 * processed, this avoids that the same error is
 			 * reported several times when replaying the batch.
 			 */
-			if (nfnl_err_add(&err_list, nlh, err, &extack) < 0) {
+			if (err == -ENOMEM ||
+			    nfnl_err_add(&err_list, nlh, err, &extack) < 0) {
 				/* We failed to enqueue an error, reset the
 				 * list of errors and send OOM to userspace
 				 * pointing to the batch header.
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 06d46d182634..15e451dc3fc4 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1600,17 +1600,10 @@ static void pipapo_free_fields(struct nft_pipapo_match *m)
 	}
 }
 
-/**
- * pipapo_reclaim_match - RCU callback to free fields from old matching data
- * @rcu:	RCU head
- */
-static void pipapo_reclaim_match(struct rcu_head *rcu)
+static void pipapo_free_match(struct nft_pipapo_match *m)
 {
-	struct nft_pipapo_match *m;
 	int i;
 
-	m = container_of(rcu, struct nft_pipapo_match, rcu);
-
 	for_each_possible_cpu(i)
 		kfree(*per_cpu_ptr(m->scratch, i));
 
@@ -1625,7 +1618,19 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
 }
 
 /**
- * pipapo_commit() - Replace lookup data with current working copy
+ * pipapo_reclaim_match - RCU callback to free fields from old matching data
+ * @rcu:	RCU head
+ */
+static void pipapo_reclaim_match(struct rcu_head *rcu)
+{
+	struct nft_pipapo_match *m;
+
+	m = container_of(rcu, struct nft_pipapo_match, rcu);
+	pipapo_free_match(m);
+}
+
+/**
+ * nft_pipapo_commit() - Replace lookup data with current working copy
  * @set:	nftables API set representation
  *
  * While at it, check if we should perform garbage collection on the working
@@ -1635,7 +1640,7 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
  * We also need to create a new working copy for subsequent insertions and
  * deletions.
  */
-static void pipapo_commit(const struct nft_set *set)
+static void nft_pipapo_commit(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *new_clone, *old;
@@ -1660,6 +1665,26 @@ static void pipapo_commit(const struct nft_set *set)
 	priv->clone = new_clone;
 }
 
+static void nft_pipapo_abort(const struct nft_set *set)
+{
+	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *new_clone, *m;
+
+	if (!priv->dirty)
+		return;
+
+	m = rcu_dereference(priv->match);
+
+	new_clone = pipapo_clone(m);
+	if (IS_ERR(new_clone))
+		return;
+
+	priv->dirty = false;
+
+	pipapo_free_match(priv->clone);
+	priv->clone = new_clone;
+}
+
 /**
  * nft_pipapo_activate() - Mark element reference as active given key, commit
  * @net:	Network namespace
@@ -1667,8 +1692,7 @@ static void pipapo_commit(const struct nft_set *set)
  * @elem:	nftables API element representation containing key data
  *
  * On insertion, elements are added to a copy of the matching data currently
- * in use for lookups, and not directly inserted into current lookup data, so
- * we'll take care of that by calling pipapo_commit() here. Both
+ * in use for lookups, and not directly inserted into current lookup data. Both
  * nft_pipapo_insert() and nft_pipapo_activate() are called once for each
  * element, hence we can't purpose either one as a real commit operation.
  */
@@ -1684,8 +1708,6 @@ static void nft_pipapo_activate(const struct net *net,
 
 	nft_set_elem_change_active(net, set, &e->ext);
 	nft_set_elem_clear_busy(&e->ext);
-
-	pipapo_commit(set);
 }
 
 /**
@@ -1931,7 +1953,6 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		if (i == m->field_count) {
 			priv->dirty = true;
 			pipapo_drop(m, rulemap);
-			pipapo_commit(set);
 			return;
 		}
 
@@ -2230,6 +2251,8 @@ const struct nft_set_type nft_set_pipapo_type = {
 		.init		= nft_pipapo_init,
 		.destroy	= nft_pipapo_destroy,
 		.gc_init	= nft_pipapo_gc_init,
+		.commit		= nft_pipapo_commit,
+		.abort		= nft_pipapo_abort,
 		.elemsize	= offsetof(struct nft_pipapo_elem, ext),
 	},
 };
@@ -2252,6 +2275,8 @@ const struct nft_set_type nft_set_pipapo_avx2_type = {
 		.init		= nft_pipapo_init,
 		.destroy	= nft_pipapo_destroy,
 		.gc_init	= nft_pipapo_gc_init,
+		.commit		= nft_pipapo_commit,
+		.abort		= nft_pipapo_abort,
 		.elemsize	= offsetof(struct nft_pipapo_elem, ext),
 	},
 };
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9b31a10cc639..b33f88e50aa9 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1581,7 +1581,7 @@ int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
 
 static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 			u32 portid, u32 seq, u16 flags, int event, int bind,
-			int ref)
+			int ref, struct netlink_ext_ack *extack)
 {
 	struct tcamsg *t;
 	struct nlmsghdr *nlh;
@@ -1596,6 +1596,10 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 	t->tca__pad1 = 0;
 	t->tca__pad2 = 0;
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_ROOT_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nest = nla_nest_start_noflag(skb, TCA_ACT_TAB);
 	if (!nest)
 		goto out_nlmsg_trim;
@@ -1606,6 +1610,7 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 	nla_nest_end(skb, nest);
 
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -1624,7 +1629,7 @@ tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
 	if (!skb)
 		return -ENOBUFS;
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
-			 0, 1) <= 0) {
+			 0, 1, NULL) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
 		kfree_skb(skb);
 		return -EINVAL;
@@ -1798,7 +1803,7 @@ tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
 	if (!skb)
 		return -ENOBUFS;
 
-	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1) <= 0) {
+	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1, NULL) <= 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -1885,7 +1890,7 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 		return -ENOBUFS;
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
-			 0, 2) <= 0) {
+			 0, 2, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action attributes");
 		kfree_skb(skb);
 		return -EINVAL;
@@ -1964,7 +1969,7 @@ tcf_add_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 		return -ENOBUFS;
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_flags,
-			 RTM_NEWACTION, 0, 0) <= 0) {
+			 RTM_NEWACTION, 0, 0, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
 		kfree_skb(skb);
 		return -EINVAL;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 238759c3192e..180669aa9d09 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -13,7 +13,10 @@
 #include <linux/rtnetlink.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <linux/tc_act/tc_pedit.h>
@@ -312,11 +315,35 @@ static bool offset_valid(struct sk_buff *skb, int offset)
 	return true;
 }
 
-static int pedit_skb_hdr_offset(struct sk_buff *skb,
-				enum pedit_header_type htype, int *hoffset)
+static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int header_type)
 {
+	const int noff = skb_network_offset(skb);
 	int ret = -EINVAL;
+	struct iphdr _iph;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP): {
+		const struct iphdr *iph = skb_header_pointer(skb, noff, sizeof(_iph), &_iph);
 
+		if (!iph)
+			goto out;
+		*hoffset = noff + iph->ihl * 4;
+		ret = 0;
+		break;
+	}
+	case htons(ETH_P_IPV6):
+		ret = ipv6_find_hdr(skb, hoffset, header_type, NULL, NULL) == header_type ? 0 : -EINVAL;
+		break;
+	}
+out:
+	return ret;
+}
+
+static int pedit_skb_hdr_offset(struct sk_buff *skb,
+				 enum pedit_header_type htype, int *hoffset)
+{
+	int ret = -EINVAL;
+	/* 'htype' is validated in the netlink parsing */
 	switch (htype) {
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_ETH:
 		if (skb_mac_header_was_set(skb)) {
@@ -331,25 +358,26 @@ static int pedit_skb_hdr_offset(struct sk_buff *skb,
 		ret = 0;
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_TCP:
+		ret = pedit_l4_skb_offset(skb, hoffset, IPPROTO_TCP);
+		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_UDP:
-		if (skb_transport_header_was_set(skb)) {
-			*hoffset = skb_transport_offset(skb);
-			ret = 0;
-		}
+		ret = pedit_l4_skb_offset(skb, hoffset, IPPROTO_UDP);
 		break;
 	default:
-		ret = -EINVAL;
 		break;
 	}
-
 	return ret;
 }
 
 static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			 struct tcf_result *res)
 {
+	enum pedit_header_type htype = TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
+	enum pedit_cmd cmd = TCA_PEDIT_KEY_EX_CMD_SET;
 	struct tcf_pedit *p = to_pedit(a);
+	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
+	struct tc_pedit_key *tkey;
 	u32 max_offset;
 	int i;
 
@@ -365,88 +393,80 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
-	if (parms->tcfp_nkeys > 0) {
-		struct tc_pedit_key *tkey = parms->tcfp_keys;
-		struct tcf_pedit_key_ex *tkey_ex = parms->tcfp_keys_ex;
-		enum pedit_header_type htype =
-			TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
-		enum pedit_cmd cmd = TCA_PEDIT_KEY_EX_CMD_SET;
-
-		for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
-			u32 *ptr, hdata;
-			int offset = tkey->off;
-			int hoffset;
-			u32 val;
-			int rc;
-
-			if (tkey_ex) {
-				htype = tkey_ex->htype;
-				cmd = tkey_ex->cmd;
-
-				tkey_ex++;
-			}
+	tkey = parms->tcfp_keys;
+	tkey_ex = parms->tcfp_keys_ex;
 
-			rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
-			if (rc) {
-				pr_info("tc action pedit bad header type specified (0x%x)\n",
-					htype);
-				goto bad;
-			}
+	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int offset = tkey->off;
+		int hoffset = 0;
+		u32 *ptr, hdata;
+		u32 val;
+		int rc;
 
-			if (tkey->offmask) {
-				u8 *d, _d;
-
-				if (!offset_valid(skb, hoffset + tkey->at)) {
-					pr_info("tc action pedit 'at' offset %d out of bounds\n",
-						hoffset + tkey->at);
-					goto bad;
-				}
-				d = skb_header_pointer(skb, hoffset + tkey->at,
-						       sizeof(_d), &_d);
-				if (!d)
-					goto bad;
-				offset += (*d & tkey->offmask) >> tkey->shift;
-			}
+		if (tkey_ex) {
+			htype = tkey_ex->htype;
+			cmd = tkey_ex->cmd;
 
-			if (offset % 4) {
-				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
-				goto bad;
-			}
+			tkey_ex++;
+		}
 
-			if (!offset_valid(skb, hoffset + offset)) {
-				pr_info("tc action pedit offset %d out of bounds\n",
-					hoffset + offset);
-				goto bad;
-			}
+		rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
+		if (rc) {
+			pr_info_ratelimited("tc action pedit unable to extract header offset for header type (0x%x)\n", htype);
+			goto bad;
+		}
 
-			ptr = skb_header_pointer(skb, hoffset + offset,
-						 sizeof(hdata), &hdata);
-			if (!ptr)
-				goto bad;
-			/* just do it, baby */
-			switch (cmd) {
-			case TCA_PEDIT_KEY_EX_CMD_SET:
-				val = tkey->val;
-				break;
-			case TCA_PEDIT_KEY_EX_CMD_ADD:
-				val = (*ptr + tkey->val) & ~tkey->mask;
-				break;
-			default:
-				pr_info("tc action pedit bad command (%d)\n",
-					cmd);
+		if (tkey->offmask) {
+			u8 *d, _d;
+
+			if (!offset_valid(skb, hoffset + tkey->at)) {
+				pr_info("tc action pedit 'at' offset %d out of bounds\n",
+					hoffset + tkey->at);
 				goto bad;
 			}
+			d = skb_header_pointer(skb, hoffset + tkey->at,
+					       sizeof(_d), &_d);
+			if (!d)
+				goto bad;
+			offset += (*d & tkey->offmask) >> tkey->shift;
+		}
 
-			*ptr = ((*ptr & tkey->mask) ^ val);
-			if (ptr == &hdata)
-				skb_store_bits(skb, hoffset + offset, ptr, 4);
+		if (offset % 4) {
+			pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+			goto bad;
 		}
 
-		goto done;
-	} else {
-		WARN(1, "pedit BUG: index %d\n", p->tcf_index);
+		if (!offset_valid(skb, hoffset + offset)) {
+			pr_info("tc action pedit offset %d out of bounds\n",
+				hoffset + offset);
+			goto bad;
+		}
+
+		ptr = skb_header_pointer(skb, hoffset + offset,
+					 sizeof(hdata), &hdata);
+		if (!ptr)
+			goto bad;
+		/* just do it, baby */
+		switch (cmd) {
+		case TCA_PEDIT_KEY_EX_CMD_SET:
+			val = tkey->val;
+			break;
+		case TCA_PEDIT_KEY_EX_CMD_ADD:
+			val = (*ptr + tkey->val) & ~tkey->mask;
+			break;
+		default:
+			pr_info("tc action pedit bad command (%d)\n",
+				cmd);
+			goto bad;
+		}
+
+		*ptr = ((*ptr & tkey->mask) ^ val);
+		if (ptr == &hdata)
+			skb_store_bits(skb, hoffset + offset, ptr, 4);
 	}
 
+	goto done;
+
 bad:
 	spin_lock(&p->tcf_lock);
 	p->tcf_qstats.overlimits++;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index abaf75300497..445ab1b0537d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -485,7 +485,8 @@ static struct tcf_chain *tcf_chain_lookup_rcu(const struct tcf_block *block,
 #endif
 
 static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
-			   u32 seq, u16 flags, int event, bool unicast);
+			   u32 seq, u16 flags, int event, bool unicast,
+			   struct netlink_ext_ack *extack);
 
 static struct tcf_chain *__tcf_chain_get(struct tcf_block *block,
 					 u32 chain_index, bool create,
@@ -518,7 +519,7 @@ static struct tcf_chain *__tcf_chain_get(struct tcf_block *block,
 	 */
 	if (is_first_reference && !by_act)
 		tc_chain_notify(chain, NULL, 0, NLM_F_CREATE | NLM_F_EXCL,
-				RTM_NEWCHAIN, false);
+				RTM_NEWCHAIN, false, NULL);
 
 	return chain;
 
@@ -551,8 +552,8 @@ static void __tcf_chain_put(struct tcf_chain *chain, bool by_act,
 {
 	struct tcf_block *block = chain->block;
 	const struct tcf_proto_ops *tmplt_ops;
+	unsigned int refcnt, non_act_refcnt;
 	bool free_block = false;
-	unsigned int refcnt;
 	void *tmplt_priv;
 
 	mutex_lock(&block->lock);
@@ -572,13 +573,15 @@ static void __tcf_chain_put(struct tcf_chain *chain, bool by_act,
 	 * save these to temporary variables.
 	 */
 	refcnt = --chain->refcnt;
+	non_act_refcnt = refcnt - chain->action_refcnt;
 	tmplt_ops = chain->tmplt_ops;
 	tmplt_priv = chain->tmplt_priv;
 
-	/* The last dropped non-action reference will trigger notification. */
-	if (refcnt - chain->action_refcnt == 0 && !by_act) {
-		tc_chain_notify_delete(tmplt_ops, tmplt_priv, chain->index,
-				       block, NULL, 0, 0, false);
+	if (non_act_refcnt == chain->explicitly_created && !by_act) {
+		if (non_act_refcnt == 0)
+			tc_chain_notify_delete(tmplt_ops, tmplt_priv,
+					       chain->index, block, NULL, 0, 0,
+					       false);
 		/* Last reference to chain, no need to lock. */
 		chain->flushing = false;
 	}
@@ -1815,7 +1818,8 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 			 struct tcf_proto *tp, struct tcf_block *block,
 			 struct Qdisc *q, u32 parent, void *fh,
 			 u32 portid, u32 seq, u16 flags, int event,
-			 bool terse_dump, bool rtnl_held)
+			 bool terse_dump, bool rtnl_held,
+			 struct netlink_ext_ack *extack)
 {
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
@@ -1855,7 +1859,13 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 		    tp->ops->dump(net, tp, fh, skb, tcm, rtnl_held) < 0)
 			goto nla_put_failure;
 	}
+
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto nla_put_failure;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -1869,7 +1879,7 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 			  struct nlmsghdr *n, struct tcf_proto *tp,
 			  struct tcf_block *block, struct Qdisc *q,
 			  u32 parent, void *fh, int event, bool unicast,
-			  bool rtnl_held)
+			  bool rtnl_held, struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
@@ -1881,7 +1891,7 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 
 	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
 			  n->nlmsg_seq, n->nlmsg_flags, event,
-			  false, rtnl_held) <= 0) {
+			  false, rtnl_held, extack) <= 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -1910,7 +1920,7 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 
 	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
 			  n->nlmsg_seq, n->nlmsg_flags, RTM_DELTFILTER,
-			  false, rtnl_held) <= 0) {
+			  false, rtnl_held, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
 		kfree_skb(skb);
 		return -EINVAL;
@@ -1936,14 +1946,15 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 static void tfilter_notify_chain(struct net *net, struct sk_buff *oskb,
 				 struct tcf_block *block, struct Qdisc *q,
 				 u32 parent, struct nlmsghdr *n,
-				 struct tcf_chain *chain, int event)
+				 struct tcf_chain *chain, int event,
+				 struct netlink_ext_ack *extack)
 {
 	struct tcf_proto *tp;
 
 	for (tp = tcf_get_next_proto(chain, NULL);
 	     tp; tp = tcf_get_next_proto(chain, tp))
-		tfilter_notify(net, oskb, n, tp, block,
-			       q, parent, NULL, event, false, true);
+		tfilter_notify(net, oskb, n, tp, block, q, parent, NULL,
+			       event, false, true, extack);
 }
 
 static void tfilter_put(struct tcf_proto *tp, void *fh)
@@ -2147,7 +2158,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			      flags, extack);
 	if (err == 0) {
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
-			       RTM_NEWTFILTER, false, rtnl_held);
+			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
 		/* q pointer is NULL for shared blocks */
 		if (q)
@@ -2275,7 +2286,7 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 	if (prio == 0) {
 		tfilter_notify_chain(net, skb, block, q, parent, n,
-				     chain, RTM_DELTFILTER);
+				     chain, RTM_DELTFILTER, extack);
 		tcf_chain_flush(chain, rtnl_held);
 		err = 0;
 		goto errout;
@@ -2299,7 +2310,7 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 		tcf_proto_put(tp, rtnl_held, NULL);
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
-			       RTM_DELTFILTER, false, rtnl_held);
+			       RTM_DELTFILTER, false, rtnl_held, extack);
 		err = 0;
 		goto errout;
 	}
@@ -2443,7 +2454,7 @@ static int tc_get_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		err = -ENOENT;
 	} else {
 		err = tfilter_notify(net, skb, n, tp, block, q, parent,
-				     fh, RTM_NEWTFILTER, true, rtnl_held);
+				     fh, RTM_NEWTFILTER, true, rtnl_held, NULL);
 		if (err < 0)
 			NL_SET_ERR_MSG(extack, "Failed to send filter notify message");
 	}
@@ -2481,7 +2492,7 @@ static int tcf_node_dump(struct tcf_proto *tp, void *n, struct tcf_walker *arg)
 	return tcf_fill_node(net, a->skb, tp, a->block, a->q, a->parent,
 			     n, NETLINK_CB(a->cb->skb).portid,
 			     a->cb->nlh->nlmsg_seq, NLM_F_MULTI,
-			     RTM_NEWTFILTER, a->terse_dump, true);
+			     RTM_NEWTFILTER, a->terse_dump, true, NULL);
 }
 
 static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
@@ -2515,7 +2526,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
 			if (tcf_fill_node(net, skb, tp, block, q, parent, NULL,
 					  NETLINK_CB(cb->skb).portid,
 					  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-					  RTM_NEWTFILTER, false, true) <= 0)
+					  RTM_NEWTFILTER, false, true, NULL) <= 0)
 				goto errout;
 			cb->args[1] = 1;
 		}
@@ -2658,7 +2669,8 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 			      void *tmplt_priv, u32 chain_index,
 			      struct net *net, struct sk_buff *skb,
 			      struct tcf_block *block,
-			      u32 portid, u32 seq, u16 flags, int event)
+			      u32 portid, u32 seq, u16 flags, int event,
+			      struct netlink_ext_ack *extack)
 {
 	unsigned char *b = skb_tail_pointer(skb);
 	const struct tcf_proto_ops *ops;
@@ -2695,7 +2707,12 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 			goto nla_put_failure;
 	}
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -2705,7 +2722,8 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 }
 
 static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
-			   u32 seq, u16 flags, int event, bool unicast)
+			   u32 seq, u16 flags, int event, bool unicast,
+			   struct netlink_ext_ack *extack)
 {
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	struct tcf_block *block = chain->block;
@@ -2719,7 +2737,7 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
 
 	if (tc_chain_fill_node(chain->tmplt_ops, chain->tmplt_priv,
 			       chain->index, net, skb, block, portid,
-			       seq, flags, event) <= 0) {
+			       seq, flags, event, extack) <= 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -2747,7 +2765,7 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 		return -ENOBUFS;
 
 	if (tc_chain_fill_node(tmplt_ops, tmplt_priv, chain_index, net, skb,
-			       block, portid, seq, flags, RTM_DELCHAIN) <= 0) {
+			       block, portid, seq, flags, RTM_DELCHAIN, NULL) <= 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -2900,11 +2918,11 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 		}
 
 		tc_chain_notify(chain, NULL, 0, NLM_F_CREATE | NLM_F_EXCL,
-				RTM_NEWCHAIN, false);
+				RTM_NEWCHAIN, false, extack);
 		break;
 	case RTM_DELCHAIN:
 		tfilter_notify_chain(net, skb, block, q, parent, n,
-				     chain, RTM_DELTFILTER);
+				     chain, RTM_DELTFILTER, extack);
 		/* Flush the chain first as the user requested chain removal. */
 		tcf_chain_flush(chain, true);
 		/* In case the chain was successfully deleted, put a reference
@@ -2914,7 +2932,7 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 		break;
 	case RTM_GETCHAIN:
 		err = tc_chain_notify(chain, skb, n->nlmsg_seq,
-				      n->nlmsg_flags, n->nlmsg_type, true);
+				      n->nlmsg_flags, n->nlmsg_type, true, extack);
 		if (err < 0)
 			NL_SET_ERR_MSG(extack, "Failed to send chain notify message");
 		break;
@@ -3014,7 +3032,7 @@ static int tc_dump_chain(struct sk_buff *skb, struct netlink_callback *cb)
 					 chain->index, net, skb, block,
 					 NETLINK_CB(cb->skb).portid,
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
-					 RTM_NEWCHAIN);
+					 RTM_NEWCHAIN, NULL);
 		if (err <= 0)
 			break;
 		index++;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 34d25f7a0687..a3477537c102 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -716,13 +716,19 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 struct nlattr *est, u32 flags, u32 fl_flags,
 			 struct netlink_ext_ack *extack)
 {
-	int err;
+	int err, ifindex = -1;
 
 	err = tcf_exts_validate_ex(net, tp, tb, est, &n->exts, flags,
 				   fl_flags, extack);
 	if (err < 0)
 		return err;
 
+	if (tb[TCA_U32_INDEV]) {
+		ifindex = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
+		if (ifindex < 0)
+			return -EINVAL;
+	}
+
 	if (tb[TCA_U32_LINK]) {
 		u32 handle = nla_get_u32(tb[TCA_U32_LINK]);
 		struct tc_u_hnode *ht_down = NULL, *ht_old;
@@ -757,13 +763,9 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		tcf_bind_filter(tp, &n->res, base);
 	}
 
-	if (tb[TCA_U32_INDEV]) {
-		int ret;
-		ret = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
-		if (ret < 0)
-			return -EINVAL;
-		n->ifindex = ret;
-	}
+	if (ifindex >= 0)
+		n->ifindex = ifindex;
+
 	return 0;
 }
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 6fb345ec2264..01d07e6a6811 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -907,7 +907,8 @@ static void qdisc_offload_graft_root(struct net_device *dev,
 }
 
 static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
-			 u32 portid, u32 seq, u16 flags, int event)
+			 u32 portid, u32 seq, u16 flags, int event,
+			 struct netlink_ext_ack *extack)
 {
 	struct gnet_stats_basic_sync __percpu *cpu_bstats = NULL;
 	struct gnet_stats_queue __percpu *cpu_qstats = NULL;
@@ -975,7 +976,12 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 	if (gnet_stats_finish_copy(&d) < 0)
 		goto nla_put_failure;
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -996,7 +1002,8 @@ static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
 
 static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 			struct nlmsghdr *n, u32 clid,
-			struct Qdisc *old, struct Qdisc *new)
+			struct Qdisc *old, struct Qdisc *new,
+			struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
@@ -1007,12 +1014,12 @@ static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 
 	if (old && !tc_qdisc_dump_ignore(old, false)) {
 		if (tc_fill_qdisc(skb, old, clid, portid, n->nlmsg_seq,
-				  0, RTM_DELQDISC) < 0)
+				  0, RTM_DELQDISC, extack) < 0)
 			goto err_out;
 	}
 	if (new && !tc_qdisc_dump_ignore(new, false)) {
 		if (tc_fill_qdisc(skb, new, clid, portid, n->nlmsg_seq,
-				  old ? NLM_F_REPLACE : 0, RTM_NEWQDISC) < 0)
+				  old ? NLM_F_REPLACE : 0, RTM_NEWQDISC, extack) < 0)
 			goto err_out;
 	}
 
@@ -1027,10 +1034,11 @@ static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 
 static void notify_and_destroy(struct net *net, struct sk_buff *skb,
 			       struct nlmsghdr *n, u32 clid,
-			       struct Qdisc *old, struct Qdisc *new)
+			       struct Qdisc *old, struct Qdisc *new,
+			       struct netlink_ext_ack *extack)
 {
 	if (new || old)
-		qdisc_notify(net, skb, n, clid, old, new);
+		qdisc_notify(net, skb, n, clid, old, new, extack);
 
 	if (old)
 		qdisc_put(old);
@@ -1068,17 +1076,29 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
 	if (parent == NULL) {
 		unsigned int i, num_q, ingress;
+		struct netdev_queue *dev_queue;
 
 		ingress = 0;
 		num_q = dev->num_tx_queues;
 		if ((q && q->flags & TCQ_F_INGRESS) ||
 		    (new && new->flags & TCQ_F_INGRESS)) {
-			num_q = 1;
 			ingress = 1;
-			if (!dev_ingress_queue(dev)) {
+			dev_queue = dev_ingress_queue(dev);
+			if (!dev_queue) {
 				NL_SET_ERR_MSG(extack, "Device does not have an ingress queue");
 				return -ENOENT;
 			}
+
+			q = rtnl_dereference(dev_queue->qdisc_sleeping);
+
+			/* This is the counterpart of that qdisc_refcount_inc_nz() call in
+			 * __tcf_qdisc_find() for filter requests.
+			 */
+			if (!qdisc_refcount_dec_if_one(q)) {
+				NL_SET_ERR_MSG(extack,
+					       "Current ingress or clsact Qdisc has ongoing filter requests");
+				return -EBUSY;
+			}
 		}
 
 		if (dev->flags & IFF_UP)
@@ -1089,18 +1109,26 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		if (new && new->ops->attach && !ingress)
 			goto skip;
 
-		for (i = 0; i < num_q; i++) {
-			struct netdev_queue *dev_queue = dev_ingress_queue(dev);
-
-			if (!ingress)
+		if (!ingress) {
+			for (i = 0; i < num_q; i++) {
 				dev_queue = netdev_get_tx_queue(dev, i);
+				old = dev_graft_qdisc(dev_queue, new);
 
-			old = dev_graft_qdisc(dev_queue, new);
-			if (new && i > 0)
-				qdisc_refcount_inc(new);
-
-			if (!ingress)
+				if (new && i > 0)
+					qdisc_refcount_inc(new);
 				qdisc_put(old);
+			}
+		} else {
+			old = dev_graft_qdisc(dev_queue, NULL);
+
+			/* {ingress,clsact}_destroy() @old before grafting @new to avoid
+			 * unprotected concurrent accesses to net_device::miniq_{in,e}gress
+			 * pointer(s) in mini_qdisc_pair_swap().
+			 */
+			qdisc_notify(net, skb, n, classid, old, new, extack);
+			qdisc_destroy(old);
+
+			dev_graft_qdisc(dev_queue, new);
 		}
 
 skip:
@@ -1110,12 +1138,10 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 				qdisc_refcount_inc(new);
 			rcu_assign_pointer(dev->qdisc, new ? : &noop_qdisc);
 
-			notify_and_destroy(net, skb, n, classid, old, new);
+			notify_and_destroy(net, skb, n, classid, old, new, extack);
 
 			if (new && new->ops->attach)
 				new->ops->attach(new);
-		} else {
-			notify_and_destroy(net, skb, n, classid, old, new);
 		}
 
 		if (dev->flags & IFF_UP)
@@ -1146,7 +1172,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
-		notify_and_destroy(net, skb, n, classid, old, new);
+		notify_and_destroy(net, skb, n, classid, old, new, extack);
 	}
 	return 0;
 }
@@ -1519,7 +1545,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		if (err != 0)
 			return err;
 	} else {
-		qdisc_notify(net, skb, n, clid, NULL, q);
+		qdisc_notify(net, skb, n, clid, NULL, q, NULL);
 	}
 	return 0;
 }
@@ -1667,7 +1693,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 	err = qdisc_change(q, tca, extack);
 	if (err == 0)
-		qdisc_notify(net, skb, n, clid, NULL, q);
+		qdisc_notify(net, skb, n, clid, NULL, q, extack);
 	return err;
 
 create_n_graft:
@@ -1734,7 +1760,7 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
 		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
 				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC) <= 0)
+				  RTM_NEWQDISC, NULL) <= 0)
 			goto done;
 		q_idx++;
 	}
@@ -1756,7 +1782,7 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
 		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
 				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC) <= 0)
+				  RTM_NEWQDISC, NULL) <= 0)
 			goto done;
 		q_idx++;
 	}
@@ -1829,8 +1855,8 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
  ************************************************/
 
 static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
-			  unsigned long cl,
-			  u32 portid, u32 seq, u16 flags, int event)
+			  unsigned long cl, u32 portid, u32 seq, u16 flags,
+			  int event, struct netlink_ext_ack *extack)
 {
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
@@ -1865,7 +1891,12 @@ static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
 	if (gnet_stats_finish_copy(&d) < 0)
 		goto nla_put_failure;
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -1876,7 +1907,7 @@ static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
 
 static int tclass_notify(struct net *net, struct sk_buff *oskb,
 			 struct nlmsghdr *n, struct Qdisc *q,
-			 unsigned long cl, int event)
+			 unsigned long cl, int event, struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
@@ -1885,7 +1916,7 @@ static int tclass_notify(struct net *net, struct sk_buff *oskb,
 	if (!skb)
 		return -ENOBUFS;
 
-	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, event) < 0) {
+	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, event, extack) < 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -1912,7 +1943,7 @@ static int tclass_del_notify(struct net *net,
 		return -ENOBUFS;
 
 	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
-			   RTM_DELTCLASS) < 0) {
+			   RTM_DELTCLASS, extack) < 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -2119,7 +2150,7 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 			tc_bind_tclass(q, portid, clid, 0);
 			goto out;
 		case RTM_GETTCLASS:
-			err = tclass_notify(net, skb, n, q, cl, RTM_NEWTCLASS);
+			err = tclass_notify(net, skb, n, q, cl, RTM_NEWTCLASS, extack);
 			goto out;
 		default:
 			err = -EINVAL;
@@ -2137,7 +2168,7 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 	if (cops->change)
 		err = cops->change(q, clid, portid, tca, &new_cl, extack);
 	if (err == 0) {
-		tclass_notify(net, skb, n, q, new_cl, RTM_NEWTCLASS);
+		tclass_notify(net, skb, n, q, new_cl, RTM_NEWTCLASS, extack);
 		/* We just create a new class, need to do reverse binding. */
 		if (cl != new_cl)
 			tc_bind_tclass(q, portid, clid, new_cl);
@@ -2159,7 +2190,7 @@ static int qdisc_class_dump(struct Qdisc *q, unsigned long cl,
 
 	return tc_fill_tclass(a->skb, q, cl, NETLINK_CB(a->cb->skb).portid,
 			      a->cb->nlh->nlmsg_seq, NLM_F_MULTI,
-			      RTM_NEWTCLASS);
+			      RTM_NEWTCLASS, NULL);
 }
 
 static int tc_dump_tclass_qdisc(struct Qdisc *q, struct sk_buff *skb,
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ee43e8ac039e..a5693e25b248 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1046,7 +1046,7 @@ static void qdisc_free_cb(struct rcu_head *head)
 	qdisc_free(q);
 }
 
-static void qdisc_destroy(struct Qdisc *qdisc)
+static void __qdisc_destroy(struct Qdisc *qdisc)
 {
 	const struct Qdisc_ops  *ops = qdisc->ops;
 
@@ -1070,6 +1070,14 @@ static void qdisc_destroy(struct Qdisc *qdisc)
 	call_rcu(&qdisc->rcu, qdisc_free_cb);
 }
 
+void qdisc_destroy(struct Qdisc *qdisc)
+{
+	if (qdisc->flags & TCQ_F_BUILTIN)
+		return;
+
+	__qdisc_destroy(qdisc);
+}
+
 void qdisc_put(struct Qdisc *qdisc)
 {
 	if (!qdisc)
@@ -1079,7 +1087,7 @@ void qdisc_put(struct Qdisc *qdisc)
 	    !refcount_dec_and_test(&qdisc->refcnt))
 		return;
 
-	qdisc_destroy(qdisc);
+	__qdisc_destroy(qdisc);
 }
 EXPORT_SYMBOL(qdisc_put);
 
@@ -1094,7 +1102,7 @@ void qdisc_put_unlocked(struct Qdisc *qdisc)
 	    !refcount_dec_and_rtnl_lock(&qdisc->refcnt))
 		return;
 
-	qdisc_destroy(qdisc);
+	__qdisc_destroy(qdisc);
 	rtnl_unlock();
 }
 EXPORT_SYMBOL(qdisc_put_unlocked);
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index f6ee7f4040c1..5383b6a9da61 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -4484,7 +4484,7 @@ enum sctp_disposition sctp_sf_eat_auth(struct net *net,
 				    SCTP_AUTH_NEW_KEY, GFP_ATOMIC);
 
 		if (!ev)
-			return -ENOMEM;
+			return SCTP_DISPOSITION_NOMEM;
 
 		sctp_add_cmd_sf(commands, SCTP_CMD_EVENT_ULP,
 				SCTP_ULPEVENT(ev));
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 53881406e200..cdcd2731860b 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1258,7 +1258,7 @@ int tipc_nl_media_get(struct sk_buff *skb, struct genl_info *info)
 	struct tipc_nl_msg msg;
 	struct tipc_media *media;
 	struct sk_buff *rep;
-	struct nlattr *attrs[TIPC_NLA_BEARER_MAX + 1];
+	struct nlattr *attrs[TIPC_NLA_MEDIA_MAX + 1];
 
 	if (!info->attrs[TIPC_NLA_MEDIA])
 		return -EINVAL;
@@ -1307,7 +1307,7 @@ int __tipc_nl_media_set(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	char *name;
 	struct tipc_media *m;
-	struct nlattr *attrs[TIPC_NLA_BEARER_MAX + 1];
+	struct nlattr *attrs[TIPC_NLA_MEDIA_MAX + 1];
 
 	if (!info->attrs[TIPC_NLA_MEDIA])
 		return -EINVAL;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 13b209a8db28..ee853a14a02d 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2021-2022 Intel Corporation
+ * Copyright (C) 2018, 2021-2023 Intel Corporation
  */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
@@ -1441,8 +1441,8 @@ rdev_del_intf_link(struct cfg80211_registered_device *rdev,
 		   unsigned int link_id)
 {
 	trace_rdev_del_intf_link(&rdev->wiphy, wdev, link_id);
-	if (rdev->ops->add_intf_link)
-		rdev->ops->add_intf_link(&rdev->wiphy, wdev, link_id);
+	if (rdev->ops->del_intf_link)
+		rdev->ops->del_intf_link(&rdev->wiphy, wdev, link_id);
 	trace_rdev_return_void(&rdev->wiphy);
 }
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4f3f31244e8b..522180919a1a 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2442,11 +2442,8 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 		case NL80211_IFTYPE_P2P_GO:
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
-			wiphy_lock(wiphy);
 			ret = cfg80211_reg_can_beacon_relax(wiphy, &chandef,
 							    iftype);
-			wiphy_unlock(wiphy);
-
 			if (!ret)
 				return ret;
 			break;
@@ -2478,11 +2475,11 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
 	struct wireless_dev *wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	ASSERT_RTNL();
-
+	wiphy_lock(wiphy);
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		if (!reg_wdev_chan_valid(wiphy, wdev))
 			cfg80211_leave(rdev, wdev);
+	wiphy_unlock(wiphy);
 }
 
 static void reg_check_chans_work(struct work_struct *work)
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 274125307ebd..5a84b6443875 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -33,7 +33,7 @@ ld-option = $(success,$(LD) -v $(1))
 
 # $(as-instr,<instr>)
 # Return y if the assembler supports <instr>, n otherwise
-as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)
+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler-with-cpp -o /dev/null -)
 
 # check if $(CC) and $(LD) exist
 $(error-if,$(failure,command -v $(CC)),C compiler '$(CC)' not found)
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 20d353dcabfb..158c57f2acfd 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -29,16 +29,16 @@ try-run = $(shell set -e;		\
 	fi)
 
 # as-option
-# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
+# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
-# Usage: cflags-y += $(call as-instr,instr,option1,option2)
+# Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
diff --git a/scripts/as-version.sh b/scripts/as-version.sh
index 1a21495e9ff0..af717476152d 100755
--- a/scripts/as-version.sh
+++ b/scripts/as-version.sh
@@ -45,7 +45,7 @@ orig_args="$@"
 # Get the first line of the --version output.
 IFS='
 '
-set -- $(LC_ALL=C "$@" -Wa,--version -c -x assembler /dev/null -o /dev/null 2>/dev/null)
+set -- $(LC_ALL=C "$@" -Wa,--version -c -x assembler-with-cpp /dev/null -o /dev/null 2>/dev/null)
 
 # Split the line on spaces.
 IFS=' '
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 48a0e87136f1..920e44ba998a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11738,6 +11738,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b0a, 0x01b8, "ACER Veriton", ALC662_FIXUP_ACER_VERITON),
 	SND_PCI_QUIRK(0x1b35, 0x1234, "CZC ET26", ALC662_FIXUP_CZC_ET26),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1c6c, 0x1239, "Compaq N14JP6-V2", ALC897_FIXUP_HP_HSMIC_VERB),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 04be71435491..c2c56e560809 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -46,7 +46,7 @@ static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_DSP1_RX5_SRC,			0x00000020 },
 	{ CS35L41_DSP1_RX6_SRC,			0x00000021 },
 	{ CS35L41_DSP1_RX7_SRC,			0x0000003A },
-	{ CS35L41_DSP1_RX8_SRC,			0x00000001 },
+	{ CS35L41_DSP1_RX8_SRC,			0x0000003B },
 	{ CS35L41_NGATE1_SRC,			0x00000008 },
 	{ CS35L41_NGATE2_SRC,			0x00000009 },
 	{ CS35L41_AMP_DIG_VOL_CTRL,		0x00008000 },
@@ -58,8 +58,8 @@ static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_IRQ1_MASK2,			0xFFFFFFFF },
 	{ CS35L41_IRQ1_MASK3,			0xFFFF87FF },
 	{ CS35L41_IRQ1_MASK4,			0xFEFFFFFF },
-	{ CS35L41_GPIO1_CTRL1,			0xE1000001 },
-	{ CS35L41_GPIO2_CTRL1,			0xE1000001 },
+	{ CS35L41_GPIO1_CTRL1,			0x81000001 },
+	{ CS35L41_GPIO2_CTRL1,			0x81000001 },
 	{ CS35L41_MIXER_NGATE_CFG,		0x00000000 },
 	{ CS35L41_MIXER_NGATE_CH1_CFG,		0x00000303 },
 	{ CS35L41_MIXER_NGATE_CH2_CFG,		0x00000303 },
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 3496301582b2..f966d39c5c90 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -183,30 +183,6 @@ static void i2s_stop(struct dw_i2s_dev *dev,
 	}
 }
 
-static int dw_i2s_startup(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *cpu_dai)
-{
-	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
-	union dw_i2s_snd_dma_data *dma_data = NULL;
-
-	if (!(dev->capability & DWC_I2S_RECORD) &&
-			(substream->stream == SNDRV_PCM_STREAM_CAPTURE))
-		return -EINVAL;
-
-	if (!(dev->capability & DWC_I2S_PLAY) &&
-			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
-		return -EINVAL;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = &dev->play_dma_data;
-	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		dma_data = &dev->capture_dma_data;
-
-	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)dma_data);
-
-	return 0;
-}
-
 static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 {
 	u32 ch_reg;
@@ -305,12 +281,6 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void dw_i2s_shutdown(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
-}
-
 static int dw_i2s_prepare(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
@@ -382,8 +352,6 @@ static int dw_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 }
 
 static const struct snd_soc_dai_ops dw_i2s_dai_ops = {
-	.startup	= dw_i2s_startup,
-	.shutdown	= dw_i2s_shutdown,
 	.hw_params	= dw_i2s_hw_params,
 	.prepare	= dw_i2s_prepare,
 	.trigger	= dw_i2s_trigger,
@@ -625,6 +593,14 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 
 }
 
+static int dw_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &dev->play_dma_data, &dev->capture_dma_data);
+	return 0;
+}
+
 static int dw_i2s_probe(struct platform_device *pdev)
 {
 	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
@@ -643,6 +619,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dw_i2s_dai->ops = &dw_i2s_dai_ops;
+	dw_i2s_dai->probe = dw_i2s_dai_probe;
 
 	dev->i2s_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(dev->i2s_base))
diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 87f9c18be238..87353b4b0cd7 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -394,7 +394,7 @@ static int avs_register_i2s_boards(struct avs_dev *adev)
 	}
 
 	for (mach = boards->machs; mach->id[0]; mach++) {
-		if (!acpi_dev_present(mach->id, NULL, -1))
+		if (!acpi_dev_present(mach->id, mach->uid, -1))
 			continue;
 
 		if (mach->machine_quirk)
diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 8fe5917b1e26..22f21f3f612d 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -424,21 +424,34 @@ static int avs_dai_fe_startup(struct snd_pcm_substream *substream, struct snd_so
 
 	host_stream = snd_hdac_ext_stream_assign(bus, substream, HDAC_EXT_STREAM_TYPE_HOST);
 	if (!host_stream) {
-		kfree(data);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	data->host_stream = host_stream;
-	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto err;
+
 	/* avoid wrap-around with wall-clock */
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 20, 178000000);
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_rates);
+	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 20, 178000000);
+	if (ret < 0)
+		goto err;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_rates);
+	if (ret < 0)
+		goto err;
+
 	snd_pcm_set_sync(substream);
 
 	dev_dbg(dai->dev, "%s fe STARTUP tag %d str %p",
 		__func__, hdac_stream(host_stream)->stream_tag, substream);
 
 	return 0;
+
+err:
+	kfree(data);
+	return ret;
 }
 
 static void avs_dai_fe_shutdown(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7a486ca9633c..f3964060a044 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2403,6 +2403,9 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
 			continue;
 
+		if (!snd_soc_dpcm_can_be_prepared(fe, be, stream))
+			continue;
+
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND) &&
@@ -3043,3 +3046,20 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
+
+/*
+ * We can only prepare a BE DAI if any of it's FE are not prepared,
+ * running or paused for the specified stream direction.
+ */
+int snd_soc_dpcm_can_be_prepared(struct snd_soc_pcm_runtime *fe,
+				 struct snd_soc_pcm_runtime *be, int stream)
+{
+	const enum snd_soc_dpcm_state state[] = {
+		SND_SOC_DPCM_STATE_START,
+		SND_SOC_DPCM_STATE_PAUSED,
+		SND_SOC_DPCM_STATE_PREPARE,
+	};
+
+	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_prepared);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 1e1d7458bce1..f2c798c4506b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -650,6 +650,10 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 
+	ret = snd_usb_pcm_change_state(subs, UAC3_PD_STATE_D0);
+	if (ret < 0)
+		goto unlock;
+
  again:
 	if (subs->sync_endpoint) {
 		ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3ecd1ba7fd4b..6cf55b7f7a04 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2191,6 +2191,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2ab6, /* T+A devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x3336, /* HEM devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3842, /* EVGA */
diff --git a/tools/gpio/lsgpio.c b/tools/gpio/lsgpio.c
index c61d061247e1..52a0be45410c 100644
--- a/tools/gpio/lsgpio.c
+++ b/tools/gpio/lsgpio.c
@@ -94,7 +94,7 @@ static void print_attributes(struct gpio_v2_line_info *info)
 	for (i = 0; i < info->num_attrs; i++) {
 		if (info->attrs[i].id == GPIO_V2_LINE_ATTR_ID_DEBOUNCE)
 			fprintf(stdout, ", debounce_period=%dusec",
-				info->attrs[0].debounce_period_us);
+				info->attrs[i].debounce_period_us);
 	}
 }
 
diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index 341e3de00896..bf67b23ed29a 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -389,6 +389,9 @@ create_chip chip
 create_bank chip bank
 set_num_lines chip bank 8
 enable_chip chip
+DEVNAME=`configfs_dev_name chip`
+CHIPNAME=`configfs_chip_name chip bank`
+SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank` 0
 test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
 remove_chip chip
diff --git a/tools/testing/selftests/net/forwarding/hw_stats_l3.sh b/tools/testing/selftests/net/forwarding/hw_stats_l3.sh
index 9c1f76e108af..1a936ffbacee 100755
--- a/tools/testing/selftests/net/forwarding/hw_stats_l3.sh
+++ b/tools/testing/selftests/net/forwarding/hw_stats_l3.sh
@@ -84,8 +84,9 @@ h2_destroy()
 
 router_rp1_200_create()
 {
-	ip link add name $rp1.200 up \
-		link $rp1 addrgenmode eui64 type vlan id 200
+	ip link add name $rp1.200 link $rp1 type vlan id 200
+	ip link set dev $rp1.200 addrgenmode eui64
+	ip link set dev $rp1.200 up
 	ip address add dev $rp1.200 192.0.2.2/28
 	ip address add dev $rp1.200 2001:db8:1::2/64
 	ip stats set dev $rp1.200 l3_stats on
@@ -256,9 +257,11 @@ reapply_config()
 
 	router_rp1_200_destroy
 
-	ip link add name $rp1.200 link $rp1 addrgenmode none type vlan id 200
+	ip link add name $rp1.200 link $rp1 type vlan id 200
+	ip link set dev $rp1.200 addrgenmode none
 	ip stats set dev $rp1.200 l3_stats on
-	ip link set dev $rp1.200 up addrgenmode eui64
+	ip link set dev $rp1.200 addrgenmode eui64
+	ip link set dev $rp1.200 up
 	ip address add dev $rp1.200 192.0.2.2/28
 	ip address add dev $rp1.200 2001:db8:1::2/64
 }
diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 198ad5f32187..cfa9562f3cd8 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -502,11 +502,11 @@ int main(int argc, char *argv[])
 			interval = t2 - t1;
 			offset = (t2 + t1) / 2 - tp;
 
-			printf("system time: %lld.%u\n",
+			printf("system time: %lld.%09u\n",
 				(pct+2*i)->sec, (pct+2*i)->nsec);
-			printf("phc    time: %lld.%u\n",
+			printf("phc    time: %lld.%09u\n",
 				(pct+2*i+1)->sec, (pct+2*i+1)->nsec);
-			printf("system time: %lld.%u\n",
+			printf("system time: %lld.%09u\n",
 				(pct+2*i+2)->sec, (pct+2*i+2)->nsec);
 			printf("system/phc clock time offset is %" PRId64 " ns\n"
 			       "system     clock time delay  is %" PRId64 " ns\n",
diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index 4638c63a339f..aec4de8bea78 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -6,6 +6,7 @@ CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
 CONFIG_NF_NAT=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
 
 CONFIG_NET_SCHED=y
 
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
index ba2f5e79cdbf..e21c7f22c6d4 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
@@ -58,10 +58,10 @@
         "setup": [
             "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb db 10",
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb db 100",
         "expExitCode": "0",
         "verifyCmd": "$TC qdisc show dev $DUMMY",
-        "matchPattern": "qdisc sfb 1: root refcnt [0-9]+ rehash 600s db 10ms",
+        "matchPattern": "qdisc sfb 1: root refcnt [0-9]+ rehash 600s db 100ms",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root",
diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index afb0cd86fa3d..eb357bd7923c 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -2,5 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 modprobe netdevsim
+modprobe sch_teql
 ./tdc.py -c actions --nobuildebpf
 ./tdc.py -c qdisc
