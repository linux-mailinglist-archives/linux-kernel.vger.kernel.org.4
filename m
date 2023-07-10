Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1352C74D1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjGJJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjGJJjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:39:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86D26BB;
        Mon, 10 Jul 2023 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688981813; x=1720517813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZKaRuGdjiNCn7C7n8xPfX596TIEq0qNYdoQyUSZd1aQ=;
  b=GkwOWqQ335P0jFJkhgvqYfI61DMRZvR1SXfg8LOaK37dPj2GerciF59M
   iXWBI1ooRAcUTAkgAsuvzVlhOfeB7UTyqiBT9nfRiYpxbFqBf1p0uy4Zg
   XjuzOSnYSs3yfRoHFW2lGaZdiMRN98l+tiPYlHtH1UTylMdCVGcVSzgmk
   Sf2uWo8U7/4xgJQ4x1mn35rPHDZJH+SSK05F4BSp2IanPMaq7S9bkQyWH
   ZhiFZl2S1+s12SgVJetkAQknVlRDLZ/bhTERGPzPTa7M3rR53ZI/hQTOW
   FUlO/d0CGc18741X7M8pMlLQpYKu3zQOBM+MX3ELx0wxAVIIdAhE3K8hS
   g==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="234573276"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2023 02:36:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 10 Jul 2023 02:36:33 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 10 Jul 2023 02:36:31 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/11] RISC-V: don't parse dt/acpi isa string to get rv32/rv64
Date:   Mon, 10 Jul 2023 10:35:37 +0100
Message-ID: <20230710-moodiness-region-bf54989f0bbe@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710-equipment-stained-dd042d66ba5d@wendy>
References: <20230710-equipment-stained-dd042d66ba5d@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=n3RvV1kp7c1RvguDNV0TNjeqOvB9izEszUM2SQOrTeY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmrL1xrq/y6cc4vhwO/L/HHnJ5VqJXfx9W/P5Y19wqL85Ju 5cB3HSUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI+UpGhpOeN3I3stx12B/f4Ra3x+ XG9vUXrv67wHs1oeeolXnHw7UMX/iffzvHX6ykIZ2/sOaHy4qpNyayRNz3fDS5LEjI8EkLAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

When filling hwcap the kernel already expects the isa string to start with
rv32 if CONFIG_32BIT and rv64 if CONFIG_64BIT.

So when recreating the runtime isa-string we can also just go the other way
to get the correct starting point for it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
- Fix tabbing of print_mmu()

Changes in v2:
- Delete the whole else & pull print_mmu() above it, since that's common
  code now
---
 arch/riscv/kernel/cpu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3af2d214ce21..f808b67f5a27 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -257,13 +257,16 @@ static void print_isa_ext(struct seq_file *f)
  */
 static const char base_riscv_exts[13] = "imafdqcbkjpvh";
 
-static void print_isa(struct seq_file *f, const char *isa)
+static void print_isa(struct seq_file *f)
 {
 	int i;
 
 	seq_puts(f, "isa\t\t: ");
-	/* Print the rv[64/32] part */
-	seq_write(f, isa, 4);
+	if (IS_ENABLED(CONFIG_32BIT))
+		seq_write(f, "rv32", 4);
+	else
+		seq_write(f, "rv64", 4);
+
 	for (i = 0; i < sizeof(base_riscv_exts); i++) {
 		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
 			/* Print only enabled the base ISA extensions */
@@ -320,27 +323,21 @@ static int c_show(struct seq_file *m, void *v)
 	unsigned long cpu_id = (unsigned long)v - 1;
 	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
 	struct device_node *node;
-	const char *compat, *isa;
+	const char *compat;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
+	print_isa(m);
+	print_mmu(m);
 
 	if (acpi_disabled) {
 		node = of_get_cpu_node(cpu_id, NULL);
-		if (!of_property_read_string(node, "riscv,isa", &isa))
-			print_isa(m, isa);
 
-		print_mmu(m);
 		if (!of_property_read_string(node, "compatible", &compat) &&
 		    strcmp(compat, "riscv"))
 			seq_printf(m, "uarch\t\t: %s\n", compat);
 
 		of_node_put(node);
-	} else {
-		if (!acpi_get_riscv_isa(NULL, cpu_id, &isa))
-			print_isa(m, isa);
-
-		print_mmu(m);
 	}
 
 	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
-- 
2.40.1

