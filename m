Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394FE6D6908
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjDDQir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjDDQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C2197
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680626276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5L3HWpAkpN3snqo22epQ9Rf+TQRWSZtMYOZoBBQpjwA=;
        b=dSdtXsCN4pvOsj+0Bn71IvGLHVQ6onI5nDOxqHZTDOEne6dDrzmsGJU+2WS8JWOmcqjbCX
        4ro+VZf5VBfpyJBLC4CB2nezLpr4HbaP67XKBWYgP3ah522SFqkz3jeLknYVdKmL1XeI+F
        93NP3K4GzmFOSN8Vgpn/Kuq5EJ3FuWU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-k9PNDsoHOj2IO8LzPjca0Q-1; Tue, 04 Apr 2023 12:37:55 -0400
X-MC-Unique: k9PNDsoHOj2IO8LzPjca0Q-1
Received: by mail-oi1-f198.google.com with SMTP id f18-20020a05680814d200b003877ce3bfb4so8298909oiw.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L3HWpAkpN3snqo22epQ9Rf+TQRWSZtMYOZoBBQpjwA=;
        b=mjTTq9WD/k0qtm9jNGMr1uM9bH+e75Ezthk987fHhTkJIuOCGrhoawrxrHD1f8oflm
         wsRMD/OSM6XVrxG4NA4j2KiFqHGv1p6/yB9jHDNuwdgcy1aKxEDMd+yzB+iNW7oGU32d
         wfwU9jtmLtFDmcVkoRJgKcO/0tIdaWMtTGUAjkgLgn6/M9wiNFHo6VWXI9u5c+9TCVsy
         G3X3Vpgcr478iYhBj71cuxAsK/QLYBbRXCvEpVBRh40AlpWrTfrview9vSZJV3W34O7v
         YbacC7CRnxqwi7da1q0ADo06OPeVjpmeeKycYBPkV5azTr4rslcAl1cUITa5iG7+EneV
         XXwg==
X-Gm-Message-State: AAQBX9cV9UsYoNMKZvCnbcncAdmpM4Zv7tTjTUNZ+KE/mJVUNAoKle2D
        FSaBlcopP0/UMzG02R91XUXtv2Rd+pBUXkJf3z4dkdrRqVW6gZmMvE/wvFvCcjD0HrxAx6H5JLt
        ZIAYNqtd87z9VRa1hyxIe+VAF
X-Received: by 2002:a05:6808:2a8d:b0:38b:5e4:9d3b with SMTP id fc13-20020a0568082a8d00b0038b05e49d3bmr1486713oib.4.1680626275007;
        Tue, 04 Apr 2023 09:37:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350aJ2KGdlh0EzLpckgpOVoJxkOrXA0su/AVKejuIMw/SU54LRZ1/NiSU07C24R5ULdhhMlwE/g==
X-Received: by 2002:a05:6808:2a8d:b0:38b:5e4:9d3b with SMTP id fc13-20020a0568082a8d00b0038b05e49d3bmr1486669oib.4.1680626273296;
        Tue, 04 Apr 2023 09:37:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a802:2599:c6a8:e6db:a08:61b6])
        by smtp.gmail.com with ESMTPSA id bd1-20020a056808220100b0038755008179sm5264623oib.26.2023.04.04.09.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:37:52 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/6] riscv/cmpxchg: Deduplicate cmpxchg() macros
Date:   Tue,  4 Apr 2023 13:37:37 -0300
Message-Id: <20230404163741.2762165-3-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404163741.2762165-1-leobras@redhat.com>
References: <20230404163741.2762165-1-leobras@redhat.com>
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
 arch/riscv/include/asm/cmpxchg.h | 82 ++++++--------------------------
 1 file changed, 14 insertions(+), 68 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 22f2ad13cad71..f76a82274a4fd 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -164,8 +164,8 @@
  * indicated by comparing RETURN with OLD.
  */
 
-#define ___cmpxchg(lr_sfx, sc_sfx, prepend, append, r, rc, p, co, o, n)	\
-{									\
+#define ____cmpxchg(lr_sfx, sc_sfx, prepend, append, r, rc, p, co, o, n)\
+({									\
 	__asm__ __volatile__ (						\
 		prepend							\
 		"0:	lr" lr_sfx " %0, %2\n"				\
@@ -177,9 +177,9 @@
 		: "=&r" (r), "=&r" (rc), "+A" (*(p))			\
 		: "rJ" (co o), "rJ" (n)					\
 		: "memory");						\
-}
+})
 
-#define __cmpxchg_relaxed(ptr, old, new, size)				\
+#define ___cmpxchg(ptr, old, new, size, sc_sfx, prepend, append)	\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(ptr)) __old = (old);				\
@@ -188,12 +188,12 @@
 	register unsigned int __rc;					\
 	switch (size) {							\
 	case 4:								\
-		___cmpxchg(".w", ".w", "", "",				\
-			   __ret, __rc, __ptr, (long), __old, __new);	\
+		____cmpxchg(".w", ".w" sc_sfx, prepend, append,		\
+			    __ret, __rc, __ptr, (long), __old, __new);	\
 		break;							\
 	case 8:								\
-		___cmpxchg(".d", ".d", "", "",				\
-			   __ret, __rc, __ptr, /**/, __old, __new);	\
+		____cmpxchg(".d", ".d" sc_sfx, prepend, append,		\
+			    __ret, __rc, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -201,6 +201,9 @@
 	__ret;								\
 })
 
+#define __cmpxchg_relaxed(ptr, old, new, size)				\
+	___cmpxchg(ptr, old, new, size, "", "", "")
+
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
@@ -210,26 +213,7 @@
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
-		___cmpxchg(".w", ".w", "", RISCV_ACQUIRE_BARRIER,	\
-			   __ret, __rc, __ptr, (long), __old, __new);	\
-		break;							\
-	case 8:								\
-		___cmpxchg(".d", ".d", "", RISCV_ACQUIRE_BARRIER,	\
-			   __ret, __rc, __ptr, /**/, __old, __new);	\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___cmpxchg(ptr, old, new, size, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
 ({									\
@@ -240,26 +224,7 @@
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
-		___cmpxchg(".w", ".w", RISCV_RELEASE_BARRIER, "",	\
-			   __ret, __rc, __ptr, (long), __old, __new);	\
-		break;							\
-	case 8:								\
-		___cmpxchg(".d", ".d", RISCV_RELEASE_BARRIER, "",	\
-			   __ret, __rc, __ptr, /**/, __old, __new);	\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___cmpxchg(ptr, old, new, size, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_cmpxchg_release(ptr, o, n)					\
 ({									\
@@ -270,26 +235,7 @@
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
-		___cmpxchg(".w", ".w.rl", "", "	fence rw, rw\n",	\
-			   __ret, __rc, __ptr, (long), __old, __new);	\
-		break;							\
-	case 8:								\
-		___cmpxchg(".d", ".d.rl", "", "	fence rw, rw\n",	\
-			   __ret, __rc, __ptr, /**/, __old, __new);	\
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

