Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06435662095
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjAIIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbjAIIsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:48:38 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDB3E17419
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:43:57 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gDk8027429;
        Mon, 9 Jan 2023 09:42:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 10/22] tools/nolibc: export environ as a weak symbol on mips
Date:   Mon,  9 Jan 2023 09:41:56 +0100
Message-Id: <20230109084208.27355-11-w@1wt.eu>
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
use it. This was tested with mips24kc (BE) both with environ inherited
from _start and extracted from envp.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-mips.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index a3764f6d267e..7d22f7bc38b3 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -176,6 +176,8 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;                                                 \
 })
 
+char **environ __attribute__((weak));
+
 /* startup code, note that it's called __start on MIPS */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
 {
@@ -191,6 +193,9 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
 		"sll $a2, $a0, 2\n"     // a2 = argc * 4
 		"add   $a2, $a2, $a1\n" // envp = argv + 4*argc ...
 		"addiu $a2, $a2, 4\n"   //        ... + 4
+		"lui $a3, %hi(environ)\n"     // load environ into a3 (hi)
+		"addiu $a3, %lo(environ)\n"   // load environ into a3 (lo)
+		"sw $a2,($a3)\n"              // store envp(a2) into environ
 		"li $t0, -8\n"
 		"and $sp, $sp, $t0\n"   // sp must be 8-byte aligned
 		"addiu $sp,$sp,-16\n"   // the callee expects to save a0..a3 there!
-- 
2.17.5

