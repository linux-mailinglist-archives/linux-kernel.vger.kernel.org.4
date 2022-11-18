Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8962F2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbiKRKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbiKRKor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:44:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0221425C58
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:44:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 940A2B822FF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B96C433D6;
        Fri, 18 Nov 2022 10:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668768284;
        bh=t5nmuhVmPEECjMyF20fPQ/HD3rLK842K2g6ySIOFp9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmMSKttGMZ3AG9ET4Jzmho3+5+Vd45Hc+eDHFJZLb8pz6PJUbKHtiwGo9TSQzCPSJ
         2T+jej+c3ShC9rBnI2R/p7myQvrMxTnjGsKrcNxk75RVM833DjMTKyEugeqxe6x6Tg
         oFYgGCLNqRKJhKqBqJ3r+UkhJrnvRVQwjtwIKOiiGm3514UFRylbM6vTwwZ0CoYiLg
         tqzSZexildsZfn03p0P6U5XGtVCnkKvzfMfg0ElKfJZvuwIzhB43Vrd713V5Ustmdj
         yP6lXdwTI6mFT96q6xvDGlKD2Eukh4Ct/Ae90MgBbbmgvuE81t7FjeUM6Xm2+f5yJX
         ea8l/4SqF4ebw==
From:   Conor Dooley <conor@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] irqchip/sifive-plic: remove user selectability of SIFIVE_PLIC
Date:   Fri, 18 Nov 2022 10:42:59 +0000
Message-Id: <20221118104300.85016-2-conor@kernel.org>
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

The SiFive PLIC driver is used by all current implementations, including
those that do not have a SiFive PLIC. The current driver supports more
than just SiFive PLICs at present and, where possible, future PLIC
implementations will also use this driver. As every supported RISC-V SoC
selects the driver directly in Kconfig.socs there's no point in exposing
this kconfig option to users.

The Kconfig help text, in its current form, is misleading. There's no
point doing anything about that though, as it will no longer be user
selectable. Remove it.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/irqchip/Kconfig | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..ecb3e3119d2e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -551,18 +551,10 @@ config RISCV_INTC
 	   If you don't know what to do here, say Y.
 
 config SIFIVE_PLIC
-	bool "SiFive Platform-Level Interrupt Controller"
+	bool
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
-	help
-	   This enables support for the PLIC chip found in SiFive (and
-	   potentially other) RISC-V systems.  The PLIC controls devices
-	   interrupts and connects them to each core's local interrupt
-	   controller.  Aside from timer and software interrupts, all other
-	   interrupt sources are subordinate to the PLIC.
-
-	   If you don't know what to do here, say Y.
 
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
-- 
2.37.2

