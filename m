Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB876E2617
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDNOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDNOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:47:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B9B767;
        Fri, 14 Apr 2023 07:47:56 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpQp1L1uLgmErLsZ5BTeSfkrRYT17nARxSl8FG39kb4=;
        b=SMLQwEdQtAeSSqC4JZV1VavL/Nfnh6QhalXPHkIkYLDvcLEGkL+O/NrJzT69c3wCk4AWum
        tGOJZQYeQcQHDreaUSXEz8ogbyu6SwiJ6x7qED/GrNQJLap7IUKI8wUagsQiDK3+TOAjEi
        yN5sfFfkddnuj60JhT4M4u6RzRI1hDhwRmyk9I4i32VKH5xwHtqhYd9vUTHLGgJqRAnq04
        uVWhrPtVHv66rU/8owy/m8yq81XqkalOQZz7+C4i+218uBAR17C1kqO7l9hXJZqP3jspZG
        xUVw4PxIPdRVompekutwpm14gbvQZucVFSdixTHuNY2HfrouNoKjs+TY5ppkFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpQp1L1uLgmErLsZ5BTeSfkrRYT17nARxSl8FG39kb4=;
        b=DzWmPIZcmD7K5cIrT5OnPZQS0Isb0zJaQCeJ6Qg+5Y801h7gw3KsqSwRjaqqKTAJq0ljN6
        ChzTz8Yh8hr4p3DA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/linkage: Fix padding for typed functions
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <721f0da48d2a49fe907225711b8b76a2b787f9a8.1681331135.git.jpoimboe@kernel.org>
References: <721f0da48d2a49fe907225711b8b76a2b787f9a8.1681331135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367428.404.12784919569941633105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4a2c3448ed3d362431c249ec0eb0f90281804ea8
Gitweb:        https://git.kernel.org/tip/4a2c3448ed3d362431c249ec0eb0f90281804ea8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 13:26:14 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:30 +02:00

x86/linkage: Fix padding for typed functions

CFI typed functions are failing to get padded properly for
CONFIG_CALL_PADDING.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/721f0da48d2a49fe907225711b8b76a2b787f9a8.1681331135.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/linkage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index dd9b811..0953aa3 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -99,7 +99,7 @@
 
 /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
 #define SYM_TYPED_FUNC_START(name)				\
-	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
 	ENDBR
 
 /* SYM_FUNC_START -- use for global functions */
