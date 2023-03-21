Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1B6C2B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCUHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCUHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38573B0D2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679384595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlcmKFBm9EfeLOX/A4Ek+TTZZd7OjXZ+kA7z9b9Tay8=;
        b=FELvU8iTG6OCnY0D5kD65zbDo9uRms/WyLCQeOkHy+BsWHJNMTX8CLu2NasoGQsjhWKmyw
        Bfts1MI/npbylIsHf3VA/PW/kHut2paZ92biOXn23mWZ16AXENl1p/tf2BrimmFqqG6n3y
        Pqub/T5QRA/wpx1t9ZoCB/l/rriD2Wc=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-TCO51j4sN2SX95TmbVHPEg-1; Tue, 21 Mar 2023 03:43:14 -0400
X-MC-Unique: TCO51j4sN2SX95TmbVHPEg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-17714741d9dso8122386fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlcmKFBm9EfeLOX/A4Ek+TTZZd7OjXZ+kA7z9b9Tay8=;
        b=ZoVCGRDXWnkQYO1AD/fOe/cgUAcLqM98ZSEUBJMEEE75rPF/t7D97e9Lhm3kNrc+DQ
         3iGkXUfFOgs3sgunvTB5KsYgdvVM0VXt/XP4/zx0AZdgblXeyqmstARcmGmU6BuRE5OC
         5G1STdw3c5KJ457NCSI1B528H7pPhyl7tVkC3HF3bzpkaL6JoJzHDmWcTmOWS8lQ9lm3
         46G5qpNdmuHUluIaGWMEHgR40rm3DfLG2p0WN/FR4U+I/v5a1Jsz7ps7jbMjyP7GqmFE
         La8u4x9QE24AA+snNF0Bs1fBWI1OcmOW8EITpBJYMGqU7nQc3Bo3pwTOqj7AAAEsKxtn
         z8zg==
X-Gm-Message-State: AO0yUKX1lwmXVwUwiqkNqwHGyO0ZVt526wxpmBFkhKcW/1CEO5iw7j/g
        jAqjSfahokNGgW5gC2aJbypIVXcEteZUxZFqOFdEJc7DzDBGjVmbdQBX7xOADju9FRuecyX5M+Y
        E8dGXtEwp7LqpRqofEqDERWhWH3gt1V0CM4A=
X-Received: by 2002:a05:6870:17a1:b0:17e:5166:e5ad with SMTP id r33-20020a05687017a100b0017e5166e5admr561228oae.44.1679384593435;
        Tue, 21 Mar 2023 00:43:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set/pyAqYnO67AML+s1dNtvHd917Gw9QhFgk20X96rex8UneHTfhT63wtlM0E2stD1HimfqKP8w==
X-Received: by 2002:a05:6870:17a1:b0:17e:5166:e5ad with SMTP id r33-20020a05687017a100b0017e5166e5admr561219oae.44.1679384593178;
        Tue, 21 Mar 2023 00:43:13 -0700 (PDT)
Received: from localhost.localdomain ([179.111.176.145])
        by smtp.gmail.com with ESMTPSA id az15-20020a05687c230f00b0016a37572d17sm4047729oac.2.2023.03.21.00.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:43:12 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v2 5/6] riscv/cmpxchg: Deduplicate xchg() macros
Date:   Tue, 21 Mar 2023 04:42:48 -0300
Message-Id: <20230321074249.2221674-6-leobras@redhat.com>
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
index 715bf61e72c82..23da4d8e6f0c8 100644
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
-		___xchg(".w.aqrl", "", "");				\
-		break;							\
-	case 8:								\
-		___xchg(".d.aqrl", "", "");				\
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

