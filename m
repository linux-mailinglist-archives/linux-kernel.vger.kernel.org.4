Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D0616BD0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiKBSP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKBSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:15:55 -0400
Received: from mail-m118207.qiye.163.com (mail-m118207.qiye.163.com [115.236.118.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 392B81DF02
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:15:54 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.48])
        by mail-m118207.qiye.163.com (HMail) with ESMTPA id 2C69B9021E0;
        Thu,  3 Nov 2022 02:15:52 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     bp@alien8.de
Cc:     chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        david.laight@aculab.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, me@inclyc.cn, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: [PATCH v4] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Thu,  3 Nov 2022 02:14:25 +0800
Message-Id: <20221102181425.2122504-1-me@inclyc.cn>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <Y2KhCyofvfG5W5hE@zn.tnic>
References: <Y2KhCyofvfG5W5hE@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWRoZShhWH0wYGB0YHRpLHkJJVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VT0NZV1kWGg8SFR0UWUFZT0tIVUpKS0hNSlVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRg6Igw6FTlLCTQfHykBTxMR
        TSgaFDJVSlVKTU1MT0pJQk5ISkNNVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU9DWVdZCAFZQUhNTkw3Bg++
X-HM-Tid: 0a84398e868b2d29kusn2c69b9021e0
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm

WG14 N2350 made very clear that it is an undefined behavior having type
definitions with in "offsetof". Replace the macro "TYPE_ALIGN" to
builtin "_Alignof" to avoid undefined behavior.

I've grepped all source files to find any type definitions within
"offsetof".

    offsetof\(struct .*\{ .*,

This implementation of macro "TYPE_ALIGN" seemes to be the only case of
type definitions within offsetof in the kernel codebase.

Link: https://reviews.llvm.org/D133574

A clang patch has been made that rejects any definitions within
__builtin_offsetof (usually #defined with "offsetof"), and tested
compiling the kernel using clang, there are no error if this patch
applied.

Link: https://gcc.gnu.org/onlinedocs/gcc/Alignment.html
Link: https://godbolt.org/z/sPs1GEhbT

ISO C11 _Alignof is subtly different from the GNU C extension
__alignof__. __alignof__ is the preferred alignment and _Alignof the
minimal alignment. For 'long long' on x86 these are 8 and 4
respectively.

The macro TYPE_ALIGN has behavior that matches _Alignof rather than
__alignof__.

Signed-off-by: YingChi Long <me@inclyc.cn>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
v4:
- commit message changes suggested by Borislav Petkov

v3:
- commit message changes suggested by Nick and David

v3: https://lore.kernel.org/all/20221006141442.2475978-1-me@inclyc.cn/

v2: https://lore.kernel.org/all/20220927153338.4177854-1-me@inclyc.cn/
---
 arch/x86/kernel/fpu/init.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 8946f89761cc..851eb13edc01 100644
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
2.37.4

