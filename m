Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB1693D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBMEzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBMEyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE9113EE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso13050083pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+FPHf6hRIJPFXwDXSpkdTEJ33J583V063C2UTppgJs=;
        b=PIc3jlcyk7tBVDiMhDV7vQZElpm10o3G2cwhqlaW4z2UIEx5lX08doq/7HmwkcA5/B
         mXA4mD3Qibw1ZZXxBKWGnAHzkaBgpiPxYs3SSCxrss438iFkUzY+I1LbmCO0Wy7Qv4zy
         OaGCmO23kCrbduaQZBVgTYiLM/xSzD/oJvobRKtEDu6wJbbzlkleuglQwO3UeTxWhlgA
         fAtMy+u3iW8kehvHhqtC3eqchwEPIk5+4Fgy7oyU8w/+z6lfr5E2IZ2FvGNy0muTuG8G
         kF9cuzHt65MD3IYO5Qezafy2tL+DHy52TBkbL+mYMz2pP3AJNcMSZFeiBzRu8l1mioSD
         7LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+FPHf6hRIJPFXwDXSpkdTEJ33J583V063C2UTppgJs=;
        b=qULw71cCl6jQDCj6MRpS/xQjuyZLWHLQiMf1mnef79ZqjiEJkPRMw+gFKLxHjVF8r0
         /2uagkkFYbUgbf3IlaPIyDM1RM+ovTucoa7Dpbi8YkIegi7X8PFryN5vjxqPX3FYa83p
         ZKmJairBXQXpnRhSQw1H+BjO/SmvjIFdSvguyHWH23Rpy7Lju6VBfq11DxvfrPb4So/a
         J7fgN+EnJhSEb4n9mD0hne6OvMi73epVsVwcO+H55hEZWrZ7g7jw91OZNEMi/S+B6Ef0
         DuZSnlL3omQ5Hvadk51tji2ueRsLxdrr7BojpU48IOTEhfxLLQp9SpCTJdYAMTwbGwNp
         OzSw==
X-Gm-Message-State: AO0yUKWpAK1i+FTV4PHGkdr5jhw7hJnzzNNulYYl/rQac+5NROB3tt91
        gEUk6kxnF1Cs70gc89oNJjlM5K5BBJoVPhMc
X-Google-Smtp-Source: AK7set+VN154o5HYEXLyYzceYsxMjWF7xqCTBzBvD1DF80PZB4FAd3bVA3SAcm+ftMrJgNi5gBcRcA==
X-Received: by 2002:a17:902:dad0:b0:199:1f42:8bed with SMTP id q16-20020a170902dad000b001991f428bedmr14338448plx.12.1676264062760;
        Sun, 12 Feb 2023 20:54:22 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:22 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 14/20] riscv: audit mode for cfi violations
Date:   Sun, 12 Feb 2023 20:53:43 -0800
Message-Id: <20230213045351.3945824-15-debug@rivosinc.com>
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

Adding an audit mode per task which suppresses cfi violations reported
as illegal instruction exception.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/processor.h | 3 ++-
 arch/riscv/kernel/process.c        | 2 ++
 arch/riscv/kernel/traps.c          | 7 ++++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f065309927b1..39c36f739ebb 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -45,7 +45,8 @@ struct thread_struct {
 struct cfi_status {
 	unsigned int ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
 	unsigned int ubcfi_en : 1; /* Enable for backward cfi. */
-	unsigned int rsvd1 : 30;
+	unsigned int audit_mode : 1;
+	unsigned int rsvd1 : 29;
 	unsigned int lp_label; /* saved label value (25bit) */
 	long user_shdw_stk; /* Current user shadow stack pointer */
 	long shdw_stk_base; /* Base address of shadow stack */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index db676262e61e..bfd8511914d9 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -246,11 +246,13 @@ int arch_elf_setup_cfi_state(const struct arch_elf_state *state)
 
 		info->user_cfi_state.user_shdw_stk = (shadow_stack_base + shadow_stk_size);
 		info->user_cfi_state.shdw_stk_base = shadow_stack_base;
+		info->user_cfi_state.audit_mode = 1;
 	}
 	/* setup forward cfi state */
 	if (arch_supports_indirect_br_lp_instr() && (state->flags & RISCV_ELF_FCFI)) {
 		info->user_cfi_state.ufcfi_en = 1;
 		info->user_cfi_state.lp_label = 0;
+		info->user_cfi_state.audit_mode = 1;
 	}
 
 	return ret;
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index a292699f4f25..1901a8b73de5 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -165,6 +165,7 @@ int handle_illegal_instruction(struct pt_regs *regs)
 	if (arch_supports_indirect_br_lp_instr() &&
 #ifdef CONFIG_USER_INDIRECT_BR_LP
 	    info->user_cfi_state.ufcfi_en &&
+	    info->user_cfi_state.audit_mode &&
 #endif
 	    (regs->status & SR_ELP)) {
 		pr_warn("cfi violation (elp): comm = %s, task = %p\n", task->comm, task);
@@ -172,7 +173,11 @@ int handle_illegal_instruction(struct pt_regs *regs)
 		return 0;
 	}
 	/* if faulting opcode is sscheckra/lpcll/lpcml/lpcll, advance PC and resume */
-	if (is_cfi_violation_insn(insn)) {
+	if (is_cfi_violation_insn(insn)
+#if defined(CONFIG_USER_SHADOW_STACK) || defined(CONFIG_USER_INDIRECT_BR_LP)
+	    && info->user_cfi_state.audit_mode
+#endif
+	) {
 		/* no compressed form for zisslpcfi instructions */
 		regs->epc += 4;
 		return 0;
-- 
2.25.1

