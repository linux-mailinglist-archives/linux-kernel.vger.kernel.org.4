Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D6F662085
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjAIIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjAIIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:48:09 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E60C165A0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:43:39 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gDWp027427;
        Mon, 9 Jan 2023 09:42:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 08/22] tools/nolibc: export environ as a weak symbol on arm64
Date:   Mon,  9 Jan 2023 09:41:54 +0100
Message-Id: <20230109084208.27355-9-w@1wt.eu>
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
 tools/include/nolibc/arch-aarch64.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index f480993159ec..2e3d9adc4c4c 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -169,6 +169,8 @@ struct sys_stat_struct {
 	_arg1;                                                                \
 })
 
+char **environ __attribute__((weak));
+
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
@@ -178,6 +180,8 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"lsl x2, x0, 3\n"    // envp (x2) = 8*argc ...
 		"add x2, x2, 8\n"    //           + 8 (skip null)
 		"add x2, x2, x1\n"   //           + argv
+		"adrp x3, environ\n"          // x3 = &environ (high bits)
+		"str x2, [x3, #:lo12:environ]\n" // store envp into environ
 		"and sp, x1, -16\n"  // sp must be 16-byte aligned in the callee
 		"bl main\n"          // main() returns the status code, we'll exit with it.
 		"mov x8, 93\n"       // NR_exit == 93
-- 
2.17.5

