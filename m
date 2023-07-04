Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA1746AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGDHoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGDHoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:44:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44814BB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:44:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so50713965e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688456640; x=1691048640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaN7FLuvwVnpnxsPOCNUh4V539jNJliF9+H8DZcJ4YM=;
        b=UW+p9aqobog562ULP3FjwFIYW3w4oDw/L8bG6v3uAVk7Cgjoh9ylTtxrzwp0ioAakV
         SSd2Lq69ada7NGqCwOziqGEuQ4msC0QC0h2Pp30r3LgXqI7pwM4PUvdmQvjH5A6Rha6f
         BihFqeSFAM2bpNbzqU9jtLX2jxaC+LBSiajG5EiQbKg3KWCIzhEZJBmBSBMCITwZFUHF
         nIFOW0h+8qoFJOm7OA/JkmvHCJKlWgKzrAcXicREr52rqEpQKiHB35ySdtOOPlawua7+
         ZYotALMumf7cWbBsp2Szn29OyUpN0xzrm5rHtZjStkTUvz6zv3gSbQpgIAsDWx0qSbTC
         tj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456640; x=1691048640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaN7FLuvwVnpnxsPOCNUh4V539jNJliF9+H8DZcJ4YM=;
        b=Ua6WCyafUOc9QLD+AHeqlMfXwDiie5lDmWh2nZ+fb/gX7w8VnZjOYXHF8aHB8M7l0K
         S7XzA+GKslI5lmKs5Qs61fgwKPPKZ8PJqSXA2DbS1qtwE6mlYY2kZIYbinjaBG6hlMXl
         7LzTx7VEOqgV6Eh3WaqZvItB3DOXrL++Es8AG1NnGWdCf1AHEmq4VJwjWDYg2TcONh1k
         fZhdjah9ZGF+JiUw4VbL0ZzFY0Kg0ArV4+BDxgoUuRL2z2UIHFkqobLvWzeNR/9Ti6o7
         oW2TDro/x5sgngWht20tDMWUhsJHihsQONtB7uUoe5uSY6Y1l9xSDupRzCpMatbYIwxG
         9F+w==
X-Gm-Message-State: AC+VfDz7YR48Jk9cy7pohjTncQReuhjb1ZujBWCiRYsKBYOVRLIku7Yq
        kfiG+SST1Y5FqycctmQ7XgBNvw==
X-Google-Smtp-Source: ACHHUZ6M+qhM9G8h9/aI0f5Bll9cIwjv/ArSQTrd/5+etwzEx2vSgFdmUVw+eICVPHbFMf4oxTQAHw==
X-Received: by 2002:a7b:cc82:0:b0:3fb:b008:2002 with SMTP id p2-20020a7bcc82000000b003fbb0082002mr10415933wma.0.1688456640324;
        Tue, 04 Jul 2023 00:44:00 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([93.23.105.195])
        by smtp.gmail.com with ESMTPSA id y5-20020a05600c364500b003fbc9d178a8sm10790933wmq.4.2023.07.04.00.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:43:59 -0700 (PDT)
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
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] riscv: Mark KASAN tmp* page tables variables as static
Date:   Tue,  4 Jul 2023 09:43:56 +0200
Message-Id: <20230704074357.233982-1-alexghiti@rivosinc.com>
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

tmp_pg_dir, tmp_p4d and tmp_pud are only used in kasan_init.c so they
should be declared as static.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306282202.bODptiGE-lkp@intel.com/
Fixes: 96f9d4daf745 ("riscv: Rework kasan population functions")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/kasan_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 8fc0efcf905c..b88914741f3d 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -23,9 +23,9 @@
  */
 
 extern pgd_t early_pg_dir[PTRS_PER_PGD];
-pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
-pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
+static pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+static p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
+static pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
 
 static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
 {
-- 
2.39.2

