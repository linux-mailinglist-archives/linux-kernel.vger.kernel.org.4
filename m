Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643186778CB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjAWKNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjAWKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:13:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74AFEB77
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:12:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so8128121wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzLCWkEIOjhYvr7p7s7uKUj96vyQiWAZD9+xORl+Fd4=;
        b=HXc8RqVoAlQiZ3SA2JFj/Ss1Z4kvlhRCjc8xe2vvhQs7MG+eiCGYHpoDvfBnNdp6Dv
         Y+fbxkiIx0qH1+5beUgDgVbZyHqwPhWfOkZqdoa4CcpkVYSA0pZvsCX2zfNOiyF0W3cv
         4mMCvCoCb2pEnyD09346WX82nautOUHabcg/bg44jXDHHJktQS+ON0lo+MK/rA0Fiw1I
         AGldKNHzkoVZEX4z40MQ6jBTw8p2d4QBPzbcxGy6ZIOlBimIexgg9m3K+mX/N1rKyLMR
         NiGOQW6gZ9Wkk7a8E4iI6icfKgXRhrCfDsYYxtffTahQDSRzS2nEths/z8JtQIf3Yryb
         jVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzLCWkEIOjhYvr7p7s7uKUj96vyQiWAZD9+xORl+Fd4=;
        b=Ss6nRTLiyB3BXjFurwD1jTucYNeC3a6TmJ8j1DtB0mmIE0T0TNLioY93bYAbjn6RF5
         w+ftGNUH+jTP9eFKsO0274tlT1MbAIbfKXk/ixaRfK/4+8vyWb6fPK15Ux40E+BdMSpD
         DdP46S+QDjF9/uOsofWBHzDB+5Xnp3sAieVrkASNI0XV2r2x6xCHACE/ZLgdCU+YEOI5
         nEueDlkRK4Q0H30IGq3WGwIXOBiPwWIb/5L6tl1VaGs8qPduznGr08iHDn548b0YmvaC
         a5XRBHJJAQkl9lV+4ljZOTkxwXgcASSqQSGtHQjTfJW7liUeu5dX/PQrxGbWXwiVQsPo
         sHvw==
X-Gm-Message-State: AFqh2krdjwhBqjZoWRHk73jM3/ihBp0UoHeyRH6nCdpoeB7IVAeDoW25
        fbcZI/G7xcfZVOaoBjhpxJIyUg==
X-Google-Smtp-Source: AMrXdXv+bjpVA33KRbsI7GGQQ6TP8aToqcfzuFxT6KcEnBDPOEnT0+96sEUxMPkf/KM0d7bIPhR22Q==
X-Received: by 2002:a05:600c:1c83:b0:3db:27b3:a654 with SMTP id k3-20020a05600c1c8300b003db27b3a654mr14875103wms.26.1674468776649;
        Mon, 23 Jan 2023 02:12:56 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id d19-20020a05600c34d300b003a6125562e1sm10375823wmq.46.2023.01.23.02.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:12:56 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
Date:   Mon, 23 Jan 2023 11:09:48 +0100
Message-Id: <20230123100951.810807-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230123100951.810807-1-alexghiti@rivosinc.com>
References: <20230123100951.810807-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early virtual address should lie in the kernel address space for
inline kasan instrumentation to succeed, otherwise kasan tries to
dereference an address that does not exist in the address space (since
kasan only maps *kernel* address space, not the userspace).

Simply use the very first address of the kernel address space for the
early fdt mapping.

It allowed an Ubuntu kernel to boot successfully with inline
instrumentation.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 478d6763a01a..87f6a5d475a6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -57,7 +57,7 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
-#define DTB_EARLY_BASE_VA      PGDIR_SIZE
+#define DTB_EARLY_BASE_VA      (ADDRESS_SPACE_END - (PTRS_PER_PGD / 2 * PGDIR_SIZE) + 1)
 void *_dtb_early_va __initdata;
 uintptr_t _dtb_early_pa __initdata;
 
-- 
2.37.2

