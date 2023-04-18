Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2189D6E6A52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjDRQ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjDRQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:58:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9035EAF1E;
        Tue, 18 Apr 2023 09:58:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f27a9c7970so2378749f8f.2;
        Tue, 18 Apr 2023 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837119; x=1684429119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHTCK4IH8CpnQ2hctqpSfEPGWKuXKMKbfcr+NEqGgNM=;
        b=c7NVCQdcfYpXjG6JpnLHC1XY2GT04VUpdalUJjvWVroHHxQXzCeh9rHt1G9d0YNFr8
         LfATM3lGN391NR0N4kBYaWgcrTjqIwpkwtJkdchavYEdSRDVpI3a0RxKXdziqhaMagwO
         myLIvmONlrpxpJKNDEIF6tjCXfD/XZ9rOloMitf3cdKtY1F9KBIS+zDqAKV0dIOvCU1v
         b3lV70AWJ/BaeYIJ9+agqwa0yw91I1JtVNpahrL6MRFtyLey0weWiQYHgfv2gb6v5gpK
         t1ZsUifpggGyC/cEY6FwKCK1PT8OnFV9n9fuGfA9FnAaSb0apIxu6X09ta+EOlE/A9Yr
         7RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837119; x=1684429119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHTCK4IH8CpnQ2hctqpSfEPGWKuXKMKbfcr+NEqGgNM=;
        b=B3mAZLpeooaF4rglZ4YjhKbRDgPRrriH+9ZzZ+2LLFud9ue8BKeAo4fuLrmpS4KI6r
         vn/DEwIu/sH7JIkp7cLvBi7C6fu2bIwTmAo3HnwsAPBC0TokoJe9jxXCkYd91MLJWmu+
         1Im2eGUhkTHPlvCekVkaTUZRKTx6XIuYa+vl5ONpe/LRVu6FxAu7yjQBflUINujTPYhL
         BiTo1HT6zjuLnsBb67NiIJP6wxvR2zFlESehggngaSRjBaSnj+VzWA81A3SCgtMW7Cw3
         OKubMm8o2Y6ApIaDDPz0Vv6GH6Nb+DMXMmhcPdJ9dH4GO1MBuluXvf5ldnzszyKR6r5L
         JqSw==
X-Gm-Message-State: AAQBX9dfAIE7zA1INsci/ZlvJQpR045HoOh8wMbHlldKfDxn+eaSISpW
        csz3bwu3s2YopOpo3E1BVEdVdBlxq3vxzQ==
X-Google-Smtp-Source: AKy350YwiMAKV/OELBxnmVSWzLV95kU5ZNDTn3WwgHXQkxuriyXIynPG3cd73SJo4mzPaNboTLVogg==
X-Received: by 2002:a5d:504b:0:b0:2cf:e74f:2957 with SMTP id h11-20020a5d504b000000b002cfe74f2957mr2373972wrt.33.1681837119394;
        Tue, 18 Apr 2023 09:58:39 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id q17-20020adfdfd1000000b002e4cd2ec5c7sm13514523wrn.86.2023.04.18.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:58:38 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-mm@kvack.org
Subject: [PATCH 3/4] openrisc: Support floating point user api
Date:   Tue, 18 Apr 2023 17:58:12 +0100
Message-Id: <20230418165813.1900991-4-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418165813.1900991-1-shorne@gmail.com>
References: <20230418165813.1900991-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for handling floating point exceptions and forwarding the
SIGFPE signal to processes.  Also, add fpu state to sigcontext.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/uapi/asm/elf.h        |  3 +--
 arch/openrisc/include/uapi/asm/ptrace.h     |  4 ++++
 arch/openrisc/include/uapi/asm/sigcontext.h |  1 +
 arch/openrisc/kernel/entry.S                | 11 +++++++++--
 arch/openrisc/kernel/head.S                 |  4 ++--
 arch/openrisc/kernel/signal.c               |  2 ++
 arch/openrisc/kernel/traps.c                | 22 +++++++++++++++++++++
 7 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/openrisc/include/uapi/asm/elf.h b/arch/openrisc/include/uapi/asm/elf.h
index e892d5061685..6868f81c281e 100644
--- a/arch/openrisc/include/uapi/asm/elf.h
+++ b/arch/openrisc/include/uapi/asm/elf.h
@@ -53,8 +53,7 @@ typedef unsigned long elf_greg_t;
 #define ELF_NGREG (sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
-/* A placeholder; OR32 does not have fp support yes, so no fp regs for now.  */
-typedef unsigned long elf_fpregset_t;
+typedef struct __or1k_fpu_state elf_fpregset_t;
 
 /* EM_OPENRISC is defined in linux/elf-em.h */
 #define EM_OR32         0x8472
