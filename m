Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB56C81F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjCXP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCXP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:56:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A510A87
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:56:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h17so2290407wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679673391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR0MUUfacwAfsjInBPeABoZtOXtMYsQVXBaBrC8rWtM=;
        b=R3kCrQe6UqEb7GoCrQ19E+2HaE0y0+lHYsucNBd+vyoWzCdTuw80+N+fDn3B4o+dGG
         c3qMMwW7jNWTEIdDu0/u2KtnYi8Z4faTZC28TPwx77lPhfWdPjP83tGua6o+w7itsWnj
         mC3HDqQJuuf8k7AgnKbGbTX8y5ZXhA9Uh6RAgNkZxDP5De3aTBcrTXt7lCao9xGz/62i
         yRsIEErfZ8vqKRQmmBfipn3Wt25HXQtH2CQiOzoIT8RAc6LVYIvxgM6UkQ6h+FLqnKVY
         FeppzjVOse3GnyvmI1Qms9N0XKZuOPfDfWF4JwwjWlS/x8DIws6pR1+HOABy/Yzj8yLu
         jggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679673391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR0MUUfacwAfsjInBPeABoZtOXtMYsQVXBaBrC8rWtM=;
        b=eeZDf6AYM7OaNgdmAj8C2xc/IiDBMnmLAuiE917jvJFSu5UsQd5LooxYWX7W8B9MII
         qnX1KTm0npSDWt3atCcFQoPBeoqQgOx/f1HtCQZeDhobCtXj8sJaFEgSG8PWFC/+6Xd1
         4QEtEMV+BpJf29aByEBufWd52edxmsusq51NbTaawVU8+AyprIgFWy/e75TtDE8nP7Yn
         THnKr/Ac48s8ExQa00eVZJheYjl5uaZBdB9AYkI6Y5aVo38DOwYLbE3hwzwSTMk32TyG
         GPavuupWql/QoWPCa0srcDxpwkIvYIIVAcN50avvGxBoH/HgC8mjuPXOX67LKbvtEBDi
         y/+w==
X-Gm-Message-State: AAQBX9fDjXu1EWWTcs5oJ50SyUyF87dNeTWyisnVdGvGPn70qFqU3x7M
        mV81+ow8Aq2A0tTc2mKjzuQdGg==
X-Google-Smtp-Source: AKy350ZbYATQfNEPjI55Pl0fHAqYJaEDna5Eve19pmNEhT+ETLFt3/hTIE34PKB7xqhm0hzFTkzAsw==
X-Received: by 2002:adf:fe41:0:b0:2cf:e517:c138 with SMTP id m1-20020adffe41000000b002cfe517c138mr2687659wrs.66.1679673391487;
        Fri, 24 Mar 2023 08:56:31 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b002d5a8d8442asm14382912wrs.37.2023.03.24.08.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:56:31 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v9 2/3] riscv: Move the linear mapping creation in its own function
Date:   Fri, 24 Mar 2023 16:54:20 +0100
Message-Id: <20230324155421.271544-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230324155421.271544-1-alexghiti@rivosinc.com>
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
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

No change intended, it just splits the linear mapping creation from
setup_vm_final: this prepares for upcoming additions to the linear
mapping creation.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index cc558d94559a..3b37d8606920 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1086,16 +1086,25 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pt_ops_set_fixmap();
 }
 
-static void __init setup_vm_final(void)
+static void __init create_linear_mapping_range(phys_addr_t start,
+					       phys_addr_t end)
 {
+	phys_addr_t pa;
 	uintptr_t va, map_size;
-	phys_addr_t pa, start, end;
-	u64 i;
 
-	/* Setup swapper PGD for fixmap */
-	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
-			   __pa_symbol(fixmap_pgd_next),
-			   PGDIR_SIZE, PAGE_TABLE);
+	for (pa = start; pa < end; pa += map_size) {
+		va = (uintptr_t)__va(pa);
+		map_size = best_map_size(pa, end - pa);
+
+		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
+				   pgprot_from_va(va));
+	}
+}
+
+static void __init create_linear_mapping_page_table(void)
+{
+	phys_addr_t start, end;
+	u64 i;
 
 	/* Map all memory banks in the linear mapping */
 	for_each_mem_range(i, &start, &end) {
@@ -1107,14 +1116,19 @@ static void __init setup_vm_final(void)
 		if (end >= __pa(PAGE_OFFSET) + memory_limit)
 			end = __pa(PAGE_OFFSET) + memory_limit;
 
-		for (pa = start; pa < end; pa += map_size) {
-			va = (uintptr_t)__va(pa);
-			map_size = best_map_size(pa, end - pa);
-
-			create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
-					   pgprot_from_va(va));
-		}
+		create_linear_mapping_range(start, end);
 	}
+}
+
+static void __init setup_vm_final(void)
+{
+	/* Setup swapper PGD for fixmap */
+	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
+			   __pa_symbol(fixmap_pgd_next),
+			   PGDIR_SIZE, PAGE_TABLE);
+
+	/* Map the linear mapping */
+	create_linear_mapping_page_table();
 
 	/* Map the kernel */
 	if (IS_ENABLED(CONFIG_64BIT))
-- 
2.37.2

