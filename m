Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19C662086
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbjAIIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbjAIIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:47:51 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAA0B15F06
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:43:32 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gDoH027426;
        Mon, 9 Jan 2023 09:42:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 07/22] tools/nolibc: export environ as a weak symbol on i386
Date:   Mon,  9 Jan 2023 09:41:53 +0100
Message-Id: <20230109084208.27355-8-w@1wt.eu>
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
 tools/include/nolibc/arch-i386.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index ef2a836ee667..60b586120727 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -178,6 +178,8 @@ struct sys_stat_struct {
 	_eax;							\
 })
 
+char **environ __attribute__((weak));
+
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -191,6 +193,7 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"pop %eax\n"                // argc   (first arg, %eax)
 		"mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
 		"lea 4(%ebx,%eax,4),%ecx\n" // then a NULL then envp (third arg, %ecx)
+		"mov %ecx, environ\n"       // save environ
 		"xor %ebp, %ebp\n"          // zero the stack frame
 		"and $-16, %esp\n"          // x86 ABI : esp must be 16-byte aligned before
 		"sub $4, %esp\n"            // the call instruction (args are aligned)
-- 
2.17.5