diff --git a/arch/openrisc/include/uapi/asm/ptrace.h b/arch/openrisc/include/uapi/asm/ptrace.h
index d4fab268f6aa..a77cc9915ca8 100644
--- a/arch/openrisc/include/uapi/asm/ptrace.h
+++ b/arch/openrisc/include/uapi/asm/ptrace.h
@@ -30,6 +30,10 @@ struct user_regs_struct {
 	unsigned long pc;
 	unsigned long sr;
 };
+
+struct __or1k_fpu_state {
+	unsigned long fpcsr;
+};
 #endif
 
 
diff --git a/arch/openrisc/include/uapi/asm/sigcontext.h b/arch/openrisc/include/uapi/asm/sigcontext.h
index 8ab775fc3450..ca585e4af6b8 100644
--- a/arch/openrisc/include/uapi/asm/sigcontext.h
+++ b/arch/openrisc/include/uapi/asm/sigcontext.h
@@ -28,6 +28,7 @@
 
 struct sigcontext {
 	struct user_regs_struct regs;  /* needs to be first */
+	struct __or1k_fpu_state fpu;
 	unsigned long oldmask;
 };
 
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c7b47e571220..c9f48e750b72 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -848,9 +848,16 @@ _syscall_badsys:
 
 /******* END SYSCALL HANDLING *******/
 
-/* ---[ 0xd00: Trap exception ]------------------------------------------ */
+/* ---[ 0xd00: Floating Point exception ]-------------------------------- */
 
-UNHANDLED_EXCEPTION(_vector_0xd00,0xd00)
+EXCEPTION_ENTRY(_fpe_trap_handler)
+	CLEAR_LWA_FLAG(r3)
+	/* r4: EA of fault (set by EXCEPTION_HANDLE) */
+	l.jal   do_fpe_trap
+	 l.addi  r3,r1,0 /* pt_regs */
+
+	l.j     _ret_from_exception
+	 l.nop
 
 /* ---[ 0xe00: Trap exception ]------------------------------------------ */
 
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index e11699f3d6bd..439e00f81e5d 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -424,9 +424,9 @@ _dispatch_do_ipage_fault:
     .org 0xc00
 	EXCEPTION_HANDLE(_sys_call_handler)
 
-/* ---[ 0xd00: Trap exception ]------------------------------------------ */
+/* ---[ 0xd00: Floating point exception ]--------------------------------- */
     .org 0xd00
-	UNHANDLED_EXCEPTION(_vector_0xd00)
+	EXCEPTION_HANDLE(_fpe_trap_handler)
 
 /* ---[ 0xe00: Trap exception ]------------------------------------------ */
     .org 0xe00
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 80f69740c731..4664a18f0787 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -50,6 +50,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user(regs, sc->regs.gpr, 32 * sizeof(unsigned long));
 	err |= __copy_from_user(&regs->pc, &sc->regs.pc, sizeof(unsigned long));
 	err |= __copy_from_user(&regs->sr, &sc->regs.sr, sizeof(unsigned long));
+	err |= __copy_from_user(&regs->fpcsr, &sc->fpu.fpcsr, sizeof(unsigned long));
 
 	/* make sure the SM-bit is cleared so user-mode cannot fool us */
 	regs->sr &= ~SPR_SR_SM;
@@ -112,6 +113,7 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	err |= __copy_to_user(sc->regs.gpr, regs, 32 * sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.pc, &regs->pc, sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.sr, &regs->sr, sizeof(unsigned long));
+	err |= __copy_to_user(&sc->fpu.fpcsr, &regs->fpcsr, sizeof(unsigned long));
 
 	return err;
 }
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index f5bbe6b55849..0aa6b07efda1 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -243,6 +243,28 @@ asmlinkage void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 	die("Oops", regs, 9);
 }
 
+asmlinkage void do_fpe_trap(struct pt_regs *regs, unsigned long address)
+{
+	int code = FPE_FLTUNK;
+	unsigned long fpcsr = regs->fpcsr;
+
+	if (fpcsr & SPR_FPCSR_IVF)
+		code = FPE_FLTINV;
+	else if (fpcsr & SPR_FPCSR_OVF)
+		code = FPE_FLTOVF;
+	else if (fpcsr & SPR_FPCSR_UNF)
+		code = FPE_FLTUND;
+	else if (fpcsr & SPR_FPCSR_DZF)
+		code = FPE_FLTDIV;
+	else if (fpcsr & SPR_FPCSR_IXF)
+		code = FPE_FLTRES;
+
+	/* Clear all flags */
+	regs->fpcsr &= ~SPR_FPCSR_ALLF;
+
+	force_sig_fault(SIGFPE, code, (void __user *)regs->pc);
+}
+
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
 	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
-- 
2.39.1

