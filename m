Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2876639FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbjAJHaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjAJH33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:29:29 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD7053725
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:27:03 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7OcV3003939;
        Tue, 10 Jan 2023 08:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 12/22] tools/nolibc: export environ as a weak symbol on s390
Date:   Tue, 10 Jan 2023 08:24:24 +0100
Message-Id: <20230110072434.3863-13-w@1wt.eu>
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

From: Sven Schnelle <svens@linux.ibm.com>

The environ is retrieved from the _start code and is easy to store at
this moment. Let's declare the variable weak and store the value into
it. By not being static it will be visible to all units. By being weak,
if some programs already declared it, they will continue to be able to
use it. This was tested on s390 both with environ inherited from
_start and extracted from envp.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-s390.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index b58f64d47b82..039b454e79f0 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -159,6 +159,8 @@ struct sys_stat_struct {
 	_arg1;								\
 })
 
+char **environ __attribute__((weak));
+
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
@@ -174,6 +176,8 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		"la	%r4,8(%r4)\n"		/* advance pointer */
 		"jnz	0b\n"			/* no -> test next pointer */
 						/* yes -> r4 now contains start of envp */
+		"larl	%r1,environ\n"
+		"stg	%r4,0(%r1)\n"
 
 		"aghi	%r15,-160\n"		/* allocate new stackframe */
 		"xc	0(8,%r15),0(%r15)\n"	/* clear backchain */
-- 
2.17.5

