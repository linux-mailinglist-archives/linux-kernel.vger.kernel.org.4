Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94D6D690C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjDDQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjDDQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F303ABC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680626286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0rQxrNAcokC6W+51FfMD9h8pzjOdzJF6kUxCcV/Qp0=;
        b=L02M0KUyJ0bdg33efyOiSdmOueLDtuKyPxYR6gmsw9ny3KOahi+FzoWWFpvWu7gLooILKM
        8rV5v8EFfwbcviJlHXT8q5HSdixXwd84KvvlbkS80Q6fh2DFoRtwNVGcunxl4U92lWePkF
        hHrgXwPmtl/MmQ/4W9GDI2eA7I7iw70=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-Ij9M2tDiMBaVg6HuZLTQpw-1; Tue, 04 Apr 2023 12:38:05 -0400
X-MC-Unique: Ij9M2tDiMBaVg6HuZLTQpw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-17fd0d597dcso10069077fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0rQxrNAcokC6W+51FfMD9h8pzjOdzJF6kUxCcV/Qp0=;
        b=qbmvx16XMTgyFODpnKiIIKwygfaOgZuv1RtJRU/PhXXAwj0cNW26egQwnmz8CINAmJ
         idk+cZjZl/3F9e1EDy9xs9MtgiEz/+clx6icntlMcG9ZQ41iPrdzxtGE8OYBN/yvD0It
         H3bhodsb8dzqSFtCcVGXaXfsGnOjeXjXIGbI+KszKlzymObpzc7csUhKeumfiXusBpxz
         GkU9697EFgqnwwT4fAO6kG4OuqSPKAurRTACgouBGMFdHEvLqryziuP9S+WFU+l7RNs7
         DJ0DJAvdO38WxMXzZm4vCSv6tIOyDKaLke3BB0LNlA54PWIiJv4nDAE0SB5YNuFjqJvD
         4JnQ==
X-Gm-Message-State: AAQBX9feidreTTGWpTsfryrCPg1BIxfpeezfW7oXnxHlJaAduFNu8e7n
        kRwnP5kIOXSgQwi5DSCQ/jbnyRdCWap3fiRWLlNAM3I0TdKeJ+F0FYankdgfAVgJbIKpo5NM1ds
        m7XCA7FxDLZF/wVMaQlQTeUoqlySqWM2qH70=
X-Received: by 2002:a05:6808:6141:b0:389:4a00:51b5 with SMTP id dl1-20020a056808614100b003894a0051b5mr1470946oib.8.1680626282540;
        Tue, 04 Apr 2023 09:38:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350YnaLdfH8tuMD+Yi3A2v4l8UvYgA1HiIUzt7doj1XBln6gnqsmFL5ffbVmpHlQtBFCWz3mhXA==
X-Received: by 2002:a05:6808:6141:b0:389:4a00:51b5 with SMTP id dl1-20020a056808614100b003894a0051b5mr1470938oib.8.1680626282256;
        Tue, 04 Apr 2023 09:38:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a802:2599:c6a8:e6db:a08:61b6])
        by smtp.gmail.com with ESMTPSA id bd1-20020a056808220100b0038755008179sm5264623oib.26.2023.04.04.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:38:01 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 5/6] riscv/cmpxchg: Deduplicate xchg() macros
Date:   Tue,  4 Apr 2023 13:37:40 -0300
Message-Id: <20230404163741.2762165-6-leobras@redhat.com>
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
 arch/riscv/include/asm/cmpxchg.h | 72 ++++++--------------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index a524484946815..480234719b78c 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,7 +11,7 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
-#define ___xchg(sfx, prepend, append, r, p, n)				\
+#define ____xchg(sfx, prepend, append, r, p, n)				\
 ({									\
 	__asm__ __volatile__ (						\
 		prepend							\
@@ -22,19 +22,19 @@
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
-		___xchg(".w", "", "",					\
-			__ret, __ptr, __new);				\
+		____xchg(".w" sfx, prepend, append,			\
+			 __ret, __ptr, __new);				\
 		break;							\
 	case 8:								\
-		___xchg(".d", "", "",					\
-			__ret, __ptr, __new);				\
+		____xchg(".d" sfx, prepend, append,			\
+			 __ret, __ptr, __new);				\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -42,6 +42,9 @@
 	__ret;								\
 })
 
+#define __xchg_relaxed(ptr, new, size)					\
+	___xchg(ptr, new, size, "", "", "")
+
 #define arch_xchg_relaxed(ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
@@ -50,24 +53,7 @@
 })
 
 #define __xchg_acquire(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		___xchg(".w", "", RISCV_ACQUIRE_BARRIER,		\
-			__ret, __ptr, __new);				\
-		break;							\
-	case 8:								\
-		___xchg(".d", "", RISCV_ACQUIRE_BARRIER,		\
-			__ret, __ptr, __new);				\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___xchg(ptr, new, size, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_acquire(ptr, x)					\
 ({									\
@@ -77,24 +63,7 @@
 })
 
 #define __xchg_release(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		___xchg(".w", RISCV_RELEASE_BARRIER, "",		\
-			__ret, __ptr, __new);				\
-		break;							\
-	case 8:								\
-		___xchg(".d", RISCV_RELEASE_BARRIER, "",		\
-			__ret, __ptr, __new);				\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	___xchg(ptr, new, size, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg_release(ptr, x)					\
 ({									\
@@ -104,24 +73,7 @@
 })
 
 #define __xchg(ptr, new, size)						\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		___xchg(".w.aqrl", "", "",				\
-			__ret, __ptr, __new);				\
-		break;							\
-	case 8:								\
-		___xchg(".d.aqrl", "", "",				\
-			__ret, __ptr, __new);				\
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

