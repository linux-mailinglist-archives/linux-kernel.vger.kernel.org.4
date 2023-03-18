Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52F46BF8CB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCRIC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRICY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3A20A07
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679126497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yn+twTZLAkRdUYrcTaC/OxuB+ZzmlZ8IAyD5qH6ScI=;
        b=TiFdufxzQu4fp60xjHtwfqVMGmlqMmJed/dKupFvvBtfxNhcKjyla7E94Rw+4fcWyMWQhp
        fX3FUxYSu1FFOQJtwKVuUPFJMcY97LhYmFp56ZZ0dpg6vh22dkwH299OJzX40qj0Fyp7ut
        An6GMMhAR9+5R1y7iO6Nrh14rAZT09E=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-bshf04h8PQOARmpipDrRTg-1; Sat, 18 Mar 2023 04:01:34 -0400
X-MC-Unique: bshf04h8PQOARmpipDrRTg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-177c2fb86b7so4223135fac.20
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yn+twTZLAkRdUYrcTaC/OxuB+ZzmlZ8IAyD5qH6ScI=;
        b=iS/pqMNT58D5qBShD3xUBxzRSmHcEaemJf9WPUPq0Ncld2FXy9V1QMQIzh7KbIITKk
         LUiZfoWGJdYHUMYREK6vgPaRRtEbIVzSJX+NDzqULPNPQzR5BKylUkzGRNHxmjBEH96s
         7wuHi62A5pAcWAky4lkuvMweyMHo5HANz/b6XSN5YkTsfBQAxYlxfjVGmH1K1EPxb7Q3
         QAiW3LRjvMtesNRUlDqZtaUw+bsNs+3pkRAnO1xDShMuMGKJd0BguFQpotfEuvIwJwtP
         oNlEwdVkGtNOG1hsYlQ4aM9yWbZmUDati7oeRGNYpnGSY72gqkUOWDEhM0XzbzZ79EnB
         ZCTQ==
X-Gm-Message-State: AO0yUKVwJNpacdwOFgP/0jt0ax2ZNYvrMRW4bndaY9Y+4fN4pI4LWNZx
        DkhE4fgsJUTS2PDTNYmLiluCBF2qQSQ3dDyoqPOnL3PRAEAUWGjzSNfOEU9AUh7ezIL2NusWoEb
        TNoFlXRgcup2jq7vfH/yGDngO
X-Received: by 2002:a9d:6184:0:b0:68b:e0bc:c533 with SMTP id g4-20020a9d6184000000b0068be0bcc533mr548139otk.20.1679126493508;
        Sat, 18 Mar 2023 01:01:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set9NAItfduCFGzNneJt6a8h+WnJSJ4XrToipUUX1gzk0K9Pe+V0SU1X8xfnrS86JCcQd8uu/uA==
X-Received: by 2002:a9d:6184:0:b0:68b:e0bc:c533 with SMTP id g4-20020a9d6184000000b0068be0bcc533mr548132otk.20.1679126493257;
        Sat, 18 Mar 2023 01:01:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d4803000000b0069dc250cb24sm1824462otf.3.2023.03.18.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:01:32 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/6] riscv/cmpxchg: Deduplicate cmpxchg() asm functions
Date:   Sat, 18 Mar 2023 05:00:55 -0300
Message-Id: <20230318080059.1109286-2-leobras@redhat.com>
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
 arch/riscv/include/asm/cmpxchg.h | 102 ++++++++-----------------------
 1 file changed, 24 insertions(+), 78 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 12debce235e52..21984d24cbfe7 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -163,6 +163,22 @@
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
+
+#define ___cmpxchg(lr_sfx, sc_sfx, prepend, append)			\
+{									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"0:	lr" lr_sfx " %0, %2\n"				\
+		"	bne  %0, %z3, 1f\n"				\
+		"	sc" sc_sfx " %1, %z4, %2\n"			\
+		"	bnez %1, 0b\n"					\
+		append							\
+		"1:\n"							\
+		: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)		\
+		: "rJ" ((long)__old), "rJ" (__new)			\
+		: "memory");						\
+}
+
 #define __cmpxchg_relaxed(ptr, old, new, size)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
@@ -172,26 +188,10 @@
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
+		___cmpxchg(".w", ".w", "", "");				\
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
+		___cmpxchg(".d", ".d", "", "");				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -216,28 +216,10 @@
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
+		___cmpxchg(".w", ".w", "", RISCV_ACQUIRE_BARRIER);	\
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
+		___cmpxchg(".d", ".d", "", RISCV_ACQUIRE_BARRIER);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -262,28 +244,10 @@
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
+		___cmpxchg(".w", ".w", RISCV_RELEASE_BARRIER, "");	\
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
+		___cmpxchg(".d", ".d", RISCV_RELEASE_BARRIER, "");	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -308,28 +272,10 @@
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
+		___cmpxchg(".w", ".w.rl", "", "	fence rw, rw\n");	\
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
+		___cmpxchg(".d", ".d.rl", "", "	fence rw, rw\n");	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
-- 
2.40.0

