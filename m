Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE116639E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbjAJHZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAJHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:25:01 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DBA949160
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:24:53 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7OdnY003943;
        Tue, 10 Jan 2023 08:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 16/22] tools/nolibc: add auxiliary vector retrieval for arm
Date:   Tue, 10 Jan 2023 08:24:28 +0100
Message-Id: <20230110072434.3863-17-w@1wt.eu>
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

It was tested in arm, thumb1 and thumb2 modes.
---
 tools/include/nolibc/arch-arm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 79666b590e87..42499f23e73c 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -197,6 +197,7 @@ struct sys_stat_struct {
 })
 
 char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
@@ -211,6 +212,16 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"ldr %r3, 1f\n"               // r3 = &environ (see below)
 		"str %r2, [r3]\n"             // store envp into environ
 
+		"mov r4, r2\n"                // search for auxv (follows NULL after last env)
+		"0:\n"
+		"mov r5, r4\n"                // r5 = r4
+		"add r4, r4, #4\n"            // r4 += 4
+		"ldr r5,[r5]\n"               // r5 = *r5 = *(r4-4)
+		"cmp r5, #0\n"                // and stop at NULL after last env
+		"bne 0b\n"
+		"ldr %r3, 2f\n"               // r3 = &_auxv (low bits)
+		"str r4, [r3]\n"              // store r4 into _auxv
+
 		"mov %r3, $8\n"               // AAPCS : sp must be 8-byte aligned in the
 		"neg %r3, %r3\n"              //         callee, and bl doesn't push (lr=pc)
 		"and %r3, %r3, %r1\n"         // so we do sp = r1(=sp) & r3(=-8);
@@ -222,6 +233,8 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		".align 2\n"                  // below are the pointers to a few variables
 		"1:\n"
 		".word environ\n"
+		"2:\n"
+		".word _auxv\n"
 	);
 	__builtin_unreachable();
 }
-- 
2.17.5

