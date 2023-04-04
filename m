Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F516D690B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjDDQjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjDDQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B00F3C14
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680626287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Eu0Zi/ZTTdFnwlWVeYiPrkCPaBaCVeU5jDe5lhDGhs=;
        b=QB+UfjMvuegx8n5K1epr7BOdTbYMqLiyMnrdbfTEy7ixmfF2/lHabi9rpH1Ad0T1TcQZqn
        UtCt5ndiArw5PXrB4vM0Gx8PWUycrITpNlmoDTC+Y1LEcl3iw54A9KGMYvfrIlW7ryh9ph
        tNfB4iXkWB8Jj4uexHvhEyMxO7Zgn5A=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-pwkNvc4bMtm6ffO0UYQuwg-1; Tue, 04 Apr 2023 12:38:06 -0400
X-MC-Unique: pwkNvc4bMtm6ffO0UYQuwg-1
Received: by mail-oi1-f199.google.com with SMTP id i128-20020acaea86000000b003893eb09687so7075368oih.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Eu0Zi/ZTTdFnwlWVeYiPrkCPaBaCVeU5jDe5lhDGhs=;
        b=FL03yYC1qWsheJXUGNtbt6ZdChtl8JflgWZRzicyBnV63eOgrYGR1EI8xH5wqqjWfg
         1egKzBWJV1h5aMF77SlMj6gADuCV295somY1SdBEcprwUDldBD40NhEzWoY0HsiLMYZ6
         toyYYq9zbEYwYw5qTPm3vG2kF8aXJztavuaWaDt3BtCG4p53GcZlnBnGZeSORlFgtt4X
         c18+2DyyeQF6pSt8zP+bJWaAcn70BHiZS1Zf42LP2f6p/MbN7ueKXYNZOsSzwXZOgwuJ
         nxZNtg8FDItZTsOwharN4JNyI0DtbepnteW52oLwOrMT8cq9TIqXwVgzMYFYkGexLsw4
         MVVA==
X-Gm-Message-State: AAQBX9cSoYK5B7chakNSAAFsFFDjleKFd6kXoYT7vmgBv3PufiykZydf
        Y5Lc6aLiWiitoMFebW66GJ6O7Suo9UJDZxvxIf5iE53khXW31MG+x0IghdxQD2UeD49DU/Yx5r3
        chsMas87mXtN17s2sj357blYF
X-Received: by 2002:aca:d944:0:b0:384:3cc0:9ffd with SMTP id q65-20020acad944000000b003843cc09ffdmr1605626oig.9.1680626285347;
        Tue, 04 Apr 2023 09:38:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZH+tLo6+HoUfrUJlea3gq5Hmp/51sq6E4j8u/P3iEiEiy01tvmDOosUyXWMyR/S17heMTNgg==
X-Received: by 2002:aca:d944:0:b0:384:3cc0:9ffd with SMTP id q65-20020acad944000000b003843cc09ffdmr1605617oig.9.1680626285148;
        Tue, 04 Apr 2023 09:38:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a802:2599:c6a8:e6db:a08:61b6])
        by smtp.gmail.com with ESMTPSA id bd1-20020a056808220100b0038755008179sm5264623oib.26.2023.04.04.09.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:38:04 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 6/6] riscv/cmpxchg: Deduplicate arch_xchg() macros
Date:   Tue,  4 Apr 2023 13:37:41 -0300
Message-Id: <20230404163741.2762165-7-leobras@redhat.com>
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

Every arch_xchg define (_relaxed, _acquire, _release, vanilla) contain it's
own define for creating tmp variables and calling the correct internal
macro for the desired version.

Those defines are mostly the same code, so there is no need to keep the 4
copies.

Create a helper define to avoid code duplication.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 480234719b78c..905a888d8b04d 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -45,41 +45,33 @@
 #define __xchg_relaxed(ptr, new, size)					\
 	___xchg(ptr, new, size, "", "", "")
 
-#define arch_xchg_relaxed(ptr, x)					\
+#define _arch_xchg(order, ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
+	(__typeof__(*(ptr))) __xchg ## order((ptr),			\
+					     _x_, sizeof(*(ptr)));	\
 })
 
+#define arch_xchg_relaxed(ptr, x)					\
+	_arch_xchg(_relaxed, ptr, x)
+
 #define __xchg_acquire(ptr, new, size)					\
 	___xchg(ptr, new, size, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_acquire(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(_acquire, ptr, x)
 
 #define __xchg_release(ptr, new, size)					\
 	___xchg(ptr, new, size, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg_release(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_release((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(_release, ptr, x)
 
 #define __xchg(ptr, new, size)						\
 	___xchg(ptr, new, size, ".aqrl", "", "")
 
 #define arch_xchg(ptr, x)						\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(, ptr, x)
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.40.0

