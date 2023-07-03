Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1A745A41
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGCKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGCK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:29:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24201710;
        Mon,  3 Jul 2023 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688380170; x=1719916170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GCIGwsCwU5RS5bMsoRtWcou0pn3VgTFaZMXbVrYz4DA=;
  b=2OUXeVYip8DxTmGOvGO4vhWnLtHYc9MaDRpirjZG2t/a3XjyO3Jptlji
   YuhhxQ6DCUWSJAkARETFesJS2HUAtfUGslfwTpdwce2BMkC8f26+mKWSs
   5f+o2pS+Mn/4jCoOlHIIp9JKrTk0ufSWnQm3LsdZLbbYLadROII2bwFMd
   ytmuaazDkw4Dtx6Xgk5p4QiPpFW5odzJUzan8/qh+9OPjv5XDIVoYAgZw
   QwI8ywyTkFHxhcbmvoqSW6T2yvf7JRv5aw43QW1pVVcrvKQbCKEW2iVzu
   /NNZTRALoUVWqMzRay7pJQEzPiPnHR7uvVNK9yTFa/VTA4mWoOn4oTIDc
   A==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="218683999"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 03:29:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 03:29:23 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 03:29:21 -0700
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
Subject: [PATCH v3 09/11] RISC-V: enable extension detection from new properties
Date:   Mon, 3 Jul 2023 11:28:01 +0100
Message-ID: <20230703-throwback-polio-d5fa832ad368@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
References: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4499; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=GCIGwsCwU5RS5bMsoRtWcou0pn3VgTFaZMXbVrYz4DA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmLFq25vtB/8xcjV76neuf5K392Bwi92qm1eLIi4+7Y2QJ/ SpiYOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRiRMZ/lcdr/RzkTwiYl/8tjdZbW OUpW3IZVnxvY9SdqXy5s9YJcvI8OLS+4IrzbUuwd0cj4vu7q3wL9PQ6xFVLbo4f6kKH8cXRgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parsing the new riscv,isa-extensions property in
riscv_fill_hwcap(), by means of a new "property" member of the
riscv_isa_ext_data struct. For now, this shadows the name of the
extension for all users, however this may not be the case for all
extensions, based on how the dt-binding is written.
For the sake of backwards compatibility, fall back to the old scheme
if the new properties are not detected. For now, just inform, rather
than warn, when that happens.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Pick a more suitable function name than fill_hwcap_new()
- Actually use the property member to read from the DT
---
 arch/riscv/include/asm/hwcap.h |  1 +
 arch/riscv/kernel/cpufeature.c | 76 ++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index a20e4ade1b53..e3cda14a486b 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -76,6 +76,7 @@ unsigned long riscv_get_elf_hwcap(void);
 struct riscv_isa_ext_data {
 	const unsigned int id;
 	const char *name;
+	const char *property;
 };
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 41aedeaecb61..2c4503fa984f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -101,6 +101,7 @@ static bool riscv_isa_extension_check(int id)
 
 #define __RISCV_ISA_EXT_DATA(_name, _id) {	\
 	.name = #_name,				\
+	.property = #_name,			\
 	.id = _id,				\
 }
 
@@ -414,11 +415,67 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		acpi_put_table((struct acpi_table_header *)rhct);
 }
 
+static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		unsigned long this_hwcap = 0;
+		struct device_node *cpu_node;
+		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
+
+		cpu_node = of_cpu_device_node_get(cpu);
+		if (!cpu_node) {
+			pr_warn("Unable to find cpu node\n");
+			continue;
+		}
+
+		if (!of_property_present(cpu_node, "riscv,isa-extensions"))
+			continue;
+
+		for (int i = 0; i < riscv_isa_ext_count; i++) {
+			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
+						     riscv_isa_ext[i].property) < 0)
+				continue;
+
+			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
+				continue;
+
+			/* Only single letter extensions get set in hwcap */
+			if (strnlen(riscv_isa_ext[i].name, 2) == 1)
+				this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
+
+			set_bit(riscv_isa_ext[i].id, this_isa);
+		}
+
+		of_node_put(cpu_node);
+
+		/*
+		 * All "okay" harts should have same isa. Set HWCAP based on
+		 * common capabilities of every "okay" hart, in case they don't.
+		 */
+		if (elf_hwcap)
+			elf_hwcap &= this_hwcap;
+		else
+			elf_hwcap = this_hwcap;
+
+		if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
+			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
+		else
+			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
+	}
+
+	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
+		return -ENOENT;
+
+	return 0;
+}
+
 void __init riscv_fill_hwcap(void)
 {
 	char print_str[NUM_ALPHA_EXTS + 1];
-	int i, j;
 	unsigned long isa2hwcap[26] = {0};
+	int i, j;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -428,10 +485,21 @@ void __init riscv_fill_hwcap(void)
 	isa2hwcap['c' - 'a'] = COMPAT_HWCAP_ISA_C;
 	isa2hwcap['v' - 'a'] = COMPAT_HWCAP_ISA_V;
 
-	riscv_fill_hwcap_from_isa_string(isa2hwcap);
+	if (!acpi_disabled) {
+		riscv_fill_hwcap_from_isa_string(isa2hwcap);
+	} else {
+		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
 
-	/* We don't support systems with F but without D, so mask those out
-	 * here. */
+		if (ret) {
+			pr_info("Falling back to deprecated \"riscv,isa\"\n");
+			riscv_fill_hwcap_from_isa_string(isa2hwcap);
+		}
+	}
+
+	/*
+	 * We don't support systems with F but without D, so mask those out
+	 * here.
+	 */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
 		pr_info("This kernel does not support systems with F but not D\n");
 		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
-- 
2.40.1

