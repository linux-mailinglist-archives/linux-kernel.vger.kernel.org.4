Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116DA6AE1C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjCGOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCGOIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:08:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B308F867D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 950B161456
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1021EC4339C;
        Tue,  7 Mar 2023 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198056;
        bh=an7RQl0FyYFp7pKvljqsgvYahLoQXlUCxmiwvRE6nxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1AMjA/Q6Tv3JeIisClS6GOarzAr08r6Bk0wyffkzCepVTonXIzNfn3dUG7iWkgjX
         dNDCIuawjWf584NQZRvBZECxIqAPoKXI9r7qy+drljZo+dgHMf/UCmCK8xWjij+HpP
         IDkGd5BGbfTNsE7p2IaTMYkRmc3cGfXtXi4RSKFXXqqUV7nzxJfJciSb6IxyNWR4t3
         wxbTPKgzRK7jYLmhqinyjhAs9/fcr25cHfwwd5QOoz/xf0d/NWGDMRuB0EClW/nbad
         Di5hhFWByMQ4MlVIg8dG3TSpcAiaJm1+WYhpOcdXuQgvh27jS78kxnG1igLHBc6/U+
         4CrBQFoFtJ1Rw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 24/60] arm64: kernel: Remove early fdt remap code
Date:   Tue,  7 Mar 2023 15:04:46 +0100
Message-Id: <20230307140522.2311461-25-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=ardb@kernel.org; h=from:subject; bh=an7RQl0FyYFp7pKvljqsgvYahLoQXlUCxmiwvRE6nxQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxSqOkXnV6mPWGxZKXlvR5vbwjFFV9H1f3/1+B2PvH dintU+jo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzktiAjw0UG5R2NFRlGBk0u nxcly37OrC0orPc5x+8vbuwidNR2P8M/i/sxShuXJ3Gpiymmr7hrfn/Gih1/LQP+CPgKmJd4XFr DCAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early FDT remap code is no longer used so let's drop it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/setup.h |  3 ---
 arch/arm64/kernel/setup.c      | 15 ---------------
 2 files changed, 18 deletions(-)

diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index f4af547ef54caa70..acc5e00bf3b0fafb 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -7,9 +7,6 @@
 
 #include <uapi/asm/setup.h>
 
-void *get_early_fdt_ptr(void);
-void early_fdt_map(u64 dt_phys);
-
 /*
  * These two variables are used in the head.S file.
  */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index b8ec7b3ac9cbe8a8..bda21a9245943c57 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -166,21 +166,6 @@ static void __init smp_build_mpidr_hash(void)
 		pr_warn("Large number of MPIDR hash buckets detected\n");
 }
 
-static void *early_fdt_ptr __initdata;
-
-void __init *get_early_fdt_ptr(void)
-{
-	return early_fdt_ptr;
-}
-
-asmlinkage void __init early_fdt_map(u64 dt_phys)
-{
-	int fdt_size;
-
-	early_fixmap_init();
-	early_fdt_ptr = fixmap_remap_fdt(dt_phys, &fdt_size, PAGE_KERNEL);
-}
-
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	int size;
-- 
2.39.2

