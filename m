Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0326D9163
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjDFIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbjDFIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE06FF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680769237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSaMfai72G9Tt4xz9KKUysgG6AJqyHxWXMI7tIwY4iE=;
        b=Vy90ux3SpLupmE0v5h/0M9P/E5MzVxmhYgapC/UrQ/TypEB/QhON3r5+Szs+0rTF2IkllA
        dFecaqExOI6dvpvYChSKaKKRaBhSEwcau8mwCZVrpcvSwE+Br1WEWBTv0oR8uZz54uOLkH
        l1JVP4NpM19X2m77O6r1x8y8QQPMDqE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-sROokbcDOIqjsWV4vea9mg-1; Thu, 06 Apr 2023 04:20:36 -0400
X-MC-Unique: sROokbcDOIqjsWV4vea9mg-1
Received: by mail-qv1-f69.google.com with SMTP id h7-20020a0cd807000000b005dd254e7babso17533158qvj.14
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSaMfai72G9Tt4xz9KKUysgG6AJqyHxWXMI7tIwY4iE=;
        b=a4O7b8W6/xT+Bw/IxB16CyfMaIoDJ4Xuy8a5wnQgzf+a6StYAHdOvjRZowPcwyx0F3
         4dctRcnWQwrDivuS2qxZ/mvRR/21Hw4BFFDLZhY7/jOX/BGw/Ut7ooLY9eRmsSBOUSpD
         /xKzuqeoDWD2WaD83gszDkqtMJGxK5YOMxe4ExIuXbLreStHmkYHyg7XnSI58Bn88Cl/
         jxWxW59c6ueLpT54Bd5JHUqCIz+UQBZl9xevYpN+f3R//YqRJuaFo8HACiv7WRqy1VXF
         D0efrbymqiouoKoddJdQ/G+6l3WGA3a+etSU5fqzNHS8+CHGtIe4+mJ85ZW9ylj0KMCd
         mfPg==
X-Gm-Message-State: AAQBX9f38qC7mS3v3KLY2uDxza3evZ+pJM/ARxVZ1ykCARv97ndmevDR
        k1Lvd7qt+5HuPxU/pXbAU7uikG7fXN5fiLLtqMcQtBBNtKfDltKNEN3bIzlxsaJ9MN3oZ4EFFtX
        6TCNMDWFQqkqUvBPoUFqJlFS/
X-Received: by 2002:ad4:5dcc:0:b0:5cb:6880:1924 with SMTP id m12-20020ad45dcc000000b005cb68801924mr2965868qvh.13.1680769235799;
        Thu, 06 Apr 2023 01:20:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350b3FwOIlgZSFBk3ro3ZOBAKXBnZZPxON2GwjbIBNkLe/RaTkjn0brP0Q17gIbHvf8If/JBg2w==
X-Received: by 2002:ad4:5dcc:0:b0:5cb:6880:1924 with SMTP id m12-20020ad45dcc000000b005cb68801924mr2965850qvh.13.1680769235574;
        Thu, 06 Apr 2023 01:20:35 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:2599:3b52:5a:179c:6ae7])
        by smtp.gmail.com with ESMTPSA id 186-20020a3705c3000000b007456c75edbbsm292776qkf.129.2023.04.06.01.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:20:35 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/2] riscv/cmpxchg: Deduplicate xchg() asm functions
Date:   Thu,  6 Apr 2023 05:20:19 -0300
Message-Id: <20230406082018.70367-3-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406082018.70367-1-leobras@redhat.com>
References: <20230406082018.70367-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this header every xchg define (_relaxed, _acquire, _release, vanilla)
contain it's own asm file, both for 4-byte variables an 8-byte variables,
on a total of 8 versions of mostly the same asm.

This is usually bad, as it means any change may be done in up to 8
different places.

Unify those versions by creating a new define with enough parameters to
generate any version of the previous 8.

Then unify the result under a more general define, and simplify
arch_xchg* generation.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 135 +++++++------------------------
 1 file changed, 31 insertions(+), 104 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index f88fae357071c..905a888d8b04d 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,25 +11,30 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
-#define __xchg_relaxed(ptr, new, size)					\
+#define ____xchg(sfx, prepend, append, r, p, n)				\
+({									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amoswap" sfx " %0, %2, %1\n"			\
+		append							\
+		: "=r" (r), "+A" (*(p))					\
+		: "r" (n)						\
+		: "memory");						\
+})
+
+#define ___xchg(ptr, new, size, sfx, prepend, append)			\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(new) __new = (new);					\
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		____xchg(".w" sfx, prepend, append,			\
+			 __ret, __ptr, __new);				\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		____xchg(".d" sfx, prepend, append,			\
+			 __ret, __ptr, __new);				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -37,114 +42,36 @@
 	__ret;								\
 })
 
-#define arch_xchg_relaxed(ptr, x)					\
+#define __xchg_relaxed(ptr, new, size)					\
+	___xchg(ptr, new, size, "", "", "")
+
+#define _arch_xchg(order, ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
+	(__typeof__(*(ptr))) __xchg ## order((ptr),			\
+					     _x_, sizeof(*(ptr)));	\
 })
 
+#define arch_xchg_relaxed(ptr, x)					\
+	_arch_xchg(_relaxed, ptr, x)
+
 #define __xchg_acquire(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___xchg(ptr, new, size, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_acquire(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(_acquire, ptr, x)
 
 #define __xchg_release(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___xchg(ptr, new, size, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg_release(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_release((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(_release, ptr, x)
 
 #define __xchg(ptr, new, size)						\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___xchg(ptr, new, size, ".aqrl", "", "")
 
 #define arch_xchg(ptr, x)						\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(, ptr, x)
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.40.0

