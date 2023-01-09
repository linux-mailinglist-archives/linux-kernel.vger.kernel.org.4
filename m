Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85C66207D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbjAIIqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjAIIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:45:56 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCD31140B4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:42:52 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gFrt027434;
        Mon, 9 Jan 2023 09:42:15 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 15/22] tools/nolibc: add auxiliary vector retrieval for arm64
Date:   Mon,  9 Jan 2023 09:42:01 +0100
Message-Id: <20230109084208.27355-16-w@1wt.eu>
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

In the _start block we now iterate over envp to find the auxiliary
vector after the NULL. The pointer is saved into an _auxv variable
that is marked as weak so that it's accessible from multiple units.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-aarch64.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 2e3d9adc4c4c..383baddef701 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -170,6 +170,7 @@ struct sys_stat_struct {
 })
 
 char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
@@ -182,6 +183,12 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"add x2, x2, x1\n"   //           + argv
 		"adrp x3, environ\n"          // x3 = &environ (high bits)
 		"str x2, [x3, #:lo12:environ]\n" // store envp into environ
+		"mov x4, x2\n"       // search for auxv (follows NULL after last env)
+		"0:\n"
+		"ldr x5, [x4], 8\n"  // x5 = *x4; x4 += 8
+		"cbnz x5, 0b\n"      // and stop at NULL after last env
+		"adrp x3, _auxv\n"   // x3 = &_auxv (high bits)
+		"str x4, [x3, #:lo12:_auxv]\n" // store x4 into _auxv
 		"and sp, x1, -16\n"  // sp must be 16-byte aligned in the callee
 		"bl main\n"          // main() returns the status code, we'll exit with it.
 		"mov x8, 93\n"       // NR_exit == 93
-- 
2.17.5

