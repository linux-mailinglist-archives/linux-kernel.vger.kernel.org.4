Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3D6639FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbjAJHaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbjAJH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:29:31 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C76453704
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:27:06 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7Odop003941;
        Tue, 10 Jan 2023 08:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 14/22] tools/nolibc: add auxiliary vector retrieval for x86_64
Date:   Tue, 10 Jan 2023 08:24:26 +0100
Message-Id: <20230110072434.3863-15-w@1wt.eu>
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
 tools/include/nolibc/arch-x86_64.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 683702a16a61..17f6751208e7 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -179,6 +179,7 @@ struct sys_stat_struct {
 })
 
 char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
 /*
@@ -195,6 +196,12 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
 		"mov %rdx, environ\n"       // save environ
 		"xor %ebp, %ebp\n"          // zero the stack frame
+		"mov %rdx, %rax\n"          // search for auxv (follows NULL after last env)
+		"0:\n"
+		"add $8, %rax\n"            // search for auxv using rax, it follows the
+		"cmp -8(%rax), %rbp\n"      // ... NULL after last env (rbp is zero here)
+		"jnz 0b\n"
+		"mov %rax, _auxv\n"         // save it into _auxv
 		"and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
 		"call main\n"               // main() returns the status code, we'll exit with it.
 		"mov %eax, %edi\n"          // retrieve exit code (32 bit)
-- 
2.17.5

