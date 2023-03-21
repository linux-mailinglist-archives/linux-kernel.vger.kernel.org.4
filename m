Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFC6C2B98
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCUHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCUHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D20812BC0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679384591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMfpmYwfPn+xgsAmrLdh6YxWI9aM4T+CUsR5ROJOFiM=;
        b=MSHiYrRYsot4pTzKm//qwphesOHsy8RZk7sbZxAStprBKYS56FxQKKPQwmi0Eo+o7q3kkO
        PO/D1MZ/GGwqprmBeBMoMyr3QeJnm6oyJDVhder2HniypwzyJL/AXX8ApZTr+1aCm7PCFg
        O2XahZBAFo/UYzuiy2S924Rxx4mydws=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-Q_EhCMXZOeOgZyIssoa1dg-1; Tue, 21 Mar 2023 03:43:09 -0400
X-MC-Unique: Q_EhCMXZOeOgZyIssoa1dg-1
Received: by mail-ot1-f69.google.com with SMTP id a11-20020a05683012cb00b0068bdd21c8d7so6755145otq.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMfpmYwfPn+xgsAmrLdh6YxWI9aM4T+CUsR5ROJOFiM=;
        b=SOu4jqpX6UtK23TfjHPKJ1kx88rZZoUMe+hEJnY4VTgh+6IS051eRllWp3ZSqxd9Gb
         V4FPEVpBmkkCK66QqTSOP1Wwpybjn0Mu3lRqzAw4MrU+mOGOmHK0cd4hzCuy18EKdhuf
         KfzHts8FeklpGm5KcQ/gTd7CQYmXG94atlDYWQx7EtTcNNVOX0lpJIMN9aiRHKlYNXfW
         Lyi1jQnWQd0EqiY4RVWHEay0dFO+BjrB+e4FL4N1g7zyWHatLSeI/mBMaRbQg7cIzMdQ
         qAhlB4MoguXRNVdfj+eNmYLO+7wUbP+M4gKyM064pN08b7Isdfx5o8BQiVuNUKdBtTNr
         ySog==
X-Gm-Message-State: AO0yUKUfP5dpzD8Xy6fmZEiZmJ4Uowg1Cs/sZo1VMl03tP8C1wlz5YWY
        5aCZ8FnfXgFs+/ONBwR4foG2o5RYjQTanq0rX8MXXILJx7VjUnBNp1OMcKGqNu8cSiT+7LiLpQY
        6NYTvXUetkVyZEvQ8A/ib44LG
X-Received: by 2002:a05:6870:a686:b0:172:3d71:c248 with SMTP id i6-20020a056870a68600b001723d71c248mr667007oam.18.1679384588863;
        Tue, 21 Mar 2023 00:43:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set//h+rt/5rnzWZgDMDSljtrlf8yFkWx80HQCLbvaD/XbP8sCxWepJibqGOFz3BE31CrO/dz9g==
X-Received: by 2002:a05:6870:a686:b0:172:3d71:c248 with SMTP id i6-20020a056870a68600b001723d71c248mr667004oam.18.1679384588690;
        Tue, 21 Mar 2023 00:43:08 -0700 (PDT)
Received: from localhost.localdomain ([179.111.176.145])
        by smtp.gmail.com with ESMTPSA id az15-20020a05687c230f00b0016a37572d17sm4047729oac.2.2023.03.21.00.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:43:08 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v2 3/6] riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
Date:   Tue, 21 Mar 2023 04:42:46 -0300
Message-Id: <20230321074249.2221674-4-leobras@redhat.com>
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

