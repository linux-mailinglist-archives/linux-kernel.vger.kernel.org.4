Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F806C2A85
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCUGgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCUGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7D3B86C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679380532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpwvsmW/EIvjt3XpmgOB2tOjIn+1scWXRJYbQwzYCy4=;
        b=CdbjvdUUaRqT/cE+KdS0dLsTiANDvV9wp5hMDx/P9QP2SJ4oCzZKqDAszLhG3krUwpYXBz
        8t2Y+5NDrnI/jOK5bcoyrKqF8Y01pgNWcc5tSgx9bBUVLOdtoSccvWdtT0IHPIIkgAiL69
        HRVoQtVbZoGoRJrLWp5vzisLIwZoMaQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-vKSrda-aNHy5mU7quyEJbw-1; Tue, 21 Mar 2023 02:35:30 -0400
X-MC-Unique: vKSrda-aNHy5mU7quyEJbw-1
Received: by mail-oo1-f69.google.com with SMTP id bp27-20020a056820199b00b0052513faabe1so4251039oob.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpwvsmW/EIvjt3XpmgOB2tOjIn+1scWXRJYbQwzYCy4=;
        b=lTv+DVqEsXzsWvDYvraDHDtTgdMdXFEuew18QgtpBzFpo1SEllq9StW/UO+cfYzcNR
         cPxaZ9OW4pjbVKRQVM0Oq7SCwcYXwgUEOy3dTtDXY/XEDiGhmxP6ff9lQfVKmqOL02k3
         vpJKkRGoOxD600eFcd/yeBL6U9zxvsRNNVf7khokfJuTWgguzXRiu+Y0wKRXKIeCOhnS
         9wDOQm++V/39vhwDYX5ZwQrxjFiqLeluxwbRRdjyClmqDmSyqg31siK7eCzZFybggfEB
         Qa1dr674uK7m7g64kAvIj+EResuwY2Lgjz/0tkiSJ/AtsjYAajxDrXkvBFaFMv7ug2QL
         GJnQ==
X-Gm-Message-State: AO0yUKXR4XDH7JMaRr/ZkJLkXZPqghKtS152zazsJGfk/unrlXeLMtmQ
        X0dmEzeZcoONdK/XVOGj1lnNyo661P3KGGtC9A6MRD5vP0eOhSjSfUnVb6oFRj+L1EAMk6MWRCk
        KFp5TbjNXZTZEkjflkblYa+nw
X-Received: by 2002:a4a:584f:0:b0:53b:4d59:405a with SMTP id f76-20020a4a584f000000b0053b4d59405amr457322oob.3.1679380530165;
        Mon, 20 Mar 2023 23:35:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set+EYpjdBiffGwngyRKhEMmlht1lLjtybmnM/t+R/I3MOqYmd03nCIqYG7O6LG1cmD69gyKGYg==
X-Received: by 2002:a4a:584f:0:b0:53b:4d59:405a with SMTP id f76-20020a4a584f000000b0053b4d59405amr457315oob.3.1679380529942;
        Mon, 20 Mar 2023 23:35:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id y75-20020a4a454e000000b005293e9a12f5sm4545147ooa.45.2023.03.20.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:35:29 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 6/6] riscv/cmpxchg: Deduplicate arch_xchg() macros
Date:   Tue, 21 Mar 2023 03:34:32 -0300
Message-Id: <20230321063430.2218795-7-leobras@redhat.com>
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
index 23da4d8e6f0c8..d13da2286c82a 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -43,41 +43,33 @@
 #define __xchg_relaxed(ptr, new, size)					\
 	___xchg(ptr, new, size, "", "", "")
 
-#define arch_xchg_relaxed(ptr, x)					\
+#define _arch_xchg(order, ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
+	(__typeof__(*(ptr))) __xchg ## order((ptr),			\
+						_x_, sizeof(*(ptr)));	\
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

