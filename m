Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C774EFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjGKNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjGKNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24418D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02F2614BD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFD1C433C8;
        Tue, 11 Jul 2023 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689080931;
        bh=YRG1SatEXSQvibLkPPPJGs1s5S3gHEmvd7gZSzwoAnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8vIO/3oz0iV+JgNzmjwzr+CqcICYWIe7Rog2iDkpGmFwZJYExFefwtunqZdT6VMl
         EQnVR6hgqYxvFUCn1yz1VxthdhaUjLWAQNQknByoD2ylRfeXIGTkinPU7DRPpEARDZ
         7wX0sSRV4gsPE+0pjG7tc7lPTroIyaiNr9krJQaOVEEiaUTnd9kPtjM1i7eDyrWveS
         QtdstMrnsA2dPoXWxPs7dLSeHSQaNy11g5joZAo4bkYF0MURxHjYoP8QJ1BL2CHNxl
         dRj4mzhN1/YDtHZnmVaI3l9GfljurrccBjsCIrXpFRYcC9/hqYTui5DrmkZ/0JYoKJ
         JsEwgA/i1IYjg==
From:   Greg Ungerer <gerg@kernel.org>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     palmer@dabbelt.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, brauner@kernel.org,
        Greg Ungerer <gerg@kernel.org>
Subject: [PATCH v2 2/2] riscv: support the elf-fdpic binfmt loader
Date:   Tue, 11 Jul 2023 23:07:54 +1000
Message-Id: <20230711130754.481209-3-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711130754.481209-1-gerg@kernel.org>
References: <20230711130754.481209-1-gerg@kernel.org>
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

Add support for enabling and using the binfmt_elf_fdpic program loader
on RISC-V platforms. The most important change is to setup registers
during program load to pass the mapping addresses to the new process.

One of the interesting features of the elf-fdpic loader is that it
also allows appropriately compiled ELF format binaries to be loaded on
nommu systems. Appropriate being those compiled with -pie.

Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
v1->v2: rebase onto linux-6.5-rc1
        increment PTRACE_GETFDPIC value to keep it unique

 arch/riscv/include/asm/elf.h         | 11 ++++++++++-
 arch/riscv/include/asm/mmu.h         |  4 ++++
 arch/riscv/include/uapi/asm/ptrace.h |  5 +++++
 fs/Kconfig.binfmt                    |  2 +-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index c24280774caf..c33fe923ef6d 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -41,6 +41,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
 #define compat_elf_check_arch	compat_elf_check_arch
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS	0
 #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
 
 /*
@@ -69,6 +70,13 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
 #define ELF_HWCAP	riscv_get_elf_hwcap()
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
@@ -78,7 +86,6 @@ extern unsigned long elf_hwcap;
 
 #define COMPAT_ELF_PLATFORM	(NULL)
 
-#ifdef CONFIG_MMU
 #define ARCH_DLINFO						\
 do {								\
 	/*							\
@@ -115,6 +122,8 @@ do {								\
 	else							 \
 		NEW_AUX_ENT(AT_IGNORE, 0);			 \
 } while (0)
+
+#ifdef CONFIG_MMU
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 0099dc116168..355504b37f8e 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -20,6 +20,10 @@ typedef struct {
 	/* A local icache flush is needed before user execution can resume. */
 	cpumask_t icache_stale_mask;
 #endif
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long exec_fdpic_loadmap;
+	unsigned long interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index e17c550986a6..30f6d6537adc 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -10,6 +10,11 @@
 
 #include <linux/types.h>
 
+#define PTRACE_GETFDPIC		33
+
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+
 /*
  * User-mode register state for core dumps, ptrace, sigcontext
  *
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 93539aac0e5b..f5693164ca9a 100644
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

