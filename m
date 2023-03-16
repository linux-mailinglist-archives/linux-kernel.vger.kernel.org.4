Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB71E6BD0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCPNUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCPNUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:20:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643DCA1D4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:20:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l12so1507308wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678972822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNtcjIvt7Jcu6BbJu0k6G/sx5AHflabOU3bxX5prrUE=;
        b=L6eAT+smuQGoJO4DezL+IdwC0T7yTp/6MdgBgpSYGnzsE3GMtH0OsHZCA5KvkK/jsL
         SCQbzTNJRG+h5gG55AwIc3rp3qvPJ5HvHBpBdMMvum+UhNDX3K0d4mevTt2us+FFR9fP
         /SkYJ3PFgwjlEeZJ4QPID/NaQDyD2lSqhEWFJsMLe0iYwjDfErv7L30D/hLJYYVSFfx7
         jrT7h87/rKRPpMs9Aij8oJj9DBxmwR0E5LN3DULWfc0aFVYbJwTggaKYwjOlxm9f5rbi
         T0csEj0sYOg1wDUvvVEpshdAj9QA/fAZ/IJurP8+1WuNoMR3+2zSN2/cqzpGfR2FuvNh
         EyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNtcjIvt7Jcu6BbJu0k6G/sx5AHflabOU3bxX5prrUE=;
        b=tmKeKYigbgURGNsubAQfWnuDTKd4UzjL33wdM7m7E44syBN9TAmdqgziwmd8ZSrITD
         MJX3Oi02KKTEhQ0eXxhwcrgEkoWhvzxu0Z2GYV4SVX9lWgSaqKqAP7L1zRqqiiF+AY+u
         piX75WAth8pENzWD34HdvzzgQxNm57DdJMnOW6OgO8ToFRdKmiJHSAoFE2xud2gb7wFu
         p7nwuHyqE0tJ/WQ76ipPPNwNV8Ejx270M2O5aeOCM0mDijtJWfZO0Z1+TKcafaQZ6sHy
         ceOUPbegqEjvYNL6qysqF8ctWredN2Lpq1YAPdN9mFTR3TniNYMkOtrQeXXS/Orvze3w
         Lf/w==
X-Gm-Message-State: AO0yUKW5DduOGII0baV9ZKAiZjQAUj/lZm6/DHSdUOwOP3vQpeTGPwuf
        +5gYIXKzFWbRkTLShQb99c0hwg==
X-Google-Smtp-Source: AK7set98CBvIraFbTCbJWdo8CgRP1gvKzH5/GyoF0yuADO0rA+pPToO5CbtwnI+LruqnMYg8TXy3Ww==
X-Received: by 2002:adf:ce11:0:b0:2cf:e3d0:2a43 with SMTP id p17-20020adfce11000000b002cfe3d02a43mr4536359wrn.4.1678972821966;
        Thu, 16 Mar 2023 06:20:21 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (238.174.185.81.rev.sfr.net. [81.185.174.238])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d6544000000b002c56013c07fsm7218162wrv.109.2023.03.16.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:20:21 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v8 3/4] arm64: Make use of memblock_isolate_memory for the linear mapping
Date:   Thu, 16 Mar 2023 14:17:10 +0100
Message-Id: <20230316131711.1284451-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230316131711.1284451-1-alexghiti@rivosinc.com>
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to isolate the kernel text mapping and the crash kernel
region, we used some sort of hack to isolate thoses ranges which consisted
in marking them as not mappable with memblock_mark_nomap.

Simply use the newly introduced memblock_isolate_memory function which does
exactly the same but does not uselessly mark the region as not mappable.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/mmu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6f9d8898a025..387c2a065a09 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -548,19 +548,18 @@ static void __init map_mem(pgd_t *pgdp)
 
 	/*
 	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
-	 * So temporarily mark them as NOMAP to skip mappings in
-	 * the following for-loop
+	 * read-only text and rodata sections of the kernel image so isolate
+	 * those regions and map them after the for loop.
 	 */
-	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	memblock_isolate_memory(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map) {
 		if (defer_reserve_crashkernel())
 			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 		else if (crashk_res.end)
-			memblock_mark_nomap(crashk_res.start,
-			    resource_size(&crashk_res));
+			memblock_isolate_memory(crashk_res.start,
+						resource_size(&crashk_res));
 	}
 #endif
 
@@ -568,6 +567,17 @@ static void __init map_mem(pgd_t *pgdp)
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
 			break;
+
+		if (start == kernel_start)
+			continue;
+
+#ifdef CONFIG_KEXEC_CORE
+		if (start == crashk_res.start &&
+		    crash_mem_map && !defer_reserve_crashkernel() &&
+		    crashk_res.end)
+			continue;
+#endif
+
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
@@ -589,7 +599,6 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	__map_memblock(pgdp, kernel_start, kernel_end,
 		       PAGE_KERNEL, NO_CONT_MAPPINGS);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 
 	/*
 	 * Use page-level mappings here so that we can shrink the region
@@ -603,8 +612,6 @@ static void __init map_mem(pgd_t *pgdp)
 				       crashk_res.end + 1,
 				       PAGE_KERNEL,
 				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-			memblock_clear_nomap(crashk_res.start,
-					     resource_size(&crashk_res));
 		}
 	}
 #endif
-- 
2.37.2

