Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2625748A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGERbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGERbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:31:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5361BE3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:30:29 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6686708c986so5549302b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688578193; x=1691170193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21WgRYzk/FRZzyhPurFkJWRpl393yD1S4pYgQXdWIKY=;
        b=pDhW1muSnAlTyX2Z/SLj6E1+r/W6uepKcIroiGfSIOcT51P/RT7lujWK1VlHHTktOq
         TQ8oM+fQ6W4ituAQx2s48UNCh0krswk0E9sWzS7F4Ckrk4dJyqBHP6EsNqMpjLf8bf9p
         lV6/weT2vqENFEOJ2GCRRzqWkcWvId71QuOiyhJYPwfOYdeBQA6WbRdR8OXUFF2GVkXx
         3DjGYhBMbz7UA25iBepU8Ao+zB70V4gQFxlmGCdLz32FbAo0WXjKl2dTCF3LD/nAXW3r
         xaa1CmnZuV9vbUEsKfqF8j+n81vFgShCEuZtXpXHC7Ce4MblMnSYFw4TEIl6+maw/RiB
         J0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578193; x=1691170193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21WgRYzk/FRZzyhPurFkJWRpl393yD1S4pYgQXdWIKY=;
        b=V/FsRhiDl40ECzi98NPYzVwI+rNjG1tVxSbmy8tFky4PNS1LPbRzBeTyxqaVoe2Hjs
         vjcdC6laaRxzq44dMq2ZWUWISmmjvYGUv+YetMDy7y1/WHk3VlD2WKEmuHEer7v1QOdZ
         qRlNoxjEPqPum8eTxOTTxu9MZlbDwVeZy3SCx1HzXYjSq8AKXuaPRnCHfoTOdbSV/sHY
         SX+8YsCe2ndiwHq208r7amLKwkj+5Tz8DwVjFkroNoHa22H6XIp3w5KZiCFAFhCm3Y37
         jMtzsq+Oy60VsQF/bVsVt65jfMShrLNVRCLmxsoFXUBA5NAHBhmFTCDzCFxgKzboG5Y8
         KmIg==
X-Gm-Message-State: ABy/qLZkM7vDnHCwFRxwyVoL6xNsYtRufz4LJh0KclQRUwR7DXHZZzjH
        9Xki2ZujMpC60SMzb6hYhG6Ypg==
X-Google-Smtp-Source: APBJJlE+cUUqf4PZsftRzFUhRQhAQdKZ66CaWMKscoxCnAdrmnh4xbX2rF0IZVJYDMbIvyaf6RKciQ==
X-Received: by 2002:a05:6a00:1823:b0:67e:18c6:d2c6 with SMTP id y35-20020a056a00182300b0067e18c6d2c6mr22812326pfa.5.1688578192636;
        Wed, 05 Jul 2023 10:29:52 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id t15-20020a62ea0f000000b0068288aaf23esm5719930pfh.100.2023.07.05.10.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 10:29:52 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Date:   Wed,  5 Jul 2023 10:29:31 -0700
Message-Id: <20230705172931.1099183-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
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

In /proc/cpuinfo, most of the information we show for each processor is
specific to that hart: marchid, mvendorid, mimpid, processor, hart,
compatible, and the mmu size. But the ISA string gets filtered through a
lowest common denominator mask, so that if one CPU is missing an ISA
extension, no CPUs will show it.

Now that we track the ISA extensions for each hart, let's report ISA
extension info accurately per-hart in /proc/cpuinfo. We cannot change
the "isa:" line, as usermode may be relying on that line to show only
the common set of extensions supported across all harts. Add a new "hart
isa" line instead, which reports the true set of extensions for that
hart. This matches what is returned in riscv_hwprobe() when querying a
given hart.

Signed-off-by: Evan Green <evan@rivosinc.com>

---

Changes in v2:
 - Added new "hart isa" line rather than altering behavior of existing
   "isa" line (Conor, Palmer)


I based this series on top of Conor's riscv-extensions-strings branch
from July 3rd, since otherwise this change gets hopelessly entangled
with that series.

I was unsure if I could snuggle the new "hart isa" line in just below
"isa". Aesthetically it would be quite pleasing, but it runs the risk of
breaking brittle usermode parsers that are assuming a specific line
order. So I put it at the end.

---
 arch/riscv/kernel/cpu.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 1acf3679600d..6264b7b94945 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -197,9 +197,8 @@ arch_initcall(riscv_cpuinfo_init);
 
 #ifdef CONFIG_PROC_FS
 
-static void print_isa(struct seq_file *f)
+static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
 {
-	seq_puts(f, "isa\t\t: ");
 
 	if (IS_ENABLED(CONFIG_32BIT))
 		seq_write(f, "rv32", 4);
@@ -207,7 +206,7 @@ static void print_isa(struct seq_file *f)
 		seq_write(f, "rv64", 4);
 
 	for (int i = 0; i < riscv_isa_ext_count; i++) {
-		if (!__riscv_isa_extension_available(NULL, riscv_isa_ext[i].id))
+		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
 			continue;
 
 		/* Only multi-letter extensions are split by underscores */
@@ -271,7 +270,15 @@ static int c_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
-	print_isa(m);
+
+	/*
+	 * For historical raisins, the isa: line is limited to the lowest common
+	 * denominator of extensions supported across all harts. A true list of
+	 * extensions supported on this hart is printed later in the hart_isa:
+	 * line.
+	 */
+	seq_puts(m, "isa\t\t: ");
+	print_isa(m, NULL);
 	print_mmu(m);
 
 	if (acpi_disabled) {
@@ -287,6 +294,13 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
 	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
 	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
+
+	/*
+	 * Print the ISA extensions specific to this hart, which may show
+	 * additional extensions not present across all harts.
+	 */
+	seq_puts(m, "hart isa\t: ");
+	print_isa(m, hart_isa[cpu_id].isa);
 	seq_puts(m, "\n");
 
 	return 0;
-- 
2.34.1

