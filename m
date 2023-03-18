Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D96BF8CA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCRICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCRICY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACE720A06
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679126499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPnhvOcPIzsxcdPaGdi9oJi4cZ44pFeBuguAKI/S1NE=;
        b=JPHMhhmqNsKx1R3ts69M2E0KV01KKCsmte7WSZrQxkBK92cau1785hEdopGO4SNGya2jVE
        qRjNrQwm7fYspIxRkzb6EVXxeWQBofPfhhQ0iGhH3e+St0kcaFDzcbDCThsJdGhl/ULBMd
        2cscOxQkqC42BEl6GKNvs4aZqCAbnEY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-hsxZPx34O7eT0mNUyvN9eg-1; Sat, 18 Mar 2023 04:01:38 -0400
X-MC-Unique: hsxZPx34O7eT0mNUyvN9eg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-176347f3b28so4207177fac.23
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPnhvOcPIzsxcdPaGdi9oJi4cZ44pFeBuguAKI/S1NE=;
        b=hh5G+5gVdLTDdHGEY/oe9wi8ejp6XjZujtbi570YKiaPY6gK0jWn+0iAOgqbzBbOuL
         DBGdTRVG9Q4QlDj/QteKnQ/W5BBGvecQYo/EOP+b91iL4OaHcEgV/jfoD+5egswWZdOt
         /RtTi15HWN+BlHiN7ogYtOhcRiqfEbNpxcPMMFcw8mjUvpXBNwQAG7GPwmsOFpxz1wLg
         r7mBo7PqwNladQh76Tm4AjCtzC0mmT0HaqgTC3p6K5XZbxxBvdH9YGsaFc7U3ujy/rhZ
         StyMCLBmR/9oR6Pa8LbaD6isaESiwnobo4wD5BIm92sahrxeJsnc69zSyCfsBNM3yFI9
         fTOQ==
X-Gm-Message-State: AO0yUKUND781bzn4cYVqRLI8ITTWvexMz1ARejCT8IBE2xKzh+zxkFcm
        hNMqO1vP8zn+dPcW1Ksfb9JXfKjfKEHqlR8mXz2WHzuJ/vvjSpfvIilL56k5ZMFICojWCRgqfLf
        EKsP8YSSiRg8ao+qJpezEOXhh5tl28Y7/P0g=
X-Received: by 2002:a9d:6d07:0:b0:699:a4f5:c951 with SMTP id o7-20020a9d6d07000000b00699a4f5c951mr545060otp.2.1679126497073;
        Sat, 18 Mar 2023 01:01:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set+WcHJHToqcNvmcnD6lpwssEC4fCQRqdp8Ky5jVCA70hyM292yOTI3zEF7jhKXF67Z9dF5gdA==
X-Received: by 2002:a9d:6d07:0:b0:699:a4f5:c951 with SMTP id o7-20020a9d6d07000000b00699a4f5c951mr545053otp.2.1679126496831;
        Sat, 18 Mar 2023 01:01:36 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d4803000000b0069dc250cb24sm1824462otf.3.2023.03.18.01.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:01:36 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/6] riscv/cmpxchg: Deduplicate cmpxchg() macros
Date:   Sat, 18 Mar 2023 05:00:56 -0300
Message-Id: <20230318080059.1109286-3-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230318080059.1109286-1-leobras@redhat.com>
References: <20230318080059.1109286-1-leobras@redhat.com>
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

