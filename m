Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA31F5FBE60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJKXUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJKXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:19:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B7A8CCC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 16:19:12 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oiOWK-0003i7-GH; Wed, 12 Oct 2022 01:18:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor.Dooley@microchip.com, samuel@sholland.org,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 1/2] RISC-V: Cache SBI vendor values
Date:   Wed, 12 Oct 2022 01:18:40 +0200
Message-Id: <20221011231841.2951264-2-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011231841.2951264-1-heiko@sntech.de>
References: <20221011231841.2951264-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbi_get_mvendorid(), sbi_get_marchid() and sbi_get_mimpid() might get
called multiple times, though the values of these CSRs should not change
during the runtime of a specific machine.

Though the values can be different depending on which hart of the system
they get called. So hook into the newly introduced cpuinfo struct to allow
retrieving these cached values via new functions.

Also use arch_initcall for the cpuinfo setup instead, as that now clearly
is "architecture specific initialization" and also makes these information
available slightly earlier.

[caching vendor ids]
Suggested-by: Atish Patra <atishp@atishpatra.org>
[using cpuinfo struct as cache]
Suggested-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/sbi.h |  5 +++++
 arch/riscv/kernel/cpu.c      | 30 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 2a0ef738695e..4ca7fbacff42 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -327,4 +327,9 @@ int sbi_err_map_linux_errno(int err);
 static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
 static inline void sbi_init(void) {}
 #endif /* CONFIG_RISCV_SBI */
+
+unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
+unsigned long riscv_cached_marchid(unsigned int cpu_id);
+unsigned long riscv_cached_mimpid(unsigned int cpu_id);
+
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 250220e2cceb..2c40763e1cc8 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -70,8 +70,6 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
-#ifdef CONFIG_PROC_FS
-
 struct riscv_cpuinfo {
 	unsigned long mvendorid;
 	unsigned long marchid;
@@ -79,6 +77,30 @@ struct riscv_cpuinfo {
 };
 static DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
+unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
+{
+	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
+
+	return ci->mvendorid;
+}
+EXPORT_SYMBOL(riscv_cached_mvendorid);
+
+unsigned long riscv_cached_marchid(unsigned int cpu_id)
+{
+	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
+
+	return ci->marchid;
+}
+EXPORT_SYMBOL(riscv_cached_marchid);
+
+unsigned long riscv_cached_mimpid(unsigned int cpu_id)
+{
+	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
+
+	return ci->mimpid;
+}
+EXPORT_SYMBOL(riscv_cached_mimpid);
+
 static int riscv_cpuinfo_starting(unsigned int cpu)
 {
 	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
@@ -113,7 +135,9 @@ static int __init riscv_cpuinfo_init(void)
 
 	return 0;
 }
-device_initcall(riscv_cpuinfo_init);
+arch_initcall(riscv_cpuinfo_init);
+
+#ifdef CONFIG_PROC_FS
 
 #define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
 	{							\
-- 
2.35.1

