Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78896ED593
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjDXTuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjDXTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA0D6EA1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:35 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pr2Bj-0006Mz-8z; Mon, 24 Apr 2023 21:49:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com
Cc:     heiko@sntech.de, kito.cheng@sifive.com, jrtc27@jrtc27.com,
        conor.dooley@microchip.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH 3/4] RISC-V: export the ISA string of the running machine in the aux vector
Date:   Mon, 24 Apr 2023 21:49:10 +0200
Message-Id: <20230424194911.264850-4-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Already defined aux-vectors regarding the machine type are AT_PLATFORM
and AT_BASE_PLATFORM. PPC already uses AT_BASE_PLATFORM to identify the
real platform the system is running on, so do a similar thing on RISC-V
and export the ISA string of the running machine via this aux-vector
element.

This way userspace can possibly adapt to extensions that allow it to
run certain loads more performantly.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/elf.h | 10 ++++++++++
 arch/riscv/kernel/cpu.c      | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 30e7d2455960..820ef627e83d 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -78,6 +78,16 @@ extern unsigned long elf_hwcap;
 
 #define COMPAT_ELF_PLATFORM	(NULL)
 
+/*
+ * ELF_PLATFORM indicates the ISA supported by the platform, but has
+ * special meaning to ld.so .
+ * Expose the ISA string including all usable extensions via
+ * ELF_BASE_PLATFORM instead and allow userspace to adapt to them
+ * if needed.
+ */
+#define ELF_BASE_PLATFORM (riscv_base_platform)
+extern const char *riscv_base_platform;
+
 #ifdef CONFIG_MMU
 #define ARCH_DLINFO						\
 do {								\
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 06c2f587a176..71770563199f 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -118,8 +118,12 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
 	return 0;
 }
 
+const char *riscv_base_platform = NULL;
+static char *riscv_create_isa_string(void);
+
 static int __init riscv_cpuinfo_init(void)
 {
+	char *isa_str;
 	int ret;
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/cpuinfo:starting",
@@ -129,6 +133,14 @@ static int __init riscv_cpuinfo_init(void)
 		return ret;
 	}
 
+	/*
+	 * Create the isa-string with the common set of extensions over
+	 * all harts, to expose as AT_BASE_PLATFORM in the aux vector.
+	 */
+	isa_str = riscv_create_isa_string();
+	if (!IS_ERR(isa_str))
+		riscv_base_platform = isa_str;
+
 	return 0;
 }
 arch_initcall(riscv_cpuinfo_init);
-- 
2.39.0

