Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002A66C2B96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCUHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCUHn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD55252
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679384586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yn+twTZLAkRdUYrcTaC/OxuB+ZzmlZ8IAyD5qH6ScI=;
        b=HsXhQXGtq8VocuhFzm9NsJZZxewh+a20SzX4L2elP1pBRza5t/gcVkFI3cB7ficS3UxGcd
        gSErxTCE8i984A3zuBukCnRsD0ivAn5uYeXKtC4X3ErIgA/tot08Q64LsiUNXm2fBFYbRQ
        6eJNjRhhM++CSWde9b8V8eIKSpVxm/Y=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-EEzNwstNO_61107J7_rtDg-1; Tue, 21 Mar 2023 03:43:05 -0400
X-MC-Unique: EEzNwstNO_61107J7_rtDg-1
Received: by mail-oo1-f71.google.com with SMTP id w5-20020a4a9785000000b0052521223553so4319822ooi.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yn+twTZLAkRdUYrcTaC/OxuB+ZzmlZ8IAyD5qH6ScI=;
        b=IGMYIHiAacvptDdaLdPv1/V6AlPgjBdgySHCR7zlGAZPaG8/4ulHVO+ym1A6SD4sg/
         wIHIOEVHkA6L3v3nlBK55Wp/SSeEI1NObTHQiifNOwgVLAJX4ePqF987BfWdQstoau0E
         icVZuuMsjiPK77W8YDG7IA5r/cJD7hRFibaAcEQR8YVxQGiXAOUCq26UVC3jhGdYitr1
         hjGY+gLKF5pClzB0BUgrkJvaQcT8ACWw6qUIhOolBm7lR/ztaSPGk2Vri7POBNh7gRdP
         5m5a7RVvunBOcoXoZhTXIIJfam0lsKJ7M6/mhKZkTjbklxiYckz1NCmSw9aAs3yhMSec
         ZCEQ==
X-Gm-Message-State: AO0yUKXf3c37Vu9MfGbdsVVGLSar7IBi9IdjfPk4VPiQoxvw/AXsTCZ7
        l4f7W/8BHNJuCUdKC+0lGyv7lusq5naImMvdLEX/ZRLw47SbmKiN3XE1aAgUX2otfwbYJpERVmc
        OWOm5FoGC0txNe0eQBLLE6XUZ
X-Received: by 2002:a05:6870:d38f:b0:177:9a8f:2a6a with SMTP id k15-20020a056870d38f00b001779a8f2a6amr638648oag.6.1679384584385;
        Tue, 21 Mar 2023 00:43:04 -0700 (PDT)
X-Google-Smtp-Source: AK7set+5dYLqUwBoGwWqYbNO6rmNI6RXPTyQIcUwdLTaU41SFvlJEUkqNzr5SVTeAvo9r89hTVkcJg==
X-Received: by 2002:a05:6870:d38f:b0:177:9a8f:2a6a with SMTP id k15-20020a056870d38f00b001779a8f2a6amr638640oag.6.1679384584181;
        Tue, 21 Mar 2023 00:43:04 -0700 (PDT)
Received: from localhost.localdomain ([179.111.176.145])
        by smtp.gmail.com with ESMTPSA id az15-20020a05687c230f00b0016a37572d17sm4047729oac.2.2023.03.21.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:43:03 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v2 1/6] riscv/cmpxchg: Deduplicate cmpxchg() asm functions
Date:   Tue, 21 Mar 2023 04:42:44 -0300
Message-Id: <20230321074249.2221674-2-leobras@redhat.com>
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

