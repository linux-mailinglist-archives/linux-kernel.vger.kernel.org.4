Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69DF6C7C36
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCXKGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCXKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:06:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D522A37
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679652396; x=1711188396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HIMWJexj4WLJBJERrpVARQc+HGNG7OWGHifKIwHmW0=;
  b=jFlxZM4y5l1aOoQeEpyM8CLrWIIoXrKhwc2bopusry6DQo/mcSHlGgAl
   kPQlUQlPjZsZlFNujbuRWtnieAwT2KssPjiPzpi14OaZnTywDJNznP5kD
   5PRMsMk5/mnUU+O4JGXAIR7FY/BUZDCjrauNkSEQNl9dOR9qS+aGc+86C
   tCC01bJEkth7M2FhWuXBcS+VZskKLW7UsoJTC5ZO9GK+TH/WIXSIE5Ix2
   dUkm29zl+bG+k4JykHXry0SOCjylrSkKq1pEgOB1/DJ8HAD8fQictloDb
   CA1HKAnODIyRinpsXi/UzbwwC1IjkX/xiDkLXjvSiVpP7uOkShpTUouGR
   g==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673938800"; 
   d="scan'208";a="206553556"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2023 03:06:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 03:06:32 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 24 Mar 2023 03:06:30 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] RISC-V: add non-alternative fallback for riscv_has_extension_[un]likely()
Date:   Fri, 24 Mar 2023 10:05:38 +0000
Message-ID: <20230324100538.3514663-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324100538.3514663-1-conor.dooley@microchip.com>
References: <20230324100538.3514663-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128; i=conor.dooley@microchip.com; h=from:subject; bh=5HIMWJexj4WLJBJERrpVARQc+HGNG7OWGHifKIwHmW0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmypS82zLn4u6GUZffmTWHbL3WdueFeeU7x5cYpAUYctxmO BHcmdpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAi75gY/off0GP2LgwUc7wToJDjOM vj6tMIBzFR3Y0zw6cmhBcfLWNk+JtnpMVjlST+Z8vUu/GNcctczkpstOyZxz3vRbW0XLcYPwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The has_fpu() check, which in turn calls riscv_has_extension_likely(),
relies on alternatives to figure out whether the system has an FPU.
As a result, it will malfunction on XIP kernels, as they do not support
the alternatives mechanism.

When alternatives support is not present, fall back to using
__riscv_isa_extension_available() in riscv_has_extension_[un]likely()
instead stead, which handily takes the same argument, so that kernels
that do not support alternatives can accurately report the presence of
FPU support.

Fixes: 702e64550b12 ("riscv: fpu: switch has_fpu() to riscv_has_extension_likely()")
Link: https://lore.kernel.org/all/ad445951-3d13-4644-94d9-e0989cda39c3@spud/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/hwcap.h | 50 ++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e3021b2590de..6263a0de1c6a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -57,18 +57,31 @@ struct riscv_isa_ext_data {
 	unsigned int isa_ext_id;
 };
 
+unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
+
+#define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
+
+bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit);
+#define riscv_isa_extension_available(isa_bitmap, ext)	\
+	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
+
 static __always_inline bool
 riscv_has_extension_likely(const unsigned long ext)
 {
 	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
 			   "ext must be < RISCV_ISA_EXT_MAX");
 
-	asm_volatile_goto(
-	ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
-	:
-	: [ext] "i" (ext)
-	:
-	: l_no);
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		asm_volatile_goto(
+		ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
+		:
+		: [ext] "i" (ext)
+		:
+		: l_no);
+	} else {
+		if (!__riscv_isa_extension_available(NULL, ext))
+			goto l_no;
+	}
 
 	return true;
 l_no:
@@ -81,26 +94,23 @@ riscv_has_extension_unlikely(const unsigned long ext)
 	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
 			   "ext must be < RISCV_ISA_EXT_MAX");
 
-	asm_volatile_goto(
-	ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
-	:
-	: [ext] "i" (ext)
-	:
-	: l_yes);
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		asm_volatile_goto(
+		ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
+		:
+		: [ext] "i" (ext)
+		:
+		: l_yes);
+	} else {
+		if (__riscv_isa_extension_available(NULL, ext))
+			goto l_yes;
+	}
 
 	return false;
 l_yes:
 	return true;
 }
 
-unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
-
-#define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
-
-bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit);
-#define riscv_isa_extension_available(isa_bitmap, ext)	\
-	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
-
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
-- 
2.39.2

