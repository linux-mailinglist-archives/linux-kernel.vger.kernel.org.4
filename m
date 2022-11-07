Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE761F3EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiKGNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiKGNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:04:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2468ABAA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:04:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B638060F74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA8EC433D6;
        Mon,  7 Nov 2022 13:04:25 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Combine acpi_boot_table_init() and acpi_boot_init()
Date:   Mon,  7 Nov 2022 21:01:59 +0800
Message-Id: <20221107130159.3698812-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine acpi_boot_table_init() and acpi_boot_init() since they are very
simple, and we don't need to check the return value of acpi_boot_init().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/acpi.c  | 31 ++++++++++---------------------
 arch/loongarch/kernel/setup.c |  1 -
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 335398482038..8319cc409009 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -56,23 +56,6 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 		return ioremap_cache(phys, size);
 }
 
-void __init acpi_boot_table_init(void)
-{
-	/*
-	 * If acpi_disabled, bail out
-	 */
-	if (acpi_disabled)
-		return;
-
-	/*
-	 * Initialize the ACPI boot-time table parser.
-	 */
-	if (acpi_table_init()) {
-		disable_acpi();
-		return;
-	}
-}
-
 #ifdef CONFIG_SMP
 static int set_processor_mask(u32 id, u32 flags)
 {
@@ -156,13 +139,21 @@ static void __init acpi_process_madt(void)
 	loongson_sysconf.nr_cpus = num_processors;
 }
 
-int __init acpi_boot_init(void)
+void __init acpi_boot_table_init(void)
 {
 	/*
 	 * If acpi_disabled, bail out
 	 */
 	if (acpi_disabled)
-		return -1;
+		return;
+
+	/*
+	 * Initialize the ACPI boot-time table parser.
+	 */
+	if (acpi_table_init()) {
+		disable_acpi();
+		return;
+	}
 
 	loongson_sysconf.boot_cpu_id = read_csr_cpuid();
 
@@ -173,8 +164,6 @@ int __init acpi_boot_init(void)
 
 	/* Do not enable ACPI SPCR console by default */
 	acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
-
-	return 0;
 }
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 1eb63fa9bc81..ae436def7ee9 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -257,7 +257,6 @@ void __init platform_init(void)
 #ifdef CONFIG_ACPI
 	acpi_gbl_use_default_register_widths = false;
 	acpi_boot_table_init();
-	acpi_boot_init();
 #endif
 
 #ifdef CONFIG_NUMA
-- 
2.31.1

