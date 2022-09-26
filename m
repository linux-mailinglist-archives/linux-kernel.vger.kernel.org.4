Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F335EA9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiIZPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiIZPM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:12:28 -0400
Received: from mail-m118207.qiye.163.com (mail-m118207.qiye.163.com [115.236.118.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F7BC3D58F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:52:00 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118207.qiye.163.com (HMail) with ESMTPA id 43C32900A47;
        Mon, 26 Sep 2022 21:51:58 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     peterz@infradead.org
Cc:     me@inclyc.cn, ndesaulniers@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Mon, 26 Sep 2022 21:51:24 +0800
Message-Id: <20220926135125.891584-1-me@inclyc.cn>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <peterz@infradead.org>
References: <peterz@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWRoeHUpWHRkaSR4YSB0fTx5DVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PiI6OSo5CzlNFTcBCBJWFhkv
        MToKFA9VSlVKTU1PSUtLSEpCTkJNVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUhOSUs3Bg++
X-HM-Tid: 0a837a119ffc2d29kusn43c32900a47
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WG14 N2350 made very clear that it is an UB having type definitions
within "offsetof". This patch changes the implementation of macro
"TYPE_ALIGN" to builtin "_Alignof" to avoid undefined behavior.

I've grepped all source files to find any type definitions within
"offsetof".

  offsetof\(struct .*\{ .*,

This implementation of macro "TYPE_ALIGN" seemes to be the only case of
type definitions within offsetof in the kernel codebase.

GCC builtin __alignof__ has different semantics here. __alignof__() will
in fact return the 'sane' result while structure alignment and
_Alignof() return the ABI required minimum alignment.


Signed-off-by: YingChi Long <me@inclyc.cn>
Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
Link: https://godbolt.org/z/T749MfM9o
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

