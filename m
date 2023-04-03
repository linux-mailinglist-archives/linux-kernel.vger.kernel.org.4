Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8E36D3D99
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjDCGwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDCGwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE4F2727
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 23:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA50614FB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4493EC433EF;
        Mon,  3 Apr 2023 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680504734;
        bh=a/R10jH30vYnh+1wVVgBZesVEWx9VEabSFxoWE4WGaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PZjCGGdy918fsCIV2X7ji6gb3Dy7kLUZvge78w6piYQ0DQT26vfQkZHg1ffZkorWO
         Ep6okNEzf7o5LlKEoBg1ercBGYLyUlE4CNG9/sJ/RlIkr7ADq0Yeov3preu9D67xGd
         A/Fkj3TPKWa+uU/fkqkeeIODnngpg6TYD0M94porHImd6B20kTGQeIwW9yPuATQd27
         pg+kp41sRKtr+SaqbATMRdx4khZSNtThQnE0EwW89wGCNUmnquYEW/HQnjl9W2wCLf
         O9HhPb7WXLGbnP62cMrVTQui4zNO6YrU+zxA5HVieNzHsMNOzS7f71gUYvMGFKbrcs
         0vPeN8NRU/FWw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Yipeng Zou <zouyipeng@huawei.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH] riscv: entry: Save a0 prior syscall_enter_from_user_mode()
Date:   Mon,  3 Apr 2023 08:52:07 +0200
Message-Id: <20230403065207.1070974-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V calling convention passes the first argument, and the
return value in the a0 register. For this reason, the a0 register
needs some extra care; When handling syscalls, the a0 register is
saved into regs->orig_a0, so a0 can be properly restored for,
e.g. interrupted syscalls.

This functionality was broken with the introduction of the generic
entry patches. Here, a0 was saved into orig_a0 after calling
syscall_enter_from_user_mode(), which can change regs->a0 for some
paths, incorrectly restoring a0.

This is resolved, by saving a0 prior doing the
syscall_enter_from_user_mode() call.

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 1f4e37be7eb3..8c258b78c925 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -270,11 +270,11 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		ulong syscall = regs->a7;
 
-		syscall = syscall_enter_from_user_mode(regs, syscall);
-
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
 
+		syscall = syscall_enter_from_user_mode(regs, syscall);
+
 		if (syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
 		else

base-commit: d34a6b715a23ccd9c9d0bc7a475bea59dc3e28b2
-- 
2.37.2

