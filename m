Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2E6639F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjAJH3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbjAJH2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:28:44 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DC9B4FCC2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:26:35 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7OcXA003936;
        Tue, 10 Jan 2023 08:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 09/22] tools/nolibc: export environ as a weak symbol on arm
Date:   Tue, 10 Jan 2023 08:24:21 +0100
Message-Id: <20230110072434.3863-10-w@1wt.eu>
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

The environ is retrieved from the _start code and is easy to store at
this moment. Let's declare the variable weak and store the value into
it. By not being static it will be visible to all units. By being weak,
if some programs already declared it, they will continue to be able to
use it. This was tested in arm and thumb1 and thumb2 modes, and for each
mode, both with environ inherited from _start and extracted from envp.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-arm.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 48bd95492c87..79666b590e87 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -196,6 +196,8 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
+char **environ __attribute__((weak));
+
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
@@ -206,6 +208,8 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"add %r2, %r0, $1\n"          // envp = (argc + 1) ...
 		"lsl %r2, %r2, $2\n"          //        * 4        ...
 		"add %r2, %r2, %r1\n"         //        + argv
+		"ldr %r3, 1f\n"               // r3 = &environ (see below)
+		"str %r2, [r3]\n"             // store envp into environ
 
 		"mov %r3, $8\n"               // AAPCS : sp must be 8-byte aligned in the
 		"neg %r3, %r3\n"              //         callee, and bl doesn't push (lr=pc)
@@ -215,7 +219,10 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"bl main\n"                   // main() returns the status code, we'll exit with it.
 		"movs r7, $1\n"               // NR_exit == 1
 		"svc $0x00\n"
-	  );
+		".align 2\n"                  // below are the pointers to a few variables
+		"1:\n"
+		".word environ\n"
+	);
 	__builtin_unreachable();
 }
 
-- 
2.17.5

