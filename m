Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DA86EC2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 00:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDWWcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 18:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 18:32:19 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E111A4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 15:32:19 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b64ada305so4699753b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682289138; x=1684881138;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JOxROQal6cA2b9nVh8lVusUL2vjzy13mIsW+Lwv9jHs=;
        b=ZI+CBW2XxeN2IpKi/yqKtcV5tOtRGnHPi3UzIKorT7JYnj/I+50lqJj6RJvBPhth77
         XP7iLxnGT3sh6X2DkB0DtRiBC5hbiGp0FeZBzXyGmU8vVMqk/8LvAGY/5o9cu9YNPTxz
         ajp5IK4mjalS57f0R6oNLx2D9jO0K9UWcbowcFTUleKSAugdsK8AX+WD1kA8H1ASJsJ2
         savb90VOmo0RFjTjImLZFmZ5D1ksMVzfCfPhGGYAldx9mvtgpGBZ+CWEmUOesfb7puTb
         +B5wc0kLNGJZnMOjXX4Hli6vECUujnqGrq4cuZ2PQFnvL2nb3/MnBR7Ygn3/IE3MYsU2
         RV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682289138; x=1684881138;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOxROQal6cA2b9nVh8lVusUL2vjzy13mIsW+Lwv9jHs=;
        b=bz7wd00KIQVH87o+oZdEd9nJLvHUjNTrtlgqQ7gXJVry6WSoNGajY4KmpQWQQ8cOkf
         eVyuvTxZUH0ARgcS/1rmF0fprig7Egf0ZqBoMZIl8mZlI8g4ISqUkJQiaTaUJZqsC8EO
         /pS2FSX3UnQrAtx68ZTbhj4/7EjN2k/6+1ObsnZ4XXWYngdUo8IBM6NLVz/GWy/J3Khz
         Qq5cNGzMC/EyDGMhl1DRwLet3v//CnlM2bYPqOQmhV2pnlT6ZFUSirUm7KKTWTXoepxu
         d5NyxXj7/qMUaL4+jZVTf6shFWZ6wpQn1cTRo8UNLymk1lu3AX9pE2YTn9B8Sb+mOE6s
         pjiw==
X-Gm-Message-State: AAQBX9ebMU+ivBY0iZfiqoOJXYGqVVKAPrmdHvl1tKBqCAoiC4cgoTCC
        e+AT7ryrtMTuIJrnsNw+x9tYA9XAEtaL
X-Google-Smtp-Source: AKy350bQrjBRDCACPQikFKADUWF2WW/fppn+Q+GDorzkU2RbyvCdQq8amt1ztzMepbCggXkGjlV4ll+h+03M
X-Received: from meowing-l.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3eba])
 (user=maskray job=sendgmr) by 2002:a05:6a00:1a53:b0:63d:46f0:2370 with SMTP
 id h19-20020a056a001a5300b0063d46f02370mr4945410pfv.6.1682289138662; Sun, 23
 Apr 2023 15:32:18 -0700 (PDT)
Date:   Sun, 23 Apr 2023 22:32:10 +0000
Mime-Version: 1.0
Message-ID: <20230423223210.126948-1-maskray@google.com>
Subject: [PATCH] riscv: replace deprecated scall with ecall
From:   Fangrui Song <maskray@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scall is a deprecated alias for ecall. ecall is used in several places,
so there is no assembler compatibility concern.

Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/riscv/kernel/entry.S             | 4 ++--
 arch/riscv/kernel/vdso/rt_sigreturn.S | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 99d38fdf8b18..2f51935612d1 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -191,7 +191,7 @@ handle_syscall:
 	REG_S a0, PT_ORIG_A0(sp)
 	/*
 	 * Advance SEPC to avoid executing the original
-	 * scall instruction on sret
+	 * ecall instruction on sret
 	 */
 	addi s2, s2, 0x4
 	REG_S s2, PT_EPC(sp)
@@ -603,6 +603,6 @@ END(excp_vect_table)
 #ifndef CONFIG_MMU
 ENTRY(__user_rt_sigreturn)
 	li a7, __NR_rt_sigreturn
-	scall
+	ecall
 END(__user_rt_sigreturn)
 #endif
diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vdso/rt_sigreturn.S
index 0573705eac76..10438c7c626a 100644
--- a/arch/riscv/kernel/vdso/rt_sigreturn.S
+++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
@@ -11,6 +11,6 @@ ENTRY(__vdso_rt_sigreturn)
 	.cfi_startproc
 	.cfi_signal_frame
 	li a7, __NR_rt_sigreturn
-	scall
+	ecall
 	.cfi_endproc
 ENDPROC(__vdso_rt_sigreturn)
-- 
2.40.0.634.g4ca3ef3211-goog

