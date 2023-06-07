Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363F726024
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbjFGM7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjFGM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:58:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A7A6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:58:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30e53cacc10so974236f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686142736; x=1688734736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJowdc9e59oB9wLZyR+086niExyuveZY6dunY32SgSw=;
        b=qYGg+N98bKzlnOSPs1w2WU3nsb+GHqRRgSHImrjk+cI7oLcG2JrvcdZENBR/LrxErj
         CJ03F5EweLHhwLn/VZG9dRqx8pnZmwYX1hsu4ZJvoNMwfYu4bLI6becMzNzZouVxOPsF
         DtM13TFnXRSQounOafPHJyFNSkuRogJ0byeSMwsOFxWckEdkJz6wZf97nGyE1QCgbIo1
         gibaGN5I6O5VTp107lFVSW0BKXnSCwe3172yaicz42X+MT7xGq/mLjyIKZtO8cSZUlzh
         JIvtwJEHhjhIC4vmIofAz6h2MWGZsRSD1ZR+B6l5cSLt4DISIxxFLtuQuPdoBgkbL0ZP
         z+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142736; x=1688734736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJowdc9e59oB9wLZyR+086niExyuveZY6dunY32SgSw=;
        b=A/opAU6xeok0d6JQ5s036yrcWoLqwMnilWoBnx2FzFtFptmj7q/YLUZEcGFg43PiUt
         +IXPJyUy9d452+dfo9Ddho2M40QvZxbQ383JYu6xuILMwuXaVrTNS5gf7ZtqpL0AUuwL
         8m1gDPjS8TOizdZ1qARbyGzIMYJD9o+QiHACVXImwEu91dpv9hm9SJ7t8QDytcy6ejdB
         ueHxZtDSjWDsDw82n4SZRlPE9QWgJgxnJfZo2j3PdY7syam7SVDtJjOjHK5o/qZRi7mq
         Fe3xpzVddEueanz500ZIQZmPP+XJfWQA/OZ9iMmvCe2AqqSW7hRH03S9Nz9D/+lMBIIC
         huFg==
X-Gm-Message-State: AC+VfDxsP6FkaHxL5WBc8dM3RUYTH5amfepp3WBcAlRfoPnNTOEREwCQ
        we8QZ6kJsHgGmwfgGKf671aRvg==
X-Google-Smtp-Source: ACHHUZ4TWTfgOEoFeZVMqWAp8ZN/koVFrf7eHsf6VrJB/pLXD1S4I70XGWbwV2qVsNa3FRrfijmKDQ==
X-Received: by 2002:a5d:558d:0:b0:30a:e00e:8af7 with SMTP id i13-20020a5d558d000000b0030ae00e8af7mr4621946wrv.63.1686142736136;
        Wed, 07 Jun 2023 05:58:56 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f42d8dd7d1sm2164096wml.7.2023.06.07.05.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:58:55 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH -fixes] riscv: Check the virtual alignment before choosing a map size
Date:   Wed,  7 Jun 2023 14:58:51 +0200
Message-Id: <20230607125851.63370-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
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

We used to only check the alignment of the physical address to decide
which mapping would fit for a certain region of the linear mapping, but
it is not enough since the virtual address must also be aligned, so check
that too.

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Reported-by: Song Shuai <songshuaishuai@tinylab.org>
Link: https://lore.kernel.org/linux-riscv/tencent_7C3B580B47C1B17C16488EC1@qq.com/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d42ea31c7de0..5143eef4c074 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -660,18 +660,19 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 	create_pgd_next_mapping(nextp, va, pa, sz, prot);
 }
 
-static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
+static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
+				      phys_addr_t size)
 {
-	if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
+	if (!(pa & (PGDIR_SIZE - 1)) && !(va & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
 		return PGDIR_SIZE;
 
-	if (!(base & (P4D_SIZE - 1)) && size >= P4D_SIZE)
+	if (!(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
 		return P4D_SIZE;
 
-	if (!(base & (PUD_SIZE - 1)) && size >= PUD_SIZE)
+	if (!(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
 		return PUD_SIZE;
 
-	if (!(base & (PMD_SIZE - 1)) && size >= PMD_SIZE)
+	if (!(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
@@ -1177,7 +1178,7 @@ static void __init create_linear_mapping_range(phys_addr_t start,
 	for (pa = start; pa < end; pa += map_size) {
 		va = (uintptr_t)__va(pa);
 		map_size = fixed_map_size ? fixed_map_size :
-					    best_map_size(pa, end - pa);
+					    best_map_size(pa, va, end - pa);
 
 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
 				   pgprot_from_va(va));
-- 
2.39.2

