Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA0693D97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBMEys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBMEy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D023AE071
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nh19-20020a17090b365300b00233ceae8407so3451073pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6mU7eTgSI6j468x6JlFr8IfE22BslDPe1KItKKWUgQ=;
        b=qYf8FTmWzIZq1sj/cRWNqkDlyaUrlHtAkUn706G2DjlsOFiB0iWKuqtT+MxmEI3t6T
         Ff0DhMKpSFR6ca05rAxMPooGPzA1kFOzhjYrqNY3J0Ka4Zz14ybBi+36q/CVw1rjCcJQ
         s21yu/DiDLNr4UUmwy6Wsgi9sOq9iax7KYKB0pZOhEhM5LpPkR5ngeHS/g47Fh7aN/AI
         cMC9Y8a3hzHTiL32AkRANplY0UlHrCUshHymlqQKPn6qaw5BdiwO3FgxJ0F1Iu/SSLhy
         5pCenej/IO1VFA3WT/JAMOuCLszHyDZbQ8niFlM4YacqhxIEIz1YG6akTVFEeYQFxrxP
         0ULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6mU7eTgSI6j468x6JlFr8IfE22BslDPe1KItKKWUgQ=;
        b=37n2qT2X0kT4d2V8R8isr+Q+lJ3NtFDky45Nti/tS9vwLujMls/tZcYJHL2IY/zjQ2
         mNM6grrZmhyaD0xzFvA0x2W75ktXPCSgF6KdpBLtj6RKjyepgNwjA9xQnDtTZYLxkN0J
         Ju399y89UvUpEpK7Ha7MKH3A+5VkJzGdMRh/cFjoF7TZHwf/yAmdFPoCyQTwbartp+sh
         PpG0QFyEac8yvKaoMpuEODzMA+oQ7TmnhUfirMfbpSeilvw008xZjAy9PsMGhqz9HdrF
         XUMrFruQPpahTJ7Uy3unZa/TMdWrwm9X4PKzgrDU0fKDpBufijfvd5U12s/HPd/oDe5i
         70qQ==
X-Gm-Message-State: AO0yUKVx2b0DB0RVQZW9bkf9zmbPbCbxmnHeRVDNHDFOvILQphDVfkPW
        w/oJ6ehEKbILGJI3/hCAjCyPj58DKPgDzsQ5
X-Google-Smtp-Source: AK7set8HPfJbTibzxMHxoi7mMOcMVGZORNN77Z7301T7+NMj1/NsI1Getj9LRbOMwSbpaixi5cPnoA==
X-Received: by 2002:a17:903:1c2:b0:198:e1b8:9476 with SMTP id e2-20020a17090301c200b00198e1b89476mr29006123plh.15.1676264053898;
        Sun, 12 Feb 2023 20:54:13 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:13 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Deepak Gupta <debug@rivosinc.com>, linux-mm@kvack.org
Subject: [PATCH v1 RFC Zisslpcfi 08/20] riscv: ELF header parsing in GNU property for riscv zisslpcfi
Date:   Sun, 12 Feb 2023 20:53:37 -0800
Message-Id: <20230213045351.3945824-9-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binaries enabled for Zisslpcfi will have new instructions that may fault
on risc-v cpus which dont implement Zimops or Zicfi. This change adds

 - support for parsing new backward and forward cfi flags in
   PT_GNU_PROPERTY
 - setting cfi state on recognizing cfi flags in ELF
 - enable back cfi and forward cfi in sstatus

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/elf.h | 54 +++++++++++++++++++++++++++++
 arch/riscv/kernel/process.c  | 67 ++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index e7acffdf21d2..60ac2d2390ee 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -14,6 +14,7 @@
 #include <asm/auxvec.h>
 #include <asm/byteorder.h>
 #include <asm/cacheinfo.h>
+#include <linux/processor.h>
 
 /*
  * These are used to set parameters in the core dumps.
@@ -140,4 +141,57 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 				compat_arch_setup_additional_pages
 
 #endif /* CONFIG_COMPAT */
