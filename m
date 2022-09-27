Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19505EC7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiI0Pdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiI0Pdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:33:50 -0400
Received: from mail-m118206.qiye.163.com (mail-m118206.qiye.163.com [115.236.118.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D9481C430A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:33:46 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118206.qiye.163.com (HMail) with ESMTPA id A789EBE0C0F;
        Tue, 27 Sep 2022 23:33:43 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     me@inclyc.cn
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Tue, 27 Sep 2022 23:33:38 +0800
Message-Id: <20220927153338.4177854-1-me@inclyc.cn>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220925153151.2467884-1-me@inclyc.cn>
References: <20220925153151.2467884-1-me@inclyc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWUNISEtWGUpPGh1MSENJSkJLVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hNSlVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NT46Dgw4TTkDLzcyQ1FNFAFM
        USwKCSNVSlVKTU1PSUJJQ0lPTkJCVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUhNTk03Bg++
X-HM-Tid: 0a837f95247a2d28kusna789ebe0c0f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WG14 N2350 made very clear that it is an UB having type definitions with
in "offsetof". This patch change the implementation of macro
"TYPE_ALIGN" to builtin "_Alignof" to avoid undefined behavior.

I've grepped all source files to find any type definitions within
"offsetof".

    offsetof\(struct .*\{ .*,

This implementation of macro "TYPE_ALIGN" seemes to be the only case of
type definitions within offsetof in the kernel codebase.

I've made a clang patch that rejects any definitions within
__builtin_offsetof (usually #defined with "offsetof"), and tested
compiling with this patch, there is no error if this patch is applied.

In PATCH v1 "TYPE_ALIGN" was substituted with "__alignof__" which is a
GCC extension, which returns the *preferred alignment*, that is
different from C11 "_Alignof" returning *ABI alignment*. For example, on
i386 __alignof__(long long) evaluates to 8 but _Alignof(long long)
evaluates to 4. See godbolt links below.

In this patch, I'd like to use "__alignof__" to "_Alignof" to preserve
the behavior here.

Signed-off-by: YingChi Long <me@inclyc.cn>
Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
Link: https://godbolt.org/z/13xTYYd11
Link: https://godbolt.org/z/T749MfM9o
Link: https://gcc.gnu.org/onlinedocs/gcc/Alignment.html
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=10360
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52023
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69560
Link: https://reviews.llvm.org/D133574
---
 arch/x86/kernel/fpu/init.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 621f4b6cac4a..de96c11e1fe9 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -133,9 +133,6 @@ static void __init fpu__init_system_generic(void)
 	fpu__init_system_mxcsr();
 }

-/* Get alignment of the TYPE. */
-#define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
-
 /*
  * Enforce that 'MEMBER' is the last field of 'TYPE'.
  *
@@ -143,8 +140,8 @@ static void __init fpu__init_system_generic(void)
  * because that's how C aligns structs.
  */
 #define CHECK_MEMBER_AT_END_OF(TYPE, MEMBER) \
-	BUILD_BUG_ON(sizeof(TYPE) != ALIGN(offsetofend(TYPE, MEMBER), \
-					   TYPE_ALIGN(TYPE)))
+	BUILD_BUG_ON(sizeof(TYPE) !=         \
+		     ALIGN(offsetofend(TYPE, MEMBER), _Alignof(TYPE)))

 /*
  * We append the 'struct fpu' to the task_struct:
--
2.35.1

