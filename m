Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1E6C51E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCVRFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjCVREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19032A14B;
        Wed, 22 Mar 2023 10:04:00 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=44nt7dVUV9OUctW6eaYTms76IFq36xY8mNNKTDTJ8gs=;
        b=i24Sep4G9uriDdYavjgiejso8gFeZRxtpE6dRPWg7WRDHQ8ZILFqGgBQSeTR/3M9NiHq+Y
        SQnqtfp3tMw7SMVSDqQ2q1iaH7rkDUeD/vWg+HAhYaI1cB3oTk183SlRY5iCaJUDBsFu/O
        HOl7EIAjGwrnujyh2U4JjGNLXYBJshqySQQZC3DB/9BxryYkIi/omOLH0QN5ZKiAUMzXCT
        Xkoe/BFNnSPXgqn+c+IA+qbm4Iqrj0dcYqK0DY8QO1qfSUbprSEjcqiCtRQvPY49jWK6jJ
        lZzFHnBvfnGiziUlQB+27m9wtWzDsZqfniV8A550+olmU9H8SfyCsbvyaPAQwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=44nt7dVUV9OUctW6eaYTms76IFq36xY8mNNKTDTJ8gs=;
        b=T5KIGlwZ/z0eLJbbfZPTjM4l+Cos8UOthqTqxNZkjueFOctA0C66NZbGH4ycts4GUM1JG8
        bNOxpl5584N6eUDw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Rework address range check in get_user() and put_user()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458889.5837.5617910719902761467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b19b74bc99b1501a550f4448d04d59b946dc617a
Gitweb:        https://git.kernel.org/tip/b19b74bc99b1501a550f4448d04d59b946dc617a
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:25:56 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:38 -07:00

x86/mm: Rework address range check in get_user() and put_user()

The functions get_user() and put_user() check that the target address
range resides in the user space portion of the virtual address space.
In order to perform this check, the functions compare the end of the
range against TASK_SIZE_MAX.

For kernels compiled with CONFIG_X86_5LEVEL, this process requires some
additional trickery using ALTERNATIVE, as TASK_SIZE_MAX depends on the
paging mode in use.

Linus suggested that this check could be simplified for 64-bit kernels.
It is sufficient to check bit 63 of the address to ensure that the range
belongs to user space. Additionally, the use of branches can be avoided
by setting the target address to all ones if bit 63 is set.

There's no need to check the end of the access range as there's huge
gap between end of userspace range and start of the kernel range. The
gap consists of canonical hole and unused ranges on both kernel and
userspace sides.

If an address with bit 63 set is passed down, it will trigger a #GP
exception. _ASM_EXTABLE_UA() complains about this. Replace it with
plain _ASM_EXTABLE() as it is expected behaviour now.

The updated get_user() and put_user() checks are also compatible with
Linear Address Masking, which allows user space to encode metadata in
the upper bits of pointers and eliminates the need to untag the address
before handling it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20230312112612.31869-2-kirill.shutemov%40linux.intel.com
---
 arch/x86/lib/getuser.S | 83 +++++++++++++++--------------------------
 arch/x86/lib/putuser.S | 54 ++++++++++++---------------
 2 files changed, 55 insertions(+), 82 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index b70d98d..b64a2bd 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -37,22 +37,22 @@
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
-#ifdef CONFIG_X86_5LEVEL
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
-		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
-#else
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
-#endif
+.macro check_range size:req
+.if IS_ENABLED(CONFIG_X86_64)
+	mov %rax, %rdx
+	sar $63, %rdx
+	or %rdx, %rax
+.else
+	cmp $TASK_SIZE_MAX-\size+1, %eax
+	jae .Lbad_get_user
+	sbb %edx, %edx		/* array_index_mask_nospec() */
+	and %edx, %eax
+.endif
+.endm
 
 	.text
 SYM_FUNC_START(__get_user_1)
-	LOAD_TASK_SIZE_MINUS_N(0)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	check_range size=1
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -62,11 +62,7 @@ SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
 SYM_FUNC_START(__get_user_2)
-	LOAD_TASK_SIZE_MINUS_N(1)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	check_range size=2
 	ASM_STAC
 2:	movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -76,11 +72,7 @@ SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
 SYM_FUNC_START(__get_user_4)
