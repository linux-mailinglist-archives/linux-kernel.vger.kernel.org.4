Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37904662082
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjAIIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbjAIIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:47:20 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E2FB15FE0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:43:20 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gCB9027425;
        Mon, 9 Jan 2023 09:42:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 06/22] tools/nolibc: export environ as a weak symbol on x86_64
Date:   Mon,  9 Jan 2023 09:41:52 +0100
Message-Id: <20230109084208.27355-7-w@1wt.eu>
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

The environ is retrieved from the _start code and is easy to store at
this moment. Let's declare the variable weak and store the value into
it. By not being static it will be visible to all units. By being weak,
if some programs already declared it, they will continue to be able to
use it. This was tested both with environ inherited from _start and
extracted from envp.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-x86_64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 8d482505c347..683702a16a61 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -178,6 +178,8 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
+char **environ __attribute__((weak));
+
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -191,6 +193,7 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"pop %rdi\n"                // argc   (first arg, %rdi)
 		"mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
 		"lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
+		"mov %rdx, environ\n"       // save environ
 		"xor %ebp, %ebp\n"          // zero the stack frame
 		"and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
 		"call main\n"               // main() returns the status code, we'll exit with it.
-- 
2.17.5

