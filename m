Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA06C2B99
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCUHoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCUHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93973B646
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679384593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYmUB/WTTMvmBA0Z285enRAA2vTEDkWBaww5wTiZcXo=;
        b=NAWHlrzTgTylWKzWEeYUJBxJ3ylNkhLoVToWSMktSWnjrlarIThrp9O5wzwB6hhMlPCZFw
        a0ic32PmvlhYsy5+Tw3YLpuBAikP13a0rR2OGqNEuFGAbDAtcNafbF/BYVeMCXcqjGwnp7
        /7UpiFLyod3SOR/EPU8Dfpv3aOTxhpA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-5BtWiOiXN4avUkJrDlqBmg-1; Tue, 21 Mar 2023 03:43:12 -0400
X-MC-Unique: 5BtWiOiXN4avUkJrDlqBmg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-176347f3b28so8210070fac.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYmUB/WTTMvmBA0Z285enRAA2vTEDkWBaww5wTiZcXo=;
        b=lpbG6xIDv4X5Yp8mYfFFRm8ncTYCmdn7MSAmzKR4ep3dN7PaGhUKBb6gTfXcDofOYJ
         xhDRrupn7N1PovDOvsjtj9nKpjd/9ONAFn4o1TpHJWJ+5YGViN4VH8i0gif1zti/n6rh
         WDiM2D8jGs1HYw1F7YfwreJUHHjcxrrKPbM887Gpe3+4Ie5H6sfm2AkfcO//1U4bR7h8
         b5ulgvI2KTg5Dqcb2pd55LsSIl6Qq5jFfUas2dxXcNpJAzmZD5yxYmKhiCEXaScwqX9C
         0Iv120j8/Kkb5OYzoWMZxs1L81j9L5xHo8CMvm2oDE1igfzeypRLaUMxW4Ikl2EEY4Ho
         pVrw==
X-Gm-Message-State: AO0yUKXxPPoiIwUTSlMNRwpv+34dd9a5eY8/274Kqh+jh0N1+qpeJiL5
        q3P0ET1homnp+GkNZWUCTkgVsUXzLQKdhSprXQ7cYg3Z2FfA+pgdk+dszPKouzhuqAFQSjuycX0
        q/yeZm9Ek79OylbNTGQFVZh5Y
X-Received: by 2002:a05:6870:6087:b0:16e:1aeb:d74b with SMTP id t7-20020a056870608700b0016e1aebd74bmr546844oae.33.1679384591353;
        Tue, 21 Mar 2023 00:43:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set8yT5HfmiKYU2SyLBb4cWhTZvsC1XCp0Rm1hcaLuS/6AU2e8J3Z++XLxX8CXeUurrVlfilkRQ==
X-Received: by 2002:a05:6870:6087:b0:16e:1aeb:d74b with SMTP id t7-20020a056870608700b0016e1aebd74bmr546832oae.33.1679384590919;
        Tue, 21 Mar 2023 00:43:10 -0700 (PDT)
Received: from localhost.localdomain ([179.111.176.145])
        by smtp.gmail.com with ESMTPSA id az15-20020a05687c230f00b0016a37572d17sm4047729oac.2.2023.03.21.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:43:10 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v2 4/6] riscv/cmpxchg: Deduplicate xchg() asm functions
Date:   Tue, 21 Mar 2023 04:42:47 -0300
Message-Id: <20230321074249.2221674-5-leobras@redhat.com>
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
index e49a2edc6f36c..715bf61e72c82 100644
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
+		___xchg(".w.aqrl", "", "");				\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		___xchg(".d.aqrl", "", "");				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
-- 
2.40.0

