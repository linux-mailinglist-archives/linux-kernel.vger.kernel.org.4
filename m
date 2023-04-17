Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF66E5428
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjDQVyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjDQVyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:54:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE361213D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:54:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v200-20020a252fd1000000b00b8f548a72bbso12042959ybv.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681768454; x=1684360454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ROFbMOV6yOo0pF0esK8s0D/4X+P3zglkAv5TCX1cqs=;
        b=Pz9Wmj1CrPl1IL4L95VxcDW5MmG+o1YPeNyX6BDBGEP92+EkCITMnKQ7UvdtMPMQrW
         5bYV8UujE5AJG6UrgZbcInh+uPT0vISasCoVTa9GdHTMvh7SiOQT0tBNXckQ7dxh9qL6
         MDsM1qiT6eXbhT/g07gKJB/FHU4Z2NOE55ctur65xeJEowmDoi4VUxVBK8MeN9wKgmlQ
         +QtduWbRt7SYN5f4lKm6WYiBh7HlmwIs5OOF8pSxz6DzkhLpLFxOCeKx8e03x9wv8S4K
         /q0vzu5/DOn9g1FiqjN0UvWzgQZgBvjCwjFiN/YUGv30+JQXuxzHBbyEmpQY4Z9u+myL
         5Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681768454; x=1684360454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ROFbMOV6yOo0pF0esK8s0D/4X+P3zglkAv5TCX1cqs=;
        b=Amf+0L1vyLZieU1SJv/J/odorXeGVA7lXV7NMithOOj6z41ILZUhY14TxJTMk3IG3A
         mK0rx2cZD3auIfXiMOHr7++Y3BbrYd0O3/wA60b4M+dT0q1amsmjc4kcl/A/73joPA3X
         R93+G4ovF9pfLPB6owUFjU1i9jnadwQ0nVNwgAi605biIyo3JzElqLNOpgbHFrrJxOhG
         GTdMySoO6VvSd2rm8G80TidOIy6f1XZ/1yPiXZo850KFSshRTxMFoB3H04MHCCep3qVO
         DlcLEE+JgU2YIR5R+YufIW5iaXPId+BfqkYG+eFlJ4x4utw6RsOGOSCxMwmgRlIyUUjZ
         eCGA==
X-Gm-Message-State: AAQBX9fqYqT5WvY0+nQOd174l1rveNl/qGrZLDoD+XxhFuec5Svam2EU
        2skWHhSB1rTBO3n0qagBzjFFCAVl99I6k50sjzA=
X-Google-Smtp-Source: AKy350b/U+vhtgW/aCNjn1RnkgKz7XdrVLLO1qkpANynkUXFsyTRebUkNcTaVWm1RgD2tS3IBkoN051hd0ctcGynTIc=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:e8f1:df30:2fb2:cf8a])
 (user=ndesaulniers job=sendgmr) by 2002:a25:cc05:0:b0:b8b:eea7:525a with SMTP
 id l5-20020a25cc05000000b00b8beea7525amr8187707ybf.7.1681768454118; Mon, 17
 Apr 2023 14:54:14 -0700 (PDT)
Date:   Mon, 17 Apr 2023 14:54:07 -0700
In-Reply-To: <20230412-no_stackp-v1-0-86d2034a4d06@google.com>
Mime-Version: 1.0
References: <20230412-no_stackp-v1-0-86d2034a4d06@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681768450; l=3068;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=Y+mVeYQgxmjVxZ8TAgHiUAti6DIYAGqhexs7SrW7nh8=; b=Xv2k6tZ4Tz1DoWi+BSx+JfcGKmmndDJLVOOT4V3InkpHqs2Txr0BldqG6172TGpaJXU4waGOC7cP
 UJyi1aBABQQ+iDuRy15lwJ7Wtd0/eqT1u+ZHYnEmGlM+mVeB9tBI
X-Mailer: b4 0.12.2
Message-ID: <20230412-no_stackp-v1-1-86d2034a4d06@google.com>
Subject: [PATCH 1/2] start_kernel: add no_stack_protector fn attr
From:   ndesaulniers@google.com
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back during the discussion of
commit a9a3ed1eff36 ("x86: Fix early boot crash on gcc-10, third try")
we discussed the need for a function attribute to control the omission
of stack protectors on a per-function basis; at the time Clang had
support for no_stack_protector but GCC did not. This was fixed in
gcc-11. Now that the function attribute is available, let's start using
it.

Callers of boot_init_stack_canary need to use this function attribute
unless they're compiled with -fno-stack-protector, otherwise the canary
stored in the stack slot of the caller will differ upon the call to
boot_init_stack_canary. This will lead to a call to __stack_chk_fail
then panic.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722
Link: https://lore.kernel.org/all/20200316130414.GC12561@hirez.programming.kicks-ass.net/
Tested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/kernel/smp.c           |  1 +
 include/linux/compiler_attributes.h | 12 ++++++++++++
 init/main.c                         |  3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f62e5e651bcd..48acae0da034 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1603,6 +1603,7 @@ static void add_cpu_to_masks(int cpu)
 }
 
 /* Activate a secondary processor. */
+__no_stack_protector
 void start_secondary(void *unused)
 {
 	unsigned int cpu = raw_smp_processor_id();
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index e659cb6fded3..84864767a56a 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -255,6 +255,18 @@
  */
 #define __noreturn                      __attribute__((__noreturn__))
 
+/*
+ * Optional: only supported since GCC >= 11.1, clang >= 7.0.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-no_005fstack_005fprotector-function-attribute
+ *   clang: https://clang.llvm.org/docs/AttributeReference.html#no-stack-protector-safebuffers
+ */
+#if __has_attribute(__no_stack_protector__)
+# define __no_stack_protector		__attribute__((__no_stack_protector__))
+#else
+# define __no_stack_protector
+#endif
+
 /*
  * Optional: not supported by gcc.
  *
diff --git a/init/main.c b/init/main.c
index 5d6365510173..1265c8d11052 100644
--- a/init/main.c
+++ b/init/main.c
@@ -941,7 +941,8 @@ static void __init print_unknown_bootoptions(void)
 	memblock_free(unknown_options, len);
 }
 
-asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(void)
+asmlinkage __visible __init __no_sanitize_address __noreturn __no_stack_protector
+void start_kernel(void)
 {
 	char *command_line;
 	char *after_dashes;

-- 
2.40.0.634.g4ca3ef3211-goog

