Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3D6B3B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjCJJta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCJJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:49:12 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7596A9E9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:48:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so2997742wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678441727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGavHCNEAmB3AhZu0LKzFHubCv5xCdNflVD0ekR4UY0=;
        b=nEDaPnA8Ty4PvBzODbwL6B2sTto11mRsb4Jzs2H7G9p6A7ZKSNrhnk3x4BOWFO5NAM
         I/78Se50og1itnoiMPakGj3AveG31x2j6/j/50CVZh8lwbX6MQDYxcf8yYxVJoMofzOn
         So11W4KjPW25NSlFIH8QkPFlfV0uo7dzOyl980DN9KkNz+cd36ioi6QDF2EBD7bd5PyU
         POxxiU/fHG2HLQE58X+B7ZTBTf7m1Ez0P/WNGhmIjfMIHPth9RdlR4D0u/Oxg4pQMLp3
         2eK+lEAa5joep7xYw4om/Il1YLWfTzdepO6+BmZdGMIWNwLKWLRg8ZeFmMq9uBF+PfuR
         4knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGavHCNEAmB3AhZu0LKzFHubCv5xCdNflVD0ekR4UY0=;
        b=O7pG38jZUGFAMCMFjZsQip6auZM4a9UkEU5mDSHvM5PQlJrQ/SU/MlVp6iAoTadv4P
         jerVBU0oBb5kCrptyC92ZXxCNLbH7wQunioj5eTJspsujomls50kTJmcByS0fds9yXgj
         Ecc+CFWo1k4PrmLn5IBZFSNwqFzRgTRKApE8+aJDacE2fhHk+Qkx41+nx2C9cfF9DVZA
         nsxV/JhBSUZXDjghHS5pZvRqFuiE0a9Mm0VLmWRGTf4nVw7NNh9AaLorc6p0V0xp9iHo
         uicPPZLiVkFtHVs5WslryfcA4Y34PD82Agc0S0KA7FjaMvlabIVRdp7OKL801n86//Ho
         23hQ==
X-Gm-Message-State: AO0yUKW6bJXsa/aHeQcSQ1lAJPfI6W3G+ISGoZETyIyBsAT6e3HGWHdm
        6jqnvAuJ8ldOLaLqxuXdJJb6nA==
X-Google-Smtp-Source: AK7set+y/rX3YhT007UnAYJB6sfLfhyhEqqnKFykNxvLHTsOstaKSQULB4uzAM12oQybO0ImSo5iuQ==
X-Received: by 2002:a05:600c:b8a:b0:3eb:578d:ded3 with SMTP id fl10-20020a05600c0b8a00b003eb578dded3mr1976475wmb.35.1678441727129;
        Fri, 10 Mar 2023 01:48:47 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003dc5b59ed7asm1572826wmi.11.2023.03.10.01.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:48:46 -0800 (PST)
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
Subject: [PATCH v7 3/4] arm64: Make use of memblock_isolate_memory for the linear mapping
Date:   Fri, 10 Mar 2023 10:45:38 +0100
Message-Id: <20230310094539.764357-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230310094539.764357-1-alexghiti@rivosinc.com>
References: <20230310094539.764357-1-alexghiti@rivosinc.com>
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

In order to isolate the kernel text mapping, we used some sort of hack
to isolate the kernel text range which consisted in marking this region
as not mappable with memblock_mark_nomap. Simply use the newly introduced
memblock_isolate_memory function which does exactly the same but does not
uselessly mark the region as not mappable.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6f9d8898a025..408dc852805c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -552,7 +552,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * So temporarily mark them as NOMAP to skip mappings in
 	 * the following for-loop
 	 */
-	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	memblock_isolate_memory(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map) {
@@ -568,6 +568,7 @@ static void __init map_mem(pgd_t *pgdp)
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
 			break;
+
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
@@ -589,7 +590,6 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	__map_memblock(pgdp, kernel_start, kernel_end,
 		       PAGE_KERNEL, NO_CONT_MAPPINGS);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 
 	/*
 	 * Use page-level mappings here so that we can shrink the region
-- 
2.37.2

