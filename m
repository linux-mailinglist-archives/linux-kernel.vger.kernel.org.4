Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D42662077
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjAIIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjAIImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:42:39 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E9AD14026
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:42:33 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gCBD027421;
        Mon, 9 Jan 2023 09:42:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 02/22] tools/nolibc: enable support for thumb1 mode for ARM
Date:   Mon,  9 Jan 2023 09:41:48 +0100
Message-Id: <20230109084208.27355-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109084208.27355-1-w@1wt.eu>
References: <20230109084208.27355-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing -mthumb to the kernel.org arm toolchain failed to build because it
defaults to armv5 hence thumb1, which has a fairly limited instruction set
compared to thumb2 enabled with armv7 that is much more complete. It's not
very difficult to adjust the instructions to also build on thumb1, it only
adds a total of 3 instructions, so it's worth doing it at least to ease use
by casual testers. It was verified that the adjusted code now builds and
works fine for armv5, thumb1, armv7 and thumb2, as long as frame pointers
are not used.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-arm.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 875b21975137..e4ba77b0310f 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -180,10 +180,16 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 	__asm__ volatile (
 		"pop {%r0}\n"                 // argc was in the stack
 		"mov %r1, %sp\n"              // argv = sp
-		"add %r2, %r1, %r0, lsl #2\n" // envp = argv + 4*argc ...
-		"add %r2, %r2, $4\n"          //        ... + 4
-		"and %r3, %r1, $-8\n"         // AAPCS : sp must be 8-byte aligned in the
-		"mov %sp, %r3\n"              //         callee, an bl doesn't push (lr=pc)
+
+		"add %r2, %r0, $1\n"          // envp = (argc + 1) ...
+		"lsl %r2, %r2, $2\n"          //        * 4        ...
+		"add %r2, %r2, %r1\n"         //        + argv
+
+		"mov %r3, $8\n"               // AAPCS : sp must be 8-byte aligned in the
+		"neg %r3, %r3\n"              //         callee, and bl doesn't push (lr=pc)
+		"and %r3, %r3, %r1\n"         // so we do sp = r1(=sp) & r3(=-8);
+		"mov %sp, %r3\n"              //
+
 		"bl main\n"                   // main() returns the status code, we'll exit with it.
 		"movs r7, $1\n"               // NR_exit == 1
 		"svc $0x00\n"
-- 
2.17.5

