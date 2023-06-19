Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2AF734B79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjFSGBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F261B8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687154414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpHql56o0Ol2+6lYVJK23uRll0Ruosuke+wpToxzf9M=;
        b=MYdfjl05DvjAIsROHhiJtpBB8ZuJytwHe57IYAXXkucPW4r2kXKYElShnE3lyO0YnHt5G8
        YMAnJIDV/8fkbqS5U+7IiyMolSQ+IsZC2AFPZXQ4p6iK/cDQwqhhZbI0Hy87Exl8+QTGNn
        D0iV8Li43nfzgbRH6pMzA2FimrW6wj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-TNwaER-hPVO9kiL19i_CkQ-1; Mon, 19 Jun 2023 02:00:07 -0400
X-MC-Unique: TNwaER-hPVO9kiL19i_CkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37189811E78;
        Mon, 19 Jun 2023 06:00:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-194.pek2.redhat.com [10.72.12.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB953112132C;
        Mon, 19 Jun 2023 06:00:01 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, horms@kernel.org,
        chenjiahao16@huawei.com, linux-riscv@lists.infradead.org,
        x86@kernel.org, bp@alien8.de, Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH 1/4] kdump: rename parse_crashkernel() to parse_crashkernel_common()
Date:   Mon, 19 Jun 2023 13:59:48 +0800
Message-Id: <20230619055951.45620-2-bhe@redhat.com>
In-Reply-To: <20230619055951.45620-1-bhe@redhat.com>
References: <20230619055951.45620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there are parse_crashkernel_high() and parse_crashkernel_low()
parsing crashkernel=,high|low. Function parse_crashkernel() could be
misunderstood as a generic interface parsing all possible crashkernel
kernel parameters.

Hence, rename parse_crashkernel() to parse_crashkernel_common() to
differentiate it from parse_crashkernel_high() and
parse_crashkernel_low(), to remove possible ambiguity.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/kernel/setup.c              |  4 ++--
 arch/arm64/mm/init.c                 |  4 ++--
 arch/ia64/kernel/setup.c             |  4 ++--
 arch/loongarch/kernel/setup.c        |  3 ++-
 arch/mips/cavium-octeon/setup.c      |  2 +-
 arch/mips/kernel/setup.c             |  4 ++--
 arch/powerpc/kernel/fadump.c         |  5 +++--
 arch/powerpc/kexec/core.c            |  4 ++--
 arch/powerpc/mm/nohash/kaslr_booke.c |  4 ++--
 arch/riscv/mm/init.c                 |  5 +++--
 arch/s390/kernel/setup.c             |  4 ++--
 arch/sh/kernel/machine_kexec.c       |  5 +++--
 arch/x86/kernel/setup.c              |  3 ++-
 include/linux/crash_core.h           |  2 +-
 kernel/crash_core.c                  | 14 +++++---------
 15 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 75cd4699e7b3..7f3dc9ff32f7 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1016,8 +1016,8 @@ static void __init reserve_crashkernel(void)
 	int ret;
 
 	total_mem = get_total_mem();
-	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base);
+	ret = parse_crashkernel_common(boot_command_line, total_mem,
+				       &crash_size, &crash_base);
 	/* invalid value specified or crashkernel=0 */
 	if (ret || !crash_size)
 		return;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index c28c2c8483cc..2fc4ea0b5b7a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -114,8 +114,8 @@ static void __init reserve_crashkernel(void)
 		return;
 
 	/* crashkernel=X[@offset] */
