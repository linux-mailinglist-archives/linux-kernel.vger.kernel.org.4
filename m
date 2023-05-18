Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B436F70865C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjERREp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjERREn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:04:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DAE199
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:04:34 -0700 (PDT)
X-QQ-mid: bizesmtp70t1684429359tgkq75s7
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 19 May 2023 01:02:38 +0800 (CST)
X-QQ-SSF: 01200000000000C0V000000A0000000
X-QQ-FEAT: 83ShfzFP0oBUigIVReinYVVse+wZCQ1xyB9c0HLHomQcRIhIHH1Wbj3e7QJxl
        XRGA27Pmu0I1ZUz4S0zTfxBJxpCfVY2O9Br44TiESs6isz5Vtok9zA/tKqQIvvWrYlIROuQ
        VsD2bhbVu+YdqHdX2WGGQQw6BHsVl4Z09JVxFJM5MQcYeYxSk+6352EdRNFQ3hgEXSLPsK6
        QovuyY9gP1bqHyd5vMUnXOTo0nsszRnIY6GU2j5ZcqtHegYeeXIai6gsSucGfGBHzffKm4C
        jGFszYGPzvI101y+uvQLGL7xjE/aa444ATZrCbazXXe267+pOQOFXlumTidsRyO2v7gjq+7
        pcRoZsDZ0W0oy7EGPePzY2orOyZI5oF1gzrkbGSrZrveR9gzn4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13521670369968386674
From:   Zhangjin Wu <falcon@tinylab.org>
To:     Willy Tarreau <w@1wt.eu>, Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>
Subject: [PATCH 1/2] tools/nolibc: riscv: Fix up load/store instructions for rv32
Date:   Fri, 19 May 2023 01:02:12 +0800
Message-Id: <1425d092ef4c1242646ede2bbcbc3ac945c2b274.1684425792.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684425792.git.falcon@tinylab.org>
References: <cover.1684425792.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-riscv.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index e197fcb10ac0..7d7c4beabb8d 100644
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
-		"lw    a0, 0(sp)\n"          // argc (a0) was in the stack
+		REG_L" a0, 0(sp)\n"          // argc (a0) was in the stack
 		"add   a1, sp, "SZREG"\n"    // argv (a1) = sp
 		"slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
 		"add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
@@ -189,14 +193,14 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 
 		"add   a3, a2, zero\n"       // iterate a3 over envp to find auxv (after NULL)
 		"0:\n"                       // do {
-		"ld    a4, 0(a3)\n"          //   a4 = *a3;
+		REG_L" a4, 0(a3)\n"          //   a4 = *a3;
 		"add   a3, a3, "SZREG"\n"    //   a3 += sizeof(void*);
 		"bne   a4, zero, 0b\n"       // } while (a4);
 		"lui   a4, %hi(_auxv)\n"     // a4 = &_auxv (high bits)
-		"sd    a3, %lo(_auxv)(a4)\n" // store a3 into _auxv
+		REG_S" a3, %lo(_auxv)(a4)\n" // store a3 into _auxv
 
-		"lui a3, %hi(environ)\n"     // a3 = &environ (high bits)
-		"sd a2,%lo(environ)(a3)\n"   // store envp(a2) into environ
+		"lui   a3, %hi(environ)\n"   // a3 = &environ (high bits)
+		REG_S" a2,%lo(environ)(a3)\n"// store envp(a2) into environ
 		"andi  sp,a1,-16\n"          // sp must be 16-byte aligned
 		"call  main\n"               // main() returns the status code, we'll exit with it.
 		"li a7, 93\n"                // NR_exit == 93
-- 
2.25.1

