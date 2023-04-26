Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390A26EF197
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjDZKBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbjDZKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:00:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D43599
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:00:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso5693288b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682503250; x=1685095250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OK3qaiVcydKF9XZu8gI/RVWN/3p/t3jhTnRjwV7K8CU=;
        b=OHfLmQ6TetIifmiTVR9LyyauRXAcQNU3ERRrcAXiXo5JSu8k8e90/F4LPPPxvhJ5Bq
         qNc1BsfC7SsE7nke5Fb3nrfLJaBSzgAU/H/ABTcbkHZ9NFDeBwaKH53PjgoEeHy8Jsx2
         Ci9Ik49fYzQ+zyEouDCMivUg0zEswhp3zYDlVUJgVjqjpYyWYJFvzDcs3mkzoF9dVWZI
         IaCp5zjQmirto4Fk/SULtA7lKvU8rtRf5YTXaFg2J+z8gC8e3pRM94hxSkeVLH8yCu1X
         9Z3NLJ6A0hU7QyPGbChnho1BtfAlgg1nrRK4IWYQGPgQpry1AoWtfsT5/9NYkdXS8Kaf
         M1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682503250; x=1685095250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK3qaiVcydKF9XZu8gI/RVWN/3p/t3jhTnRjwV7K8CU=;
        b=LIl9TOE9Y9e2OC42itcnFS8VlEaRsXZDYmORkqQfxc3uvVFhQ0HqCDSeCjTNjb/SAl
         VeubumxfLX7WfAULGS200z4+fW19DkkJmBrEzAoh92MLi/hW/mn3i86m3aIXKQnbJoRl
         mxOJiRI/MGb9e3QMzpahBe5lE1GxfvJ5Js5N68Z3UPjPrKkWE7oMQh8xNH+oJO339TqV
         MfT2yA3rXSmk9xhF4aB+F0xugbeZD2Cn87ykjXzNc1rchk4aVAQu1WbR7ame6h+sm+Z6
         w2FRf7F7ihY4G6yoDEDkMOVjTU9k+2f0Y55TOm3n6ViuH/HlcZCW3XLTZKPgcQY/gSyA
         OhgA==
X-Gm-Message-State: AAQBX9dcQr5CVCnl0A3LjjjHDGm/JKgouudOLQE7u8Nt8/ztEVmudoiz
        J5mm8WXliFAbBFHy1K0EXAdK82XthFU=
X-Google-Smtp-Source: AKy350ahc/rCzAYODAXkAQXwOIl8SBjdAMeWouAOBakREDSTC5hR8ZV2katEqTzZ0BMa/9RHBRaP/w==
X-Received: by 2002:a05:6a21:788e:b0:f0:5a5b:7bea with SMTP id bf14-20020a056a21788e00b000f05a5b7beamr26480987pzc.61.1682503250334;
        Wed, 26 Apr 2023 03:00:50 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id u29-20020a056a00099d00b0063d2bb0d107sm10940811pfg.64.2023.04.26.03.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:00:48 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexghiti@rivosinc.com, heiko@sntech.de,
        conor.dooley@microchip.com, guoren@kernel.org,
        anshuman.khandual@arm.com, mick@ics.forth.gr, samuel@sholland.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH -fixes V2] riscv: mm: remove redundant parameter of create_fdt_early_page_table
Date:   Wed, 26 Apr 2023 18:00:09 +0800
Message-Id: <20230426100009.685435-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_fdt_early_page_table() explicitly uses early_pg_dir for
32-bit fdt mapping and the pgdir parameter is redundant here.
So remove it and its caller.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
Changes in V1:
https://lore.kernel.org/linux-riscv/83540cb1-0c9b-f572-849a-cb100437d049@ghiti.fr/T/#t
- fix the typo
---
 arch/riscv/mm/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0f14f4a8d179..6ebb75a9a6b9 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -843,8 +843,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
  * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
  * entry.
  */
-static void __init create_fdt_early_page_table(pgd_t *pgdir,
-					       uintptr_t fix_fdt_va,
+static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 					       uintptr_t dtb_pa)
 {
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
@@ -1034,8 +1033,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_kernel_page_table(early_pg_dir, true);
 
 	/* Setup early mapping for FDT early scan */
-	create_fdt_early_page_table(early_pg_dir,
-				    __fix_to_virt(FIX_FDT), dtb_pa);
+	create_fdt_early_page_table(__fix_to_virt(FIX_FDT), dtb_pa);
 
 	/*
 	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
-- 
2.20.1

