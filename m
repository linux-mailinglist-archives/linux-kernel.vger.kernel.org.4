Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7DD6BF8D0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCRICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjCRICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC14B21977
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679126513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbEE9rLsMkeSG6CkDtERD6c7FbVv+HEbsIDG5ynJNIc=;
        b=IRgROxCrZ7t5sjyyCbgdF1MPhdBWKMOKi67sriAH2QwkFZIxYGy9lWc6ZEErGIZLSvhSyy
        6S9iAj2sZqmm26CuboNg6iKSoBuuxVP2a3EMkLrvEN4ZHHBcnlgDox+aqIuRFyHL7S5lzi
        kk8mcngHjE8O9ZwC1lEQlT2SkIM1NwA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-8szKnRdvMyaPoKU3ZT1Sng-1; Sat, 18 Mar 2023 04:01:45 -0400
X-MC-Unique: 8szKnRdvMyaPoKU3ZT1Sng-1
Received: by mail-ot1-f70.google.com with SMTP id a15-20020a0568300b8f00b0069965814cf7so3332471otv.15
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbEE9rLsMkeSG6CkDtERD6c7FbVv+HEbsIDG5ynJNIc=;
        b=QoBRoPlAr7c9RYNKv5xwgQ07zgGnez+DkWX2ts0+pXApV05/5+ezXYNLGPjL4K0g98
         lcfrYxAiL1xF/MQD+4aQuK7PFwPSpyxdOaSAdCZsb4Kfv0LPYE2hpK8PVnH70xHtqYGK
         /5wyDWqY/TdaFDMkqVmIx3DZhNmt5zPjz2YqwS9sHJg1GA8a9syQAPMkdJKmxCNV1JEd
         yhPmt6+vdVscofEdUQFZSH3gF09Wr07QP2KzeL9ge4hgXChFbPUqp/R9BPAnt6f9PkP1
         NviQgEQgUYMtG7xlQeQIE8cGTapdzy4u5XihjAua9Q5iHk/Dj3Soa9lVULTrx7woal9Z
         E7Ew==
X-Gm-Message-State: AO0yUKWeJ9TIFOx7HLjOZyMxUZG8uws/lfndqD1+oxrIAFRgUYpR9/Yw
        QoGjPXKuRGWlTRV++4vtj5iK6mTPGxw8EDOoxCDV3LD8iXk6soWeZraQ5AdQic9OQYyU03bghlg
        iwozw0E8vucGjdYtqXmRmYyb4
X-Received: by 2002:a9d:6d07:0:b0:699:a4f5:c951 with SMTP id o7-20020a9d6d07000000b00699a4f5c951mr545249otp.2.1679126504310;
        Sat, 18 Mar 2023 01:01:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set98ZKY0u5f8b+haxIAAI83p8gfQCrvcJ86i5uq8nFKjoznRe70RyMpyZxxyaIYMjXHy5gPGaQ==
X-Received: by 2002:a9d:6d07:0:b0:699:a4f5:c951 with SMTP id o7-20020a9d6d07000000b00699a4f5c951mr545241otp.2.1679126504089;
        Sat, 18 Mar 2023 01:01:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d4803000000b0069dc250cb24sm1824462otf.3.2023.03.18.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:01:43 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] riscv/cmpxchg: Deduplicate xchg() asm functions
Date:   Sat, 18 Mar 2023 05:00:58 -0300
Message-Id: <20230318080059.1109286-5-leobras@redhat.com>
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
 arch/riscv/include/asm/cmpxchg.h | 63 ++++++++++----------------------
 1 file changed, 19 insertions(+), 44 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index e49a2edc6f36c..13dc608229ef0 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,6 +11,17 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
+#define ___xchg(sfx, prepend, append)					\
+({									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amoswap" sfx " %0, %2, %1\n"			\
+		append							\
+		: "=r" (__ret), "+A" (*__ptr)				\
+		: "r" (__new)						\
+		: "memory");						\
+})
+
 #define __xchg_relaxed(ptr, new, size)					\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -18,18 +29,10 @@
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".w", "", "");					\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".d", "", "");					\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -51,20 +54,10 @@
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".w", "", RISCV_ACQUIRE_BARRIER);		\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".d", "", RISCV_ACQUIRE_BARRIER);		\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -86,20 +79,10 @@
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".w", RISCV_RELEASE_BARRIER, "");		\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".d", RISCV_RELEASE_BARRIER, "");		\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -121,18 +104,10 @@
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg("w.aqrl", "", "");				\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg("d.aqrl", "", "");				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
-- 
2.40.0

