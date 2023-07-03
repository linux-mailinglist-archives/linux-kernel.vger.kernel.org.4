Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E6745A44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGCKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjGCKaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:30:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1B9173C;
        Mon,  3 Jul 2023 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688380175; x=1719916175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lVE/oaRwv4TRJvHt5T3XNlCrqoPFy2NcS4RQfVsdXa0=;
  b=E+lyJZejmMzER3qxziWSb5KeiZfvpRp4x+D3hzfJ6DnyMNJ2NQEE3eAH
   7wuth/XgqKTcKCOaHBj4SDG06a7kjVgivHg2j/sBl+vAttUFEuYOOrWPn
   C474V6EZPyqT26uov70s9Xi8gk7NcP3LZV2dmLjNZUsQnhDjSlI6Y2P3b
   zq7PMIyvi7Dbod9BZdchfUmP5xBhT/KQ7EtgmBn6U/eJkiQrB6dmFfRBs
   X5qDD+PSbxwd0hfNmtntQqIgRZiug42uM+1kXyCfomw2PqNAFpsKzKF/t
   YwZ5Eku4xEvPa6j3KKERdgAu8O8ymkGyf26ykesZA22OzE/3gia/i0PhM
   w==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="221754681"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 03:29:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 03:29:29 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 03:29:27 -0700
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 11/11] RISC-V: provide Kconfig & commandline options to control parsing "riscv,isa"
Date:   Mon, 3 Jul 2023 11:28:03 +0100
Message-ID: <20230703-greedy-dividable-251fa2b809ac@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
References: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5379; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=lVE/oaRwv4TRJvHt5T3XNlCrqoPFy2NcS4RQfVsdXa0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmLFq19sfNDxd5ZKzstu/hT0m4Kftl+W1isKaJn3ZtbCb2n vmcc6ihlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBELjxh+J+29GBw/LWTOcJy1iX7L4 c3auh51LVVfZ2c+Y2rpvanuzcjw7QL+//2qvt91j50foPN033+LatCw9ouTc0xSz9Ypn+ukQcA
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

As it says on the tin, provide Kconfig option to control parsing the
"riscv,isa" devicetree property. If either option is used, the kernel
will fall back to parsing "riscv,isa", where "riscv,isa-base" and
"riscv,isa-extensions" are not present.
The Kconfig options are set up so that the default kernel configuration
will enable the fallback path, without needing the commandline option.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
- Invert the Kconfig entry. It's now default y & not hidden by
  NONPORTABLE, but its entablement will now activate the fallback
- Add a commandline option to enable the fallback on kernels that do not
  enable it in Kconfig, as Drew suggested
- Default the global var to the Kconfig option & override it with the
  commandline one, rather than have checks for IS_ENABLED() and for the
  commandline option in riscv_fill_hwcap() &
  riscv_early_of_processor_hartid()
---
 .../admin-guide/kernel-parameters.txt          |  7 +++++++
 arch/riscv/Kconfig                             | 18 ++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                 |  1 +
 arch/riscv/kernel/cpu.c                        |  6 ++++++
 arch/riscv/kernel/cpufeature.c                 | 14 +++++++++++++-
 5 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d910fba25f2c..1bd435f60055 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5437,6 +5437,13 @@
 			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
 			CPUs.
 
+	riscv_isa_fallback [RISCV]
+			When CONFIG_RISCV_ISA_FALLBACK is not enabled, permit
+			falling back to detecting extension support by parsing
+			"riscv,isa" property on devicetree systems when the
+			replacement properties are not found. See the Kconfig
+			entry for RISCV_ISA_FALLBACK.
+
 	ro		[KNL] Mount root device read-only on boot
 
 	rodata=		[KNL]
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1d39efe2b940..a9a473b67182 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -841,6 +841,24 @@ config XIP_PHYS_ADDR
 	  be linked for and stored to.  This address is dependent on your
 	  own flash usage.
 
+config RISCV_ISA_FALLBACK
+	bool "Permit falling back to parsing riscv,isa for extension support by default"
+	default y
+	help
+	  Parsing the "riscv,isa" devicetree property has been deprecated and
+	  replaced by a list of explicitly defined strings. For compatibility
+	  with existing platforms, the kernel will fall back to parsing the
+	  "riscv,isa" property if the replacements are not found.
+
+	  Selecting N here will result in a kernel that does not use the
+	  fallback, unless the commandline "riscv_isa_fallback" parameter is
+	  present.
+
+	  Please see the dt-binding, located at
+	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
+	  on the replacement properties of "riscv,isa-base" and
+	  "riscv,isa-extensions".
+
 endmenu # "Boot options"
 
 config BUILTIN_DTB
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e3cda14a486b..b7b58258f6c7 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@ struct riscv_isa_ext_data {
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
 extern const size_t riscv_isa_ext_count;
+extern bool riscv_isa_fallback;
 
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 28d5af21f544..1acf3679600d 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -87,6 +87,12 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
 	return 0;
 
 old_interface:
+	if (!riscv_isa_fallback) {
+		pr_warn("CPU with hartid=%lu is invalid: this kernel does not parse \"riscv,isa\"",
+			*hart);
+		return -ENODEV;
+	}
+
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
 		pr_warn("CPU with hartid=%lu has no \"riscv,isa-base\" or \"riscv,isa\" property\n",
 			*hart);
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2c4503fa984f..5945dfc5f806 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -471,6 +471,18 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 	return 0;
 }
 
+#ifdef CONFIG_RISCV_ISA_FALLBACK
+bool __initdata riscv_isa_fallback = true;
+#else
+bool __initdata riscv_isa_fallback;
+static int __init riscv_isa_fallback_setup(char *__unused)
+{
+	riscv_isa_fallback = true;
+	return 1;
+}
+early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
+#endif
+
 void __init riscv_fill_hwcap(void)
 {
 	char print_str[NUM_ALPHA_EXTS + 1];
@@ -490,7 +502,7 @@ void __init riscv_fill_hwcap(void)
 	} else {
 		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
 
-		if (ret) {
+		if (ret && riscv_isa_fallback) {
 			pr_info("Falling back to deprecated \"riscv,isa\"\n");
 			riscv_fill_hwcap_from_isa_string(isa2hwcap);
 		}
-- 
2.40.1

