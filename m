Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A3574D1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjGJJkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjGJJjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:39:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8649359D;
        Mon, 10 Jul 2023 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688981819; x=1720517819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5gfCaYU0chLq5c3B/D2KhUCxcGWsZsApGGytqjShGTw=;
  b=gMjrZErUTiBgXaj+dPf8Xl4I8gbCxlxkvgSYdH2NvoArCz1D98neZW69
   bAh8fkNXPl8FnxY01kfwvtw48WBaH8gEibG7ZZD8vru8NFBTG+UT87Pvj
   +sCAzO45urGwMcuLfM4mhE6nVx91zQVek8dJSmD7nd0H/NID+eqPX2KdL
   FF8QljXWvFSrDrKhZC5nZ4DlYoW+lmjbZXPEIUdgSgMJ6SfxocCrnJBf/
   cmkPAs3sKj1GC6rSFsNvEirJ+9aS+Zwnlu4fhDz9oNRfyR9w/ktsPDE0w
   x+HmtTCLVOboWSmj4FYlODt5gONp4SQscmwnftH+eUtpiLSCXe0jHUyzk
   A==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="160600093"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2023 02:36:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 10 Jul 2023 02:36:42 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 10 Jul 2023 02:36:39 -0700
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
Subject: [PATCH v4 05/11] RISC-V: repurpose riscv_isa_ext array in riscv_fill_hwcap()
Date:   Mon, 10 Jul 2023 10:35:40 +0100
Message-ID: <20230710-banker-visible-4c4cb3685dc1@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710-equipment-stained-dd042d66ba5d@wendy>
References: <20230710-equipment-stained-dd042d66ba5d@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3700; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5gfCaYU0chLq5c3B/D2KhUCxcGWsZsApGGytqjShGTw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmrL1xPKCp13DJjVogsRwlTZfMlzXpt12j+2T8ZbJl2Cdet OyPWUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIlcqWJk+FL9M1HkwgNBzrJw3wIr8y 0/2/tyOLWzN8vMf1O87FXPbIa/4ptXtRwIX+jS0cmzzDbz75bd9eyrdv9cUaXiHrwm4+85PgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
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
index bf93293d51f3..aa17eeb0ec9a 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -168,9 +168,10 @@ static void print_isa_ext(struct seq_file *f)
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

