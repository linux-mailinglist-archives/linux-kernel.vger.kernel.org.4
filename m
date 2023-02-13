Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112FF693DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBMEzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBMEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:57 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803DB12075
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w5so12280535plg.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sWo6wCd+6s/qv8qKQzFAIRIpzM1RXjpCLCKpSqwk7c=;
        b=wt3q+VJD6Cp/b63Im6YhKcHv2i1AyapK9Tkrv/Lhww4i7czsTc+eUGnKJic8SCla3/
         PZeWAHDzQcpwxfG87wj9siHJ53pcxmGJj0Al/qZsMz4b8wLG4BExSAIQ4Nh0yVWI8eA1
         mdxKCUjoG1enCDnovmujulzh9ivudh8B7fewqOfdwU/ZGjXrEe0tnW65F6JP3I73DJ0O
         2pC+POBx+yCDZm97cI3uisSvoGWjp5y005oxdW98wIerdHNjp+Fv0zqfuea3nWldQhEm
         4GleUJiZnFqHyNc5rExalqnFx+zUnW254K9Y/BfKidu8I/uoOfcdaSt+6r9FSxD1x7yu
         usKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sWo6wCd+6s/qv8qKQzFAIRIpzM1RXjpCLCKpSqwk7c=;
        b=ExZZu32YbwV/8h9JtlyYceJ7uYhpMhk4nLvtbOYFcF5i5NHcWqywjy/z0P+wnJigkO
         gI2NBAwl5JaxHxSPoXKoW7d2JEOZ2ZllJGO/QtvM4CTJE21TMnJLthb/OqmIsbNoPUin
         rV2r5oYzk2wgh3bgsdLfPhuNeTjRWAKDhl68kvXcJfRmLIl3CGPZ/BAfOonKDZR0WWiV
         QqWv7AFrcL32Ikgi95Uioa+609NmshCbNBH/4q1EbJJ1FupwZm3ME81Y/4covch788qB
         mbq295PrsddDBzDF6Y7iOX1HMDUgajcxbWDqiFnnKXxeKmSem6evloZVfs0OeEy5xbjH
         ZSrw==
X-Gm-Message-State: AO0yUKWhjPkT+E7UTfuCvflheVpc5MFI2Z7ipuNJUuEUVg8hZo/zYMxE
        xzt54mUkBH6/GMkUIhnOImmrz+KUk5MNbD7G
X-Google-Smtp-Source: AK7set/We3gZfKBWsBui9LQ+h2dQamScS+mnmA55bftJ1qX9qQdJsEmqonYKb0jOGqlzZmSqaU7JgA==
X-Received: by 2002:a17:903:124b:b0:19a:9406:b234 with SMTP id u11-20020a170903124b00b0019a9406b234mr5720720plh.45.1676264065599;
        Sun, 12 Feb 2023 20:54:25 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:25 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 16/20] riscv: Implements sslp prctls
Date:   Sun, 12 Feb 2023 20:53:45 -0800
Message-Id: <20230213045351.3945824-17-debug@rivosinc.com>
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

New prctls are PR_GET_SHADOW_STACK_STATUS/PR_SET_SHADOW_STACK_STATUS and
PR_GET_INDIRECT_BR_LP_STATUS/PR_SET_INDIRECT_BR_LP_STATUS are implemented
on riscv in this patch.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/processor.h |  4 +-
 arch/riscv/kernel/process.c        | 88 +++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 39c36f739ebb..c088584580b4 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -46,7 +46,9 @@ struct cfi_status {
 	unsigned int ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
 	unsigned int ubcfi_en : 1; /* Enable for backward cfi. */
 	unsigned int audit_mode : 1;
-	unsigned int rsvd1 : 29;
+	unsigned int ufcfi_locked : 1;
+	unsigned int ubcfi_locked : 1;
+	unsigned int rsvd1 : 27;
 	unsigned int lp_label; /* saved label value (25bit) */
 	long user_shdw_stk; /* Current user shadow stack pointer */
 	long shdw_stk_base; /* Base address of shadow stack */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index bfd8511914d9..1218ed4fd29f 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -257,4 +257,90 @@ int arch_elf_setup_cfi_state(const struct arch_elf_state *state)
 
 	return ret;
 }
-#endif
\ No newline at end of file
+#endif
+
+#ifdef CONFIG_USER_SHADOW_STACK
+int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long bcfi_status = 0;
+	struct thread_info *info = NULL;
+
+	if (!arch_supports_shadow_stack())
+		return -EINVAL;
+
+	info = current_thread_info();
+	bcfi_status |= info->user_cfi_state.ubcfi_locked ? (1UL << 0) : 0;
+	bcfi_status |= info->user_cfi_state.ubcfi_en ? ((1UL << 1) |
+		       (info->user_cfi_state.user_shdw_stk)) : 0;
+
+	return copy_to_user(status, &bcfi_status, sizeof(bcfi_status)) ? -EFAULT : 0;
+}
+
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long bcfi_status = 0;
+	struct thread_info *info = NULL;
+	unsigned long shdw_stk = 0;
+
+	if (!arch_supports_shadow_stack())
+		return -EINVAL;
+
+	info = current_thread_info();
+	/* bcfi status is locked and further can't be modified by user */
+	if (info->user_cfi_state.ubcfi_locked)
+		return -EINVAL;
+
+	if (copy_from_user(&bcfi_status, status, sizeof(bcfi_status)))
+		return -EFAULT;
+	/* clear two least significant bits. Always assume min 4 byte alignment */
+	shdw_stk = (long) (bcfi_status & (~3));
+
+	if (shdw_stk >= TASK_SIZE)
+		return -EINVAL;
+
+	info->user_cfi_state.ubcfi_en = (bcfi_status & (1UL << 1)) ? 1 : 0;
+	info->user_cfi_state.ubcfi_locked = (bcfi_status & (1UL << 0)) ? 1 : 0;
+	info->user_cfi_state.user_shdw_stk = (long) shdw_stk;
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_USER_INDIRECT_BR_LP
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long fcfi_status = 0;
+	struct thread_info *info = NULL;
+
+	if (!arch_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	info = current_thread_info();
+	fcfi_status |= info->user_cfi_state.ufcfi_locked ? (1UL << 0) : 0;
+	fcfi_status |= info->user_cfi_state.ufcfi_en ? (1UL << 1) : 0;
+
+	return copy_to_user(status, &fcfi_status, sizeof(fcfi_status)) ? -EFAULT : 0;
+}
+
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long fcfi_status = 0;
+	struct thread_info *info = NULL;
+
+	if (!arch_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	info = current_thread_info();
+	/* bcfi status is locked and further can't be modified by user */
+	if (info->user_cfi_state.ufcfi_locked)
+		return -EINVAL;
+
+	if (copy_from_user(&fcfi_status, status, sizeof(fcfi_status)))
+		return -EFAULT;
+
+	info->user_cfi_state.ufcfi_en = (fcfi_status & (1UL << 1)) ? 1 : 0;
+	info->user_cfi_state.ufcfi_locked = (fcfi_status & (1UL << 0)) ? 1 : 0;
+
+	return 0;
+}
+#endif
-- 
2.25.1

