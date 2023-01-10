Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860006639FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbjAJH3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbjAJH3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:29:23 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 193C453711
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:27:02 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7OcjL003938;
        Tue, 10 Jan 2023 08:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 11/22] tools/nolibc: export environ as a weak symbol on riscv
Date:   Tue, 10 Jan 2023 08:24:23 +0100
Message-Id: <20230110072434.3863-12-w@1wt.eu>
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
use it. This was tested on riscv64 both with environ inherited from
_start and extracted from envp.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-riscv.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index c2b5db383d96..1608e6bd94b9 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -170,6 +170,8 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
+char **environ __attribute__((weak));
+
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
@@ -183,6 +185,8 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
 		"add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
 		"add   a2,a2,a1\n"           //             + argv
+		"lui a3, %hi(environ)\n"     // a3 = &environ (high bits)
+		"sd a2,%lo(environ)(a3)\n"   // store envp(a2) into environ
 		"andi  sp,a1,-16\n"          // sp must be 16-byte aligned
 		"call  main\n"               // main() returns the status code, we'll exit with it.
 		"li a7, 93\n"                // NR_exit == 93
-- 
2.17.5

