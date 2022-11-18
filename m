Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5631A62F2DC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbiKRKpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbiKRKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:44:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DECB657FD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:44:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C6BBB822D8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F21CC433D6;
        Fri, 18 Nov 2022 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668768289;
        bh=W+cw8CbjTjtzmisgW+jbJ65nAVSygcxv7sm+idsmMMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOqPxHYYu82pZ61iRaesC23GHsmkrHKWF0U0tAiP5Q90stFsYyQTrFeHQXfyaJWnz
         wodTGfqNpoaEPRlw9XApvvq2V6B8Bhl0qgnbMHE63xwzb2dMErUejwegZeX8ns8KCa
         ZoexQJIwi7q8zN8t0S8Qe9o06OQOGVlzPQsMvPQxD7HxYHuXDjELUV2Qdf2pkhJJwO
         YfhzkckHJPo+PjmTKnSyPsNnbJe6HTIcM6GuKcI0uya724NC9iV7BJyTE/U7oRWBPc
         6qjAsYXxlCv724Mm+ekddLTrdn9FwuA7Vc0kIAPsdiDoJDSRZOrR9kA2xQuWEHRqnc
         X9x81Vyv+9Hjg==
From:   Conor Dooley <conor@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/3] RISC-V: stop selecting SIFIVE_PLIC at the SoC level
Date:   Fri, 18 Nov 2022 10:43:01 +0000
Message-Id: <20221118104300.85016-4-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118104300.85016-1-conor@kernel.org>
References: <20221118104300.85016-1-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

The SIFIVE_PLIC driver is used by all current RISC-V SoCs & will be,
where possible, used for future implementations. Rather than having each
driver select the option on a case-by-case basis, do so at the arch
level.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig      | 1 +
 arch/riscv/Kconfig.socs | 5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa78595a6089..846f61254dfc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -123,6 +123,7 @@ config RISCV
 	select PCI_MSI if PCI
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
+	select SIFIVE_PLIC
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..15e391f38f75 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -3,7 +3,6 @@ menu "SoC selection"
 config SOC_MICROCHIP_POLARFIRE
 	bool "Microchip PolarFire SoCs"
 	select MCHP_CLK_MPFS
-	select SIFIVE_PLIC
 	help
 	  This enables support for Microchip PolarFire SoC platforms.
 
@@ -13,7 +12,6 @@ config SOC_SIFIVE
 	select SERIAL_SIFIVE_CONSOLE if TTY
 	select CLK_SIFIVE
 	select CLK_SIFIVE_PRCI
-	select SIFIVE_PLIC
 	select ERRATA_SIFIVE if !XIP_KERNEL
 	help
 	  This enables support for SiFive SoC platform hardware.
@@ -22,7 +20,6 @@ config SOC_STARFIVE
 	bool "StarFive SoCs"
 	select PINCTRL
 	select RESET_CONTROLLER
-	select SIFIVE_PLIC
 	help
 	  This enables support for StarFive SoC platform hardware.
 
@@ -34,7 +31,6 @@ config SOC_VIRT
 	select POWER_RESET_SYSCON_POWEROFF
 	select GOLDFISH
 	select RTC_DRV_GOLDFISH if RTC_CLASS
-	select SIFIVE_PLIC
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
 	select RISCV_SBI_CPUIDLE if CPU_IDLE && RISCV_SBI
@@ -47,7 +43,6 @@ config SOC_CANAAN
 	select CLINT_TIMER if RISCV_M_MODE
 	select SERIAL_SIFIVE if TTY
 	select SERIAL_SIFIVE_CONSOLE if TTY
-	select SIFIVE_PLIC
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
 	select COMMON_CLK
-- 
2.37.2

