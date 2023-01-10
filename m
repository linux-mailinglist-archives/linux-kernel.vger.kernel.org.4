Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5321A6639F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbjAJH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjAJH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:27:19 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C46D5FC5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:26:03 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7OcbD003934;
        Tue, 10 Jan 2023 08:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 07/22] tools/nolibc: export environ as a weak symbol on i386
Date:   Tue, 10 Jan 2023 08:24:19 +0100
Message-Id: <20230110072434.3863-8-w@1wt.eu>
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

