Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E16639EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjAJH0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbjAJHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:25:31 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E81749172
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:25:16 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7OdiK003944;
        Tue, 10 Jan 2023 08:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 17/22] tools/nolibc: add auxiliary vector retrieval for riscv
Date:   Tue, 10 Jan 2023 08:24:29 +0100
Message-Id: <20230110072434.3863-18-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230110072434.3863-1-w@1wt.eu>
References: <20230110072434.3863-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the _start block we now iterate over envp to find the auxiliary
vector after the NULL. The pointer is saved into an _auxv variable
that is marked as weak so that it's accessible from multiple units.
It was tested on riscv64 only.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-riscv.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 1608e6bd94b9..e197fcb10ac0 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -171,6 +171,7 @@ struct sys_stat_struct {
 })
 
 char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
@@ -185,6 +186,15 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
 		"add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
 		"add   a2,a2,a1\n"           //             + argv
+
+		"add   a3, a2, zero\n"       // iterate a3 over envp to find auxv (after NULL)
+		"0:\n"                       // do {
+		"ld    a4, 0(a3)\n"          //   a4 = *a3;
+		"add   a3, a3, "SZREG"\n"    //   a3 += sizeof(void*);
+		"bne   a4, zero, 0b\n"       // } while (a4);
+		"lui   a4, %hi(_auxv)\n"     // a4 = &_auxv (high bits)
+		"sd    a3, %lo(_auxv)(a4)\n" // store a3 into _auxv
+
 		"lui a3, %hi(environ)\n"     // a3 = &environ (high bits)
 		"sd a2,%lo(environ)(a3)\n"   // store envp(a2) into environ
 		"andi  sp,a1,-16\n"          // sp must be 16-byte aligned
-- 
2.17.5

