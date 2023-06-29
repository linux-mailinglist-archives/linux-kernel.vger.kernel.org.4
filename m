Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE85074223C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjF2IcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjF2Ia0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:30:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C72703;
        Thu, 29 Jun 2023 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688027415; x=1719563415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FyhCBQzwfA+WMj8JPqh8q7RSGYDMWs5+f1Cx9CBdUeU=;
  b=pTmqSUC7tUzftDcBj6G2Yo/YQOU+fGmpVSVCVPHBhWWbnjCN0Z/wVY2z
   ig7a+gsi+e0JTP2GccymgKu5EHEPQfBfDjxfMkVSxIUmPD412GEzGEzP8
   EPeI0R4aVmkA3Fhz6aRMQD/bNN24PE0H9uSYyCNHCNULX8uPofuYUVk6b
   DsfWxbRcqC9ZtrEng6EMD+wpfmF1kuF/pq8wqHvo0cMTOtFLY5jGH06Xa
   +U+x06SlXq496rhqUgeYOUXvcMTp9AtBZv2Ire41K2y9uCVt8Wy45AGIp
   FNdGfRev6Zwb1TWLXdUygQasbv4gezxX5iZRD+ppxOOZ2bME04Api1Wk8
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="220461307"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 01:30:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 01:30:14 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 01:30:11 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Evan Green" <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable parsing "riscv,isa"
Date:   Thu, 29 Jun 2023 09:28:56 +0100
Message-ID: <20230629-resilient-grievance-d782163b09d6@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=FyhCBQzwfA+WMj8JPqh8q7RSGYDMWs5+f1Cx9CBdUeU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClzHY7obVavUtw9NyBe5vWxwFOv+ZZa9B6d4MElaLi3sH39 L1GJjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkIx8jw5rVnnHmXF8XyF8z4PaQEv qXySfEuc0x/uets2oXG2dcf8/IcKJg2Z2Q6tpjEw6/avzHMm3O+rCfdR9mrtNeXVv+6JC5DzMA
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

As it says on the tin, provide a Kconfig option to disabling parsing the
"riscv,isa" devicetree property. Hide the option behind NONPORTABLE so
that only those willing to keep the pieces enable it, and make sure the
default kernel contains the fallback code.

Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig             | 16 ++++++++++++++++
 arch/riscv/kernel/cpu.c        |  3 +++
 arch/riscv/kernel/cpufeature.c |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1d39efe2b940..0e1909ac5947 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -291,6 +291,22 @@ config NONPORTABLE
 
 	  If unsure, say N.
 
+config NO_RISCV_ISA_FALLBACK
+	bool "Permit falling back to parsing riscv,isa for extension support"
+	depends on NONPORTABLE
+	help
+	  Parsing the "riscv,isa" devicetree property has been deprecated and
+	  replaced by a list of explicitly defined strings. For compatibility
+	  with existing platforms, the kernel will fall back to parsing the
+	  "riscv,isa" property if the replacements are not found.
+
+	  Selecting Y here will result in a kernel without this fallback, and
+	  will not work on platforms where the devicetree does not contain the
+	  replacement 	  properties of "riscv,isa-base" and
+	  "riscv,isa-extensions". Please see the dt-binding, located at
+	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
+	  on the replacement properties.
+
 choice
 	prompt "Base ISA"
 	default ARCH_RV64I
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 9a4f4a23afcd..86a1d98b8b3b 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -81,6 +81,9 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
 	return 0;
 
 old_interface:
+	if (IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK))
+		return -ENODEV;
+
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
 		pr_warn("CPU with hartid=%lu has no \"riscv,isa-base\" or \"riscv,isa\" property\n",
 			*hart);
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2c4503fa984f..f6fb18d2af84 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -490,7 +490,7 @@ void __init riscv_fill_hwcap(void)
 	} else {
 		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
 
-		if (ret) {
+		if (ret && !IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK)) {
 			pr_info("Falling back to deprecated \"riscv,isa\"\n");
 			riscv_fill_hwcap_from_isa_string(isa2hwcap);
 		}
-- 
2.40.1

