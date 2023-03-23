Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDDD6C6DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjCWQiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjCWQho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:37:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6763433B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:36:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j24so12388188wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679589360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFIdVMyY2JcOEfEYtk1Mrcm+ayayJpn4ssJH1y+Y8SY=;
        b=XRx/qjnE9uNVUhjrkckwtZNfRSeDtPWLGHujMYbX+pUc6W8XwJmyzK1Ozrgu3VrsCw
         ixX8yG4vVRdtvMmjSzsPFW6TAPtaQxa32kDhr/vEIxz/liX5Jnxy5ks5DMPn+9Tyqa0I
         dhuIn3YjYroXQczSAF05RgaY7Kx28T0tYXahdqAvORqBe/APPcYemeDL+w3XcSMRAei/
         FKvdHHP06rtfOitHpAAyJ0P4XX7VIzxGjRd4JUWIFZkTI6oVrvarr15s7codKgs0PYNT
         zS2CfmUgxC4epAxnNbYREJe7YzKCstK51eH0rVUpoZ7mNbioJ0ywr2VQq6ujrDbSqDWe
         XaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFIdVMyY2JcOEfEYtk1Mrcm+ayayJpn4ssJH1y+Y8SY=;
        b=S875F8rEglRIWSX5ALSdP+tEPtFU9WYJEfADA4KpzR+olgy1AH1aI5vHFY9Ot2BzJk
         jnaBITvQsH/jMQUCvRruzRY/X69SyXrt0KpzsP7QtyVw6eLOW0FV8KOhz6czMTfNkU36
         oXOcKDFvwpvJyL+8/co15mhNMbFXSg8bINXHlYvnktb507/DdbFgnm1aB/DdtEByeth7
         zX19At4Xslh6BbkzKm+GIzTu43jaLiauTwSQmIq1nWYDQ/sxshIQW+9WW1CBf80fkedL
         EGNaBMvPjbZn2Ivq1YF4Tnbdjk5/DMHdvtAQr2rXw9WCBNA3ER/SHnNMWwkawua9tsHM
         R4KQ==
X-Gm-Message-State: AAQBX9fMuORKrohep8yrtN50+Z3+HwnxlFsCe2oGq17nLY+9QCuYr0eV
        LHl+dnfBk18/WCyDU+H8ZvWD6A==
X-Google-Smtp-Source: AKy350bZB6XINZ/e2OvUeiAx/NAII4Q3/0majzUkK7Zk38kV4Ea31iChLco4fr0gnvIX/KOBcmR+sw==
X-Received: by 2002:adf:da50:0:b0:2cf:f312:86dd with SMTP id r16-20020adfda50000000b002cff31286ddmr2991280wrl.18.1679589359878;
        Thu, 23 Mar 2023 09:35:59 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v3-20020adfe4c3000000b002cf8220cc75sm8570661wrm.24.2023.03.23.09.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:35:59 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 2/2] riscv: Do not set initial_boot_params to the linear address of the dtb
Date:   Thu, 23 Mar 2023 17:33:47 +0100
Message-Id: <20230323163347.182895-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230323163347.182895-1-alexghiti@rivosinc.com>
References: <20230323163347.182895-1-alexghiti@rivosinc.com>
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

Now that the dtb early mapping was moved in the fixmap region, we can
keep using this address since it is present in swapper_pg_dir, so remove
the dtb relocation which was wrong anyway since early_memremap is
restricted to 256K whereas the maximum fdt size is 2MB.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/setup.c |  5 +----
 arch/riscv/mm/init.c      | 21 ++-------------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 542eed85ad2c..a059b73f4ddb 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -278,10 +278,7 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
-		unflatten_device_tree();
-	else
-		pr_err("No DTB found in kernel mappings\n");
+	unflatten_device_tree();
 #endif
 	misc_mem_init();
 
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

