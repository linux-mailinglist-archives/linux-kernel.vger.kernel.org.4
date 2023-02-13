Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B38693DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjBMEzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjBMEzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:55:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED31259C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mg23so4213183pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zsprz/VkYP6JnZQvaX4OtVPneKai8SEDj1BTi+BhY/U=;
        b=7eSn2qdyORPNxiUoyovTXFhpXsZHqi8gnCLRE8GgSFK5tj4/mM+NE2BEscg9ShWtpB
         PzxBxeovnUU8KeQiZs+IWnuGNyAcMW1KXbhp2VQESntSd2LWuz+pzNCUJWIPxB0JU5Ab
         EesW3hY9NeyIHHfTNOmY/6BwGaMaUJiMo3GIx05W9NZJ0qvDJ0bluOBnu//KNpG2uyou
         4SOQKrmR4F5ng8nIZLAVUY7neQXbZCIE2lfTveTDHH94wb4oRM14reOmS/4svizRqEPL
         rwqB8M6hauOSNhA0VumODFAY0bMXd/4v8bTFTh5K1IeqLZXyl0c6K01GuPfSNRRgUsul
         zsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zsprz/VkYP6JnZQvaX4OtVPneKai8SEDj1BTi+BhY/U=;
        b=KWlesAxu7Vy7JaA/Nv+cRIDmhRRzj5URzy+6hr0aMpCAZdN1IAmVt1KyoSjaYCg2c4
         E+deg93f/0h0ZRhjRBKnHloVUxGNgzy9md4Xrj199NPnT04OVXPZesqtRczr87DzJ92m
         HeaKA+JKI9JXdigEF1nn0WDJ25+W1qLBBB5YqVuIj9AjIOfC3y0xyckEkXMY112uAvQn
         R96X8AopmxlmelZUyKtbm1R6sXGB9KTVcXvxM1I9keUa8h1brb/Ors9I2nkk0buw6xDr
         lYNbhtVRNux5YbcMwKiAJGfTlIkDhdjUsYbHLXAGrTbWBuPUczRfSOpRvf1X+cVtq8DD
         inGA==
X-Gm-Message-State: AO0yUKUEh9g4rve6uvYuS34Qh6CI58Vz9QBPK5zxnhVng5Pbq5EKkc17
        tQOTdlsu2k1yoAS0fSV61ZQ0A0HM3Pq2yVgp
X-Google-Smtp-Source: AK7set/p0rkBQR17h7qM1KcTLnHTByuWpmwwvmpl6P367bUJpgMQejcCNRaERuAYYCD3D7dwaqjSJg==
X-Received: by 2002:a17:902:e545:b0:199:60:b9c8 with SMTP id n5-20020a170902e54500b001990060b9c8mr29757848plf.45.1676264068264;
        Sun, 12 Feb 2023 20:54:28 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:27 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 18/20] riscv signal: Save and restore of shadow stack for signal
Date:   Sun, 12 Feb 2023 20:53:47 -0800
Message-Id: <20230213045351.3945824-19-debug@rivosinc.com>
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

Save shadow stack pointer in ucontext structure while delivering signal.
Restore shadow stack pointer from ucontext on sigreturn.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/signal.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index bfb2afa4135f..b963bbce5879 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -103,6 +103,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
 	struct task_struct *task;
+	struct thread_info *info = NULL;
 	sigset_t set;
 
 	/* Always make any pending restarted system calls return -EINTR */
@@ -124,6 +125,27 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+#if defined(CONFIG_USER_SHADOW_STACK)
+	/*
+	 * TODO: Restore shadow stack as a form of token stored on shadow stack itself as a safe
+	 * way to restore.
+	 * A token on shadow gives following properties
+	 *	- Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *	  must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *	  stack must check the token before restore. Since writing to shadow stack with
+	 *	  address of shadow stack itself is not easily allowed. A restore without a save
+	 *	  is quite difficult for an attacker to perform.
+	 *	- A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *	  So a single linear range can be bucketed into different shadow stack segments.
+	 *	  Any sspop; sscheckra will detect the condition and fault to kernel.
+	 */
+	info = current_thread_info();
+	if (info->user_cfi_state.ubcfi_en &&
+	    __copy_from_user(&info->user_cfi_state.user_shdw_stk, &frame->uc.uc_ss_ptr,
+				sizeof(unsigned long)))
+		goto badframe;
+#endif
+
 	regs->cause = -1UL;
 
 	return regs->a0;
@@ -180,6 +202,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
+	struct thread_info *info = NULL;
 	long err = 0;
 
 	frame = get_sigframe(ksig, regs, sizeof(*frame));
@@ -191,6 +214,23 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	/* Create the ucontext. */
 	err |= __put_user(0, &frame->uc.uc_flags);
 	err |= __put_user(NULL, &frame->uc.uc_link);
+#if defined(CONFIG_USER_SHADOW_STACK)
+	/*
+	 * TODO: Save a pointer to shadow stack itself on shadow stack as a form of token.
+	 * A token on shadow gives following properties
+	 *	- Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *	  must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *	  stack must check the token before restore. Since writing to shadow stack with
+	 *	  address of shadow stack itself is not easily allowed. A restore without a save
+	 *	  is quite difficult for an attacker to perform.
+	 *	- A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *	  So a single linear range can be bucketed into different shadow stack segments. Any
+	 *	  sspop; sscheckra will detect the condition and fault to kernel.
+	 */
+	info = current_thread_info();
+	if (info->user_cfi_state.ubcfi_en)
+		err |= __put_user(info->user_cfi_state.user_shdw_stk, &frame->uc.uc_ss_ptr);
+#endif
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigcontext(frame, regs);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
@@ -201,6 +241,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 #ifdef CONFIG_MMU
 	regs->ra = (unsigned long)VDSO_SYMBOL(
 		current->mm->context.vdso, rt_sigreturn);
+#if defined(CONFIG_USER_SHADOW_STACK)
+	/* if bcfi is enabled x1 (ra) and x5 (t0) must match */
+	if (info->user_cfi_state.ubcfi_en)
+		regs->t0 = regs->ra;
+#endif
 #else
 	/*
 	 * For the nommu case we don't have a VDSO.  Instead we push two
-- 
2.25.1

