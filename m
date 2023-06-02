Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8469171FCE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjFBI7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjFBI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:59:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784CE53;
        Fri,  2 Jun 2023 01:59:16 -0700 (PDT)
Date:   Fri, 02 Jun 2023 08:59:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685696353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzCUvK7VsvtUi6pVkojjKFhV5bxfWD/ubOOML8CJHr4=;
        b=nmU+nyLIeV3A0zgTlk5bmIsY6xNG4Cp7DSrEiAJzF+d5LsWEU1m4bNAHY+xiWEELFeuF9Q
        hlWxBaxYPFIWik0mN83Jxo6UIJTVO7ghYBx6wqL4OnT1jUp0hQjfVfh6/eBiBjdjkcEQ2h
        nxGCkMGJmVUETeaGcJRxJ3kV+liPzkG4dFKaH1gJXmKwxAwttEkjzyE0MtInNdxnux/keU
        /pqb0qjpEyBuJsjmJAyIYTrG/wqGvVydMRNU2sV0SuUoFhQx6XjscO+rXFE4ePtmzQ4Q5l
        EgcpxN6qT22I5yM+MJsSszW6ehbLT1HdMiM3QGD8bm36tPnCEMJqQtNdu2iZGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685696353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzCUvK7VsvtUi6pVkojjKFhV5bxfWD/ubOOML8CJHr4=;
        b=q5wsCAq8APdqKOSiDdVKBlFJtH53WukIq3p6z/zS6XrmGLI2h9s8tOfiXy7BTnH6SwxugB
        zepCg+MxMOo2q0Ag==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/lib: Make get/put_user() exception handling a
 visible symbol
Cc:     Nadav Amit <namit@vmware.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230525184244.2311-1-namit@vmware.com>
References: <20230525184244.2311-1-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <168569635294.404.854143587019790184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     5516c89d58283413134f8d26960c6303d5d5bd89
Gitweb:        https://git.kernel.org/tip/5516c89d58283413134f8d26960c6303d5d5bd89
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Thu, 25 May 2023 11:42:44 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 02 Jun 2023 10:51:46 +02:00

x86/lib: Make get/put_user() exception handling a visible symbol

The .L-prefixed exception handling symbols of get_user() and put_user()
do get discarded from the symbol table of the final kernel image.

This confuses tools which parse that symbol table and try to map the
chunk of code to a symbol. And, in general, from toolchain perspective,
it is a good practice to have all code belong to a symbol, and the
correct one at that.

  ( Currently, objdump displays that exception handling chunk as part
    of the previous symbol which is a "fallback" of sorts and not
    correct. )

While at it, rename them to something more descriptive.

  [ bp: Rewrite commit message, rename symbols. ]

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230525184244.2311-1-namit@vmware.com
---
 arch/x86/lib/getuser.S | 32 ++++++++++++++++----------------
 arch/x86/lib/putuser.S | 24 ++++++++++++------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index b64a2bd..9c63713 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -143,43 +143,43 @@ SYM_FUNC_END(__get_user_nocheck_8)
 EXPORT_SYMBOL(__get_user_nocheck_8)
 
 
-SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
+SYM_CODE_START_LOCAL(__get_user_handle_exception)
 	ASM_CLAC
 .Lbad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
 	RET
-SYM_CODE_END(.Lbad_get_user_clac)
+SYM_CODE_END(__get_user_handle_exception)
 
 #ifdef CONFIG_X86_32
-SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
+SYM_CODE_START_LOCAL(__get_user_8_handle_exception)
 	ASM_CLAC
 bad_get_user_8:
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX
 	RET
-SYM_CODE_END(.Lbad_get_user_8_clac)
+SYM_CODE_END(__get_user_8_handle_exception)
 #endif
 
 /* get_user */
-	_ASM_EXTABLE(1b, .Lbad_get_user_clac)
-	_ASM_EXTABLE(2b, .Lbad_get_user_clac)
-	_ASM_EXTABLE(3b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(1b, __get_user_handle_exception)
+	_ASM_EXTABLE(2b, __get_user_handle_exception)
+	_ASM_EXTABLE(3b, __get_user_handle_exception)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(4b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(4b, __get_user_handle_exception)
 #else
-	_ASM_EXTABLE(4b, .Lbad_get_user_8_clac)
-	_ASM_EXTABLE(5b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(4b, __get_user_8_handle_exception)
+	_ASM_EXTABLE(5b, __get_user_8_handle_exception)
 #endif
 
 /* __get_user */
-	_ASM_EXTABLE(6b, .Lbad_get_user_clac)
-	_ASM_EXTABLE(7b, .Lbad_get_user_clac)
-	_ASM_EXTABLE(8b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(6b, __get_user_handle_exception)
+	_ASM_EXTABLE(7b, __get_user_handle_exception)
+	_ASM_EXTABLE(8b, __get_user_handle_exception)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(9b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(9b, __get_user_handle_exception)
 #else
-	_ASM_EXTABLE(9b, .Lbad_get_user_8_clac)
-	_ASM_EXTABLE(10b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(9b, __get_user_8_handle_exception)
+	_ASM_EXTABLE(10b, __get_user_8_handle_exception)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 3062d09..1451e0c 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -131,22 +131,22 @@ SYM_FUNC_START(__put_user_nocheck_8)
 SYM_FUNC_END(__put_user_nocheck_8)
 EXPORT_SYMBOL(__put_user_nocheck_8)
 
-SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
+SYM_CODE_START_LOCAL(__put_user_handle_exception)
 	ASM_CLAC
 .Lbad_put_user:
 	movl $-EFAULT,%ecx
 	RET
-SYM_CODE_END(.Lbad_put_user_clac)
+SYM_CODE_END(__put_user_handle_exception)
 
-	_ASM_EXTABLE(1b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(2b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(3b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(4b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(5b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(6b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(7b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(9b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(1b, __put_user_handle_exception)
+	_ASM_EXTABLE(2b, __put_user_handle_exception)
+	_ASM_EXTABLE(3b, __put_user_handle_exception)
+	_ASM_EXTABLE(4b, __put_user_handle_exception)
+	_ASM_EXTABLE(5b, __put_user_handle_exception)
+	_ASM_EXTABLE(6b, __put_user_handle_exception)
+	_ASM_EXTABLE(7b, __put_user_handle_exception)
+	_ASM_EXTABLE(9b, __put_user_handle_exception)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE(8b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(10b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(8b, __put_user_handle_exception)
+	_ASM_EXTABLE(10b, __put_user_handle_exception)
 #endif
