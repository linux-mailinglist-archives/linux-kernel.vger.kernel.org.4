Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4717116BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbjEYSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbjEYSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:50:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42101984
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:43:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso106402b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685040173; x=1687632173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjWbDEw2QH6XF35tVFZ0HAaapmFpGTcu4LzSvUqVlcI=;
        b=JKNxP5/AUR37jOIze+kYEBgzrgyVEZSKrKb9xeg1aLJVBudQqTOThOxq9gD+G7LTeJ
         spRfv2ER5vf/xdAzAWyxuILc+HicrO9W5u/HfVcEQcpHZGI6dzjpz/0jZ35+eIHLA4K3
         ebxFvs1WhQ8IjUQSJGNYJbaONXJmCIIWS1/15TVXXLFch4ZKk+QAS4sNWiI9d7ky5ICA
         kbFiMc4jxXWe2Ycaj3vF/pViEMlNDQSiJInExqwTTV6hmBxolNZucxC/ywxfuGbRxJAr
         DhW5/WIcnVQZo+/6eRKPFe/eH4uTI6wngQ7W7nUqAO/Bg7D2biMZ4mtXST81OQ9zrPOp
         vBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685040173; x=1687632173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjWbDEw2QH6XF35tVFZ0HAaapmFpGTcu4LzSvUqVlcI=;
        b=Zho273hoZti0fWC6z5IMuvKZWQDEx85cC8Omn5PXCDN1PabSCOWyjjG0Hef5cTVTcX
         /OA/qXZFprd3HksR75zD13KlOgz5NTIqsUr+OZ/GgTMs+9cm/1ELGd5fMf/p2LyIhZgk
         Xdt/kCcznSOiWTNeP6iTx0OfURuMHaYrwOhYkqzK2uvUoN4hfhrJsaiG6490RE+CY1zM
         1JVs7gvGm9dalKByceAtmk2ljyhm7tV6BQoNs0dXRM5LNESVkvAjGPsKoxZFOtG2olJW
         Q5AsMru2BN0ZahhSFoJOU0ta91yaBzZjZaFyqkuA09L50EGL7qswWfReiPzbmX3gfEZ3
         g21w==
X-Gm-Message-State: AC+VfDyt3VKS8DXzfOeDSVZXyLTmnFIQ2fBvDqGLM3OPL7VKndWcP01h
        2TgXSw75iFML5csohDBIKJuE7EPZVRI=
X-Google-Smtp-Source: ACHHUZ79NQlQ/p5TfjdugWULQrhW40vmbEHdEwLRKlPdu+y0ETucUe8PIaYOyvc1h/E0/wqkNmERrw==
X-Received: by 2002:a05:6a00:2284:b0:646:5041:9729 with SMTP id f4-20020a056a00228400b0064650419729mr9764123pfe.0.1685040172885;
        Thu, 25 May 2023 11:42:52 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78813000000b0064d6b6aac5dsm1474267pfo.73.2023.05.25.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:42:52 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH v2] x86/lib: Do not use local symbols with SYM_CODE_START_LOCAL()
Date:   Thu, 25 May 2023 11:42:44 -0700
Message-Id: <20230525184244.2311-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

When SYM_CODE_START_LOCAL() is used, the symbols are local but need to
be preserved in the object. However, using the ".L" label prefix does
not retain the symbol in the object.

It is beneficial to be able to map instruction pointers back to symbols,
for instance for profiling. Otherwise, there are code addresses that do
not map back to any symbol.  Consequently, the ".L" label prefix should
not be used when SYM_CODE_START_LOCAL() is used.

Few symbols, such as .Lbad_put_user_clac and currently have both the
SYM_CODE_START_LOCAL() invocation and the ".L" prefix.  This commit
removes the ".L" prefix from these symbols.

No functional change, other then emitting these symbols into the object,
is intended.

Signed-off-by: Nadav Amit <namit@vmware.com>

---

v1 -> v2:
* Rebase on 6.4 (the affected symbols have changed)
---
 arch/x86/lib/getuser.S | 32 ++++++++++++++++----------------
 arch/x86/lib/putuser.S | 24 ++++++++++++------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index b64a2bd1a1ef..d98a80e0cdaf 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -143,43 +143,43 @@ SYM_FUNC_END(__get_user_nocheck_8)
 EXPORT_SYMBOL(__get_user_nocheck_8)
 
 
-SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
+SYM_CODE_START_LOCAL(bad_get_user_clac)
 	ASM_CLAC
 .Lbad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
 	RET
-SYM_CODE_END(.Lbad_get_user_clac)
+SYM_CODE_END(bad_get_user_clac)
 
 #ifdef CONFIG_X86_32
-SYM_CODE_START_LOCAL(.Lbad_get_user_8_clac)
+SYM_CODE_START_LOCAL(bad_get_user_8_clac)
 	ASM_CLAC
 bad_get_user_8:
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX
 	RET
-SYM_CODE_END(.Lbad_get_user_8_clac)
+SYM_CODE_END(bad_get_user_8_clac)
 #endif
 
 /* get_user */
-	_ASM_EXTABLE(1b, .Lbad_get_user_clac)
-	_ASM_EXTABLE(2b, .Lbad_get_user_clac)
-	_ASM_EXTABLE(3b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(1b, bad_get_user_clac)
+	_ASM_EXTABLE(2b, bad_get_user_clac)
+	_ASM_EXTABLE(3b, bad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(4b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(4b, bad_get_user_clac)
 #else
-	_ASM_EXTABLE(4b, .Lbad_get_user_8_clac)
-	_ASM_EXTABLE(5b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(4b, bad_get_user_8_clac)
+	_ASM_EXTABLE(5b, bad_get_user_8_clac)
 #endif
 
 /* __get_user */
-	_ASM_EXTABLE(6b, .Lbad_get_user_clac)
-	_ASM_EXTABLE(7b, .Lbad_get_user_clac)
-	_ASM_EXTABLE(8b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(6b, bad_get_user_clac)
+	_ASM_EXTABLE(7b, bad_get_user_clac)
+	_ASM_EXTABLE(8b, bad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(9b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(9b, bad_get_user_clac)
 #else
-	_ASM_EXTABLE(9b, .Lbad_get_user_8_clac)
-	_ASM_EXTABLE(10b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(9b, bad_get_user_8_clac)
+	_ASM_EXTABLE(10b, bad_get_user_8_clac)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 3062d09a776d..f0c80e07229d 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -131,22 +131,22 @@ SYM_FUNC_START(__put_user_nocheck_8)
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
 
-	_ASM_EXTABLE(1b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(2b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(3b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(4b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(5b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(6b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(7b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(9b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(1b, bad_put_user_clac)
+	_ASM_EXTABLE(2b, bad_put_user_clac)
+	_ASM_EXTABLE(3b, bad_put_user_clac)
+	_ASM_EXTABLE(4b, bad_put_user_clac)
+	_ASM_EXTABLE(5b, bad_put_user_clac)
+	_ASM_EXTABLE(6b, bad_put_user_clac)
+	_ASM_EXTABLE(7b, bad_put_user_clac)
+	_ASM_EXTABLE(9b, bad_put_user_clac)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE(8b, .Lbad_put_user_clac)
-	_ASM_EXTABLE(10b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(8b, bad_put_user_clac)
+	_ASM_EXTABLE(10b, bad_put_user_clac)
 #endif
-- 
2.25.1

