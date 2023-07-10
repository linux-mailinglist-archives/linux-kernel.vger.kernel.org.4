Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B9474DE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGJTY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGJTY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:24:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0DE3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:24:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262ff3a4659so3667329a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689017065; x=1691609065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVU5xkkFrBHK9KN4xCmrxkM+F8/EoTyfyWL/2CP+3j0=;
        b=HASFVZl23FPMCm79tXoegRb1RNFILB9pF0aVoVMK8x4Sxj+bbrS70w4s+kI778hKvo
         rgVeXgf8djTPdQwty4wprwlEFrb3lhdGd/5Z7XWefuGrcp4oEeSRwKxzc9ZpwZ1lBEsY
         41h1Q/oXnJCJAbhIepxk74dE+5mMkkSoVoHFg5jAw8QI079ME/C5vdykHYakRi4fPbX7
         3z65PNk21m2ZjuB+sgjrjVcWtlZVtvMv5FD9QfkKTGY+nNIP7c5PDj1xs+OsZf+CVB6i
         ZnJ7q30xy/5dw0omQTP7ZNjTUSEvmHUElLvT2Ns8khZyXU7Z3rqTKEwNO39X4vCDI3Ir
         hDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017065; x=1691609065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVU5xkkFrBHK9KN4xCmrxkM+F8/EoTyfyWL/2CP+3j0=;
        b=B9wfhaLv315xpQjL/i4UeAjbG7XpDNOZzoQC3S5qa50aFs7IYRYamK2jIy5r86LQaW
         qC+70VD7iCwSGNN+NzlcTNHRDcGuooR6+ZBnfg+tbk5ZISjUw7WJuEEJCcf6xnfy+MC8
         ah/pzBvGueWrUaNqZIPv24kPJ6NmS9tcKKU5w1/NBk7OgMo47m44wp93CYQ0Dx9LB6Lg
         wnO0ZpFIH3pQtXGFxm4I+qTdjegc2N+bcEnbOQC55y3AxkrOP4AG6pbnnJigorl74ARh
         hEzgxcDyIcp0sAtFflvH9gYTnw5aWLInYPCWYjUjEbTiemLwTMWJ4YA45hdMVOCoGktC
         kV7g==
X-Gm-Message-State: ABy/qLa8Vkbsm1F2YPY8EZJBN7E2I47nggGOrmXsLJlihnduV72uiNAM
        g35xRyIORgDg7aypqtlr6QoIug==
X-Google-Smtp-Source: APBJJlElX3ouS/7FElxVVpI095f8HqlJxpa1dRsjo4z1LRMa0ZScCGPnPQjxkZlRuLEsux42YF/jSw==
X-Received: by 2002:a17:90a:3e08:b0:25b:e85a:e9fe with SMTP id j8-20020a17090a3e0800b0025be85ae9femr12935954pjc.27.1689017064856;
        Mon, 10 Jul 2023 12:24:24 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a74c900b00263ba6a248bsm6646981pjl.1.2023.07.10.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:24:24 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Evan Green <evan@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Date:   Mon, 10 Jul 2023 12:24:13 -0700
Message-Id: <20230710192413.2089085-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes in v3:
 - Add some documentation (Conor)

Changes in v2:
 - Added new "hart isa" line rather than altering behavior of existing
   "isa" line (Conor, Palmer)


I based this series on top of Conor's riscv-extensions-strings branch
from July 3rd, since otherwise this change gets hopelessly entangled
with that series.

---
 Documentation/riscv/uabi.rst | 10 ++++++++++
 arch/riscv/kernel/cpu.c      | 22 ++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
index 8960fac42c40..4f462f5b168c 100644
--- a/Documentation/riscv/uabi.rst
+++ b/Documentation/riscv/uabi.rst
@@ -42,6 +42,16 @@ An example string following the order is::
 
    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
 
+"isa" vs "hart isa" lines in /proc/cpuinfo
+-----------------------------------------
+
+The "isa" line in /proc/cpuinfo describes the lowest common denominator of
+RISC-V ISA extensions understood by the kernel and implemented on all harts. The
+"hart isa" line, in contrast, describes the set of extensions understood by the
+kernel on the particular hart in question, even if those extensions may not be
+present on all harts in the system. The "hart isa" line is consistent with
+what's returned by __riscv_hwprobe() when querying for that specific CPU.
+
 Misaligned accesses
 -------------------
 
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

