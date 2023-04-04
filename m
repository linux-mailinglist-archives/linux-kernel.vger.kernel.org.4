Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70FB6D6909
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjDDQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjDDQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0013D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680626279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x67eJiKWfkOOGp7f4Z5Mhye30XEwf/bDKb9kNuQLIhw=;
        b=ie9rx0bEy22TtSRPwkJgtSNRWc5tl7tWVpKgWrG+DNqJ0dvZX+ESkVwyb5tnS7Sf2fnLfC
        HaX5YeNBA/J+RNDWsJkS3wKjtsqojabOo/CxFsXsud3TDUlnlmK41QC1jlHxLKS0eknWnV
        XqB6j2wVzCTKOoEgk2wopMIFnBSER+M=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-p-nem63GMNaSgoB1MmMQGA-1; Tue, 04 Apr 2023 12:37:57 -0400
X-MC-Unique: p-nem63GMNaSgoB1MmMQGA-1
Received: by mail-oi1-f198.google.com with SMTP id j6-20020aca6546000000b003890ca8e7faso7569892oiw.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x67eJiKWfkOOGp7f4Z5Mhye30XEwf/bDKb9kNuQLIhw=;
        b=e0gMnZaQebwnUPyao0QhPhSomnJ/UGU9GT9N1bAtRncCOB2J3A4kznV0wvfwWFb4Us
         f+QTYol+6AoyFNWjuyQiXb4wfjaURtP31yzT1oXYJzYBBefS4OJFTEqSu4B78mCv1AfW
         JoUcaTv6ZnFq87WjdU7PT5RK2zCgppZ4RqRrPiuy6FGMbVPhFxrWIeokHCcY4fMWXoTo
         Io7NwaQ+rDYIFSqKaSmUQi8MQjpcgPdXGOF23gEW1KF6zrXn6nNaTJOWsGnMfGbvcvLL
         VaLHX4MGz6WDtc5JJ9fnUlsccoKCsnG8Hfn3E6k+vDRdm+VAmPTCcWSt+MYNxyN0AT9l
         cyYw==
X-Gm-Message-State: AAQBX9cyQTl0o+MRLrBwcIY8ZsyTS2mHkbQb3965XlN7pLKM9J4yvlHm
        G3X+2xLw1H74COP7WfdaJWCwG93uDhB9XN8z44xmOsJm6aPMrVslOyzQaFGxz9o9WOr4PCs8KiV
        mIapM4NaNKL4MOxzYgyemYLYw
X-Received: by 2002:a54:471a:0:b0:389:72d5:f16f with SMTP id k26-20020a54471a000000b0038972d5f16fmr1575913oik.28.1680626276555;
        Tue, 04 Apr 2023 09:37:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZFxm9VKkuRCMgs6kh4K+aV5vzqKnbbzO6Oq2hq27GK/DiYuPVZe/Rh2OKQA1BsOa41q5DNAw==
X-Received: by 2002:a54:471a:0:b0:389:72d5:f16f with SMTP id k26-20020a54471a000000b0038972d5f16fmr1575905oik.28.1680626276359;
        Tue, 04 Apr 2023 09:37:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a802:2599:c6a8:e6db:a08:61b6])
        by smtp.gmail.com with ESMTPSA id bd1-20020a056808220100b0038755008179sm5264623oib.26.2023.04.04.09.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:37:55 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/6] riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
Date:   Tue,  4 Apr 2023 13:37:38 -0300
Message-Id: <20230404163741.2762165-4-leobras@redhat.com>
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

Every arch_cmpxchg define (_relaxed, _acquire, _release, vanilla) contain
it's own define for creating tmp variables and calling the correct internal
macro for the desired version.

Those defines are mostly the same code, so there is no need to keep the 4
copies.

Create a helper define to avoid code duplication.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index f76a82274a4fd..f88fae357071c 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -204,46 +204,34 @@
 #define __cmpxchg_relaxed(ptr, old, new, size)				\
 	___cmpxchg(ptr, old, new, size, "", "", "")
 
-#define arch_cmpxchg_relaxed(ptr, o, n)					\
+#define _arch_cmpxchg(order, ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
+	(__typeof__(*(ptr))) __cmpxchg ## order((ptr), _o_, _n_,	\
+						sizeof(*(ptr)));	\
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

