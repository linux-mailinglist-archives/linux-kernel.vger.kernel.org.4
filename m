Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF405F6191
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJFHSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJFHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1B43307
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87DB61840
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0314EC433D7;
        Thu,  6 Oct 2022 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665040675;
        bh=8Lz5QrNESG5omW8wbab7hELS/76piojMbUm54X300LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMsgMjntB8QBpKSj/OwpDvzeZC0oQuw2e186kJD8lDrw2bUsLph94Bw2iP6w9t/p5
         vfCG2PZaKRoA3hi1nXZGVUYxLxTMnBw4TdL3s/2vVe9XOHeXMlagj5MJ8sjjgoYqiT
         u/iSC7qUW9ePnYTIiMCEaKpAysyiX1jeDj0uKzmKmBpuSRvsGsCzoIYZ+MiURkaOGp
         TYlY35eLWx3AdaihEDRt1vP1YAMBQ1fsltXWyG4oBQYo3r5hlic2fVKaeL+Ntz4wfz
         cQdh/g8iB3S9PJIYWmmDb7SA1z5dfNCTTah5z6N61moxkEiiMTLEHhnCxoTFqhATCO
         JlGn9ksW+3jlQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] riscv: hwcap: make ISA extension ids can be used in asm
Date:   Thu,  6 Oct 2022 15:08:13 +0800
Message-Id: <20221006070818.3616-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006070818.3616-1-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will make use of ISA extension in asm files, so make the multi-letter
RISC-V ISA extension IDs macros rather than enums and move them and
those base ISA extension IDs to suitable place.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/hwcap.h | 45 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 6f59ec64175e..6cf445653911 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -12,20 +12,6 @@
 #include <linux/bits.h>
 #include <uapi/asm/hwcap.h>
 
-#ifndef __ASSEMBLY__
-#include <linux/jump_label.h>
-/*
- * This yields a mask that user programs can use to figure out what
- * instruction set this cpu supports.
- */
-#define ELF_HWCAP		(elf_hwcap)
-
-enum {
-	CAP_HWCAP = 1,
-};
-
-extern unsigned long elf_hwcap;
-
 #define RISCV_ISA_EXT_a		('a' - 'a')
 #define RISCV_ISA_EXT_c		('c' - 'a')
 #define RISCV_ISA_EXT_d		('d' - 'a')
@@ -46,21 +32,36 @@ extern unsigned long elf_hwcap;
 #define RISCV_ISA_EXT_BASE 26
 
 /*
- * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
+ * These macros represent the logical ID for each multi-letter RISC-V ISA extension.
  * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
  * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
  * extensions while all the multi-letter extensions should define the next
  * available logical extension id.
  */
-enum riscv_isa_ext_id {
-	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
-	RISCV_ISA_EXT_SVPBMT,
-	RISCV_ISA_EXT_ZICBOM,
-	RISCV_ISA_EXT_ZIHINTPAUSE,
-	RISCV_ISA_EXT_SSTC,
-	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
+#define RISCV_ISA_EXT_SSCOFPMF 		26
+#define RISCV_ISA_EXT_SVPBMT		27
+#define RISCV_ISA_EXT_ZICBOM		28
+#define RISCV_ISA_EXT_ZIHINTPAUSE	29
+#define RISCV_ISA_EXT_SSTC		30
+
+#define RISCV_ISA_EXT_ID_MAX		RISCV_ISA_EXT_MAX
+
+
+#ifndef __ASSEMBLY__
+#include <linux/jump_label.h>
+/*
+ * This yields a mask that user programs can use to figure out what
+ * instruction set this cpu supports.
+ */
+#define ELF_HWCAP		(elf_hwcap)
+
+enum {
+	CAP_HWCAP = 1,
 };
 
+extern unsigned long elf_hwcap;
+
+
 /*
  * This enum represents the logical ID for each RISC-V ISA extension static
  * keys. We can use static key to optimize code path if some ISA extensions
-- 
2.37.2

