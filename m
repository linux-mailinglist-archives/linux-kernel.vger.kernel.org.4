Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A3742234
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjF2IbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjF2IaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:30:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88169131;
        Thu, 29 Jun 2023 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688027410; x=1719563410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bIs6kqMED+8WeRtoxXsVzTKb8hUL0V34cciMGbaTy6Y=;
  b=BG0tf0G+aFVFpt0jAusByz4CPoEmvRuBHnycalTGo6+mDEjd4elNtLEp
   XtI30XWaFQiqxjF+4CK1ipLtImr9J1z/ctQTGZH4w2Dldqf0K/2YSk3JT
   KAW1LlOw1TsWaxFd30hycojN8L6hOBbn2UuDk4EU0ofgegLj7Ovg1ehWd
   ykPoEkPqiJ1mFtKdCf2eSmMirVJpq0GlzSE1cpH/lzKQkyi+PEz6180iv
   lQASahrXbstbTE6k9LPaY3PcdbRHd5W/oV04pjnv+Y3Ozp6QpIS8rl3jH
   myhLrRAQeoRsWd90cGxneTS7UnxF2OAcgQ/Nz2UwuNeAvkmijM79eBfqX
   A==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="159104686"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 01:30:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 01:29:58 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 01:29:56 -0700
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/10] RISC-V: repurpose riscv_isa_ext array in riscv_fill_hwcap()
Date:   Thu, 29 Jun 2023 09:28:50 +0100
Message-ID: <20230629-lair-thinner-349e8d9f0e89@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=bIs6kqMED+8WeRtoxXsVzTKb8hUL0V34cciMGbaTy6Y=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClzHQ7V1O9/urQ6ewEnQ+vNl5feWW7avabv1Zbm7nUrz4fd jeBd0VHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJ3A9kZJhS9dCBN0zb5VdwyCfH77 O+7X3afe3gqqe7P9/f8aPHw3wOwz+r3WknI/w4BRTTYuWu+DIdN97y1mrG3wR2xolaN424M3kA
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

In riscv_fill_hwcap() riscv_isa_ext array can be looped over, rather
than duplicating the list of extensions with individual
SET_ISA_EXT_MAP() usage. While at it, drop the statement-of-the-obvious
comments from the struct, rename uprop to something more suitable for
its new use & constify the members.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Delete the now unused definition
---
 arch/riscv/include/asm/hwcap.h |  7 ++-----
 arch/riscv/kernel/cpu.c        |  5 +++--
 arch/riscv/kernel/cpufeature.c | 26 +++++++-------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 7a57e6109aef..2460ac2fc7ed 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -55,7 +55,6 @@
 #define RISCV_ISA_EXT_ZIHPM		42
 
 #define RISCV_ISA_EXT_MAX		64
-#define RISCV_ISA_EXT_NAME_LEN_MAX	32
 
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
@@ -70,10 +69,8 @@
 unsigned long riscv_get_elf_hwcap(void);
 
 struct riscv_isa_ext_data {
-	/* Name of the extension displayed to userspace via /proc/cpuinfo */
-	char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
-	/* The logical ISA extension ID */
-	unsigned int isa_ext_id;
+	const unsigned int id;
+	const char *name;
 };
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 269a32ceb595..c89abf8ef6de 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -164,9 +164,10 @@ static void print_isa_ext(struct seq_file *f)
 {
 	for (int i = 0; i < riscv_isa_ext_count; i++) {
 		const struct riscv_isa_ext_data *edata = &riscv_isa_ext[i];
-		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
+		if (!__riscv_isa_extension_available(NULL, edata->id))
 			continue;
-		seq_printf(f, "_%s", edata->uprop);
+
+		seq_printf(f, "_%s", edata->name);
 	}
 }
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index fb476153fffc..6d8cd45af723 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -99,11 +99,10 @@ static bool riscv_isa_extension_check(int id)
 	return true;
 }
 
-#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
-	{							\
-		.uprop = #UPROP,				\
-		.isa_ext_id = EXTID,				\
-	}
+#define __RISCV_ISA_EXT_DATA(_name, _id) {	\
+	.name = #_name,				\
+	.id = _id,				\
+}
 
 /*
  * The canonical order of ISA extension names in the ISA string is defined in
@@ -366,20 +365,9 @@ void __init riscv_fill_hwcap(void)
 					set_bit(nr, isainfo->isa);
 				}
 			} else {
-				/* sorted alphabetically */
-				SET_ISA_EXT_MAP("smaia", RISCV_ISA_EXT_SMAIA);
-				SET_ISA_EXT_MAP("ssaia", RISCV_ISA_EXT_SSAIA);
-				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
-				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
-				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
-				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);
-				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
-				SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
-				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
-				SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
-				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
-				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
-				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
+				for (int i = 0; i < riscv_isa_ext_count; i++)
+					SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
+							riscv_isa_ext[i].id);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.40.1

