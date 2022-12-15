Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EB064DED2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLOQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLOQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:41:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FBDF12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:41:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA8B4B81BA1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FA5C433F1;
        Thu, 15 Dec 2022 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122475;
        bh=B56jZ4GwXNxhvlUoyX2XvXatc24AC7epFPyOb5O+MA0=;
        h=From:To:Cc:Subject:Date:From;
        b=BzFfFEieMR+SMt6S/dei6SFTQVj8/YXpa6OIj53vpHCw38xgKhrP78DVIJYNHyDoX
         AHOZkO3zIQKppPi1AOIG5YIDfaXIphT4RisfC314Rklmtqnd7NJEIqjFm7nzp5PVV7
         dGqmKpeP0N2oQT88VvhzC6LbdU4sd6JDbADMum8/ntm6apFawFX27zX9dusuoqimq+
         Ui0oEHFPFoj1qkWHMxfTLmT+JJZoTk6u78tjJW0J8HIYGyp2nUcy/L/tDfqt03QJQh
         3HEuJBOqXmlyBfcoJktdRb8BJECMRw/fxc5w5KgPAjh3m6JCJpttCI0NldPL3TfmE3
         MK0436U3Xd3fw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.Li@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: build IMX_MU_MSI only on ARM
Date:   Thu, 15 Dec 2022 17:40:41 +0100
Message-Id: <20221215164109.761427-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

From: Arnd Bergmann <arnd@arndb.de>

compile-testing IMX_MU_MSI on x86 without PCI_MSI support results
in a build failure:

arch/x86/kernel/hpet.c:520:46: error: 'msi_alloc_info_t' {aka 'struct irq_alloc_info'} has no member named 'hwirq'
  520 |         irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
      |                                              ^~
arch/x86/kernel/hpet.c:521:49: error: 'msi_alloc_info_t' {aka 'struct irq_alloc_info'} has no member named 'data'
  521 |                             handle_edge_irq, arg->data, "edge");
      |                                                 ^~
arch/x86/kernel/hpet.c: In function 'hpet_create_irq_domain':
arch/x86/kernel/hpet.c:550:13: error: 'x86_vector_domain' undeclared (first use in this function)
  550 |         if (x86_vector_domain == NULL)
      |             ^~~~~~~~~~~~~~~~~
arch/x86/kernel/hpet.c:550:13: note: each undeclared identifier is reported only once for each function it appears in
arch/x86/kernel/hpet.c: In function 'hpet_assign_irq':
arch/x86/kernel/hpet.c:600:9: error: implicit declaration of function 'init_irq_alloc_info' [-Werror=implicit-function-declaration]
  600 |         init_irq_alloc_info(&info, NULL);

Tighten the dependency further to only allow compile testing on Arm.
This could be refined further to allow certain x86 configs.

Fixes: 6c9f7434159b ("irqchip: IMX_MU_MSI should depend on ARCH_MXC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index caa952c40ff9..4ebf4d566e6f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -484,7 +484,7 @@ config IMX_INTMUX
 config IMX_MU_MSI
 	tristate "i.MX MU used as MSI controller"
 	depends on OF && HAS_IOMEM
-	depends on ARCH_MXC || COMPILE_TEST
+	depends on ARCH_MXC || ((ARM || ARM64) && COMPILE_TEST)
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-- 
2.35.1

