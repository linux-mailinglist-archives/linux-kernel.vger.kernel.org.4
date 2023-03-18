Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EED6BF8CD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCRICi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCRICb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3AC20A15
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679126503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMfpmYwfPn+xgsAmrLdh6YxWI9aM4T+CUsR5ROJOFiM=;
        b=D9oMiD84CmIimDPPfvCQ/jQ83FmpLX8WkIDQ3Dl/C7qpOvI4v/wvFJCF35NzsHfglk/p4b
        1JH1ZqDWVdvi+WnAEMoolFT0ojiT0lc69jmG4u2/YkGBEIK32xFQ5YY1la7dr2Uok3tFmB
        6YEg5kQIwls/3teY1X2EaFrKh7UcSM4=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-bmojtJIROiy64ShizXBI6Q-1; Sat, 18 Mar 2023 04:01:41 -0400
X-MC-Unique: bmojtJIROiy64ShizXBI6Q-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1778b36a88dso4234168fac.17
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMfpmYwfPn+xgsAmrLdh6YxWI9aM4T+CUsR5ROJOFiM=;
        b=D/i0OzuXa/JqYIpsiMraBrVsXdvDdzp5x4uOr4LDefoqSsdOAbH/di9YTgwOV1hAEg
         StLQYFaZYQIboIaI3U2HC8WL68Bk9djTuFSCIP94oD/dC13ZHYxws4JxwomAtUZoR2/c
         JUO11/NItziWPh0pQJZLv688deUW04et+KRukVcT2e93LjP8ahFQ41tVDgIx63+D7bQm
         lgQQOm+V7N9dFO+bGx5KoPPVkR1HFYUdA5fDCVdQV7V9/evNfCAen54Xct9Rdh7o2lmh
         856lDfxqsd3HhRB6+A4rj5j5tuEq32EeuJMQYtFiiK44rHFBnZEj48XNtqR3bECIcE7J
         Z1Uw==
X-Gm-Message-State: AO0yUKUKXsf0QtX3p5jcit/l3yf899VKIGAa8ic09qthM4x0JLKiFGC0
        3rHfO9XeoBXt+4Ax4WSrLaHVSdkDdDqDwKmpQoZNz16TSp72Wlkp6Ld2OabDVFtoOadibNfRGEp
        NT7YvpERzIjGF6BfBLNtm4Nrf
X-Received: by 2002:a9d:4813:0:b0:68b:dfc9:c41c with SMTP id c19-20020a9d4813000000b0068bdfc9c41cmr696697otf.9.1679126500834;
        Sat, 18 Mar 2023 01:01:40 -0700 (PDT)
X-Google-Smtp-Source: AK7set+qA+Wajn70KJF8VSYWlbJbIwFT+kahKHnCy/vx5pmbuTdfzLCDMZ/nlXQnhye3u/ZMg1TpNw==
X-Received: by 2002:a9d:4813:0:b0:68b:dfc9:c41c with SMTP id c19-20020a9d4813000000b0068bdfc9c41cmr696690otf.9.1679126500582;
        Sat, 18 Mar 2023 01:01:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d4803000000b0069dc250cb24sm1824462otf.3.2023.03.18.01.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:01:40 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/6] riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
Date:   Sat, 18 Mar 2023 05:00:57 -0300
Message-Id: <20230318080059.1109286-4-leobras@redhat.com>
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

Every arch_cmpxchg define (_relaxed, _acquire, _release, vanilla) contain
it's own define for creating tmp variables and calling the correct internal
macro for the desired version.

Those defines are mostly the same code, so there is no need to keep the 4
copies.

Create a helper define to avoid code duplication.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index c7a13eec4dbcc..e49a2edc6f36c 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -202,46 +202,35 @@
 #define __cmpxchg_relaxed(ptr, old, new, size)				\
 	___cmpxchg(ptr, old, new, size, "", "", "")
 
-#define arch_cmpxchg_relaxed(ptr, o, n)					\
+#define _arch_cmpxchg(order, ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
+	(__typeof__(*(ptr))) __cmpxchg ## order((ptr),			\
+							_o_, _n_,	\
+							sizeof(*(ptr)));\
 })
 
+#define arch_cmpxchg_relaxed(ptr, o, n)					\
+	_arch_cmpxchg(_relaxed, ptr, o, n)
+
 #define __cmpxchg_acquire(ptr, old, new, size)				\
 	___cmpxchg(ptr, old, new, size, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
-})
+	_arch_cmpxchg(_acquire, ptr, o, n)
 
 #define __cmpxchg_release(ptr, old, new, size)				\
 	___cmpxchg(ptr, old, new, size, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_cmpxchg_release(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_release((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
-})
+	_arch_cmpxchg(_release, ptr, o, n)
 
 #define __cmpxchg(ptr, old, new, size)					\
 	___cmpxchg(ptr, old, new, size, ".rl", "", "	fence rw, rw\n")
 
 #define arch_cmpxchg(ptr, o, n)						\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg((ptr),				\
-				       _o_, _n_, sizeof(*(ptr)));	\
-})
+	_arch_cmpxchg(, ptr, o, n)
 
 #define arch_cmpxchg_local(ptr, o, n)					\
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
-- 
2.40.0

