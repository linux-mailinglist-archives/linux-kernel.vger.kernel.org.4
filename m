Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6B625506
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiKKINn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiKKINl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:13:41 -0500
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21096AEEC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:13:38 -0800 (PST)
Received: from YC20090004.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.orange.fr with ESMTPA
        id tPA6omw6rPMmatPAFocD5t; Fri, 11 Nov 2022 09:13:36 +0100
X-ME-Helo: YC20090004.ad.ts.tri-ad.global
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 11 Nov 2022 09:13:36 +0100
X-ME-IP: 103.175.111.222
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [RFC PATCH] lib: test_bitops: add compile-time optimization/evaluations assertions
Date:   Fri, 11 Nov 2022 17:13:16 +0900
Message-Id: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to the bitops test suite to assert that the bitops
helper correctly fold constant expressions (or trigger a build bug
otherwise). This should work on all the optimization levels supported
by Kbuild.

The function doesn't perform any runtime tests and gets optimized out to
nothing after passing the build assertions.

At the time of writing, we have not yet asserted that this will work on all
architectures. Architectures which fail that test should adjust their
arch/*/include/asm/bitops.h by either:

  - using __builtin_constant_p() to select between the architecture
    specific asm and the generic __builitn implementation if the
    architecture specific asm produces better code (similar to [1]).

  - always calling the generic __builtin implementation if the architecture
    specific asm does not produce better code (similar to [2]).

[1] commit 146034fed6ee ("x86/asm/bitops: Use __builtin_ffs() to evaluate
    constant expressions")

[2] patch "x86/asm/bitops: Replace __fls() by its generic builtin
    implementation"
    Link: https://lore.kernel.org/lkml/20221106095106.849154-2-mailhol.vincent@wanadoo.fr/

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This is a follow up of this thread:
https://lore.kernel.org/all/Yw8hJS9f6SofG4%2F6@yury-laptop/

in which I promised to eventually implement a check.

This patch requires below series in order to work on x86:
https://lore.kernel.org/lkml/20221106095106.849154-1-mailhol.vincent@wanadoo.fr/

Because that series is not yet merge, I am sending it as RFC for
now.

Concerning architectures other than x86, I am fine to write patches
but I will not test it (I do not have the build environment).

One idea would be to add this patch to any kind of CI which runs on
all architecture and see which architectures need to be fixed before
making this mainstream. Tell me what you think.
---
 lib/Kconfig.debug |  4 ++++
 lib/test_bitops.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3fc7abffc7aa..233a82cd3b6e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2300,6 +2300,10 @@ config TEST_BITOPS
 	  compilations. It has no dependencies and doesn't run or load unless
 	  explicitly requested by name.  for example: modprobe test_bitops.
 
+	  In addition, check that the compiler is able to fold the bitops
+	  function into a compile-time constant (given that the argument is also
+	  a compile-time constant) and trigger a build bug otherwise.
+
 	  If unsure, say N.
 
 config TEST_VMALLOC
diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index 3b7bcbee84db..e6e3d22ce52a 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -50,6 +50,50 @@ static unsigned long order_comb_long[][2] = {
 };
 #endif
 
+static void __init test_bitops_const_eval(void)
+{
+	int res;
+	u64 res64;
+
+	/*
+	 * On any supported optimization level (-O2, -Os) and if
+	 * invoked with a compile-time constant argument, the compiler
+	 * must be able to fold into a constant expression all the bit
+	 * find functions. Namely: __ffs(), ffs(), ffz(), __fls(),
+	 * fls() and fls64(). Otherwise, trigger a build bug.
+	 */
+
+	/* __ffs(BIT(10)) ==  10 */
+	res = __ffs(BIT(10)) == 10;
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
+
+	/* ffs(BIT(10)) ==  11 */
+	res = ffs(BIT(10)) == 11;
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
+
+	/* ffz(~BIT(10)) == 10 */
+	res = ffz(~BIT(10)) == 10;
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
+
+	/* __fls(BIT(10)) == 10 */
+	res = __fls(BIT(10)) == 10;
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
+
+	/* fls(BIT(10)) == 11 */
+	res = fls(BIT(10)) == 11;
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
+
+	/* fls64(BIT_ULL(10)) == 11 */
+	res64 = fls64(BIT_ULL(10)) == 11;
+	BUILD_BUG_ON(!__builtin_constant_p(res64));
+	BUILD_BUG_ON(!res64);
+}
+
 static int __init test_bitops_startup(void)
 {
 	int i, bit_set;
@@ -94,6 +138,8 @@ static int __init test_bitops_startup(void)
 	if (bit_set != BITOPS_LAST)
 		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
 
+	test_bitops_const_eval();
+
 	pr_info("Completed bitops test\n");
 
 	return 0;
-- 
2.35.1

