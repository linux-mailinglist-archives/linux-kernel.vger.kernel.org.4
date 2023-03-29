Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8527C6CD487
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjC2IYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjC2IXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:23:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D9055B8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:22:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y14so14768304wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680078157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkd1yySkMZCjQpFk/I00/AFBZMzwvjb6fzx+RcYU4u8=;
        b=h5xChJSmqqdKg1QSgQom43LhcMDU0XiEsWSGiNAEWStm39CVorzpPFv0ONnnnIzsF9
         Ty9fCdH2xUz2wOZR3NKor67Qdex16pDFGgwBHihecdqsxLGSk+HTgbwfoT7RYQekKSxu
         SbmuwSNFsjGFqHbtDD6ksJRWX27fdpcnLkWqD3UW1R5E7gBu7qHO15F//p+2aDSW2ZPJ
         3XfGMZn7kWWzAn00jE4Xlv2bopw4A0wydAb2rWVMI7SGd4F+bM+QTGAHlxcNNsqJ80D2
         U2GBrATYMSRGj1vmfr96jLrF4tREftjHjgSGNdVyO36HJXh94p23JlkJWCxZ3yplJUqT
         117Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkd1yySkMZCjQpFk/I00/AFBZMzwvjb6fzx+RcYU4u8=;
        b=qzgZNMIVuQbypnhzuYSnK/lZE9tXs2bOQWo1BPkeov4va8von3B0tpVjiSaEr6O4Q0
         N4SVAeFdGMf140WiLuk3NQw5mEkvYtq/ps6gMqtYnq5jxis2fhM/4Gqw5THP/SMsa7lF
         cEVrhPC/hnfVS91/V83/Wv6W2ebbRbMMMQAHGPODfrnu5paZDyfyF7IJ7mEzUWUYrVK/
         yqYjYTBvBdgln6z7nJ25bVN7OnIhJRqs4/rxE4A2SZrOqWpv/vvJfBei/oaWQnsgfzNx
         lMaknWeRfByEje0+yFG6jd2PYI+oQxcPmqGVv73/asD+dq5lzzgVZNyETBfyRPx2146T
         3/qg==
X-Gm-Message-State: AAQBX9ci2uQrOSaaC6vNwUauRb8pUza5Sbl+Rr9X7ghwhuSV9cXpSrl+
        oN6RRFm0NTnBJ2q091NvAPawtGexGGc4O8cetkc=
X-Google-Smtp-Source: AKy350ZkffXk96u2+42Qo7i7ZWXLM9FtJwE6V4RF+IY/ajIq1EyS7UxT/cCOOkgZrg6bEngki+QLiQ==
X-Received: by 2002:adf:f8c2:0:b0:2c3:e7d8:245c with SMTP id f2-20020adff8c2000000b002c3e7d8245cmr13699207wrq.13.1680078157521;
        Wed, 29 Mar 2023 01:22:37 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6082000000b002c6d0462163sm29468263wrt.100.2023.03.29.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:22:37 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes v2 3/3] riscv: No need to relocate the dtb as it lies in the fixmap region
Date:   Wed, 29 Mar 2023 10:19:32 +0200
Message-Id: <20230329081932.79831-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329081932.79831-1-alexghiti@rivosinc.com>
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to access the dtb via its linear mapping address but now that the
dtb early mapping was moved in the fixmap region, we can keep using this
address since it is present in swapper_pg_dir, and remove the dtb
relocation.

Note that the relocation was wrong anyway since early_memremap() is
restricted to 256K whereas the maximum fdt size is 2MB.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb78d6bbabae..0f14f4a8d179 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -249,25 +249,8 @@ static void __init setup_bootmem(void)
 	 * early_init_fdt_reserve_self() since __pa() does
 	 * not work for DTB pointers that are fixmap addresses
 	 */
-	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
-		/*
-		 * In case the DTB is not located in a memory region we won't
-		 * be able to locate it later on via the linear mapping and
-		 * get a segfault when accessing it via __va(dtb_early_pa).
-		 * To avoid this situation copy DTB to a memory region.
-		 * Note that memblock_phys_alloc will also reserve DTB region.
-		 */
-		if (!memblock_is_memory(dtb_early_pa)) {
-			size_t fdt_size = fdt_totalsize(dtb_early_va);
-			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
-			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
-
-			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
-			early_memunmap(new_dtb_early_va, fdt_size);
-			_dtb_early_pa = new_dtb_early_pa;
-		} else
-			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
-	}
+	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
+		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
 
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
-- 
2.37.2

