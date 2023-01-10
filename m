Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F856639F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbjAJH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbjAJHZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:25:34 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5CF54A95F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:25:24 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7OdlZ003945;
        Tue, 10 Jan 2023 08:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 18/22] tools/nolibc: add auxiliary vector retrieval for mips
Date:   Tue, 10 Jan 2023 08:24:30 +0100
Message-Id: <20230110072434.3863-19-w@1wt.eu>
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

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-mips.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 7d22f7bc38b3..bf83432d23ed 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -177,6 +177,7 @@ struct sys_stat_struct {
 })
 
 char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
 
 /* startup code, note that it's called __start on MIPS */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
@@ -196,6 +197,16 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
 		"lui $a3, %hi(environ)\n"     // load environ into a3 (hi)
 		"addiu $a3, %lo(environ)\n"   // load environ into a3 (lo)
 		"sw $a2,($a3)\n"              // store envp(a2) into environ
+
+		"move $t0, $a2\n"             // iterate t0 over envp, look for NULL
+		"0:"                          // do {
+		"lw $a3, ($t0)\n"             //   a3=*(t0);
+		"bne $a3, $0, 0b\n"           // } while (a3);
+		"addiu $t0, $t0, 4\n"         // delayed slot: t0+=4;
+		"lui $a3, %hi(_auxv)\n"       // load _auxv into a3 (hi)
+		"addiu $a3, %lo(_auxv)\n"     // load _auxv into a3 (lo)
+		"sw $t0, ($a3)\n"             // store t0 into _auxv
+
 		"li $t0, -8\n"
 		"and $sp, $sp, $t0\n"   // sp must be 8-byte aligned
 		"addiu $sp,$sp,-16\n"   // the callee expects to save a0..a3 there!
-- 
2.17.5

