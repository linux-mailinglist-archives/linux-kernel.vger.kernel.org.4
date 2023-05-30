Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE6A7158C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjE3IjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjE3IjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:39:19 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84627C9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:39:17 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-5142da822cbso4093776a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685435956; x=1688027956;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d2gZVOqgM2bnB8NENsAMpjub1Q/xoX1pCqU5k5h5AWY=;
        b=Qr8jpDkXiWtlWEKgM/OCiUY6Qr6uIug26AODpYGcZCgHTfMWI3yZaegQAjWlbgKu4z
         104GXMaD2SXHLrPfTEEfuM9jfDznwWhEwcuiJuoh0higXz2jNLE7lzNCaL5n3nBCjacW
         +4FyxBv3CzhKMvvafis0fhTTfvmgShIcoQnQt3e2nDYnAr9DEl0ornOw8+oGgruVFraT
         3nDsArzpfnNfbH/+0HI1ziVPlMgtUuqBISYUh+i2BGQ1NGqbPulsFH1ae3NrHFHtP+uF
         dGhVDhLJdr4OJfuu4gJzx3j6RhktmWrxEKilQRAG2UvMGfRIORAdf9bNp4Dvtj3JYb3q
         icYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685435956; x=1688027956;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2gZVOqgM2bnB8NENsAMpjub1Q/xoX1pCqU5k5h5AWY=;
        b=Fk6RxvDm/IA+nMaf5Lu+lTrgs16uhThH68q8FX2K3X2nyT2pl91s3lRNgWi8iPjZne
         1/2MVu5dEDjAKV01QLcOnY+pkRn5bmZlGWomOnPrgegXfmJuaqJrDVVbWZpgf5wFgyl2
         H9YsDLv7L8VtpAer1+hZyeD3Wawvy4J9gtCk32wQK1wNVTyowxbEziDwVC+0nUJ0gj4G
         MP24fhfKPrpyVzDnTSCvlFVME+Iak4d72F/TyWfrPp/LKCEOgKvACt/qEQ+4YDwtuhLJ
         lV5DTuI2IXPAe1EMOdeHaNQlswoAA6ELKLf4qYthNmaZLj7o5orvFXT6TC/MQzIMU8I9
         AtTQ==
X-Gm-Message-State: AC+VfDxTy9Oe1hlekiToWiCXLgKtL6h7MrgSwj3aE3NQnZOtYgDNArQd
        K1zRpC9vdOvQ8gMGrLG36ie83h8zj0A=
X-Google-Smtp-Source: ACHHUZ4l9kbotePBkAx85Fa8Beqd63nCciENdBm5Zvi4udP/o5anv8KJ2u5mcPW++drsyf/NxzsGKI/sXOk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a4:5738:5a7f:a82e])
 (user=glider job=sendgmr) by 2002:a50:8ada:0:b0:50b:c4f7:fa5a with SMTP id
 k26-20020a508ada000000b0050bc4f7fa5amr529352edk.3.1685435956071; Tue, 30 May
 2023 01:39:16 -0700 (PDT)
Date:   Tue, 30 May 2023 10:39:11 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530083911.1104336-1-glider@google.com>
Subject: [PATCH v2] string: use __builtin_memcpy() in strlcpy/strlcat
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, andy@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        ndesaulniers@google.com, nathan@kernel.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/string.c is built with -ffreestanding, which prevents the compiler
from replacing certain functions with calls to their library versions.

On the other hand, this also prevents Clang and GCC from instrumenting
calls to memcpy() when building with KASAN, KCSAN or KMSAN:
 - KASAN normally replaces memcpy() with __asan_memcpy() with the
   additional cc-param,asan-kernel-mem-intrinsic-prefix=1;
 - KCSAN and KMSAN replace memcpy() with __tsan_memcpy() and
   __msan_memcpy() by default.

To let the tools catch memory accesses from strlcpy/strlcat, replace
the calls to memcpy() with __builtin_memcpy(), which KASAN, KCSAN and
KMSAN are able to replace even in -ffreestanding mode.

This preserves the behavior in normal builds (__builtin_memcpy() ends up
being replaced with memcpy()), and does not introduce new instrumentation
in unwanted places, as strlcpy/strlcat are already instrumented.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.com/
Acked-by: Kees Cook <keescook@chromium.org>
---
 lib/string.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 3d55ef8901068..be26623953d2e 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -110,7 +110,7 @@ size_t strlcpy(char *dest, const char *src, size_t size)
 
 	if (size) {
 		size_t len = (ret >= size) ? size - 1 : ret;
-		memcpy(dest, src, len);
+		__builtin_memcpy(dest, src, len);
 		dest[len] = '\0';
 	}
 	return ret;
@@ -260,7 +260,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
 	count -= dsize;
 	if (len >= count)
 		len = count-1;
-	memcpy(dest, src, len);
+	__builtin_memcpy(dest, src, len);
 	dest[len] = 0;
 	return res;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

