Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3C6D6907
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjDDQip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjDDQin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0B3C2F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680626274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkLzLdGanqQWkIW56OlfNGGVARUbVzCrAbRW+lCFaME=;
        b=a+KpInYWHrmA9vpEDiZkcIcckXyzGrRceHym6Ilsg+5WhyViZM/fj9SDaTd1nZaJUtcPmw
        phnWzV66qgGR4OjvEzwZgcZil5bxprVwW2GG/U7M9OCHFU8e5idsG9ZOZkdoQ4oXS/3rRG
        9Z7U+vvWM8PxLEKHkVe58WgIedgIvo4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Il7ey56ZMd6v5tvtA_KOHg-1; Tue, 04 Apr 2023 12:37:53 -0400
X-MC-Unique: Il7ey56ZMd6v5tvtA_KOHg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-17afa2c993cso17471580fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkLzLdGanqQWkIW56OlfNGGVARUbVzCrAbRW+lCFaME=;
        b=wFU50QA2Dk/FCRSFmPnqwSYckHH5o9ocoksVnIb3sQTSTqOgmKXd6a+jBgJKq0SQyW
         oabmF8TR3ZT3MuNj0ibu/EaIRzC/3Dz5pjsIqUI72a0LAUMd9rI3JdVs69d2FTdJeynq
         DV9gB99Ei4AszFCm2ITtwJC0v2m5mweowvyKjxy6rZm5oxwZ6otFEOwfFHCriej8z8Oc
         XfU690kEWM7r6jOnTBdf9Gdv1adVxkCvmEQabmiM2lWRBfLfYD8Q5wWws45Kdbww7I5g
         eBydPgi54QQ7QL4P18Tkz3w1Vh/y5NpZrrPSyn4X+xXkvmLcXzTJkb+ZK7XStLqRFLIG
         /Dqg==
X-Gm-Message-State: AAQBX9dHE2aBTYTehGJ74XhaKEHQTVbqSS3Jb6GXwW72IAuIL8R87bX7
        HL7aM0KpzRoBDAIhnlJxKHpFJYrU0fz8v1OLgyyidCHoQw5ozKQ3ZBhU/b6eGb3j5N93ehFu0OB
        Tu3oeYh5nkhk4wxq/qpGgOKMe
X-Received: by 2002:aca:a90a:0:b0:367:6c7:ba98 with SMTP id s10-20020acaa90a000000b0036706c7ba98mr1652991oie.23.1680626272166;
        Tue, 04 Apr 2023 09:37:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZmlgAkxSWHcDx8gnC09wC/9Kl6psMH2hmRnFwk+D+PeGCc7kRnI/0vT1pWa4hNNU8zKSAvjg==
X-Received: by 2002:aca:a90a:0:b0:367:6c7:ba98 with SMTP id s10-20020acaa90a000000b0036706c7ba98mr1652948oie.23.1680626270456;
        Tue, 04 Apr 2023 09:37:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a802:2599:c6a8:e6db:a08:61b6])
        by smtp.gmail.com with ESMTPSA id bd1-20020a056808220100b0038755008179sm5264623oib.26.2023.04.04.09.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:37:50 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/6] riscv/cmpxchg: Deduplicate cmpxchg() asm functions
Date:   Tue,  4 Apr 2023 13:37:36 -0300
Message-Id: <20230404163741.2762165-2-leobras@redhat.com>
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

In this header every cmpxchg define (_relaxed, _acquire, _release,
vanilla) contain it's own asm file, both for 4-byte variables an 8-byte
variables, on a total of 8 versions of mostly the same asm.

This is usually bad, as it means any change may be done in up to 8
different places.

Unify those versions by creating a new define with enough parameters to
generate any version of the previous 8.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 110 +++++++++----------------------
 1 file changed, 32 insertions(+), 78 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 12debce235e52..22f2ad13cad71 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -163,6 +163,22 @@
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
+
+#define ___cmpxchg(lr_sfx, sc_sfx, prepend, append, r, rc, p, co, o, n)	\
+{									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"0:	lr" lr_sfx " %0, %2\n"				\
+		"	bne  %0, %z3, 1f\n"				\
+		"	sc" sc_sfx " %1, %z4, %2\n"			\
+		"	bnez %1, 0b\n"					\
+		append							\
+		"1:\n"							\
+		: "=&r" (r), "=&r" (rc), "+A" (*(p))			\
+		: "rJ" (co o), "rJ" (n)					\
+		: "memory");						\
+}
+
 #define __cmpxchg_relaxed(ptr, old, new, size)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -172,26 +188,12 @@
 	register unsigned int __rc;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
+		___cmpxchg(".w", ".w", "", "",				\
+			   __ret, __rc, __ptr, (long), __old, __new);	\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
+		___cmpxchg(".d", ".d", "", "",				\
+			   __ret, __rc, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -216,28 +218,12 @@
 	register unsigned int __rc;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			RISCV_ACQUIRE_BARRIER				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
+		___cmpxchg(".w", ".w", "", RISCV_ACQUIRE_BARRIER,	\
+			   __ret, __rc, __ptr, (long), __old, __new);	\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			RISCV_ACQUIRE_BARRIER				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
+		___cmpxchg(".d", ".d", "", RISCV_ACQUIRE_BARRIER,	\
+			   __ret, __rc, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -262,28 +248,12 @@
 	register unsigned int __rc;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
+		___cmpxchg(".w", ".w", RISCV_RELEASE_BARRIER, "",	\
+			   __ret, __rc, __ptr, (long), __old, __new);	\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
+		___cmpxchg(".d", ".d", RISCV_RELEASE_BARRIER, "",	\
+			   __ret, __rc, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -308,28 +278,12 @@
 	register unsigned int __rc;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w.rl %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
+		___cmpxchg(".w", ".w.rl", "", "	fence rw, rw\n",	\
+			   __ret, __rc, __ptr, (long), __old, __new);	\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d.rl %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
+		___cmpxchg(".d", ".d.rl", "", "	fence rw, rw\n",	\
+			   __ret, __rc, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
-- 
2.40.0

