Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252DB6C2A80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCUGgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCUGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F643BD90
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679380513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPnhvOcPIzsxcdPaGdi9oJi4cZ44pFeBuguAKI/S1NE=;
        b=KDTvg9u/d0qIIZG3UuztkTO2g6Qnz2JlUa0DtlEBB/9Sf4kqtfAhrLqtjdXSHK3hXUG7qc
        c4jVP67G7obnlnNkNxQeY8616JyzFjAXLc9R8O3ugn/4a3URGXfuu5V0ODQP7mKuyFiCIK
        rvTFnOD7HxwapdAnIC3o6+I9uBW1n2E=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-oZm837k3M9K6jg1cdjbTaw-1; Tue, 21 Mar 2023 02:35:12 -0400
X-MC-Unique: oZm837k3M9K6jg1cdjbTaw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-176347f3b28so8140801fac.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPnhvOcPIzsxcdPaGdi9oJi4cZ44pFeBuguAKI/S1NE=;
        b=UtFd83ez1oLXsy8GE69jK4bIk3mLdpcNFDHM9wbMQkdxraK17ELYoLIa2rJi28cXFh
         RhLkqlxWIukHBN4O9+/5ficHaGsqcRJogua7LMB4yw/LVE1YevQ0vyyERMLTWoBFk2Kq
         InPAPtmyCiloQc/aOScAWJOVbZq2Nuo++YeGblJKtyFla7g5KXkhbOjYe1/L7Hhmdvlv
         obIXiL/CEY+DjI19c55/LlPcx9M5r4hYyu0r/novMSVeLHVmVCTkl84lQroDi7CUpwZF
         O1SDiAqeOA0zCvBoMbCJ9NEwNU2GtxbhOERNv0oeicjO52dfv1RnjDXu0VE7sjxPgARy
         ahwA==
X-Gm-Message-State: AO0yUKUd+42a60WxqcEiYQy8wATRqQdQwuxH3ov5/c18kKG5HoeiBVMu
        myeNz547A4Y86q1/bdbpXH/lCI6UcTubOQEzBfooKMuCgfNHbCPmZPkc7fSvjxeCyOZIqR5SHRg
        hVmK7npLCsB48WWxy4SUKzuyaWPnGcdSWWH0=
X-Received: by 2002:a4a:3717:0:b0:525:4cde:53ca with SMTP id r23-20020a4a3717000000b005254cde53camr387161oor.7.1679380511409;
        Mon, 20 Mar 2023 23:35:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set+B3iS14kKznbvOrLdsR2O90xtmoFVXGkXb3A7xEJOE4JmAaaaMLbG1Bq8icqta3r70glUZ9g==
X-Received: by 2002:a4a:3717:0:b0:525:4cde:53ca with SMTP id r23-20020a4a3717000000b005254cde53camr387155oor.7.1679380511137;
        Mon, 20 Mar 2023 23:35:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id y75-20020a4a454e000000b005293e9a12f5sm4545147ooa.45.2023.03.20.23.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:35:10 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/6] riscv/cmpxchg: Deduplicate cmpxchg() macros
Date:   Tue, 21 Mar 2023 03:34:28 -0300
Message-Id: <20230321063430.2218795-3-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321063430.2218795-1-leobras@redhat.com>
References: <20230321063430.2218795-1-leobras@redhat.com>
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

