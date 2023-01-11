Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76D7665C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjAKNXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjAKNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:23:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60DC2632
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673443428; x=1704979428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+rl4a/r+n7WVh8LTw1aFIfnP3cclJ/IXLZLoq8uYoKo=;
  b=Ri5bLSZ0AYMznAuCyJfV/7O/Vbuiu1h6aUElmQcKfSUSPvDBAZbJX7Nc
   OQaCAIz/BO2rekpbDuPaFfxfaz6qEIe5OQ7a/XV0iSSNNoOtzyq2iV1rY
   GN96qTHHHsqVIvfkkRx9TQnbfp1xHss+/v/HUP6NC9u2JNFirys7HFjZX
   xudbARUW3NmG0JyVsl7vHRAFIt2F+oLji0XtSAoIpZlTwwh4IR07tB8of
   jIz8AipNdYatoBqHdfff5N0SVnSv1oKiwwSo98N3E43OKuHjHSVPvoFJ2
   ZQfkzhoq7NlDV7ngDhEvSswwG0LaJBSgx/jTBrjCT8NSphukmLyg307sl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387872495"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="387872495"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687927404"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="687927404"
Received: from bachaue1-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.250])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:42 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0815B109C73; Wed, 11 Jan 2023 15:37:41 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv14 01/17] x86/mm: Rework address range check in get_user() and put_user()
Date:   Wed, 11 Jan 2023 15:37:20 +0300
Message-Id: <20230111123736.20025-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/lib/getuser.S | 83 ++++++++++++++++--------------------------
 arch/x86/lib/putuser.S | 54 ++++++++++++---------------
 2 files changed, 55 insertions(+), 82 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index b70d98d79a9d..b64a2bd1a1ef 100644
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
index 32125224fcca..3062d09a776d 100644
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
-- 
2.38.2

