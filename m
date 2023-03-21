Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED56C2B97
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCUHoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCUHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA653B21E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679384588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPnhvOcPIzsxcdPaGdi9oJi4cZ44pFeBuguAKI/S1NE=;
        b=JHYUv+hrEFkPdd9pBtsUBEDJmhcXaoDVsjL03cYhnTrMQzro1EnFAVUItSm/9iNN5GFVxk
        xzZ9ZG9GUAG9k6HZRsIaX2SSLeomEyQW8k+0rysgc2QvTfTbotfIlJpz3miRscNm/TD+B5
        28yNcOKQfjc6ZVXRzP272uO7ZOf5mRo=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-JysRyL8iPsOLELlAyS4OXQ-1; Tue, 21 Mar 2023 03:43:07 -0400
X-MC-Unique: JysRyL8iPsOLELlAyS4OXQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-17714741d9dso8122278fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPnhvOcPIzsxcdPaGdi9oJi4cZ44pFeBuguAKI/S1NE=;
        b=nD9KTceiCUMGcPbfImO/6+vDQ56tBp8XZVOmW3ESWhlH2JDjoNGDTUmnEWIBao2aHm
         cIBgup31aYkB4E/DJ7HZXt/v9uf5mxajBTlLcxNV/WDKPd93T9Dsbab4NYIx5Z/18npU
         fzQaPRZOZRB6/ed9gBWg6VFsGyik2jwE/T2lrpzqwsF5YEP+Q1s2W3ODHd4hOhmOt//B
         dBIS+2gZAJgS72nkNJCAHPDpjBhnx2Hm6fge40VGwhv8APxb//CiKVPmpvN4h04DLYyg
         9G2IXbd9Mdg3c5Utz8vQpPmVUMQUkxOk274zhExfatTUPwR+rYxjDV0dtMcEvUt2qjPy
         Lk6Q==
X-Gm-Message-State: AO0yUKV9mipB8iucTtjqDsUrYLbrHTeQKlNdIyiFhWIcoTq4Up7Kjopd
        wOf0YfKHNvDPkowChyEx6zzZ2cfauVHFUB10xvNShTb66lSEs4zdjGZ577Q0xSe42MUfSWybtgX
        qG68QU/GAaIT7WIyarb57A3Eh
X-Received: by 2002:a05:6870:b022:b0:17a:f324:84ef with SMTP id y34-20020a056870b02200b0017af32484efmr443832oae.59.1679384586647;
        Tue, 21 Mar 2023 00:43:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set9b8yamhEH0q7gTigIbJe6gd98wbZe5VUiij8zGy8NAuWEbdR53tgMM8Yl9DhbMWzVFsWMIvw==
X-Received: by 2002:a05:6870:b022:b0:17a:f324:84ef with SMTP id y34-20020a056870b02200b0017af32484efmr443822oae.59.1679384586423;
        Tue, 21 Mar 2023 00:43:06 -0700 (PDT)
Received: from localhost.localdomain ([179.111.176.145])
        by smtp.gmail.com with ESMTPSA id az15-20020a05687c230f00b0016a37572d17sm4047729oac.2.2023.03.21.00.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:43:06 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v2 2/6] riscv/cmpxchg: Deduplicate cmpxchg() macros
Date:   Tue, 21 Mar 2023 04:42:45 -0300
Message-Id: <20230321074249.2221674-3-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321074249.2221674-1-leobras@redhat.com>
References: <20230321074249.2221674-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every cmpxchg define (_relaxed, _acquire, _release, vanilla) contain it's
own define for creating tmp variables and selecting the correct asm code
for give variable size.

All those defines are mostly the same code (other than specific barriers),
so there is no need to keep the 4 copies.

Unify those under a more general define, that can reproduce the previous 4
versions.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 72 ++++++--------------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 21984d24cbfe7..c7a13eec4dbcc 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -164,8 +164,8 @@
  * indicated by comparing RETURN with OLD.
  */
 
-#define ___cmpxchg(lr_sfx, sc_sfx, prepend, append)			\
-{									\
+#define ____cmpxchg(lr_sfx, sc_sfx, prepend, append)			\
+({									\
 	__asm__ __volatile__ (						\
 		prepend							\
 		"0:	lr" lr_sfx " %0, %2\n"				\
@@ -177,9 +177,9 @@
 		: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)		\
 		: "rJ" ((long)__old), "rJ" (__new)			\
 		: "memory");						\
-}
+})
 
-#define __cmpxchg_relaxed(ptr, old, new, size)				\
+#define ___cmpxchg(ptr, old, new, size, sc_sfx, prepend, append)	\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(ptr)) __old = (old);				\
@@ -188,10 +188,10 @@
 	register unsigned int __rc;					\
 	switch (size) {							\
 	case 4:								\
-		___cmpxchg(".w", ".w", "", "");				\
+		____cmpxchg(".w", ".w" sc_sfx, prepend, append);	\
 		break;							\
 	case 8:								\
-		___cmpxchg(".d", ".d", "", "");				\
+		____cmpxchg(".d", ".d" sc_sfx, prepend, append);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -199,6 +199,9 @@
 	__ret;								\
 })
 
+#define __cmpxchg_relaxed(ptr, old, new, size)				\
+	___cmpxchg(ptr, old, new, size, "", "", "")
+
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
@@ -208,24 +211,7 @@
 })
 
 #define __cmpxchg_acquire(ptr, old, new, size)				\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
-	register unsigned int __rc;					\
-	switch (size) {							\
-	case 4:								\
-		___cmpxchg(".w", ".w", "", RISCV_ACQUIRE_BARRIER);	\
-		break;							\
-	case 8:								\
-		___cmpxchg(".d", ".d", "", RISCV_ACQUIRE_BARRIER);	\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___cmpxchg(ptr, old, new, size, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
 ({									\
@@ -236,24 +222,7 @@
 })
 
 #define __cmpxchg_release(ptr, old, new, size)				\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
-	register unsigned int __rc;					\
-	switch (size) {							\
-	case 4:								\
-		___cmpxchg(".w", ".w", RISCV_RELEASE_BARRIER, "");	\
-		break;							\
-	case 8:								\
-		___cmpxchg(".d", ".d", RISCV_RELEASE_BARRIER, "");	\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___cmpxchg(ptr, old, new, size, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_cmpxchg_release(ptr, o, n)					\
 ({									\
@@ -264,24 +233,7 @@
 })
 
 #define __cmpxchg(ptr, old, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
-	register unsigned int __rc;					\
-	switch (size) {							\
-	case 4:								\
-		___cmpxchg(".w", ".w.rl", "", "	fence rw, rw\n");	\
-		break;							\
-	case 8:								\
-		___cmpxchg(".d", ".d.rl", "", "	fence rw, rw\n");	\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___cmpxchg(ptr, old, new, size, ".rl", "", "	fence rw, rw\n")
 
 #define arch_cmpxchg(ptr, o, n)						\
 ({									\
-- 
2.40.0

