Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA25F4772
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJDQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJDQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:22:40 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3E647F4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:22:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:e15b:43db:96f7:952f])
        by michel.telenet-ops.be with bizsmtp
        id TsNY2800D2GKRF306sNYtA; Tue, 04 Oct 2022 18:22:35 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ofkgi-000hG5-7o; Tue, 04 Oct 2022 18:22:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ofkgh-007ycG-Q4; Tue, 04 Oct 2022 18:22:31 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: IMX_MU_MSI should depend on ARCH_MXC
Date:   Tue,  4 Oct 2022 18:22:30 +0200
Message-Id: <7f3bd932614ddbff46a1b750ef45b231130364ad.1664900434.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale/NXP i.MX Messaging Unit is only present on Freescale/NXP
i.MX SoCs.  Hence add a dependency on ARCH_MXC, to prevent asking the
user about this driver when configuring a kernel without Freescale/NXP
i.MX SoC family support.

While at it, expand "MU" to "Messaging Unit" in the help text.

Fixes: 70afdab904d2d1e6 ("irqchip: Add IMX MU MSI controller driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a0c30c86087d0e97..2ec500e12ab62cd8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -484,14 +484,15 @@ config IMX_INTMUX
 config IMX_MU_MSI
 	tristate "i.MX MU used as MSI controller"
 	depends on OF && HAS_IOMEM
+	depends on ARCH_MXC || COMPILE_TEST
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
-	  Provide a driver for the MU block used as a CPU-to-CPU MSI
-	  controller. This requires a specially crafted DT to make use
-	  of this driver.
+	  Provide a driver for the i.MX Messaging Unit block used as a
+	  CPU-to-CPU MSI controller. This requires a specially crafted DT
+	  to make use of this driver.
 
 	  If unsure, say N
 
-- 
2.25.1

