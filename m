Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF44A66208D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjAIItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjAIIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:48:15 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5DA2165B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:43:43 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3098gF7A027438;
        Mon, 9 Jan 2023 09:42:15 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 19/22] tools/nolibc: add auxiliary vector retrieval for s390
Date:   Mon,  9 Jan 2023 09:42:05 +0100
Message-Id: <20230109084208.27355-20-w@1wt.eu>
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

From: Sven Schnelle <svens@linux.ibm.com>

In the _start block we now iterate over envp to find the auxiliary
vector after the NULL. The pointer is saved into an _auxv variable
that is marked as weak so that it's accessible from multiple units.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-s390.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 039b454e79f0..6b0e54ed543d 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -160,6 +160,7 @@ struct sys_stat_struct {
 })
 
 char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
@@ -179,6 +180,15 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"larl	%r1,environ\n"
 		"stg	%r4,0(%r1)\n"
 
+		/* search for auxv */
+		"lgr	%r5,%r4\n"		/* start at envp */
+		"1:\n"
+		"clg	%r0,0(%r5)\n"		/* entry zero? */
+		"la	%r5,8(%r5)\n"		/* advance pointer */
+		"jnz	1b\n"			/* no -> test next pointer */
+		"larl	%r1,_auxv\n"		/* yes -> store value in _auxv */
+		"stg	%r5,0(%r1)\n"
+
 		"aghi	%r15,-160\n"		/* allocate new stackframe */
 		"xc	0(8,%r15),0(%r15)\n"	/* clear backchain */
 		"brasl	%r14,main\n"		/* ret value of main is arg to exit */
-- 
2.17.5

