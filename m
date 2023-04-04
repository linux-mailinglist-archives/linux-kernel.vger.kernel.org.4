Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CED6D690A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjDDQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjDDQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53436113
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680626282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Po1dD0V9oZXC1u6q0PdogM7Oei1BCdcz7qvnbPIGYkM=;
        b=OdFwLT28DbbewUbIvux2oG/pwoplp++WMiKUws6hcnGjzGkLdYy2F7iG9FuegnTxGQk71U
        fX04jPeEjNdttaxix/khwNuA6ZtQ8Pn66dY/a3ROR9Z1CeI/HuPHIxqveuf2jaKBz7ZLic
        9JufmMIyssyWqz+EwqpPG5gnsjVlHOE=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-R7FTlUbkPyq8V8_wkWfKcw-1; Tue, 04 Apr 2023 12:38:00 -0400
X-MC-Unique: R7FTlUbkPyq8V8_wkWfKcw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-17a678c2de9so17440054fac.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po1dD0V9oZXC1u6q0PdogM7Oei1BCdcz7qvnbPIGYkM=;
        b=sLD4Ai4wxvAV/SpCBjdOZzJGkwZckWEwfptFZoPm6xaeSo8XJBMTkijgow5G6bng4M
         hFZURIofEK7C5ij7gzxZZjW9a8ohQYT29hWKAkBT8Oe1ebfbrYIvCoN5+KoyUE8wJgXt
         hQd9y/sTrLBGhJNQyGk7whZZbz+EaxE2K1yoMkUYluorNCATtOWhs6yXzqCypOLGILW9
         yoRr/vANru2QwPFty0BIGhc6v7YysQMSA9pkDNzRlnDeJFAcUpdpIGQFunRQzLrRjx+3
         EJ7L+DS1DwmuVhs+YAflQbm68z8LQvWfIaE5ivI6EPwRU/uYFbm8alh7fvUYc4O4MND3
         RmOw==
X-Gm-Message-State: AAQBX9dnYGL2kgXwzjE/US9fzO9NqryTM6tEaOkvoai64UAP1n3+0Q2P
        vmf8wwvxxqbZAe+6PyRlJINA2Xvjgx2fqp+c3yXo4wDoUVn2EgURx6mucxQC/bk6IS6gFsu9tGI
        kLQ+m186C+LOzg6zHKwG4bTPK
X-Received: by 2002:a05:6808:4b:b0:384:23f0:21b7 with SMTP id v11-20020a056808004b00b0038423f021b7mr1347053oic.14.1680626279663;
        Tue, 04 Apr 2023 09:37:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350aOrxgdZwug+N0+LNMDxyZG6RB11xLyFdHeoJrlEj4dqfaDrYNSHKssIXTp1eibxVXFi6Velw==
X-Received: by 2002:a05:6808:4b:b0:384:23f0:21b7 with SMTP id v11-20020a056808004b00b0038423f021b7mr1347044oic.14.1680626279345;
        Tue, 04 Apr 2023 09:37:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a802:2599:c6a8:e6db:a08:61b6])
        by smtp.gmail.com with ESMTPSA id bd1-20020a056808220100b0038755008179sm5264623oib.26.2023.04.04.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:37:59 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 4/6] riscv/cmpxchg: Deduplicate xchg() asm functions
Date:   Tue,  4 Apr 2023 13:37:39 -0300
Message-Id: <20230404163741.2762165-5-leobras@redhat.com>
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

In this header every xchg define (_relaxed, _acquire, _release, vanilla)
contain it's own asm file, both for 4-byte variables an 8-byte variables,
on a total of 8 versions of mostly the same asm.

This is usually bad, as it means any change may be done in up to 8
different places.

Unify those versions by creating a new define with enough parameters to
generate any version of the previous 8.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 71 ++++++++++++--------------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index f88fae357071c..a524484946815 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,6 +11,17 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
+#define ___xchg(sfx, prepend, append, r, p, n)				\
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
 #define __xchg_relaxed(ptr, new, size)					\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -18,18 +29,12 @@
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".w", "", "",					\
+			__ret, __ptr, __new);				\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".d", "", "",					\
+			__ret, __ptr, __new);				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -51,20 +56,12 @@
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".w", "", RISCV_ACQUIRE_BARRIER,		\
+			__ret, __ptr, __new);				\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".d", "", RISCV_ACQUIRE_BARRIER,		\
+			__ret, __ptr, __new);				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -86,20 +83,12 @@
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".w", RISCV_RELEASE_BARRIER, "",		\
+			__ret, __ptr, __new);				\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".d", RISCV_RELEASE_BARRIER, "",		\
+			__ret, __ptr, __new);				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -121,18 +110,12 @@
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".w.aqrl", "", "",				\
+			__ret, __ptr, __new);				\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".d.aqrl", "", "",				\
+			__ret, __ptr, __new);				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
-- 
2.40.0

