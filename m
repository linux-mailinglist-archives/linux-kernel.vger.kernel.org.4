Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29346EF0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbjDZJRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbjDZJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:17:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54A30EF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:16:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63d4595d60fso41710146b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682500518; x=1685092518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1nNIQi3pWLHzY3mOaTfbR0SSgvzLFHi14IClojKi4Y=;
        b=baXS/3xEL/zgxbl/pFfiKiRTf/R+xesvjrekb2conjC3lDEz3pBuUOC7GF7W181/xh
         7uQeWmy1gTmVTO1BvNEMCc/7rk68t+K3N8346/FsQEU6rtDJdqXmeB4/mzMYibX+ff7s
         7kK1epjlx5CgpW+91Fi9AZ2T8Z7grAhAKLdgFZzKV84qfCR98FVyjwUyN8htuVQ8QE0F
         e68nc2EEE1ut7/A5hbJwuI9LrBXGyd8LYZVk6l9h14gq+XN2ev7OVMzFJ9IBNAycttWL
         bBP7aY1YPxCe6TENfU1/EPX2uRpjps/CZE/dD/dbxfjCaecQwSJM/myKzlIbpix6vRd/
         nK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682500518; x=1685092518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1nNIQi3pWLHzY3mOaTfbR0SSgvzLFHi14IClojKi4Y=;
        b=Zv5Y0xTOoLBNVJl1LqMGGiwGrJUsDJ1kHUQE3/rQBUMS5U9Xq1u9X5uXII46YwMnEI
         f1sLfrup0uuSaaTl9Ce2/421VS+ay7lF8pxD/0V0o2bVZTNk8c72YXgTA/IvMciap+6T
         N7iNvKBzOYoZjKHx4xTdlCexd7mBZvFmKUkCaEyNXRvZNveAVe7+YY/T8IaDeGHLay1k
         Ub2PXf/4FJWy7NeSdyEtRclkBh/6fHy/qMQW4++8RpI9LCQPBkEJDeKXZfhBJF3jU5bD
         cs7xhVy5HYSsN/AVGWOYTGXI+G0MNo6lyzaZFAEczCCpJIBlO7+On/L/W+B9Jy06wUil
         To5A==
X-Gm-Message-State: AC+VfDxymEv8JHb5mXSRYTfn+bM5ywUj83bUW6BfLgmCXtsFzFIuJbRU
        SakT38eRnUK9qHykyJ5pdj35rxR/K1Q=
X-Google-Smtp-Source: ACHHUZ6/v7mRGS8g2x9/P7M9ukN+9J0uNGapXrhW4xVZ3urfzV1+NKjuQWYRVCYIFid8HSxDiIXs+g==
X-Received: by 2002:a05:6a00:139a:b0:5a8:9858:750a with SMTP id t26-20020a056a00139a00b005a89858750amr2327838pfg.13.1682500517625;
        Wed, 26 Apr 2023 02:15:17 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id g9-20020a056a001a0900b0063b642c5230sm11075684pfv.177.2023.04.26.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:15:17 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexghiti@rivosinc.com, heiko@sntech.de,
        conor.dooley@microchip.com, guoren@kernel.org,
        anshuman.khandual@arm.com, mick@ics.forth.gr, samuel@sholland.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH -fixes] riscv: mm: remove redundant parameter of create_fdt_early_page_table
Date:   Wed, 26 Apr 2023 17:15:11 +0800
Message-Id: <20230426091511.674496-1-suagrfillet@gmail.com>
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
32-bit ftb mapping and the pgdir parameter is redundant here.
So remove it and its caller.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
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

