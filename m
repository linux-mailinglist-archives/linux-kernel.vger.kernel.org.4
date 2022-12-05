Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25E8642A9A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiLEOq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLEOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:46:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178EE1B7A6;
        Mon,  5 Dec 2022 06:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670251577; x=1701787577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mR+tA9ajFYArrwEF7cxAJbYpdeZOV3FQATUmv3J86uc=;
  b=aruAvhGt7EqTGWKdM/2zUIIl+sJFymUrbb4HWMcHNrHkVoZ+Y9+fCGr+
   R2w2T1dsGqyGO+koi9JuwUsmz2HcppbTAsUWO/4wBYQtjvb8Xmss+VyuD
   2r6af/92C4++HSh6/t+rcSDMMBS/yVzU22ax4CfezOyGK9lbrRoYwJvvm
   pmriiPjl/LtyxCFyV+wDRYjZe+Ondgi/xK32v32JdFGN1K41GhedO5W++
   BXhkZqQZ9X6hjP99E2NCTAxt1doY58+moMQr10945nslgGA02Fc0PfthT
   mepohx+HEobaS3f7R8MaluOpRKA/Hk6DH1uUS/rWyiyKZiLhWrODi2ihx
   g==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="202640935"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2022 07:46:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Dec 2022 07:46:17 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Dec 2022 07:46:15 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <conor@kernel.org>, <corbet@lwn.net>, <guoren@kernel.org>,
        <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v2 2/3] RISC-V: resort all extensions in consistent orders
Date:   Mon, 5 Dec 2022 14:45:25 +0000
Message-ID: <20221205144525.2148448-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205144525.2148448-1-conor.dooley@microchip.com>
References: <20221205144525.2148448-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ordering between each and every list of extensions is wildly
inconsistent. Per discussion on the lists pick the following policy:

- The array defining order in /proc/cpuinfo follows a narrow
  interpretation of the ISA specifications, described in a comment
  immediately presiding it.

- All other lists of extensions are sorted alphabetically.

This will hopefully allow for easier review & future additions, and
reduce conflicts between patchsets as the number of extensions grows.

Link: https://lore.kernel.org/all/20221129144742.2935581-2-conor.dooley@microchip.com/
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/hwcap.h | 12 +++++++-----
 arch/riscv/kernel/cpu.c        |  4 ++--
 arch/riscv/kernel/cpufeature.c |  6 ++++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b22525290073..ce522aad641a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -51,14 +51,15 @@ extern unsigned long elf_hwcap;
  * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
  * extensions while all the multi-letter extensions should define the next
  * available logical extension id.
+ * Entries are sorted alphabetically.
  */
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_SSTC,
+	RISCV_ISA_EXT_SVINVAL,
 	RISCV_ISA_EXT_SVPBMT,
 	RISCV_ISA_EXT_ZICBOM,
 	RISCV_ISA_EXT_ZIHINTPAUSE,
-	RISCV_ISA_EXT_SSTC,
-	RISCV_ISA_EXT_SVINVAL,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
@@ -66,11 +67,12 @@ enum riscv_isa_ext_id {
  * This enum represents the logical ID for each RISC-V ISA extension static
  * keys. We can use static key to optimize code path if some ISA extensions
  * are available.
+ * Entries are sorted alphabetically.
  */
 enum riscv_isa_ext_key {
 	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
-	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
 	RISCV_ISA_EXT_KEY_SVINVAL,
+	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
 	RISCV_ISA_EXT_KEY_MAX,
 };
 
@@ -90,10 +92,10 @@ static __always_inline int riscv_isa_ext2key(int num)
 		return RISCV_ISA_EXT_KEY_FPU;
 	case RISCV_ISA_EXT_d:
 		return RISCV_ISA_EXT_KEY_FPU;
-	case RISCV_ISA_EXT_ZIHINTPAUSE:
-		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
 	case RISCV_ISA_EXT_SVINVAL:
 		return RISCV_ISA_EXT_KEY_SVINVAL;
+	case RISCV_ISA_EXT_ZIHINTPAUSE:
+		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index db8b16ad9342..0bf1c7f663fc 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -185,12 +185,12 @@ arch_initcall(riscv_cpuinfo_init);
  * New entries to this struct should follow the ordering rules described above.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
+	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
-	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
-	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 694267d1fe81..8a76a6ce70cf 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -199,12 +199,13 @@ void __init riscv_fill_hwcap(void)
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
 				set_bit(*ext - 'a', this_isa);
 			} else {
+				/* sorted alphabetically */
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
+				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
-				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
-				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 			}
 #undef SET_ISA_EXT_MAP
 		}
@@ -284,6 +285,7 @@ static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
  * This code may also be executed before kernel relocation, so we cannot use
  * addresses generated by the address-of operator as they won't be valid in
  * this context.
+ * Tests, unless otherwise required, are to be added in alphabetical order.
  */
 static u32 __init_or_module cpufeature_probe(unsigned int stage)
 {
-- 
2.38.1

