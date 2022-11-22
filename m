Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A436335C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiKVHP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiKVHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:15:53 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794533121B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:15:52 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b62so13373768pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cH3XUOlDzLJq6dhclj6pjTqONBWIigRQAqYPPPqneg=;
        b=Vnm+P7TjjenvMiUbjymitiEvEMZiWLaP4jiBbrVu3fciCG3Vdy7UFfLtAIkdDsLNw9
         GR/9D5fb4a64eMzKQFRRR/MxGlBG8+Sud+/1KAi1CODGiltst5PVnHUVMBtxZSBbAHSD
         FCneXl6zoV52BYzLxZVbT0UMf+dXk9XWZl8kX7Q97nER9DuPZFcz8i28OBa1DJAYHcum
         t7EXzgxwamH0E2Zj8r07RdSboaj61octPpoELFLpL9r9VaHdDM0a5AgiUYMtnLsqC2XS
         32/OOZjU6OLA9lENFi/i+I7KdK3ifVzC7k0VfJWUIlChT8MEx8EY6RBvhP700Y2EXrpQ
         fzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cH3XUOlDzLJq6dhclj6pjTqONBWIigRQAqYPPPqneg=;
        b=2FD6HrNzvR5eWPupkbIJsunwqNwUAj6tjlD+95SuBj1p9R2i1lrVTbWRkVw/ElySiX
         5g2CxtNGgvK/27J0SbyzFbZjDEyYsXKIjzJWnrv+vJhoA5aTJwdDSsel+wmqipNq/d9s
         cGXI+DgvKrGzyw2rzGb2y++mijNWL1CMA20IfjgFYhGi+YAWY0VTa1tCfAwgeDN1+Hi9
         LfvKvoC046I7eJmCsZtKEyQQ+icZt+yNtZJpBb72lBOkiREkQNHczSjDtk9m0scnvOFm
         FJTiPJea1vdJ3Q4Yc7lE27En8PxTcRfzCo9JSnQkJjEmSkZ/1fz4r/skqgvnJ3cBRUT+
         721A==
X-Gm-Message-State: ANoB5pk8MGJOUn2tw4pOQDEAAe9tj0/DPimNBbq+jTucawIoIpq1kcL1
        IS/FOFYkLG2GCtZcvFpVzaQ=
X-Google-Smtp-Source: AA0mqf5BmIdUoBXZWyijBTwSaemPvbbOOQ9M7FUnjJIPKdl8xZw74f8fH9XG1g0nPL2wzvxP9H7aQg==
X-Received: by 2002:a63:ff17:0:b0:470:8f8d:eb51 with SMTP id k23-20020a63ff17000000b004708f8deb51mr7337369pgi.69.1669101351597;
        Mon, 21 Nov 2022 23:15:51 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b00186b06963f9sm10988969plk.180.2022.11.21.23.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:15:51 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH] x86/lib: Do not use local symbols with SYM_CODE_START_LOCAL()
Date:   Mon, 21 Nov 2022 23:15:47 -0800
Message-Id: <20221122071547.165296-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

When SYM_CODE_START_LOCAL() is used, the symbols are local but should be
saved to the object. In contrast, using ".L" label prefix causes the
symbols not to be saved in the object.

Since it is preferable to be able to map instruction pointers back to
symbols, the local symbol should be saved in the object. Therefore, when
SYM_CODE_START_LOCAL() is used, the ".L" label prefix should not be
used.

Two symbols, however, have both SYM_CODE_START_LOCAL() and ".L" prefix:
.Lbad_put_user_clac and .Lcopy_user_handle_tail. Remove the ".L" prefix
from them.

No functional change, other then emitting these symbols into the object,
is intended.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/lib/copy_user_64.S | 16 ++++++++--------
 arch/x86/lib/putuser.S      | 24 ++++++++++++------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 9dec1b38a98f..92b4c17c95cd 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -83,7 +83,7 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 
 30:	shll $6,%ecx
 	addl %ecx,%edx
-	jmp .Lcopy_user_handle_tail
+	jmp copy_user_handle_tail
 
 	_ASM_EXTABLE_CPY(1b, 30b)
 	_ASM_EXTABLE_CPY(2b, 30b)
@@ -139,7 +139,7 @@ SYM_FUNC_START(copy_user_generic_string)
 
 11:	leal (%rdx,%rcx,8),%ecx
 12:	movl %ecx,%edx		/* ecx is zerorest also */
-	jmp .Lcopy_user_handle_tail
+	jmp copy_user_handle_tail
 
 	_ASM_EXTABLE_CPY(1b, 11b)
 	_ASM_EXTABLE_CPY(3b, 12b)
@@ -169,7 +169,7 @@ SYM_FUNC_START(copy_user_enhanced_fast_string)
 	RET
 
 12:	movl %ecx,%edx		/* ecx is zerorest also */
-	jmp .Lcopy_user_handle_tail
+	jmp copy_user_handle_tail
 
 	_ASM_EXTABLE_CPY(1b, 12b)
 SYM_FUNC_END(copy_user_enhanced_fast_string)
@@ -190,7 +190,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
+SYM_CODE_START_LOCAL(copy_user_handle_tail)
 	cmp $X86_TRAP_MC,%eax
 	je 3f
 
@@ -209,9 +209,9 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 
 .Lcopy_user_handle_align:
 	addl %ecx,%edx			/* ecx is zerorest also */
-	jmp .Lcopy_user_handle_tail
+	jmp copy_user_handle_tail
 
-SYM_CODE_END(.Lcopy_user_handle_tail)
+SYM_CODE_END(copy_user_handle_tail)
 
 /*
  * Finish memcpy of less than 64 bytes.  #AC should already be set.
@@ -252,7 +252,7 @@ SYM_CODE_START_LOCAL(copy_user_short_string)
 40:	leal (%rdx,%rcx,8),%edx
 	jmp 60f
 50:	movl %ecx,%edx		/* ecx is zerorest also */
-60:	jmp .Lcopy_user_handle_tail
+60:	jmp copy_user_handle_tail
 
 	_ASM_EXTABLE_CPY(18b, 40b)
 	_ASM_EXTABLE_CPY(19b, 40b)
@@ -382,7 +382,7 @@ SYM_FUNC_START(__copy_user_nocache)
 	movl %ecx,%edx
 .L_fixup_handle_tail:
 	sfence
-	jmp .Lcopy_user_handle_tail
+	jmp copy_user_handle_tail
 
 	_ASM_EXTABLE_CPY(1b, .L_fixup_4x8b_copy)
 	_ASM_EXTABLE_CPY(2b, .L_fixup_4x8b_copy)
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 32125224fcca..3c33071cec97 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -137,22 +137,22 @@ SYM_FUNC_START(__put_user_nocheck_8)
 SYM_FUNC_END(__put_user_nocheck_8)
 EXPORT_SYMBOL(__put_user_nocheck_8)
 
-SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
+SYM_CODE_START_LOCAL(bad_put_user_clac)
 	ASM_CLAC
 .Lbad_put_user:
 	movl $-EFAULT,%ecx
 	RET
-SYM_CODE_END(.Lbad_put_user_clac)
+SYM_CODE_END(bad_put_user_clac)
 
-	_ASM_EXTABLE_UA(1b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(2b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(3b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(4b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(5b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(6b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(7b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(9b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(1b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(2b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(3b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(4b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(5b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(6b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(7b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(9b, bad_put_user_clac)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE_UA(8b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(10b, .Lbad_put_user_clac)
+	_ASM_EXTABLE_UA(8b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(10b, bad_put_user_clac)
 #endif
-- 
2.25.1

