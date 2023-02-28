Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988606A5A67
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjB1NxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjB1NxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:53:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE5272E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:52:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6606EB80E46
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3263C4339B;
        Tue, 28 Feb 2023 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677592370;
        bh=sUmjqdECpzhBzLfzvtQfNGKN7mDNJWpISMfwa2tW33U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Boyhyv71FzWm40DrM+Drdf72LjQFrF8AHpWmkg5DOe9wjg6w+XJdL/M9yJ/fIvYrH
         Po6NftZvGdme/ZlecbcNrBfx0klhFEcwZ06OJYzJNppwaap9/rEj+KA4n+KD78eCnp
         d9KS8dGiWMkM/WGE9yO5CyrQH+H9VzPXuDzFzb18BC0C8Xpf8nZ2+hZeJ1zSIkmIqS
         99Owj8rS1vjZJn/XGaZgAebaYTR61DeKsel6vXO7AWDquYQ1DyZHjeDgsr31tVo94b
         lbTB2jyn2+RCN9nQb5kJ0YvmIhyVsil9h1mKkzoQroWo8WLvjGItnNlLFRHXiuPd+m
         fVjKuCUH/UF7Q==
From:   Greg Ungerer <gerg@kernel.org>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Ungerer <gerg@kernel.org>
Subject: [PATCH 2/2] riscv: support the elf-fdpic binfmt loader
Date:   Tue, 28 Feb 2023 23:51:26 +1000
Message-Id: <20230228135126.1686427-3-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228135126.1686427-1-gerg@kernel.org>
References: <20230228135126.1686427-1-gerg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for enabling and using the binfmt_elf_fdpic program loader
on RISC-V platorms. The most important change is to setup registers
during program load to pass the mapping addresses to the new process.

One of the interresting features of the elf-fdpic loader is that it
also allows appropriately compiled ELF format binaries to be loaded on
nommu systems. Appropriate being those compiled with -pie.

Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
 arch/riscv/include/asm/elf.h         | 11 ++++++++++-
 arch/riscv/include/asm/mmu.h         |  4 ++++
 arch/riscv/include/uapi/asm/ptrace.h |  5 +++++
 fs/Kconfig.binfmt                    |  2 +-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index e7acffdf21d26..95747b35d3262 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -40,6 +40,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
 #define compat_elf_check_arch	compat_elf_check_arch
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS	0
 #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
 
 /*
@@ -67,6 +68,13 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
 #define ELF_HWCAP	(elf_hwcap)
 extern unsigned long elf_hwcap;
 
+#define ELF_FDPIC_PLAT_INIT(_r, _exec_map_addr, _interp_map_addr, dynamic_addr) \
+	do { \
+		(_r)->a1 = _exec_map_addr; \
+		(_r)->a2 = _interp_map_addr; \
+		(_r)->a3 = dynamic_addr; \
+	} while (0)
+
 /*
  * This yields a string that ld.so will use to load implementation
  * specific libraries for optimization.  This is more specific in
@@ -76,7 +84,6 @@ extern unsigned long elf_hwcap;
 
 #define COMPAT_ELF_PLATFORM	(NULL)
 
-#ifdef CONFIG_MMU
 #define ARCH_DLINFO						\
 do {								\
 	/*							\
@@ -104,6 +111,8 @@ do {								\
 	NEW_AUX_ENT(AT_L3_CACHEGEOMETRY,			\
 		get_cache_geometry(3, CACHE_TYPE_UNIFIED));	\
 } while (0)
+
+#ifdef CONFIG_MMU
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 5ff1f19fd45c2..af3fc3fb4d1ad 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -22,6 +22,10 @@ typedef struct {
 	/* A local tlb flush is needed before user execution can resume. */
 	cpumask_t tlb_stale_mask;
 #endif
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long exec_fdpic_loadmap;
+	unsigned long interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 882547f6bd5c9..93a690509b133 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -10,6 +10,11 @@
 
 #include <linux/types.h>
 
+#define PTRACE_GETFDPIC		31
+
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+
 /*
  * User-mode register state for core dumps, ptrace, sigcontext
  *
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 93539aac0e5b2..f5693164ca9a3 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || SUPERH || XTENSA) && !MMU)
+	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.25.1