-	LOAD_TASK_SIZE_MINUS_N(3)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	check_range size=4
 	ASM_STAC
 3:	movl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -90,30 +82,17 @@ SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
 SYM_FUNC_START(__get_user_8)
-#ifdef CONFIG_X86_64
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	check_range size=8
 	ASM_STAC
+#ifdef CONFIG_X86_64
 4:	movq (%_ASM_AX),%rdx
-	xor %eax,%eax
-	ASM_CLAC
-	RET
 #else
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user_8
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
-	ASM_STAC
 4:	movl (%_ASM_AX),%edx
 5:	movl 4(%_ASM_AX),%ecx
+#endif
 	xor %eax,%eax
 	ASM_CLAC
 	RET
-#endif
 SYM_FUNC_END(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
@@ -166,7 +145,7 @@ EXPORT_SYMBOL(__get_user_nocheck_8)
 
 SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
 	ASM_CLAC
-bad_get_user:
+.Lbad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
 	RET
@@ -184,23 +163,23 @@ SYM_CODE_END(.Lbad_get_user_8_clac)
 #endif
 
 /* get_user */
-	_ASM_EXTABLE_UA(1b, .Lbad_get_user_clac)
-	_ASM_EXTABLE_UA(2b, .Lbad_get_user_clac)
-	_ASM_EXTABLE_UA(3b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(1b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(2b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(3b, .Lbad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(4b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(4b, .Lbad_get_user_clac)
 #else
-	_ASM_EXTABLE_UA(4b, .Lbad_get_user_8_clac)
-	_ASM_EXTABLE_UA(5b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(4b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(5b, .Lbad_get_user_8_clac)
 #endif
 
 /* __get_user */
-	_ASM_EXTABLE_UA(6b, .Lbad_get_user_clac)
-	_ASM_EXTABLE_UA(7b, .Lbad_get_user_clac)
-	_ASM_EXTABLE_UA(8b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(6b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(7b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(8b, .Lbad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(9b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(9b, .Lbad_get_user_clac)
 #else
-	_ASM_EXTABLE_UA(9b, .Lbad_get_user_8_clac)
-	_ASM_EXTABLE_UA(10b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(9b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(10b, .Lbad_get_user_8_clac)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 3212522..3062d09 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -33,20 +33,20 @@
  * as they get called from within inline assembly.
  */
 
-#ifdef CONFIG_X86_5LEVEL
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rbx), \
-		    __stringify(mov $((1 << 56) - 4096 - (n)),%rbx), X86_FEATURE_LA57
-#else
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	mov $(TASK_SIZE_MAX - (n)),%_ASM_BX
-#endif
+.macro check_range size:req
+.if IS_ENABLED(CONFIG_X86_64)
+	mov %rcx, %rbx
+	sar $63, %rbx
+	or %rbx, %rcx
+.else
+	cmp $TASK_SIZE_MAX-\size+1, %ecx
+	jae .Lbad_put_user
+.endif
+.endm
 
 .text
 SYM_FUNC_START(__put_user_1)
-	LOAD_TASK_SIZE_MINUS_N(0)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	check_range size=1
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -66,9 +66,7 @@ SYM_FUNC_END(__put_user_nocheck_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
 SYM_FUNC_START(__put_user_2)
-	LOAD_TASK_SIZE_MINUS_N(1)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	check_range size=2
 	ASM_STAC
 3:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -88,9 +86,7 @@ SYM_FUNC_END(__put_user_nocheck_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
 SYM_FUNC_START(__put_user_4)
-	LOAD_TASK_SIZE_MINUS_N(3)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	check_range size=4
 	ASM_STAC
 5:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -110,9 +106,7 @@ SYM_FUNC_END(__put_user_nocheck_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
 SYM_FUNC_START(__put_user_8)
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	check_range size=8
 	ASM_STAC
 7:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
@@ -144,15 +138,15 @@ SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
 	RET
 SYM_CODE_END(.Lbad_put_user_clac)
 
-	_ASM_EXTABLE_UA(1b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(2b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(3b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(4b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(5b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(6b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(7b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(9b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(1b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(2b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(3b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(4b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(5b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(6b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(7b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(9b, .Lbad_put_user_clac)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE_UA(8b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(10b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(8b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(10b, .Lbad_put_user_clac)
 #endif
