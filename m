Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E128D709801
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjESNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjESNNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:13:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689309D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:13:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso31426865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684501994; x=1687093994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VubzrgCD2ViwjmO3PZokr9/4IFGa31fvJ3BrWREI83s=;
        b=esXtjrha/93GEYue04kr1iYA2b8go6OK835+hPZVPvEThh/VfdYosW1AKs6s7hktoz
         zPIWkQzeaZDU4xwV3VdId7N9gVpqccbTO7zC/RErqlEwPuKSoMvodIaRLgajJAToThvl
         mpeHBk17ZiOWelgQekvt6juGQE/6lzDTaqrkzeECodBD6GZ8GnzxJn27gUKVKoeubU4V
         mNgCSKA/qbNtO+hDlKnCffMbtEKSGTiUPbfp6PY26ZMGIX8ddHFAg7qLb0SRsJgiCgRS
         ILjuxOOl9WrTrI9+GlwbbbjbCfVcSZqLwZqunDKzO2dy15wm+o3nNe71h2zC3yHQDvi9
         pH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501994; x=1687093994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VubzrgCD2ViwjmO3PZokr9/4IFGa31fvJ3BrWREI83s=;
        b=eDD4YE1XJMpwuloLwM04LgJYQ80PuDbTa9W2BJbVALwwrqAEaY2yW58uVHwj3z5+ND
         msN4puUz+A17tRbTlLpNkJPClJt6pJkHrZvs01R3Qb/Na/+KuLwQzK/FA5HkjDGIyxxJ
         O8IpuMCc2KmqtCItue9Pe+ZGTjTgDPwhPQZgKTQyww20H6M6QpULEKPdkOoSZbXJ2k/0
         1fhiM63R14nysordoz3MnOVO0FT74Bprz37xLBkVdRLA5yP5EMlyrYKPUbpE/J8tniUF
         TwlusYIpZQgQ8GMFWfeysKOPMWmvtMUgtOLmFbSvzz4C9qORx212x5uy7WgQpc8ehPn5
         FUvA==
X-Gm-Message-State: AC+VfDxG8Tce1dMfvXa5pnWC1lMfbOzCzUFahfuhQ2AKG+4M7akjj95+
        XcvpLR2H6l9DhN8Vbkt3aKgKYw==
X-Google-Smtp-Source: ACHHUZ7z6OJX0gt0aF1BvTHyoKCTYb8Fn0XrT2W5Wunx95APLO34d8Hw86p9y/xxKYpasC/ohNUFdA==
X-Received: by 2002:a1c:ed0c:0:b0:3f4:2506:3d58 with SMTP id l12-20020a1ced0c000000b003f425063d58mr1278568wmh.23.1684501993851;
        Fri, 19 May 2023 06:13:13 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n3-20020adff083000000b00304b5b2f5ffsm5282580wro.53.2023.05.19.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 06:13:13 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: Fix unused variable warning when BUILTIN_DTB is set
Date:   Fri, 19 May 2023 15:13:11 +0200
Message-Id: <20230519131311.391960-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap
region") wrongly moved the #ifndef CONFIG_BUILTIN_DTB surrounding the pa
variable definition in create_fdt_early_page_table(), so move it back to
its right place to quiet the following warning:

../arch/riscv/mm/init.c: In function ‘create_fdt_early_page_table’:
../arch/riscv/mm/init.c:925:12: warning: unused variable ‘pa’ [-Wunused-variable]
  925 |  uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);

Fixes: ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap region")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 747e5b1ef02d..c6bb966e4123 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -922,9 +922,9 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
 static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 					       uintptr_t dtb_pa)
 {
+#ifndef CONFIG_BUILTIN_DTB
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
 
-#ifndef CONFIG_BUILTIN_DTB
 	/* Make sure the fdt fixmap address is always aligned on PMD size */
 	BUILD_BUG_ON(FIX_FDT % (PMD_SIZE / PAGE_SIZE));
 
-- 
2.37.2

