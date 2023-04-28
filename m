Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0DC6F1493
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjD1JxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345686AbjD1Jwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:52:41 -0400
Received: from out0-202.mail.aliyun.com (out0-202.mail.aliyun.com [140.205.0.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058505BBE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:52:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.STFoGCe_1682675531;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFoGCe_1682675531)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:52:12 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "=?UTF-8?B?UGV0ZXIgWmlqbHN0cmEgKEludGVsKQ==?=" <peterz@infradead.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        "Arnd Bergmann" <arnd@arndb.de>
Subject: [PATCH RFC 11/43] x86/irq: Adapt assembly for PIE support
Date:   Fri, 28 Apr 2023 17:50:51 +0800
Message-Id: <38061a9bfc6f4a6b4bd9737d45ce4f551849ed08.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly options to work with pointers instead of integers.
The generated code is the same PIE just ensures input is a pointer.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/irq_stack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 798183867d78..caba5d1d0800 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -93,7 +93,7 @@
 	"popq	%%rsp					\n"		\
 									\
 	: "+r" (tos), ASM_CALL_CONSTRAINT				\
-	: [__func] "i" (func), [tos] "r" (tos) argconstr		\
+	: [__func] "X" (func), [tos] "r" (tos) argconstr		\
 	: "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10",	\
 	  "memory"							\
 	);								\
-- 
2.31.1

