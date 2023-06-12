Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A641C72D0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbjFLUsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbjFLUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD12947
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7891762EFF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0971C433B4;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=fq9Novytq9EKJSJOpiX99BQ9yCRZSIhHk3PPBCKpdpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkSeDAmaew4avDeeKGbVMWmJIg8UX9nNJdjMiuk1Fx30gwqYD40eUrLLhLve/qfB9
         7i2b265TDipJXOgn8Rj/LCefmQvvlQ3AchyTC5SunbYhD68VLY5FVWQW1M9EWPMPF9
         CeR4dNYL/T6pui29UWb+t6/tuTJ3JYNLY5Az3PuIZBoQJTAZMTF2z0cbJQ1kJPKL0y
         bvmTbiwEOMiXA0amQ7pF6nM0n1mAR/4RqbiUFmR57OhPaspoGTbzF4hCBC3p1ln+8k
         o5Kj8ZrxrCagR1EpTlkINX2wzXYgS9ygFYQrua/8MkpELY6oT/R5vv/lQ3i7xQ96E7
         kvr+uOK0xhMNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD581CE3A57; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 16/53] tools/nolibc: riscv: Fix up load/store instructions for rv32
Date:   Mon, 12 Jun 2023 13:44:37 -0700
Message-Id: <20230612204514.292087-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

When compile nolibc application for rv32, we got such errors:
  nolibc/sysroot/riscv/include/arch.h:190: Error: unrecognized opcode `ld a4,0(a3)'
  nolibc/sysroot/riscv/include/arch.h:194: Error: unrecognized opcode `sd a3,%lo(_auxv)(a4)'
  nolibc/sysroot/riscv/include/arch.h:196: Error: unrecognized opcode `sd a2,%lo(environ)(a3)'

Refer to arch/riscv/include/asm/asm.h and add REG_L/REG_S macros here to let
rv32 uses its own lw/sw instructions.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-riscv.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 0d5f15fdedc4..992a1739dd9c 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -33,9 +33,13 @@ struct sys_stat_struct {
 #if   __riscv_xlen == 64
 #define PTRLOG "3"
 #define SZREG  "8"
+#define REG_L  "ld"
+#define REG_S  "sd"
 #elif __riscv_xlen == 32
 #define PTRLOG "2"
 #define SZREG  "4"
+#define REG_L  "lw"
+#define REG_S  "sw"
 #endif
 
 /* Syscalls for RISCV :
@@ -181,7 +185,7 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		".option norelax\n"
 		"lla   gp, __global_pointer$\n"
 		".option pop\n"
-		"lw    a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
+		REG_L" a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
 		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
 		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
 		"add   a2, a2, "SZREG"\n"    /*             + SZREG (skip null)                     */
@@ -189,14 +193,14 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 
 		"add   a3, a2, zero\n"       /* iterate a3 over envp to find auxv (after NULL)      */
 		"0:\n"                       /* do {                                                */
-		"ld    a4, 0(a3)\n"          /*   a4 = *a3;                                         */
+		REG_L" a4, 0(a3)\n"          /*   a4 = *a3;                                         */
 		"add   a3, a3, "SZREG"\n"    /*   a3 += sizeof(void*);                              */
 		"bne   a4, zero, 0b\n"       /* } while (a4);                                       */
 		"lui   a4, %hi(_auxv)\n"     /* a4 = &_auxv (high bits)                             */
-		"sd    a3, %lo(_auxv)(a4)\n" /* store a3 into _auxv                                 */
+		REG_S" a3, %lo(_auxv)(a4)\n" /* store a3 into _auxv                                 */
 
-		"lui a3, %hi(environ)\n"     /* a3 = &environ (high bits)                           */
-		"sd a2,%lo(environ)(a3)\n"   /* store envp(a2) into environ                         */
+		"lui   a3, %hi(environ)\n"   /* a3 = &environ (high bits)                           */
+		REG_S" a2,%lo(environ)(a3)\n"/* store envp(a2) into environ                         */
 		"andi  sp,a1,-16\n"          /* sp must be 16-byte aligned                          */
 		"call  main\n"               /* main() returns the status code, we'll exit with it. */
 		"li a7, 93\n"                /* NR_exit == 93                                       */
-- 
2.40.1