+
+#define RISCV_ELF_FCFI (1 << 0)
+#define RISCV_ELF_BCFI (1 << 1)
+
+#ifdef CONFIG_ARCH_BINFMT_ELF_STATE
+struct arch_elf_state {
+	int flags;
+};
+
+#define INIT_ARCH_ELF_STATE {                  \
+	.flags = 0,                             \
+}
+#endif
+
+#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
+static inline int arch_parse_elf_property(u32 type, const void *data,
+					  size_t datasz, bool compat,
+					  struct arch_elf_state *arch)
+{
+	/*
+	 * TODO: Do we want to support in 32bit/compat?
+	 * may be return 0 for now.
+	 */
+	if (IS_ENABLED(CONFIG_COMPAT) && compat)
+		return 0;
+	if ((type & GNU_PROPERTY_RISCV_FEATURE_1_AND) == GNU_PROPERTY_RISCV_FEATURE_1_AND) {
+		const u32 *p = data;
+
+		if (datasz != sizeof(*p))
+			return -ENOEXEC;
+		if (arch_supports_indirect_br_lp_instr() &&
+		   (*p & GNU_PROPERTY_RISCV_FEATURE_1_FCFI))
+			arch->flags |= RISCV_ELF_FCFI;
+		if (arch_supports_shadow_stack() && (*p & GNU_PROPERTY_RISCV_FEATURE_1_BCFI))
+			arch->flags |= RISCV_ELF_BCFI;
+	}
+	return 0;
+}
+
+static inline int arch_elf_pt_proc(void *ehdr, void *phdr,
+				   struct file *f, bool is_interp,
+				   struct arch_elf_state *state)
+{
+	return 0;
+}
+
+static inline int arch_check_elf(void *ehdr, bool has_interp,
+				 void *interp_ehdr,
+				 struct arch_elf_state *state)
+{
+	return 0;
+}
+#endif
 #endif /* _ASM_RISCV_ELF_H */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 8955f2432c2d..db676262e61e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -24,6 +24,7 @@
 #include <asm/switch_to.h>
 #include <asm/thread_info.h>
 #include <asm/cpuidle.h>
+#include <linux/mman.h>
 
 register unsigned long gp_in_global __asm__("gp");
 
@@ -135,6 +136,14 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	else
 		regs->status |= SR_UXL_64;
 #endif
+#ifdef CONFIG_USER_SHADOW_STACK
+	if (current_thread_info()->user_cfi_state.ufcfi_en)
+		regs->status |= SR_UFCFIEN;
+#endif
+#ifdef CONFIG_USER_INDIRECT_BR_LP
+	if (current_thread_info()->user_cfi_state.ubcfi_en)
+		regs->status |= SR_UBCFIEN;
+#endif
 }
 
 void flush_thread(void)
@@ -189,3 +198,61 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }
+
+
+int allocate_shadow_stack(unsigned long *shadow_stack_base, unsigned long *shdw_size)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, populate, size;
+	*shadow_stack = 0;
+
+	if (!shdw_size)
+		return -EINVAL;
+
+	size = *shdw_size;
+
+	/* If size is 0, then try to calculate yourself */
+	if (size == 0)
+		size = round_up(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G), PAGE_SIZE);
+	mmap_write_lock(mm);
+	addr = do_mmap(NULL, 0, size, PROT_SHADOWSTACK, flags, 0,
+		       &populate, NULL);
+	mmap_write_unlock(mm);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+	*shadow_stack_base = addr;
+	*shdw_size = size;
+	return 0;
+}
+
+#if defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+/* gets called from load_elf_binary(). This'll setup shadow stack and forward cfi enable */
+int arch_elf_setup_cfi_state(const struct arch_elf_state *state)
+{
+	int ret = 0;
+	unsigned long shadow_stack_base = 0;
+	unsigned long shadow_stk_size = 0;
+	struct thread_info *info = NULL;
+
+	info = current_thread_info();
+	/* setup back cfi state */
+	/* setup cfi state only if implementation supports it */
+	if (arch_supports_shadow_stack() && (state->flags & RISCV_ELF_BCFI)) {
+		info->user_cfi_state.ubcfi_en = 1;
+		ret = allocate_shadow_stack(&shadow_stack_base, &shadow_stk_size);
+		if (ret)
+			return ret;
+
+		info->user_cfi_state.user_shdw_stk = (shadow_stack_base + shadow_stk_size);
+		info->user_cfi_state.shdw_stk_base = shadow_stack_base;
+	}
+	/* setup forward cfi state */
+	if (arch_supports_indirect_br_lp_instr() && (state->flags & RISCV_ELF_FCFI)) {
+		info->user_cfi_state.ufcfi_en = 1;
+		info->user_cfi_state.lp_label = 0;
+	}
+
+	return ret;
+}
+#endif
\ No newline at end of file
-- 
2.25.1