-	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
+	ret = parse_crashkernel_common(cmdline, memblock_phys_mem_size(),
+				       &crash_size, &crash_base);
 	if (ret == -ENOENT) {
 		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
 		if (ret || !crash_size)
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index c05728044272..91531fce0ba3 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -276,8 +276,8 @@ static void __init setup_crashkernel(unsigned long total, int *n)
 	unsigned long long base = 0, size = 0;
 	int ret;
 
-	ret = parse_crashkernel(boot_command_line, total,
-			&size, &base);
+	ret = parse_crashkernel_common(boot_command_line, total,
+				       &size, &base);
 	if (ret == 0 && size > 0) {
 		if (!base) {
 			sort_regions(rsvd_region, *n);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 4444b13418f0..17f9d3d58906 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -267,7 +267,8 @@ static void __init arch_parse_crashkernel(void)
 	unsigned long long crash_base, crash_size;
 
 	total_mem = memblock_phys_mem_size();
-	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	ret = parse_crashkernel_common(boot_command_line, total_mem,
+				       &crash_size, &crash_base);
 	if (ret < 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index c5561016f577..bdcac8a4d85e 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -885,7 +885,7 @@ void __init prom_init(void)
 			strcat(arcs_cmdline, arg);
 			/*
 			 * To do: switch parsing to new style, something like:
-			 * parse_crashkernel(arg, sysinfo->system_dram_size,
+			 * parse_crashkernel_common(arg, sysinfo->system_dram_size,
 			 *		  &crashk_size, &crashk_base);
 			 */
 #endif
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c0e65135481b..99f3ed8aeb35 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -457,8 +457,8 @@ static void __init mips_parse_crashkernel(void)
 	int ret;
 
 	total_mem = memblock_phys_mem_size();
-	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base);
+	ret = parse_crashkernel_common(boot_command_line, total_mem,
+				       &crash_size, &crash_base);
 	if (ret != 0 || crash_size <= 0)
 		return;
 
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ea0a073abd96..b4a038cbd1cf 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -312,8 +312,9 @@ static __init u64 fadump_calculate_reserve_size(void)
 	 * option. If yes, then use that but ignore base as fadump reserves
 	 * memory at a predefined offset.
 	 */
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&size, &base);
+	ret = parse_crashkernel_common(boot_command_line,
+				       memblock_phys_mem_size(),
+				       &size, &base);
 	if (ret == 0 && size > 0) {
 		unsigned long max_size;
 
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index de64c7962991..853de54cc2db 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -108,8 +108,8 @@ void __init reserve_crashkernel(void)
 
 	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
 	/* use common parsing */
-	ret = parse_crashkernel(boot_command_line, total_mem_sz,
-			&crash_size, &crash_base);
+	ret = parse_crashkernel_common(boot_command_line, total_mem_sz,
+				       &crash_size, &crash_base);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 2fb3edafe9ab..8c049659056f 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -177,8 +177,8 @@ static void __init get_crash_kernel(void *fdt, unsigned long size)
 	unsigned long long crash_size, crash_base;
 	int ret;
 
-	ret = parse_crashkernel(boot_command_line, size, &crash_size,
-				&crash_base);
+	ret = parse_crashkernel_common(boot_command_line, size,
+				       &crash_size, &crash_base);
 	if (ret != 0 || crash_size == 0)
 		return;
 	if (crash_base == 0)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4fa420faa780..6d4b27fc254b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1326,8 +1326,9 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
+	ret = parse_crashkernel_common(boot_command_line,
+				       memblock_phys_mem_size(),
+				       &crash_size, &crash_base);
 	if (ret || !crash_size)
 		return;
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index fe10da1a271e..9693f155936e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -625,8 +625,8 @@ static void __init reserve_crashkernel(void)
 	phys_addr_t low, high;
 	int rc;
 
-	rc = parse_crashkernel(boot_command_line, ident_map_size, &crash_size,
-			       &crash_base);
+	rc = parse_crashkernel_common(boot_command_line, ident_map_size,
+				      &crash_size, &crash_base);
 
 	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
 	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 223c14f44af7..9775f6fe245c 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -153,8 +153,9 @@ void __init reserve_crashkernel(void)
 	unsigned long long crash_size, crash_base;
 	int ret;
 
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-			&crash_size, &crash_base);
+	ret = parse_crashkernel_common(boot_command_line,
+				       memblock_phys_mem_size(),
+				       &crash_size, &crash_base);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff771bd..b2b67b8c1c1e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -558,7 +558,8 @@ static void __init reserve_crashkernel(void)
 	total_mem = memblock_phys_mem_size();
 
 	/* crashkernel=XM */
-	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	ret = parse_crashkernel_common(boot_command_line, total_mem,
+				       &crash_size, &crash_base);
 	if (ret != 0 || crash_size <= 0) {
 		/* crashkernel=X,high */
 		ret = parse_crashkernel_high(boot_command_line, total_mem,
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..6ec10ed5c6a6 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -77,7 +77,7 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
 
-int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
+int __init parse_crashkernel_common(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 90ce1dfd591c..57738ca0ee7f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -273,17 +273,13 @@ static int __init __parse_crashkernel(char *cmdline,
 	return parse_crashkernel_simple(ck_cmdline, crash_size, crash_base);
 }
 
-/*
- * That function is the entry point for command line parsing and should be
- * called from the arch-specific code.
- */
-int __init parse_crashkernel(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+int __init parse_crashkernel_common(char *cmdline,
+				    unsigned long long system_ram,
+				    unsigned long long *crash_size,
+				    unsigned long long *crash_base)
 {
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-					"crashkernel=", NULL);
+				   "crashkernel=", NULL);
 }
 
 int __init parse_crashkernel_high(char *cmdline,
-- 
2.34.1

