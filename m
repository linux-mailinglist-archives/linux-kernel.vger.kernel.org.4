Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30875F6975
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiJFOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiJFORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:17:30 -0400
Received: from mail-m118206.qiye.163.com (mail-m118206.qiye.163.com [115.236.118.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC8CC57241
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:15:02 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118206.qiye.163.com (HMail) with ESMTPA id 38763BE0B01;
        Thu,  6 Oct 2022 22:14:58 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     me@inclyc.cn
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org, david.laight@aculab.com
Subject: [PATCH v3] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Thu,  6 Oct 2022 22:14:42 +0800
Message-Id: <20221006141442.2475978-1-me@inclyc.cn>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220925153151.2467884-1-me@inclyc.cn>
References: <20220925153151.2467884-1-me@inclyc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWUJOGkpWQktITU1PHhgYQxlJVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZT0tIVUpJS0NOTVVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Fgw6TjlOATYuM09POSxN
        DghPFDpVSlVKTU1OS01OTUJCSk1CVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUhOSU03Bg++
X-HM-Tid: 0a83ada645d02d28kusn38763be0b01
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
compiling with this patch, there are no error if this patch applied.

ISO C11 _Alignof is subtly different from the GNU C extension
__alignof__. __alignof__ is the preferred alignment and _Alignof the
minimal alignment. For 'long long' on x86 these are 8 and 4
respectively.

The macro TYPE_ALIGN we're replacing has behavior that matches
_Alignof rather than __alignof__.

Signed-off-by: YingChi Long <me@inclyc.cn>
Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
Link: https://godbolt.org/z/sPs1GEhbT
Link: https://gcc.gnu.org/onlinedocs/gcc/Alignment.html
Link: https://reviews.llvm.org/D133574
---
v3:
- commit message changes suggested by Nick and David

v2: https://lore.kernel.org/all/20220927153338.4177854-1-me@inclyc.cn/
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

