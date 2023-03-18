Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DC6BF8CE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCRICp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjCRICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C3211FA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679126510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gfMcI5aMDF6IpHIz8HZtjeTtHnq7AJwdDOIUhbWBLk=;
        b=KH4rzIl1enHRsC6JE1NLaP5pl2g3qjMdq241lLu9VI94fJ0/3hyTJgZJV3v9V8YHSpCCVD
        H8a3BiRErzpf7hmQgl9MHtt2/ahO1rhxVvk7bC9bw1DWRZuSrgcjkRKichedTPTVWsnN4h
        IqIns2BEhVehNJrJjs6El6C9mUxW754=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-UGyMnnYDOIqCL7lnBcHH4Q-1; Sat, 18 Mar 2023 04:01:48 -0400
X-MC-Unique: UGyMnnYDOIqCL7lnBcHH4Q-1
Received: by mail-ot1-f72.google.com with SMTP id g19-20020a056830161300b0069d6fbb1a72so2990392otr.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gfMcI5aMDF6IpHIz8HZtjeTtHnq7AJwdDOIUhbWBLk=;
        b=VyYHFQTVPwsvX1RBJcCCS5Ob34hSdl8ENXuesJL+2qyW4/Tw2bSaw3cozb6T6emgt4
         sLE8fhI2vHhyWTgq9G6UGkJnJHsWHPYZU3YNhNmR9y9U5iQCQG8iXILF40AIaMWxYMXK
         vESOGQ9tdiBDiHxo0/Pvdsr2BHdyTEmll9ZTLoigEMyqHzAInaxnUOaK21mGIdrEcevr
         mmqvBDyRejTn3btjGbV/VT6HNSnQtiu7ZcNN/3JfKwWM7MiwMq234aafqOk2A+dPH6Q+
         leqkSiWV9CmyNzfGdDVJFWtFXvJ640gMGAmJltD46QAo6GiaxeXtnMXhMbbxjoD+6Z9c
         MqMA==
X-Gm-Message-State: AO0yUKWqriVokdox5jEH1jStdLdQnxV6YM1eihuStRlDZJuZQ954gzmF
        kXHSCgqXqdVRPz3/afsw9GgwWvWhTnVgQeKUtiMvZeMx0yPIrBcBzGFltbbSm0Ari/+9qiwRIlM
        FgeQPVBFVzjBA4s9xUMLnDRsh
X-Received: by 2002:a4a:976c:0:b0:525:42c7:9a5f with SMTP id v41-20020a4a976c000000b0052542c79a5fmr622251ooi.6.1679126507897;
        Sat, 18 Mar 2023 01:01:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set/b+sFSDMT3cPiuGUXdE8iECw0N3iv23H541xyVl8EvWgowAjDCIuSTW7z8aNpA5JDXO8rfgw==
X-Received: by 2002:a4a:976c:0:b0:525:42c7:9a5f with SMTP id v41-20020a4a976c000000b0052542c79a5fmr622245ooi.6.1679126507684;
        Sat, 18 Mar 2023 01:01:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d4803000000b0069dc250cb24sm1824462otf.3.2023.03.18.01.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:01:47 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] riscv/cmpxchg: Deduplicate xchg() macros
Date:   Sat, 18 Mar 2023 05:00:59 -0300
Message-Id: <20230318080059.1109286-6-leobras@redhat.com>
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

Every xchg define (_relaxed, _acquire, _release, vanilla) contain it's own
define for creating tmp variables and selecting the correct asm code for
given variable size.

All those defines are mostly the same code (other than specific barriers),
so there is no need to keep the 4 copies.

Unify those under a more general define, that can reproduce the previous 4
versions.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 62 ++++++--------------------------
 1 file changed, 10 insertions(+), 52 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 13dc608229ef0..23da4d8e6f0c8 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,7 +11,7 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
-#define ___xchg(sfx, prepend, append)					\
+#define ____xchg(sfx, prepend, append)					\
 ({									\
 	__asm__ __volatile__ (						\
 		prepend							\
@@ -22,17 +22,17 @@
 		: "memory");						\
 })
 
-#define __xchg_relaxed(ptr, new, size)					\
+#define ___xchg(ptr, new, size, sfx, prepend, append)			\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(new) __new = (new);					\
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
 	case 4:								\
-		___xchg(".w", "", "");					\
+		____xchg(".w" sfx, prepend, append);			\
 		break;							\
 	case 8:								\
-		___xchg(".d", "", "");					\
+		____xchg(".d" sfx, prepend, append);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -40,6 +40,9 @@
 	__ret;								\
 })
 
+#define __xchg_relaxed(ptr, new, size)					\
+	___xchg(ptr, new, size, "", "", "")
+
 #define arch_xchg_relaxed(ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
@@ -48,22 +51,7 @@
 })
 
 #define __xchg_acquire(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		___xchg(".w", "", RISCV_ACQUIRE_BARRIER);		\
-		break;							\
-	case 8:								\
-		___xchg(".d", "", RISCV_ACQUIRE_BARRIER);		\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___xchg(ptr, new, size, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_acquire(ptr, x)					\
 ({									\
@@ -73,22 +61,7 @@
 })
 
 #define __xchg_release(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		___xchg(".w", RISCV_RELEASE_BARRIER, "");		\
-		break;							\
-	case 8:								\
-		___xchg(".d", RISCV_RELEASE_BARRIER, "");		\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___xchg(ptr, new, size, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg_release(ptr, x)					\
 ({									\
@@ -98,22 +71,7 @@
 })
 
 #define __xchg(ptr, new, size)						\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		___xchg("w.aqrl", "", "");				\
-		break;							\
-	case 8:								\
-		___xchg("d.aqrl", "", "");				\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___xchg(ptr, new, size, ".aqrl", "", "")
 
 #define arch_xchg(ptr, x)						\
 ({									\
-- 
2.40.0

