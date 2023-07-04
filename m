Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD6C746AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGDHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGDHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:45:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A703E170D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:45:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so8283731e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688456702; x=1691048702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=da1Ya2LZv3Pi8isMeSjt68UFYCIa9e30GSmEnk1v2WU=;
        b=YBFkVrQUVuVXwwqDBTbaJzy2/t3gm5gTRh4YaK09x3g6uBEJPRDKE8NS/9McR10pkx
         P5AOrhmEQMhod+anbEHbGZuuS+GpFejHfrmbGZ41RL1pU+LGRMXu7nUNqFqNWewQd4sO
         kf6i9i039rdr8OPy05gX4wq3SCdopIoOXFYGZAUtqBPRk1EBV1J+MLJeFuncm1jilmjc
         utZRmxMCCJlnOUm5KNtQYNVWgPztKtInGKQo8hp1wH/eg97MVKRBmFL4q3dXk7UgVviq
         v4RixJpiBg7Jw1cubz5N39ErtAt7ZxQltLf0KWtnzrTXgo4PhZw9d8kS17eXR4rb7a7Y
         tiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456702; x=1691048702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=da1Ya2LZv3Pi8isMeSjt68UFYCIa9e30GSmEnk1v2WU=;
        b=ckMxJfmGq0CU4RImDRyUBKowm0BxdjeEEXnHuGKKzyGOqZu1Sk05XN7L4Y03fG0JxL
         RXnDK/nRp3O8C15U7yFCoLyEvDROyOudghjQxcpCPSzA9lrXU3PH5MasQ8AzNTNkAABK
         aZz1R6W1y02huJGuPmvQXMySwjd4qmBHYZoLlUCfWu5G3wNSlWEJSWs3Bc3tH2InXmk4
         wqXglZJqt3z3xd1lQctFjGkFZBNfj32tv4f2N99p8mtGJz7jD0SCrnbri8TD55KmZnq7
         Fo2Pzq9Lr8BGLRsQ770kqmRFXtQmrYAvjmRqJ7fOeRdebSGtqJFcciSlCytOqGozB+yZ
         RQIg==
X-Gm-Message-State: ABy/qLb2Kn2GwkshVsXUPmjz6SmwfEJay6yj4u5tRllgPNDBGZ300xVc
        G8x0x5UqWlLVJGifhbj0/cuLLg==
X-Google-Smtp-Source: APBJJlHvbp/jKnp3/lAXPD2+TrpDqD1OgqQPu97Sba0NY8V3T2Xj8Pr94eByk1JhAXXIELZd33oU1w==
X-Received: by 2002:ac2:4f0e:0:b0:4fb:8bea:f5f6 with SMTP id k14-20020ac24f0e000000b004fb8beaf5f6mr9893002lfr.34.1688456702503;
        Tue, 04 Jul 2023 00:45:02 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([93.23.105.195])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b003fbb06af219sm17455668wmm.32.2023.07.04.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:45:02 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: Move create_tmp_mapping() to init sections
Date:   Tue,  4 Jul 2023 09:43:57 +0200
Message-Id: <20230704074357.233982-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704074357.233982-1-alexghiti@rivosinc.com>
References: <20230704074357.233982-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is only used at boot time so mark it as __init.

Fixes: 96f9d4daf745 ("riscv: Rework kasan population functions")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index b88914741f3d..435e94a5b1bb 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -439,7 +439,7 @@ static void __init kasan_shallow_populate(void *start, void *end)
 	kasan_shallow_populate_pgd(vaddr, vend);
 }
 
-static void create_tmp_mapping(void)
+static void __init create_tmp_mapping(void)
 {
 	void *ptr;
 	p4d_t *base_p4d;
-- 
2.39.2

