Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D636C2A82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjCUGge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjCUGg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9930DD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679380518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMfpmYwfPn+xgsAmrLdh6YxWI9aM4T+CUsR5ROJOFiM=;
        b=UXQZKNNvrmvAVorVMmtXHvAaO+FvhCUA6dbTds+RTOdPgAC24mmoxU8dxlcNHN3BEmEHB8
        6P1gLjrAtoLLCfSHo5cSAPm+fnrbfRdANybu9VcWuFSfj3KcP4FV2TzvA1bsnW/L7H+ARc
        gZdfVoHiqHxQwuQLtdxW7oIlDTr4JjU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-MLK6455cMVytZ0lLgRTSaQ-1; Tue, 21 Mar 2023 02:35:17 -0400
X-MC-Unique: MLK6455cMVytZ0lLgRTSaQ-1
Received: by mail-oi1-f199.google.com with SMTP id n205-20020acabdd6000000b003846654dd65so6114161oif.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMfpmYwfPn+xgsAmrLdh6YxWI9aM4T+CUsR5ROJOFiM=;
        b=vw6UuFtq8JuCosg83g+V950g3Rhj2CYCrNawFzcFxGyIrzhEzoZm6HfoFHl/30/mhF
         tKIpFjrkTBXAfEfdWYuSFBkC4+VVTNQTOApgZqyYsgZUBs/oaNW1GH41aKW4QMPVzscc
         OoDn+bEu10t6aqyEVQRs+KgZVzd3BMWsLxG74RBMcWKG3XCgnMamPCyKgZBw/BjRiJbG
         jFfb3+wvEmEdn/8XcXtjwchrbZnNE96ZZ9qt1KxSvJCaY63B6XGCMzzo3hqrjn4uMpqJ
         xZjLGz153woj/Bq9l8WychAP1RzsyzqCp/ujFt+1KOALaQ31Ma4+Tx3PpBg6YUmwvhHe
         g8uA==
X-Gm-Message-State: AO0yUKVclnn9f+23dYLjsJeqVTuZQtkebuhJV1qpmpBgRvaJnFoq1ggl
        fAkC1mYJt1CIVE6Gt+dZ8d7BXkjBTku0mBYBcb6xhz4t/H3af/VQOwci6fs+U0EFkR1aUbg8QnS
        rMRiKTRgBRDUmvXn6FwK0eCCp
X-Received: by 2002:a4a:49ce:0:b0:53b:4b94:45bf with SMTP id z197-20020a4a49ce000000b0053b4b9445bfmr436115ooa.3.1679380516942;
        Mon, 20 Mar 2023 23:35:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set9KBCi4JudcKB/KFTrhmudiUfxMZmrtBSAQiYyoKeP9b0F99/cAettMuxy2bo1MR2I9SFwNag==
X-Received: by 2002:a4a:49ce:0:b0:53b:4b94:45bf with SMTP id z197-20020a4a49ce000000b0053b4b9445bfmr436107ooa.3.1679380516740;
        Mon, 20 Mar 2023 23:35:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id y75-20020a4a454e000000b005293e9a12f5sm4545147ooa.45.2023.03.20.23.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:35:16 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/6] riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
Date:   Tue, 21 Mar 2023 03:34:29 -0300
Message-Id: <20230321063430.2218795-4-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321063430.2218795-1-leobras@redhat.com>
References: <20230321063430.2218795-1-leobras@redhat.com>
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

